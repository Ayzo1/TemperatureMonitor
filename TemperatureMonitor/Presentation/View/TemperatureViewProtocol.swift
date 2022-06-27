import Foundation

protocol TemperatureViewProtocol: AnyObject {
    
    func updateValues(temperature: Float, humidity: Float)
    func startLoad()
    func endLoad()
}
