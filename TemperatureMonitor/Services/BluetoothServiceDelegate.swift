import Foundation

protocol BluetoothServiceDelegate: AnyObject {
    
    func didReceived(data: Data?, error: Error?)
}
