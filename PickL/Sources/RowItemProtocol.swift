//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

/// Base row item protocol for implementing string/view representable row items.
///
/// - note: You shouldn't directly use this protocol. Use `RowStringItemProtocol` and `RowViewItemProtocol` instead.
public protocol RowItemProtocol {

    /// Called by the picker view when the user selects a row in a component.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
}

public extension RowItemProtocol {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
}
