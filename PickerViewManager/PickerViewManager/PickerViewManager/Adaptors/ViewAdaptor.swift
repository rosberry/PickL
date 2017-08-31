//
//  ViewAdaptor.swift
//  PickerViewManager
//
//  Created by Nikita Ermolenko on 31/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public final class ViewAdaptor: NSObject, Adaptor {

    public typealias RowItemType = RowViewItem
    public var components: [ComponentItem<ViewAdaptor>] = []
}

public extension ViewAdaptor {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return components[component][row].pickerView(pickerView, viewForRow: row, forComponent: component, reusing: view)
    }
}
