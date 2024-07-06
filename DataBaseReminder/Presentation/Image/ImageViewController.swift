//
//  ImageViewController.swift
//  DataBaseReminder
//
//  Created by 서충원 on 7/6/24.
//

import UIKit
import PhotosUI

class ImageViewController: BaseViewController<ImageView>, SubViewType {
    
    private var image: UIImage?
    var delegate: DataTransportDelegate?
    
    override func configureView() {
        customView.configureNavigationController(self)
        customView.addImageButton.addTarget(self, action: #selector(imageButtonClicked), for: .touchUpInside)
        customView.picker.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.transportImage(image: image)
    }
    
    @objc private func imageButtonClicked(_ sender: UIButton) {
        present(customView.picker, animated: true)
    }
}

//MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension ImageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        ///User Canceled
        guard !results.isEmpty else { return }
        
        guard let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            DispatchQueue.main.async {
                let image = image as? UIImage
                self.image = image
                self.customView.imageView.image = image
                self.customView.addImageButton.setImage(UIImage(), for: .normal)
            }
        }
    }
}
