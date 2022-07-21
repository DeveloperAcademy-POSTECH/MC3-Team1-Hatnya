//
//  UIColor+Extension.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit
import Foundation

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor) {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 11, width: viewSize, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
}

extension GetInfoView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.underlined(viewSize: self.valueTextField.bounds.width, color: UIColor.blue)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlined(viewSize: self.valueTextField.bounds.width, color: UIColor.gray)
    }
}

extension CyclePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return cycles.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return cycles[row]
        } else {
            return "주"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print("row: \(row)")
            print("value: \(cycles[row])")
            selectedCycleLabel.text = cycles[row] + "주"
        }
    }
}

extension CyclePickerView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if isShown == true {
            pickerView.isHidden = true
        } else {
            pickerView.isHidden = false
        }
        isShown.toggle()
        return true
    }
}

extension SelectCycleDaysView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        var completeSentence = ""
        let selectedCycle = cyclePickerView.selectedCycleLabel.text ?? ""
        
        var days: [String] = []
        
        if dayButtonStackView.sundayButton.isSelected {
            days.append("일")
        }
        if dayButtonStackView.mondayButton.isSelected {
            days.append("월")
        }
        if dayButtonStackView.tuesdayButton.isSelected {
            days.append("화")
        }
        if dayButtonStackView.wednesdayButton.isSelected {
            days.append("수")
        }
        if dayButtonStackView.thursdayButton.isSelected {
            days.append("목")
        }
        if dayButtonStackView.fridayButton.isSelected {
            days.append("금")
        }
        if dayButtonStackView.saturdayButton.isSelected {
            days.append("토")
        }
        
        completeSentence = "숙제가 " + selectedCycle + "마다 "
        days.forEach { day in
            completeSentence = completeSentence + day + ", "
        }
        completeSentence = completeSentence + "에 반복됩니다."
        selectedCycleDaysLabel.text = completeSentence
        return true
    }
}
