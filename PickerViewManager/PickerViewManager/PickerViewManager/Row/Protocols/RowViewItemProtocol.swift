//
//  RowViewItemProtocol.swift
//  PickerViewManager
//
//  Created by Nikita Ermolenko on 31/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public protocol RowViewItemProtocol: RowItemProtocol {

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
}
