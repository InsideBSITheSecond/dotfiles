import QtQuick
import Quickshell
import Quickshell.Hyprland

Column {
  id: workspaceRoot
  width: 150
  height: 25

  property color color

    /* --------------------------------------------------------------------
       *  The monitor this instance represents.
       *
       *  This value is set by the parent component (for example,
       *  “HDMI-A-1” or “HDMI-A-2”).  It allows the same file to be used for
       *  each screen without hard‑coding any monitor names inside the logic.
       */
    property var monitor          // <- set by the parent

    /* Alias that gives us just the monitor’s name as a string. */
    property var monitorName: monitor.name

    /* --------------------------------------------------------------------
       *  Grab the Hyprland monitor object once and cache it.
       *
       *  Using a property keeps the lookup out of every binding or
       *  expression, which is both faster and easier to read.
       */
    property var myMonitor: Hyprland.monitorFor(monitor)

    /* --------------------------------------------------------------------
       *  Base workspace number for each monitor.
       *
       *  The mapping that was previously hard‑coded in the original code
       *  is kept here so that the “X” logic and the per‑monitor numbering
       *  stay consistent with the previous behaviour.
       */
    property int monitorBase:
        monitorName === "HDMI-A-1" ? -10 :
        monitorName === "HDMI-A-2" ? 20 : 0

    /* --------------------------------------------------------------------
       *  Active workspace of this monitor, shown as “X”.
       *
       *  `displayedWorkspace` is a string because the surrounding UI
       *  displays it directly.  The calculation mirrors the original
       *  logic: we map the global workspace id to a local 1‑10 number
       *  and then offset it with `monitorBase`.
       */
  property string displayedWorkspace: {
        let raw = parseInt(myMonitor.activeWorkspace.id)
    return monitorBase + ((raw - 1) % 10) + 1
  }

  function displayTextForWorkspace(w) {
    if (w.id === Hyprland.focusedWorkspace.id)
      return " "
    else if (w.id === myMonitor.activeWorkspace.id)
      return " "
    else
      return ((parseInt(w.id) - 1) % 10 + 1) + " "
  }

  function focusWorkspace(id) {
    
  }

    /* --------------------------------------------------------------------
       *  UI – show the current state.
       *
       *  The text shows:
       *   • The active workspace on this monitor (the “X” logic)
       *   • The currently focused monitor (global Hyprland focus)
       *   • Which monitor instance is rendering this component
       */
  /*Text {
    anchors.centerIn: parent.bot
    text: "active workspace: " + displayedWorkspace 
    + " / active screen: " + Hyprland.focusedMonitor.name
    + " / owner screen: " + monitorName
  }*/

    /* --------------------------------------------------------------------
       *  Row of workspaces belonging to this monitor.
       *
       *  We now simply iterate over `myMonitor.workspaces.values`,
       *  which guarantees that we only see the workspaces that belong
       *  to the monitor represented by this instance.  The text for each
       *  workspace shows “X” when it is the active workspace of the
       *  monitor, otherwise it displays its local number (1‑10).
       */
  Row {
    Repeater {
      /* Filter the global workspace list so that only workspaces belonging
         to this monitor are returned.  The ID ranges you described are used:
           center   : 1‑10
           left     : 11‑20
           right    : 21‑30
      */
      model: Array.from(Hyprland.workspaces.values).filter(w => {
        const id = parseInt(w.id)
        if (monitorName === "HDMI-A-1")       return id >= 11 && id <= 20   // left
        if (monitorName === "HDMI-A-2")       return id >= 21 && id <= 30   // right
        /* otherwise assume center monitor */
        return id >= 1  && id <= 10
      })

      Text {
        text: displayTextForWorkspace(modelData)
        color: workspaceRoot.color

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: modelData.activate()
        }
      }
    }
  }
}


