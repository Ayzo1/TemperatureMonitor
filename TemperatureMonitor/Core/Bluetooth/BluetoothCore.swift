import Foundation
import CoreBluetooth

final class BluetoothCore: NSObject {
    
    // MARK: - Private properties
    
    private var manager: CBCentralManager?
    private var xaiomiTermometer: CBPeripheral?
    private let serviceUUID = CBUUID(string: "EBE0CCB0-7A0A-4B0C-8A1A-6FF2997DA3A6")
    private let temperatureCBUUID = CBUUID(string: "EBE0CCC1-7A0A-4B0C-8A1A-6FF2997DA3A6")
    private var observer: BluetoothObserver?
    
    // MARK: - init()
    
    init(observer: BluetoothObserver) {
        super.init()
        self.observer = observer
    }
}

extension BluetoothCore: BluetoothObservable {
    
    func connect(queue: DispatchQueue?) {
        manager = CBCentralManager(delegate: self, queue: queue)
    }
    
    func disconnect() {
        
    }
}

extension BluetoothCore: CBCentralManagerDelegate, CBPeripheralDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state{
        case .unknown:
            print("unknow")
        case .resetting:
            print("resetting")
        case .unsupported:
            print("unsupported")
        case .unauthorized:
            print("unauthorized")
        case .poweredOff:
            print("poweredOff")
        case .poweredOn:
            print("poweredOn")
            manager?.scanForPeripherals(withServices: nil, options: nil)
        @unknown default:
            print("default")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if (peripheral.name == "LYWSD03MMC") {
            manager?.stopScan()
            self.xaiomiTermometer = peripheral
            self.xaiomiTermometer?.delegate = self
            manager?.connect(xaiomiTermometer!, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected")
        peripheral.discoverServices([serviceUUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
            print("no services")
            return
        }
        for service in services {
            peripheral.discoverCharacteristics([temperatureCBUUID], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
            print("no characteristics")
            return
        }
        for characteristic in characteristics {
            peripheral.setNotifyValue(true, for: characteristic)
            peripheral.readValue(for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        guard let data = characteristic.value else {
            return
        }
        observer?.didReceived(data: data, error: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Connect Failed")
    }
}
