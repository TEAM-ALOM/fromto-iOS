//
//  MapViewModel.swift
//  FromTo
//
//  Created by 송영모 on 2023/08/04.
//  Copyright © 2023 alom.com. All rights reserved.
//

import Foundation

class BaseViewModel {
    init() {
        
    }
}

public struct MapSearchAction { }

public struct MapSearchInput {
    let viewDidLoad: Observable<Void> = .init(())
}

public struct MapSearchOutput {
    
}

final class MapSearchViewModel: BaseViewModel {
    var action: MapSearchAction
    var input: MapSearchInput
    var output: MapSearchOutput
    
    init(action: MapSearchAction) {
        self.action = action
        self.input = .init()
        self.output = .init()
        
        super.init()
    }
}
