//
//  PopularShowsDetailsVC.swift
//  PopularShowsTvMaze
//
//  Created by Abdallah on 12/24/21.
//

import UIKit

class PopularShowsDetailsVC: UIViewController {

    @IBOutlet weak var showIamge: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var averageRunTimeLabel: UILabel!
    @IBOutlet weak var premieredLabel: UILabel!
    @IBOutlet weak var endedLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!


// pass data from PopularShowsVC in put in ShowMovie
    var ShowMovie: ShowMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadImage(formURL: ShowMovie?.image?.original ?? "")
        //
        nameLabel.text = ShowMovie?.name
        typeLabel.text = ShowMovie?.type.rawValue
        languageLabel.text = ShowMovie?.language.rawValue
        averageRunTimeLabel.text = "\(ShowMovie?.averageRuntime ?? 0)"
        premieredLabel.text = ShowMovie?.premiered
        endedLabel.text = ShowMovie?.ended
        summaryLabel.text = ShowMovie?.summary
    }
    
    //MARK: - Action
// open in Safari
    @IBAction func officialSiteAction(_ sender: Any) {
        self.goSafari(urlString: ShowMovie?.officialSite ?? "")
    }
    
    // fetch image
    
    func downloadImage(formURL url:String){
        
        NetworkManger.shared.downLoadImage(from: url) { [weak self] (image) in
            guard let self = self else{return}
            DispatchQueue.main.async {
                self.showIamge.image = image
                
            }
        }
    }
}
