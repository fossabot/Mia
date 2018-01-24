/*
 public class func storyboardClass() -> SalesOverviewView! {
 let sb = UIStoryboard(name: "Sales", bundle: nil)
 let vc = sb.instantiateViewController(withIdentifier: "SalesOverviewView") as! SalesOverviewView
 return vc
 }
 */
@available(*, deprecated, message: "Replaced with `ViewControllerInitializer`.")
public protocol StoryboardConvertible {
    static func storyboardInit() -> UIViewController
}
