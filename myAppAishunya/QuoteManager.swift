//
//  QuoteManager.swift
//  Stoic Quotes
//
//  Created by Aisha Nurgaliyeva on 24.05.2023.
//

import Foundation

protocol QuoteManagerDelegate {
    func didUpdateQuote(author: String, quote: String)
}

struct QuoteManager {
    
    var delegate: QuoteManagerDelegate?
     
    func getQuote() {
        let urlString = "https://api.themotivate365.com/stoic-quote"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let quote = self.parseJSON(safeData).last, let author = self.parseJSON(safeData).first {
                        self.delegate?.didUpdateQuote(author: author, quote: quote)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [String] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(QuoteData.self, from: data)
            let author = decodedData.author
            let q = decodedData.quote
            let quote = [author, q]
            return quote
        } catch {
            print(error)
            return []
        }
    }
    
}
