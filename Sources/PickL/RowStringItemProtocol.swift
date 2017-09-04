//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

/// Special protocol for implementing string representable row items.
public protocol RowStringItemProtocol: RowItemProtocol {

    /// Called by the picker view when it needs the title to use for a given row in a given component.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    
    /// Called by the picker view when it needs the styled title to use for a given row in a given component.
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
}

public extension RowStringItemProtocol {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return nil
    }
}
