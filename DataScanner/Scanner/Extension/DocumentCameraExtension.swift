//
//  DocumentCameraExtension.swift
//  DataScanner
//
//  Created by Dustin Hitzing on 12/2/23.
//

import Foundation
import SwiftUI
import VisionKit


#if os(iOS)
public extension DocumentCamera {

    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {

        private let cancelAction: DocumentCamera.CancelAction
        private let resultAction: DocumentCamera.ResultAction

        public init(
            cancelAction: @escaping DocumentCamera.CancelAction,
            resultAction: @escaping DocumentCamera.ResultAction) {
            self.cancelAction = cancelAction
            self.resultAction = resultAction
        }

        public func documentCameraViewControllerDidCancel(
            _ controller: VNDocumentCameraViewController) {
            cancelAction()
        }

        public func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFailWithError error: Error) {
            resultAction(.failure(error))
        }

        public func documentCameraViewController(
            _ controller: VNDocumentCameraViewController,
            didFinishWith scan: VNDocumentCameraScan) {
            resultAction(.success(scan))
        }
    }
}
#endif
