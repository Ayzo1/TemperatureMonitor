import Foundation

protocol BluetoothServiceProtocol {
    
    var delegate: BluetoothServiceDelegate? { get set }
    func connectBackground()
    func connectMain()
}
