//
//  Concentration.swift
//  Memory-assignment
//
//  Created by Kunal Gandhi on 03.04.18.
//  Copyright © 2018 Kunal Gandhi. All rights reserved.
//

import Foundation

public class Concentration {
    

    private(set) var cards : Array<Cards> = [Cards]()
    
    var flipCount: Int = 0
    
    var score: Int = 0
    
    private var indexOfOneAndOnlyFaceUpCard : Int? {
        
        get {
            
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        
        }
        
        set {
            
            for index in cards.indices {
            
                cards[index].isFaceUp = (index == newValue)
            
            }
        
        }
    
    }
    
    public var gameOver : Bool = false
    
    private var remainingCardCount : Int {
        
        didSet {
            
            if remainingCardCount == 0 {
                
                gameOver = true
            
            }
        }
        
    }
    
    func ChooseCard (identifier : Int) {
        
        assert(cards.indices.contains(identifier),"Concentration.choosecard at \(identifier)")
        
        if !cards[identifier].isMatched {
           
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != identifier {
                //      one card is faceup
                
                flipCount += 1
                
                if cards[matchIndex] == cards[identifier] {
                    
                    cards[matchIndex].isMatched = true
                    cards[identifier].isMatched = true
                    remainingCardCount -= 2
                    
                    // incrementing card seen count if you get super lucky
                    if cards[identifier].isSeen == 0 {
                        
                        cards[identifier].isSeen += 1
                    
                    }
                    self.score += 2
                } else {
                    // incrementing your seen count as the cards did not match
                    if cards[identifier].isSeen > 0 {
                        self.score -= 1
                    }
                    cards[identifier].isSeen += 1
                    
                }
                
                cards[identifier].isFaceUp = true

             } else {
                //incrementing your card seen count if not the same card
                if !cards[identifier].isFaceUp {
                    flipCount += 1
                    cards[identifier].isSeen += 1
                }
                
                indexOfOneAndOnlyFaceUpCard = identifier
                
            }
            
        }
        
    }


    init (numberOfPairOfCards : Int) {
        
        
        for _ in 0 ..< numberOfPairOfCards {
            
            let card = Cards()
            cards += [card, card]
        
        }
        
        self.remainingCardCount = cards.count
        
        //TODO: shuffle logic incorporated
        /*var cardsShuffeled : [Cards] = [Cards]()
        var cardsShuffeledTemp : [Cards] = [Cards]()
        let halfDeckSize : Int = (cards.count)/2
        var firstHalf : ArraySlice<Cards> = cards[0...(halfDeckSize-1)]
        var secondHalf : ArraySlice<Cards> = cards[halfDeckSize...(cards.count-1)]
        var firstHalfarray : [Cards] = Array(firstHalf)
        var secondHalfarray : [Cards] = Array(secondHalf)
        
        for _ in 0 ..< (halfDeckSize/2) {
            
            for index in 0 ..< firstHalfarray.count {
                
                cardsShuffeledTemp.append(firstHalfarray[index])
                cardsShuffeledTemp.append(secondHalfarray[index])
            
            }
            
            firstHalf = cardsShuffeledTemp[0...(halfDeckSize-1)]
            secondHalf = cardsShuffeledTemp[halfDeckSize...(cardsShuffeledTemp.count-1)]
            firstHalfarray = Array(firstHalf)
            secondHalfarray = Array(secondHalf)
            cardsShuffeled = cardsShuffeledTemp
            cardsShuffeledTemp = []
        
        }
        
        cards = cardsShuffeled
        
        for index in 0 ..< cards.count {
            
            var uniqueIncrementor = cards.count.arc4randomuniform
            
            while(index == uniqueIncrementor) {
            
                uniqueIncrementor = cards.count.arc4randomuniform
            
            }
            
            cards.swapAt(index, uniqueIncrementor)
        
        }*/
        
    }
    
}

extension Collection {
    
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
    
}
