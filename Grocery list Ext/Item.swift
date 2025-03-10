//
//  Item.swift
//  Grocery list Ext
//
//  Created by Rahul choudhary on 30/01/25.
//

import Foundation
import SwiftData

@Model
class Item {
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = false
    }
}
