//
//  CapturePage.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/18/25.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
    }
}
    struct CapturePage: View {
        @State private var session = AVCaptureSession()
        @Environment(\.dismiss) var dismiss
        var body: some View {
            ZStack {
                CameraPreview(session: session)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Button(action:{dismiss()})
                        {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                        }
                    }
                    Spacer()
                }
            }
            .onAppear {
                configureCamera()
                session.startRunning()
            }
            .onDisappear {
                session.stopRunning()
            }
        }
        private func configureCamera() {
            session.beginConfiguration()
            session.sessionPreset = .high
            
            guard let device = AVCaptureDevice.default(for: .video),
                  let input = try? AVCaptureDeviceInput(device: device),
                  session.canAddInput(input) else {
                print("Failed to access camera")
                return
            }
            
            session.addInput(input)
            session.commitConfiguration()
        }
    }
#Preview {
    CapturePage()
}
