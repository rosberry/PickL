//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public protocol SpecificAdaptor: class {
    associatedtype RowItemType = RowItemProtocol
}

/// Base adaptor for working with string/view representable row items.
public class BaseAdaptor: NSObject {

    unowned var delegate: PickLDelegate

    required init(delegate: PickLDelegate) {
        self.delegate = delegate
    }
}

// MARK: - UIPickerViewDelegate

extension BaseAdaptor: UIPickerViewDelegate {

    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return delegate.pickerView(pickerView, widthForComponent: component)
    }

    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return delegate.pickerView(pickerView, rowHeightForComponent: component)
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate.pickerView(pickerView, didSelectRow: row, inComponent: component)
    }
}
