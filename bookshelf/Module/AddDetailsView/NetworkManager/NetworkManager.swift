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
    
    func sendRequest(bookName: String) {
        guard let url = URL(string: self.url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
            
            print(String(decoding: data, as: UTF8.self))
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

//{
//    "model": "gpt-4o",
//    "messages": [
//        {
//            "role": "user",
//            "content": "Tell me about Fiji"
//        }
//    ]
//}
