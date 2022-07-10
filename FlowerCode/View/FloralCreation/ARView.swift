//
//  ARView.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/7/4.
//

import SwiftUI
import RealityKit

struct ARFlowerView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let flowerAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(flowerAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ARView_Previews : PreviewProvider {
    static var previews: some View {
        ARFlowerView()
    }
}
#endif
