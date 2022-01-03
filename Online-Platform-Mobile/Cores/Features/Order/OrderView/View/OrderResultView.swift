//
//  OrderResultView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 28/12/21.
//  Edited by Reva on 02/01/2022

import SwiftUI
import SDWebImageSwiftUI

struct OrderResultView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private let gridItem = Array(repeating: GridItem(.flexible(),spacing: 2),count: 4)
    private let threeColumnGrid = [
        GridItem(.adaptive(minimum:40)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40))
    ]
    @State var revision = false
    @State var count = 0
    @StateObject private var orderResultVM = OrderResultViewModel()
    var orderId: Int
    @State private var navigateToComplain = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("Photo Result")
                    .font(.custom(ThemeFont.displaySemiBold, size: 15))
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    .padding([.leading, .top], 16)
                if orderResultVM.results.count == 0 {
                    emptyView
                        .padding(.top, 156)
                }
                ScrollView {
                    LazyVGrid(columns: gridItem, alignment: .center) {
                        ForEach(orderResultVM.results, id: \.id) { item in
                            GeometryReader { gr in
                                card(orderresultVM: orderResultVM, image: item, onrevision: $revision, count: $count)
                            }
                            .clipped()
                            .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                .padding()
                Spacer()
                VStack (alignment: .leading){
                    Text("\(orderResultVM.selectedPhoto.count) Photo selected ")
                        .bold()
                        .padding(.top)
                    HStack {
                        NavigationLink(destination: SubmitComplainView(orderId: orderId), isActive: $navigateToComplain){
                            PrimaryButton(content: "Complain", maxWidth: 80, action: {
                                self.navigateToComplain.toggle()
                            }, btnColor: Color.red, textColor: Color.white)
                        }
                            .disabled(orderResultVM.revisionAvailable ? true : false)
                            .opacity(orderResultVM.revisionAvailable ? 0.5 : 1)
                        PrimaryButton(content: "Revision", maxWidth: 80, action: {
                            self.revision.toggle()
                        }, btnColor: Color.red, textColor: Color.white)
                            .disabled(!orderResultVM.revisionAvailable ? true : false)
                            .opacity(!orderResultVM.revisionAvailable ? 0.5 : 1)
                            
                        PrimaryButton(content: revision ? "Submit" : "Completed", maxWidth: 50, action: {
                            if revision {
                                orderResultVM.requestRevision(orderId: orderId)
                            }
                            else {
                                orderResultVM.completeOrder(orderId: orderId)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, btnColor: Color.theme.primary, textColor: Color.white)
                    }
                }
                .padding([.leading, .trailing, .bottom], 16)
                .frame(width: UIScreen.main.bounds.width, height: 120)
                .padding(.bottom, 16)
                .background(Color.init(hex: "F7F7F7"))
            }
            
            if orderResultVM.preview {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .opacity(0.8)
                        .ignoresSafeArea()
                        .onTapGesture {
                            orderResultVM.preview.toggle()
                        }
                    
                    WebImage(url: URL(string: orderResultVM.imagepreview))
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            orderResultVM.preview.toggle()
                        }
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            orderResultVM.getOrderResult(orderId: self.orderId)
        }
        .onChange(of: orderResultVM.revisionSubmitted) { _ in
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var emptyView: some View {
        VStack (spacing: 15) {
            Image("noResult")
                .resizable()
                .scaledToFill()
                .frame(width: 247, height: 235, alignment: .center)
            Text("No result uploaded yet ...")
                .font(.custom(ThemeFont.displayMedium, size: 22.5))
        }
    }
}

struct card: View {
    
    @ObservedObject var orderresultVM: OrderResultViewModel
    
    @State var image: OrderRevision
    @Binding var onrevision: Bool
    @State var tapped: Bool = false
    @Binding var count: Int
    
    
    var body: some View {
        ZStack {
            
            if onrevision {
                WebImage(url: URL(string: image.file_path))
                    .resizable()
                    .opacity(self.image.selected ? 1 : 0.3)
            } else {
                WebImage(url: URL(string: image.file_path))
                    .resizable()
            }
            
        }
        .frame(width: (UIScreen.main.bounds.width - 80) / 2, height: 90)
        .onTapGesture {
            if onrevision {
                if !self.image.selected {
                    orderresultVM.selectedPhoto.append(image)
                    self.image.selected.toggle()
                } else {
                    orderresultVM.removeSelected(selected: image)
                    self.image.selected.toggle()
                }

                tapped.toggle()
                count += 1
            } else {
                orderresultVM.preview.toggle()
                orderresultVM.imagepreview = image.file_path
            }
            
        }
    }
}

struct OrderResultView_Previews: PreviewProvider {
    static var previews: some View {
        OrderResultView(orderId: 3)
    }
}
