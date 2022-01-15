//
//  YemekDetayInteractor.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation
import Alamofire

class YemekDetayInteractor : PresenterToInteractorYemekDetayProtocol{
    
    var yemekDetayPresenter: InteractorToPresenterYemekDetayProtocol?
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        let params : Parameters = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet": yemek_siparis_adet,"kullanici_adi" : kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post, parameters: params).response{
            response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]{
                        print(json)
                        self.yemekDetayPresenter?.presenteraVeriGonder()                        
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
