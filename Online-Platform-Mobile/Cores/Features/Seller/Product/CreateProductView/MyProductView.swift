//
//  MyProductView.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 15/12/21.
//

import SwiftUI

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
    
}

struct MyProductView: View {
    @State var showCreateProduct = false
    
    var body: some View {
        VStack {
            ScrollView {
//                NavigationLink(destination: EditProduct()) {
                    ProductCard()
                        .frame(width: 358, height: 95)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                        .padding()
//                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    self.showCreateProduct.toggle()
                } label: {
                    Text("+")
                        .font(.title)
                        .foregroundColor(Color.theme.primary)
                }
            }
        }
        .sheet(isPresented: $showCreateProduct) {
            CreateProductView(showPage: $showCreateProduct)
        }
    }
}

struct MyProductView_Previews: PreviewProvider {
    static var previews: some View {
        MyProductView()
    }
}
