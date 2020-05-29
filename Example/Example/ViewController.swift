//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import PickL

class RowStringItem2: RowStringItem {}

class ViewController: UIViewController {

    let pickerView = UIPickerView()
    lazy var pickL = PickL<StringAdaptor>(pickerView: self.pickerView)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(pickerView)

        let redRowItem = NSAttributedString(string: "Red", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        let blackRowItem = NSAttributedString(string: "Black", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        let greenRowItem = NSAttributedString(string: "Green", attributes: [NSAttributedString.Key.foregroundColor: UIColor.green])

        let colorsComponentItem = ComponentItem<StringAdaptor>(rowItems: [redRowItem, blackRowItem, greenRowItem])
        colorsComponentItem.width = .value(80)

        let carItem = RowStringItem2(title: "Car")
        let ferryItem = RowStringItem2(title: "Ferry")

        let stuffComponentItem = ComponentItem<StringAdaptor>(rowItems: [carItem, ferryItem, "House"])
        stuffComponentItem.height = .auto

        pickL.pickerView.showsSelectionIndicator = true
        pickL.components = [colorsComponentItem, stuffComponentItem]

        pickL.selectedRowsArrayHandler { selectedRows in
            print(selectedRows)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerView.center = view.center
    }
}
