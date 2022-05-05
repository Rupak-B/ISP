
import Scenes
import Igis

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class InteractionLayer : Layer, KeyDownHandler, KeyUpHandler {

    let projectileExample : Projectile
    let ufo = UFO()
    let ufo3 = UFO()
    let ufo4 = UFO()
    let ufo5 = UFO()
    let alien = Alien()
    let ufo2 = UFO2()
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

        ufo.setInteractionLayer(layer:self)
        ufo3.setInteractionLayer(layer:self)

        // We insert our RenderableEntities in the constructor
        insert(entity: background, at:.back)
        insert(entity: moon, at: .front)
        insert(entity: ufo5, at: .front)
        insert(entity: ufo3, at: .front)
        insert(entity: ufo4, at: .front)
        insert(entity: ufo, at: .front) 
        insert(entity: alien, at: .front)
        alien.changeVelocity(velocityX: 26, velocityY: 12)
        ufo.changeVelocity(velocityX: 26, velocityY: 12)
        ufo3.changeVelocity(velocityX: 26, velocityY: 12)
        ufo4.changeVelocity(velocityX: 36, velocityY: 12)
        ufo5.changeVelocity(velocityX: 16, velocityY: 2)
        insert(entity: projectileExample, at: .front)
        insert(entity: ufo2, at: .front)
        ufo2.changeVelocity(velocityX: -20, velocityY: 12)

        ball.changeVelocity(velocityX: 15, velocityY: 10)

        insert(entity: ball, at: .front)

        insert(entity: paddleLeft, at: .front)
        insert(entity: paddleRight, at: .front)
    }
func renderprojectileExample(projectileExample:Projectile) {
        insert(entity:projectileExample, at:.front)
    }
   
    func removeEntity(entity: RenderableEntity) {
        remove(entity: entity)
    }

    override func preSetup(canvasSize: Size, canvas: Canvas)
    {
        paddleLeft.move(to:Point(x: 20, y: 480))
        paddleRight.move(to:Point(x: 1875, y: 480))
          //        projectileExample.move(to:Point(x: 500, y:200))
        dispatcher.registerKeyDownHandler(handler: self)
        dispatcher.registerKeyUpHandler(handler: self)

    }

    var keysDown = [String]()

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool)
    {
        let tlpl = paddleLeft.rectangle.rect.topLeft
        let tlpr = paddleRight.rectangle.rect.topLeft

        if !keysDown.contains(key) {
            keysDown.append(key)
        }

        for k in keysDown {        
            switch k
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

    }

    func onKeyUp(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        if keysDown.contains(key) {
            keysDown = keysDown.filter { $0 != key }
        }
    }

    override func postTeardown()
    {
        tick += 1
    //    print(tick)
        dispatcher.unregisterKeyDownHandler(handler: self)
        dispatcher.unregisterKeyUpHandler(handler: self)
    }
    
}
   
