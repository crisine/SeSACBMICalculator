//
//  AlertType.swift
//  SeSACBMICalculator
//
//  Created by Minho on 1/4/24.
//

enum AlertType: String, CustomStringConvertible {
    case invalidNicknameLength = "유효하지 않은 길이의 닉네임",
         invalidHeightInput = "유효하지 않은 키 입력",
         invalidWeightInput = "유효하지 않은 몸무게 입력",
         outOfHeightRange = "키 입력 범위 초과",
         outOfWeightRange = "몸무게 입력 범위 초과"
    
    var description: String {
        switch self {
        case .invalidNicknameLength:
            return "닉네임을 1~10자 사이로 입력해주세요"
        case .invalidHeightInput:
            return "정상적인 키 값을 숫자로 입력해주세요"
        case .invalidWeightInput:
            return "정상적인 몸무게 값을 숫자로 입력해주세요"
        case .outOfHeightRange:
            return "키 값이 범위를 벗어났습니다.\n(cm단위, 80~300)"
        case .outOfWeightRange:
            return "몸무게 값이 범위를 벗어났습니다.\n(kg단위, 20~200)"
        }
    }
}
