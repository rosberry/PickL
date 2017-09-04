//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

fileprivate struct AssociatedKeys {
    static var didSelectHandler = "rsb_didSelectHandler"
}

public typealias SelectionHandler = ((_ pickerView: UIPickerView, _ rowIndex: Int, _ componentIndex: Int) -> Void)

public protocol RowItemProtocol {

    var itemDidSelectHandler: SelectionHandler? { get set }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
}

public extension RowItemProtocol {
    
    var itemDidSelectHandler: SelectionHandler? {
        get {
            return ClosureWrapper<SelectionHandler>.handler(for: self, key: &AssociatedKeys.didSelectHandler)
        }
        set {
            ClosureWrapper<SelectionHandler>.setHandler(newValue, for: self, key: &AssociatedKeys.didSelectHandler)
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        itemDidSelectHandler?(pickerView, row, component)
    }
}
