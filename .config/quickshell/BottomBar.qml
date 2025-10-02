import QtQuick
import Quickshell
import Quickshell.Io

/*
 * BottomBar.qml — a simple resource-monitor bar for Quickshell
 *
 * What it shows (left → right):
 *   • CPU%   • Mem%   • Swap%   • Net: up/down (KB/s)   • Disk / usage   • Time
 *
 * Notes:
 *   - Adjust `iface` for your primary network interface (e.g., "wlan0", "eth0").
 *   - Uses /proc and /sys files; updates every second.
 *   - Disk usage uses `df -h /` via Process to keep it simple.
 */

PanelWindow {
  id: bar
  anchors.bottom: true
  anchors.left: true
  anchors.right: true
  implicitHeight: 28
  color: Qt.rgba(0,0,0,0.55)

  // === Settings you may change ===
  property string iface: "wlan0"   // set to your main NIC (e.g., "eth0", "enp3s0")
  property int    pollMs: 1000      // update interval

  // === UI ===
  Row {
    id: row
    anchors.fill: parent
    anchors.margins: 8
    spacing: 16

    // cpu
    Text { id: cpuTxt;   font.family: "monospace"; color: "#ddd"; text: `CPU ${cpuPct.toFixed(0)}%` }
    // mem
    Text { id: memTxt;   font.family: "monospace"; color: "#ddd"; text: `Mem ${memPct.toFixed(0)}%` }
    // swap
    Text { id: swapTxt;  font.family: "monospace"; color: "#ddd"; text: swapTotal>0 ? `Swap ${swapPct.toFixed(0)}%` : "Swap —" }
    // net
    Text { id: netTxt;   font.family: "monospace"; color: "#ddd"; text: `Net ${fmtRate(txRate)}↑ ${fmtRate(rxRate)}↓` }
    // disk
    Text { id: diskTxt;  font.family: "monospace"; color: "#ddd"; text: diskUsage.length ? `Disk ${diskUsage}` : "Disk …" }
    // clock (simple)
    //Text { id: clockTxt; font.family: "monospace"; color: "#ddd"; text: Qt.formatDateTime(new Date(), "HH:mm:ss") }
  }

  // === Data state ===
  // CPU
  property real cpuPct: 0
  property double _lastTotal: 0
  property double _lastIdle: 0

  // Mem
  property real memPct: 0
  property real swapPct: 0
  property int  swapTotal: 0

  // Net
  property double rxRate: 0 // bytes/s
  property double txRate: 0 // bytes/s
  property double _lastRx: 0
  property double _lastTx: 0

  // Disk
  property string diskUsage: ""

  // === Helpers ===
  function fmtRate(bps) {
    // show in KiB/s or MiB/s
    if (bps < 1024) return `${bps.toFixed(0)}B/s`
    let kib = bps/1024
    if (kib < 1024) return `${kib.toFixed(0)}KiB/s`
    return `${(kib/1024).toFixed(2)}MiB/s`
  }

  function _parseCpuStat(text) {
    // first line: cpu  user nice system idle iowait irq softirq steal guest guest_nice
    const line = String(text).split("\n")[0]
    const parts = line.trim().split(/\s+/)
    // parts[0] == 'cpu'
    const nums = parts.slice(1).map(v => parseFloat(v) || 0)
    const idle = (nums[3]||0) + (nums[4]||0) // idle + iowait
    const total = nums.reduce((a,b)=>a+b,0)
    if (_lastTotal > 0) {
      const dTotal = total - _lastTotal
      const dIdle  = idle  - _lastIdle
      if (dTotal > 0) cpuPct = 100 * (1 - dIdle/dTotal)
    }
    _lastTotal = total
    _lastIdle  = idle
  }

  function _parseMeminfo(text) {
    const lines = String(text).split("\n")
    let total=0, avail=0, swTotal=0, swFree=0
    for (let ln of lines) {
      if (ln.startsWith("MemTotal:")) total = parseInt(ln.replace(/[^0-9]/g,''))
      else if (ln.startsWith("MemAvailable:")) avail = parseInt(ln.replace(/[^0-9]/g,''))
      else if (ln.startsWith("SwapTotal:")) swTotal = parseInt(ln.replace(/[^0-9]/g,''))
      else if (ln.startsWith("SwapFree:")) swFree = parseInt(ln.replace(/[^0-9]/g,''))
    }
    if (total>0) memPct = 100 * (1 - (avail/total))
    swapTotal = swTotal
    if (swTotal>0) swapPct = 100 * (1 - (swFree/swTotal))
  }

  function _updateNet(rxStr, txStr) {
    const rx = parseInt(rxStr) || 0
    const tx = parseInt(txStr) || 0
    if (_lastRx>0) rxRate = (rx - _lastRx) / (pollMs/1000)
    if (_lastTx>0) txRate = (tx - _lastTx) / (pollMs/1000)
    _lastRx = rx; _lastTx = tx
  }

  // === File readers ===
  FileView { id: cpuStat; path: "/proc/stat"; watchChanges: false;
    onLoaded: _parseCpuStat(cpuStat.text());
    onTextChanged: _parseCpuStat(cpuStat.text());
  }

  FileView { id: memInfo; path: "/proc/meminfo"; watchChanges: false;
    onLoaded: _parseMeminfo(memInfo.text());
    onTextChanged: _parseMeminfo(memInfo.text());
  }

  FileView { id: rxFile; path: `/sys/class/net/${bar.iface}/statistics/rx_bytes`; watchChanges: false }
  FileView { id: txFile; path: `/sys/class/net/${bar.iface}/statistics/tx_bytes`; watchChanges: false }

  // Disk via `df -h /`
  Process { id: dfProc; command: ["/bin/sh","-c","df -h / | awk 'NR==2{print $5 \" of \" $2}'"] }
  StdioCollector {
    id: dfCol
    //process: dfProc
    //onStdout: (buf) => diskUsage = String.fromUtf8(buf).trim()
  }

  // === Poller ===
  Timer {
    interval: pollMs
    running: true
    repeat: true
    onTriggered: {
      cpuStat.reload()
      memInfo.reload()
      rxFile.reload(); txFile.reload()
      if (rxFile.loaded && txFile.loaded) _updateNet(String(rxFile.text()), String(txFile.text()))
      //dfProc.start()
      //clockTxt.text = Qt.formatDateTime(new Date(), "HH:mm:ss")
    }
  }

  // First fill
  Component.onCompleted: {
    cpuStat.reload(); memInfo.reload(); rxFile.reload(); txFile.reload(); //dfProc.start()
  }
}
