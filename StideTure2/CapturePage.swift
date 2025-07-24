//
//  CapturePage.swift
//  StideTure2
//
//  Created by 52GOParticipant on 7/18/25.
//

import SwiftUI
import AVFoundation
import CoreML
import Vision

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
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {}
}

struct CapturePage: View {
    @AppStorage("selectedOption") private var selectedOption: String?
    @AppStorage("currentTargetImage") var currentTargetImage: String = ""
    @AppStorage("score") var score: Int = 0
    @State private var session = AVCaptureSession()
    @State private var photoOutput = AVCapturePhotoOutput()
    @State private var classificationResult: String = ""
    @State private var processor: PhotoCaptureProcessor?
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
                
                Text (classificationResult)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                Button(action: takePhoto) {
                    Image (systemName: "camera.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                }
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
        session.sessionPreset = .photo
        
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input) else {
            print("Failed to access camera")
            return
        }
        
        session.addInput(input)
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }else{
            print ("cannot add photoOutput")
        }
        session.commitConfiguration()
    }
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        let newProcessor = PhotoCaptureProcessor() { image in classifyImage(image)}
        self.processor = newProcessor
        photoOutput.capturePhoto(with: settings, delegate: newProcessor)
    }
    
func classifyImage(_ image: UIImage) {
        do {
            let mlModel: MLModel
            guard let option = selectedOption?.lowercased() else {
                classificationResult = "No environment selected"
                return
            }

            switch option {
            case "forest":
                mlModel = try Forest(configuration: MLModelConfiguration()).model
            case "park":
                mlModel = try Park(configuration: MLModelConfiguration()).model
            case "city":
                mlModel = try StreetOrCity(configuration: MLModelConfiguration()).model
            default:
                classificationResult = "Unknown environment: \(option)"
                return
            }
            let model = try VNCoreMLModel(for: mlModel)
            
            guard let ciImage = CIImage(image: image) else {
                classificationResult = "Invalid image"
                return
            }
            
            let request = VNCoreMLRequest(model: model) { request, error in
                if let results = request.results as? [VNClassificationObservation],
                   let top = results.first {
                    
                
                   let prediction = top.identifier.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                   let target = currentTargetImage.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

                    DispatchQueue.main.async {
                        classificationResult = "Prediction: \(top.identifier) (\(String(format: "%.2f", top.confidence * 100))%)"
                        if prediction == target {
                            score += 1
                            allTimeScore +=1
                            classificationResult += "\n✅ Match! +1 Point"
                        } else {
                            classificationResult += "\n❌ No Match"
                        }
                    }
                } else{
                    DispatchQueue.main.async {
                        classificationResult = "No prediction"
                    }
                }
            }
            let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
            try handler.perform([request])
            
        } catch {
            classificationResult = "Failed to load model: \(error.localizedDescription)"
        }
    }
}
class PhotoCaptureProcessor: NSObject, AVCapturePhotoCaptureDelegate {
    var completionHandler: (UIImage) -> Void

    init(completion: @escaping (UIImage) -> Void) {
        self.completionHandler = completion
    }

    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        if let data = photo.fileDataRepresentation(),
           let uiImage = UIImage(data: data) {
            completionHandler(uiImage)
        } else {
            print("Photo capture failed")
        }
    }
}
#Preview {
    CapturePage()
}
