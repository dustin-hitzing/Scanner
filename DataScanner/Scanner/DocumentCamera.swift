//
//  DocumentCamera.swift
//  DataScanner
//
//  Created by Dustin Hitzing on 12/2/23.
//

import SwiftUI
import VisionKit

#if os(iOS)
public struct DocumentCamera: UIViewControllerRepresentable {
    
    public typealias CameraResult = Result<VNDocumentCameraScan, Error>
    public typealias CancelAction = () -> Void
    public typealias ResultAction = (CameraResult) -> Void

    private let cancelAction: CancelAction
    private let resultAction: ResultAction

    public init(
        cancelAction: @escaping CancelAction = {},
        resultAction: @escaping ResultAction) {
        self.cancelAction = cancelAction
        self.resultAction = resultAction
    }
    
    public func makeCoordinator() -> Coordinator {
            Coordinator(
                cancelAction: cancelAction,
                resultAction: resultAction)
        }

    public func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let controller = VNDocumentCameraViewController()
        controller.delegate = context.coordinator
        return controller
    }

    public func updateUIViewController(
        _ uiViewController: VNDocumentCameraViewController,
        context: Context) {}
}
#endif
