//
//  ViewController.swift
//  TTT
//
//  Created by Dustin Galindo on 5/10/17.
//  Copyright © 2017 Dustin Galindo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    var blueTurn = true
    var isWinner = false
    var player = 1
    var winner = 0
    var playedTags = [0]
    var gameBoard = [[0,0,0],
                     [0,0,0],
                     [0,0,0]]
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        reset()
    }
    func reset() {
        for i in 1...9{
            self.view.viewWithTag(i)?.backgroundColor = UIColor.gray
        }
        blueTurn = true
        isWinner = false
        winner = 0
        
        gameBoard = [
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0]
        ]
        playedTags = [0]
        winnerLabel.text = "Blue's Turn"
    }
    @IBAction func tileIsPressed(_ sender: UIButton) {
        if isWinner {
            return
        }
        if blueTurn{
            player = 1
        }else{
            player = 2
        }
        
        let tag = sender.tag
        if playedTags.contains(tag){
            return
        }
        switch tag {
        case 1:
            
            gameBoard[0][0] = player
        case 2:
            gameBoard[0][1] = player
        case 3:
            gameBoard[0][2] = player
        case 4:
            gameBoard[1][0] = player
        case 5:
            gameBoard[1][1] = player
        case 6:
            gameBoard[1][2] = player
        case 7:
            gameBoard[2][0] = player
        case 8:
            gameBoard[2][1] = player
        case 9:
            gameBoard[2][2] = player
        default:
            print("something has gone terribly wrong")
        }
        playedTags.append(tag)
        //check win state
        if blueTurn{
            sender.backgroundColor? = UIColor.blue
            blueTurn = false
            winnerLabel.text = "Red's Turn"
        }else{
            sender.backgroundColor? = UIColor.red
            blueTurn = true
            winnerLabel.text = "Blue's Turn"
            
        }
        checkWin()
    }
    
    func checkWin(){
        //check draw
        if playedTags.count == 10{
            isWinner = true
            winnerLabel.text = "Draw!"
            return
        }
        //check diagonal
        winner = gameBoard[0][0]
        for i in 1...2{
            
            if winner == 0 || gameBoard[i][i] != winner{
                winner = 0
                break
            }
            
        }
        if winner != 0{
            if winner == 1{
                winnerLabel.text = "Blue wins!"
            }else{
                winnerLabel.text = "Red wins!"
            }
            isWinner = true
            return
        }
        winner = gameBoard[2][0]
        for i in 0...2{
            if winner == 0 || gameBoard[2-i][i] != winner{
                winner = 0
                break
            }
        }
        if winner != 0{
            if winner == 1{
                winnerLabel.text = "Blue wins!"
            }else{
                winnerLabel.text = "Red wins!"
            }
            isWinner = true
            return
        }
        //check horizontal wins
        for row in gameBoard{
            winner = row[0]
            for column in row{
                
                if column == 0{
                    winner = 0
                    break
                }
                if column != winner{
                    winner = 0
                    break
                }
            }
            if winner != 0{
                if winner == 1{
                    winnerLabel.text = "Blue wins!"
                }else{
                    winnerLabel.text = "Red wins!"
                }
                isWinner = true
                return
            }
        }
        //check vertical wins
        for column in 0...2{
            winner = gameBoard[0][column]
            for row in 0...2{
                if gameBoard[row][column] == 0{
                    winner = 0
                    break
                }
                if gameBoard[row][column] != winner{
                    winner = 0
                    break
                }
            }
            if winner != 0{
                if winner == 1{
                    winnerLabel.text = "Blue wins!"
                }else{
                    winnerLabel.text = "Red wins!"
                }
                isWinner = true
                return
            }
        }
        
    }
}

