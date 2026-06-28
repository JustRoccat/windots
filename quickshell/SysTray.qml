
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Item {
    id: root
    implicitWidth: innerRow.implicitWidth + 10
    implicitHeight: parent ? parent.height : 26


    Rectangle {
        anchors.fill: parent
        color: "#c0c0c0"


        Rectangle { x: 0;                y: 0;                width: parent.width;  height: 1;             color: "#808080" }
        Rectangle { x: 0;                y: 0;                width: 1;             height: parent.height;  color: "#808080" }
        Rectangle { x: 0;                y: parent.height - 1;width: parent.width;  height: 1;             color: "#ffffff" }
        Rectangle { x: parent.width - 1; y: 0;                width: 1;             height: parent.height;  color: "#ffffff" }

        Row {
            id: innerRow
            anchors.left:           parent.left
            anchors.leftMargin:     5
            anchors.right:          parent.right
            anchors.rightMargin:    5
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4


            Repeater {
                model: SystemTray.items

                Item {
                    id: trayIconItem
                    width:  16
                    height: 16
                    anchors.verticalCenter: parent.verticalCenter

                    required property var modelData

                    Image {
                        anchors.fill: parent

                        source:   trayIconItem.modelData.icon ?? ""
                        fillMode: Image.PreserveAspectFit
                        smooth:   false
                    }

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: (mouse) => {
                            if (mouse.button === Qt.LeftButton)
                                trayIconItem.modelData.activate()
                            else
                                trayIconItem.modelData.secondaryActivate()
                        }
                    }
                }
            }


            Item {
                width: 6
                height: 16
                anchors.verticalCenter: parent.verticalCenter
                Rectangle { x: 1; y: 0; width: 1; height: parent.height; color: "#808080" }
                Rectangle { x: 2; y: 0; width: 1; height: parent.height; color: "#ffffff" }
            }


            Clock {}
        }
    }
}
