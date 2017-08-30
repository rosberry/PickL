//
//  Foundation+RowItemProtocol.swift
//  Obolus
//
//  Created by Nikita Ermolenko on 16/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

extension NSAttributedString: RowItemProtocol {
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return self
    }
}

extension String: RowItemProtocol {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self
    }
}
