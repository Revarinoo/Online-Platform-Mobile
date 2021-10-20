//
//  TestPicker.swift
//  Online-Platform-Mobile
//
//  Created by Christian Adiputra on 20/10/21.
//

import SwiftUI

struct TestPicker: View {
    @State var style = 0
    var body: some View {
        Menu {
            Button {
                style = 0
            } label: {
                Text("Linear")
                Image(systemName: "arrow.down.right.circle")
            }
            Button {
                style = 1
            } label: {
                Text("Radial")
                Image(systemName: "arrow.up.and.down.circle")
            }
        } label: {
             Text("Style")
             Image(systemName: "tag.circle")
        }
    }
}

struct TestPicker_Previews: PreviewProvider {
    static var previews: some View {
        TestPicker()
    }
}
