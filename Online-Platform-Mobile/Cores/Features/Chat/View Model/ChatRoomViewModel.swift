//
//  ChatRoomViewModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 06/12/21.
//

import Foundation
import SwiftUI
import Firebase

class ChatRoomViewModel: ObservableObject {
    @ObservedObject var userProfile = UserHelper.shared
    private var db = Firestore.firestore()
    @Published var chatData: [ChatData] = []
    @Published var chatRooms: [ChatRoom] = []
    private var service = UserService()
    @AppStorage("role", store: .standard) var role = ""
    @Published var countData = 0
    
    func removeData() {
        self.chatRooms.removeAll()
        self.chatData.removeAll()
    }
    
    func getData() {
        removeData()
        db.collection("chatrooms").whereField("users", arrayContains: userProfile.user.id).addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                return
            }
            self.chatRooms = documents.map({ docSnaphot -> ChatRoom in
                let data = docSnaphot.data()
                let docId = docSnaphot.documentID
                let users = data["users"] as? [Int] ?? []
                self.getUser(id: users[self.role == "Client" ? 1 : 0]) { [weak self] data in
                    DispatchQueue.main.async {
                        self!.getLastMessage(docId: docId) { [weak self] lastMsg, timeMsg  in
                            self!.checkData(docId: docId)
                            self!.chatData.append(ChatData(chatRooms: ChatRoom(id: docId, users: users), targetUser: data, lastMessage: lastMsg, timeMessage: timeMsg))
                            self!.sortChat()
                        }
                    }
                }
                
                return ChatRoom(id: docId, users: users)
            })
        }
    }
    
    private func checkData(docId: String) {
        for (index, data) in chatData.enumerated() {
            if data.chatRooms.id == docId {
                chatData.remove(at: index)
            }
        }
    }
    
    private func sortChat() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        chatData.sort{
            dateFormatter.date(from: $0.timeMessage!)! > dateFormatter.date(from: $1.timeMessage!)!
        }
    }
    
    func getLastMessage(docId: String, result: @escaping(_ lastMsg: String, _ timeMsg: String)-> Void) {
        var messages: [Message] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        db.collection("chatrooms").document(docId).collection("messages").order(by: "sentAt", descending: false).addSnapshotListener { snapShot, error in
            guard let documents = snapShot?.documents else {
                return
            }
            
            messages = documents.map({ docSnapShot -> Message in
                let data = docSnapShot.data()
                let docId = docSnapShot.documentID
                let content = data["content"] as? String ?? ""
                let sender = data["sender"] as? Int ?? 0
                let sentAt = (data["sentAt"] as? Timestamp)?.dateValue() ?? Date()
                return Message(id: docId, content: content, sender: sender, sentAt: sentAt)
            })
            
            result(messages.last?.content ?? "", dateFormatter.string(from: messages.last?.sentAt ?? Date()))
        }
    }
    
    func getUser(id: Int, completion: @escaping(_ data: ProfileChat)->Void) {
        service.getSpecificUserProfile(userId: id) { result in
            if let name = result?.name, let photo = result?.photo {
                completion(.init(name: name, photo: photo))
            }
        }
    }
    
    func createChatRoom(target: Int) -> Bool {
        if isCreated(user: userProfile.user.id, target: target) { return false }
        var target1 = userProfile.user.id
        var target2 = target
        if role == "Seller" {
            target1 = target
            target2 = userProfile.user.id
        }
        db.collection("chatrooms").addDocument(data: ["users": [target1, target2]]) { err in
            if let err = err {
                print(err.localizedDescription)
            }
        }
        return true
    }
    
    private func isCreated(user: Int, target: Int) -> Bool {
        for data in chatData {
            if data.chatRooms.users.contains(user) && data.chatRooms.users.contains(target) {
                return true
            }
        }
        return false
    }
}
