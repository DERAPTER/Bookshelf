//
//  NetworkManager.swift
//  bookshelf
//
//  Created by Егор Халиков on 06.09.2026.
//

import Foundation

class NetworkManager {
     let url = "https://bothub.chat/api/v2/openai/v1/chat/completions"
    let token = "" //TOKEN
    
    func sendRequest(bookName: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: self.url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBodyStruct = BotHubResponse(model: "gpt-4o", messages: [Message(role: "user", content: "Опиши книгу \(bookName) в 3 - 5 предложений.")])
        
        do {
            let requestBody = try JSONEncoder().encode(requestBodyStruct)
            request.httpBody = requestBody
        } catch {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else { return }
            guard let data else { return }
            
            do {
                let response = try JSONDecoder().decode(ChatResponse.self, from: data)
                completion(response.choices[0].message.content)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func loadCover(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.addValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, resp, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let httpResp = resp as? HTTPURLResponse,
            httpResp.statusCode == 200 else {
                completion(.failure(SaveError.missingCover))
                return
            }
            
            guard let data else {
                completion(.failure(SaveError.missingData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}

enum SaveError: Error {
    case missingCover
    case missingData
}

struct BotHubResponse: Encodable {
    let model: String
    let messages: [Message]
}

struct Message: Codable {
    let role: String
    let content: String
}

struct ChatResponse: Decodable {
    let choices: [ChatResponseChoice]
}

struct ChatResponseChoice: Decodable {
    let message: Message
}

//{
//    "model": "gpt-4o",
//    "messages": [
//        {
//            "role": "user",
//            "content": "Tell me about Fiji"
//        }
//    ]
//}
