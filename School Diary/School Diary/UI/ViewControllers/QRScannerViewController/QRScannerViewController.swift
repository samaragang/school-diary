//
//  QRScannerViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 25.11.23.
//

import UIKit
import SchoolDiaryUIComponents
import AVFoundation

final class QRScannerViewController: BaseUIViewController {
    private lazy var captureSession = AVCaptureSession()
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        return previewLayer
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isAccessGranted in
            DispatchQueue.main.async {
                guard isAccessGranted else {
                    self?.dismiss(animated: true)
                    return
                }
                
                self?.setupCapture()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard captureSession.isRunning else { return }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard captureSession.isRunning else { return }
        
        captureSession.stopRunning()
    }
    
    private func setupCapture() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
              self.captureSession.canAddInput(videoInput)
        else {
            self.dismiss(animated: true)
            return
        }
        
        captureSession.addInput(videoInput)
        let metadataOutput = AVCaptureMetadataOutput()
        guard captureSession.canAddOutput(metadataOutput) else {
            self.dismiss(animated: true)
            return
        }
        
        captureSession.addOutput(metadataOutput)
        metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
        metadataOutput.metadataObjectTypes = [.qr]
        
        self.view.layer.addSublayer(previewLayer)
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
}

// MARK: - Setup interface methods
extension QRScannerViewController {
    override func setupInterface() {
        super.setupInterface()
        self.view.backgroundColor = .black
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        guard let metadataObjects = metadataObjects.first,
              let readableObject = metadataObjects as? AVMetadataMachineReadableCodeObject,
              let stringValue = readableObject.stringValue?.replacingOccurrences(of: "'", with: "\""),
              let data = stringValue.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let pupilId = json["userId"] as? Int
        else { return }
        
        self.dismiss(animated: true) {
            let currentVC = MainCoordinator.shared.currentController as? BaseUIViewController
            currentVC?.spinner(isShow: true)
            SchoolsDiaryProvider.shared.pupilInfo(id: pupilId) { user in
                currentVC?.spinner(isShow: false)
                MainCoordinator.shared.pushUserViewController(userInfo: user)
            } failure: {
                currentVC?.spinner(isShow: false)
            }
        }
    }
}
