//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public protocol SpecificAdaptor: class {    
    associatedtype RowItemType = RowItemProtocol
}

public class Adaptor: NSObject, UIPickerViewDelegate {

    unowned var delegate: PickLDelegate
    
    required public init(delegate: PickLDelegate) {
        self.delegate = delegate
    }
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return delegate.pickerView(pickerView, widthForComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate.pickerView(pickerView, didSelectRow: row, inComponent: component)
    }
}
