//
//  ViewControllerProtocols.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation

protocol PresenterToInteractorViewControllerProtocol{
    
    var viewControllerPresenter : InteractorToPresenterViewControllerProtocol?{get set}
    func tumYemekleriListele()
    func yemekAra(aramaKelimesi : String)
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String)
    
}

protocol ViewToPresenterViewControllerProtocol{
    
    var viewControllerInteractor : PresenterToInteractorViewControllerProtocol?{get set}
    var viewControllerView : PresenterToViewViewControllerProtocol?{get set}
    func yemekleriListele()
    func ara(aramaKelimesi : String)
    func ekle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String)
    
}

protocol InteractorToPresenterViewControllerProtocol{
    func presenteraVeriGonder(yemeklerListesi : Array<Yemekler>)
}

protocol PresenterToViewViewControllerProtocol{
    func vieweVeriGonder(yemeklerListesi : Array<Yemekler>)
}

protocol PresenterToRouterViewControllerProtocol{
    static func createModule(ref : ViewController)
}
