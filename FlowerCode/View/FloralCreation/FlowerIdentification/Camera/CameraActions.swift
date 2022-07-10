
import Foundation

public protocol CameraActions {
    func takePhoto(events: UserEvents)
    func toggleVideoRecording(events: UserEvents)
    func rotateCamera(events: UserEvents)
    func changeFlashMode(events: UserEvents)
}

public extension CameraActions {
    func takePhoto(events: UserEvents) {
        events.didAskToCapturePhoto = true
    }
    
    func toggleVideoRecording(events: UserEvents) {
        if events.didAskToRecordVideo {
            events.didAskToStopRecording = true
        } else {
            events.didAskToRecordVideo = true
        }
    }
    
    func rotateCamera(events: UserEvents) {
        events.didAskToRotateCamera = true
    }
    
    func changeFlashMode(events: UserEvents) {
        events.didAskToChangeFlashMode = true
    }
}
