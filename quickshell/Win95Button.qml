
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property string text: ""
    property bool enabled: true
    signal clicked()

    implicitWidth:  textLabel.implicitWidth + 20
    implicitHeight: 22

    property bool pressed: false
    property bool hov: hoverHandler.hovered && root.enabled

    Rectangle {
        anchors.fill: parent
        color: "#c0c0c0"


        Rectangle { x: 0;               y: 0;               width: parent.width; height: 1;            color: root.pressed ? "#808080" : "#ffffff" }
        Rectangle { x: 0;               y: 0;               width: 1;            height: parent.height; color: root.pressed ? "#808080" : "#ffffff" }
        Rectangle { x: 0;               y: parent.height-1; width: parent.width; height: 1;            color: root.pressed ? "#ffffff" : "#000000" }
        Rectangle { x: parent.width-1;  y: 0;               width: 1;            height: parent.height; color: root.pressed ? "#ffffff" : "#000000" }
        Rectangle { x: 1; y: 1;               width: parent.width-2; height: 1;              color: root.pressed ? "#404040" : "#dfdfdf" }
        Rectangle { x: 1; y: 1;               width: 1;              height: parent.height-2; color: root.pressed ? "#404040" : "#dfdfdf" }
        Rectangle { x: 1; y: parent.height-2; width: parent.width-2; height: 1;              color: root.pressed ? "#dfdfdf" : "#808080" }
        Rectangle { x: parent.width-2; y: 1;  width: 1;              height: parent.height-2; color: root.pressed ? "#dfdfdf" : "#808080" }

        Text {
            id: textLabel
            anchors.centerIn: parent
            transform: Translate { x: root.pressed ? 1 : 0; y: root.pressed ? 1 : 0 }
            text: root.text
            font.family: "Tahoma, Arial, sans-serif"
            font.pixelSize: 12
            color: root.enabled ? "#000000" : "#808080"
        }
    }

    HoverHandler { id: hoverHandler }

    MouseArea {
        anchors.fill: parent
        enabled: root.enabled
        onPressed:  root.pressed = true
        onReleased: root.pressed = false
        onClicked:  root.clicked()
    }
}
