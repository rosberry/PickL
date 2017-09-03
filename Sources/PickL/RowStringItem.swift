//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

open class RowStringItem {
    
    public var title: String
    
    public init(title: String) {
        self.title = title
    }
}

// MARK: - RowStringItemProtocol

extension RowStringItem: RowStringItemProtocol {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return title
    }
}
