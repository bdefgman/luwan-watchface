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
        // 取x与y的中心点
        centerX = dc.getWidth() / 2;
        centerY = dc.getHeight() / 2;
        r = centerX;


        // 画下四周的圆弧
        drawArcPenWidth(dc);
        

        System.println("centerX:" + centerX + "centerY:"+centerY);

        dc.setColor(Graphics.COLOR_BLUE,Graphics.COLOR_BLUE);
        dc.fillRectangle(centerX,centerY,10,10);

        drawLine(dc);
        drawSecondScale(dc);
        drawDataField(dc);


        var luwanPic = WatchUi.loadResource(Rez.Drawables.luwanJPG);
        dc.drawBitmap(centerX-50,centerY-50,luwanPic);

        // var bluetooth = WatchUi.loadResource(Rez.Drawables.bluetooth);
        // dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_WHITE);
        // dc.drawBitmap(centerX-80,centerY-80,bluetooth);
    }

    public function drawDataField(dc as Dc) {
        var dataFieldInfo = new DataFieldInfo();

        // 绘制电池
        drawBattery(dc,dataFieldInfo);

        // 绘制蓝牙
        drawBluetoothConnection(dc);
        // 绘制步数

        
    }

    function drawBluetoothConnection(dc as Dc) {
        var dataFieldIcons = new DataFieldIcons();

        var bluetoothX = secondScaleLineLength + arcPendWidth + 10;
        var bluetoothY = centerY - 20;

        if (Sys.getDeviceSettings().phoneConnected){
            dc.setColor(Graphics.COLOR_BLUE,Graphics.COLOR_TRANSPARENT);
            dataFieldIcons.drawBluetoothConnection(dc,bluetoothX+10,bluetoothY,10);
        } else {
            dataFieldIcons.drawNoBluetoothConnection(dc,bluetoothX+10,bluetoothY,10);
        }

    }

    // 绘制电池
    function drawBattery(dc as Dc,dataFieldInfo){
        var dataFieldIcons = new DataFieldIcons();
        dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);

        var statsCharging = dataFieldInfo.getStatsCharging();
        var currentBattery = dataFieldInfo.getBattery();

        if (statsCharging) {
            dataFieldIcons.drawBatteryLoading(dc,centerX-20,secondScaleLineLength + arcPendWidth + 20 ,10);
        } else {
            if (currentBattery >= 90) {
                dataFieldIcons.drawBatteryFull(dc,centerX-20,secondScaleLineLength + arcPendWidth + 20 ,10);
            } else if (currentBattery > 30 && currentBattery < 90) {
                dataFieldIcons.drawBattery(dc,centerX-20,secondScaleLineLength + arcPendWidth + 20,10);
            } else if (currentBattery <= 30) {
                dataFieldIcons.drawBatteryLow(dc,centerX-20,secondScaleLineLength + arcPendWidth + 20 ,10);
            }
        }
    }

    function drawSecondScale(dc as Dc) {
        // 刻度数量
        var secondScale = 60;
        // 起始弧度
        var startDegress = 0;
        // 刻度值
        var secondValue = 15;

        // 刻度值字体
        var scaleFont = WatchUi.loadResource(Rez.Fonts.MeridiemFont);
        var radiansUtils = new RadiansUtils();
        for (var index = 0; index < secondScale; index++) {
            var scaleR = secondValue % 5 == 0 ? 0.98 * r : r;
            var radians = radiansUtils.degreesToRadians(startDegress);

            var outerRingX = radiansUtils.convertCoorX(radians,scaleR);
            var outerRingY = radiansUtils.convertCoorY(radians,scaleR);

            var interRingX = radiansUtils.convertCoorX(radians,scaleR-secondScaleLineLength);
            var interRingY = radiansUtils.convertCoorY(radians,scaleR-secondScaleLineLength);
            // 绘制刻度
            if(secondValue % 5 != 0){
                var lineScaleColor = Graphics.createColor(255,50,50,50);
                dc.setColor(lineScaleColor,Graphics.COLOR_TRANSPARENT);
                dc.drawLine(outerRingX,outerRingY,interRingX,interRingY);
            } else {
                // 绘制文本 
                if (Graphics.Dc has :getVectorFont){
                    drawSecondText(secondValue,radians,dc);
                } else {
                    var textX = (outerRingX + interRingX) / 2;
                    var textY = (outerRingY + interRingY) / 2 ;
                    dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
                    dc.drawText(textX,textY,scaleFont,secondValue,Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
                }
            }

              
            secondValue++;
            secondValue = secondValue > 60 ? secondValue % 60 : secondValue;
            startDegress += 6;
        }
    }



    public function drawSecondText(secondValue,angle,dc as Dc) as Void {
        var font = Graphics.getVectorFont({
                :face => ["RobotoCondensedBold"],
                :size => 10.0
        });
        // var font = WatchUi.loadResource(Rez.Fonts.IconsFont);
        // dc.drawRadialText(centerX,centerY,font,"test",Graphics.TEXT_JUSTIFY_LEFT,30,0.8*centerX,Graphics.RADIAL_TEXT_DIRECTION_COUNTER_CLOCKWISE); // 反方向
        dc.drawRadialText(centerX,centerY,font,secondValue.toString(),Graphics.TEXT_JUSTIFY_CENTER,angle,r,Graphics.RADIAL_TEXT_DIRECTION_CLOCKWISE);  // 正方向

    }



    function textIcon(dc, x, y, string) as Void {
        var font = WatchUi.loadResource(Rez.Fonts.IconsFont);
        dc.drawText(x, y, font, string, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
  }


    public function drawArcPenWidth(dc as Dc) {
        dc.setColor(Graphics.COLOR_DK_GRAY,Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(arcPendWidth);

        var arcR = r-secondScaleLineLength-arcPendWidth - 5;
        var upperStartAngle = arcSpacing + arcSpacingOffset;
        var upperEndAngle = 90 + arcSpacing - arcSpacingOffset;
        // 上
        dc.drawArc(centerX,centerY,arcR,Graphics.ARC_COUNTER_CLOCKWISE,upperStartAngle,upperEndAngle);
        // 左
        // dc.drawArc(centerX,centerY,r,Graphics.ARC_COUNTER_CLOCKWISE,90 + arcSpacing + arcSpacingOffset,180 + arcSpacing - arcSpacingOffset);
        // 下
        dc.drawArc(centerX,centerY,arcR,Graphics.ARC_COUNTER_CLOCKWISE,180 + arcSpacing + arcSpacingOffset,270 + arcSpacing - arcSpacingOffset);
        // 右
        // dc.drawArc(centerX,centerY,r,Graphics.ARC_COUNTER_CLOCKWISE,270 + arcSpacing + arcSpacingOffset,360 + arcSpacing - arcSpacingOffset);

        dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
        dc.drawArc(centerX,centerY,arcR,Graphics.ARC_COUNTER_CLOCKWISE,(upperStartAngle + upperEndAngle) / 2,upperEndAngle);

    }


    public function drawLine(dc as Dc) as Void {
        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
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
        dc.drawLine(centerX, upperRightY, centerX, lowerRightY);
        // 上水平线
        // dc.drawLine(upperRightX,upperRightY,upperLeftX,upperLeftY);
        // 下水平线
        // dc.drawLine(lowerRightX,lowerRightY,lowerLeftX,lowerLeftY);
        // 右垂直线
        // dc.drawLine(upperRightX,upperRightY,lowerRightX,lowerRightY);
        // 左垂直线
        // dc.drawLine(upperLeftX,upperLeftY,lowerLeftX,lowerLeftY);
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
