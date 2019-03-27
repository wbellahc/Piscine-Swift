import Foundation

class Deck: NSObject {
    static let allSpades: [Card] = Value.allValues.map({ Card(color: Color.piques, value: $0) })
    static let allDiamonds: [Card] = Value.allValues.map({ Card(color: Color.carreaux, value: $0) })
    static let allHearts: [Card] = Value.allValues.map({ Card(color: Color.coeurs, value: $0) })
    static let allClubs: [Card] = Value.allValues.map({ Card(color: Color.trefles, value: $0) })
    static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs
}

extension Array {
    mutating func shuffle() {
        for _ in indices {
            sort { (_,_) in arc4random_uniform(13) + 1 < arc4random_uniform(13) + 1 }
        }
    }
}