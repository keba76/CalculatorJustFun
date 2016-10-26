//
//  ViewController.swift
//  CalculatorJustFun
//
//  Created by Ievgen Keba on 10/25/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    private var btnSound: AVAudioPlayer!
    private var typing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btnSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        outputLbl.text = String(0.0)
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playsound()
        if typing {
            let textCurrentlyInDisplay = outputLbl.text!
            outputLbl.text = textCurrentlyInDisplay + String(Double(sender.tag))
        } else {
            outputLbl.text = String(Double(sender.tag))
            typing = true
        }
    }
    @IBAction func performOperation(sender: UIButton) {
        playsound()
        if typing {
            calculator.setOp(operand: displayValue)
            typing = false
        }
        calculator.performOp(symbol: String(sender.tag))
        displayValue = calculator.result
    }
    
    private func playsound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    var calculator = Calculator()
    
    var displayValue: Double {
        get {
            return Double(outputLbl.text!)!
        }
        set {
            outputLbl.text = String(newValue)
        }
    }
}

