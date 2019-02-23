//
//  Category.swift
//  toDoListApp
//
//  Created by Rafael Asencio on 23/10/2018.
//  Copyright © 2018 Rafael Asencio. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var colour : String = ""
    let items = List<Item>()
}
