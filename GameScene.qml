import QtQuick

Item {
    id: scene
    focus: true

    signal finished(int elapsedTime, int mistakes, int size)

    QtObject {
        id: d

        property int sceneWidth: 1260
        property int sceneHeight: 40
        property int keyWidth: 40
        property int keyHeight: 40
        property int keySpace: 2
    }

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: "beige"
    }

    Component {
        id: keyViewComponent
        KeyView {
            width: d.keyWidth
            height: d.keyHeight
        }
    }

    property var keyViews: []

    function load(task) {
        size = task.length
        task.split("").forEach((item, index) => {
            let keyView = keyViewComponent.createObject(sceneView, {x: index * (d.keyWidth + d.keySpace), y: 0, text: item, opacity: 0, scale: 0.8})
            keyView.show()
            keyViews.push(keyView)
        })
        keyViews[0].isActive = true

        start()
    }

    property var startTime
    property int size: 0
    property int mistakes: 0

    function start() {
        startTime = new Date().getTime()
        mistakes = 0
    }

    function stop() {
        const elapsedTime = new Date().getTime() - startTime

        scene.finished(elapsedTime, mistakes, size)
    }

    Keys.onPressed: (event)=> {
        if (event.text === "")
        {
            return
        }

        if (keyViews.length !== 0) {
            var keyView = keyViews[0]
            if (keyView.text === event.text) {
                keyView = keyViews.shift()
                keyView.hideAndDestroy()

                if (keyViews.length !== 0) {
                    keyViews[0].isActive = true
                } else {
                    stop()
                }
            } else {
                mistakes++
                keyView.shake()
            }
        }
    }

    Keys.onReleased: (event)=> {
    }

    Item {
        id: sceneView

        width: d.sceneWidth
        height: d.sceneHeight

        anchors.centerIn: parent
        readonly property real sceneScale: Math.min(scene.width / (sceneView.width + d.keyWidth * 2), scene.height / (sceneView.height + d.keyHeight * 2))
        scale: sceneScale
    }
}
