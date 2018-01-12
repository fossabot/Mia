import Foundation


/*
 public class func storyboardClass() -> SalesOverviewView! {
    let sb = UIStoryboard(name: "Sales", bundle: nil)
    let vc = sb.instantiateViewController(withIdentifier: "SalesOverviewView") as! SalesOverviewView
    return vc
 }
 */
public protocol StoryboardConvertible {
    static func storyboardInit() -> UIViewController
}
