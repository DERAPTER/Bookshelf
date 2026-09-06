//
//  BookNetworkManager.swift
//  bookshelf
//
//  Created by Егор Халиков on 05.09.2026.
//

import Foundation

class BookNetworkManager {
    ///https://openlibrary.org/search.json?
    ///q=убить пересмешника
    ///&fields=title,author_name,cover_i,subtitle,number_of_pages_median,first_publish_year,ratings_count
    ///&lang=ru
    
    let url = "https://openlibrary.org/search.json"
    
    func searchBookRequest(q: String, completion: @escaping (Result<[BookModelItem], Error>) -> Void) {
        var urlComponent = URLComponents(string: url)
        urlComponent?.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "fields", value: "title,author_name,cover_i,subtitle,number_of_pages_median,first_publish_year,ratings_count"),
            URLQueryItem(name: "lang", value: "ru")
        ]
        
        guard let url = urlComponent?.url else { return }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(.failure(error!))
                return
            }
            
            guard let data else {
                return
            }
            
            do {
                let books = try JSONDecoder().decode(BookModel.self, from: data)
                completion(.success(books.docs))
            } catch {
                print(error.localizedDescription )
                completion(.failure(error))
            }
            
            print(String(decoding: data, as: UTF8.self))
            
        }.resume()
    }
}
