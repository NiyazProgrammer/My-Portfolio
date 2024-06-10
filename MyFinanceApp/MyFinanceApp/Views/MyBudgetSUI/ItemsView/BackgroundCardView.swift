//
//  BackgroundCardView.swift
//  MyFinanceApp
//
//  Created by Нияз Ризванов on 22.05.2024.
//

import SwiftUI

struct BackgroundCardView: View {
    @Binding var selectionBackground: String 
    @Environment(\.presentationMode) var presentationMode
    var backgrounds = ["background1", "background2", "background3", "background4", "background5", "background6"]

    var body: some View {
        List(backgrounds, id: \.self) { background in
            Image(background)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding(.vertical, 10)
                .onTapGesture {
                    selectionBackground = background
                    presentationMode.wrappedValue.dismiss()
                }
        }
        .listStyle(PlainListStyle())
    }
}
