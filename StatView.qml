import QtQuick
import QtQuick.Shapes
import QtQuick.Controls

Item {
    id: root

    property int accuracy: 0
    property int symbolsPerMinute: 0
    property int maxSymbolsPerMinute: 300

    height: width / 2
    property real ratio: Math.min(symbolsPerMinute / maxSymbolsPerMinute, 1.0)
    Behavior on ratio {
        NumberAnimation { duration: 200; easing.type: Easing.Linear }
    }

    property color color: {
        if (ratio < 0.2)
            return Qt.color("lightcoral")
        else if (ratio < 0.4)
            return Qt.color("goldenrod")
        else if (ratio < 0.6)
            return Qt.color("darkkhaki")
        else
            return Qt.color("yellowgreen")
    }
    Behavior on color {
        ColorAnimation { duration: 300; easing.type: Easing.Linear }
    }

    readonly property real shapeWidth: root.width
    readonly property real shapeHeight: root.height
    readonly property real shapeWidth2: shapeWidth / 2
    readonly property real shapeHeight2: shapeHeight / 2

    readonly property real progressLineWidth: shapeWidth / 10
    readonly property real progressLineWidth2: progressLineWidth / 2

    Shape {
        ShapePath {
            id: progressPath
            strokeWidth: progressLineWidth
            strokeColor: root.color
            fillColor: "transparent"
            capStyle: ShapePath.MiterJoin

            startX: progressLineWidth / 2
            startY: shapeHeight

            readonly property real radius: shapeWidth2 - progressLineWidth2
            readonly property real radians: (180.0 - ratio * 180.0) * Math.PI / 180.0

            PathArc {
                x: shapeWidth2 + progressPath.radius * Math.cos(progressPath.radians);
                y: shapeHeight - progressPath.radius * Math.sin(progressPath.radians)
                radiusX: progressPath.radius; radiusY: progressPath.radius; useLargeArc: false
            }
        }

        ShapePath {
            strokeWidth: 2
            strokeColor: "darkGray"
            fillColor: "transparent"

            startX: 0
            startY: shapeHeight

            PathArc { x: shapeWidth; y: shapeHeight; radiusX: shapeWidth2; radiusY: shapeHeight; useLargeArc: true }
            PathLine { x: shapeWidth - progressLineWidth; y: shapeHeight }
            PathMove { x: 0; y: shapeHeight }
            PathLine { x: progressLineWidth; y: shapeHeight }
            PathArc { x: shapeWidth - progressLineWidth; y: shapeHeight; radiusX: shapeWidth2 - progressLineWidth * 2; radiusY: shapeHeight - progressLineWidth * 2; useLargeArc: true }
        }
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 16
            font.bold: true
            color: "black"
            text: root.symbolsPerMinute + " зн./хв"
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 14
            color: "black"
            text: "Швидкість"
        }

        Item { width: 1; height: 4 }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 16
            font.bold: true
            color: "black"
            text: root.accuracy + " %"
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 14
            color: "black"
            text: "Точність"
        }

        Item { width: 1; height: 4 }
    }
}
