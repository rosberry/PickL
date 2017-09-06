//
//  Copyright © 2017 Rosberry. All rights reserved.
//

open class RowItem {

    /// The handler for detecting row selection.
    public var didSelectHandler: SelectionHandler?    
}

// MARK: - RowStringItemProtocol

extension RowItem: RowItemProtocol {
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelectHandler?(row, component)
    }
}
