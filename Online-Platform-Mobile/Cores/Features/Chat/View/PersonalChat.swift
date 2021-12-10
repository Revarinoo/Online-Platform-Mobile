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
    @State private var messageIDScroll: String?
    let columns = [GridItem(.flexible(minimum: 10))]
    
    var body: some View {
        VStack {
            ScrollView (.vertical, showsIndicators: false) {
                ScrollViewReader { scrollReader in
                    LazyVGrid(columns: columns, content: {
                        ForEach(messageVM.messages) { message in
                            let isUser = messageVM.userProfile.user.id == message.sender
                            HStack{
                                Text(message.content)
                                    .foregroundColor(isUser ? Color.white : Color.black)
                                    .padding(.horizontal)
                                    .padding(.vertical, 12)
                                    .background(isUser ? Color.theme.primary : Color.white)
                                    .cornerRadius(15, corners: isUser ? [.topLeft, .bottomLeft, .bottomRight] : [.topRight, .bottomLeft, .bottomRight])
                            }
                            .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
                            .padding(.vertical, 3)
                            .padding([.leading, .trailing], 16)
                            .id(message.id)
                            .shadow(color: Color.theme.darkGrey.opacity(0.5), radius: 2, x: 0, y: 5)
                        }
                        
                        .onChange(of: messageIDScroll) { _ in
                            if let messageID = messageIDScroll {
                                scrollTo(messageID: messageID, shouldAnimate: true, scrollReader: scrollReader)
                            }
                        }
                        .onAppear {
                            if let messageID = messageVM.messages.last?.id {
                                print("tidak null \(messageID)")
                                scrollTo(messageID: messageID, shouldAnimate: true, scrollReader: scrollReader)
                            }
                        }
                    })
                   
                }
            }
            HStack (spacing: 9) {
                TextField("Text Message", text: $messageField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    messageVM.sendMessage(content: messageField, docId: chatRoom.id)
                    self.messageField = ""
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        messageIDScroll = messageVM.messages.last?.id
                    })
                }, label: {
                    Image("send")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 27, height: 27)
                })
            }
            .padding([.leading, .trailing], 16)
            .frame(height: 25, alignment: .bottom)
            .padding(.top, 15)
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color.white.ignoresSafeArea())
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                HStack (spacing: 6) {
                    WebImage(url: URL(string: target.photo))
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                    Text(target.name)
                        .font(.custom(ThemeFont.displaySemiBold, size: 17))
                }
            }
        })
        .onAppear {
            messageVM.fetchData(docId: chatRoom.id)
        }
        .onTapGesture {
            self.dismissKeyboard()
        }
    }
    
    func scrollTo(messageID: String, anchor: UnitPoint? = nil, shouldAnimate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn: nil) {
                scrollReader.scrollTo(messageID, anchor: anchor)
            }
        }
    }
}

struct PersonalChat_Previews: PreviewProvider {
    static var previews: some View {
        PersonalChat(target: ProfileChat(name: "Reva", photo: ""), chatRoom: ChatRoom(id: "", users: []))
    }
}
