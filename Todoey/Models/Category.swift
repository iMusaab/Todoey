//
//  Category.swift
//  Todoey
//
//  Created by Musaab mohammed on 21/08/2019.
//  Copyright © 2019 Musaab mohammed. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc var name: String = ""
    let items = List<Item>()
}
