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
    "MeiGui":"玫瑰", "BaiZhang":"白掌", "YuJinXiang": "郁金香", "AnShu": "桉树", "ManTianXing": "铃兰", "HeiZhongCao": "黑种草", "DaXingQin": "大星芹"
]

let flower_discription: [String:String] = [
    "AnShu":"桃金娘科桉属植物，原产地主要在澳洲大陆",
    "BaiHe":"别名苞叶芋，是天南星科多年生常绿草本观叶植物",
    "BaiZhang":"是菊科雏菊属植物，多年生草本植物",
    "DaXingQin":"伞形科星芹属的一种多年生草本，株高60-90厘米",
    "HeiZhongCao":"一种喜阳光植物，需要充足的光照",
    "JuHua":"喜阳光，忌荫蔽，较耐旱，怕涝",
    "KangNaiXin":"通常香气四溢，开花时间长",
    "XueLiu":"枝灰白色，圆柱形，小枝淡黄色或淡绿色",
    "ChuJu":"匙形丛生呈莲座状，密集矮生，颜色碧翠",
    "HuangYing":"有长根状茎。茎直立，高达2.5米",
    "XiangRiKui":"茎秆直立、结实；叶多互生；花为头状花序",
    "ManTianXing":"茎细皮滑，分枝甚多，叶片窄长，无柄，对生",
    "YuanWei":"多年生草本，根状茎粗壮，花蓝紫色",
    "XiuQiuHua":"喜阴、喜湿、喜肥，耐寒性又较差",
    "YuLan":"树皮深灰色，粗糙开裂；小枝稍粗壮，灰褐色",
    "MiDieXiang":"产于地中海盆地，木本多年生香料植物",
    "GaoShanYangChi":"喜阴、喜潮、喜偏酸性土壤",
    "YinYeJu":"分支性强，丛生状，叶片质较薄，缺裂",
    "GuiBeiZhu":"茎绿色，粗壮，有苍白色的半月形叶迹",
    "PingAnShu":"喜光又耐阴，喜暖热、无霜雪",
    "XiangPiShu":"片肥厚宽大，色彩浓绿，顶芽鲜红",
    "SanWeiKui":"茎干光滑，黄绿色，无毛刺"
]

struct MLResultView: View {
    
    @EnvironmentObject var document: FCDocument
    @Binding var showIdentificationView: Bool
    
    @State var isShowAlert: Bool = false
    
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
                        Image(FlowerNameDict[className]!)
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
                            let name = className
                            
                            print(name)
//                            name = "MeiGui"
                            // 已知className，如baihe
                            let filename = FlowerKind2FileName[name]
                            if filename != nil { // 模型存在
//                                let newScene = SCNScene(named: filename)!
//                                var child = newScene.rootNode.childNode(withName: "\(name)-1", recursively: true)!
                                // child是要添加进场景的东西
                                document.addFlowerByOne(name)
                                let childName = "\(name)-\(document.flowerNumber[name]!)"
                                document.addSceneChild(childName, SCNVector3(0,0,0), SCNVector4(0,0,0,0))
                                
                                showIdentificationView = false
                            }
                            else {
                                isShowAlert = true
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
        .alert(Text("添加失败"), isPresented: $isShowAlert) {
            Button("确定") {}
        } message: {
            Text("该模型未拥有")
        }
    }
}




