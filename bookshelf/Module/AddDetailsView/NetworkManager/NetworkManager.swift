//
//  NetworkManager.swift
//  bookshelf
//
//  Created by Егор Халиков on 06.09.2026.
//

import Foundation

class NetworkManager {
     let url = "https://bothub.chat/api/v2/openai/v1/chat/completions"
    let token = "eyJhbGci0iJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNwVmMzI0LTc1NmUtNDV10C04YWYxLTF1MWNkMDRkMDE1NyIsIm1zRGV2ZWxvcGVyIjp0cnV1LCJpYXQi0jE3MzUz0TA3NjIsImV4cCI6MjA1MDk2Njc2Mn0.xL2fhtLOtHp_K4Xn_bEAhuKgnRwY1UGwaRk-XxirgdY"
    
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
