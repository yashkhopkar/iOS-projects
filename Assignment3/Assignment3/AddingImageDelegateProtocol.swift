//
//  AddingImageDelegateProtocol.swift
//  Assignment3
//
//  Created by Yash Khopkar on 2023-03-31.
//

import Foundation

protocol AddingImageDelegateProtocol {
    func controllerDidFinishWithNewImage(image: ImageInfo)
    func controllerDidCancel()
}
