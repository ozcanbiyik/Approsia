//
//  YemekDetayPresenter.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation

class YemekDetayPresenter : ViewToPresenterYemekDetayProtocol{
    
    var yemekDetayInteractor: PresenterToInteractorYemekDetayProtocol?
    var yemekDetayView : PresenterToViewYemekDetayProtocol?
    
    func ekle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        yemekDetayInteractor?.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
}

extension YemekDetayPresenter : InteractorToPresenterYemekDetayProtocol{
    func presenteraVeriGonder() {
        
    }

}
