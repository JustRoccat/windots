
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {
    id: root

    visible: false
    anchors.left:   true
    anchors.bottom: true
    margins.bottom: 30
    exclusionMode:  ExclusionMode.Ignore
    implicitWidth:  280
    implicitHeight: 460
    color: "transparent"

    WlrLayershell.layer:         WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

    onVisibleChanged: {
        if (visible) {
            searchField.text = ""
            searchField.forceActiveFocus()
            listView.currentIndex = -1
        }
    }


    Rectangle {
        x: 4; y: 4
        width: parent.width - 4
        height: parent.height - 4
        color: "#000000"
        opacity: 0.35
    }


    Rectangle {
        id: win
        width: parent.width - 4
        height: parent.height - 4
        color: "#c0c0c0"


        Rectangle { x:0;y:0;           width:parent.width;height:1;  color:"#ffffff" }
        Rectangle { x:0;y:0;           width:1;height:parent.height; color:"#ffffff" }
        Rectangle { x:0;y:parent.height-1; width:parent.width;height:1; color:"#000000" }
        Rectangle { x:parent.width-1;y:0;  width:1;height:parent.height; color:"#000000" }
        Rectangle { x:1;y:1;           width:parent.width-2;height:1;  color:"#dfdfdf" }
        Rectangle { x:1;y:1;           width:1;height:parent.height-2; color:"#dfdfdf" }
        Rectangle { x:1;y:parent.height-2; width:parent.width-2;height:1; color:"#808080" }
        Rectangle { x:parent.width-2;y:1;  width:1;height:parent.height-2; color:"#808080" }

        Row {
            anchors { fill: parent; margins: 2 }
            spacing: 0


            Rectangle {
                width:  8
                height: parent.height
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#2a5db0" }
                    GradientStop { position: 1.0; color: "#000060" }
                }
            }


            Column {
                width: parent.width - 8
                height: parent.height
                spacing: 0


                Rectangle {
                    width: parent.width
                    height: 32
                    color: "#c0c0c0"

                    Rectangle {
                        anchors { fill: parent; leftMargin:6; rightMargin:6; topMargin:5; bottomMargin:3 }
                        color: "#ffffff"

                        Rectangle { x:0;y:0; width:parent.width;height:1; color:"#808080" }
                        Rectangle { x:0;y:0; width:1;height:parent.height; color:"#808080" }
                        Rectangle { x:0;y:parent.height-1; width:parent.width;height:1; color:"#ffffff" }
                        Rectangle { x:parent.width-1;y:0; width:1;height:parent.height; color:"#ffffff" }
                        Rectangle { x:1;y:1; width:parent.width-2;height:1; color:"#404040" }
                        Rectangle { x:1;y:1; width:1;height:parent.height-2; color:"#404040" }

                        Text {
                            id: searchIcon
                            anchors { left:parent.left; leftMargin:6; verticalCenter:parent.verticalCenter }
                            text: "🔍"
                            font.pixelSize: 11
                            opacity: 0.6
                        }

                        TextInput {
                            id: searchField
                            anchors { fill:parent; leftMargin:22; rightMargin:6 }
                            font.family: "Tahoma, Arial, sans-serif"
                            font.pixelSize: 11
                            color: "#000000"
                            clip: true
                            selectByMouse: true
                            verticalAlignment: TextInput.AlignVCenter

                            Keys.onUpPressed: {
                                if (listView.currentIndex > 0) listView.currentIndex--
                                else listView.currentIndex = listView.count - 1
                            }
                            Keys.onDownPressed: {
                                if (listView.currentIndex < listView.count - 1) listView.currentIndex++
                                else listView.currentIndex = 0
                            }
                            Keys.onReturnPressed: root.launch()
                            Keys.onEscapePressed: root.visible = false
                        }

                        Text {
                            anchors { left:parent.left; leftMargin:22; verticalCenter:parent.verticalCenter }
                            text: "Szukaj…"
                            font.family: "Tahoma, Arial, sans-serif"
                            font.pixelSize: 11
                            color: "#a0a0a0"
                            visible: searchField.text === ""
                        }
                    }
                }


                Rectangle { width:parent.width; height:1; color:"#808080" }
                Rectangle { width:parent.width; height:1; color:"#ffffff" }


                ScriptModel {
                    id: apps
                    values: {
                        const all = [...DesktopEntries.applications.values]
                            .filter(d => d.name)
                            .sort((a, b) => a.name.localeCompare(b.name))
                        const q = searchField.text.trim().toLowerCase()
                        if (q === "") return all
                        return all.filter(d => {
                            const n = (d.name    || "").toLowerCase()
                            const c = (d.comment || "").toLowerCase()
                            const k = (d.keywords   || []).join(" ").toLowerCase()
                            return n.includes(q) || c.includes(q) || k.includes(q)
                        })
                    }
                }

                ListView {
                    id: listView
                    width: parent.width
                    height: parent.height - 32 - 2 - 36 - 2
                    clip: true
                    model: apps.values
                    currentIndex: -1
                    highlightMoveDuration: 0
                    highlightResizeDuration: 0

                    delegate: Item {
                        id: entry
                        required property var modelData
                        required property int index

                        width: listView.width
                        height: 26

                        Rectangle {
                            anchors.fill: parent
                            color: listView.currentIndex === entry.index
                                   ? "#000080"
                                   : (entry.index % 2 === 0 ? "#c0c0c0" : "#cacaca")
                        }

                        HoverHandler {
                            id: hov
                            onHoveredChanged: if (hovered) listView.currentIndex = entry.index
                        }

                        RowLayout {
                            anchors { fill:parent; leftMargin:8; rightMargin:8 }
                            spacing: 8

                            Image {
                                source: Quickshell.iconPath(entry.modelData.icon ?? "", true)
                                Layout.preferredWidth:  18
                                Layout.preferredHeight: 18
                                sourceSize.width:  18
                                sourceSize.height: 18
                                fillMode: Image.PreserveAspectFit
                                smooth: true
                            }

                            Text {
                                Layout.fillWidth: true
                                text: entry.modelData.name ?? ""
                                font.family: "Tahoma, Arial, sans-serif"
                                font.pixelSize: 12
                                color: listView.currentIndex === entry.index ? "#ffffff" : "#000000"
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked:       listView.currentIndex = entry.index
                            onDoubleClicked: root.launch()
                        }
                    }
                }


                Rectangle { width:parent.width; height:1; color:"#808080" }
                Rectangle { width:parent.width; height:1; color:"#ffffff" }


                Item {
                    width:  parent.width
                    height: 36

                    Row {
                        anchors { right:parent.right; rightMargin:8; verticalCenter:parent.verticalCenter }
                        spacing: 6

                        Win95Button {
                            text:    "Uruchom"
                            enabled: listView.currentIndex >= 0
                            onClicked: root.launch()
                        }
                        Win95Button {
                            text: "Anuluj"
                            onClicked: root.visible = false
                        }
                    }
                }
            }
        }
    }

    function launch() {
        const i = listView.currentIndex
        if (i >= 0 && i < apps.values.length) {
            apps.values[i].execute()
            root.visible = false
        }
    }
}
