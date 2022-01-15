//
//  ViewControllerInteractor.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation
import Alamofire

class ViewControllerInteractor : PresenterToInteractorViewControllerProtocol{
    
    var viewControllerPresenter: InteractorToPresenterViewControllerProtocol?
    
    func tumYemekleriListele() {
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response{ response in
            
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(YemeklerResponse.self, from: data)
                    var liste = [Yemekler]()
                    if let gelenListe = cevap.yemekler{
                        liste = gelenListe
                    }
                    
                    self.viewControllerPresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        let params : Parameters = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet": yemek_siparis_adet,"kullanici_adi" : kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post, parameters: params).response{
            response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]{
                        print(json)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func yemekAra(aramaKelimesi: String) {
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response{ response in
            
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(YemeklerResponse.self, from: data)
                    var yemek = [Yemekler]()
                    if let gelenListe = cevap.yemekler{
                        yemek = gelenListe.filter{$0.yemek_adi!.localizedCaseInsensitiveContains(aramaKelimesi)}
                    }
                    self.viewControllerPresenter?.presenteraVeriGonder(yemeklerListesi: yemek)
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
        /*
        var yemek = [Yemekler]()
        let yemekArr = [aramaKelimesi]
        yemek = yemek.filter { $0.yemek_adi!.contains(where: {yemekArr.contains(String($0))})}
        print(yemek)
        self.viewControllerPresenter?.presenteraVeriGonder(yemeklerListesi:yemek)
         */
       
    }
}
