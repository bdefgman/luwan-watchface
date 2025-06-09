import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class Background extends WatchUi.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "Background"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc as Dc) as Void {
        // Set the background color then call to clear the screen
        dc.setColor(Graphics.COLOR_TRANSPARENT, getApp().getProperty("BackgroundColor") as Number);
        dc.clear();

        //         // 绘制背景图片（覆盖整个屏幕）
        // var bgImage = Image.getImage(Resources.IMAGE_BACKGROUND); // 通过资源 ID 获取图片
        // dc.drawImage(0, 0, bgImage); // 从 (0,0) 坐标开始绘制，尺寸为图片原始尺寸
        
        // // ... 绘制其他元素（如时间、心率） ...
    }

}
