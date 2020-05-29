//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

/// Special adaptor for working with view representable row items.
public final class ViewAdaptor: Adaptor, SpecificAdaptor {

    public typealias RowItemType = RowViewItemProtocol

    // MARK: - UIPickerViewDelegate

    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return delegate.pickerView(pickerView, viewForRow: row, forComponent: component, reusing: view)
    }
}
