//
//  Styles.swift
//  RedDog
//
//  Created by Marco Antonio Flores Lopez on 17/03/21.
//

import Foundation
import UIKit

struct AppColors {
    let marineBlue = UIColor(named: "marineBlue") ?? .white
    let lightGray = UIColor(named: "ligthGray") ?? .lightGray
    let gray = UIColor(named: "gray") ?? .gray
    let darkGray = UIColor(named: "darkGray") ?? .darkGray
    let red = UIColor(named: "red") ?? .red
}

struct AppFonts {
    let helveticaBold = UIFont(name: "Helvetica-Bold", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
    let helvetica = UIFont(name: "Helvetica", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
}

struct AppImages {
    var logo: UIImage { get { return getImage(named: "logo") } }
    
    private func getImage(named: String) -> UIImage {
       return UIImage(named: named) ?? UIImage()
    }
}

struct AppStyle {
    let windowHeight = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.frame.size.height ?? 667.0
    let colors = AppColors()
    let fonts = AppFonts()
    let images = AppImages()
}

let kStyle = AppStyle()
