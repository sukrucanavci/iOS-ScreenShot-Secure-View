//
//  SecureViewDetector.swift
//  SecureView
//
//  Created by Şükrü Can Avcı on 21.01.2024.
//

import UIKit

struct SecureViewDetector {
    
    private enum Error: Swift.Error {
        case unsupportedOSVersion(version: Float)
        case desiredContainerNotFound(_ containerName: String)
    }
    
    func getSecureFrame(from view: UIView) throws -> UIView {
        let containerName = try getSecureViewTypeInStringRepresentation()
        let containers = view.subviews.filter { subview in
            type(of: subview).description() == containerName
        }
        
        guard let container = containers.first else {
            throw Error.desiredContainerNotFound(containerName)
        }
        
        return container
    }
    
    private func getSecureViewTypeInStringRepresentation() throws -> String {
        
        if #available(iOS 15, *) {
            return "_UITextLayoutCanvasView"
        }
        
        if #available(iOS 14, *) {
            return "_UITextFieldCanvasView"
        }
        
        if #available(iOS 13, *) {
            return "_UITextFieldCanvasView"
        }
        
        if #available(iOS 12, *) {
            return "_UITextFieldContentView"
        }
        
        let currentIOSVersion = (UIDevice.current.systemVersion as NSString).floatValue
        throw Error.unsupportedOSVersion(version: currentIOSVersion)
    }
}
