//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

fileprivate struct AssociatedKeys {
    static var didSelectHandler = "rsb_didSelectHandler"
    static var internalItemDidSelectHandler = "rsb_internalItemDidSelectHandler"
}

public typealias RowIndex = Int
public typealias ComponentIndex = Int
public typealias SelectionHandler = ((UIPickerView, RowIndex, ComponentIndex) -> Void)

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
        internalItemDidSelectHandler?(pickerView, row, component)
    }
}

extension RowItemProtocol {
    
    var internalItemDidSelectHandler: SelectionHandler? {
        get {
            return ClosureWrapper<SelectionHandler>.handler(for: self, key: &AssociatedKeys.internalItemDidSelectHandler)
        }
        set {
            ClosureWrapper<SelectionHandler>.setHandler(newValue, for: self, key: &AssociatedKeys.internalItemDidSelectHandler)
        }
    }
}
