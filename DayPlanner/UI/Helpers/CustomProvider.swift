//
//  CustomProvider.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/17/23.
//

import SwiftUI

class CustomProvider: NSItemProvider {
    var ended: () -> Void
    
    init(ended: @escaping () -> Void) {
        self.ended = ended
        super.init()
    }
    
    deinit {
        ended()
    }
}
