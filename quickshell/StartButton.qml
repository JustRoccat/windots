
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    implicitWidth:  row.implicitWidth + 14
    implicitHeight: parent ? parent.height : 26

    property bool pressed: false

    Launcher { id: launcher }

    Rectangle {
        anchors.fill: parent
        color: "#c0c0c0"

        Rectangle { x: 0;               y: 0;               width: parent.width; height: 1;            color: root.pressed ? "#808080" : "#ffffff" }
        Rectangle { x: 0;               y: 0;               width: 1;            height: parent.height; color: root.pressed ? "#808080" : "#ffffff" }
        Rectangle { x: 0;               y: parent.height-1; width: parent.width; height: 1;            color: root.pressed ? "#ffffff" : "#000000" }
        Rectangle { x: parent.width-1;  y: 0;               width: 1;            height: parent.height; color: root.pressed ? "#ffffff" : "#000000" }
        Rectangle { x: 1;               y: 1;               width: parent.width-2; height: 1;              color: root.pressed ? "#404040" : "#dfdfdf" }
        Rectangle { x: 1;               y: 1;               width: 1;              height: parent.height-2; color: root.pressed ? "#404040" : "#dfdfdf" }
        Rectangle { x: 1;               y: parent.height-2; width: parent.width-2; height: 1;              color: root.pressed ? "#dfdfdf" : "#808080" }
        Rectangle { x: parent.width-2;  y: 1;               width: 1;              height: parent.height-2; color: root.pressed ? "#dfdfdf" : "#808080" }

        Row {
            id: row
            anchors.centerIn: parent
            transform: Translate { x: root.pressed ? 1 : 0; y: root.pressed ? 1 : 0 }
            spacing: 5

            Grid {
                columns: 2
                spacing: 1
                anchors.verticalCenter: parent.verticalCenter
                Repeater {
                    model: ["#ff2020", "#20b020", "#2020ff", "#ffdd00"]
                    Rectangle { width: 7; height: 7; color: modelData }
                }
            }

            Text {
                text: "Start"
                font.family: "Tahoma, Arial, sans-serif"
                font.pixelSize: 12
                font.bold: true
                color: "#000000"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed:  root.pressed = true
        onReleased: root.pressed = false
        onClicked:  launcher.visible = !launcher.visible
    }
}
