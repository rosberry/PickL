//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

/// Special adaptor for working with string representable row items: `String`, `NSAttributedString`.
public final class StringAdaptor: Adaptor, SpecificAdaptor {

    public typealias RowItemType = RowStringItemProtocol

    // MARK: - UIPickerViewDelegate

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return delegate.pickerView(pickerView, titleForRow: row, forComponent: component)
    }

    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return delegate.pickerView(pickerView, attributedTitleForRow: row, forComponent: component)
    }
}
