import Foundation

enum BluetoothError: Error {
    
    case unknown
    case resetting
    case unsupported
    case unauthorized
    case poweredOff
    case poweredOn
}

/*
extension BluetoothError {
    public var description: String {
        switch self {
        case .badURL:
            return "bad url"
        case .couldNotParse:
            return "could not create URL from string"
        case .networkError:
            return "failed to load data from API"
        }
    }
}
*/
