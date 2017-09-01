//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public class RowStringItem {
    
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

// MARK: - RowStringItemProtocol

extension RowStringItem: RowStringItemProtocol {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return title
    }
}
