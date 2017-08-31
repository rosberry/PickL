//
//  RowStringItem.swift
//  Obolus
//
//  Created by Nikita Ermolenko on 17/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public protocol RowStringItem: RowItem {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
}

public extension RowStringItem {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return nil
    }
}
