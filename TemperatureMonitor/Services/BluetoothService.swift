import Foundation

final class BluetoothService {
    
    private var bluetoothCore: BluetoothObservable?
    public weak var delegate: BluetoothServiceDelegate?
    
    init() {
        
    }
}

extension BluetoothService: BluetoothServiceProtocol {
    
    func connectBackground() {
        let queue = DispatchQueue.global(qos: .utility)
        self.bluetoothCore = BluetoothCore(observer: self)
        self.bluetoothCore?.connect(queue: queue)
    }
    
    func connectMain() {
        let queue = DispatchQueue.main
        self.bluetoothCore = BluetoothCore(observer: self)
        self.bluetoothCore?.connect(queue: queue)
    }
}

extension BluetoothService: BluetoothObserver {
    
    func didConnected(error: Error?) {
        
    }
    
    func didReceived(data: Data?, error: Error?) {
        self.delegate?.didReceived(data: data, error: error)
    }
}
