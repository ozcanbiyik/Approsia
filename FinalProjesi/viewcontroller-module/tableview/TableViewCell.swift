//
//  TableViewCell.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {

    @IBOutlet weak var yemekAdLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var yemekGorselView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func yemekGorselAdi(gorselAdi : String){
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(gorselAdi)"){
            DispatchQueue.main.async {
                self.yemekGorselView.kf.setImage(with:url)
            }
        }
    }

}
