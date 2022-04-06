//
//  DescriptionView.swift
//  AMAHoroscope
//
//  Created by Muhamed Agakishiev on 01/04/22.
//

import SwiftUI
import UIKit

struct HoroscopeDescriptionView: UIViewRepresentable {
    let sign: HoroscropeSign

    typealias UIViewType = HoroscopeDescriptionUIView

    func makeUIView(context: Context) -> HoroscopeDescriptionUIView {
        HoroscopeDescriptionUIView()
    }

    func updateUIView(_ uiView: HoroscopeDescriptionUIView, context: Context) {
        uiView.loadHoroscrope(sign: sign)
    }
}


final class HoroscopeDescriptionUIView: UIView {
    private let horoscropeDescriptionLabel = UILabel()
    private let horoscropeService = RapidAPIService()

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .secondarySystemBackground

        self.addSubview(horoscropeDescriptionLabel)

        horoscropeDescriptionLabel.textAlignment = .center
        horoscropeDescriptionLabel.numberOfLines = 0
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        horoscropeDescriptionLabel.frame = self.bounds.inset(by: .init(top: 16, left: 16, bottom: 16, right: 16))
    }

    func loadHoroscrope(sign: HoroscropeSign) {
        horoscropeDescriptionLabel.text = "Loading..."

        horoscropeService.cancel()

        print("Load \(sign.apiValue)")
        horoscropeService.getHoroscope(for: sign) { result in
            print("Did load \(sign.apiValue)")
            DispatchQueue.main.async {
                switch result {
                case .success(let horoscope):
                    self.horoscropeDescriptionLabel.text = horoscope.description
                case .failure(let error):
                    self.horoscropeDescriptionLabel.text = error.localizedDescription
                }
            }
        }
    }
}
