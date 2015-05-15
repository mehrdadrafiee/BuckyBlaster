

import UIKit
import SpriteKit

class ShooterScene: SKScene {
    
    var score = 0
    var enemyCount = 10
    var shooterAnimation = [SKTexture]()
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0, -1.2)
        self.initShooterScene()
    }
    
    func initShooterScene(){
        let shooterAtlas = SKTextureAtlas(named: "shooter")
        
        for index in 1...shooterAtlas.textureNames.count {
            let imgName = String(format: "shooter%01d", index)
            shooterAnimation += [shooterAtlas.textureNamed(imgName)]
        }
        
        //Drop balls from top
        let dropBalls = SKAction.sequence([SKAction.runBlock({
            self.createBallNode()}),
            SKAction.waitForDuration(2.0)
            ])
        
        self.runAction(SKAction.repeatAction(dropBalls, count: enemyCount), completion: nil)
    }
   
    //Animate the shooter
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let shooterNode = self.childNodeWithName("shooterNode")
        
        if(shooterNode != nil) {
            let animation = SKAction.animateWithTextures(shooterAnimation, timePerFrame: 0.05)
            
            //Shooting the bullet
            let shootBullet = SKAction.runBlock({
                let bulletNode = self.createBulletNode()
                self.addChild(bulletNode)
                bulletNode.physicsBody?.applyImpulse(CGVectorMake(180.0, 0))
            })
            
            let sequence = SKAction.sequence([animation, shootBullet])
            shooterNode?.runAction(sequence)
        }
    }
    
    //Create bullet node
    func createBulletNode() -> SKSpriteNode {
        let shooterNode = self.childNodeWithName("shooterNode")
        let shooterPosition = shooterNode?.position
        let shooterWidth = shooterNode?.frame.size.width
        
        let bullet = SKSpriteNode (imageNamed: "bullet.png")
        bullet.position = CGPointMake(shooterPosition!.x + shooterWidth!/2, shooterPosition!.y)
        bullet.name = "bulletNode"
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.frame.size)
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        
        return bullet
    }
    
    //Call this to create a new ball
    func createBallNode() {
        let ball = SKSpriteNode(imageNamed: "ball.png")
        ball.position = CGPointMake(randomNumber(self.size.width), self.size.height)
        ball.name = "ballNode"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(ball)
    }
    
    //Random number between 0 and width
    func randomNumber(maximum: CGFloat) -> CGFloat {
        let maxInt = UInt32(maximum)
        let result = arc4random_uniform(maxInt)
        return CGFloat(result)
    }
}








