//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

/// Convenient extension of `NSAttributedString`.
///
/// ```
///  let rowItem = NSAttributedString(string: "Hey", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
///  let componentItem = ComponentItem<StringAdaptor>(rowItems: [rowItem])
/// ```
extension NSAttributedString: RowStringItemProtocol {
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return self
    }
}

/// Convenient extension of `String`.
/// ```
///  let componentItem = ComponentItem<StringAdaptor>(rowItems: ["item1", "item2"])
/// ```
extension String: RowStringItemProtocol {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self
    }
}
