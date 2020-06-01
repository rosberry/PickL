//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

/// Special protocol for implementing view representable row items.
public protocol RowViewItemProtocol: RowItemProtocol {

    /// Called by the picker view when it needs the view to use for a given row in a given component.
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
}
