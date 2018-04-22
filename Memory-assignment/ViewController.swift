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
    
    lazy private var currentTheme: ThemeColors = ThemeColors.halloween
    lazy private var currentThemeAttributes: ColorAttributes = currentTheme.colors
    private var currentThemeIndex: Int = 0
    
   //Game properties
    
    @IBAction func newGame(_ sender: UIButton) {
        createNewGame(for: currentThemeIndex)
    }
    
    @IBOutlet weak var gameScore: UILabel!
    
    @IBOutlet weak var newGameButton: UIButton!
    
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
            var isSeenValues : [Cards : Int] = [Cards : Int]()
            
            for index in CardButtons.indices {
                
                let button = CardButtons[index]
                let card = Game.cards[index]
                
                isSeenValues.merge([card : card.isSeen]){(_, new) in new }
                
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
    
    private func updateFlipCount() {
            Flipcount.text = "Flips:\(Game.flipCount)"
    }
    
    func updateGameScore() {
        gameScore.text = "Game Score:\(Game.score)"
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
        
        if (Game.gameOver == true) || cardButtonsStackViewTopConstraint.constant < 0 {
            let wasHidden = cardButtonsStackView.isHidden
            let isHidden = !wasHidden
            cardButtonsStackView.isHidden = isHidden
            // If stackView was hidden, now it's visible, use a positive offset (or setting it
            cardButtonsStackViewTopConstraint.constant += isHidden ? -200 : 200
        }
    }
    
    func createNewGame(for buttonIndex: Int) {
        
        let choosenTheme : String = themeButton[buttonIndex].currentTitle!.lowercased()
        let currentTheme = ThemeColors(rawValue : choosenTheme)!
        currentThemeAttributes = currentTheme.colors
        
        view.backgroundColor = currentThemeAttributes.screenBackgroundColor
        Game = Concentration(numberOfPairOfCards : numberOfPairOfCards)
        gameOverMessage.isHidden = true
        
        for index in CardButtons.indices {
            
            CardButtons[index].setTitle(" ", for: UIControlState.normal)
            CardButtons[index].backgroundColor = currentThemeAttributes.buttonFaceDownColor
            
        }
        
        gameScore.textColor = currentThemeAttributes.flipCountColor
        newGameButton.isHidden = false
        newGameButton.setTitleColor(currentThemeAttributes.flipCountColor, for: UIControlState.normal)
        Flipcount.textColor = currentThemeAttributes.flipCountColor
        
        updateFlipCount()
        updateGameScore()
        
    }
    
    @IBAction public func chooseTheme(_ sender : UIButton) {
        
        if let themeIndex : Int = themeButton.index(of : sender) {
            
            currentThemeIndex = themeIndex
            
            setThemeButtons(for : sender)
            
            createNewGame(for: currentThemeIndex)
            
            toggleCardButtonsStackViewVisibility()
            
        }
    
    }
    
    //Game Display Logic

    @IBAction public func touchCard(_ sender : UIButton) {
        
        if let cardIndex = CardButtons.index(of : sender) {
            
            Game.ChooseCard(identifier: cardIndex)
            updateFlipCount()
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
        
        updateGameScore()
        
        if Game.gameOver {
            
            toggleCardButtonsStackViewVisibility()
            
            setThemeButtons(for: nil)
            newGameButton.isHidden = true
            gameOverMessage.text = gameOverMessageText
            gameOverMessage.lineBreakMode = .byWordWrapping
            gameOverMessage.numberOfLines = 0
            gameOverMessage.text = gameOverMessage.text?.replacingOccurrences(of : "\n", with : "\n")
            gameOverMessage.isHidden = false
        
        }
    
    }
    
    private var emojis = [Cards : String]()
    
    private func emoji(for card : Cards)->String {
        
        if emojis[card] == nil {

             emojis[card] = currentThemeAttributes.removeEmoji(at : currentThemeAttributes.emojiIcons.count.arc4randomuniform)
        
        }
        
        return emojis[card] ?? "?"
        
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
