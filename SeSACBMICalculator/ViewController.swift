//
//  ViewController.swift
//  SeSACBMICalculator
//
//  Created by Minho on 1/4/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var heightInputTextField: UITextField!
    @IBOutlet weak var weightInputTextField: UITextField!
    @IBOutlet weak var randomInputButton: UIButton!
    @IBOutlet weak var calculateBMIButton: UIButton!
    @IBOutlet weak var resetUserInfoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightInputTextField.textContentType = .telephoneNumber
        weightInputTextField.textContentType = .telephoneNumber
        loadUserInfo()
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
        
        let nickname = nicknameTextField.text == "" ? "아무개" : nicknameTextField.text!
        
        let alert = UIAlertController(title: "\(nickname)님의 BMI 지수", message: "\(bmiValue)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
        
        saveUserInfo(nickname: nickname, height: height, weight: weight)
    }
    
    @IBAction func didRandomInputButtonTapped(_ sender: UIButton) {
        heightInputTextField.text = String(format: "%.2f", Double.random(in: 40...300))
        weightInputTextField.text = String(format: "%.2f", Double.random(in: 20...200))
    }
    
    @IBAction func didEndEditingInNicknameTextField(_ sender: UITextField) {
        let nicknameLength = sender.text?.count ?? 0
        
        if nicknameLength <= 0 || nicknameLength > 10 {
            let alert = createAlert(alertType: .invalidNicknameLength)
            present(alert, animated: true)
        }
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
    
    func saveUserInfo(nickname: String, height: Double, weight: Double) {
        // struct로 유저정보를 관리하면 좋을듯하나 시간상 차후로..
        UserDefaults.standard.setValue(nickname, forKey: "nickname")
        UserDefaults.standard.setValue(height, forKey: "height")
        UserDefaults.standard.setValue(weight, forKey: "weight")
    }
    
    // -> User 를 반환하는것이 좀 더 옳은 방안이라고 생각되나 이쪽도..
    func loadUserInfo() {
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            nicknameTextField.text = nickname
        } else {
            nicknameTextField.text = nil
        }
        
        let height = UserDefaults.standard.double(forKey: "height")
        heightInputTextField.text = height == 0 ? "" : String(format: "%.2f", height)
        
        let weight = UserDefaults.standard.double(forKey: "weight")
        weightInputTextField.text = weight == 0 ? "" : String(format: "%.2f", weight)
    }
    
    
    @IBAction func didResetUserInfoButtonTapped(_ sender: UIButton) {
        /// Alert 띄워서 어떤 정보를 없앨지 분기처리하거나,
        /// 한번에 없앨거면 User struct 나중에 만드는 것으로.
        UserDefaults.standard.removeObject(forKey: "nickname")
        UserDefaults.standard.removeObject(forKey: "height")
        UserDefaults.standard.removeObject(forKey: "weight")
        loadUserInfo()
    }
}

