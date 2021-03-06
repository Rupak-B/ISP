
import Foundation
import Scenes
import Igis

class UFO2: RenderableEntity, MouseMoveHandler
{ 
//declare variables
    var ellipse = Ellipse(center:Point(x:0, y:0), radiusX:11, radiusY:21, fillMode:.fillAndStroke)
    var ellipse2 = Ellipse(center:Point(x:0, y:20), radiusX:31, radiusY:10, fillMode:.fillAndStroke)
    let strokeStyle = StrokeStyle(color:Color(.yellow))
    let fillStyle = FillStyle(color:Color(.green))
    let lineWidth = LineWidth(width:5)
    var didRender = false
    var velocityX : Int
    var velocityY : Int
    var defaultVelocityX: Int
    var defaultVelocityY: Int
    var doubleVelocityX: Double
    var doubleVelocityY: Double
    var defaultRadiusX = 51
    var defaultRadiusY = 51
    var tick = 0
    var x = 0
    init()
    {
        self.velocityX = 20
        self.velocityY = 0
        self.defaultVelocityX = 20
        self.defaultVelocityY = 0
        self.doubleVelocityX = 0
        self.doubleVelocityY = 0
        super.init(name:"Ball")
    }

    func changeVelocity(velocityX:Int, velocityY:Int)
    {
        self.velocityX = velocityX
        self.velocityY = velocityY
        self.defaultVelocityX = 20
        self.defaultVelocityY = 0
        self.doubleVelocityX = Double(velocityX)
        self.doubleVelocityY = Double(velocityY)
    }

    override func calculate(canvasSize: Size)
    {
        // First, move to the new position
        ellipse.center += Point(x:velocityX, y:velocityY)
        ellipse2.center += Point(x:velocityX, y:velocityY)
        // Form a bounding rectangle around the canvas
        let canvasBoundingRect = Rect(size:canvasSize)

        // Form a bounding rect around the ball (ellipse)
        let ballBoundingRect = Rect(topLeft:Point(x:ellipse.center.x-ellipse.radiusX, y:ellipse.center.y-ellipse.radiusY), size:Size(width:ellipse.radiusX*1, height:ellipse.radiusY*1))

        // Determine if we've moved outside of the canvas boundary rect
        let tooFarLeft = ballBoundingRect.topLeft.x <= canvasBoundingRect.topLeft.x
        let tooFarRight = ballBoundingRect.topLeft.x + ballBoundingRect.size.width >= canvasBoundingRect.topLeft.x + canvasBoundingRect.size.width

        let tooFarUp = ballBoundingRect.topLeft.y <= canvasBoundingRect.topLeft.y
        let tooFarDown = ballBoundingRect.bottomLeft.y + ballBoundingRect.size.height >= canvasBoundingRect.topLeft.y + canvasBoundingRect.size.height


        if tooFarLeft || tooFarRight{
            velocityX *= 0
            //taking a property of the ellipse object, radiusX, and we're changing it

        }


        if tooFarUp || tooFarDown{
            velocityY = 0

        }
        // enact cosine wave math and or change direction smoothly
        if ellipse.center.x  > 900 {
            velocityX -= Int.random(in: 0..<4)
        }

        else {
            velocityX += Int.random(in: 0..<4)
        }
        if ellipse.center.x  ==  900{
            if tick > 700{
                velocityX = Int.random(in: -1..<1)
                tick = 0
            }
        }

        if ellipse.center.y  > 400 {
            velocityY -= Int.random(in: 0..<2)

        }
        else {
            velocityY += Int.random(in: 0..<2)
        }

    }
    override func setup(canvasSize: Size, canvas: Canvas)
    {
        // Position the ellipse at the center of the canvas
        ellipse.center = canvasSize.center
        ellipse2.center = canvasSize.center
        dispatcher.registerMouseMoveHandler(handler:self)
    }

    override func teardown()
    {
        dispatcher.unregisterMouseMoveHandler(handler:self)
    }
    func onMouseMove(globalLocation: Point, movement: Point)
    {
    }

    override func boundingRect() -> Rect
    {
        return Rect(size: Size(width: Int.max, height: Int.max))
    }
    override func render(canvas:Canvas)
    {
        changeVelocity(velocityX:velocityX, velocityY:velocityY)


        didRender = false

        if let canvasSize = canvas.canvasSize,  didRender == false
        {
            canvas.render(strokeStyle, fillStyle, lineWidth, ellipse, ellipse2)

        }
        didRender = true
        x+=1
        tick+=1

    }
}
 
