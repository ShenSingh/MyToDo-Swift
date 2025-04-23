//
//  ContentView.swift
//  MyToDo
//
//  Created by Gayashan Ashinshana on 2025-04-23.
//

// Import SwiftUI framework to create UI elements
import SwiftUI
// Creating a struct to represent the UI of the app
struct ContentView: View {
    // Creating a property to store the new Todo item
    @State private var newTodoItem = ""
    @StateObject private var viewModel = TodoListViewModel()
    // Creating UI elements to represent the UI of the app
    var body: some View {
        // Creating a vertical stack to hold the UI elements
        VStack {
            // Creating a text view to display the title of the app
            Text("Todo List 📝")
                .font(.largeTitle)
                .padding()
            // Creating a list to display the list of Todo items
            List {
                // Creating a for each loop to iterate over the list of Todo items
                ForEach(viewModel.todoItems) { item in
                    // Creating a horizontal stack to hold the UI elements
                    HStack {
                        // Creating a text view to display the title of the Todo item
                        Text(item.title)
                            .strikethrough(item.isComplete)
                            .foregroundColor(item.isComplete ? .gray : .primary)
                        Spacer()
                        // Creating a button to toggle the completion status of the Todo item
                        Button(action: {
                            viewModel.toggleTodoItemCompletion(item)
                        }) {
                            Image(systemName: item.isComplete ? "checkmark.circle" : "circle")
                                .foregroundColor(item.isComplete ? Color.green : Color.red)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteTodoItem)
            }
            .cornerRadius(10)
            // Creating a horizontal stack to hold the UI elements to add a new Todo item
            HStack {
                // Creating a text field to enter the title of the new Todo item
                TextField("Enter new Todo item", text: $newTodoItem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                // Creating a button to add the new Todo item
                Button(action: {
                    viewModel.addTodoItem(title: newTodoItem)
                    newTodoItem = ""
                }) {
                    Text("Add")
                }
                .padding()
            }
        }
        .padding()
    }
}
// Creating a struct to represent the preview of the app
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
