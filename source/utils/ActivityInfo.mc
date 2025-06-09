


class ActivityInfo {

    function getCurStep() {
        var currentStep = ActivityMonitor.getInfo().steps;
        return currentStep.toString();
    }
}