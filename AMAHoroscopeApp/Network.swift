//
//  Network.swift
//  AMAHoroscope
//
//  Created by Muhamed Agakishiev on 24/03/22.
//
import Foundation

enum HoroscropeSign: CaseIterable {
    case aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces

    var uiValue: String {
        switch self {
        case .leo:
            return "Leo"
        case .aries:
            return "Aries"
        case .taurus:
            return "Taurus"
        case .gemini:
            return "Gemini"
        case .cancer:
            return "Cancer"
        case .virgo:
            return "Virgo"
        case .libra:
            return "Libra"
        case .scorpio:
            return "Scorpio"
        case .sagittarius:
            return "Sagittarius"
        case .capricorn:
            return "Capricorn"
        case .aquarius:
            return "Aquarius"
        case .pisces:
            return "Pisces"
        }
    }

    var apiValue: String {
        switch self {
        case .leo:
            return "leo"
        case .aries:
            return "aries"
        case .taurus:
            return "taurus"
        case .gemini:
            return "gemini"
        case .cancer:
            return "cancer"
        case .virgo:
            return "virgo"
        case .libra:
            return "libra"
        case .scorpio:
            return "scorpio"
        case .sagittarius:
            return "sagittarius"
        case .capricorn:
            return "capricorn"
        case .aquarius:
            return "aquarius"
        case .pisces:
            return "pisces"
        }
    }
}

struct Horoscope: Decodable {
    let description: String
}


final class RapidAPIService {
    private var currentTask: URLSessionDataTask?

    func cancel() {
        currentTask?.cancel()
    }

    func getHoroscope(for sign: HoroscropeSign, completion: @escaping (Result<Horoscope, Error>) -> Void) {
        let headers = [
            "X-RapidAPI-Host": "sameer-kumar-aztro-v1.p.rapidapi.com",
            "X-RapidAPI-Key": "781df9cc80mshef4070c8e5068a7p1bb768jsn732ef8d1261e"
        ]

        let request = NSMutableURLRequest(
            url: URL(string: "https://sameer-kumar-aztro-v1.p.rapidapi.com/?sign=\(sign.apiValue)&day=today")!,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error))
            } else {
                let data = data ?? Data()
                let decoder = JSONDecoder()
                if let horoscope = try? decoder.decode(Horoscope.self, from: data) {
                    completion(.success(horoscope))
                } else {
                    let error = NSError(domain: "horoscope", code: 1)
                    completion(.failure(error as Error))
                }
            }
        }

        currentTask = dataTask
        dataTask.resume()
    }
}
