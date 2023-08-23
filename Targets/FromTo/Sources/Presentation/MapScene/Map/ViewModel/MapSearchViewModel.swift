//
//  MapViewModel.swift
//  FromTo
//
//  Created by 송영모 on 2023/08/04.
//  Copyright © 2023 alom.com. All rights reserved.
//

import Foundation
import CoreLocation

import RxSwift
import RxCocoa

public struct MapSearchAction { }

public struct MapSearchInput {
    let viewDidLoad: Observable<Void> = .init(())
}

public struct MapSearchOutput {
    
}

public final class MapSearchViewModel {
    public var state: State
    
    public enum Action {
        case viewDidLoad
    }
    
    public struct State {
        var currentLocation: BehaviorRelay<CLLocation> = .init(value: .init())
    }
    
    public init() {
        state = .init()
        
        bind()
    }
    
    public func send(_ action: Action) {
        switch action {
        case .viewDidLoad:
            break
        }
    }
    
    private func bind() {
        
    }
}
