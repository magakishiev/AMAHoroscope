//
//  DetailView.swift
//  AMAHoroscope
//
//  Created by Muhamed Agakishiev on 24/03/22.
//


import SwiftUI
import UIKit

struct HoroscopeCell: View {
    private let imageName: String
    private let title: String

    init(sign: HoroscropeSign) {
        self.imageName = sign.uiValue
        self.title = sign.uiValue
    }

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
            Text(title)
                .fontWeight(.heavy)
                .italic()
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ContentView: View {
    private let signs = HoroscropeSign.allCases
    @State private var showingSheet = false
    @State private var selectedSign: HoroscropeSign = .scorpio

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text("Horoscope App")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .padding()


                ForEach(0..<4) { line in
                    HStack(spacing: 0) {
                        ForEach(signs[(line * 3)...(line * 3) + 2], id: \.self) { sign in
                            Button {
                                showDescription(sign: sign)
                            } label: {
                                HoroscopeCell(sign: sign)
                            }
                        }
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                }
            }
            .frame(
                  maxWidth: .infinity,
                  maxHeight: .infinity
                )

            BottomSheetView(isOpen: $showingSheet, maxHeight: 300) {
                HoroscopeDescriptionView(sign: selectedSign)
            }
        }

    }

    private func showDescription(sign: HoroscropeSign) {
        selectedSign = sign
        showingSheet.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
