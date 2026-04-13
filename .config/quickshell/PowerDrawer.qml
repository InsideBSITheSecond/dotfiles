// PowerDrawer.qml
import QtQuick 2.15
import QtQuick.Layouts 1.15
import Quickshell.Io

Item {
  id: root
  // ---- config ----
  property int pad: 6
  property int gap: 10
  property int animMs: 500
  property int iconPx: 18
  property string fontFamily: ""   // e.g. "JetBrainsMono Nerd Font"
  property string leaderGlyph: "󰤁"

  // ---- internal state ----
  property bool expanded: false

  // ---- size math ----
  readonly property int leaderW: leader.implicitWidth
  readonly property int extraW: extraRow.implicitWidth
  readonly property int collapsedW: leaderW + pad*2
  readonly property int fullW: leaderW + (extraW > 0 ? gap + extraW : 0) + pad*2

  // Outer shell is ALWAYS full width; we slide content inside
  width: fullW
  height: Math.max(leader.implicitHeight, extraRow.implicitHeight) + pad*2
  clip: true

  // One hover tracker layered on top; doesn’t steal clicks
  MouseArea {
    id: hoverArea
    anchors.fill: parent
    z: 9999
    hoverEnabled: true
    acceptedButtons: Qt.NoButton
    onEntered: {
      collapseTimer.stop()
      root.expanded = true
    }
    onExited: collapseTimer.restart()
  }

  Timer {
    id: collapseTimer
    interval: 200
    onTriggered: if (!hoverArea.containsMouse) root.expanded = false
  }

  // Slide the content to keep the RIGHT edge fixed
  Item {
    id: slider
    anchors.fill: parent
    // When collapsed, shift content so only the rightmost (leader) is visible.
    x: root.expanded ? 0 : (fullW - collapsedW)
    Behavior on x { NumberAnimation { duration: animMs; easing.type: Easing.InOutCubic } }

    Row {
      id: row
      anchors.fill: parent
      anchors.margins: pad
      spacing: gap
      // right-align the content so the leader hugs the right edge
      layoutDirection: Qt.RightToLeft

      // --- Leader (always at the right edge) ---
      Item {
        id: leader
        implicitWidth: leaderText.implicitWidth + 8
        implicitHeight: leaderText.implicitHeight + 8

        Text {
          id: leaderText
          anchors.centerIn: parent
          text: leaderGlyph
          font.pixelSize: iconPx
          font.family: fontFamily
          color: "#ddd"
        }

        // Click only; no hover here to avoid hover fights
        MouseArea {
          anchors.fill: parent
          onClicked: {
            // default action (optional)
          }
        }
      }

      // --- Extra icons (fade in/out; never toggling visible hard) ---
      Row {
        id: extraRow
        spacing: gap
        opacity: root.expanded ? 1 : 0
        // keep visible = true so nothing disappears during animation
        // (clipping + opacity handle the effect)
        Behavior on opacity { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

        // Helper for icon buttons
        component IconButton: Item {
          property string label: "?"
          property string col: "#ddd"
          signal triggered()
          implicitWidth: glyph.implicitWidth + 8
          implicitHeight: glyph.implicitHeight + 8

          Text {
            id: glyph
            anchors.centerIn: parent
            text: label
            font.pixelSize: iconPx
            font.family: fontFamily
            color: col
          }
          MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: triggered()
          }
        }

        // Command runner
        Process { id: runner
        stdout: StdioCollector { waitForEnd: true }
        stderr: StdioCollector { waitForEnd: true } }

        // Shutdown
        IconButton {
          label: ""
          onTriggered: runner.exec(["shutdown",  "now"])
        }

        // Arch
        IconButton {
          label: ""
          onTriggered: runner.exec(["pkexec",  "/home/insidebsi/.config/quickshell/scripts/systemd-reboot.sh", "arch"])
        }
        // Windows
        IconButton {
          label: ""
          onTriggered: runner.exec(["pkexec",  "/home/insidebsi/.config/quickshell/scripts/systemd-reboot.sh", "win"])
        }
        // Logout
        IconButton {
          label: "󰗼"
          onTriggered: runner.exec(["hyprctl",  "dispatch", "exit"])
        }
      }
    }
  }
}