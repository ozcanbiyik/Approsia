//
//  YemekDetayProtocols.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation

protocol PresenterToInteractorYemekDetayProtocol{
    var yemekDetayPresenter : InteractorToPresenterYemekDetayProtocol?{get set}
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String)
}

protocol ViewToPresenterYemekDetayProtocol{
    var yemekDetayInteractor : PresenterToInteractorYemekDetayProtocol?{get set}
    var yemekDetayView : PresenterToViewYemekDetayProtocol?{get set}
    func ekle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String)
}

protocol InteractorToPresenterYemekDetayProtocol{
    func presenteraVeriGonder()
}

protocol PresenterToViewYemekDetayProtocol{
    func vieweVeriGonder()
}

protocol PresenterToRouterYemekDetayProtocol{
    static func createModule(ref : YemekDetayVC)
}
