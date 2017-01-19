//
//  Constants.swift
//  KCFloatingActionButton-Sample
//
//  Created by Sara Mukali on 09.01.17.
//  Copyright © 2017 kciter. All rights reserved.
//

import Foundation
import UIKit

//Значения параметров по умолчанию
struct Constants {
    //Радиус основной и вторичной кнопок
    static let radius: CGFloat = 20
    
    //Цвет основной кнопки
    static let color: UIColor = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1.0)
    
    //Иконка основной кнопки
    static let icon: UIImage? = UIImage(named: "icon")
    
    //Название вторичной кнопки
    static let title: String? = nil
    
    //Цвет названия вторичной кнопки
    static let titleColor: UIColor = UIColor.white
    
    //Расстояние между вторичными кнопками
    static let space: CGFloat = 20
    
    //Цвет вторичной кнопки
    static let itemColor: UIColor = UIColor.white
    
    //Иконка вторичной кнопки
    static let itemIcon: UIImage? = nil
    
    //Расстояние от правого нижнего угла по горизонтали
    static let paddingX: CGFloat = 20
    
    //Расстояние от правого нижнего угла по вертикали
    static let paddingY: CGFloat = 20
    
    //Наличие тени основной и вторичной кнопок
    static let hasShadow: Bool = true
    
    //Наличие затемнения по нажатию на основную кнопку
    static let hasBlackout: Bool = false
    
     //Цвет затемнения    
    static let blackoutColor: UIColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
    
    //Активность основной кнопки
    static let isActive: Bool = false
    
    //Нестандартные размер и распложение кнопки
    static let isCustomFrame: Bool = false
    
    //На сколько при нажатии меняется каждый канал цвета основной кнопки
    static let colorChange: CGFloat = 20
    
    //Определенный цвет, в который перекрашивается основная кнопка при долгом нажатии
    static let changedColor: UIColor? = nil
}
