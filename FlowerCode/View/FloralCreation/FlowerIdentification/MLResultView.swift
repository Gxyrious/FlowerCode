//
//  MLResultView.swift
//  IOSFlowerClassifier
//
//  Created by onevfall on 2022/7/3.
//

import SwiftUI
import CoreImage
import SceneKit

//var className: String?
//var confidence: Double?

fileprivate let flower_name: [String:String] = ["baihe":"百合", "youjiali":"尤加利"]
fileprivate let flower_scale: [String:Float] = ["baihe":2.5, "youjiali":0.15]
fileprivate let flower_position: [String:SCNVector3] = ["baihe":SCNVector3(-0.675,1,0.1), "youjiali":SCNVector3(-0.6,1,0.1)]
fileprivate let flower_discription: [String:String] = ["baihe":"适宜温度12～18℃，喜光畏湿","youjiali":"适宜温度15-25℃，注意定期修剪"]
struct MLResultView: View {
    @Binding var scene: SCNScene
    @Binding var nodesSelected: [String:Bool]
    @Binding var showIdentificationView: Bool
    
    var result: Flower5Output {
        let model: Flower5 = try! Flower5(configuration: .init())
        let pixelImage = MLResultView.buffer(from: (global_UIimage ?? UIImage(named: "imagePlaceholder"))!)
        guard let result = try? model.prediction(image: pixelImage!) else { fatalError("unexpected error happened") }
        return result
    }
    var className: String {
        result.classLabel
    }
    var confidence: Double {
        result.classLabelProbs[result.classLabel] ?? 1.0
    }
    static func buffer(from image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }

        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)

        UIGraphicsPushContext(context!)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

        return pixelBuffer
    }
    var body: some View {
        ZStack{
            if (global_UIimage != nil){
                VStack{
                    //此处应该加个判断，对于判断结果需要分别展示
                    HStack{
                        Image(className)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(.leading, 20)
                        VStack {
                            Text(flower_name[className] ?? "无法识别")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.446, green: 0.44, blue: 0.44))
                            Text(flower_discription[className] ?? "")
                                .font(.system(size: 15))
                                .foregroundColor(Color(red: 0.708, green: 0.708, blue: 0.708))
                        }
                        
                        Spacer()
                        Button {
                            // 已知className
                            let filename = className + ".dae"
                            guard let newScene = SCNScene(named: filename) else { return }
                            var child = newScene.rootNode.childNode(withName: "main", recursively: true)
                            if child == nil {
                                child  = newScene.rootNode
                            }
                            if child != nil {
                                let name = className
                                var i = 1
                                while nodesSelected.keys.contains("\(name)-\(i)") {
                                    i += 1
                                }
                                child?.name = "\(name)-\(i)"
                                let size: Float? = flower_scale[className] ?? nil
                                if size != nil {
                                    child?.scale = SCNVector3(size!,size!,size!)
                                }
                                child?.position = flower_position[className] ?? SCNVector3(0,0,0)
                                scene.rootNode.addChildNode(child!)
                                nodesSelected.updateValue(false, forKey: "\(name)-\(i)")
                                print("nodesSelected = \(nodesSelected)")
                            }
                            showIdentificationView = false
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 30))
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .background(Color(red: 0.6523, green: 0.6992, blue: 0.5586))
                                .clipShape(Circle())
                                .padding(.horizontal)
                        }
                    }
                }
                .background(.white)
            }
        }
    }
}




