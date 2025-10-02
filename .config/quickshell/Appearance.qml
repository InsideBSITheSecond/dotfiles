pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell

Singleton {
    id: root
    property QtObject m3colors
    property QtObject animation
    property QtObject animationCurves
    property QtObject colors
    property QtObject rounding
    property QtObject font
    property QtObject sizes

    property real transparency: 0
    property real contentTransparency: 0.1
    property real workpaceTransparency: 0.8

    m3colors: QtObject {
        property bool darkmode: true
        property bool transparent: false

        // Core surface colors
        property color m3background: "#1a1110"
        property color m3onBackground: "#f1dedc"
        property color m3surface: "#1a1110"
        property color m3onSurface: "#f1dedc"
        property color m3surfaceVariant: "#534341"
        property color m3onSurfaceVariant: "#d8c2bf"

        // Surface container colors
        property color m3surfaceContainer: "#271d1c"
        property color m3surfaceContainerLow: "#231918"
        property color m3surfaceContainerLowest: "#140c0b"
        property color m3surfaceContainerHigh: "#322826"
        property color m3surfaceContainerHighest: "#3d3231"

        // Primary colors
        property color m3primary: "#ffb3ac"
        property color m3onPrimary: "#571e1a"
        property color m3primaryContainer: "#73332f"
        property color m3onPrimaryContainer: "#ffdad6"
        property color m3primaryFixed: "#ffdad6"
        property color m3primaryFixedDim: "#ffb3ac"
        property color m3onPrimaryFixed: "#3b0908"
        property color m3onPrimaryFixedVariant: "#73332f"

        // Secondary colors
        property color m3secondary: "#e7bdb8"
        property color m3onSecondary: "#442927"
        property color m3secondaryContainer: "#5d3f3c"
        property color m3onSecondaryContainer: "#ffdad6"
        property color m3secondaryFixed: "#ffdad6"
        property color m3secondaryFixedDim: "#e7bdb8"
        property color m3onSecondaryFixed: "#2c1513"
        property color m3onSecondaryFixedVariant: "#5d3f3c"

        // Tertiary colors
        property color m3tertiary: "#e1c38c"
        property color m3onTertiary: "#3f2d04"
        property color m3tertiaryContainer: "#584419"
        property color m3onTertiaryContainer: "#fedea6"
        property color m3tertiaryFixed: "#fedea6"
        property color m3tertiaryFixedDim: "#e1c38c"
        property color m3onTertiaryFixed: "#261900"
        property color m3onTertiaryFixedVariant: "#584419"

        // Error colors
        property color m3error: "#ffb4ab"
        property color m3onError: "#690005"
        property color m3errorContainer: "#93000a"
        property color m3onErrorContainer: "#ffdad6"

        // Outline colors
        property color m3outline: "#a08c8a"
        property color m3outlineVariant: "#534341"

        // Special colors
        property color m3shadow: "#000000"
        property color m3scrim: "#000000"
        property color m3inverseSurface: "#f1dedc"
        property color m3onInverseSurface: "#392e2d"
        property color m3inversePrimary: "#904a44"
        property color m3surfaceTint: "#ffb3ac"

        // Legacy mappings for backward compatibility
        property color m3primaryText: m3onBackground
        property color m3layerBackground1: m3surface
        property color m3layerBackground2: m3surfaceContainerLow
        property color m3layerBackground3: m3surfaceContainer
        property color m3surfaceText: m3onSurface
        property color m3secondaryText: m3onSurfaceVariant
        property color m3borderPrimary: m3primary
        property color m3shadowColor: m3shadow
        property color m3accentPrimary: m3primary
        property color m3accentSecondary: m3secondary
        property color m3selectionBackground: m3surfaceVariant
        property color m3accentPrimaryText: m3onPrimary
        property color m3selectionText: m3onSurfaceVariant
        property color m3borderSecondary: m3outlineVariant
        property color colTooltip: m3inverseSurface
        property color colOnTooltip: m3onInverseSurface
    }

    colors: QtObject {
        property color colSubtext: m3colors.m3outline
        property color colLayer0: ColorUtils.transparentize(m3colors.m3background, root.transparency)
        property color colOnLayer0: m3colors.m3onBackground
        property color colLayer0Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer0, colOnLayer0, 0.9, root.contentTransparency))
        property color colLayer0Active: ColorUtils.transparentize(ColorUtils.mix(colLayer0, colOnLayer0, 0.8, root.contentTransparency))
        property color colLayer1: ColorUtils.transparentize(ColorUtils.mix(m3colors.m3surfaceContainerLow, m3colors.m3background, 0.8), root.contentTransparency)
        property color colOnLayer1: m3colors.m3onSurfaceVariant
        property color colOnLayer1Inactive: ColorUtils.mix(colOnLayer1, colLayer1, 0.45)
        property color colLayer2: ColorUtils.transparentize(ColorUtils.mix(m3colors.m3surfaceContainer, m3colors.m3surfaceContainerHigh, 0.1), root.contentTransparency)
        property color colOnLayer2: m3colors.m3onSurface
        property color colOnLayer2Disabled: ColorUtils.mix(colOnLayer2, m3colors.m3background, 0.4)
        property color colLayer3: ColorUtils.transparentize(ColorUtils.mix(m3colors.m3surfaceContainerHigh, m3colors.m3onSurface, 0.96), root.contentTransparency)
        property color colOnLayer3: m3colors.m3onSurface
        property color colLayer1Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer1, colOnLayer1, 0.92), root.contentTransparency)
        property color colLayer1Active: ColorUtils.transparentize(ColorUtils.mix(colLayer1, colOnLayer1, 0.85), root.contentTransparency)
        property color colLayer2Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer2, colOnLayer2, 0.90), root.contentTransparency)
        property color colLayer2Active: ColorUtils.transparentize(ColorUtils.mix(colLayer2, colOnLayer2, 0.80), root.contentTransparency)
        property color colLayer2Disabled: ColorUtils.transparentize(ColorUtils.mix(colLayer2, m3colors.m3background, 0.8), root.contentTransparency)
        property color colLayer3Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer3, colOnLayer3, 0.90), root.contentTransparency)
        property color colLayer3Active: ColorUtils.transparentize(ColorUtils.mix(colLayer3, colOnLayer3, 0.80), root.contentTransparency)
        property color colPrimary: m3colors.m3primary
        property color colOnPrimary: m3colors.m3onPrimary
        property color colPrimaryHover: ColorUtils.mix(colors.colPrimary, colLayer1Hover, 0.87)
        property color colPrimaryActive: ColorUtils.mix(colors.colPrimary, colLayer1Active, 0.7)
        property color colPrimaryContainer: m3colors.m3primaryContainer
        property color colPrimaryContainerHover: ColorUtils.mix(colors.colPrimaryContainer, colLayer1Hover, 0.7)
        property color colPrimaryContainerActive: ColorUtils.mix(colors.colPrimaryContainer, colLayer1Active, 0.6)
        property color colOnPrimaryContainer: m3colors.m3onPrimaryContainer
        property color colSecondary: m3colors.m3secondary
        property color colSecondaryHover: ColorUtils.mix(m3colors.m3secondary, colLayer1Hover, 0.85)
        property color colSecondaryActive: ColorUtils.mix(m3colors.m3secondary, colLayer1Active, 0.4)
        property color colSecondaryContainer: m3colors.m3secondaryContainer
        property color colSecondaryContainerHover: ColorUtils.mix(m3colors.m3secondaryContainer, colLayer1Hover, 0.6)
        property color colSecondaryContainerActive: ColorUtils.mix(m3colors.m3secondaryContainer, colLayer1Active, 0.54)
        property color colOnSecondaryContainer: m3colors.m3onSecondaryContainer
        property color colSurfaceContainerLow: ColorUtils.transparentize(m3colors.m3surfaceContainerLow, root.contentTransparency)
        property color colSurfaceContainer: ColorUtils.transparentize(m3colors.m3surfaceContainer, root.contentTransparency)
        property color colSurfaceContainerHigh: ColorUtils.transparentize(m3colors.m3surfaceContainerHigh, root.contentTransparency)
        property color colSurfaceContainerHighest: ColorUtils.transparentize(m3colors.m3surfaceContainerHighest, root.contentTransparency)
        property color colSurfaceContainerHighestHover: ColorUtils.mix(m3colors.m3surfaceContainerHighest, m3colors.m3onSurface, 0.95)
        property color colSurfaceContainerHighestActive: ColorUtils.mix(m3colors.m3surfaceContainerHighest, m3colors.m3onSurface, 0.85)
        property color colTooltip: m3colors.m3inverseSurface
        property color colOnTooltip: m3colors.m3inverseOnSurface
        property color colScrim: ColorUtils.transparentize(m3colors.m3scrim, 0.5)
        property color colShadow: ColorUtils.transparentize(m3colors.m3shadow, 0.7)
        property color colOutlineVariant: m3colors.m3outlineVariant
    }

    rounding: QtObject {
        property int unsharpen: 0
        property int verysmall: 3
        property int small: 5
        property int normal: 15
        property int large: 23
        property int verylarge: 25
        property int veryverylarge: 50
        property int full: 99
        property int screenRounding: 8
    }

    font: QtObject {
        property QtObject family: QtObject {
            property string uiFont: "Rubik"
            property string iconFont: "SymbolsNerdFont"
            property string codeFont: "JetBrains Mono NF"
            property string uiBigFont: "Gabarito"

            property string normal: uiFont
        }
        property QtObject pixelSize: QtObject {
            property int textSmall: 13
            property int textBase: 15
            property int textMedium: 16
            property int textLarge: 19
            property int iconLarge: 22
        }
    }

    animationCurves: QtObject {
        readonly property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.90, 1, 1] // Default, 350ms
        readonly property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1.00, 1, 1] // Default, 500ms
        readonly property list<real> expressiveSlowSpatial: [0.39, 1.29, 0.35, 0.98, 1, 1] // Default, 650ms
        readonly property list<real> expressiveEffects: [0.34, 0.80, 0.34, 1.00, 1, 1] // Default, 200ms
        readonly property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
        readonly property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
        readonly property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
        readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
        readonly property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
        readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
    }

    animation: QtObject {
        property QtObject elementMove: QtObject {
            property int duration: 500
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.expressiveDefaultSpatial
            property int velocity: 650
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animation.elementMove.duration
                    easing.type: root.animation.elementMove.type
                    easing.bezierCurve: root.animation.elementMove.bezierCurve
                }
            }
            property Component colorAnimation: Component {
                ColorAnimation {
                    duration: root.animation.elementMove.duration
                    easing.type: root.animation.elementMove.type
                    easing.bezierCurve: root.animation.elementMove.bezierCurve
                }
            }
        }
        property QtObject elementMoveEnter: QtObject {
            property int duration: 400
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.emphasizedDecel
            property int velocity: 650
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animation.elementMoveEnter.duration
                    easing.type: root.animation.elementMoveEnter.type
                    easing.bezierCurve: root.animation.elementMoveEnter.bezierCurve
                }
            }
        }
        property QtObject elementMoveExit: QtObject {
            property int duration: 200
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.emphasizedAccel
            property int velocity: 650
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animation.elementMoveExit.duration
                    easing.type: root.animation.elementMoveExit.type
                    easing.bezierCurve: root.animation.elementMoveExit.bezierCurve
                }
            }
        }
        property QtObject elementMoveFast: QtObject {
            property int duration: 200
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.expressiveEffects
            property int velocity: 850
            property Component colorAnimation: Component {
                ColorAnimation {
                    duration: root.animation.elementMoveFast.duration
                    easing.type: root.animation.elementMoveFast.type
                    easing.bezierCurve: root.animation.elementMoveFast.bezierCurve
                }
            }
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animation.elementMoveFast.duration
                    easing.type: root.animation.elementMoveFast.type
                    easing.bezierCurve: root.animation.elementMoveFast.bezierCurve
                }
            }
        }

        property QtObject clickBounce: QtObject {
            property int duration: 200
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.expressiveFastSpatial
            property int velocity: 850
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animation.clickBounce.duration
                    easing.type: root.animation.clickBounce.type
                    easing.bezierCurve: root.animation.clickBounce.bezierCurve
                }
            }
        }
        property QtObject scroll: QtObject {
            property int duration: 400
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.standardDecel
        }
        property QtObject menuDecel: QtObject {
            property int duration: 350
            property int type: Easing.OutExpo
        }
    }

    sizes: QtObject {
        property real barWidth: 44
        property real sidebarWidth: 460
        property real dashboardWidth: 460
        property real sidebarWidthExtended: 750
        property real osdWidth: 200
        property real mediaControlsWidth: 478
        property real mediaControlsHeight: 150
        property real notificationPopupWidth: 410
        property real searchWidthCollapsed: 260
        property real searchWidth: 450
        property real hyprlandGapsOut: 2
        property real elevationMargin: 10
        property real fabShadowRadius: 5
        property real fabHoveredShadowRadius: 7
    }
}
