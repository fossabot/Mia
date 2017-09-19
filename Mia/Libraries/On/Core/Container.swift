import Foundation

public typealias Action = () -> Void
public typealias StringAction = (String) -> Void
public typealias FloatAction = (Float) -> Void
public typealias DateAction = (Date) -> Void
public typealias AnyAction = (Any) -> Void
public typealias NotificationAction = (Notification) -> Void

public class Container<Host:AnyObject>: NSObject {

    unowned let host: Host

    init(host: Host) {

        self.host = host
    }

    // Just to keep the targets around
    var controlTarget: ControlTarget?
    var buttonTarget: ButtonTarget?
    var sliderTarget: SliderTarget?
    var gestureTarget: GestureTarget?
    var datePickerTarget: DatePickerTarget?
    var barButtonItemTarget: BarButtonItemTarget?
    var searchBarTarget: SearchBarTarget?
    var textFieldTargets = [ TextFieldTarget ]()
    var textViewTarget: TextViewTarget?
    var timerTarget: TimerTarget?
    let keyPathTarget = KeyPathTarget()
    let notificationTarget = NotificationTarget()
}
