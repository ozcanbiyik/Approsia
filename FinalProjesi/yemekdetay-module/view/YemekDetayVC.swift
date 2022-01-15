//
//  YemekDetayVC.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import UIKit


class YemekDetayVC: UIViewController {

    @IBOutlet weak var yemekGorselView: UIImageView!
    @IBOutlet weak var yemekAdLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    
    @IBOutlet weak var detayView: UIView!
    var yemek : Yemekler?
    var yemekDetayPresenterNesnesi : ViewToPresenterYemekDetayProtocol?
    
    var yemekAdet : Int = 1
    var yemekFiyat : Int = 0
    var kullaniciAdi : String = "ozcan_biyik"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let y = yemek{
            yemekAdLabel.text = y.yemek_adi
            yemekFiyatLabel.text = "\(y.yemek_fiyat!)₺"
            resimGorselAdi(gorselAdi:y.yemek_resim_adi!)
        }
        
        
        detayView.layer.cornerRadius = 50
        detayView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        
        YemekDetayRouter.createModule(ref: self)

    }
    
    func resimGorselAdi(gorselAdi : String){
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(gorselAdi)"){
            DispatchQueue.main.async {
                self.yemekGorselView.kf.setImage(with:url)
            }
        }
    }
    
    @IBAction func stepperDegistir(_ sender: UIStepper) {
        yemekAdet = Int(sender.value)
        yemekFiyat = Int(yemekFiyat * yemekAdet)
        stepperLabel.text = String(Int(sender.value))
        print("\(yemekFiyat)")
    }
    
    //var yemekFiyatx = (Int((yemek?.yemek_fiyat!)!)! * Int(stepperLabel.text!)!)
    
    //var a = Int((yemek?.yemek_fiyat!)!)!
    
    @IBAction func sepeteEkleButton(_ sender: Any) {
        
        if let y = yemek, let sl = Int(stepperLabel.text!){
            yemekDetayPresenterNesnesi?.ekle(yemek_adi: y.yemek_adi!, yemek_resim_adi: y.yemek_resim_adi!, yemek_fiyat: Int(y.yemek_fiyat!)!, yemek_siparis_adet: sl, kullanici_adi: kullaniciAdi)
        }
        performSegue(withIdentifier: "toYemekSepetVC", sender: yemek)

    }
    
}

extension YemekDetayVC : PresenterToViewYemekDetayProtocol{
    func vieweVeriGonder() {
        //
    }
}
