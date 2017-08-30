//
//  UIView+RowItemProtocol.swift
//  Obolus
//
//  Created by Nikita Ermolenko on 16/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

extension UIView: RowItemProtocol {
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return self
    }
}
