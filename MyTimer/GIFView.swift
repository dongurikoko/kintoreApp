//
//  GIFView.swift
//  MyTimer
//
//  Created by 大本詩織 
//

import SwiftUI
import UIKit

struct GIFView: UIViewRepresentable {
    let gifName: String //表示したい画像のファイル名
    
    func makeUIView(context: UIViewRepresentableContext<GIFView>) -> UIView {
        let gifView = UIView()
        guard let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif") else {
            return gifView
        }
        guard let imageData = try? Data(contentsOf: gifURL) else {
            return gifView
        }
        guard let gifImage = UIImage.gif(data: imageData) else {
            return gifView
        }
        let imageView = UIImageView(image: gifImage)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        gifView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: gifView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: gifView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: gifView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: gifView.bottomAnchor)
        ])
        return gifView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GIFView>) {
        
    }
}

extension UIImage {
    static func gif(data: Data) -> UIImage? { //Data型のGIF画像データをUIImage型に変換する
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        let count = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        var duration: TimeInterval = 0.0
        for i in 0..<count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                continue
            }
            guard let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any] else {
                continue
            }
            guard let gifInfo = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any] else {
                continue
            }
            if let delayTime = gifInfo[kCGImagePropertyGIFDelayTime as String] as? TimeInterval {
                duration += delayTime
            }
            images.append(UIImage(cgImage: cgImage))
        }
        return UIImage.animatedImage(with: images, duration: duration)
    }
}
