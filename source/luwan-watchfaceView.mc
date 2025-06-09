import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

using Toybox.System as Sys;
using Toybox.Time.Gregorian as Date;

class luwan_watch_faceView extends WatchUi.WatchFace {

    var timeUtils = new TimeUtils();

    var activityInfo = new ActivityInfo();

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }


    // Update the view
    function onUpdate(dc as Dc) as Void {

        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        

        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        var view = View.findDrawableById("TimeLabel") as Text;
        // view.setSize();
        view.setColor(Application.Properties.getValue("TimeLableColor") as Number);
        view.setText(timeString);


        var daysOfWeek = timeUtils.getDaysOfWeek();
        var daysOfWeekView = View.findDrawableById("DaysOfWeek") as Text;
        daysOfWeekView.setColor(Application.Properties.getValue("TimeLableColor") as Number);
        daysOfWeekView.setText(daysOfWeek);

        var day = timeUtils.getDayOfMonth();
        var dayview = View.findDrawableById("Day") as Text;
        dayview.setColor(Application.Properties.getValue("TimeLableColor") as Number);
        dayview.setText(day);

        // var windAndRain = View.findDrawableById("windAndRain") as Text;
        // windAndRain.setFont(Toybox.Graphics.FONT_TINY);
        // windAndRain.setJustification(Graphics.TEXT_JUSTIFY_CENTER);

        // var luwanWaitYou = View.findDrawableById("luwanWaitYou") as Text;
        // luwanWaitYou.setFont(Toybox.Graphics.FONT_TINY);
        // luwanWaitYou.setJustification(Graphics.TEXT_JUSTIFY_CENTER);


        var stepCountView = View.findDrawableById("StepCount") as Text;
        var curStep = "  " + activityInfo.getCurStep() + "                       ";
        stepCountView.setText(curStep);

        var distance = ActivityMonitor.getInfo().distance;
        Sys.print("distance :"+distance);

        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
