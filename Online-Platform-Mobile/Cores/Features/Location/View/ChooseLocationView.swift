//
//  ChooseLocationView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 20/12/21.
//

import SwiftUI
import MapKit
import Introspect

struct ChooseLocationView: View {
    
    @Binding var location: String
    @StateObject private var locationVM = LocationViewModel()
    @State private var searchQuery = ""
    @State private var selectedStack: LocationList? = nil
    @State private var isNavigate = false
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack {
                    TextField("Search location", text: $searchQuery) { _ in
                    } onCommit: {
                        locationVM.searchLocation(query: searchQuery)
                    }.textFieldStyle(RoundedBorderTextFieldStyle())
                        .introspectTextField(customize: { textfield in
                            textfield.becomeFirstResponder()
                        })
                        .padding()
                    
                    
                    Spacer()

                    ForEach(locationVM.landmarks) { landmark in
                        LazyVStack (alignment: .leading, spacing: 10) {
                            Text(landmark.name)
                                .font(.headline)
                            Text(landmark.title)
                            Divider()
                        }
                        .padding([.leading, .trailing], 16)
                        .onTapGesture {
                            self.selectedStack = landmark
                            location = ("\(landmark.name), \(landmark.title)")
                        }
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .background(selectedStack?.placemark == landmark.placemark ? Color.theme.primarywhite : Color.white)
                    }
                }
            }
            VStack {
                Spacer()
                VStack {
                    if selectedStack != nil {
                        NavigationLink(destination: MapView(coordinate: selectedStack!.coordinate, locationList: self.selectedStack!)) {
                            Text("Choose")
                                .font(.custom(ThemeFont.displaySemiBold, size: 15))
                                .foregroundColor(Color.white)
                                .padding(EdgeInsets(top: 6, leading: 25, bottom: 6, trailing: 25))
                                .frame(width: UIScreen.main.bounds.width - 32, height: 60, alignment: .center)
                                .background(Color.theme.primary)
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 16)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .onTapGesture {
                self.dismissKeyboard()
            }
        }
    }
}

struct ChooseLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseLocationView(location: .constant("Location"))
    }
}
