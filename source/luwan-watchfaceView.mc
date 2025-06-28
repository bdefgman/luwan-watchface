import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

using Toybox.System as Sys;
using Toybox.Time.Gregorian as Date;

class luwan_watch_faceView extends WatchUi.WatchFace {


    var luwan_draw;

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
        // 取x与y的中心点
        centerX = dc.getWidth() / 2;
        centerY = dc.getHeight() / 2;
        r = 0.95*centerX;


        // 画下四周的圆弧
        drawArcPenWidth(dc);
        

        System.println("centerX:" + centerX);
        System.println("centerY:" + centerY);


        // drawLine(dc);
        // drawArc(dc);
        drawLine(dc);
        // drawCicle(dc);
        


        var luwanPic = WatchUi.loadResource(Rez.Drawables.luwanJPG);
        dc.drawBitmap(centerX-50,centerY-50,luwanPic);

        textIcon(dc, centerX-30, centerY-20, "s");

    }

    function textIcon(dc, x, y, string) as Void {
        var font = WatchUi.loadResource(Rez.Fonts.IconsFont);
        dc.drawText(x, y, font, string, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
  }


    public function drawArcPenWidth(dc as Dc) {
        dc.setColor(Graphics.COLOR_DK_GRAY,Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(arcPendWidth);
        // 上
        dc.drawArc(centerX,centerY,r,Graphics.ARC_COUNTER_CLOCKWISE,arcSpacing + arcSpacingOffset,90 + arcSpacing - arcSpacingOffset);
        // 左
        dc.drawArc(centerX,centerY,r,Graphics.ARC_COUNTER_CLOCKWISE,90 + arcSpacing + arcSpacingOffset,180 + arcSpacing - arcSpacingOffset);
        // 下
        dc.drawArc(centerX,centerY,r,Graphics.ARC_COUNTER_CLOCKWISE,180 + arcSpacing + arcSpacingOffset,270 + arcSpacing - arcSpacingOffset);
        // 右
        dc.drawArc(centerX,centerY,r,Graphics.ARC_COUNTER_CLOCKWISE,270 + arcSpacing + arcSpacingOffset,360 + arcSpacing - arcSpacingOffset);
    
        // var radians = Math.toRadians(arcSpacing);
        // Sys.println("radians:"+radians);
        // var high = Math.sin(radians) * r;
        // var smallDigitalFont = WatchUi.loadResource(Rez.Fonts.xbigdigigarmin);
        // dc.drawText(centerX + r - fontPending,centerY+high/2,smallDigitalFont,"0",Graphics.TEXT_JUSTIFY_CENTER);
        // dc.drawText(0,0,smallDigitalFont,"100",Graphics.TEXT_JUSTIFY_CENTER);

    }


    public function drawLine(dc as Dc) as Void {
        dc.setPenWidth(2);

        var radiansUtils = new RadiansUtils();
        // 右上角的 x、y 坐标值
        var topDegress = radiansUtils.degreesToRadians(-45);
        var upperRightX = radiansUtils.convertCoorX(topDegress,r);
        var upperRightY = radiansUtils.convertCoorY(topDegress,r);
        // 左上角的 x、y 坐标值
        var upperLeftAngle = radiansUtils.degreesToRadians(-135);
        var upperLeftX = radiansUtils.convertCoorX(upperLeftAngle,r);
        var upperLeftY = radiansUtils.convertCoorY(upperLeftAngle,r);
        // 右下角的 x、y 坐标值
        var lowerRightAngle = radiansUtils.degreesToRadians(45);
        var lowerRightX = radiansUtils.convertCoorX(lowerRightAngle,r);
        var lowerRightY = radiansUtils.convertCoorY(lowerRightAngle,r);
        // 左下角的 x、y 坐标值
        var lowerLeftAngle = radiansUtils.degreesToRadians(135);
        var lowerLeftX = radiansUtils.convertCoorX(lowerLeftAngle,r);
        var lowerLeftY = radiansUtils.convertCoorY(lowerLeftAngle,r);

        // x、y 的中间点偏移量
        var centerYOffset = (centerY - upperLeftY) / 2;
        var centerXOffset = (centerX - upperLeftX) / 2;

        // 左 上中点的 x、y 坐标值
        var leftUpperCenterX = upperLeftX;
        var leftUpperCenterY = upperLeftY + centerYOffset;
        // 右 上中点的 x、y 坐标值
        var rightUpperCenterX = upperRightX;
        var rightUpperCenterY = upperRightY + centerYOffset;

        // 左 下中点的 x、y 坐标值
        var leftLowerCenterX = upperLeftX;
        var leftLowerCenterY = centerY + centerYOffset;
        // 右 下中点的 x、y 坐标值
        var rightLowerCenterX = upperRightX;
        var rightLowerCenterY = leftLowerCenterY;

        // 上 左中点的 x、y 坐标值
        var upperLeftCenterX = centerX - centerXOffset;
        var upperLeftCenterY = upperLeftY;
        // 下 左中点的 x、y 坐标值
        var lowerLeftCenterX = upperLeftCenterX;
        var lowerLeftCenterY = lowerLeftY;

        // 上 右中的 x、y 坐标值
        var upperRightCenterX = centerX + centerXOffset;
        var upperRightCenterY = upperRightY;
        // 下 右中的 x、y 坐标值
        var lowerRightCenterX = upperRightCenterX;
        var lowerRightCenterY = lowerRightY;



        // 中水平线
        dc.drawLine(upperLeftX, centerY, upperRightX, centerY);
        // 中垂直线
        dc.drawLine(centerX, upperRightY-centerYOffset, centerX, lowerRightY);
        // 上水平线
        dc.drawLine(upperRightX,upperRightY,upperLeftX,upperLeftY);
        // 下水平线
        dc.drawLine(lowerRightX,lowerRightY,lowerLeftX,lowerLeftY);
        // 右垂直线
        dc.drawLine(upperRightX,upperRightY,lowerRightX,lowerRightY);
        // 左垂直线
        dc.drawLine(upperLeftX,upperLeftY,lowerLeftX,lowerLeftY);
        // 上与中水平线
        dc.drawLine(leftUpperCenterX,leftUpperCenterY,rightUpperCenterX,rightUpperCenterY);
        // 中与下水平线
        dc.drawLine(leftLowerCenterX,leftLowerCenterY,rightLowerCenterX,rightLowerCenterY);
        // 左与中垂直线
        dc.drawLine(upperLeftCenterX,upperLeftCenterY,lowerLeftCenterX,lowerLeftCenterY);
        // 右与中垂直线
        dc.drawLine(upperRightCenterX,upperRightCenterY,lowerRightCenterX,lowerRightCenterY);


        Sys.println("r:"+r+"centerXOffset:"+centerXOffset+",centerYOffset:"+centerYOffset);


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

    public function drawText(dc as Dc) {
        // var smallDigitalFont = WatchUi.loadResource(Rez.Fonts.smadigi);
        // dc.drawText(centerX,centerY,smallDigitalFont,"QWER",Graphics.TEXT_JUSTIFY_CENTER);
    }

    public function dtrawIcon(dc as Dc) {
        // var weatherFont = WatchUi.loadResource(Rez.Fonts.weather);
        // var icon = "";
        // dc.drawText(centerX, centerY+50, weatherFont,icon, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    		
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
