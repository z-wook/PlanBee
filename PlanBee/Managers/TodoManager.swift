//
//  TodoManager.swift
//  PlanBee
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

final class TodoManager {
    private let storeManager = FirestoreManager()
    
    func saveTodo(saveTodo: Todo) -> Bool {
        if CoreDataManager.saveTodoData(todo: saveTodo) {
            Task {
                await storeManager.saveTodo(data: saveTodo)
            }
            return true
        }
        return false
    }
    
    func getDateList() -> [String] {
        let todoList = CoreDataManager.fetchTodoData()
        guard let todoList = todoList else { return [] }
        let dateList = todoList.map { todo in
            todo.date
        }
        return dateList
    }
    
    func getTodoList(date: Date?) -> [Todo] {
        guard let date = date,
              let list = CoreDataManager.fetchTodoData(date: date) else { return [] }
        let sortedList = list.sorted {
            $0.priority < $1.priority
        }
        return sortedList
    }
    
    func updateTodo(todo: Todo) async -> Bool {
        if CoreDataManager.updatePlanData(newTodo: todo) {
            Task {
                await storeManager.updateTodo(data: todo)
            }
            return true
        }
        return false
    }
    
    func removeTodo(todo: Todo) async -> Bool {
        if CoreDataManager.deletePlanData(todo: todo) {
            Task {
                await storeManager.deleteTodo(data: todo)
            }
            return true
        }
        return false
    }
    
    func textFieldIsFullWithBlank(text: String) -> Bool {
        let trimmedText = text.trimmingCharacters(in: .whitespaces)
        return trimmedText.isEmpty ? true : false
    }
    
    func moveTodo(date: Date?, startIndex: Int, destinationIndex: Int) async {
        var todoList = getTodoList(date: date)
        todoList.swapAt(startIndex, destinationIndex)
        let newIndex = destinationIndex + 1
        
        todoList[newIndex...].sort {
            $0.priority < $1.priority
        }
        
        for index in destinationIndex..<todoList.count {
            let updatedTodo = Todo(
                id: todoList[index].id,
                content: todoList[index].content,
                date: todoList[index].date,
                priority: Date(),
                done: todoList[index].done,
                alarm: todoList[index].alarm
            )
            _ = await updateTodo(todo: updatedTodo)
        }
    }
}
