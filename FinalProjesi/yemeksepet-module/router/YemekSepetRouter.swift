//
//  YemekSepetRouter.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 12.01.2022.
//

import Foundation

class YemekSepetRouter : PresenterToRouterYemekSepetProtocol{
    static func createModule(ref: YemekSepetVC) {
        
        let presenter = YemekSepetPresenter()
        
        ref.yemekSepetPresenterNesnesi = presenter
        
        ref.yemekSepetPresenterNesnesi?.yemekSepetInteractor = YemekSepetInteractor()
        ref.yemekSepetPresenterNesnesi?.yemekSepetView = ref
        
        
        ref.yemekSepetPresenterNesnesi?.yemekSepetInteractor?.yemekSepetPresenter = presenter
        
    }
}
