//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

/// Convenient class for working `String` representable row items. Handy when you need to implement a `didSelectHandler`.
///
/// - note: `String` already conforms to `RowStringItemProtocol`.
open class RowStringItem {
    
    /// Title value for row item.
    public var title: String
    
    public init(title: String) {
        self.title = title
    }
}

// MARK: - RowStringItemProtocol

extension RowStringItem: RowStringItemProtocol {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return title
    }
}
