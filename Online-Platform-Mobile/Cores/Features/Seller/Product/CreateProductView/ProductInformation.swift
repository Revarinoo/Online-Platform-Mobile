////
////  ProductInformation.swift
////  Online-Platform-Mobile
////
////  Created by Christian Adiputra on 12/12/21.
////
//
//import SwiftUI
//
//struct ProductInformation: View {
//    
//    init() {
//        UITableView.appearance().backgroundColor = .clear // Uses UIColor
//    }
//    
//    //
//    @StateObject private var productVM = SellerProductViewModel()
//    @State var selectedIndex = 0
//    
//    var listCategory = ["Photo", "Video"]
//    
//    var body: some View {
//        VStack(alignment: .leading){
//            VStack(alignment: .leading) {
//                Text("Product Information")
//                    .foregroundColor(Color.theme.primary)
//                    .fontWeight(.semibold)
//                VStack {
//                    TextField("Package Name", text: $createproductVM.packageName)
//                        .padding(.vertical)
//                    Divider()
//                    NavigationLink(destination: {}) {
//                        HStack{
//                            Text("Category")
//                                .foregroundColor(Color.black)
//                            Spacer()
//                            Group{
//                                Text(createproductVM.packageCategory)
//                                Image(systemName: "play.fill")
//                            }
//                            .foregroundColor(Color.gray)
//                        }
//                    }
//                    Divider()
//                    TextField("Package Price", text: $createproductVM.packagePrice)
//                        .padding(.vertical)
//                }
//                .padding(.horizontal)
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
//            }
//        }
//        .padding()
//    }
//}
//
//struct ProductInformation_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductInformation()
//    }
//}
