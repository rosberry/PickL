//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

extension NSAttributedString: RowStringItemProtocol {
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return self
    }
}

extension String: RowStringItemProtocol {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self
    }
}
