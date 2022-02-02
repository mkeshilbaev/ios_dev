//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Madi Keshilbayev on 04.02.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit


private  var calculatorModel = Calculator()

class ViewController: UIViewController {
    
    var calculator = Calculator()
    
    var userIsTyping: Bool {
        set {
            if newValue {
                clearButton.setTitle("C", for: .normal)
            } else {
                clearButton.setTitle("AC", for: .normal)
            }
        }
        get {
            return clearButton.currentTitle! == "C"
        }
    }
    
    var displayValue: Double {
        get {
            if let value = display.text,
               let _ = Double(value) {
                return Double(value)!
            }
            return 0.0
        }
        set {
            display.text = String(Int(newValue))
        }
    }
    
    var isLandscapeOrientation: Bool = UIDevice.current.orientation.isLandscape {
        willSet {
            additionalButtons.isHidden = !newValue
        }
    }
    
    private var isSecond: Bool = false
    
    private let secondTextVariation: [String: String] = [
        "sin": "sin⁻¹",
        "cos": "cos⁻¹",
        "tan": "tan⁻¹",
        "sinh": "sinh⁻¹",
        "cosh": "cosh⁻¹",
        "tanh": "tanh⁻¹",
        "eˣ": "yˣ",
        "ln": "logᵧ",
        "10ˣ": "2ˣ",
        "log₁₀": "log₂"
    ]
    
    // MARK: Outlets
    @IBOutlet weak var additionalButtons: UIStackView!
    @IBOutlet var flippyButtons: [UIButton]!
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet var clearButton: RoundedButton!
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLandscapeOrientation = UIDevice.current.orientation.isLandscape
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        isLandscapeOrientation = UIDevice.current.orientation.isLandscape
    }
    
    // MARK: Actions
    @IBAction func touchDigit(_ sender: UIButton) {
        if let title = sender.currentTitle {
            if userIsTyping {
                display.text = display.text! + title
            } else {
                display.text = title
                userIsTyping = true
            }
        }
    }
    
    @IBAction func touchFloatingPoint(_ sender: UIButton) {
        if !display.text!.contains(sender.currentTitle!) {
            display.text = display.text! + sender.currentTitle!
        }
        userIsTyping = true
    }
    
    @IBAction func clearAll(_ sender: UIButton) {
        userIsTyping = false
        displayValue = 0.0
        calculator.clear()
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping {
            calculator.set(operand: Double(display.text!)!)
            userIsTyping = false
        }
        if let mathOperator = sender.currentTitle {
            calculator.performOperation(mathOperator)
        }
        display.text = String(calculator.result)
    }
    
    @IBAction func changeButtons(_ sender: UIButton) {
        isSecond = !isSecond
        changeParameters(of: sender)
        for button in flippyButtons {
            changeText(of: button)
        }
    }
    
}

extension ViewController {
    
    // MARK: Helper functions
    func changeParameters(of button: UIButton) {
        if isSecond {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
        } else {
            button.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.1294117719, blue: 0.1411764771, alpha: 1)
            button.setTitleColor(.white, for: .normal)
        }
    }
    
    func changeText(of button: UIButton) {
        if let title = button.currentTitle {
            button.setTitle(isSecond ? secondTextVariation[title] : secondTextVariation.key(for: title),
                            for: .normal)
        }
    }
    
}

extension Dictionary where Key == String, Value: Equatable {
    func key(for value: Value) -> Key? {
        return compactMap { value == $1 ? $0 : nil }.first
    }
}
