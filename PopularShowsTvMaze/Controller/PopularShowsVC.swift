//
//  PopularShowsVC.swift
//  PopularShowsTvMaze
//
//  Created by Abdallah on 12/23/21.
//

import UIKit

class PopularShowsVC: UIViewController {

    @IBOutlet weak var PopularShowsTableView: UITableView!
    
    var popularShowMovie = [PopularShow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNibCell()
        tableViewDesign()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovie()

    }
    
    func fetchMovie(){
        // to show Activity
        self.showLoadingView()
        // fetch data and call api
        NetworkManger.shared.getPopularShows { [weak self] result in
            guard let self = self else{return}
            switch result {
            // get response
            case .success(let response):
                
                //fetch add append in arry

                self.popularShowMovie = response
                //reload tableView in background
                DispatchQueue.main.async {
                    self.PopularShowsTableView.reloadData()
                }
                // to hide Activity when loading data

                self.dismissLoadingView()
            //  show error in Alert
            case .failure(let error):
                self.dismissLoadingView()
                self.showAlert(withTitle: "Some thing error", withMessage: error.rawValue)
            }
        }
    }
  

}

//MARK: -  Table View
extension PopularShowsVC : UITableViewDataSource , UITableViewDelegate{
    
    // call cutom nibCell
    func configureNibCell(){
        let nib = UINib(nibName: Constant.popularShowsCell, bundle: nil)
        PopularShowsTableView.register(nib, forCellReuseIdentifier: Constant.popularShowsCell)
    }
    
    // to hide separator
    func tableViewDesign() {
        PopularShowsTableView.tableFooterView = UIView()
        PopularShowsTableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularShowMovie.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.popularShowsCell) as? PopularShowsCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        // to add data in cell
        let movies = popularShowMovie[indexPath.row].show
        cell.set(result: movies)
        
        //callBack data
        cell.callBack = {
            // open Url inside cell
            self.goSafari(urlString: movies.url)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constant.showDetails, sender: self)

    }

    //MARK: - prepareSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.showDetails {
            let detailsController = segue.destination as! PopularShowsDetailsVC
            if let indexPath = PopularShowsTableView.indexPathForSelectedRow {
                // pass data of array to next Page and show it
                detailsController.ShowMovie = popularShowMovie[indexPath.row].show
            }else{
                return print("error")
            }
        }
    }
}
