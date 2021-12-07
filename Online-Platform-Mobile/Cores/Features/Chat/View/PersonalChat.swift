//
//  PersonalChat.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 07/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PersonalChat: View {
    @StateObject var messageVM = MessageViewModel()
    var target: ProfileChat
    var chatRoom: ChatRoom
    @State var messageField = ""
    
    var body: some View {
        VStack {
            List(messageVM.messages) { message in
                HStack {
                    Text(message.content)
                    Spacer()
                }
            }
            HStack {
                TextField("Enter Message ....", text: $messageField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    messageVM.sendMessage(content: messageField, docId: chatRoom.id)
                }, label: {
                    Text("Send")
                })
            }
        }
        .onAppear {
            messageVM.fetchData(docId: chatRoom.id)
        }
    }
}

struct PersonalChat_Previews: PreviewProvider {
    static var previews: some View {
        PersonalChat(target: ProfileChat(name: "Reva", photo: ""), chatRoom: ChatRoom(id: "", users: []))
    }
}
