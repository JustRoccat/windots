
import QtQuick

Item {
    id: root
    implicitWidth: timeLabel.implicitWidth + 8
    implicitHeight: parent ? parent.height : 26

    property string timeStr: Qt.formatDateTime(new Date(), "hh:mm")
    property string dateStr: Qt.formatDateTime(new Date(), "d.M.yyyy")

    Timer {
        interval: 1000
        running:  true
        repeat:   true
        onTriggered: {
            root.timeStr = Qt.formatDateTime(new Date(), "hh:mm")
            root.dateStr = Qt.formatDateTime(new Date(), "d.M.yyyy")
        }
    }

    Text {
        id: timeLabel
        anchors.centerIn: parent
        text:             root.timeStr
        font.family:      "Tahoma, Arial, sans-serif"
        font.pixelSize:   11
        color:            "#000000"
    }


    HoverHandler { id: hover }

    Rectangle {
        visible:       hover.hovered
        anchors.bottom: parent.top
        anchors.right:  parent.right
        anchors.bottomMargin: 2
        width:  dateLabel.implicitWidth + 8
        height: dateLabel.implicitHeight + 4
        color:  "#ffffe1"
        border.color: "#000000"
        border.width: 1

        Text {
            id: dateLabel
            anchors.centerIn: parent
            text:             root.dateStr
            font.family:      "Tahoma, Arial, sans-serif"
            font.pixelSize:   11
            color:            "#000000"
        }
    }
}
