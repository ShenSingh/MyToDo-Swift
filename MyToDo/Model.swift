//
//  Model.swift
//  MyToDo
//
//  Created by Gayashan Ashinshana on 2025-04-23.
//

import Foundation
// Creating a struct to represent a Todo item
// It is the model of the app and conforms to Identifiable and Codable protocols
struct TodoItem: Identifiable, Codable {
    var id = UUID()
    let title: String
    var isComplete = false
}
