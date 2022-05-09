import Foundation
import Scenes
import Igis

/*

 This class is responsible for rendering the background.
 */


class Background : RenderableEntity {

    var animationFrame = 0

    let backround1 : Image
    let backround2 : Image
    let backround3 : Image

    init() {

        func getImage(url:String) -> Image {
            guard let url = URL(string:url) else {
                fatalError("Failed to create URL for "+url)
            }
            return Image(sourceURL:url)
        }

        backround1 = getImage(url :"https://codermerlin.com/users/logan-mueller/backround1.jpeg")
        backround2 = getImage(url :"https://codermerlin.com/users/logan-mueller/backround2.jpg")
        backround3 = getImage(url :"https://codermerlin.com/users/logan-mueller/backround3.jpeg")
        super.init(name:"Background")

    }

    override func setup (canvasSize: Size, canvas:Canvas) {
        canvas.setup(backround1, backround2, backround3)
    }

    override func render(canvas:Canvas) {
        if (animationFrame >= 300) {
            animationFrame = 0
        }
        if (animationFrame / 100 == 1) {
            if (backround1.isReady) {
                backround1.renderMode = .destinationRect(Rect(topLeft:Point(x:0,y:0), size:Size( width:1900, height:1000)))
                canvas.render(backround1)
            }
        }
        else if(animationFrame / 100 == 2) {
            if (backround2.isReady) {
                backround2.renderMode = .destinationRect(Rect(topLeft:Point(x:0,y:0), size:Size( width:1900, height:1000)))           }
        }
        else {
            if (backround3.isReady) {
                backround3.renderMode = .destinationRect(Rect(topLeft:Point(x:0,y:0), size:Size( width:1900, height:1000)))
                canvas.render(backround3)
            }
        }
        animationFrame += 1
//        print(animationFrame)
    }
}

 
