//
//  CustomProvider.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/17/23.
//

import SwiftUI

//Idea came from https://github.com/Asperi-Demo/4SwiftUI/blob/master/PlayOn_iOS/PlayOn_iOS/Findings/TestDropCancellingIntercept.swift
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
