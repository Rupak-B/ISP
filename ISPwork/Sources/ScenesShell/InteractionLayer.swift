import Scenes
import Igis

  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class InteractionLayer : Layer, KeyDownHandler {

    let projectileExample : Projectile
    let ufo = UFO()
    let ufo2 = UFO()
    var tick = 0 
    let moon = Moon()
    let ball = Ball()
    let background = Background()

    let paddleLeft = Paddle(rect:Rect(size:Size(width:10, height:150)))
    let paddleRight = Paddle(rect:Rect(size:Size(width:10, height:150)))
    
    init() {
        self.projectileExample = Projectile(velocityY : 3, rectangle: Rectangle(rect:Rect(topLeft: Point(), size:Size(width: 4, height: 30)), fillMode: .fill))
        
      // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")
        
        // We insert our RenderableEntities in the constructor
        insert(entity: background, at:.back)
        insert(entity: moon, at: .back)
        insert(entity: ufo, at: .front)
        ufo.changeVelocity(velocityX: 26, velocityY: 12)
        insert(entity: projectileExample, at: .front)
        insert(entity: ufo2, at: .front)
        ufo2.changeVelocity(velocityX: -20, velocityY: 12)

        ball.changeVelocity(velocityX: 8, velocityY: 8)

        insert(entity: ball, at: .front)

        insert(entity: paddleLeft, at: .front)
        insert(entity: paddleRight, at: .front)
    }

    func removeEntity(entity: RenderableEntity) {
        remove(entity: entity)
    }
 
    override func preSetup(canvasSize: Size, canvas: Canvas)
    {
        paddleLeft.move(to:Point(x: 20, y: 480))
        paddleRight.move(to:Point(x: 1875, y: 480))
        projectileExample.move(to:Point(x: 500, y:200))
        dispatcher.registerKeyDownHandler(handler: self)

    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool)
    {
        let tlpl = paddleLeft.rectangle.rect.topLeft
        let tlpr = paddleRight.rectangle.rect.topLeft
        switch key
        {
        case "w":
            paddleLeft.move(to:Point(x: tlpl.x, y:tlpl.y - 25))
        case "s":
            paddleLeft.move(to:Point(x: tlpl.x, y:tlpl.y + 25))
        case "ArrowUp":
            paddleRight.move(to:Point(x: tlpr.x, y:tlpr.y - 25))
        case "ArrowDown":
            paddleRight.move(to:Point(x: tlpr.x, y:tlpr.y + 25))
        default:
            break
        }

    }

    override func postTeardown()
    {
        tick += 1
        print(tick)
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
    
}
