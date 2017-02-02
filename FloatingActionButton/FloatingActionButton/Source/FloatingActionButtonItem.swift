//
//  FloatingActionButtonItem.swift
//  FloatingActionButton
//
//  Created by Sara Mukali on 12.01.17.
//  Copyright © 2017 Sara. All rights reserved.
//

import UIKit

public enum TitlePosition {
    case left
    case right
}

open class FloatingActionButtonItem: UIView {
    //Основная кнопка
    open weak var actionButton: FloatingActionButton?
    
    //Функция, выполняющаяся при нажатии на вторичную кнопку
    open var handler: ((FloatingActionButtonItem) -> Void)? = nil
    
    //Радиус вторичной кнопки
    open var radius: CGFloat = Constants.radius
    
    //Цвет вторичной кнопки
    open var color: UIColor = Constants.itemColor
    
    //Иконка вторичной кнопки
    open var icon: UIImage? = Constants.itemIcon
    
    //Название вторичной кнопки
    open var title: String? = Constants.title
    
    //Цвет названия вторичной кнопки
    open var titleColor: UIColor = Constants.titleColor
    
    //Лэйбел, на котором отображается название
    open var titleLabel: UILabel = UILabel()
    
    //Расположение названия относительно вторичной кнопки
    open var titlePosition: TitlePosition = .left
    
    //Вью, на которой расположена иконка
    fileprivate var iconImageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    //Слой, позволяющий делать кнопку круглой
    fileprivate var circleLayer: CAShapeLayer = CAShapeLayer()
    
    //Пустой инициализатор
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
        backgroundColor = UIColor.clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Функция, выполняющаяся при отображении вью
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        frame =  CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        createCircleLayer()
        setShadow()
        
        if title != nil {
            setTitle()
        }
        
        if icon != nil {
            addIcon()
        }
    }
    
    //Функция, выполняющаяся после первого прикосновения ко вью с основной кнопкой
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count == 1, let touch = touches.first, touch.tapCount == 1 {
            return
        }
    }

    //Функция, выполняющаяся во время подвижного прикосновения ко вью с основной кнопкой
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count == 1, let touch = touches.first, touch.tapCount == 1 {
            return
        }
    }
    
    //Функция, выполняющаяся после нажатия на вью с вторичной кнопкой
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count == 1, let touch = touches.first, touch.tapCount == 1 {
            if let button = actionButton {
                button.deactivate()
            }
            if let handler = handler {
                handler(self)
            }
        }
    }

    //Функция делает кнопку круглой
    fileprivate func createCircleLayer() {
        let castParent : FloatingActionButton = superview as! FloatingActionButton
        circleLayer.frame = CGRect(x: castParent.itemRadius - radius, y: 0, width: radius * 2, height: radius * 2)
        circleLayer.backgroundColor = color.cgColor
        circleLayer.cornerRadius = radius
        layer.addSublayer(circleLayer)
    }
    
    //Функция добавляет тень к вторичной кнопке
    fileprivate func setShadow() {
        circleLayer.shadowOffset = CGSize(width: 1, height: 1)
        circleLayer.shadowRadius = 2
        circleLayer.shadowOpacity = 0.4
        
        titleLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        titleLabel.layer.shadowRadius = 2
        titleLabel.layer.shadowOpacity = 0.4
    }
    
    //Функция добавляет название кнопки
    fileprivate func setTitle() {
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.sizeToFit()
        switch titlePosition {
        case .right:
            titleLabel.frame.origin.x = frame.size.width + Constants.spaceBetweenItemAndTitle
        case .left:
            titleLabel.textAlignment = .left
            titleLabel.frame.origin.x = -titleLabel.frame.size.width - Constants.spaceBetweenItemAndTitle
        }
        titleLabel.frame.origin.y = radius-titleLabel.frame.size.height/2
        addSubview(titleLabel)
    }
    
    //Функция добавляет иконку к вторичной кнопке
    fileprivate func addIcon() {
        iconImageView.center = CGPoint(x: radius, y: radius)
        iconImageView.contentMode = UIViewContentMode.scaleAspectFill
        iconImageView.image = icon
        addSubview(iconImageView)
    }
}
