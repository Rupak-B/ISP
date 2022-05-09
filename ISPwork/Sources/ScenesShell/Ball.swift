import Foundation
import Scenes
import Igis

class Ball: RenderableEntity, MouseMoveHandler, KeyDownHandler, KeyUpHandler {
    var ellipse = Ellipse(center:Point(x:0, y:0), radiusX:26, radiusY:26, fillMode:.fillAndStroke)
    let strokeStyle = StrokeStyle(color:Color(.orange))
    let fillStyle = FillStyle(color:Color(.red))
    let lineWidth = LineWidth(width:5)
    var didRender = false

    var velocityX : Int
    var velocityY : Int
    var defaultVelocityX: Int
    var defaultVelocityY: Int
    var doubleVelocityX: Double
    var doubleVelocityY: Double
    var defaultRadiusX = 26
    var defaultRadiusY = 26

    var time = 1
    let maxPattern = 11
    var leftScore = 1
    var rightScore = 1
    var rect: Rect?

    static let paddleLeft = Paddle(rect:Rect(size:Size(width:10, height:100)))
    static let paddleRight = Paddle(rect:Rect(size:Size(width:10, height:100)))

    var tick = 0

    var stoop = false
    
    init()
    {
        self.velocityX = 15
        self.velocityY = 10
        self.defaultVelocityX = 15
        self.defaultVelocityY = 10
        self.doubleVelocityX = 0
        self.doubleVelocityY = 0
        

        // Using a meaningful name can be helpful for debugging
        super.init(name:"Ball")
    }

    func colon(canvas:Canvas) {
        let text = Text(location:Point(x:1000, y:55), text:":")
        text.font = "50pt Arial"
        canvas.render(FillStyle(color:Color(.red)))
        canvas.render(text)
    }
    func leftWin(canvas:Canvas) {
        let text = Text(location:Point(x:50, y:450), text:"LEFT PLAYER WINS")
        text.font = "130pt Arial"
        canvas.render(FillStyle(color:Color(.red)))
        canvas.render(text)
    }
    func rightWin(canvas:Canvas) {
        let text = Text(location:Point(x:50, y:450), text:"RIGHT PLAYER WINS")
        text.font = "130pt Arial"
        canvas.render(FillStyle(color:Color(.red)))
        canvas.render(text)
    }
    func renderLabel(canvas:Canvas, patternId:Int) {
        let text = Text(location:Point(x:950, y:55), text:"\(patternId)")
        text.font = "50pt Arial"
        canvas.render(FillStyle(color:Color(.red)))
        canvas.render(text)
    }
    func renderLabelR(canvas:Canvas, patternIdR:Int) {
        let text = Text(location:Point(x:1035, y:55), text:"\(patternIdR)")
        text.font = "50pt Arial"
        canvas.render(FillStyle(color:Color(.red)))
        canvas.render(text)
    }
    func renderPattern0(canvas:Canvas) {
        renderLabel(canvas:canvas, patternId:0)
    }
    func renderPattern1(canvas:Canvas) {
        renderLabel(canvas:canvas, patternId:1)
    }
    func renderPattern2(canvas:Canvas) {
        renderLabel(canvas:canvas, patternId:2)
    }
    func renderPattern3(canvas:Canvas) {
        renderLabel(canvas:canvas, patternId:3)
    }
    func renderPattern4(canvas:Canvas) {
        renderLabel(canvas:canvas, patternId:4)
    }
    func renderPattern5(canvas:Canvas) {
        renderLabel(canvas:canvas, patternId:5)
    }
    func renderPattern6(canvas:Canvas) {
        renderLabel(canvas:canvas, patternId:6)
    }
    func renderPattern7(canvas:Canvas) {
        renderLabel(canvas:canvas, patternId:7)
    }
    func renderPattern8(canvas:Canvas) {
        renderLabel(canvas:canvas, patternId:8)
    }
    func renderPattern9(canvas:Canvas) {
        renderLabel(canvas:canvas, patternId:9)
    }

    func renderPattern0R(canvas:Canvas) {
        renderLabelR(canvas:canvas, patternIdR:0)
    } 
    func renderPattern1R(canvas:Canvas) {
        renderLabelR(canvas:canvas, patternIdR:1)
    }
    func renderPattern2R(canvas:Canvas) {
        renderLabelR(canvas:canvas, patternIdR:2)
    }
    func renderPattern3R(canvas:Canvas) {
        renderLabelR(canvas:canvas, patternIdR:3)
    }
    func renderPattern4R(canvas:Canvas) {
        renderLabelR(canvas:canvas, patternIdR:4)
    }
    func renderPattern5R(canvas:Canvas) {
        renderLabelR(canvas:canvas, patternIdR:5)
    }
    func renderPattern6R(canvas:Canvas) {
        renderLabelR(canvas:canvas, patternIdR:6)
    }
    func renderPattern7R(canvas:Canvas) {
        renderLabelR(canvas:canvas, patternIdR:7)
    }
    func renderPattern8R(canvas:Canvas) {
        renderLabelR(canvas:canvas, patternIdR:8)
    }
    func renderPattern9R(canvas:Canvas) {
        renderLabelR(canvas:canvas, patternIdR:9)
    }
    func changeVelocity(velocityX:Int, velocityY:Int)
    {
        self.velocityX = velocityX
        self.velocityY = velocityY
        self.defaultVelocityX = 15
        self.defaultVelocityY = 10
        self.doubleVelocityX = Double(velocityX)
        self.doubleVelocityY = Double(velocityY)
    }
    override func calculate(canvasSize: Size)
    {
        // First, move to the new position

        ellipse.center += Point(x:velocityX/2, y:velocityY/2)
        
        
        // Form a bounding rectangle around the canvas
        let canvasBoundingRect = Rect(size:canvasSize)

        let paddleLeftBoundingRect = Ball.paddleLeft.rectangle.rect
        let paddleRightBoundingRect = Ball.paddleRight.rectangle.rect
        // Form a bounding rect around the ball (ellipse)
        let ballBoundingRect = Rect(topLeft:Point(x:ellipse.center.x-ellipse.radiusX, y:ellipse.center.y-ellipse.radiusY), size:Size(width:ellipse.radiusX*2, height:ellipse.radiusY*2))

        // Determine if we've moved outside of the canvas boundary rect
        let tooFarLeft = ballBoundingRect.topLeft.x <= canvasBoundingRect.topLeft.x
        let tooFarRight = ballBoundingRect.topLeft.x + ballBoundingRect.size.width >= canvasBoundingRect.topLeft.x + canvasBoundingRect.size.width

        let tooFarUp = ballBoundingRect.topLeft.y <= canvasBoundingRect.topLeft.y
        let tooFarDown = ballBoundingRect.bottomLeft.y + ballBoundingRect.size.height >= canvasBoundingRect.topLeft.y + canvasBoundingRect.size.height

//        let contactpaddleLeft = ((ballBoundingRect.topLeft.x <= paddleLeftBoundingRect.topRight.x+75) && ((ballBoundingRect.topLeft.y <= paddleLeftBoundingRect.bottomRight.y) && (ballBoundingRect.topLeft.y >= paddleLeftBoundingRect.topRight.y))) || ((ballBoundingRect.topLeft.x <= paddleLeftBoundingRect.topRight.x) && ((ballBoundingRect.bottomLeft.y >= paddleLeftBoundingRect.topRight.y) && (ballBoundingRect.bottomLeft.y <= paddleLeftBoundingRect.bottomRight.y)))
//        let contactpaddleLeft = ((ballBoundingRect.topLeft.x <= paddleLeftBoundingRect.topRight.x) && ((ballBoundingRect.topLeft.y <= paddleLeftBoundingRect.bottomRight.y) && (ballBoundingRect.topLeft.y >= paddleLeftBoundingRect.topRight.y))) || ((ballBoundingRect.topLeft.x <= paddleLeftBoundingRect.topRight.x) && ((ballBoundingRect.bottomLeft.y >= paddleLeftBoundingRect.topRight.y) && (ballBoundingRect.bottomLeft.y <= paddleLeftBoundingRect.bottomRight.y)))

       // let contactpaddleRight = ((ballBoundingRect.topLeft.x >= paddleRightBoundingRect.topLeft.x) && ((ballBoundingRect.topLeft.y <= paddleRightBoundingRect.bottomLeft.y) && (ballBoundingRect.topLeft.y >= paddleRightBoundingRect.topLeft.y))) || ((ballBoundingRect.topLeft.x >= paddleRightBoundingRect.topLeft.x) && ((ballBoundingRect.bottomLeft.y >= paddleRightBoundingRect.topLeft.y) && (ballBoundingRect.bottomLeft.y <= paddleRightBoundingRect.bottomLeft.y)))

        let contactpaddleLeft = (ballBoundingRect.topLeft.x <= paddleLeftBoundingRect.topRight.x-25) && ((paddleLeftBoundingRect.topLeft.y-55 < ballBoundingRect.topLeft.y) && (paddleLeftBoundingRect.bottomLeft.y+55 > ballBoundingRect.bottomLeft.y))
        let contactpaddleRight = (ballBoundingRect.topLeft.x >= paddleRightBoundingRect.topRight.x-45) && ((paddleRightBoundingRect.topLeft.y-55 < ballBoundingRect.topLeft.y) && (paddleRightBoundingRect.bottomLeft.y+55 > ballBoundingRect.bottomLeft.y))
        
//        print(paddleLeftBoundingRect.topLeft.y)
        
        if contactpaddleRight {
            if velocityX >= 0 {
                print("contactpaddleRight")
                velocityX *= -3
                velocityY *= 3
                ellipse.radiusX = ellipse.radiusX/2
            }
        }
        if contactpaddleLeft {
            if velocityX <= 0 {
                print("contactpaddleLeft")
                velocityX *= -3
                velocityY *= 3
                ellipse.radiusX = ellipse.radiusX/2
            }
        }
        if tooFarRight{
            leftScore += 1
            if (leftScore > maxPattern) {
                rightScore = 1
            }
            didRender = false
            velocityX *= -2
            velocityY *= 2
            //taking a property of the ellipse object, radiusX, and we're changing it
            ellipse.radiusX = ellipse.radiusX/2
        }
        if tooFarLeft {
            rightScore += 1
            if (rightScore > maxPattern) {
                rightScore = 1
            }
            didRender = false
            velocityX *= -2
            velocityY *= 2
            //taking a property of the ellipse object, radiusX, and we're changing it
            ellipse.radiusX = ellipse.radiusX/2
        }
        if tooFarUp || tooFarDown{
            velocityY *= -2
            velocityX *= 2
            ellipse.radiusY = ellipse.radiusY/2
        }
        if abs(velocityY) >= 30
        {
            velocityY /= abs(velocityY)
            velocityY *= 30
        }
        if abs(velocityX) >= 45
        {
            velocityX /= abs(velocityX)
            velocityX *= 45
        } 
        func slowDown(velocity: inout Int, defaultVelocity: Int, doubleVelocity: inout Double){
            doubleVelocity = Double(velocity)
            if abs(velocity) > defaultVelocity{
                var change = -0.1
                if doubleVelocity.sign == .minus{
                    change = 0.1
                }
                doubleVelocity += change
                velocity = Int(doubleVelocity)
            }
            else if abs(velocity) < defaultVelocity{
                //doubleVelocity = Double(defaultVelocity)
                velocity = defaultVelocity
            }
        }
        func growRadius(radius: inout Int, defaultRadius: Int){
            if radius < defaultRadius{
                var change = 1
                if Double(radius).sign == .minus{
                    change = -1
                }
                radius += change
            }
            else if abs(radius) > defaultRadius{
                radius = defaultRadius
            }
        }
        slowDown(velocity: &velocityX, defaultVelocity:defaultVelocityX, doubleVelocity: &doubleVelocityX)
        slowDown(velocity: &velocityY, defaultVelocity:defaultVelocityY, doubleVelocity: &doubleVelocityY)
        growRadius(radius: &ellipse.radiusX, defaultRadius:defaultRadiusX)
        growRadius(radius: &ellipse.radiusY, defaultRadius:defaultRadiusY)
    }

    

   override func setup(canvasSize: Size, canvas: Canvas)
    {
//        canvas.setup(mm)
        // Position the ellipse at the center of the canvas
        ellipse.center = canvasSize.center
        rect = Rect(size: canvasSize)
//        Ball.paddleLeft.move(to:Point(x: 50, y: 480))
       // Ball.paddleRight.move(to:Point(x: 1850, y: 480))

        dispatcher.registerMouseMoveHandler(handler:self)
        dispatcher.registerKeyDownHandler(handler: self)
        dispatcher.registerKeyUpHandler(handler: self)
    }
    var keypDown = [String]()

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool)
    {
        print(keypDown)
        let tlpl = Ball.paddleLeft.rectangle.rect.topLeft
        let tlpr = Ball.paddleRight.rectangle.rect.topLeft

        if !keypDown.contains(key) {
            keypDown.append(key)
            
        }

        for k in keypDown {        
            switch k
            {
            case "w":
tick += 1
           //     Ball.paddleLeft.move(to:Point(x: tlpl.x, y:tlpl.y - 25))
            case "s":
tick += 1
         //       Ball.paddleLeft.move(to:Point(x: tlpl.x, y:tlpl.y + 25))
            case "ArrowUp":
tick += 1
         //       Ball.paddleRight.move(to:Point(x: tlpr.x, y:tlpr.y - 25))
            case "ArrowDown":
tick += 1
           //     Ball.paddleRight.move(to:Point(x: tlpr.x, y:tlpr.y + 25))
            default:
                break
            }
        }

    }

   func onKeyUp(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {

      if keypDown.contains(key) {
            keypDown = keypDown.filter { $0 != key }
        }
    }


    override func teardown()
    {
        dispatcher.unregisterKeyDownHandler(handler: self)
        dispatcher.unregisterMouseMoveHandler(handler:self)
    }

    func onMouseMove(globalLocation: Point, movement: Point)
    {
        //        print(tick)
        //changeVelocity(velocityX:velocityX, velocityY:velocityY)
        //      tick += 1
        //ellipse.center = globalLocation
        //didRender = false
    }

    override func boundingRect() -> Rect
    {
        if let rect = rect {
            return rect
        } else {
            return Rect()
        }
    }
    override func render(canvas:Canvas)
    {
        if stoop == false
        {
            changeVelocity(velocityX:velocityX, velocityY:velocityY)
        }
        tick += 1
        //print(tick)
time += 1
        didRender = false
        if let canvasSize = canvas.canvasSize,  didRender == false
        {
            // Clear the entire canvas
//            let clearRect = Rect(topLeft:Point(x:0, y:0), size:canvasSize)
  //          let clearRectangle = Rectangle(rect:clearRect, fillMode:.clear)
    //        canvas.render(clearRectangle)
            colon(canvas:canvas)
            switch (leftScore) {
            case 1:
                renderPattern0(canvas:canvas)
            case 2:
                renderPattern1(canvas:canvas)
            case 3:
                renderPattern2(canvas:canvas)
            case 4:
                renderPattern3(canvas:canvas)
            case 5:
                renderPattern4(canvas:canvas)
            case 6:
                renderPattern5(canvas:canvas)
            case 7:
                renderPattern6(canvas:canvas)
            case 8:
                renderPattern7(canvas:canvas)
            case 9:
                renderPattern8(canvas:canvas)
            case 10:
                renderPattern9(canvas:canvas)
            case 11:
                //break
                //tick = 0
                stoop = true
                changeVelocity(velocityX:0, velocityY:0)
                let clearRect = Rect(topLeft:Point(x:0, y:0), size:canvasSize)
                let clearRectangle = Rectangle(rect:clearRect, fillMode:.clear)
                canvas.render(clearRectangle)
                leftWin(canvas:canvas)
            default:
                fatalError("Unexpected pattern: \(leftScore)")
            }

            switch (rightScore) {
            case 1:
                renderPattern0R(canvas:canvas)
            case 2:
                renderPattern1R(canvas:canvas)
            case 3:
                renderPattern2R(canvas:canvas)
            case 4:
                renderPattern3R(canvas:canvas)
            case 5:
                renderPattern4R(canvas:canvas)
            case 6:
                renderPattern5R(canvas:canvas)
            case 7:
                renderPattern6R(canvas:canvas)
            case 8:
                renderPattern7R(canvas:canvas)
            case 9:
                renderPattern8R(canvas:canvas)
            case 10:
                renderPattern9R(canvas:canvas)
            case 11:
                //break
                //tick = 0
                stoop = true
                changeVelocity(velocityX:0, velocityY:0)
//                let clearRect = Rect(topLeft:Point(x:0, y:0), size:canvasSize)
  //              let clearRectangle = Rectangle(rect:clearRect, fillMode:.clear)
    //            canvas.render(clearRectangle)
                rightWin(canvas:canvas)
                self.velocityX = 10000000000000
            default:
                fatalError("Unexpected pattern: \(rightScore)")
            }
            
            canvas.render(strokeStyle, fillStyle, lineWidth, ellipse)
        }
        didRender = true
    }
}
