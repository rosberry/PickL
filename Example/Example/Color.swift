//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

final class Color {

    let name: String
    let color: UIColor

    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}

extension Color: CustomDebugStringConvertible {

    var debugDescription: String {
        name
    }
}
