
import QtQuick

Item {
    id: root
    property string text: ""

    HoverHandler { id: hover }

    Rectangle {
        visible: hover.hovered && root.text !== ""

        anchors.bottom:       parent.top
        anchors.left:         parent.left
        anchors.bottomMargin: 2
        width:  tipLabel.implicitWidth + 8
        height: tipLabel.implicitHeight + 4
        color:  "#ffffe1"
        border.color: "#000000"
        border.width: 1
        z: 100

        Text {
            id: tipLabel
            anchors.centerIn: parent
            text:             root.text
            font.family:      "Tahoma, Arial, sans-serif"
            font.pixelSize:   11
            color:            "#000000"
        }
    }
}
