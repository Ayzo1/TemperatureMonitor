import Foundation

protocol BluetoothObservable {
    
    func connect(queue: DispatchQueue?)
    func disconnect()
}
