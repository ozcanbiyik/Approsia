//
//  YemekSepetInteractor.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation
import Alamofire

class YemekSepetInteractor : PresenterToInteractorYemekSepetProtocol{
    
    var yemekSepetPresenter: InteractorToPresenterYemekSepetProtocol?
    
    func tumSepetListele(kullanici_adi: String) {
        let params : Parameters = ["kullanici_adi" : kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response{
            response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(SepetResponse.self, from : data)
                    var liste = [Sepet]()
                    if let gelenListe = cevap.sepet_yemekler{
                        liste = gelenListe;
                    }
                    self.yemekSepetPresenter?.presenteraVeriGonder(sepetListe: liste)
                }catch{
                    print(error.localizedDescription)
                    self.yemekSepetPresenter?.presenteraVeriGonder(sepetListe: [Sepet]())
                }
            }
        }
    }
    
    func seciliYemekSil(sepet_yemek_id: Int, kullanici_adi: String) {
        let params : Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post, parameters: params).response{
            response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]{
                        print(json)
                        self.tumSepetListele(kullanici_adi: kullanici_adi)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
