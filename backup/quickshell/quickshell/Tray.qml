pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Services.SystemTray
import QtQuick

Rectangle {
    id: tray_bar
    property int padding: 5
    implicitHeight: tray_text.height
    implicitWidth: tray_text.width + list_view.width
    color: "#232629"
    radius: 5
    Text {
        id: tray_text
        padding: tray_bar.padding
        anchors.left: parent.left
        color: "#fcfcfc"
        font.family: "Hack"
        font.pixelSize: 18
        text: "Tray:"
    }
    ListView {
        id: list_view
        anchors.left: tray_text.right
        orientation: Qt.Horizontal
        layoutDirection: Qt.RightToLeft
        height: tray_text.height
        width: 100
        model: SystemTray.items
        delegate: Item {
            id: tray
            required property var modelData
            height: tray_bar.implicitHeight
            width: height
            Image {
                anchors.centerIn: parent
                sourceSize.width: 64
                sourceSize.height: 64
                height: parent.height - tray_bar.padding * 2
                width: height
                fillMode: Image.PreserveAspectFit
                source: tray.modelData.icon
            }
            QsMenuOpener { id: menuOpener }
            MouseArea {
                id: mouse
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: (mouse) => {
                    if (mouse.button == Qt.LeftButton)
                        tray.modelData.activate()
                    else
                        tray.modelData.display(status_bar, tray.x, tray.y)
                }
            }
        }
    }
}
