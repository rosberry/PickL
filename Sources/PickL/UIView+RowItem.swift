//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

extension UIView: RowViewItemProtocol {
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return self
    }
}
