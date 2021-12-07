//
//  MessageViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 06/12/21.
//

import Foundation
import SwiftUI
import Firebase

class MessageViewModel: ObservableObject {
    @Published var messages: [Message] = []
    private let db = Firestore.firestore()
    @ObservedObject var userProfile = UserHelper.shared
    
    func sendMessage(content: String, docId: String) {
        db.collection("chatrooms").document(docId).collection("messages").addDocument(data: [
            "sentAt": Date(),
            "sender": userProfile.user.id,
            "content": content
        ])
    }
    
    func fetchData(docId: String) {
        db.collection("chatrooms").document(docId).collection("messages").order(by: "sentAt", descending: false).addSnapshotListener { snapShot, error in
            guard let documents = snapShot?.documents else {
                return
            }
            
            DispatchQueue.main.async {
                self.messages = documents.map({ docSnapShot -> Message in
                    let data = docSnapShot.data()
                    let docId = docSnapShot.documentID
                    let content = data["content"] as? String ?? ""
                    let sender = data["sender"] as? Int ?? 0
                    let sentAt = (data["sentAt"] as? Timestamp)?.dateValue() ?? Date()
                    return Message(id: docId, content: content, sender: sender, sentAt: sentAt)
                })
            }
        }
    }
    
}
