//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by RAUL MANTILLA ASSIA on 28/05/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    var coordinator: SearchCoordinator?
    var viewModel: SearchViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the view model
        viewModel = SearchViewModel()
        viewModel.delegate = self
        
        // Do any additional setup after loading the view.
        viewModel.searchLocation(query: "Cartagena")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
    
}

extension SearchViewController: SearchViewModelDelegate {
    func searchViewModelDidUpdateLocations() {
        // Handle the update in locations data and update the UI accordingly
        print(viewModel.getLocationCount())
    }
    
    func searchViewModelDidFailWithError(error: Error) {
        // Handle the error and display an appropriate message to the user
        print(error.localizedDescription)
    }
}
