

class RadiansUtils {
        /**
    * @function degreesToRadians
    * @brief 将角度值转换为弧度值
    * @param degrees 待转换的角度值（单位：度）
    * @returns 转换后的弧度值（浮点数）
    * @note 公式：弧度 = 角度 × π / 180
    * @example degreesToRadians(180) → π（约3.14159265）
    */
    public function degreesToRadians(degrees) {
        return degrees * Math.PI / 180;
    }  

    /**
    * @function radiansToDegrees
    * @brief 将弧度值转换为角度值
    * @param radians 待转换的弧度值（浮点数）
    * @returns 转换后的角度值（单位：度，浮点数）
    * @note 公式：角度 = 弧度 × 180 / π
    * @example radiansToDegrees(Math.PI) → 180.0
    */
    public function radiansToDegrees(radians) {
        return radians * 180 / Math.PI;
    }  

    /**
    * @function convertCoorX
    * @brief 根据极坐标计算平面坐标系的X坐标（基于圆心偏移）
    * @param radians 极角（弧度，X轴正方向为0，逆时针为正）
    * @param radius 极半径（到圆心的距离，需≥0）
    * @returns X坐标值（浮点数，相对于centerX的偏移结果）
    * @depends centerX 圆心的X坐标（需提前定义，通常为表盘中心）
    * @warning 若radius为负数，结果将反向偏移
    */
    public function convertCoorX(radians, radius) {
        return centerX + radius*Math.cos(radians);
    }

    /**
    * @function convertCoorY
    * @brief 根据极坐标计算平面坐标系的Y坐标（基于圆心偏移）
    * @param radians 极角（弧度，X轴正方向为0，逆时针为正）
    * @param radius 极半径（到圆心的距离，需≥0）
    * @returns Y坐标值（浮点数，相对于centerY的偏移结果）
    * @depends centerY 圆心的Y坐标（需提前定义，通常为表盘中心）
    * @note Garmin设备坐标系中，Y轴正方向通常为屏幕下方，需注意符号
    */
    public function convertCoorY(radians, radius) {
        return centerY + radius*Math.sin(radians);
    }
}