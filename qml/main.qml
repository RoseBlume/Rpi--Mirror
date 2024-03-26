import QtWebEngine 6.4
import QtQuick 6.6
import QtQuick.Window 6.6
import QtQuick.Controls 6.6
import "qrc:/qml/plugs" 1.0
//import MyQmlSingleton 1.0
//import io.qt.examples.backend 1.0
Window {
    id: window
    title: qsTr("Mirror")
    visibility: Window.FullScreen
    MouseArea {
        id: bar1
        height: parent.height * 0.05
        width:128
        Text{
            id:buttonarea
            width:parent.width
            height:parent.height
            text:"Plugins"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        onPressed: {
            if (boxes.visible == true) {
                boxes.visible = false
            }
            else {
                boxes.visible = true
            }
        }
    }
    Rectangle {
        id:boxes
        z: 1
        width: parent.width
        height:parent.height * 0.95
        y: parent.height * 0.05
        WebEngineView {
            id:tab1
            url: "qrc:/Plugins/Info/index.html"
            anchors.fill: parent
        }
    }
    Plugins {
        id:plugmodel
    }
    Listviewer {

    }
    Component.onCompleted:{
        width = Screen.width
        height = Screen.height
        visibility = "FullScreen"
        visible = true
    }
}
