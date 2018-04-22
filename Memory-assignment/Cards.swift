//
//  Cards.swift
//  Memory-assignment
//
//  Created by Kunal Gandhi on 03.04.18.
//  Copyright © 2018 Kunal Gandhi. All rights reserved.
//

import Foundation

public struct Cards: Hashable  {
    
    public var hashValue: Int {
        return identifier
    }
    
    public static func == (lhs: Cards, rhs: Cards) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    public var isFaceUp : Bool = false
    
    public var isMatched : Bool = false
    
    private var identifier : Int
    
    public var isSeen : Int = 0
    
    static private var identifierFactory : Int = 0
    
    static private func getUniqueIdentifier () -> Int {
        
        Cards.identifierFactory += 1
        
        return Cards.identifierFactory
        
    }
    
    init() {
        
        self.identifier = Cards.getUniqueIdentifier()
    
    }
    
}
