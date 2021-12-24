//
//  PopularShowsCell.swift
//  PopularShowsTvMaze
//
//  Created by Abdallah on 12/23/21.
//

import UIKit
import Cosmos
class PopularShowsCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var dateMovieLabel: UILabel!
    @IBOutlet weak var runTimeMovieLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    var callBack:(()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.settings.updateOnTouch = false
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 16, bottom:5, right: 16))
      }
    
    
    // fetch data and add in cell
    func set(result:ShowMovie){
        
        nameMovieLabel.text    = result.name
        dateMovieLabel.text    = result.premiered
        runTimeMovieLabel.text = "\(result.runtime ?? 0)"
        ratingView.rating      = Double(result.rating.average ?? 0)
        downloadImage(formURL: result.image?.medium ?? "")
        
    }
    
    // fetch image
    
    func downloadImage(formURL url:String){
        
        NetworkManger.shared.downLoadImage(from: url) { [weak self] (image) in
            guard let self = self else{return}
            DispatchQueue.main.async {
                self.movieImage.image = image
                
            }
        }
    }
    
   
    //MARK: - Action
    
    @IBAction func showUrlAction(_ sender: Any) {
         callBack?()

    }
}
