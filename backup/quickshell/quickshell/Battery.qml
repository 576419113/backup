import Quickshell.Services.UPower
import QtQuick

Rectangle {
    id: battery
    color: "#232627"
    radius: 5
    property int padding: 5
    property var percentage: Math.round(UPower.displayDevice.percentage*100)
    property var isCharging: UPower.displayDevice.state === UPowerDeviceState.Charging
    implicitWidth: battery_icon.width + battery_value.width
    implicitHeight: battery_value.height
    Text {
        id: battery_value
        padding: battery.padding
        text: `${battery.percentage}%`
        color: battery.percentage < 10 ? "#ed1515" : "#fcfcfc"
        font.family: "Hack"
        font.pixelSize: 18
    }
    Text {
        id: battery_icon
        topPadding: battery.padding
        rightPadding: battery.padding
        bottomPadding: battery.padding
        anchors.left: battery_value.right
        anchors.baseline: battery_value.baseline
        property var uncharge_icon: [ "󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹" ]
        property var charge_icon: [ "󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅" ]
        text: battery.isCharging ? charge_icon[Math.floor(battery.percentage/10)] : uncharge_icon[Math.floor(battery.percentage/10)]
        color: battery.isCharging ? battery.percentage < 50 ? "#fdbc4b" : "#11d116" : battery.percentage < 20 ? "#ed1515" : "#fcfcfc"
        font.family: "Hack"
        font.pixelSize: 18
    } 
}
