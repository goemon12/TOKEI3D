//
//  GameViewController.swift
//  TOKEI3D
//
//  Created by goemon12 on 2019/08/14.
//  Copyright © 2019 goemon12. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    var hariH: SCNNode!
    var hariM: SCNNode!
    var hariS: SCNNode!
    var fmtH: DateFormatter!
    var fmtM: DateFormatter!
    var fmtS: DateFormatter!
    //(1)変数定義
    var textH: SCNText!
    var textM: SCNText!
    var textS: SCNText!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/tokei3d.scn")!
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        fmtH = DateFormatter()
        fmtM = DateFormatter()
        fmtS = DateFormatter()
        fmtH.dateFormat = "HH"
        fmtM.dateFormat = "mm"
        fmtS.dateFormat = "ss"

        hariM = scene.rootNode.childNode(withName: "HARI-M", recursively: true)
        hariH = scene.rootNode.childNode(withName: "HARI-H", recursively: true)
        hariS = scene.rootNode.childNode(withName: "HARI-S", recursively: true)
        
        //（２）変数にtokei3D.scnファイルのTEXTノードのジオメトリを代入する
        textH = scene.rootNode.childNode(withName: "TEXT-H", recursively: true)!.geometry as? SCNText
        textM = scene.rootNode.childNode(withName: "TEXT-M", recursively: true)!.geometry as? SCNText
        textS = scene.rootNode.childNode(withName: "TEXT-S", recursively: true)!.geometry as? SCNText

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            let t = Date()
            let strH = self.fmtH.string(from: t)
            let strM = self.fmtM.string(from: t)
            let strS = self.fmtS.string(from: t)
            let h = Int(strH)!
            let m = Int(strM)!
            let s = Int(strS)!
            self.hariH.rotation = SCNVector4(0, 0, 1, CGFloat.pi * 2 /  720 * -CGFloat(h * 60 + m))
            self.hariM.rotation = SCNVector4(0, 0, 1, CGFloat.pi * 2 / 3600 * -CGFloat(m * 60 + s))
            self.hariS.rotation = SCNVector4(0, 0, 1, CGFloat.pi * 2 / 60 * -CGFloat(s))
 
            //(3)TEXTノードのジオメトリのstringプロパティに時間文字を代入する
            self.textH.string = "\(h)"
            self.textM.string = "\(m)"
            self.textS.string = "\(s)"
        })
    }
}
