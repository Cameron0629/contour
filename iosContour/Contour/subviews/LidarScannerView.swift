import SwiftUI
import ARKit
import RealityKit

struct LidarScannerView: UIViewControllerRepresentable {
    class ScannerProxy {
        var exportAction: (() -> URL?)?
    }

    let proxy: ScannerProxy

    func makeUIViewController(context: Context) -> LidarScannerViewController {
        let controller = LidarScannerViewController()
        controller.coordinator = context.coordinator
        proxy.exportAction = controller.exportMesh
        return controller
    }

    func updateUIViewController(_ uiViewController: LidarScannerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, ARSessionDelegate {
        var meshAnchors: [UUID: ARMeshAnchor] = [:]

        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                if let meshAnchor = anchor as? ARMeshAnchor {
                    meshAnchors[meshAnchor.identifier] = meshAnchor
                }
            }
        }
    }
}

class LidarScannerViewController: UIViewController {
    var arView: ARView!
    var coordinator: LidarScannerView.Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView = ARView(frame: view.bounds)
        view.addSubview(arView)
        arView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let config = ARWorldTrackingConfiguration()
        config.sceneReconstruction = .mesh
        config.environmentTexturing = .automatic
        config.planeDetection = [.horizontal, .vertical]

        arView.debugOptions.insert(.showSceneUnderstanding)
        arView.session.delegate = coordinator
        arView.session.run(config)
    }

    func exportMesh() -> URL? {
        guard let meshes = coordinator?.meshAnchors.values else { return nil }
        
        var obj = ""
        var totalVertexCount = 0

        for mesh in meshes {
            let geometry = mesh.geometry
            let vertexCount = geometry.vertices.count
            let normalCount = geometry.normals.count

            let vertexPointer = geometry.vertices.buffer.contents().bindMemory(to: simd_float3.self, capacity: vertexCount)
            for i in 0..<vertexCount {
                let vertex = vertexPointer[i]
                obj += "v \(vertex.x) \(vertex.y) \(vertex.z)\n"
            }

            let normalPointer = geometry.normals.buffer.contents().bindMemory(to: simd_float3.self, capacity: normalCount)
            for i in 0..<normalCount {
                let normal = normalPointer[i]
                obj += "vn \(normal.x) \(normal.y) \(normal.z)\n"
            }
            
            let faceCount = geometry.faces.count
            let facePointer = geometry.faces.buffer.contents().bindMemory(to: UInt32.self, capacity: faceCount * 3)

            for i in 0..<faceCount {
                let baseIndex = i * 3
                let index1 = Int(facePointer[baseIndex]) + totalVertexCount + 1
                let index2 = Int(facePointer[baseIndex + 1]) + totalVertexCount + 1
                let index3 = Int(facePointer[baseIndex + 2]) + totalVertexCount + 1
                obj += "f \(index1)//\(index1) \(index2)//\(index2) \(index3)//\(index3)\n"
            }
            
            totalVertexCount += vertexCount
        }

        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("scan.obj")
        
        do {
            try obj.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            print("Failed to save OBJ file: \(error)")
            return nil
        }
    }
}
