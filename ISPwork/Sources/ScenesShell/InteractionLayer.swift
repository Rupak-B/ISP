
import Scenes
import Igis

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class InteractionLayer : Layer, KeyDownHandler, KeyUpHandler {

    let projectileExample : Projectile
    static let ufo = UFO()
    static let ufo5 = UFO()
    static let ufo4 = UFO()
    static let ufo3 = UFO()
    static let alien = Alien()
    static let ufo2 = UFO2()
    var tick = 0
    let moon = Moon()
    static let ball = Ball()
    let background = Background()

    static let paddleLeft = Paddle(rect:Rect(size:Size(width:10, height:150)))
    static let paddleRight = Paddle(rect:Rect(size:Size(width:10, height:150)))

    init() {
        self.projectileExample = Projectile(velocityY : 3, rectangle: Rectangle(rect:Rect(topLeft: Point(), size:Size(width: 4, height: 30)), fillMode: .fill))

        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        InteractionLayer.ufo.setInteractionLayer(layer:self)
        InteractionLayer.ufo3.setInteractionLayer(layer:self)
        InteractionLayer.ufo4.setInteractionLayer(layer:self)
        InteractionLayer.ufo5.setInteractionLayer(layer:self) 
        // We insert our RenderableEntities in the constructor
        insert(entity: background, at:.back)
        insert(entity: moon, at: .front)
        insert(entity:  InteractionLayer.ufo5, at: .front)
        insert(entity:  InteractionLayer.ufo3, at: .front)
        insert(entity:  InteractionLayer.ufo4, at: .front)
        insert(entity:  InteractionLayer.ufo, at: .front) 
        insert(entity:  InteractionLayer.alien, at: .front)
        InteractionLayer.alien.changeVelocity(velocityX: 26, velocityY: 12)
        InteractionLayer.ufo.changeVelocity(velocityX: 26, velocityY: 12)
        InteractionLayer.ufo3.changeVelocity(velocityX: 26, velocityY: 12)
        InteractionLayer.ufo4.changeVelocity(velocityX: 36, velocityY: 12)
        InteractionLayer.ufo5.changeVelocity(velocityX: 16, velocityY: 2)
        insert(entity: projectileExample, at: .front)
        insert(entity:  InteractionLayer.ufo2, at: .front)
        InteractionLayer.ufo2.changeVelocity(velocityX: -20, velocityY: 12)

        InteractionLayer.ball.changeVelocity(velocityX: 15, velocityY: 10)

        insert(entity: InteractionLayer.ball, at: .front)

        insert(entity: InteractionLayer.paddleLeft, at: .front)
        insert(entity: InteractionLayer.paddleRight, at: .front)
    }
func renderprojectileExample(projectileExample:Projectile) {
        insert(entity:projectileExample, at:.front)
    }
   
    func removeEntity(entity: RenderableEntity) {
        remove(entity: entity)
    }

    override func preSetup(canvasSize: Size, canvas: Canvas)
    {
        InteractionLayer.paddleLeft.move(to:Point(x: 20, y: 480))
        InteractionLayer.paddleRight.move(to:Point(x: 1875, y: 480))
          //        projectileExample.move(to:Point(x: 500, y:200))
        dispatcher.registerKeyDownHandler(handler: self)
        dispatcher.registerKeyUpHandler(handler: self)

    }

    var keysDown = [String]()

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool)
    {
        print(keysDown) 
        let tlpl = InteractionLayer.paddleLeft.rectangle.rect.topLeft
        let tlpr = InteractionLayer.paddleRight.rectangle.rect.topLeft

        if !keysDown.contains(key) {
            keysDown.append(key)
        }

        for k in keysDown {        
            switch k
            {
            case "w":
               Ball.paddleLeft.move(to:Point(x: tlpl.x, y:tlpl.y - 25))
            case "s":
                InteractionLayer.paddleLeft.move(to:Point(x: tlpl.x, y:tlpl.y + 25))
            case "ArrowUp":
                InteractionLayer.paddleRight.move(to:Point(x: tlpr.x, y:tlpr.y - 25))
            case "ArrowDown":
                InteractionLayer.paddleRight.move(to:Point(x: tlpr.x, y:tlpr.y + 25))
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
   
