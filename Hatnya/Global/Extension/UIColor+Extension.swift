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
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
//        apickerView.isHidden = true
//        return true
//    }
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
