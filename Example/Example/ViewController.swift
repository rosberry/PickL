//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import PickL

final class RowStringItem2: RowStringItem {}

final class ViewController: UIViewController {

    private lazy var pickL: PickL<StringAdaptor> = {
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.selectedRowsHandler { [weak self] colorIndex, stuffIndex in
            guard let self = self else {
                return
            }
            print(self.colors[colorIndex], self.stuff[stuffIndex])
        }
        return pickL
    }()

    private lazy var colors: [Color] = [.init(name: "Red", color: .red),
                                .init(name: "Black", color: .black),
                                .init(name: "Green", color: .green)]
    private lazy var stuff: [String] = ["Car", "Ferry", "House"]

    // MARK: - Subviews

    private lazy var pickerView: UIPickerView = .init()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(pickerView)

        pickL.pickerView.showsSelectionIndicator = true
        pickL.components = makeComponentItems()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerView.center = view.center
    }

    // MARK: - Private

    private func makeComponentItems() -> [ComponentItem<StringAdaptor>] {
        let attributedStrings = colors.map { color in
            NSAttributedString(string: color.name, attributes: [.foregroundColor: color.color])
        }

        let colorsComponentItem = ComponentItem<StringAdaptor>(rowItems: attributedStrings)
        colorsComponentItem.width = .value(80)

        let stuffComponentItem = ComponentItem<StringAdaptor>(rowItems: stuff.map(RowStringItem2.init))

        return [colorsComponentItem, stuffComponentItem]
    }
}
