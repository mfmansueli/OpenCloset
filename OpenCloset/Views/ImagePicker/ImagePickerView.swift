//
//  ImagePickerView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 13/11/24.
//
import SwiftUI
import PhotosUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    var allowMultipleSelection: Bool

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePickerView
        
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                if self.parent.allowMultipleSelection {
                                    self.parent.images.append(image)
                                } else {
                                    self.parent.image = image
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        let multipleSelectionMaximum = 5 - images.count
        configuration.selectionLimit = allowMultipleSelection ? multipleSelectionMaximum : 1 // Limit to 5 photos for multiple selection
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}
