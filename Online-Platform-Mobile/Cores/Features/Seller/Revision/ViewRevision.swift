//
//  ViewRevision.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 03/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ViewRevision: View {
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    var orderId: Int
    @StateObject private var viewModel = ImageRevisionViewModel()
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 10){
                Text("Photo Result")
                    .font(.custom(ThemeFont.displaySemiBold, size: 15))
                    .padding(.leading, 8)
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.revisions, id: \.id) { revision in
                        WebImage(url: URL(string: revision.image))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 78, height: 84)
                            .cornerRadius(6.46)
                    }
                }
            }
            .padding([.leading, .top], 16)
        }
        .navigationTitle("Revision List")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getRevision(orderId: orderId)
        }
    }
}

struct ViewRevision_Previews: PreviewProvider {
    static var previews: some View {
        ViewRevision(orderId: 2)
    }
}
