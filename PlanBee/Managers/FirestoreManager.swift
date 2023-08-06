//
//  FirestoreManager.swift
//  PlanBee
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class FirestoreManager {
    private let fireManager = FirebaseManager()
    private let dataBase = Firestore.firestore().collection("User")
    
    func saveTodo(data: Todo) async {
        guard let uid = fireManager.getUID() else { return }
        
        var retryCount = 0
        while retryCount < 3 {
            do {
                try await dataBase.document(uid)
                    .collection(data.date).document(data.id.uuidString).setData(
                        [
                            "id": data.id.uuidString,
                            "content": data.content,
                            "date": data.date,
                            "priority": data.priority,
                            "done": data.done,
                            "alarm": data.alarm ?? "nil"
                        ]
                    )
                print("Document successfully added!")
                return
            } catch {
                print("Error adding document: \(error.localizedDescription)")
                retryCount += 1
            }
        }
        print("Max retry count reached, document could not be added.")
    }
    
    func deleteTodo(data: Todo) async {
        guard let uid = fireManager.getUID() else { return }
        
        var retryCount = 0
        while retryCount < 3 {
            do {
                try await dataBase.document(uid)
                    .collection(data.date).document(data.id.uuidString).delete()
                print("Document successfully removed!")
                return
            } catch {
                print("Error removing document: \(error.localizedDescription)")
                retryCount += 1
            }
        }
        print("Max retry count reached, document could not be removed.")
    }
    
    // 우선순위, 완료, 알림 수정 가능
    func updateTodo(data: Todo) async {
        guard let uid = fireManager.getUID() else { return }
        
        var retryCount = 0
        while retryCount < 3 {
            do {
                try await dataBase.document(uid)
                    .collection(data.date).document(data.id.uuidString).updateData(
                        [
                            "priority": data.priority,
                            "done": data.done,
                            "alarm": data.alarm ?? "nil"
                        ]
                    )
                print("Document successfully updated!")
                return
            } catch {
                print("Error updating document: \(error.localizedDescription)")
                retryCount += 1
            }
        }
        print("Max retry count reached, document could not be updated.")
    }
}
