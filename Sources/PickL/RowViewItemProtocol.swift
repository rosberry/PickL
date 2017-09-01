//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public protocol RowViewItemProtocol: RowItemProtocol {

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
}
