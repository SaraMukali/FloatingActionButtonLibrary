//
//  Constants.swift
//  KCFloatingActionButton-Sample
//
//  Created by Sara Mukali on 09.01.17.
//  Copyright © 2017 Sara. All rights reserved.
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
    static let itemSpace: CGFloat = 20
    
    //Цвет вторичной кнопки
    static let itemColor: UIColor = UIColor.white
    
    //Иконка вторичной кнопки
    static let itemIcon: UIImage? = nil
    
    static let spaceBetweenItemAndTitle: CGFloat = 10
    
    //Расстояние от правого нижнего угла по горизонтали
    static let paddingX: CGFloat = 20
    
    //Расстояние от правого нижнего угла по вертикали
    static let paddingY: CGFloat = 20
    
    //Наличие тени основной и вторичной кнопок
    static let hasShadow: Bool = true
    
    //Радиус тени кнопки
    static let shadowRadius: CGFloat = 10
    
    //Наличие затемнения по нажатию на основную кнопку
    static let hasBlackout: Bool = false
    
    //Цвет затемнения
    static let blackoutColor: UIColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
    
    //Прозрачность затемнения
    static let blackoutOpacity: CGFloat = 1.0
    
    //Длительность затменения
    static let blackoutAnimationDuration: Double = 5
    
    //Активность основной кнопки
    static let isActive: Bool = false
    
    //Нестандартные размер и распложение кнопки
    static let isCustomFrame: Bool = false
    
    //На сколько при нажатии меняется каждый канал цвета основной кнопки
    static let tappedButtonColorChangeDifference: CGFloat = 20
    
    //Определенный цвет, в который перекрашивается основная кнопка при долгом нажатии
    static let tappedButtonChangedColor: UIColor? = nil
    
    //Значения основных параметров кнопки определены
    static let isDrawn = false
    
    //Способность кнопки скрываться
    static let canBeHidden = false
    
    //Длительность исчезновения кнопки
    static let hiddenAnimationDuration: Double = 1
}
