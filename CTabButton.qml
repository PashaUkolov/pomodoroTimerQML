import QtQuick
import QtQuick.Controls

TabButton {
    id: control
    padding: 0
    property color tabButtonColor: "#b72424"

    contentItem: Text {
        text: control.text
        font: control.font

        color: "#fefefe"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 80
        implicitHeight: 40
        color: control.checked ? tabButtonColor : "transparent"
        radius: 5
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
    }
}
