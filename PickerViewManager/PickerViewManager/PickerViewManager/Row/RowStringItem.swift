//
//  RowStringItem.swift
//  Obolus
//
//  Created by Nikita Ermolenko on 17/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

class RowStringItem: RowItemProtocol {
    
    var title: String

    init(title: String) {
        self.title = title
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return title
    }
}
