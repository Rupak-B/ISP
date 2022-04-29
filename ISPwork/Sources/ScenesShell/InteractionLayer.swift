import Scenes
import Igis

  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class InteractionLayer : Layer {

    let projectileExample : Projectile
    let ufo = UFO()
    let ufo2 = UFO()
    init() {
        self.projectileExample = Projectile(velocityY : 3, rectangle: Rectangle(rect:Rect(topLeft: Point(), size:Size(width: 4, height: 30)), fillMode: .fill))
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")
        
        // We insert our RenderableEntities in the constructor
        insert(entity: ufo, at: .front)
        ufo.changeVelocity(velocityX: 26, velocityY: 12)
        insert(entity: projectileExample, at: .front)
        insert(entity: ufo2, at: .front)
        ufo2.changeVelocity(velocityX: -20, velocityY: 12)
    }

    func removeEntity(entity: RenderableEntity) {
        remove(entity: entity)
    }
}
