//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

open class RowItem {

    public typealias SelectionHandler = ((_ rowIndex: RowIndex, _ componentIndex: ComponentIndex) -> Void)

    /// The handler for detecting row selection.
    public var didSelectHandler: SelectionHandler?
}

// MARK: - RowStringItemProtocol

extension RowItem: RowItemProtocol {
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelectHandler?(row, component)
    }
}
