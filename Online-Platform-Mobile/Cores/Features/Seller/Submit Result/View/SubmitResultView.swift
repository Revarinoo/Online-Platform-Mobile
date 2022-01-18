//
//  SubmitResultView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 01/01/22.
//

import SwiftUI

struct SubmitResultView: View {
    @State private var images: [UIImage] = []
    @State private var showPicker = false
    @State private var resultLink = String()
    var orderId: Int
    @StateObject private var resultVM = SubmitResultViewModel()
    @State private var showLoading = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    result
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Photo Result")
                            .font(.custom(ThemeFont.displaySemiBold, size: 15))
                            .padding(.leading, 8)
                        LazyVGrid(columns: columns) {
                            if images.count == 0 {
                                Image(systemName: "camera")
                                    .font(.system(size: 24))
                                    .foregroundColor(.gray)
                                    .scaledToFill()
                                    .frame(width: 78, height: 84)
                                    .background(Color.init(hex: "F3F4F8"))
                                    .cornerRadius(6.46)
                                    .onTapGesture {
                                        self.showPicker.toggle()
                                }
                                
                                imagePlus
                            }
                            else {
                                ForEach(images, id:\.self) { image in
                                    ZStack {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 78, height: 84)
                                            .cornerRadius(6.46)
                                        VStack {
                                            HStack {
                                                Spacer()
                                                Button {
                                                    if let index = images.firstIndex(of: image) {
                                                        images.remove(at: index)
                                                    }
                                                } label: {
                                                    Image("xButton")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 20, height: 20)
                                                        .padding(.trailing, 5)
                                                }
                                            }
                                            Spacer()
                                        }
                                        .frame(height: 98)
                                    }
                                }
                                imagePlus
                                
                            }
                        }
                    }
                    .padding([.leading, .bottom], 8)
                }
                .padding(.top, 16)
            }
            .padding(.bottom, 45)
            VStack {
                Spacer()
                Button {
                    showLoading = true
                    resultVM.submitOrderResult(orderId: self.orderId, result: self.resultLink, images: self.images)
                } label: {
                    Text("Submit")
                        .font(.custom(ThemeFont.displaySemiBold, size: 18))
                        .frame(width: 358, height: 50)
                        .foregroundColor(Color.theme.primary)
                        .background(Color.theme.secondary)
                        .cornerRadius(15)
                }
                .disabled(resultLink.isEmpty || images == [] ? true : false)
                .opacity(resultLink.isEmpty || images == [] ? 0.4 : 1)
            }
            .navigationTitle("Submit Result")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showPicker) {
                ImagePickerReferences(referenceImages: $images)
            }
            
        }
        .onTapGesture {
            self.dismissKeyboard()
        }
        .fullScreenCover(isPresented: $showLoading) {
            LoadingView()
        }
        .onChange(of: resultVM.successfullySubmitted) { _ in
            self.showLoading = false
            presentationMode.wrappedValue.dismiss()
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var imagePlus: some View {
        Image(systemName: "plus")
            .font(.system(size: 24))
            .foregroundColor(.gray)
            .scaledToFill()
            .frame(width: 78, height: 84)
            .background(Color.init(hex: "F3F4F8"))
            .cornerRadius(6.46)
            .onTapGesture {
                self.showPicker.toggle()
            }
    }
    
    var result: some View {
        VStack(alignment: .leading) {
            Text("Result Link")
                .font(.custom(ThemeFont.displaySemiBold, size: 15))
            TextField("Link (dropbox, drive, etc)", text: $resultLink)
                .textFieldStyle(OvalTextFieldStyle())
        }
        .padding([.leading, .trailing], 16)
    }
}

struct SubmitResultView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitResultView(orderId: 1)
    }
}
