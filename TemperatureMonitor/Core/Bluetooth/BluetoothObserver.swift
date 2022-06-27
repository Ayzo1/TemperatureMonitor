import Foundation

protocol BluetoothObserver {
    
    func didConnected(error: Error?)
    func didReceived(data: Data?, error: Error?)
}
