//@ pragma UseQApplication
import Quickshell
import Quickshell.Hyprland
import QtQuick
import "."

ShellRoot {
    PanelWindow {
        id: status_bar
        anchors {
            left: true
            right: true
            bottom: true
        }
        margins {
            top: -10
            left: 5
            right: 5
            bottom: 5
        }
        color: "#00000000"
        implicitHeight: Math.max(clock.height, battery.height)
        Clock {
            id: clock
            anchors.right: parent.right
            padding: 5
            interval: 1000
        }
        Battery {
            id: battery
            anchors.right: clock.left
            anchors.rightMargin: 5
            padding: 5
        }
        Tray {
            id: tray
            anchors.right: battery.left
            anchors.rightMargin: 5
            padding: 5
        }
        Power {
            id: power
            anchors.left: parent.left
            padding: 5
        }
    }

    PanelWindow {
        id: search_window
        anchors {
            bottom: true
        }
        margins {
            bottom: 5
        }
        color: "#00000000"
        exclusionMode: ExclusionMode.Ignore
        implicitHeight: search.expand_height
        implicitWidth: search.expand_width
        mask: Region {
            item: search
        }
        Search {
            id: search
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            padding: 5
            expand_width: 600
            expand_height: 480
        }
        HyprlandFocusGrab {
            id: grab
            active: search.state === "open"
            windows: [ search_window ]
        }
    }
}
