//
// This file is part of the Marble Virtual Globe.
//
// This program is free software licensed under the GNU LGPL. You can
// find a copy of this license in LICENSE.txt in the top directory of
// the source code.
//
// Copyright 2015      Gábor Péterffy <peterffy95@gmail.com>
//


import QtQuick 2.3

Item {
    id: root

    property alias angle: rotation.angle
    property int posX: 0
    property int posY: 0
    property int radius: 0

    width: 100
    height: 100
    x: posX - width * 0.5
    y: posY - height * 0.5

    Rectangle {
         width: root.radius
         height: root.radius
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.top: parent.top
         color: "#40ff0000"
         border.color: "#ff0000"
         border.width: 2
         radius: width*0.5

         Image {
             id: image
             source: "qrc:///navigation_blue.png"
             width: 30
             height: 30
             anchors.centerIn: parent
             transform: Rotation {
                 id: rotation
                 origin {
                     x: image.width * 0.5
                     y: image.height * 0.5
                 }
             }
         }
    }
}
