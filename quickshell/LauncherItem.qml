
import QtQuick
import QtQuick.Layouts
import Quickshell

Item {
    id: root

    property string label:     ""
    property string icon:      ""
    property string cmd:       ""
    property bool   showArrow: false

    signal activated()

    implicitHeight: 26
    implicitWidth:  200

    property bool isDisabled: cmd === ""
    property bool hov: hoverHandler.hovered && !isDisabled

    Rectangle {
        anchors.fill: parent
        color: root.hov ? "#000080" : "transparent"
    }

    RowLayout {
        anchors {
            fill: parent
            leftMargin:  8
            rightMargin: 6
        }
        spacing: 6

        Text {
            text:           root.icon
            font.pixelSize: 14
            color:          root.isDisabled ? "#808080" : (root.hov ? "#ffffff" : "#000000")
        }

        Text {
            Layout.fillWidth: true
            text:           root.label
            font.family:    "Tahoma, Arial, sans-serif"
            font.pixelSize: 12
            color:          root.isDisabled ? "#808080" : (root.hov ? "#ffffff" : "#000000")
        }

        Text {
            visible:        root.showArrow
            text:           "▶"
            font.pixelSize: 9
            color:          root.isDisabled ? "#808080" : (root.hov ? "#ffffff" : "#000000")
        }
    }

    HoverHandler { id: hoverHandler }

    MouseArea {
        anchors.fill: parent
        enabled:      !root.isDisabled
        onClicked: {

            Quickshell.execDetached(root.cmd.split(" "))
            root.activated()
        }
    }
}
