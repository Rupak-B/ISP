import Foundation
import Igis
import Scenes

class Paddle: RenderableEntity
{
    var rectangle: Rectangle
    var didRender: Bool

    init(rect:Rect)
    {
        didRender = false

        rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)

        // Using a meaningful name can be helpful for debugging
        super.init(name: "Paddle")
    }
    override func render(canvas:Canvas)
    {
        if let canvasSize = canvas.canvasSize
        {
            // Clear the entire canvas
//            let clearRect = Rect(topRight:Point(x:0, y:0), size:canvasSize)
  //          let clearRectangle = Rectangle(rect:clearRect, fillMode:.fill)

    //        canvas.render(FillStyle(color:Color(.white)),clearRectangle)

            let strokeStyle = StrokeStyle(color:Color(.black))
            let fillStyle = FillStyle(color:Color(.white))
            let lineWidth = LineWidth(width:2)
            canvas.render(strokeStyle, fillStyle, lineWidth, rectangle)
        }
    }

    func move(to point:Point)
    {
        rectangle.rect.topLeft = point
    }
}
