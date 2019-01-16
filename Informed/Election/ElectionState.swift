//
//  ElectionState.swift
//  Informed
//
//  Created by Ethan Pippin on 6/8/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation
import SharedPips

enum ElectionEventChange {
    case fetchedAll([Election])
    case fetchedSingle(Election)
    case fetchedFeature(Election)
}

private let sharedCore: Core<ElectionState> = {
    return Core(state: ElectionState.emptyState())
}()

struct ElectionState: State {
    var elections: [Election]
    var featuredElection: Election? = nil
    var nationalElections: [Election] {
        return elections.filter { $0.type == .National }
    }
    var stateElections: [Election] {
        return elections.filter { $0.type == .State }
    }
    
    typealias EventType = ElectionEventChange
    
    static var core: Core<ElectionState> {
        return sharedCore
    }
    
    mutating func respond(to event: ElectionEventChange) {
        switch event {
        case .fetchedAll(let elections):
            self.elections = elections
        case .fetchedSingle(let election):
            self.elections.append(election)
        case .fetchedFeature(let election):
            self.featuredElection = election
        }
    }
    
    static func emptyState() -> ElectionState {
        return ElectionState(elections: [], featuredElection: nil)
    }
}
