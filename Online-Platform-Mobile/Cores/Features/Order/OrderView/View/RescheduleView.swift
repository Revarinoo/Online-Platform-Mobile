//
//  RescheduleView.swift
//  Online-Platform-Mobile
//
//  Created by Revarino Putra on 22/12/21.
//

import SwiftUI

struct RescheduleView: View {
    let orderDetailVM: OrderDetailViewModel
    var orderId: Int
    @State var selectedDate: Date = Date()
    @Binding var isShowed: Bool
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            VStack {
                Text("Reschedule")
                    .font(.custom(ThemeFont.displaySemiBold, size: 14))
                Divider()
                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                Divider()
                HStack {
                    Button {
                        isShowed.toggle()
                    } label: {
                        Text("Cancel")
                            .font(.custom(ThemeFont.displayRegular, size: 14))
                    }
                    Spacer()
                    Button {
                        showAlert.toggle()
                    } label: {
                        Text("Save")
                            .font(.custom(ThemeFont.displayMedium, size: 14))
                    }
                }
                .padding(.horizontal)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Reschedule Order"), message: Text("Are you sure want to reschedule this order?"), primaryButton: .default(Text("No")), secondaryButton: .default(Text("Yes"), action: {
                    orderDetailVM.rescheduleOrder(orderId: orderId, date: selectedDate)
                    isShowed = false
                }))
            }
            .padding()
            .background(
                Color.white
                    .cornerRadius(30)
            )
        }
    }
}

