
import SwiftUI

public class UserEvents: ObservableObject {
    @Published public var didAskToCapturePhoto = false
    @Published public var didAskToRotateCamera = false
    @Published public var didAskToChangeFlashMode = false
    
    @Published public var didAskToRecordVideo = false
    @Published public var didAskToStopRecording = false
    
    public init() {
        
    }
}
