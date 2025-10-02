import QtQuick
import Quickshell
import Quickshell.Wayland

Text {
  id: windowName

  property var screen

  // cache the last seen active title for THIS screen
  property string lastTitleOnThisScreen: ""

  function maybeUpdateFromActive() {
    const tl = ToplevelManager.activeToplevel
    //console.warn(windowName.screen)
    if (!tl) return
    // If the active toplevel is on this PanelWindow's screen, record its title
    if (tl.screens.indexOf(windowName.screen) !== -1) {
      lastTitleOnThisScreen = tl.title || ""
    }
  }

  // update when the active window changes
  Connections {
    target: ToplevelManager
    function onActiveToplevelChanged() { windowName.maybeUpdateFromActive() }
  }

  // also update when the active window’s title changes (e.g., browser tab change)
  Connections {
    target: ToplevelManager.activeToplevel
    ignoreUnknownSignals: true
    function onTitleChanged() { windowName.maybeUpdateFromActive() }
  }

  // initial fill
  Component.onCompleted: maybeUpdateFromActive()

    //anchors.verticalCenter: parent.verticalCenter
    //anchors.left: parent.left; anchors.leftMargin: 12
    text: lastTitleOnThisScreen.length ? lastTitleOnThisScreen : "—"
    //color: white
    //elide: Text.ElideRight
    //width: parent.width * 0.4
}