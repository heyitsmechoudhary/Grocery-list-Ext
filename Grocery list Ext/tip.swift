//
//  tip.swift
//  Grocery list Ext
//
//  Created by Rahul choudhary on 04/02/25.
//

import Foundation
import TipKit

struct ButtonTip: Tip {
    var title: Text = Text("Essential foods!")
    var message: Text? = Text("Add some essentials items to your list!")
    var image: Image? = Image(systemName: "info.circle")
}
