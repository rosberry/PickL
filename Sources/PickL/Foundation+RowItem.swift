//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

/// Convenience extension of `NSAttributedString`.
///
/// ```
///  let rowItem = NSAttributedString(string: "Hey", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
///  let componentItem1 = ComponentItem<StringAdaptor>(rowItems: [rowItem1])
/// ```
extension NSAttributedString: RowStringItemProtocol {
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return self
    }
}

/// Convenience extension of `String`.
/// ```
///  let componentItem1 = ComponentItem<StringAdaptor>(rowItems: ["item1", "item2"])
/// ```
/// - note: Due to some swift struct's features, `itemDidSelectHandler` doesn't work in this case.
extension String: RowStringItemProtocol {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self
    }
}
