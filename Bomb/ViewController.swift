//
//  ViewController.swift
//  Bomb
//
//  Created by MEI KU on 2019/9/7.
//  Copyright © 2019 Natalie KU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var bombButton: UIButton!
    
    @IBOutlet weak var stoneButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var bangImage: UIImageView!
    
    

    var gameButtons = [UIButton]()
    var score : Int = 0
    
       
       enum GameState {
           case gameOver
           case playing
       }
       
       var state = GameState.gameOver
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.isHidden = true
          gameButtons = [bombButton,stoneButton]
          setupFreshGameState()
        
         
         
    }
    
     func startNewGame() {
           playButton.isHidden = true
          score = 0
          updatescoreLabel(score)
           scoreLabel.textColor = .magenta
           scoreLabel.isHidden = false
          oneGameRound()
          
     
       
       }
       
    @IBAction func playAgain(_ sender: Any) {
        
        startNewGame()
        setupFreshGameState()
       
      
        
    }
    
    func oneGameRound() {
        updatescoreLabel(score)
       
        displayRandomButton()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {
            _ in if self.state == GameState.playing {
                if self.currentButton == self.bombButton {
                    self.gameOver()
                    self.bangImage.isHidden = false
                    self.scoreLabel.isHidden = true
                    self.playButton.isHidden = true
                    self.show_alertController()
                
                } else {
                    self.oneGameRound()
                    self.bangImage.isHidden = true
                    
                    
                    
            }
        }
    }
    }

 
    
      func show_alertController() {
      
        
        let alert = UIAlertController(title: "Game Over!", message: "Your Score: \(score), do you want to record score?", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
              self.performSegue(withIdentifier: "RegisterSegue", sender: nil)
            self.bangImage.isHidden = true
            self.setupFreshGameState()
            self.scoreLabel.isHidden = true
            
               })
               
               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
                self.gameOver()
                self.startNewGame()
                self.setupFreshGameState()
                self.bangImage.isHidden = true
                
                })
            present(alert, animated: true, completion: nil)
    }

    
    
    
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "RegisterSegue" {
              let registerTableViewController = segue.destination as! RegisterTableViewController
            
          }
        
           let controller = segue.destination as? RegisterTableViewController
              
        controller?.score = scoreLabel.text ?? ""
   
     
    }
    

    
    
    
    @IBAction func playGame(_ sender: Any) {
    
        state = GameState.playing
        startNewGame()
    
    }
    
    @IBAction func bombPress(_ sender: Any) {
    
           score = score + 100
          updatescoreLabel(score)
           bombButton.isHidden = true
           timer?.invalidate()
          oneGameRound()
      
        
    }
    

    @IBAction func stonePress(_ sender: Any) {
    
           stoneButton.isHidden = true
           timer?.invalidate()
           gameOver()
           show_alertController()
           playButton.isHidden = true
           scoreLabel.isHidden = true
        
        
    }
    
       
     var timer: Timer?
     var currentButton: UIButton!
     
     func displayRandomButton() {
         for myButton in gameButtons {
             myButton.isHidden = true
         }
         let buttonIndex = Int.random(in: 0..<gameButtons.count)
         currentButton = gameButtons[buttonIndex]
         currentButton.center = CGPoint(x: randomXCoordinate(), y: randomYCoordinate())
         currentButton.isHidden = false
         
         let fontSize = Int.random(in: 17..<51)
         currentButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
     }
     
     func gameOver() {
         state = GameState.gameOver
         scoreLabel.textColor = .brown
         setupFreshGameState()
        
         
     }
     
     func setupFreshGameState() {
         playButton.isHidden = false
         for myButton in gameButtons {
             myButton.isHidden = true
         }
         scoreLabel.alpha = 0.15
         currentButton = bombButton
         state = GameState.gameOver
       
     }
     
     func randCGFloat(_ min: CGFloat, _ max: CGFloat) -> CGFloat {
         return CGFloat.random(in: min..<max)
     }
     
     func randomXCoordinate() -> CGFloat {
         let left = view.safeAreaInsets.left + currentButton.bounds.width
         let right = view.bounds.width - view.safeAreaInsets.right - currentButton.bounds.width
         return randCGFloat(left, right)
     }
     
     func randomYCoordinate() -> CGFloat {
         let top = view.safeAreaInsets.top + currentButton.bounds.height
         let bottom = view.bounds.height - view.safeAreaInsets.bottom - currentButton.bounds.height
         return randCGFloat(top, bottom)
     }
     
    
    func updatescoreLabel(_ newValue: Int) {
         scoreLabel.text = "\(newValue)"
     }

}



