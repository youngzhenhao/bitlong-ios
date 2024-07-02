//
//  BLQRScanVC.swift
//  bitlong
//
//  Created by slc on 2024/5/29.
//

import UIKit
import AVFoundation

typealias QRScanBlock = (_ qrStr : String) -> ()

class BLQRScanVC: BLBaseVC,AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var callBack : QRScanBlock?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "扫一扫"
        
        // 设置 AVCaptureSession
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return
        }
        
        // 设置预览图层
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        // 开始扫描
        DispatchQueue.global().async { [weak self] in
            self?.captureSession.startRunning()
        }
        
        addMaskToScannerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navgationLeftBtn(picStr: "ic_back_white")
        self.setNavTitleColor(titleColor: UIColorHex(hex: 0xFFFFFF, a: 1.0), bgColor: UIColorHex(hex: 0xFFFFFF, a: 0.0), bgImage: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.setNavTitlNormal()
    }
    
    var scanningLine: UIView!
    func addMaskToScannerView() {
        // 计算正方形的位置，使其位于视图的正中心
        let squareSize: CGFloat = 300
        let squareX = (view.bounds.width - squareSize) / 2
        let squareY = (view.bounds.height - squareSize) / 2

        // 创建四个半透明的 UIView 元素作为遮罩
        let topMask = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: squareY))
        let bottomMask = UIView(frame: CGRect(x: 0, y: squareY + squareSize, width: view.bounds.width, height: view.bounds.height - (squareY + squareSize)))
        let leftMask = UIView(frame: CGRect(x: 0, y: squareY, width: squareX, height: squareSize))
        let rightMask = UIView(frame: CGRect(x: squareX + squareSize, y: squareY, width: view.bounds.width - (squareX + squareSize), height: squareSize))

        // 设置遮罩的背景颜色
        [topMask, bottomMask, leftMask, rightMask].forEach {
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            view.addSubview($0)
        }

        // 添加绿色的正方形框
        let squareFrame = UIView(frame: CGRect(x: squareX, y: squareY, width: squareSize, height: squareSize))
        squareFrame.layer.borderColor = UIColor.green.cgColor
        squareFrame.layer.borderWidth = 3
        squareFrame.backgroundColor = .clear
        view.addSubview(squareFrame)
        
        // 添加扫描线
        scanningLine = UIView(frame: CGRect(x: squareX, y: squareY, width: squareSize, height: 2))
        scanningLine.backgroundColor = UIColor.red
        view.addSubview(scanningLine)

        // 扫描线动画
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = squareY
        animation.toValue = squareY + squareSize
        animation.duration = 2
        animation.repeatCount = .infinity
        scanningLine.layer.add(animation, forKey: "scanning")
    }

    
    // 当扫描到 QRCode 时，此方法将被调用
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        self.back()
        
        // 在此处处理扫描到的 QRCode
        if callBack != nil{
            callBack!(code)
        }
    }
}
