import UIKit

class TemperatureViewController: UIViewController {

    var presenter: TemperaturePresenterProtocol?
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    private lazy var progressBarView: CustomProgressView = {
        let progressBar = CustomProgressView(frame: CGRect(x: view.frame.width/2, y: view.frame.height/2, width: 200, height: 200))
        // progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.presenter = TemperaturePresenter(view: self)
        
        view.addSubview(progressBarView)
        // setupProgressBar()
        progressBarView.configurate()
        /*
        view.addSubview(temperatureLabel)
        setupTemperatureLabel()
        view.addSubview(humidityLabel)
        setupHumidityLabel()
         */
    }
    
    override func viewWillLayoutSubviews() {
    }
    
    override func viewDidLayoutSubviews() {
        print("aaaa")
        progressBarView.updatePositions()
    }
    
    private func setupProgressBar() {
        progressBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBarView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        progressBarView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        progressBarView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

extension TemperatureViewController: TemperatureViewProtocol {
    
    func updateValues(temperature: Float, humidity: Float) {
        DispatchQueue.main.async { [weak self] in
            
            self?.progressBarView.updateValue(value: humidity)
            // self?.temperatureLabel.text = String(temperature)
            // self?.humidityLabel.text = String(humidity)
        }
    }
    
    func startLoad() {
        
    }
    
    func endLoad() {
        
    }
}
