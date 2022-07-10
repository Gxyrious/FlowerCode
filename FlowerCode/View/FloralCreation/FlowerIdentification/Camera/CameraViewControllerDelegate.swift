
import UIKit

public protocol CameraViewControllerDelegate {
//    func cameraAccessGranted()
//    func cameraAccessDenied()
    func noCameraDetected()
    func cameraSessionStarted()
    
    func didCapturePhoto()
    func didRotateCamera()
    func didChangeFlashMode()
    func didFocusOnPoint(_ point: CGPoint)
    func didChangeZoomLevel(_ zoom: CGFloat)
    
    func didStartVideoRecording()
    func didFinishVideoRecording()
    
    func didSavePhoto()
    func didFinishProcessingPhoto(_ image: UIImage)
    func didFinishSavingWithError(_ image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer)
    
    func didChangeMaximumVideoDuration(_ duration: Double)
}
