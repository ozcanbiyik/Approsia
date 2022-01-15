//
//  SepetTableViewHucre.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import UIKit
import Kingfisher

class SepetTableViewHucre: UITableViewCell {

    @IBOutlet weak var sepetYemekAdi: UILabel!
    @IBOutlet weak var sepetYemekGorsel: UIImageView!
    @IBOutlet weak var sepetYemekFiyat: UILabel!
    @IBOutlet weak var sepetYemekAdet: UILabel!
    @IBOutlet weak var sepetCellArkaplan: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func yemekGorselAdi(gorselAdi : String){
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(gorselAdi)"){
            DispatchQueue.main.async {
                self.sepetYemekGorsel.kf.setImage(with: url)
            }
        }
    }
}
