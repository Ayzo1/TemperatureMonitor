import Foundation

final class TemperaturePresenter: TemperaturePresenterProtocol {
    
    weak var view: TemperatureViewProtocol?
    private var service = BluetoothService()
    
    init(view: TemperatureViewProtocol) {
        self.view = view
        service.delegate = self
        service.connectBackground()
    }
}

extension TemperaturePresenter: BluetoothServiceDelegate {
    
    func didReceived(data: Data?, error: Error?) {
        guard let data = data else {
            return
        }
        
        let climateCharacteristics = ClimateCharacteristicsParser.parse(data: data)
        view?.updateValues(temperature: climateCharacteristics.temperature, humidity: climateCharacteristics.humidity)
    }
}
