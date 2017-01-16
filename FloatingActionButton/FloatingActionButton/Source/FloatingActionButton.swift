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
    open var icon: UIImage? = Constants.icon
    
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
    
    //Активность кнопки
    open var isActive: Bool = Constants.isActive
    
    //Массив из вторичных кнопок
    open var items: [FloatingActionButtonItem] = []
    
    //Радиус вторичной кнопки
    open var itemRadius: CGFloat = Constants.radius
        {
        didSet {
            items.forEach { item in
                item.radius = itemRadius
            }
            redrawItems()
        }
    }
    
    //Расстояние между вторичными кнопками
    open var itemSpace: CGFloat = Constants.space
    
    //Цвет вторичной кнопки
    open var itemColor: UIColor = Constants.itemColor
    
    //Цвет названия кнопки
    open var itemTitleColor: UIColor = Constants.titleColor
    
    //Нестандартные размер и распложение кнопки
    fileprivate var isCustomFrame: Bool = Constants.isCustomFrame
    
    //Слой, позволяющий делать кнопку круглой
    fileprivate var circleLayer: CAShapeLayer = CAShapeLayer()
    
    //Вью, на которой расположена иконка
    fileprivate var iconImageView: UIImageView = UIImageView()
    
    //Вью, которая затемняется
    fileprivate var blackoutView : UIControl = UIControl()
    
    //Функция, выполняющаяся при нажатии на основную кнопку, если нет вторичных
    fileprivate var handler: ((FloatingActionButton) -> Void)? = nil
    
    //Пустой инициализатор
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: (radius * 2), height: (radius * 2)))
        backgroundColor = UIColor.clear
    }
    
    //Инициализатор с определнием радиуса
    public init(radius: CGFloat) {
        self.radius = radius
        
        super.init(frame: CGRect(x: 0, y: 0, width: (radius * 2), height: (radius * 2)))
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
        if !isCustomFrame {
            setRightBottomFrame()
        } else {
            radius = min(frame.size.width/2, frame.size.height/2)
        }
        
        setCircleLayer()
        
        if icon != nil {
            setIcon()
        }
        if hasShadow {
            setShadow()
        }
    }

    //Функция добавляет вторичную кнопку в массив
    open func addItem(item: FloatingActionButtonItem) {
        let bigRadius = radius > item.radius ? radius : item.radius
        let smallRadius = radius <= item.radius ? radius : item.radius
        item.frame.origin = CGPoint(x: bigRadius - smallRadius, y: bigRadius - smallRadius)
        item.radius = itemRadius
        item.alpha = 0
        item.actionButton = self
        items.append(item)
        addSubview(item)
    }
    
    //Добавление вторичной кнопки с определенным названием
    open func addItem(title: String) {
        let item = FloatingActionButtonItem()
        setItemDefaults(item)
        item.title = title
        addItem(item: item)
    }
    
    //Добавление вторичной кнопки с определенными названием и действием при нажатии на кнопку
    open func addItem(title: String, handler: @escaping ((FloatingActionButtonItem) -> Void)) {
        let item = FloatingActionButtonItem()
        setItemDefaults(item)
        item.title = title
        item.handler = handler
        addItem(item: item)
    }
    
    //Добавление вторичной кнопки с опрделенной иконкой
    open func addItem(icon: UIImage?) {
        let item = FloatingActionButtonItem()
        setItemDefaults(item)
        item.icon = icon
        addItem(item: item)
    }
    
    //Добавление вторичной кнопки с определенными иконкой и действием при нажатии на кнопку
    open func addItem(icon: UIImage?, handler: @escaping ((FloatingActionButtonItem) -> Void)) {
        let item = FloatingActionButtonItem()
        setItemDefaults(item)
        item.icon = icon
        item.handler = handler
        addItem(item: item)
    }

    //Добавление вторичной кнопки с определенными названием и икнокой
    open func addItem(_ title: String, icon: UIImage?) {
        let item = FloatingActionButtonItem()
        setItemDefaults(item)
        item.title = title
        item.icon = icon
        addItem(item: item)
    }
    
    //Добавление вторичной кнокпи с определенными названием, иконкой и действием при нажатии на кнопку
    open func addItem(_ title: String, icon: UIImage?, handler: @escaping ((FloatingActionButtonItem) -> Void)) {
        let item = FloatingActionButtonItem()
        setItemDefaults(item)
        item.title = title
        item.icon = icon
        item.handler = handler
        addItem(item: item)
    }
    
    //Удаление вторичной кнопки по индексу
    open func removeItem(index: Int) {
        if index < items.count {
            items[index].removeFromSuperview()
            items.remove(at: index)
        }
    }

    //Функция добаления действия после нажатия на вторичную кнопку
    open func addAction(_ handler: @escaping ((FloatingActionButton) -> Void)){
        self.handler = handler
    }
    
    //Функция, выполняющаяся после нажатия на вью с основной кнопкой
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isTouched(touches) {
            toggle()
        }
    }
    
    //Определение нажатия кнопки
    open func isTouched(_ touches: Set<UITouch>) -> Bool {
        return touches.count == 1 && touches.first?.tapCount == 1 && touches.first?.location(in: self) != nil
    }
    
    //Функция позволяет найти тот сабвью, с которым взаимодействовал пользователь
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isActive {
            for item in items {
                if item.isHidden == true { continue }
                var itemPoint = item.convert(point, from: self)
                let tapArea = determineTapArea(item: item)
                if tapArea.contains(itemPoint) == true {
                    itemPoint = item.bounds.origin
                    return item.hitTest(itemPoint, with: event)
                }
            }
        }
        return super.hitTest(point, with: event)
    }
    
    //Состояние, когда видны затемнение экрана и вторичные кнопки
    internal func activate() {
        self.superview?.insertSubview(blackoutView, aboveSubview: self)
        self.superview?.bringSubview(toFront: self)
        
        setBlackoutView()
        blackoutView.addTarget(self, action: #selector(deactivate), for: UIControlEvents.touchUpInside)
        if hasBlackout {
            blackoutView.alpha = 1
        }
        
        isActive = true
        
        var itemHeight: CGFloat = 0
        for item in items {
            if item.isHidden == true { continue }
            itemHeight += item.radius * 2 + itemSpace
            let bigRadius = radius > item.radius ? radius : item.radius
            let smallRadius = radius <= item.radius ? radius : item.radius
            item.frame.origin.x = bigRadius - smallRadius
            item.frame.origin.y = (-1) * itemHeight
            item.alpha = 1
        }
        if items.count == 0 {
            handler?(self)
            deactivate()
        }
    }
    
    //Состояние, когда на экране только основная кнопка
    internal func deactivate() {
        blackoutView.removeTarget(self, action: #selector(deactivate), for: UIControlEvents.touchUpInside)
        blackoutView.alpha = 0
        
        isActive = false
        
        for item in items.reversed() {
            if item.isHidden == true { continue }
            item.alpha = 0
        }
    }
    
    //Функция делает кнопку активной и неактивной
    fileprivate func toggle() {
        if isActive {
            deactivate()
        } else {
            activate()
        }
    }
    
    //Функция делает кнопку круглой
    fileprivate func setCircleLayer() {
        circleLayer.removeFromSuperlayer()
        circleLayer.frame = CGRect(x: 0, y: 0, width: (radius * 2), height: (radius * 2))
        circleLayer.backgroundColor = color.cgColor
        circleLayer.cornerRadius = radius
        layer.addSublayer(circleLayer)
    }
    
    //Функция добавляет иконку
    fileprivate func setIcon() {
        iconImageView.removeFromSuperview()
        iconImageView = UIImageView(image: icon)
        iconImageView.frame = CGRect(
            x: circleLayer.frame.origin.x + (radius - iconImageView.frame.size.width / 2),
            y: circleLayer.frame.origin.y + (radius - iconImageView.frame.size.height / 2),
            width: iconImageView.frame.size.width,
            height: iconImageView.frame.size.height
        )
        addSubview(iconImageView)
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
    
    //Функция добавляет тень к основной кнопке
    fileprivate func setShadow() {
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
    }
    
    //Кнопка распологается в нижнем правом углу
    fileprivate func setRightBottomFrame() {
        var sizeVariable = UIScreen.main.bounds.size
        
        if superview != nil {
            sizeVariable = superview!.bounds.size
        }
        
        frame = CGRect(
            x: (sizeVariable.width - radius * 2) - paddingX,
            y: (sizeVariable.height - radius * 2) - paddingY,
            width: radius * 2,
            height: radius * 2
        )
    }

    //Вторичной кнопке присваиваются стандартные значения
    fileprivate func setItemDefaults(_ item: FloatingActionButtonItem) {
        item.color = itemColor
        item.titleColor = itemTitleColor
    }
    
    //Вторичные кнопки перерисовываются при измнении размера
    fileprivate func redrawItems() {
        for item in items {
            let bigRadius = radius > item.radius ? radius : item.radius
            let smallRadius = radius <= item.radius ? radius : item.radius
            item.frame.origin = CGPoint(x: bigRadius - smallRadius, y: bigRadius - smallRadius)
        }
    }
    
    //Опрделяется область, которая должна реагировать на взаимодействие пользователя
    fileprivate func determineTapArea(item : FloatingActionButtonItem) -> CGRect {
        let tappableMargin : CGFloat = 30.0
        
        let x = item.titleLabel.frame.origin.x
        let y = item.bounds.origin.y
        
        var width: CGFloat = item.titleLabel.bounds.size.width + item.bounds.size.width + tappableMargin
        if isCustomFrame {
            width = width + paddingX
        }
        
        let height = item.radius * 2
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

