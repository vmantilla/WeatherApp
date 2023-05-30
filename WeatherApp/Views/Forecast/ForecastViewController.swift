import UIKit

class ForecastViewController: UIViewController {
    
    private var viewModel: ForecastViewModelProtocol!
    var coordinator: ForecastCoordinator?
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var backgroundImageView: UIImageView!
    
    init(viewModel: ForecastViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchForecast()
        setupNavigationBar()
    }
    
    deinit {
        if let coordinator = coordinator {
            coordinator.didFinish()
        }
    }
    
    private func fetchForecast() {
        viewModel.fetchForecast(for: 3)
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: ForecastCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ForecastCollectionViewCell.reuseIdentifier)
        collectionView.register(UINib(nibName: CurrentCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CurrentCollectionViewCell.reuseIdentifier)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
    }
}

extension ForecastViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return (viewModel.getCurrentWeather() != nil) ? 1 : 0
        case 1: return viewModel.getForecast()?.forecast.forecastday.count ?? 0
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentCollectionViewCell.reuseIdentifier, for: indexPath) as? CurrentCollectionViewCell,
                  let currentWeather = viewModel.getCurrentWeather() else {
                return UICollectionViewCell()
            }
            cell.configure(with: currentWeather, location: viewModel.getCurrentLocation())
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.reuseIdentifier, for: indexPath) as? ForecastCollectionViewCell,
                  let forecast = viewModel.getForecast(),
                  let forecastday = forecast.forecast.forecastday.safe(at: indexPath.item) else {
                return UICollectionViewCell()
            }
            cell.configure(with: forecastday)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension ForecastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20
        let height: CGFloat = (indexPath.section == 0) ? 200 : 100
        return CGSize(width: width, height: height)
    }
}

extension ForecastViewController: ForecastViewModelDelegate {
    func forecastViewModelDidUpdateForecast() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.backgroundImageView.image = UIImage(named: self.viewModel.getImageNameForWeatherCondition())
        }
    }
    
    func forecastViewModelDidFailWithError(title: String, error: String) {
        self.showAlertWithRetryCancel(
            title: title,
            message: error,
            retryHandler: { [weak self] in
                guard let self = self else { return }
                self.fetchForecast()
            },
            cancelHandler: { }
        )
    }
}
