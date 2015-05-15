

import SpriteKit

class GameScene: SKScene {

    //Setup your scene here
    override func didMoveToView(view: SKView) {
        
    }
    //Called when a touch begins
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
      let introLabel = childNodeWithName("introLabel")

        if(introLabel != nil){
            let fadeOut = SKAction.fadeOutWithDuration(1.0)
            
            introLabel?.runAction(fadeOut, completion: {
                let doors = SKTransition.doorwayWithDuration(1.5)
                let shooterScene = ShooterScene(fileNamed: "ShooterScene")
                self.view?.presentScene(shooterScene, transition: doors)
            })
        }
        
    }
    //Called before each frame is rendered
    override func update(currentTime: CFTimeInterval) {
    }
}
