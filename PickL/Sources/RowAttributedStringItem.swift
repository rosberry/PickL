//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

/// Convenient class for working with `String` representable row item wiw `didSelect` handler.
///
/// - note: `NSAttributedString` already conforms to `RowStringItemProtocol`.
open class RowAttributedStringItem: RowItem {

    /// Attributed title value for row item.
    public var attributedTitle: NSAttributedString

    public init(attributedTitle: NSAttributedString) {
        self.attributedTitle = attributedTitle
    }
}

// MARK: - RowStringItemProtocol

extension RowAttributedStringItem: RowStringItemProtocol {
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return attributedTitle
    }
}
