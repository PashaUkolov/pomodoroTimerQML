import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Shapes

Item {
    id: timeDial
    x: 0; y: 0
    width: 200; height: 200

    Layout.alignment: Qt.AlignCenter

    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    MouseArea {
        anchors.fill: parent
        onPressed:(mouse) => {
            shapeDial.clickPos = mouse.y
            currentRotation = shapeDial.clockRotation;
            cursorShape = Qt.ClosedHandCursor
        }
        onReleased:(mouse) => {
            cursorShape = Qt.OpenedHandCursor
        }

        onPositionChanged:(mouse) => {
            var offset = shapeDial.clickPos - mouse.y
            shapeDial.clockRotation = currentRotation + offset
            if(shapeDial.clockRotation < 0) {
                shapeDial.clockRotation = 0
            }

            if(shapeDial.clockRotation > 360) {
              shapeDial.clockRotation = 360
            }
            currentTimeMinutes = deg2minutes(shapeDial.clockRotation)
            currentTimeSeconds = currentTimeMinutes*60
        }

        cursorShape: Qt.OpenHandCursor
    }

    Shape {
        id: shapeDial

        anchors.fill: parent
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        property var center : verticalCenter

        property int clickPos : 0;
        property int clockRotation : 0;
        property int pathWidth : 10

        //dial bg path
        ShapePath {
            strokeWidth: shapeDial.pathWidth
            strokeColor: "#ffffffff"
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap
            PathAngleArc {
                centerX: shapeDial.width / 2
                centerY: shapeDial.height / 2
                radiusX: 100
                radiusY: 100
                startAngle: 0
                sweepAngle: 360
            }
        }

        //dial path
        ShapePath {
            strokeWidth: shapeDial.pathWidth
            strokeColor: mainColorAccent
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap
            PathAngleArc {
                centerX: shapeDial.width / 2
                centerY: shapeDial.height / 2
                radiusX: 100
                radiusY: 100
                startAngle: -90
                sweepAngle: shapeDial.clockRotation
            }
        }

        // dial tip
        Rectangle {
            width: 20; height: 20
            radius: 30
            x: {
                Math.cos(deg2rad(shapeDial.clockRotation - 90)) * 100 + parent.width / 2 - width/2
            }
            y: {
                Math.sin(deg2rad(shapeDial.clockRotation - 90)) * 100 + parent.height / 2 - width /2
            }
        }
    }

    ColumnLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            Layout.alignment: Qt.AlignCenter
            text: currentTimeMinutes + ":" + (currentTimeSeconds % 60).toString().padStart(2, '0')
            color: "white"
            font.pointSize: 24
        }
        Text {
            Layout.alignment: Qt.AlignCenter
            text: "minutes"
            color: "white"
            font.pointSize: 18
        }
    }
}
