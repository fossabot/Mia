import UIKit
import Mia


// With
var oldFrame = CGRect(x: 0, y: 0, width: 1, height: 1)
print("oldFrame: \(oldFrame)")

let newFrame = oldFrame.with {
    $0.size.width = 200
    $0.size.height = 100
}
print("oldFrame: \(oldFrame)")
print("newFrame: \(newFrame)")



// Do
UserDefaults.standard.do {
    $0.removeObject(forKey: "username")
    print("username: \($0.object(forKey: "username"))")
}

UserDefaults.standard.do {
    $0.set("multinerd", forKey: "username")
    print("username: \($0.object(forKey: "username"))")
}



// Then
let label = UILabel().then {
    $0.text = "Hello, World!"
    $0.textAlignment = .center
    $0.textColor = .black
}
print("text: \(label.text!)")
print("color: \(label.textColor.hexString)")



