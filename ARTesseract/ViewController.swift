//
//  ViewController.swift
//  ARTesseract
//
//  Created by Magdusz on 24.04.2018.
//  Copyright © 2018 com.McPusz.ARTesseract. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    // Stack view buttons
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    // Input View
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!
    @IBOutlet weak var zTextField: UITextField!
    // Challenge info view
    @IBOutlet weak var infoView: UIView!
    
    //showing/hiding challengeView
    private var infoVisible: Bool = false {
        didSet {
            let buttonImage = infoVisible ? #imageLiteral(resourceName: "cancel_button") : #imageLiteral(resourceName: "bulb_icon")
            self.infoButton.setImage(buttonImage, for: .normal)
            self.infoView.isHidden = !infoVisible
        }
    }
    
    private var gameResult: GameResult = .lost
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
    }
    
    deinit {
        self.removeKeyboardObservers()
    }
    
    @IBAction func showChallengeInfo(_ sender: UIButton) {
        self.infoVisible = !self.infoVisible
    }
}

//MARK: Textfields
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    private func getInputPosition() -> SCNVector3? {
        guard let xPosString = self.xTextField.text,
            let yPosString = self.yTextField.text,
            let zPosString = zTextField.text,
            let xPosFloat = Float(xPosString),
            let yPosFloat = Float(yPosString),
            let zPosFloat = Float(zPosString) else {
                print("Wrong input")
                return nil
        }
        return SCNVector3Make(xPosFloat, yPosFloat, zPosFloat)
    }
    
    private func clearInput() {
        [self.xTextField,
         self.yTextField,
         self.zTextField].forEach{ $0?.text = nil }
    }
}
