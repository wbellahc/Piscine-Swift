import Foundation

class Card: NSObject {
    var color: Color
    var value: Value
    
    init(color: Color, value: Value) {
        self.color = color
        self.value = value
    }
    
    override var description: String {
        return "The color of the card is \(color) and it's value is \(value)"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Card {
            return color == object.color && value == object.value
        }
        else {
            return false
        }
    }
    
    static func ==(left: Card, right: Card) -> Bool {
        return left.color == right.color && left.value == right.value
    }
}