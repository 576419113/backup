import Quickshell.Io
import QtQuick

Rectangle {
    id: clock
    implicitHeight: time.height
    implicitWidth: time.width
    property int padding: 5
    property int interval: 500
    color: "#232627"
    radius: 5
    Process {
        id: dateProc
        command: ["date", "+%T"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: time.text = this.text
        }
    }
    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
    Text {
        id: time
        padding: clock.padding
        color: "#fcfcfc"
        font.family: "Hack"
        font.pixelSize: 18
    }
}
