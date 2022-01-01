//
//  OrderResultView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 28/12/21.
//

import SwiftUI

struct Photo: Hashable {
    var image: String
    var img_op: Double
    var selected: Bool = Bool()
}

struct OrderResultView: View {
    
    private let gridItem = Array(repeating: GridItem(.flexible(),spacing: 2),count: 4)
    
    private let threeColumnGrid = [
        GridItem(.adaptive(minimum:40)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40))
    ]
    
    @State var foto = [
        Photo(image: "0", img_op: 100.0, selected: false),
        Photo(image: "1", img_op: 100.0,  selected: false),
        Photo(image: "2", img_op: 2.0, selected: false),
        Photo(image: "3", img_op: 2.0,  selected: false),
        Photo(image: "4", img_op: 100.0, selected: false),
        Photo(image: "5", img_op: 100.0,  selected: false),
        Photo(image: "6", img_op: 2.0, selected: false),
        Photo(image: "7", img_op: 2.0,  selected: false),
        Photo(image: "0", img_op: 100.0, selected: false),
        Photo(image: "1", img_op: 100.0,  selected: false),
        Photo(image: "2", img_op: 2.0, selected: false),
        Photo(image: "3", img_op: 2.0,  selected: false),
        Photo(image: "0", img_op: 100.0, selected: false),
        Photo(image: "1", img_op: 100.0,  selected: false),
        Photo(image: "2", img_op: 2.0, selected: false),
        Photo(image: "3", img_op: 2.0,  selected: false)
    ]
    
    @State var revision = false
    @State var count = 0
    @StateObject var orderresultVM = OrderResultViewModel()
    
    
    var body: some View {
        ZStack {
            VStack {
                Text("Photo Result")
                    .bold()
                ScrollView {
                    LazyVGrid(columns: gridItem, alignment: .center) {
                        
                        ForEach(foto, id: \.self) { item in
                            GeometryReader { gr in
                                card(orderresultVM: orderresultVM, image: item, onrevision: $revision, count: $count)
                            }
                            .clipped()
                            .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                .padding()
                Spacer()
                VStack (alignment: .leading){
                    Text("\(orderresultVM.selectedPhoto.count) Photo selected ")
                        .bold()
                        .padding(.top)
                    HStack {
                        
                        PrimaryButton(content: "Revision", maxWidth: 80, action: {
                            self.revision.toggle()
                        }, btnColor: Color.red, textColor: Color.white)
                            
                        PrimaryButton(content: "Completed", maxWidth: 50, action: {
                            //
                        }, btnColor: Color.theme.primary, textColor: Color.white)
                            
                        
                    }
                }
                .ignoresSafeArea()
                .padding([.leading, .trailing, .bottom], 16)
                .frame(width: UIScreen.main.bounds.width, height: 120)
                .background(Color.init(hex: "F7F7F7"))
                
                
            }
            
            if orderresultVM.preview {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .opacity(0.8)
                        .ignoresSafeArea()
                        .onTapGesture {
                            orderresultVM.preview.toggle()
                        }
                    
                    
                    Image(orderresultVM.imagepreview)
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            orderresultVM.preview.toggle()
                        }
                        
                }
            }
            
        }
        
        
    }
}

struct card: View {
    
    @ObservedObject var orderresultVM:OrderResultViewModel
    
    @State var image: Photo
    @Binding var onrevision: Bool
    @State var tapped: Bool = false
    @Binding var count: Int
    
    
    var body: some View {
        ZStack {
            
            if onrevision {
                Image(image.image)
                    .resizable()
                    .opacity(self.image.selected ? 1 : 0.3)
            } else {
                Image(image.image)
                    .resizable()
            }
            
            //            if tapped {
            //                popupImage(image: $image)
            //            }
            
            
            //                        if self.image.selected {
            //                            Color.black.opacity(0.5)
            //                            ZStack {
            //                                Image(systemName: "checkmark")
            //                                    .resizable()
            //                                    .frame(width: 30, height: 30)
            //                                    .foregroundColor(.white)
            //                            }
            //                        }
            
        }
        .frame(width: (UIScreen.main.bounds.width - 80) / 2, height: 90)
        .onTapGesture {
            if onrevision {
                if !self.image.selected {
                    orderresultVM.selectedPhoto.append(image)
                    self.image.selected.toggle()
                    print(orderresultVM.selectedPhoto)
                } else {
                    orderresultVM.removeSelected(selected: image)
                    self.image.selected.toggle()
                    print(orderresultVM.selectedPhoto)
                }

                tapped.toggle()
                count += 1
            } else {
                orderresultVM.preview.toggle()
                orderresultVM.imagepreview = image.image
                
            }
            
        }
    }
    
    
}

struct OrderResultView_Previews: PreviewProvider {
    static var previews: some View {
        OrderResultView()
    }
}
