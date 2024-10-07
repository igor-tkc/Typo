import QtQuick
import QtQuick.Shapes

Item {
    id: root
    x: 100
    y: 100

    width: 320
    height: root.width / 2

    readonly property real shapeWidth: root.width
    readonly property real shapeHeight: root.height
    readonly property real shapeWidth2: shapeWidth / 2
    readonly property real shapeHeight2: shapeHeight / 2

    readonly property real progressLineWidth: shapeWidth / 10

    Shape {
        ShapePath {
            strokeWidth: 1
            strokeColor: "darkGray"
            fillColor: "lightGray"

            startX: 0
            startY: shapeHeight

            PathArc { x: shapeWidth; y: shapeHeight; radiusX: shapeWidth2; radiusY: shapeHeight; useLargeArc: true }
            PathLine { x: 0; y: shapeHeight }
        }

        ShapePath {
            strokeWidth: 1
            strokeColor: "darkGray"
            fillColor: "lightGray"

            startX: progressLineWidth
            startY: shapeHeight

            PathArc { x: shapeWidth - progressLineWidth; y: shapeHeight; radiusX: shapeWidth2 - progressLineWidth * 2; radiusY: shapeHeight - progressLineWidth * 2; useLargeArc: true }
            PathLine { x: progressLineWidth; y: shapeHeight }
        }
    }
}
