//
//  Speaker.swift
//  DeepDishLie
//
//  Created by Morten Bjerg Gregersen on 26/04/2024.
//

import Foundation

struct Speaker: Decodable, Identifiable {
    var id: String { name }
    let name: String
    let image: String
    let links: Links?
}
