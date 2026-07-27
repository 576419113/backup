pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
    id: search
    property int padding: 5
    property bool mode: false
    property int expand_height: 480
    property int expand_width: 600
    color: "#232627"
    radius: 5
    implicitHeight: search_icon.height
    implicitWidth: search_icon.width + search_input.width
    states: [
        State {
            name: "open"
            PropertyChanges {
                target: search
                implicitHeight: search.expand_height
                implicitWidth: search.expand_width
            }
        }
    ]
    transitions: [
        Transition {
            from: ""
            to: "open"
            SequentialAnimation {
                NumberAnimation {
                    duration: 200
                    property: "implicitWidth"
                    easing.bezierCurve: [0.12, 0, 0.39, 0, 1, 1]
                    easing.type: Easing.BezierSpline
                }
                NumberAnimation {
                    duration: 200
                    property: "implicitHeight"
                    easing.bezierCurve: [0.12, 0, 0.39, 0, 1, 1]
                    easing.type: Easing.BezierSpline
                }
            }
        },
        Transition {
            from: "open"
            to: ""
            SequentialAnimation {
                NumberAnimation {
                    duration: 200
                    property: "implicitHeight"
                    easing.bezierCurve: [0.61, 1, 0.88, 1, 1, 1]
                    easing.type: Easing.BezierSpline
                }
                NumberAnimation {
                    duration: 200
                    property: "implicitWidth"
                    easing.bezierCurve: [0.61, 1, 0.88, 1, 1, 1]
                    easing.type: Easing.BezierSpline
                }
            }
        }
    ]
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button == Qt.RightButton)
                search.state = "";
            else
                search.state = "open";
        }
    }
    IpcHandler {
        target: "search"
        function toggleSearch(): void {
            search.state = (search.state === "open" ? "" : "open");
        }
    }
    Text {
        id: search_icon
        anchors.left: search.left
        padding: search.padding
        color: "#fcfcfc"
        font.family: "Hack"
        font.pixelSize: 18
        text: ""
    }
    TextInput {
        id: search_input
        enabled: search.state === "open" ? true : false
        anchors.left: search_icon.right
        anchors.baseline: search_icon.baseline
        padding: search.padding
        color: search.state === "open" ? "#fcfcfc" : "#7f8c8d"
        font.family: "Hack"
        font.pixelSize: 18
        width: search.state === "open" ? search.width - search_icon.width : search_input.implicitWidth
        selectionColor: "#3daee9"
        text: search.state === "open" ? "" : "搜索..."
        focus: true
        onTextChanged: {
            list_view.currentIndex = 0
        }
        Keys.onPressed: (event) => {
            let idx = list_view.currentIndex
            switch (event.key) {
                case Qt.Key_Up:
                    event.accepted = true
                    do {
                        idx--
                    } while (idx >=0 && !list_view.itemAtIndex(idx)?.visible)
                    if (idx >= 0) list_view.currentIndex = idx
                    break
                case Qt.Key_Down:
                    event.accepted = true
                    do {
                        idx++
                    } while (idx < list_view.count && !list_view.itemAtIndex(idx)?.visible)
                    if (idx < list_view.count) list_view.currentIndex = idx
                    break
                case Qt.Key_Escape:
                    event.accepted = true
                    search.state = ""
                    break
                case Qt.Key_Return:
                    event.accepted = true
                    const item = list_view.itemAtIndex(idx)
                    if (item && item.visible) {
                        item.modelData.execute()
                        search.state = ""
                    }
                    break
            }
        }
    }
    ListView {
        id: list_view
        clip: true
        visible: search.state === "open"
        width: parent.width
        height: search.implicitHeight - search_icon.implicitHeight
        anchors.left: parent.left
        anchors.top: search_icon.bottom
        model: DesktopEntries.applications
        delegate: Rectangle {
            id: app
            required property var modelData
            visible: {
                if (modelData.noDisplay) return false
                var keyword = search_input.text.toLowerCase();
                var text = modelData.name.toLowerCase();
                if (!keyword)
                    return true;
                let ki = 0;
                for (let ti = 0; ti < text.length; ti++) {
                    if (text[ti] === keyword[ki])
                        ki++;
                    if (ki === keyword.length)
                        return true;
                }
                return false;
            }
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: mouse => {
                    if (mouse.button == Qt.RightButton)
                        search.state = ""
                    else {
                        app.modelData.execute()
                        search.state = ""
                    }
                }
            }
            width: list_view.width
            height: visible ? result_name.height : 0
            color: "#00000000"
            Item {
                id: result_icon
                anchors.left: parent.left
                height: result_name.height
                width: height
                Image {
                    anchors.centerIn: parent
                    source: Quickshell.iconPath(app.modelData.icon, true)
                    height: parent.height - search.padding*2
                    width: height
                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: 64
                    sourceSize.height: 64
                }
            }
            Text {
                id: result_name
                anchors.left: result_icon.right
                padding: search.padding
                color: "#cfcfcf"
                font.family: "Noto Sans CJK SC"
                font.pixelSize: 18
                text: app.modelData.name
            }
        }
        highlight: Rectangle {
            color: "#204357"
        }
    }
}
