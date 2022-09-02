//
//  MLResultView.swift
//  IOSFlowerClassifier
//
//  Created by onevfall on 2022/7/3.
//

import SwiftUI
import CoreImage
import SceneKit

let flower_name: [String:String] = [
    "MeiGui":"玫瑰", "BaiZhang":"白掌", "YuJinXiang": "郁金香", "AnShu": "桉树", "ManTianXing": "满天星", "HeiZhongCao": "黑种草", "DaXingQin": "大星芹"
]
let flower_discription: [String:String] = ["MeiGui":"适宜温度12～18℃，喜光畏湿","youjiali":"适宜温度15-25℃，注意定期修剪"]
struct MLResultView: View {
    
    @EnvironmentObject var document: FCDocument
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
                            Text(flower_name[className] ?? className)
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.446, green: 0.44, blue: 0.44))
                            Text(flower_discription[className] ?? className)
                                .font(.system(size: 15))
                                .foregroundColor(Color(red: 0.708, green: 0.708, blue: 0.708))
                        }
                        
                        Spacer()
                        Button {
                            var name = className
                            print(name)
                            name = "MeiGui"
                            // 已知className，如baihe
                            let filename = FlowerKind2FileName[name]
                            if filename != nil {
//                                let newScene = SCNScene(named: filename)!
//                                var child = newScene.rootNode.childNode(withName: "\(name)-1", recursively: true)!
                                // child是要添加进场景的东西
                                document.addFlowerByOne(name)
                                let childName = "\(name)-\(document.flowerNumber[name]!)"
                                document.addSceneChild(childName, SCNVector3(0,0,0), SCNVector4(0,0,0,0))
                                showIdentificationView = false
                            }
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




