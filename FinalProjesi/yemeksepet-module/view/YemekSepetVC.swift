//
//  YemekSepetVC.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import UIKit

class YemekSepetVC: UIViewController {
    
    var sepetListe = [Sepet]()
    var yemekSepetPresenterNesnesi : ViewToPresenterYemekSepetProtocol?

    @IBOutlet weak var sepetYemeklerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sepetYemeklerTableView.delegate = self
        sepetYemeklerTableView.dataSource = self
        YemekSepetRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        yemekSepetPresenterNesnesi?.sepetListele(kullanici_adi: "ozcan_biyik")
    }
    
}

extension YemekSepetVC : PresenterToViewYemekSepetProtocol{
    func vieweVeriGonder(sepetListe: Array<Sepet>) {
        self.sepetListe = sepetListe
        DispatchQueue.main.async {
            self.sepetYemeklerTableView.reloadData()
        }
    }
}

extension YemekSepetVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sepetYemek = sepetListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sepetHucre", for: indexPath) as! SepetTableViewHucre
        cell.sepetYemekAdi.text = "\(sepetYemek.yemek_adi!)"
        cell.sepetYemekFiyat.text = "\(Int(sepetYemek.yemek_fiyat!)! * Int(sepetYemek.yemek_siparis_adet!)!)₺"
        cell.yemekGorselAdi(gorselAdi: sepetYemek.yemek_resim_adi!)
        cell.sepetYemekAdet.text = "\(sepetYemek.yemek_siparis_adet!)"
        
        cell.backgroundColor = UIColor(white : 0.95, alpha: 1)
        cell.sepetCellArkaplan.layer.cornerRadius = 10.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sepetten Sil"){
            (UIContextualAction,view,bool) in
            
            let sepet = self.sepetListe[indexPath.row]
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(sepet.yemek_adi!) silinsin mi?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel){action in}
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){action in
                self.yemekSepetPresenterNesnesi?.yemekSil(sepet_yemek_id: Int(sepet.sepet_yemek_id!)!, kullanici_adi: "ozcan_biyik")}
                alert.addAction(evetAction)
                self.present(alert,animated: true)
            }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
}
