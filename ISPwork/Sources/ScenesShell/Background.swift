import Scenes
import Igis
import Foundation
  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity, MouseMoveHandler {

    let mm: Image
    init() {
        guard let mmURL = URL(string:"https://pixelartmaker-data-78746291193.nyc3.digitaloceanspaces.com/image/ece60cc31aeebda.png")
        else
        {
            fatalError("Failed to create URL for symbol")
        }
        mm = Image(sourceURL:mmURL)
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")
    }
    override func setup(canvasSize:Size, canvas: Canvas)
    {
        canvas.setup(mm)
        dispatcher.registerMouseMoveHandler(handler:self)
    }
    override func teardown()
    {
        dispatcher.unregisterMouseMoveHandler(handler:self)
    }
    func onMouseMove(globalLocation: Point, movement: Point) {}
    override func render(canvas:Canvas)
    {
        if let canvasSize = canvas.canvasSize
        {
            if mm.isReady
            {
                mm.renderMode = .destinationRect(Rect(topLeft:Point(x:0, y:0), size:Size(width:1950, height:1000)))
            }
            canvas.render(mm)
        }
    }
}
