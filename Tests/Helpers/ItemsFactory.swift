//
//  ItemsFactory.swift
//  PickLTests
//
//  Created by Nikita Ermolenko on 06/09/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation
import PickL

func makeStringComponentItem(withRowItemsCount count: Int) -> ComponentItem<StringAdaptor> {
    let rowItems = Array(1...count).map { value -> RowStringItem in
        return RowStringItem(title: "title")
    }
    return ComponentItem<StringAdaptor>(rowItems: rowItems)
}
