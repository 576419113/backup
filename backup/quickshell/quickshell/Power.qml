import Quickshell
import QtQuick

Rectangle {
    id: power
    property int padding: 5
    property int timeout: 30
    property bool confirm: false
    implicitHeight: power_icon.height
    implicitWidth: power.confirm ? power_icon.width + poweroff_text.width + reboot_text.width : power_icon.width
    color: "#232627"
    radius: 5
    clip: true
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutElastic
        }
    }
    Text {
        id: power_icon
        anchors.left: parent.left
        padding: power.padding
        color: "#fcfcfc"
        font.family: "Hack"
        font.pixelSize: 18
        text: ""
        MouseArea {
            anchors.fill: parent
            onClicked: power.confirm = !power.confirm
        }
    }
    Text {
        id: poweroff_text
        visible: power.confirm
        anchors.left: power_icon.right
        padding: power.padding
        rightPadding: power.padding*2
        color: "#fcfcfc"
        font.family: "Hack"
        font.pixelSize: 18
        anchors.baseline: power_icon.baseline
        text: "关机"
        MouseArea {
            anchors.fill: parent
            onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
        }
    }
    Text {
        id: reboot_text
        visible: power.confirm
        anchors.left: poweroff_text.right
        padding: power.padding
        rightPadding: power.padding*2
        color: "#fcfcfc"
        font.family: "Hack"
        font.pixelSize: 18
        anchors.baseline: power_icon.baseline
        text: "重启"
        MouseArea {
            anchors.fill: parent
            onClicked: Quickshell.execDetached(["systemctl", "reboot"])
        }
    }
}
