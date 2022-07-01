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
        let progressBar = CustomProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.presenter = TemperaturePresenter(view: self)
        
        view.addSubview(progressBarView)
        setupProgressBar()
        progressBarView.configurate()

        view.addSubview(temperatureLabel)
        setupTemperatureLabel()
    }
    
    private func setupProgressBar() {
        progressBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBarView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        progressBarView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        progressBarView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.topAnchor.constraint(equalTo: progressBarView.bottomAnchor, constant: 0).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

extension TemperatureViewController: TemperatureViewProtocol {
    
    func updateValues(temperature: Float, humidity: Float) {
        DispatchQueue.main.async { [weak self] in
            self?.progressBarView.updateValue(value: humidity)
            self?.temperatureLabel.text = "\(temperature)°C"
        }
    }
    
    func startLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.progressBarView.startLoadAnimation()
            self?.temperatureLabel.text = "––"
            self?.temperatureLabel.font = .boldSystemFont(ofSize: 80)
        }
    }
    
    func endLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.progressBarView.stopLoadAnimation()
            self?.temperatureLabel.alpha = 0
            self?.temperatureLabel.font = .boldSystemFont(ofSize: 40)
            
            guard let label = self?.temperatureLabel else {
                return
            }
            
            UILabel.transition(
                with: label,
                duration: 1,
                options: [.transitionCrossDissolve],
                animations: { [weak self] in
                    self?.temperatureLabel.alpha = 1
                },
                completion: nil)
        }
    }
}
