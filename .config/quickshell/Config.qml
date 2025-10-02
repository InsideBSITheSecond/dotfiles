pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string filePath: Directories.shellConfigPath
    property alias options: configOptionsJsonAdapter

    function setNestedValue(nestedKey, value) {
        let keys = nestedKey.split(".");
        let obj = root.options;
        let parents = [obj];

        // Traverse and collect parent objects
        for (let i = 0; i < keys.length - 1; ++i) {
            if (!obj[keys[i]] || typeof obj[keys[i]] !== "object") {
                obj[keys[i]] = {};
            }
            obj = obj[keys[i]];
            parents.push(obj);
        }

        // Convert value to correct type using JSON.parse when safe
        let convertedValue = value;
        if (typeof value === "string") {
            let trimmed = value.trim();
            if (trimmed === "true" || trimmed === "false" || !isNaN(Number(trimmed))) {
                try {
                    convertedValue = JSON.parse(trimmed);
                } catch (e) {
                    convertedValue = value;
                }
            }
        }

        obj[keys[keys.length - 1]] = convertedValue;
    }

    FileView {
        path: root.filePath

        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()
        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                writeAdapter();
            }
        }

        JsonAdapter {
            id: configOptionsJsonAdapter
            property JsonObject policies: JsonObject {
                property int ai: 1 // 0: No | 1: Yes | 2: Local
            }

            property JsonObject ai: JsonObject {
                property string systemPrompt: qsTr("You are gemini, googles ai chat bot. you are in the custom built DE of frosted built on top of hyprland")
            }

            property JsonObject appearance: JsonObject {
                property bool transparency: false
                property int opacity: 50
                property JsonObject palette: JsonObject {
                    property string type: "auto" // Allowed: auto, scheme-content, scheme-expressive, scheme-fidelity, scheme-fruit-salad, scheme-monochrome, scheme-neutral, scheme-rainbow, scheme-tonal-spot
                }
            }

            property JsonObject audio: JsonObject {
                // Values in %
                property JsonObject protection: JsonObject {
                    // Prevent sudden bangs
                    property bool enable: true
                    property real maxAllowedIncrease: 10
                    property real maxAllowed: 100 // Realistically should already provide some protection when it's 99...
                }
            }

            property JsonObject apps: JsonObject {
                property string bluetooth: "kcmshell6 kcm_bluetooth"
                property string imageViewer: "loupe"
                property string network: "plasmawindowed org.kde.plasma.networkmanagement"
                property string networkEthernet: "kcmshell6 kcm_networkmanagement"
                property string settings: "systemsettings"
                property string taskManager: "plasma-systemmonitor --page-name Processes"
                property string terminal: "foot"
            }

            property JsonObject battery: JsonObject {
                property int low: 20
                property int critical: 5
                property int suspend: 2
                property bool sound: true //Added for Battery Sound Toggle
            }

            property JsonObject bar: JsonObject {
                property bool bottom: false // Instead of top
                property bool background: false
                property bool borderless: false // true for no grouping of items
                property bool verbose: true
                property bool vertical: true
                property bool hug: true
                property bool showBackground: true
                property list<string> screenList: [] // List of names, like "eDP-1", find out with 'hyprctl monitors' command
                property JsonObject workspaces: JsonObject {
                    property int shown: 10
                    property bool showAppIcons: true
                    property bool alwaysShowNumbers: false
                    property int showNumberDelay: 100 // milliseconds
                }

                property JsonObject tray: JsonObject {
                    property bool monochromeIcons: true
                    property bool invertPinnedItems: false // Makes the below a whitelist for the tray and blacklist for the pinned area
                    property list<string> pinnedItems: ["vesktop"]
                }

                property JsonObject autoHide: JsonObject {
                    property bool enable: false
                    property bool pushWindows: false
                    property JsonObject showWhenPressingSuper: JsonObject {
                        property bool enable: true
                        property int delay: 140
                    }
                }
            }

            property JsonObject background: JsonObject {
                property bool enableClock: true // Whether to show the clock
                property string clockMode: "light" // "dark" or "light"
                property real clockX: 0
                property real clockY: 0
                property bool fixedClockPosition: true // If true, clock position is not updated when the screen resolution changes
                property bool showWatermark: true // Whether to show the watermark
                property string wallpaperPath: "/usr/share/sleex/wallpapers/SleexOne.png"
                property string clockFontFamily: "Rubik"
            }

            property JsonObject dock: JsonObject {
                property bool enabled: true
                property real height: 60
                property real hoverRegionHeight: 8
                property bool pinnedOnStartup: false
                property bool hoverToReveal: true // When false, only reveals on empty workspace
                property list<string> pinnedApps: [ // IDs of pinned entries
                    "dolphin", "kitty",]
            }

            property JsonObject networking: JsonObject {
                property string userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36"
            }

            property JsonObject osd: JsonObject {
                property int timeout: 1000
            }

            property JsonObject overview: JsonObject {
                property real scale: 0.18 // Relative to screen size
                property real numOfRows: 1
                property real numOfCols: 5
                property bool showXwaylandIndicator: true
            }

            property JsonObject resources: JsonObject {
                property int updateInterval: 3000
            }

            property JsonObject search: JsonObject {
                property int nonAppResultDelay: 30 // This prevents lagging when typing
                property string engineBaseUrl: "https://www.google.com/search?q="
                property list<string> excludedSites: ["quora.com"]
                property bool sloppy: false // Uses levenshtein distance based scoring instead of fuzzy sort. Very weird.
                property JsonObject prefix: JsonObject {
                    property string action: "/"
                    property string clipboard: ";"
                    property string emojis: ":"
                }
            }

            property JsonObject windows: JsonObject {
                property bool showTitlebar: true // Client-side decoration for shell apps
                property bool centerTitle: true
            }

            property JsonObject time: JsonObject {
                // https://doc.qt.io/qt-6/qtime.html#toString
                property string format: "hh:mm"
                property string dateFormat: "dddd, dd/MM"
            }

            property JsonObject hacks: JsonObject {
                property int arbitraryRaceConditionDelay: 20 // milliseconds
            }
        }
    }
}
