import UIKit
import SwiftUI
import SceneKit
import ARKit


//struct ARView: View {
//
//}

class ARViewController: UIViewController, ARSCNViewDelegate {

    var sceneView: ARSCNView = ARSCNView()
    var planeNodes = [SCNNode]()
    let configuration = ARWorldTrackingConfiguration()
    
    var sceneOfSwiftUI: ARViewContainer?
    
//    @EnvironmentObject var modelData: ModelData
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = SCNScene()
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        cubeNode.position = SCNVector3(0, 0, -0.2) // SceneKit/AR coordinates are in meters
        sceneView.scene.rootNode.addChildNode(cubeNode)
        
//        let around = modelData.scene.rootNode.childNode(withName: "around-scene", recursively: true)!
//        sceneView.scene.rootNode.addChildNode(around)
        sceneOfSwiftUI = ARViewContainer(sceneView: sceneView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadConfiguration()
    }
    func reloadConfiguration(removeAnchors: Bool = false)
    {
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.detectionImages = nil
        let options: ARSession.RunOptions
        
        if removeAnchors{
            options = [.removeExistingAnchors]
            for node in planeNodes {
                node.removeFromParentNode()
            }
            planeNodes.removeAll()
        } else {
            options = []
        }
        sceneView.session.run(configuration, options: options)
        }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // This visualization covers only detected planes.
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // Create a SceneKit plane to visualize the node using its position and extent.
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        let planeNode = SCNNode(geometry: plane)
        planeNode.isHidden = true
        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z)
        
        // SCNPlanes are vertically oriented in their local coordinate space.
        // Rotate it to match the horizontal orientation of the ARPlaneAnchor.
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        
        // ARKit owns the node corresponding to the anchor, so make the plane a child node.
        node.addChildNode(planeNode)
    }

}

struct ARViewContainer: UIViewRepresentable {
    
    var sceneView: ARSCNView
    
    func makeUIView(context: Context) -> ARSCNView {
        return sceneView
    }
    
    func updateUIView(_ uiViewController: ARSCNView, context: Context) {
        
    }
}

struct ARView: View {
    
    var controller: ARViewController
    
    init() {
        controller = ARViewController()
    }
    
    var body: some View {
        ZStack {
            controller.sceneOfSwiftUI
        }
    }
}
