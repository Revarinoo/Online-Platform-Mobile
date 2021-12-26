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
    var body: some View {
        NavigationView {
            
            VStack {
                ScrollView {
                    NavigationLink(destination: EditProduct()) {
                        ProductCard()
                            .frame(width: 358, height: 95)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 1)
                            .padding()
                    }
                    
                }
            }
            .navigationTitle(Text("My Product").foregroundColor(Color.theme.primary))
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: CreateProductView()) {
                        Text("+")
                            .font(.title)
                            .foregroundColor(Color.theme.primary)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MyProductView_Previews: PreviewProvider {
    static var previews: some View {
        MyProductView()
    }
}
