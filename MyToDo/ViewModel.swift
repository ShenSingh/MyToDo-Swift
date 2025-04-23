//
//  ViewModel.swift
//  MyToDo
//
//  Created by Gayashan Ashinshana on 2025-04-23.
//

import Foundation
// Creating a class to represent the view model of the app
// It is responsible for managing the data and logic of the app
class TodoListViewModel: ObservableObject {
    // Creating a property to store the list of Todo items
    @Published var todoItems: [TodoItem] {
        didSet {
            saveTodoItems()
        }
    }
    // Creating a property to store the user defaults object
    // It is used to store the list of Todo items in the user defaults (local storage)
    private let userDefaults = UserDefaults.standard
    private let todoItemsKey = "TodoItems"
    // Creating a constructor to initialize the view model
    init() {
        // Loading the list of Todo items from the user defaults
        if let data = userDefaults.data(forKey: todoItemsKey),
           let savedTodoItems = try? JSONDecoder().decode([TodoItem].self, from: data) {
            todoItems = savedTodoItems
        } else {
            todoItems = []
        }
    }
    // Creating a method to add a new Todo item
    func addTodoItem(title: String) {
        let trimmedItem = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedItem.isEmpty else { return }
        let newTodo = TodoItem(title: trimmedItem)
        todoItems.append(newTodo)
    }
    // Creating a method to delete a Todo item
    func deleteTodoItem(atOffsets offsets: IndexSet) {
        todoItems.remove(atOffsets: offsets)
    }
    // Creating a method to toggle the completion status of a Todo item
    func toggleTodoItemCompletion(_ item: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].isComplete.toggle()
        }
    }
    // Creating a method to save the list of Todo items in the user defaults
    private func saveTodoItems() {
        if let encoded = try? JSONEncoder().encode(todoItems) {
            userDefaults.set(encoded, forKey: todoItemsKey)
        }
    }
}
