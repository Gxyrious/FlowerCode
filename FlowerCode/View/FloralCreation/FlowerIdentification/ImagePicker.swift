//
//  ImagePicker.swift
//  profileImage
//
//

import SwiftUI
import UIKit


struct ImagePicker: UIViewControllerRepresentable {

    @Binding var isShoot: Bool
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker

    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        print("ccc")
        print("在Picker内isShoot")
        print(self.isShoot)
        //uiViewController._isShoot = isShoot
        //leave alone for right now
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        @Binding var isShoot: Bool

        var parent: ImagePicker

        init(_ parent: ImagePicker, isShoot: Binding<Bool>) {
            self.parent = parent
            self._isShoot = isShoot
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                global_UIimage = image  //尝试加一下
                parent.isShoot = true
                print("aaa")
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, isShoot: $isShoot)
    }
}

//struct ImagePicker: UIViewControllerRepresentable {
//
//    @Binding var selectedImage: UIImage
//    @Environment(\.presentationMode) private var presentationMode
//    var sourceType: UIImagePickerController.SourceType = .photoLibrary
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//
//        let imagePicker = UIImagePickerController()
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = sourceType
//        imagePicker.delegate = context.coordinator
//
//        return imagePicker
//
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//        //leave alone for right now
//    }
//
//    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//        var parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//                parent.selectedImage = image
//                global_UIimage = image  //尝试加一下
//                print("aa")
//            }
//
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//}
