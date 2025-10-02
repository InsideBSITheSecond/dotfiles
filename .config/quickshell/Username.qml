import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Text {
  id: uptimeText
  property string loginName: Quickshell.env("USER")

  /* --------------------------------------------------------------------
   * Format the raw uptime (seconds) into hh:mm:ss.
   * --------------------------------------------------------------------*/
  function _formatUptime(seconds) {
    const h = Math.floor(seconds / 3600)
    const m = Math.floor((seconds % 3600) / 60)
    const s = Math.floor(seconds % 60)

    return `${h.toString().padStart(2, "0")}:` +
           `${m.toString().padStart(2, "0")}:` +
           `${s.toString().padStart(2, "0")}`
  }

  /* --------------------------------------------------------------------
   * The FileView component below watches /proc/uptime.  When the file
   * is loaded or changes we read its `text` property (the file’s
   * contents) and format it.
   * --------------------------------------------------------------------*/
  FileView {
    id: uptimeFile
    path: "/proc/uptime"
    watchChanges: true

    onLoaded: () => {          // no argument – use uptimeFile.text
      const raw = String(uptimeFile.text()).trim()
      const secs = parseFloat(raw.split(" ")[0])
      if (isNaN(secs)) {
        uptimeText.text = `${loginName} (??:??:??)`
      } else {
        uptimeText.text = `${loginName} (${_formatUptime(secs)})`
      }
    }

    onLoadFailed: (error) => {
      console.warn("[Username] cannot read /proc/uptime:", error)
      uptimeText.text = `${loginName} (??:??:??)`
    }
  }

  /* Initial placeholder – will be overwritten once FileView loads */
  text: loginName + " (00:00:00)"
  
  Timer {
    interval: 1000       // update every second
    running: true
    repeat: true
    onTriggered: uptimeFile.reload()
  }
}
