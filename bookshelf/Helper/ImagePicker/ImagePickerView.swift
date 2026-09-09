//
//  ImagePickerView.swift
//  bookshelf
//
//  Created by Егор Халиков on 08.09.2026.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage
    
    typealias UIViewControllerType = UIImagePickerController
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        //picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        <#code#>
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator { image in
            self.image = image
        }
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var completion: (UIImage) -> Void
        
        init(completion: @escaping (UIImage) -> Void) {
            self.completion = completion
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                completion(image)
            }
            picker.dismiss(animated: true)
        }
    }
}
