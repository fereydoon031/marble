//
// This file is part of the Marble Virtual Globe.
//
// This program is free software licensed under the GNU LGPL. You can
// find a copy of this license in LICENSE.txt in the top directory of
// the source code.
//
// Copyright 2015      Dennis Nienhüser <nienhueser@kde.org>
//

import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

import org.kde.marble 0.20

Item {
    id: root

    property var placemark: null
    property variant map
    property alias showOsmTags: tagsView.visible
    property bool showAccessibility: false

    height: placemark === null ? 0 : Screen.pixelDensity * 4 +infoLayout.height


    SystemPalette {
        id: palette
        colorGroup: SystemPalette.Active
    }

    Rectangle {
        anchors.fill: parent
        color: palette.base
    }

    Bookmarks {
        id: bookmarks
    }

    onMapChanged: bookmarks.map = root.map


    Column {
        id: infoLayout
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: Screen.pixelDensity * 2
        }

        IconText {
            id: name
            width: parent.width
            visible: text.length > 0
            text: placemark === null ? "" : placemark.name
            maximumLineCount: 2
            font.pointSize: 20
        }

        IconText {
            width: parent.width
            visible: text.length > 0
            text: placemark === null ? "" : placemark.description
        }

        IconText {
            width: parent.width
            visible: text.length > 0
            text: placemark === null ? "" : placemark.address
            maximumLineCount: 4
        }

        IconText {
            width: parent.width
            visible: routesItem.count > 0
            text: "<a href=\"#\">Part of " + routesItem.count + " routes</a>"
            maximumLineCount: 4
            linkColor: palette.text
            onLinkActivated: routesDialog.open()
        }

        IconText {
            width: parent.width
            visible: url.length > 0
            property string url: placemark === null ? "" : placemark.website
            text: "<a href=\"" + url + "\">" + url + "</a>"
            icon: "qrc:/material/browser.svg"
            maximumLineCount: 4
            onLinkActivated: Qt.openUrlExternally(link)
        }

        IconText {
            width: parent.width
            visible: phone.length > 0
            property string phone: placemark === null ? "" : placemark.phone
            text: "<a href=\"tel:" + phone + "\">" + phone + "</a>"
            icon: "qrc:/material/phone.svg"
            maximumLineCount: 1
            onLinkActivated: Qt.openUrlExternally(link)
        }

        IconText {
            width: parent.width
            visible: url.length > 0
            property string url: placemark === null ? "" : placemark.wikipedia
            text:  "<a href=\"" + url + "\">Wikipedia</a>"
            icon: "qrc:/material/browser.svg"
            maximumLineCount: 4
            onLinkActivated: Qt.openUrlExternally(link)
        }

        IconText {
            width: parent.width
            visible: text.length > 0
            text: placemark === null ? "" : placemark.openingHours
            icon: "qrc:/material/access_time.svg"
        }

        IconText {
            width: parent.width
            visible: root.showAccessibility && text.length > 0
            text: placemark === null ? "" : placemark.wheelchairInfo
            icon: "qrc:/material/wheelchair.svg"
        }

        IconText {
            width: parent.width
            visible: text.length > 0
            text: placemark === null ? "" : placemark.wifiAvailable
            icon: "qrc:/material/wlan-available.svg"
        }

        IconText {
            width: parent.width
            visible: text.length > 0
            text: placemark === null ? "" : "<a href=\"#\"#>" + placemark.coordinates + "</a>"
            icon: "qrc:/material/place.svg"
            linkColor: palette.text
            onLinkActivated: marbleMaps.centerOnCoordinates(placemark.longitude, placemark.latitude)
        }

        ListView {
            id: tagsView
            visible: false
            width: parent.width
            height: Math.min(contentHeight, Screen.pixelDensity * 24)
            clip: true
            model: placemark ? placemark.tags : undefined
            delegate: IconText {
                width: tagsView.width;
                icon: "qrc:/material/label.svg"
                text: modelData
            }

            ScrollBar.vertical: ScrollBar {}
        }
    }


    Dialog {
        id: routesDialog
        title: qsTr("Routes")
        RoutesItem {
            id: routesItem
            implicitWidth: parent.width
            model: placemark === null ? undefined : placemark.routeRelationModel
            onHighlightChanged: map.highlightRouteRelation(oid, enabled)
        }
    }
}
