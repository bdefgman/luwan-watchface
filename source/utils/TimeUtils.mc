using Toybox.Time.Gregorian as Date;

class TimeUtils {
    
    // 静态常量存储星期和月份的缩写
    static const DAY_ABBREVIATIONS = {
        Date.DAY_MONDAY => "MON",
        Date.DAY_TUESDAY => "TUE",
        Date.DAY_WEDNESDAY => "WED",
        Date.DAY_THURSDAY => "THU",
        Date.DAY_FRIDAY => "FRI",
        Date.DAY_SATURDAY => "SAT",
        Date.DAY_SUNDAY => "SUN"
    };
    
    static const MONTH_ABBREVIATIONS = {
        Date.MONTH_JANUARY => "JAN",
        Date.MONTH_FEBRUARY => "FEB",
        Date.MONTH_MARCH => "MAR",
        Date.MONTH_APRIL => "APR",
        Date.MONTH_MAY => "MAY",
        Date.MONTH_JUNE => "JUN",
        Date.MONTH_JULY => "JUL",
        Date.MONTH_AUGUST => "AUG",
        Date.MONTH_SEPTEMBER => "SEP",
        Date.MONTH_OCTOBER => "OCT",
        Date.MONTH_NOVEMBER => "NOV",
        Date.MONTH_DECEMBER => "DEC"
    };
    
    // OutPut -> MON
    private function GetDayAbbreviation(day) {
        return DAY_ABBREVIATIONS[day];
    }
    
    // OutPut -> JAN
    private function GetMonthAbbreviation(month) {
        return MONTH_ABBREVIATIONS[month];
    }

    // OutPut -> MON
    public function getDaysOfWeek() {
        var now = Time.now();
        var date = Date.info(now, Time.FORMAT_SHORT);
        var daysOfWeek = GetDayAbbreviation(date.day_of_week);
        return daysOfWeek.toString();        
    }

    // OutPut -> JAN
    public function getMonthOfYear() {
        var now = Time.now();
        var date = Date.info(now, Time.FORMAT_SHORT);
        var month = GetMonthAbbreviation(date.month);
        return month;
    }

    // OutPut -> 30
    public function getDayOfMonth() {
        var now = Time.now();
        var date = Date.info(now, Time.FORMAT_SHORT);
        var day = date.day;
        return day.toString();
    }
}