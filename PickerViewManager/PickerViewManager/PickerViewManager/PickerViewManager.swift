//
//  PickerViewManager.swift
//  Obolus
//
//  Created by Nikita Ermolenko on 16/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

fileprivate final class PickerViewManagerDataSource: NSObject, UIPickerViewDataSource {

    private typealias Component = Int
    
    private let numberOfComponentsHandler: (UIPickerView) -> Int
    private let numberOfRowsInComponentHandler: (UIPickerView, Component) -> Int

    init(numberOfComponentsHandler: @escaping (UIPickerView) -> Int, numberOfRowsInComponentHandler: @escaping (UIPickerView, Int) -> Int) {
        self.numberOfComponentsHandler = numberOfComponentsHandler
        self.numberOfRowsInComponentHandler = numberOfRowsInComponentHandler
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.numberOfComponentsHandler(pickerView)
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.numberOfRowsInComponentHandler(pickerView, component)
    }
}

open class PickerViewManager<AdaptorType> where AdaptorType: Adaptor {

    unowned let pickerView: UIPickerView
    private let adaptor: AdaptorType
    
    private lazy var dataSource: PickerViewManagerDataSource = {
        return PickerViewManagerDataSource(numberOfComponentsHandler: { [unowned self] _ in
            return self.components.count
        }, numberOfRowsInComponentHandler: { [unowned self] _, component in
            return self.components[component].rowItems.count
        })
    }()
    
    var components: [ComponentItem<AdaptorType>] = [] {
        didSet {
            adaptor.components = components
            for component in components {
                component.pickerViewManager = self
                component.pickerView = pickerView
            }
            pickerView.reloadAllComponents()
        }
    }
    
    init(pickerView: UIPickerView) {
        self.pickerView = pickerView
        self.adaptor = AdaptorType()

        pickerView.dataSource = dataSource
        pickerView.delegate = self.adaptor
    }
}
