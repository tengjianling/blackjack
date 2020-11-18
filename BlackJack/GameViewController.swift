//
//  GameViewController.swift
//  BlackJack
//
//  Created by Teng Jian Ling on 18/5/20.
//  Copyright © 2020 Teng Jian Ling. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var firstCard: UIImageView!
    @IBOutlet weak var secondCard: UIImageView!
    @IBOutlet weak var thirdCard: UIImageView!
    @IBOutlet weak var fourthCard: UIImageView!
    @IBOutlet weak var fifthCard: UIImageView!
    
    @IBOutlet weak var cpu1card1: UIImageView!
    @IBOutlet weak var cpu1card2: UIImageView!
    @IBOutlet weak var cpu1card3: UIImageView!
    @IBOutlet weak var cpu1card4: UIImageView!
    @IBOutlet weak var cpu1card5: UIImageView!
    
    @IBOutlet weak var cpu2card1: UIImageView!
    @IBOutlet weak var cpu2card2: UIImageView!
    @IBOutlet weak var cpu2card3: UIImageView!
    @IBOutlet weak var cpu2card4: UIImageView!
    @IBOutlet weak var cpu2card5: UIImageView!
    
    
    var cardsDealt = false
    var gameOver = false
    
    var CPU1Hand = 0
    var CPU2Hand = 0
    var playerHand = 0
    
    var numCardsDrawn = 0
    var CPU1NumCardsDrawn = 0
    var CPU2NumCardsDrawn = 0
    
    var playerHandArray: [String] = []
    var CPU1HandArray: [String] = []
    var CPU2HandArray: [String] = []
    
    var deckOfCards: [String] = ["2C", "2D", "2H", "2S",
                                 "3C", "3D", "3H", "3S",
                                 "4C", "4D", "4H", "4S",
                                 "5C", "5D", "5H", "5S",
                                 "6C", "6D", "6H", "6S",
                                 "7C", "7D", "7H", "7S",
                                 "8C", "8D", "8H", "8S",
                                 "9C", "9D", "9H", "9S",
                                 "10C", "10D", "10H", "10S",
                                 "JC", "JD", "JH", "JS",
                                 "QC", "QD", "QH", "QS",
                                 "KC", "KD", "KH", "KS",
                                 "AC", "AD", "AH", "AS"]
    var fullDeck: [String] = ["2C", "2D", "2H", "2S",
                              "3C", "3D", "3H", "3S",
                              "4C", "4D", "4H", "4S",
                              "5C", "5D", "5H", "5S",
                              "6C", "6D", "6H", "6S",
                              "7C", "7D", "7H", "7S",
                              "8C", "8D", "8H", "8S",
                              "9C", "9D", "9H", "9S",
                              "10C", "10D", "10H", "10S",
                              "JC", "JD", "JH", "JS",
                              "QC", "QD", "QH", "QS",
                              "KC", "KD", "KH", "KS",
                              "AC", "AD", "AH", "AS"]
    
    
    // MARK: buttons
    
    @IBAction func newGameButton(_ sender: Any) {
        cardsDealt = false
        gameOver = false
        
        CPU1Hand = 0
        CPU2Hand = 0
        playerHand = 0
        
        numCardsDrawn = 0
        CPU1NumCardsDrawn = 0
        CPU2NumCardsDrawn = 0
        
        playerHandArray = []
        CPU1HandArray = []
        CPU2HandArray = []
        deckOfCards = fullDeck
        
        firstCard.image = UIImage(named: "")
        secondCard.image = UIImage(named: "")
        thirdCard.image = UIImage(named: "")
        fourthCard.image = UIImage(named: "")
        fifthCard.image = UIImage(named: "")
        
        cpu1card1.image = UIImage(named: "")
        cpu1card2.image = UIImage(named: "")
        cpu1card3.image = UIImage(named: "")
        cpu1card4.image = UIImage(named: "")
        cpu1card5.image = UIImage(named: "")
        
        cpu2card1.image = UIImage(named: "")
        cpu2card2.image = UIImage(named: "")
        cpu2card3.image = UIImage(named: "")
        cpu2card4.image = UIImage(named: "")
        cpu2card5.image = UIImage(named: "")
        
        winnerLabel.text = ""
    }
    
    @IBAction func dealButton(_ sender: Any) {
        if cardsDealt == false {
            cardsDealt = true
            for _ in 0...1 {
                playerHandArray.append(getRandCard())
                CPU1HandArray.append(getRandCard())
                CPU2HandArray.append(getRandCard())
            }
            
            firstCard.image = UIImage(named: playerHandArray[0])
            secondCard.image = UIImage(named: playerHandArray[1])
            
            cpu1card1.image = UIImage(named: "blue_back")
            cpu1card2.image = UIImage(named: "blue_back")
            
            cpu2card1.image = UIImage(named: "blue_back")
            cpu2card2.image = UIImage(named: "blue_back")
            
            print(playerHandArray)
            
            playerHand = getHandValue(hand: playerHandArray)
            
            if checkForBlackJack() {
                gameOver = true
        
            }
        }
    }
    
    @IBAction func drawButton(_ sender: Any) {
        let len = playerHandArray.count
        if hasExploded(arr: playerHandArray) == false  && cardsDealt && !gameOver {
            //let len = playerHandArray.count
            let nextCard = getRandCard()
            playerHandArray.append(nextCard)
            if len == 2 {
                // 3 cards in hand
                thirdCard.image = UIImage(named: nextCard)
            } else if len == 3 {
                // 4 cards in hand
                fourthCard.image = UIImage(named: nextCard)
            } else if len == 4 {
                fifthCard.image = UIImage(named: nextCard)
            } else {
                // cannot draw anymore
            }
        } else {
            // exceeded 21
            if hasAce(hand: playerHandArray) && len == 3 {
                let nextCard = getRandCard()
                fourthCard.image = UIImage(named: nextCard)
            } else {
                // cannot draw
            }
        }
        
    }
    
    @IBAction func stayButton(_ sender: Any) {
        if gameOver == false && cardsDealt {
            gameOver = true
            playerHand = getHandValue(hand: playerHandArray)
            
            CPU1HandArray = CPUSim(hand: CPU1HandArray)
            CPU1Hand = getHandValue(hand: CPU1HandArray)
            showCPU1Cards()
            
            CPU2HandArray = CPUSim(hand: CPU2HandArray)
            CPU2Hand = getHandValue(hand: CPU2HandArray)
            showCPU2Cards()
            
            getWinner()
        }
    }
    
    
    
    // MARK: other methods
    
    func getRandCard() -> String {
        let n = Int.random(in: 0...deckOfCards.count - 1)
        let card = deckOfCards[n]
        deckOfCards.remove(at: n)
        return card
    }
    
//    func getValue(str: String) -> Int {
//        let arr = Array(str)
//        if arr[0] == "J" || arr[0] == "Q" || arr[0] == "K" {
//            return 10
//        } else if arr[0] == "A" {
//            return 11
//        } else {
//
//            let char: Character = arr[0]
//            if let number = Int(String(char)) {
//                if number == 1 {
//                    if arr[1] == "0" {
//                        return 10
//                    } else {
//                        return 1
//                    }
//                } else {
//                    return number
//                }
//            }
//            return 0
//
//        }
//    }
    
//    func handValue(hand: [String]) -> Int {
//        var value = 0
//        for card in hand {
//            value += getValue(str: card)
//        }
//        return value
//    }
    
    func getHandValue(hand: [String]) -> Int {
        var result = 0
        var values: [Int] = []
        for card in hand {
            let arr = Array(card)
            let char = arr[0]
            if char == "J" || char == "Q" || char == "K" {
                //result += 10
                values.append(10)
            } else if char == "A" {
                if hand.count <= 2 {
                    //result += 11
                    values.append(11)
                } else if hand.count == 3 {
                    //result += 10
                    values.append(10)
                } else {
                    //result += 1
                    values.append(1)
                }
            } else {
                if let num = Int(String(char)) {
                    if num == 1 {
                        if arr[1] == "0" {
                            //result += 10
                            values.append(10)
                        } else {
                            //result += 1
                            values.append(1)
                        }
                    } else {
                        //result += num
                        values.append(num)
                    }
                }
            }
        }
        for i in values {
            result += i
        }
        return result
    }
    
    func hasExploded(arr: [String]) -> Bool {
        return getHandValue(hand: arr) > 21
    }
    
    
    func CPUSim(hand: [String]) -> [String] {
        var newHand = hand
        let value = getHandValue(hand: hand)
        if value < 16 {
            // draw
            newHand.append(getRandCard())
            return CPUSim(hand: newHand)
        } else if value > 21 && hand.count == 3 && hasAce(hand: hand) {
            // draw
            newHand.append(getRandCard())
            return CPUSim(hand: newHand)
        } else {
            let diff = 21 - value
            let n = Int.random(in: 1...10)
            if n <= diff {
                //draw
                newHand.append(getRandCard())
                return CPUSim(hand: newHand)
            } else {
                // cpu stays
                return newHand
            }
        }
    }

    func hasAce(hand: [String]) -> Bool {
        for card in hand {
            let arr = Array(card)
            if arr[0] == "A" {
                return true
            }
        }
        return false
    }
    
    func showCPU1Cards() {
        let len = CPU1HandArray.count
        for i in 0...len - 1 {
            let card = CPU1HandArray[i]
            if i == 0 {
                cpu1card1.image = UIImage(named: card)
            } else if i == 1 {
                cpu1card2.image = UIImage(named: card)
            } else if i == 2 {
                cpu1card3.image = UIImage(named: card)
            } else if i == 3 {
                cpu1card4.image = UIImage(named: card)
            } else {
                cpu1card5.image = UIImage(named: card)
            }
        }
    }
    
    func showCPU2Cards() {
        let len = CPU2HandArray.count
        for i in 0...len - 1 {
            let card = CPU2HandArray[i]
            if i == 0 {
                cpu2card1.image = UIImage(named: card)
            } else if i == 1 {
                cpu2card2.image = UIImage(named: card)
            } else if i == 2 {
                cpu2card3.image = UIImage(named: card)
            } else if i == 3 {
                cpu2card4.image = UIImage(named: card)
            } else {
                cpu2card5.image = UIImage(named: card)
            }
        }
    }
    
    func getWinner() {
        
        var arr = [playerHand, CPU1Hand, CPU2Hand]
        arr = arr.filter( {$0 <= 21} )
        let m = arr.max()
        if playerHand == m && CPU1Hand != m && CPU2Hand != m {
            winnerLabel.text = "You Win!"
        } else if CPU1Hand == m && playerHand != m && CPU2Hand != m {
            winnerLabel.text = "CPU1 Wins!"
        } else if CPU2Hand == m && playerHand != m && CPU1Hand != m {
        winnerLabel.text = "CPU2 Wins!"
        } else {
            winnerLabel.text = "There is a tie!"
        }
    }
    
    func isBlackJack(hand: [String]) -> Bool {
        return hand.count == 2 && getHandValue(hand: hand) == 21
    }
    
    func checkForBlackJack() -> Bool {
        var hasBlackJack = false
        let players = [playerHandArray, CPU1HandArray, CPU2HandArray]
        for i in 0...players.count - 1 {
            if isBlackJack(hand: players[i]) {
                hasBlackJack = true
                showCPU1Cards()
                showCPU2Cards()
                if i == 0 {
                    winnerLabel.text = "BlackJack! You Win!"
                } else if i == 1 {
                    winnerLabel.text = "BlackJack! CPU1 Wins!"
                } else {
                    winnerLabel.text = "BlackJack! CPU2 Wins!"
                }
            }
        }
        return hasBlackJack
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
