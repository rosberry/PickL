//
//  Copyright © 2017 Rosberry. All rights reserved.
//

/// Convenient class for working with `String` representable row item wiw `didSelect` handler.
///
/// - note: `String` already conforms to `RowStringItemProtocol`.
open class RowStringItem: RowItem {
    
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
