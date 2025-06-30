
import Toybox.SensorHistory;


class ActivityMonitorUtils {

    // 当日步数
    function getCurStepOfDay() {
        var currentStep = ActivityMonitor.getInfo().steps;
        return currentStep.toString();
    }

    // 当日活动时间（分钟）
    function getCurActiveMiniutesDay() {
        var activeMinutesDay = ActivityMonitor.getInfo().activeMinutesDay;
        return activeMinutesDay.toString();
    }

    // 当日卡路里
    public function getCaloriesOfDay() {
        var calories = ActivityMonitor.getInfo().calories;
        return calories;
    }
    
    // 当日垂直爬升距离
    public function getCurMetersClimbed() {
        var metersClimbed = ActivityMonitor.getInfo().metersClimbed;
        return metersClimbed.toString();
    }

    // 距离上次活动恢复时间 （小时）
    public function getCurTimeToRecovery() {
        var timeToRecovery = ActivityMonitor.getInfo().timeToRecovery;
        return timeToRecovery;
    }

    // 获取当前心率
    public function getCurHeartRate() {
        var hrIterator = ActivityMonitor.getHeartRateHistory(null, false);
        var sample = hrIterator.next();
        if (null != sample) {                                           // null check
            if (sample.heartRate != ActivityMonitor.INVALID_HR_SAMPLE) {    // check for invalid samples
                var curHearRate = sample.heartRate;      // print the current sample
                return curHearRate.toString();
            }
        }
        return 0.toString();
    }

    // 获取上次心率
    public function getPreviousHeartRate() {
        var hrIterator = ActivityMonitor.getHeartRateHistory(null, false);
        var previous = hrIterator.next();                                   // get the previous HR
        var sample = hrIterator.next();
        if (null != sample) {                                           // null check
            if (previous.heartRate != ActivityMonitor.INVALID_HR_SAMPLE) { // check for invalid samples
                var previousHeartRate = previous.heartRate;
                return previousHeartRate.toString();
            }
        }
        return 0.toString();
    }

    // 获取身体电量
    public function getBodyBattery() {
        var bodyBattery = null;

        if (Toybox has :SensorHistory && Toybox.SensorHistory has :getBodyBatteryHistory) {
            var iter = SensorHistory.getBodyBatteryHistory({ :period => 1 });
            bodyBattery = iter.next();
        }
        if (bodyBattery == null) {
            bodyBattery = 0;
        } else {
            bodyBattery = bodyBattery.data;
        }
        return bodyBattery;
    }
    
}