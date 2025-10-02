import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Item {
  id: root
  property real step: 0.02
  property real maxVolume: 1.25
  width: volText.implicitWidth + 8
  height: volText.implicitHeight

  PwObjectTracker { id: tracker; objects: [ Pipewire.defaultAudioSink ] }

  readonly property bool ready: Pipewire.ready
                                 && Pipewire.defaultAudioSink
                                 && Pipewire.defaultAudioSink.ready
  readonly property var  node:  Pipewire.defaultAudioSink
  readonly property var  audio: ready && node.audio ? node.audio : null
  readonly property real vol:   audio ? audio.volume : 0
  readonly property bool muted: audio ? audio.muted  : false

  function setVolume(v) {
    if (!audio) return
    audio.volume = Math.max(0, Math.min(maxVolume, v))
  }
  function nudgeVolume(by) { setVolume(vol + by) }
  function toggleMute() { if (audio) audio.muted = !muted }

  Text {
    id: volText
    anchors.centerIn: parent
    font.family: "monospace"
    color: "#ddd"
    text: {
      if (!ready || !audio) return "󰖁 --%"
      const p = Math.round(Math.min(100, vol * 100))
      const icon = muted ? "󰝟" : (p === 0 ? "󰕿" : p < 50 ? "󰖀" : "󰕾")
      return `${icon} ${p}%`
    }

    // Click to mute/unmute
    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor
      onClicked: toggleMute()
    }

    // Scroll to change volume (robust for mouse + touchpad)
    WheelHandler {
      id: wheel
      target: volText
      acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
      // Make sure we can take the grab even if something else hovered
      grabPermissions: PointerHandler.TakeOverForbidden | PointerHandler.CanTakeOverFromItems
      onWheel: (ev) => {
        // Prefer vertical; if 0, try horizontal (some touchpads send that)
        let ticks = 0
        if (ev.angleDelta.y !== 0)       ticks = ev.angleDelta.y / 120
        else if (ev.angleDelta.x !== 0)  ticks = ev.angleDelta.x / 120
        else if (ev.pixelDelta.y !== 0)  ticks = ev.pixelDelta.y / 40
        else if (ev.pixelDelta.x !== 0)  ticks = ev.pixelDelta.x / 40
        if (ticks !== 0) {
          nudgeVolume(ticks * step)
          ev.accepted = true
        }
      }
    }

    // Optional: right-click reset to 100%
    TapHandler {
      acceptedButtons: Qt.RightButton
      onTapped: () => setVolume(1.0)
    }
  }
}