//
//  ItemsFactory.swift
//  PickL
//
//  Created by Nikita Ermolenko on 06/09/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation
import PickL

func makeStringComponentItem() -> ComponentItem<StringAdaptor> {
    return ComponentItem<StringAdaptor>(rowItems: [])
}

func makeStringComponentItem(withRowItemsCount count: Int) -> ComponentItem<StringAdaptor> {
    return ComponentItem<StringAdaptor>(rowItems: Array(1...count).map { i in
        return RowStringItem(title: "title\(i)")
    })
}
