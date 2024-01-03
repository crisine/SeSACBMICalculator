//
//  ViewController.swift
//  SeSACBMICalculator
//
//  Created by Minho on 1/4/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightInputTextField: UITextField!
    @IBOutlet weak var weightInputTextField: UITextField!
    @IBOutlet weak var randomInputButton: UIButton!
    @IBOutlet weak var calculateBMIButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightInputTextField.textContentType = .telephoneNumber
        weightInputTextField.textContentType = .telephoneNumber
    }
    
    @IBAction func didCalculateBMIButtonTapped(_ sender: UIButton) {
        
        guard let height = getHeight() else {
            let alert = createAlert(alertType: .invalidHeightInput)
            present(alert, animated: true)
            return
        }
        
        guard let weight = getWeight() else {
            let alert = createAlert(alertType: .invalidWeightInput)
            present(alert, animated: true)
            return
        }
        
        guard height >= 40 && height <= 300 else {
            let alert = createAlert(alertType: .outOfHeightRange)
            present(alert, animated: true)
            return
        }
        
        guard weight >= 20 && weight <= 200 else {
            let alert = createAlert(alertType: .outOfWeightRange)
            present(alert, animated: true)
            return
        }
        
        let bmiValue = calculateBMIValue(height: height, weight: weight)
        
        let alert = UIAlertController(title: "당신의 BMI 지수", message: "\(bmiValue)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @IBAction func didRandomInputButtonTapped(_ sender: UIButton) {
        heightInputTextField.text = String(Int.random(in: 40...300))
        weightInputTextField.text = String(Int.random(in: 20...200))
    }
    
    
    @IBAction func didEndEditingInHeightTextField(_ sender: UITextField) {
        guard let height = getHeight() else {
            let alert = createAlert(alertType: .invalidHeightInput)
            present(alert, animated: true)
            return
        }
    }
    
    @IBAction func didEndEditingInWeightTextField(_ sender: UITextField) {
        guard let weight = getWeight() else {
            let alert = createAlert(alertType: .invalidWeightInput)
            present(alert, animated: true)
            return
        }
    }
    
    func createAlert(alertType: AlertType) -> UIAlertController {
        return Alert.create(title: alertType.rawValue, message: alertType.description, okTitle: "확인") { }
    }
    
    func getHeight() -> Double? {
        return Double(heightInputTextField.text ?? "")
    }
    
    func getWeight() -> Double? {
        return Double(weightInputTextField.text ?? "")
    }
    
    func calculateBMIValue(height: Double, weight: Double) -> String {
        return String(format: "%.2f", weight / pow(height / 100.0, 2.0))
    }
}

