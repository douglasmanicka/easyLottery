//
//  ViewController.swift
//  easyLottery
//
//  Created by Douglas Manicka on 12/11/19.
//  Copyright © 2019 Douglas Manicka. All rights reserved.
//

import UIKit

infix operator >-<
func >-< (total: Int, universe:Int ) -> [Int] {
    var result: [Int] = []
    while result.count < total{
        let number  = Int(arc4random_uniform(UInt32(universe))+1)
        if !result.contains(number){
            result.append(number)
        }
    }
    return result.sorted()
}

class ViewController: UIViewController {
    
    //change status bar color to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    enum GameType: String {
        case megasena = "Mega-Sena"
        case quina = "Quina"
    }
    
   

    @IBOutlet weak var lbGameType: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    @IBOutlet weak var btnGenerateGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        showNumber(for: .megasena)
      
        switch NSLocale.current.languageCode {
        case "pt_BR":
           btnGenerateGame.setTitle("Gerar Jogo", for: .normal)
        default:
           btnGenerateGame.setTitle("Generate Game", for: .normal)
        }
    }
    
    func showNumber(for type: GameType){
        lbGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
        case .megasena:
            game =  6>-<60
            balls.last?.isHidden = false
        case .quina:
            game =  5>-<80
            balls.last?.isHidden = true
       }
        for (index, numberBall) in game.enumerated(){
            balls[index].setTitle("\(numberBall)", for: .normal)
        }
    }

    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex {
        case 0:
            showNumber(for: .megasena)
        default:
            showNumber(for: .quina)
        }
    }
    
}

