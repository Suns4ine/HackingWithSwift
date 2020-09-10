import UIKit

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}


extension Int {
    func times(_ clousure: ()->()) {
        if self <= 0 { return }
        var i = self
        while (i > 0) {
            clousure()
            i -= 1
        }
    }
}

var i = -5
i.times {
    print("Hello\(i)")
}

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let itemArray = self.firstIndex(of: item) {
            self.remove(at: itemArray)
        }
    }
}
    
//        if self.isEmpty { return self }
//        var newArray = self
//        var count = 0
//
//        for i in newArray {
//            if i == item {
//                count += 1
//            }
//
//            if count == 2 {
//                break
//            }
//        }
//
//        if count >= 2 {
//            for i in newArray {
//                if i == item {
//                    newArray = newArray.remove(item: i)
//                    return newArray
//                }
//            }
//        }
//
//        return newArray
//    }


var array = [1, 6, 3, 4, 5, 2, 6, 8]

array.remove(item: 6)

for i in array {
    print(i)
}
