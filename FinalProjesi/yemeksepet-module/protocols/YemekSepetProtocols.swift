//
//  YemekSepetProtocols.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation

protocol PresenterToInteractorYemekSepetProtocol{
    var yemekSepetPresenter : InteractorToPresenterYemekSepetProtocol?{get set}
    func tumSepetListele(kullanici_adi : String)
    func seciliYemekSil(sepet_yemek_id : Int, kullanici_adi : String)
}

protocol ViewToPresenterYemekSepetProtocol{
    var yemekSepetInteractor : PresenterToInteractorYemekSepetProtocol?{get set}
    var yemekSepetView : PresenterToViewYemekSepetProtocol?{get set}
    func sepetListele(kullanici_adi : String)
    func yemekSil(sepet_yemek_id : Int, kullanici_adi : String)
}

protocol InteractorToPresenterYemekSepetProtocol{
    func presenteraVeriGonder(sepetListe : Array<Sepet>)
}

protocol PresenterToViewYemekSepetProtocol{
    func vieweVeriGonder(sepetListe : Array<Sepet>)
}

protocol PresenterToRouterYemekSepetProtocol{
    static func createModule(ref : YemekSepetVC)
}
