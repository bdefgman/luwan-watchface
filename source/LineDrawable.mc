using Toybox.WatchUi;
using Toybox.Math;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Application;

class LineDrawable extends WatchUi.View  {

    var line;

    public function initialize() {
        View.initialize();
        line = new Rez.Drawables.Smiley();


    }

    function onUpdate(dc as Graphics.Dc) as Void {
        line.draw( dc );   
    }

}