//
//  FloatingActionButton.swift
//  FloatingActionButton
//
//  Created by Sara Mukali on 10.01.17.
//  Copyright © 2017 Sara. All rights reserved.
//

import UIKit

open class FloatingActionButton: UIView {
    
    //Радиус основной кнопки
    open var radius: CGFloat = Constants.radius
    
    //Цвет фона основной кнопки
    open var color: UIColor = Constants.color
    
    //Иконка основной кнопки
    open var image: UIImage? = Constants.image
    
    //Расстояние от нижнего правого угла по горизонтали
    open var paddingX: CGFloat = Constants.paddingX
    
    //Расстояние от нижнего правого угла по вертикали
    open var paddingY: CGFloat = Constants.paddingY
    
    //Наличие тени основной кнопки
    open var hasShadow: Bool = Constants.hasShadow
    
    //Наличие затемнения при нажатии на основную кнопку
    open var hasBlackout: Bool = Constants.hasBlackout
    
    //Цвет затемнения
    open var blackoutColor: UIColor = Constants.blackoutColor
    
    //Активаность кнопки
    open var isClosed: Bool = Constants.isClosed
    
    //Нестандартные размер и распложение кнопки
    fileprivate var isCustomFrame: Bool = Constants.isCustomFrame
    
    //Слой, позволяющий делать кнопку круглой
    fileprivate var circleLayer: CAShapeLayer = CAShapeLayer()
    
    //Вью, на которой расположена иконка
    fileprivate var buttonImageView: UIImageView = UIImageView()
    
    //Вью, которая затемняется
    fileprivate var blackoutView : UIControl = UIControl()
    
    //Пустой инициализатор
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: (radius*2), height: (radius*2)))
        backgroundColor = UIColor.clear
    }
    
    //Инициализатор с определнием радиуса
    public init(radius: CGFloat) {
        self.radius = radius
        
        super.init(frame: CGRect(x: 0, y: 0, width: (radius*2), height: (radius*2)))
        backgroundColor = UIColor.clear
    }
    
    //Инициализатор с определением размера и расположения
    public override init(frame: CGRect) {
        super.init(frame: frame)
        radius = min(frame.size.width/2, frame.size.height/2)
        backgroundColor = UIColor.clear
        isCustomFrame = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        radius = min(frame.size.width/2, frame.size.height/2)
        backgroundColor = UIColor.clear
        clipsToBounds = false
        isCustomFrame = true
    }
    
    //Добавление вью с кнопкой к основному вью
    public func add(on parentView: UIView) {
        parentView.addSubview(self)
    }
    
    //Функция, выполняющаяся при отображении вью
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        if isCustomFrame == false {
            setRightBottomFrame()
        } else {
            radius = min(frame.size.width/2, frame.size.height/2)
        }
        
        setCircleLayer()
        
        if image != nil {
            setButtonImage()
        }
        if hasShadow {
            setShadow()
        }
    }
    
    //Функция, выполняющаяся после нажатия на вью с кнопкой
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isTouched(touches) {
            toggle()
        }
    }
    
    //Функция, вызывающаяся при нажатии
    open func isTouched(_ touches: Set<UITouch>) -> Bool {
        return touches.count == 1 && touches.first?.tapCount == 1 && touches.first?.location(in: self) != nil
    }
    
    //Функция открывает или закрывает кнопку в зависимости от состояния
    fileprivate func toggle() {
        if isClosed == true {
            open()
        } else {
            close()
        }
    }
    
    //Состояние, когда видно затемнение и будут видны другие маленькие кнопки
    fileprivate func open() {
        setBlackoutView()
        self.superview?.insertSubview(blackoutView, aboveSubview: self)
        self.superview?.bringSubview(toFront: self)
        blackoutView.addTarget(self, action: #selector(close), for: UIControlEvents.touchUpInside)
        if hasBlackout {
            self.blackoutView.alpha = 1
        }
        isClosed = false
    }
    
    //Не видно затемнения
    @objc fileprivate func close() {
        self.blackoutView.removeTarget(self, action: #selector(close), for: UIControlEvents.touchUpInside)
        self.blackoutView.alpha = 0
        isClosed = true
    }
    
    //Функция делает кнопку круглой
    fileprivate func setCircleLayer() {
        circleLayer.removeFromSuperlayer()
        circleLayer.frame = CGRect(x: 0, y: 0, width: (radius*2), height: (radius*2))
        circleLayer.backgroundColor = color.cgColor
        circleLayer.cornerRadius = (radius*2)/2
        layer.addSublayer(circleLayer)
    }
    
    //Функция добавляет иконку
    fileprivate func setButtonImage() {
        buttonImageView.removeFromSuperview()
        buttonImageView = UIImageView(image: image)
        buttonImageView.frame = CGRect(
            x: circleLayer.frame.origin.x + (radius - buttonImageView.frame.size.width / 2),
            y: circleLayer.frame.origin.y + (radius - buttonImageView.frame.size.height / 2),
            width: buttonImageView.frame.size.width,
            height: buttonImageView.frame.size.height
        )
        addSubview(buttonImageView)
    }
    
    //Функция создет вью для затемнения
    fileprivate func setBlackoutView() {
        blackoutView.frame = CGRect(
            x: 0,y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        blackoutView.backgroundColor = blackoutColor
        blackoutView.alpha = 0
        blackoutView.isUserInteractionEnabled = true
    }
    
    //Функция добавляет
    fileprivate func setShadow() {
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
    }
    
    //Кнопка распологается в нижнем правом углу
    fileprivate func setRightBottomFrame() {
        if superview == nil {
            frame = CGRect(
                x: (UIScreen.main.bounds.size.width - radius*2) - paddingX,
                y: (UIScreen.main.bounds.size.height - radius*2) - paddingY,
                width: radius*2,
                height: radius*2
            )
        } else {
            frame = CGRect(
                x: (superview!.bounds.size.width-radius*2) - paddingX,
                y: (superview!.bounds.size.height-radius*2) - paddingY,
                width: radius*2,
                height: radius*2
            )
        }
    }
}

