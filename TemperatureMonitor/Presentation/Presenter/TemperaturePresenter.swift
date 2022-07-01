import Foundation

final class TemperaturePresenter: TemperaturePresenterProtocol {
    
    weak var view: TemperatureViewProtocol?
    private var service = BluetoothService()
    private var isFirstReceive: Bool = true
    
    init(view: TemperatureViewProtocol) {
        self.view = view
        service.delegate = self
        service.connectBackground()
        view.startLoad()
    }
}

extension TemperaturePresenter: BluetoothServiceDelegate {
    
    func didReceived(data: Data?, error: Error?) {
        guard let data = data else {
            return
        }
        if isFirstReceive {
            view?.endLoad()
            isFirstReceive = false
        }
        let climateCharacteristics = ClimateCharacteristicsParser.parse(data: data)
        view?.updateValues(temperature: climateCharacteristics.temperature, humidity: climateCharacteristics.humidity)
    }
}
