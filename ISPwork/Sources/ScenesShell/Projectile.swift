
import Foundation
import Scenes
import Igis

class Projectile : RenderableEntity {

    var rectangle : Rectangle
    var remove = false
    let velocityY : Int
    let fillStyle = FillStyle(color:Color(.red))
    var score = 1
    
    init(velocityY: Int, rectangle : Rectangle) {
        self.velocityY = velocityY
        self.rectangle = rectangle
        
        super.init(name:"Projectile")
    }

    override func calculate(canvasSize: Size) {
        if remove {
            return
        }
        rectangle.rect.topLeft.y += velocityY
    }

    override func render(canvas: Canvas) {
        if remove {
            return
        }
        
        if let canvasSize = canvas.canvasSize {
            // if projectile is below bottom of canvas
            if rectangle.rect.topLeft.y >= canvasSize.height {
                // can be removed
                remove = true
                score += 1
            }

            // if projectile is above top of canvas
            if rectangle.rect.topLeft.y + rectangle.rect.size.height <= 0 {
                // can be removed
                remove = true
            }
        }

        canvas.render(fillStyle, rectangle)
    }
    func move(to point:Point)
    {
        rectangle.rect.topLeft = point
    }
}
