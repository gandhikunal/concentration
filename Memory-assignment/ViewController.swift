//
//  ViewController.swift
//  Memory-assignment
//
//  Created by Kunal Gandhi on 03.04.18.
//  Copyright © 2018 Kunal Gandhi. All rights reserved.
//

import UIKit

class ViewController : UIViewController {
    
    //Defaul Button Display Attributes based on the choosen theme
    
    lazy private var currentTheme : ThemeColors = ThemeColors.halloween
    lazy private var currentThemeAttributes : ColorAttributes = currentTheme.colors
    
   //Game properties
    
    lazy public var Game : Concentration = Concentration(numberOfPairOfCards : numberOfPairOfCards)
    
    @IBOutlet weak var cardButtonsStackView: UIStackView!
    @IBOutlet weak var cardButtonsStackViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet public var CardButtons : [UIButton]!
    
    @IBOutlet private weak var Flipcount : UILabel!
    
    @IBOutlet private weak var gameOverMessage : UILabel!
    
    @IBOutlet public var themeButton: [UIButton]!
    
    private var gameOverMessageText : String {
        
        get {
            
            let defaultMessage : String = "Game Over!! \n To start a new game please choose a theme."
            var isSeenValues : [Int : Int] = [Int : Int]()
            
            for index in CardButtons.indices {
                
                let button = CardButtons[index]
                let card = Game.cards[index]
                
                isSeenValues.merge([card.identifier : card.isSeen]){(_, new) in new }
                
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
            
            }
            
            if let highestSeenCount = isSeenValues.max(by : {a ,b in a.value < b.value}) {
                
                return defaultMessage+"\n Your most seen card is"+emojis[highestSeenCount.key]!+" with seen count: "+String(highestSeenCount.value)
           
            } else {
                
                return defaultMessage
            
            }
       
        }
    
    }
    
    var numberOfPairOfCards : Int {
        
        return (CardButtons.count+1)/2
    
    }
    
    var flipcount : Int = 0 {
        
        didSet {
            
            Flipcount.text = "Flips:\(flipcount)"
        
        }
    
    }
    
    //Theme Options

    private struct ColorAttributes {
        
        var buttonFaceUpColor : UIColor! = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        var buttonFaceDownColor : UIColor! = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        var screenBackgroundColor : UIColor! = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        var flipCountColor : UIColor! = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        
        var emojiIcons : [String] = ["👽","💀","☠️","👻","👺","👹","🤡","🎃","🦇","🕷","🦉"]
        
        mutating func removeEmoji(at index:Int)->String? {
            
            return self.emojiIcons.remove(at: index)
        
        }
        
    }
    
    private enum ThemeColors : String {
        
        case halloween, sport, smileys
        
        fileprivate var colors : ColorAttributes {
            
            get {
                    switch self
                    {
                        case .halloween :
                            return ColorAttributes(buttonFaceUpColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), buttonFaceDownColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), screenBackgroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), flipCountColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), emojiIcons : ["👽","💀","☠️","👻","👺","👹","🤡","🎃","🦇","🕷","🦉"])
                        case .sport :
                            return ColorAttributes(buttonFaceUpColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), buttonFaceDownColor : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), screenBackgroundColor : #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), flipCountColor : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), emojiIcons: ["🏀","🏹","🏊🏼‍♀️","🧗🏻‍♀️","🤽🏻‍♂️","🏓","🏏","🎳","🎲","🎰","🎾"])
                        case .smileys:
                            return ColorAttributes(buttonFaceUpColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), buttonFaceDownColor : #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), screenBackgroundColor : #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), flipCountColor : #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), emojiIcons :["😎","😇","🤣","😜","😂","😬","🤑","🧐","🤐","😤","🙄"])
                    }
                
            }
            
        }
        
    }
    
    //Theme Dsiplay Logic
    
    private func setThemeButtons(for button : UIButton?) {
        
        for index : Int in themeButton.indices {
            
            if button != nil, index == themeButton.index(of : button!) {
                
                button!.backgroundColor! = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button!.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControlState.normal)
                
                button!.isEnabled = false
            } else {
                
                themeButton[index].backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                themeButton[index].setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: UIControlState.normal)
                themeButton[index].isEnabled = true
            
            }
        
        }
    
    }
    
    func toggleCardButtonsStackViewVisibility() {
        let wasHidden = cardButtonsStackView.isHidden
        let isHidden = !wasHidden
        cardButtonsStackView.isHidden = isHidden
        // If stackView was hidden, now it's visible, use a positive offset (or setting it
        cardButtonsStackViewTopConstraint.constant += isHidden ? -100 : 100
    }
    
    @IBAction public func chooseTheme(_ sender : UIButton) {
        
        if let themeIndex : Int = themeButton.index(of : sender) {
            
            toggleCardButtonsStackViewVisibility()
            
            setThemeButtons(for : sender)
            let choosenTheme : String = themeButton[themeIndex].currentTitle!.lowercased()
            let currentTheme = ThemeColors(rawValue : choosenTheme)!
            currentThemeAttributes = currentTheme.colors
            
            view.backgroundColor = currentThemeAttributes.screenBackgroundColor
            Game = Concentration(numberOfPairOfCards : numberOfPairOfCards)
            gameOverMessage.isHidden = true
            
            for index in CardButtons.indices {
                
                CardButtons[index].setTitle(" ", for: UIControlState.normal)
                CardButtons[index].backgroundColor = currentThemeAttributes.buttonFaceDownColor
            
            }
            
            Flipcount.textColor = currentThemeAttributes.flipCountColor
            flipcount = 0
        
        }
    
    }
    
    //Game Display Logic

    @IBAction public func touchCard(_ sender : UIButton) {
        
        flipcount += 1
        
        if let cardIndex = CardButtons.index(of : sender) {
            
            Game.ChooseCard(identifier: cardIndex)
            updateViewfromModel()
        
        }
    
    }
    
    private func updateViewfromModel() {
       
        for index in CardButtons.indices {
            
            let button = CardButtons[index]
            let card = Game.cards[index]
            
                if card.isFaceUp {
                
                    button.backgroundColor = currentThemeAttributes.buttonFaceUpColor
                    button.setTitle(emoji(for : card), for : UIControlState.normal)
                
                } else {
            
                    button.setTitle("", for : UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : currentThemeAttributes.buttonFaceDownColor
                
            }
        
        }
        
        if Game.gameOver {
            
            toggleCardButtonsStackViewVisibility()
            
            setThemeButtons(for: nil)
            gameOverMessage.text = gameOverMessageText
            gameOverMessage.lineBreakMode = .byWordWrapping
            gameOverMessage.numberOfLines = 0
            gameOverMessage.text = gameOverMessage.text?.replacingOccurrences(of : "\n", with : "\n")
            gameOverMessage.isHidden = false
        
        }
    
    }
    
    private var emojis = [Int : String]()
    
    private func emoji(for card : Cards)->String {
        
        if emojis[card.identifier] == nil {

             emojis[card.identifier] = currentThemeAttributes.removeEmoji(at : currentThemeAttributes.emojiIcons.count.arc4randomuniform)
        
        }
        
        return emojis[card.identifier] ?? "?"
        
    }

}

extension Int
{
    var arc4randomuniform: Int
    {
       
        if self > 0 {
            
            return Int(arc4random_uniform(UInt32(self)))
        
        } else if self < 0 {
            
            return -Int(arc4random_uniform(UInt32(abs(self))))
        
        } else {
            
            return 0
        
        }
    
    }
    
}
