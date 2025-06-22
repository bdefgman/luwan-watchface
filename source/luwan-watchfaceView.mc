import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

using Toybox.System as Sys;
using Toybox.Time.Gregorian as Date;

class luwan_watch_faceView extends WatchUi.WatchFace {


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

        dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
        
        // 取x与y的中心点
        centerX = dc.getWidth() / 2;
        centerY = dc.getHeight() / 2;
        System.println("centerX:" + centerX);
        System.println("centerY:" + centerY);
        dc.setPenWidth(1);


        // drawLine(dc);
        // drawArc(dc);
        drawLine(dc);
        drawCicle(dc);
        
        dc.setColor(Graphics.COLOR_DK_GRAY,Graphics.COLOR_TRANSPARENT);
        dc.drawLine(0, centerY, dc.getWidth()*0.2, centerY); // 水平线

        // 画图 还没画好
        var luwanPic = WatchUi.loadResource(Rez.Drawables.luwanJPG);
        dc.drawBitmap(centerX-50,centerY-50,luwanPic);

        

    }

    public function drawLine(dc as Dc) as Void {
        // 绘制圆弧
        // 绘制十字线标记中心
        dc.drawLine(0, centerY, dc.getWidth(), centerY); // 水平线
        dc.drawLine(centerX, 0, centerX, dc.getHeight()); // 垂直线
    }

    public function drawArc(dc as Dc) as Void {
        dc.drawArc(centerX,centerY,0.8*centerX,Graphics.ARC_COUNTER_CLOCKWISE,0,360);
    }

    public function drawCicle(dc as Dc) as Void {
        dc.drawCircle(centerX,centerY,70);
    }

    public function drawRadialText(dc as Dc) as Void {
        var font = Graphics.getVectorFont({
                :face => ["RobotoCondensedBold"],
                :size => 26.0
        });
        // dc.drawRadialText(centerX,centerY,font,"test",Graphics.TEXT_JUSTIFY_LEFT,30,0.8*centerX,Graphics.RADIAL_TEXT_DIRECTION_COUNTER_CLOCKWISE); // 反方向
        dc.drawRadialText(centerX,centerY,font,"test",Graphics.TEXT_JUSTIFY_CENTER,90,0.8*centerX,Graphics.RADIAL_TEXT_DIRECTION_CLOCKWISE);  // 正方向

    }

    public function drawText(dc as Dc) as Void {
        var smallDigitalFont = WatchUi.loadResource(Rez.Fonts.smadigi);
        dc.drawText(centerX,centerY,smallDigitalFont,"QWER",Graphics.TEXT_JUSTIFY_CENTER);

    }

    public function dtrawIcon(dc as Dc) {
        var weatherFont = WatchUi.loadResource(Rez.Fonts.weather);
        var icon = "";
        dc.drawText(centerX, centerY+50, weatherFont,icon, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    		
    }

    public function drawBitMap2(dc as Dc) {
                // var ico_charge = WatchUi.loadResource(Rez.Drawables.id_charge);
        // // 1. 正确创建缓冲位图（示例：100x100像素）
        // // var tickBuffer = Graphics.createBufferedBitmap({:bitmapX=>0, :bitmapY=>0,});

        // // 2. 定义变换矩阵（示例：旋转10度）
        // // var transformMatrix = new Graphics.AffineTransform();
        // var redShiftColor = 0xAA0000;
        // // 3. 绘制位图并补充必要参数
        // dc.drawBitmap2(
        //     centerX,                // 目标绘制位置的左上角x坐标
        //     centerY,                // 目标绘制位置的左上角y坐标
        //     ico_charge,             // 位图对象
        //     {
        //         // :bitmapX => 0,       // 源位图区域左上角x坐标（默认0）
        //         // :bitmapY => 0,        // 源位图区域左上角y坐标（默认0）
        //         // :bitmapWidth => 100, // 源位图区域宽度（默认位图实际宽度）
        //         // :bitmapHeight => 100,// 源位图区域高度（默认位图实际高度）
        //         // :tintColor => Graphics.COLOR_WHITE, // 可选：位图着色
        //         // :filterMode => Graphics.FILTER_MODE_BILINEAR, // 双线性滤波
        //         // :transform => transformMatrix // 变换矩阵
        //         :tintColor => redShiftColor
        //     }
        // );
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
