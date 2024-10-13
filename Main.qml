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

    readonly property var ua_letters: ['а', 'о', 'л', 'в', 'м', 'и', 'н', 'т', 'р', 'к', 'е', 'с', 'у', 'і', 'й', 'п', 'д', 'з', 'б', 'г', 'ї', 'ж', 'х', 'є', 'ч', 'щ', 'ш', 'ґ', 'ф', 'ю', 'ц', 'ь', 'я']
    property int level: 2

    function generate_text(symbols, length) {
        var result = ''
        for(let i = 0; i < length; ++i) {
            result += symbols[Math.floor(Math.random() * symbols.length)]
        }
        return result
    }

    Component.onCompleted: {
        scene.load(generate_text(makeTask(), 30))
    }

    function makeTask() {
        var letters = ua_letters.slice(0, window.level)
        letters.push(' ')

        return letters
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

    StatView {
        id: statView
        width: 240
        anchors.bottom: scene.top
        anchors.bottomMargin: -1
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

            if (statView.symbolsPerMinute > 90 && statView.accuracy > 80) {
                window.level++
                window.level = Math.min(Math.max(2, window.level), window.ua_letters.length - 1)
            }

            scene.load(generate_text(makeTask(), 30))
        }
    }
}
