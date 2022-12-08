//
//  ViewController.swift
//  TreIRad
//
//  Created by Hugo Garcia on 2022-11-30.
//

import UIKit

class ViewController: UIViewController
{
    enum Turn{
        case Nought
        case Cross
    }
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    
    var board = [UIButton]()
    
    var noughtsScore = 0
    var crossesScore = 0
    var computerEasy = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initBoard()
    }
    
    func initBoard(){
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        
        if(computerEasy && currentTurn == Turn.Cross) {
            
            addToBoard(sender)
            if checkForVictory(CROSS){
                crossesScore += 1
                resultAlert(title: "Crosses Win!")
                return
            }
            if(self.fullBoard()) {
                
                self.resultAlert(title: "Draw")
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                if(!(self.checkForVictory(self.CROSS)) || self.fullBoard()){
                    self.determinComputerTurnPosition()
                    
                    if self.checkForVictory(self.NOUGHT){
                        self.noughtsScore += 1
                        self.resultAlert(title: "Noughts Win!")
                        return
                        
                    }
                    if(self.fullBoard()) {
                        
                        self.resultAlert(title: "Draw")
                        return
                    }
                }
            }
            
            
            
        }
    }
    
    func determinComputerTurnPosition() {
        //DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
            var turnPosition = self.board.randomElement()!
            
            while (!(turnPosition.title(for: .normal) == nil)){
                turnPosition = self.board.randomElement()!
                
            }
                self.addToBoard(turnPosition)
            
        //}
            
        }
    
    func checkForVictory(_ s :String) -> Bool {
        // Horizontal
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) {
                return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) {
                return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) {
                return true
        }
        // Vertical
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) {
                return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) {
                return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) {
                return true
        }
        // Diagonal
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) {
                return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) {
                return true
        }
              
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        
        let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            print("pushed reset")
            self.resetBoard()
            
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard() {
        print("in reset")
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        
        currentTurn = firstTurn
        print("\(currentTurn)")
        if(computerEasy && firstTurn == Turn.Nought) {
            //if(!checkForVictory(CROSS) || (fullBoard())){
                    determinComputerTurnPosition()
            //}
        }
        
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        
        if(sender.title(for: .normal) == nil){
            if(currentTurn == Turn.Nought){
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if(currentTurn == Turn.Cross){
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
}

