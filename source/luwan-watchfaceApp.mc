import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;


var centerX = 0;        // 中心点 x坐标
var centerY = 0;        // 中心点 y坐标
var arcSpacing = 45;    // 圆弧角度
var r = 0;              // 半径
var fontPending = 5;    // 宽度
var arcPendWidth = 8;    // 宽度
var arcSpacingOffset = 10;  // 圆弧角度偏移量


class luwan_watchfaceApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new luwan_watch_faceView() ];
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() as Void {
        WatchUi.requestUpdate();
    }

}

function getApp() as luwan_watchfaceApp {
    return Application.getApp() as luwan_watchfaceApp;
}