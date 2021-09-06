//
//  Constants.swift
//  TreasureHunt
//
//  Created by Manuella Valença on 26/08/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

struct Constants {
    struct Colors {
        static var transparentLightGray = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.1)
    }
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
