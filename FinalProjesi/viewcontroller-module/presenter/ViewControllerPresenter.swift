//
//  ViewControllerPresenter.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation

class ViewControllerPresenter : ViewToPresenterViewControllerProtocol{
    
    var viewControllerInteractor: PresenterToInteractorViewControllerProtocol?
    var viewControllerView: PresenterToViewViewControllerProtocol?
    
    func yemekleriListele() {
        viewControllerInteractor?.tumYemekleriListele()
    }
    func ekle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        viewControllerInteractor?.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    func ara(aramaKelimesi: String) {
        viewControllerInteractor?.yemekAra(aramaKelimesi: aramaKelimesi)
    }
}

extension ViewControllerPresenter : InteractorToPresenterViewControllerProtocol{
    func presenteraVeriGonder(yemeklerListesi: Array<Yemekler>) {
        viewControllerView?.vieweVeriGonder(yemeklerListesi: yemeklerListesi)
    }
}
