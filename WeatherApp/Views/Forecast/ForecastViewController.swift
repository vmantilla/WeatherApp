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
        viewModel.fetchForecast(for: 3)
        setupNavigationBar()
    }
    
    deinit {
        if let coordinator = coordinator {
            coordinator.didFinish()
        }
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
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)
        
        if indexPath.section == 1 {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            titleLabel.textColor = .white
            titleLabel.textAlignment = .center
            titleLabel.text = "Pronóstico para los próximos días"
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
                titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
                titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
            ])
        } else {
            for subview in headerView.subviews {
                subview.removeFromSuperview()
            }
        }
        
        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
}

extension ForecastViewController: ForecastViewModelDelegate {
    func forecastViewModelDidUpdateForecast() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.backgroundImageView.image = UIImage(named: self.viewModel.getImageNameForWeatherCondition())
        }
    }
    
    func forecastViewModelDidFailWithError(error: Error) {
        // Handle error
    }
}
