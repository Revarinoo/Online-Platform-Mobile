//
//  ChatModel.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 07/12/21.
//

import Foundation

struct ChatRoom: Codable, Identifiable {
    var id: String
    var users: [Int]
}

struct ProfileChat : Identifiable {
    var id = UUID()
    var name: String
    var photo: String
}

struct ChatData: Identifiable {
    let id = UUID()
    let chatRooms: ChatRoom
    let targetUser: ProfileChat
    let lastMessage: String?
    let timeMessage: String?
}

struct Message: Codable, Identifiable {
    var id: String?
    var content: String
    var sender: Int
    var sentAt: Date
}
