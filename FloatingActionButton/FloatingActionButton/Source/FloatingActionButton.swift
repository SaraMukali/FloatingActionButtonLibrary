//
//  FloatingActionButton.swift
//  FloatingActionButton
//
//  Created by Sara Mukali on 10.01.17.
//  Copyright © 2017 Sara. All rights reserved.
//

import UIKit

//Перечисление видов горизнотольного расположения
public enum HorizontalPosition {
    case left
    case right
    case center
    case none
}

//Перечисление видов скрытия кнопки
public enum HiddenType {
    case alpha
    case move
    case none
}

open class FloatingActionButton: UIView {
    
    //Радиус основной кнопки
    open var radius: CGFloat = Constants.radius {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //Цвет фона основной кнопки
    open var color: UIColor = Constants.color {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //Иконка основной кнопки
    open var icon: UIImage? = Constants.icon {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //Расстояние от нижнего правого угла по горизонтали
    open var paddingX: CGFloat = Constants.paddingX {
        didSet {
            if let position = definedHorizontalPosition() {
                paddingX = position
            }
        }
    }
    
    //Горизонтальное расположение
    open var horizontalPosition: HorizontalPosition = .none {
        didSet {
            if let position = definedHorizontalPosition() {
                paddingX = position
            }
        }
    }
    
    //Расстояние от нижнего правого угла по вертикали
    open var paddingY: CGFloat = Constants.paddingY
    
    //Наличие тени основной кнопки
    open var hasShadow: Bool = Constants.hasShadow
    
    //Наличие затемнения при нажатии на основную кнопку
    open var hasBlackout: Bool = Constants.hasBlackout
    
    //Цвет затемнения
    open var blackoutColor: UIColor = Constants.blackoutColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //Прозрачность затемнения
    open var blackoutOpacity: CGFloat = Constants.blackoutOpacity
    
    //Длительность затменения
    open var blackoutAnimationDuration: Double = Constants.blackoutAnimationDuration
    
    //Цвет изменения кнопки при долгом нажатии
    open var tappedButtonChangedColor: UIColor? = Constants.tappedButtonChangedColor
    
    //Активность кнопки
    open var isActive: Bool = Constants.isActive
    
    //Переопределение свойства isHidden
    open override var isHidden: Bool {
        get {
            return super.isHidden
        }
        set(bool) {
            canBeHidden = bool
            if !bool {
                super.isHidden = bool
            }
            makeHiddenOrVisible(isHidden: bool, completion: { (Bool) in
                super.isHidden = bool
            })
        }
    }
    
    //Вид скрытия кнопки
    open var hiddenType: HiddenType = .none
    
    //Длительность исчезновения кнопки
    open var hiddenAnimationDuration: Double = Constants.hiddenAnimationDuration
    
    //Массив из вторичных кнопок
    open var items: [FloatingActionButtonItem] = []
    
    //Радиус вторичной кнопки
    open var itemRadius: CGFloat = Constants.radius {
        didSet {
            for item in items {
                item.radius = itemRadius
            }
        }
    }
    
    //Расстояние между вторичными кнопками
    open var itemSpace: CGFloat = Constants.itemSpace
    
    //Цвет вторичной кнопки
    open var itemColor: UIColor = Constants.itemColor
    
    //Цвет названия кнопки
    open var itemTitleColor: UIColor = Constants.titleColor
    
    //Нестандартные размер и распложение кнопки
    fileprivate var isCustomFrame: Bool = Constants.isCustomFrame
    
    //Слой, позволяющий делать кнопку круглой
    fileprivate var circleLayer: CAShapeLayer = CAShapeLayer()
    
    //Слой, меняющий цвет кнопки во время нажатия
    fileprivate var tappedButtonColorChangeLayer: CAShapeLayer = CAShapeLayer()
        
    //Вью, на которой расположена иконка
    fileprivate var iconImageView: UIImageView = UIImageView()
    
    //Вью, которая затемняется
    fileprivate var blackoutView : UIControl = UIControl()
    
    //Функция, выполняющаяся при нажатии на основную кнопку, если нет вторичных
    fileprivate var handler: ((FloatingActionButton) -> Void)? = nil
    
    //Размер вью, на котором расположена кнопка
    fileprivate var superviewSize: CGSize?
    
    //Значения основных параметров кнопки определены
    fileprivate var isDrawn = Constants.isDrawn
    
    //Способность кнопки скрываться
    fileprivate var canBeHidden = Constants.canBeHidden
    
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
        isDrawn = true
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        setRightBottomFrame()
        
        setAdditionalProperties()
        
        if canBeHidden {
            makeHiddenOrVisible(isHidden: true, completion: { (Bool) in
                super.isHidden = true
            })
            canBeHidden = false
        }
    }

    //Функция добавляет вторичную кнопку в массив
    open func addItem(item: FloatingActionButtonItem) {
        let itemHeight = CGFloat(items.count) * (item.radius * 2 + itemSpace)
        item.frame.origin = CGPoint(x: radius - item.radius, y: -itemHeight)
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
    
    //Функция, выполняющаяся после первого прикосновения ко вью с основной кнопкой
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTouched(touches) {
            addColorChange()
        }
    }
    //Функция, выполняющаяся после последнего прикосновения ко вью с основной кнопкой
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        tappedButtonColorChangeLayer.removeFromSuperlayer()
        if isTouched(touches) || tappedButtonColorChangeLayer.opacity == 1 {
            toggle()
        }
    }
    
    //Определение нажатия кнопки
    fileprivate func isTouched(_ touches: Set<UITouch>) -> Bool {
        if let touch = touches.first {
            return touches.count == 1 && touch.tapCount == 1
        }
        return touches.count == 1
    }
    
    //Функция позволяет найти тот сабвью, с которым взаимодействовал пользователь
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isActive {
            for item in items {
                if item.isHidden {
                    continue
                }
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
    func activate() {
        if let selfSuperview = superview {
            selfSuperview.insertSubview(blackoutView, aboveSubview: self)
            selfSuperview.bringSubview(toFront: self)
        }
        
        blackoutView.addTarget(self, action: #selector(deactivate), for: UIControlEvents.touchUpInside)
        if hasBlackout {
            UIView.animate(withDuration: blackoutAnimationDuration, animations: {
                self.blackoutView.alpha = self.blackoutOpacity
            })
        }
        
        isActive = true

        var itemHeight: CGFloat = 0
        var delay = 0.0
        for item in items {
            if item.isHidden == true { continue }
            itemHeight += item.radius * 2 + itemSpace
            let a = radius - item.radius
            
            item.layer.transform = CATransform3DMakeScale(0.4, 0.4, 10)
            UIView.animate(withDuration: (0.7 - delay), delay: delay,
                           usingSpringWithDamping: 0.55,
                           initialSpringVelocity: 0.3,
                           options: UIViewAnimationOptions(), animations: { () -> Void in
                            item.layer.transform = CATransform3DIdentity
                            item.alpha = 1
                            item.frame.origin.x = a
                            item.frame.origin.y = -itemHeight
            }, completion: nil)
            
            delay += 0.1
        }
        if items.count == 0 {
            if let handler = handler {
                handler(self)
            }
            deactivate()
        }
    }
    
    //Состояние, когда на экране только основная кнопка
    func deactivate() {
        blackoutView.removeTarget(self, action: #selector(deactivate), for: UIControlEvents.touchUpInside)
        blackoutView.alpha = 0

        isActive = false
        
        var delay = 0.0
        for item in items.reversed() {
            if item.isHidden {
                continue
            }
            UIView.animate(withDuration: 0.3, delay: delay, options: [], animations: { () -> Void in
                item.layer.transform = CATransform3DMakeScale(0.4, 0.4, 10)
                item.alpha = 0
                
            }, completion: nil)
            delay += 0.1
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
    
    //Функция ставит основную кнопку в правом нижнем углу
    fileprivate func setRightBottomFrame() {
        let sizeVariable = superviewSize ?? UIScreen.main.bounds.size
        var titlePosition: TitlePosition = .left
        
        if horizontalPosition == .left {
            titlePosition = .right
        }
        
        items.forEach { item in
            item.titlePosition = titlePosition
        }
        
        if let position = definedHorizontalPosition() {
            paddingX = position
        }
        
        frame = CGRect(
            x: (sizeVariable.width - radius * 2) - paddingX,
            y: (sizeVariable.height - radius * 2) - paddingY,
            width: radius * 2,
            height: radius * 2
        )
    }
    
    //Функция добавляет дополнительные свойства кнопки
    fileprivate func setAdditionalProperties() {
        setCircleLayer()
        
        if icon != nil {
            setIcon()
        }
        
        if hasShadow {
            setShadow()
        }
        
        setBlackoutView()
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
    
    //Функция добавляет тень к основной кнопке
    fileprivate func setShadow() {
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
    }
    
    //Функция создет вью для затемнения
    fileprivate func setBlackoutView() {
        blackoutView.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        blackoutView.backgroundColor = blackoutColor
        blackoutView.alpha = 0
        blackoutView.isUserInteractionEnabled = true
    }
    
    //Функция меняет цвет кнопки
    fileprivate func addColorChange() {

        tappedButtonColorChangeLayer.frame = CGRect(x: circleLayer.frame.origin.x, y: circleLayer.frame.origin.y, width: radius * 2, height: radius * 2)
        
        var components =  [CGFloat]()
        
        if let colorComponents = color.cgColor.components {
            colorComponents.forEach { component in
                if component * 255.0 >= Constants.tappedButtonColorChangeDifference {
                    components.append((component * 255.0 - Constants.tappedButtonColorChangeDifference)/255.0)
                } else {
                    components.append((component * 255.0 + Constants.tappedButtonColorChangeDifference)/255.0)
                }
            }
        }
        tappedButtonColorChangeLayer.cornerRadius = radius
        
        if let color = tappedButtonChangedColor {
            tappedButtonColorChangeLayer.backgroundColor = color.cgColor
        } else {
            if components.count < 4 {
                tappedButtonColorChangeLayer.backgroundColor = UIColor(white: components[0], alpha: 1.0).cgColor
            } else {
                tappedButtonColorChangeLayer.backgroundColor = UIColor(red: components[0], green: components[1], blue: components[2], alpha: 1.0).cgColor
            }
        }
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        
        tappedButtonColorChangeLayer.add(animation, forKey: "opacity")
        layer.addSublayer(tappedButtonColorChangeLayer)
        setIcon()
    }

    //Расстояние от правого нижнего угла меняется в зависимости от выбранного расположения
    fileprivate func definedHorizontalPosition() -> CGFloat? {
        if let superviewSize = superviewSize {
            let superviewWidth = superviewSize.width
            switch horizontalPosition {
            case .right:
                return superviewWidth/4 - radius
            case .center:
                return superviewWidth/2 - radius
            case .left:
                return 3 * superviewWidth/4 - radius
            case .none: break
            }
        }
        return nil
    }
    //Вторичной кнопке присваиваются стандартные значения
    fileprivate func setItemDefaults(_ item: FloatingActionButtonItem) {
        item.color = itemColor
        item.titleColor = itemTitleColor
    }
    
    //Опрделяется область, которая должна реагировать на взаимодействие пользователя
    fileprivate func determineTapArea(item : FloatingActionButtonItem) -> CGRect {
        let tappableMargin : CGFloat = 30.0
        var x = item.titleLabel.frame.origin.x
        if item.titlePosition == .right {
            x = item.frame.origin.x
        }
        let y = item.bounds.origin.y
        
        var width: CGFloat = item.titleLabel.bounds.size.width + item.bounds.size.width + tappableMargin
        if isCustomFrame {
            width = width + paddingX
        }
        
        let height = item.radius * 2
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    //Функция вызывается после добавления на вью, на котором будет расположена кнопка
    open override func didMoveToSuperview() {
        if let superview = superview {
            superviewSize = superview.bounds.size
        }
    }
    
    //Функция выбирает метод скрытия и возвращения кнопки
    fileprivate func makeHiddenOrVisible(isHidden: Bool, completion: ((Bool) -> Swift.Void)? = nil ) {
        if isDrawn {
            switch hiddenType {
            case .alpha:
                changeVisibility(isVisible: !isHidden, completion: completion)
            case .move:
                changePosition(isMoved: isHidden, completion: completion)
            case .none:
                if let completion = completion {
                    completion(isHidden)
                }
            }
        }
    }
    
    //Функция анимированно меняет прозрачность кнопки
    fileprivate func changeVisibility(isVisible: Bool, completion: ((Bool) -> Swift.Void)? = nil) {
        UIView.animate(withDuration: hiddenAnimationDuration, animations: {
            self.alpha = isVisible ? 1 : 0
        }) { (Bool) in
            if let completion = completion {
                completion(Bool)
            }
        }
    }
    
    //Функция двигает кнопку из основного вью вниз или обратно вверх
    fileprivate func changePosition(isMoved: Bool, completion: ((Bool) -> Swift.Void)? = nil){
        UIView.animate(withDuration: hiddenAnimationDuration, animations: {
            if let size = self.superviewSize {
                self.frame.origin.y = isMoved ? (size.height + Constants.shadowRadius) : (size.height - self.radius * 2  - Constants.shadowRadius - self.paddingY)
            }
        }) { (Bool) in
            if let completion = completion {
                completion(Bool)
            }
        }
    }
}

