import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Window {
    id: window

    width: 1260
    height: 400
    visible: true
    color: "#444546"
    title: qsTr("Typo")

    Material.theme: Material.Dark
    Material.accent: Material.Amber


    function generate_text(symbols, length) {
        var result = ''
        for(let i = 0; i < length; ++i) {
            result += symbols[Math.floor(Math.random() * symbols.length)]
        }
        return result
    }

    Component.onCompleted: {
        scene.load(generate_text(['а', 'о', ' '], 30))
    }

    Row {
        anchors.right: parent.right
        anchors.topMargin: 4
        anchors.rightMargin: 4

        spacing: 4

        Button {
            id: musicToggleButton
            checkable: true
            icon.source: checked ? "qrc:/images/music_on.svg" : "qrc:/images/music_off.svg"
        }

        Button {
            id: infoButton
            icon.source: "qrc:/images/info.svg"
        }
    }

    ProgressView {
        id: progressView
        width: 48
        height: 48

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
    }

    StatView {
        id: statView
        width: 240
        anchors.bottom: scene.top
        anchors.bottomMargin: 8
        anchors.horizontalCenter: scene.horizontalCenter
    }

    property int totalCompletedItems: 0
    property int totalMistakes: 0
    property int totalElapseTime: 0

    GameScene {
        id: scene
        anchors.centerIn: parent
        width: window.width * 0.9
        height: window.height * 0.25

        onChanged: (elapsedTime, mistakes, taskSize, completedItems) => {
            statView.accuracy = Math.round(100 * (1.0 - (totalMistakes + mistakes) / (totalCompletedItems + completedItems)))
            statView.symbolsPerMinute = Math.floor(((totalCompletedItems + completedItems) / ((totalElapseTime + elapsedTime) / 1000 / 60)))
        }

        onFinished: (elapsedTime, mistakes, taskSize) => {
            totalMistakes += mistakes
            totalCompletedItems += taskSize
            totalElapseTime += elapsedTime
            scene.load(generate_text(['а', 'о', ' '], 30))
        }
    }
}
