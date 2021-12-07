//
//  ChatList.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 07/12/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Introspect

struct ChatList: View {
    @StateObject var chatVM = ChatRoomViewModel()
    @State var uiTabBarController: UITabBarController?
    
    var body: some View {
        VStack {
            Divider().background(Color.init(hex: "A7A7A7"))
            ScrollView (.vertical, showsIndicators: false) {
                ForEach(chatVM.chatData, id: \.id) { data in
                    NavigationLink(destination: PersonalChat(target: data.targetUser, chatRoom: data.chatRooms)) {
                        VStack {
                            HStack {
                                WebImage(url: URL(string: data.targetUser.photo))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                
                                VStack (alignment: .leading, spacing: 4) {
                                    Text(data.targetUser.name)
                                        .font(.custom(ThemeFont.displayMedium, size: 15))
                                        .foregroundColor(.black)
                                    
                                    Text(data.lastMessage ?? "")
                                        .font(.custom(ThemeFont.displayRegular, size: 13))
                                        .foregroundColor(Color.init(hex: "999999"))
                                }
                                .padding([.leading, .trailing], 10)
                                .frame(minWidth: 245, idealWidth: 245, alignment: .leading)
                                
                                VStack {
                                    Text(data.timeMessage ?? "09:41")
                                        .font(.custom(ThemeFont.displayRegular, size: 12))
                                        .foregroundColor(Color.init(hex: "999999"))
                                }
                            }
                            .padding([.leading, .trailing], 16)
                            .frame(width: UIScreen.main.bounds.width, height: 84, alignment: .leading)
                            
                            
                            Divider().background(Color.init(hex: "E4E4E4"))
                        }
                    }
                }
            }
        }
        .onAppear {
            chatVM.getData()
        }
        .introspectTabBarController { (UITabBarController) in
            UITabBarController.tabBar.isHidden = true
            uiTabBarController = UITabBarController
        }.onDisappear{
            uiTabBarController?.tabBar.isHidden = false
        }
        .navigationTitle("Chats")
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
