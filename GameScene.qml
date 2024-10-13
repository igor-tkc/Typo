import QtQuick
import QtMultimedia

Item {
    id: scene
    focus: true

    property bool soundEnabled: false
    signal changed(int elapsedTime, int mistakes, int taskSize, int completedItems)
    signal finished(int elapsedTime, int mistakes, int taskSize)

    QtObject {
        id: d

        property int sceneWidth: 1260
        property int sceneHeight: 40
        property int keyWidth: 40
        property int keyHeight: 40
        property int keySpace: 2
    }

    SoundEffect {
        id: typewriter1

        volume: 0.4
        source: "qrc:/sounds/typewriter-1.wav"
    }

    SoundEffect {
        id: typewriter2
        volume: 0.4
        source: "qrc:/sounds/typewriter-2.wav"
    }

    SoundEffect {
        id: typewriter3
        volume: 0.4
        source: "qrc:/sounds/typewriter-3.wav"
    }

    readonly property var typeWriterSoundEffects: [typewriter1, typewriter2, typewriter3]

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: "beige"
        border.color: "darkGray"
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
        taskSize = task.length
        task.split("").forEach((item, index) => {
            let keyView = keyViewComponent.createObject(sceneView, {x: index * (d.keyWidth + d.keySpace), y: 0, text: item, opacity: 0, scale: 0.8})
            keyView.show()
            keyViews.push(keyView)
        })
        keyViews[0].isActive = true

        start()
    }

    property var startTime
    property int taskSize: 0
    property int completedItems: 0
    property int mistakes: 0

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            scene.progress()
        }
    }

    function start() {
        startTime = new Date().getTime()
        completedItems = 0
        mistakes = 0
    }

    function stop() {
        timer.stop()

        const elapsedTime = new Date().getTime() - startTime

        scene.finished(elapsedTime, mistakes, taskSize)
    }

    function progress() {
        const elapsedTime = new Date().getTime() - startTime

        scene.changed(elapsedTime, mistakes, taskSize, completedItems)
    }

    property var typeWriterSoundEffect

    Keys.onPressed: (event)=> {
        if (!timer.running) {
             timer.start()
        }

        if (scene.soundEnabled) {
            if (typeWriterSoundEffect) {
                typeWriterSoundEffect.stop()
            }

            typeWriterSoundEffect = typeWriterSoundEffects[Math.floor(Math.random() * typeWriterSoundEffects.length)]
            typeWriterSoundEffect.play()
        }

        if (event.text === "")
        {
            return
        }

        if (keyViews.length !== 0) {
            var keyView = keyViews[0]
            if (keyView.text === event.text) {
                keyView = keyViews.shift()
                keyView.hideAndDestroy()

                completedItems++
                if (keyViews.length !== 0) {
                    keyViews[0].isActive = true
                } else {
                    stop()
                }
            } else {
                mistakes++
                keyView.shake()
            }
            progress()
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
