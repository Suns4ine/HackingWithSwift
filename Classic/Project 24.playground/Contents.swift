import UIKit
import Foundation

let name = "Taylor"

for letter in name {
    print("Give me a \(letter)!")
}

let letter = name[name.index(name.startIndex, offsetBy: 3)]

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}


let password = "123456"
password.hasPrefix("123")
password.hasSuffix("456")


extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}

let string = "This is a test string"
let attributes: [NSAttributedString.Key : Any] = [
    .foregroundColor : UIColor.white,
    .backgroundColor : UIColor.red,
    .font : UIFont.boldSystemFont(ofSize: 36)
]

//let attributedString = NSAttributedString(string: string, attributes: attributes)

//print(attributedString)

let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))


extension String {
    mutating func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return String(prefix + self)
    }
}

var first = "2first"
first.withPrefix("1")

print(first)


extension String {
    func isNumeric(_ numb: Double) -> Bool {
        if !self.isEmpty && self.contains(String(numb)) {
            return true
        }
        return false
    }
    
    func isNumeric(_ numb: Int) -> Bool {
        if !self.isEmpty && self.contains(String(numb)) {
            return true
        }
        return false
    }

}
first.isNumeric(2)


extension String {
    func lines() -> [String] {
        var array = [String]()
        array =  self.components(separatedBy: " ")
        return array
        }
    }

var arrayString = "1 2 3 4 5 ersssssss tr6 h6tg y6th ".lines()

for i in arrayString {
    print(i)
}
