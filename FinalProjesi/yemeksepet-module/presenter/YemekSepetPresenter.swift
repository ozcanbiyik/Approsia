//
//  YemekSepetPresenter.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation

class YemekSepetPresenter : ViewToPresenterYemekSepetProtocol{
    
    var yemekSepetInteractor: PresenterToInteractorYemekSepetProtocol?
    var yemekSepetView: PresenterToViewYemekSepetProtocol?
    
    func sepetListele(kullanici_adi: String) {
        yemekSepetInteractor?.tumSepetListele(kullanici_adi: kullanici_adi)
    }
    
    func yemekSil(sepet_yemek_id: Int, kullanici_adi: String) {
        yemekSepetInteractor?.seciliYemekSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
}

extension YemekSepetPresenter : InteractorToPresenterYemekSepetProtocol{
    func presenteraVeriGonder(sepetListe: Array<Sepet>) {
        yemekSepetView?.vieweVeriGonder(sepetListe: sepetListe)
    }
}
