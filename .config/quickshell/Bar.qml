import Quickshell
import QtQuick
import QtQuick.Layouts

import Quickshell.Services.SystemTray
import Quickshell.DBusMenu

Scope {
  Variants {
    id: bar
    model: Quickshell.screens

    PanelWindow {
      id: barRoot
      property var modelData
      screen: modelData
      implicitHeight: 35

      SystemPalette { id: pal }
      color: pal.midlight 

      anchors {
        top: true
        left: true
        right: true
      }


      RowLayout {

        anchors.fill: parent
        spacing: 6

        Rectangle {
          id: barLeft
          color: pal.window
          Layout.fillWidth: true
          Layout.preferredHeight: 150

          RowLayout {
            Username {
              id: username
              color: pal.text
            }

            WindowName {
              color: pal.text
              screen: barRoot.screen
            }
          }
          
        }

        Rectangle {
          id: barCenter
          color: pal.window
          Layout.fillWidth: true
          Layout.fillHeight: true

          Workspace {
            monitor: screen
            monitorName: screen.name
            color: pal.text
          }
        }

        Rectangle {
          id: barRight
          color: pal.window
          Layout.preferredWidth: 500
          Layout.preferredHeight: 150

          RowLayout {          
            SysTray {
              vertical: false
              Layout.fillHeight: false
              Layout.fillWidth: true
              invertSide: true
            }

            ClockWidget {
              id: clock
              color: pal.text
              
            }
          }
        }
      }
    }
  }
}