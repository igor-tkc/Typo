import QtQuick
import QtQuick.Controls

Window {
    id: window

    width: 1260
    height: 400
    visible: true
    color: "whitesmoke"
    title: qsTr("Typo")

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
