import Scenes
import Igis

class ClearRectangle : RenderableEntity {
    let rectangle = Rectangle(rect:Rect(topLeft:Point(), size:Size(width:0, height:0)), fillMode:.fill )
    let fillStyle = FillStyle(color : Color(.black))
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        rectangle.rect.size = canvasSize
    }

    override func render(canvas:Canvas) {
        canvas.render(fillStyle, rectangle)
    }

}
