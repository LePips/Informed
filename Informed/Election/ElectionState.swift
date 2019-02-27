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
    case refreshedSingle(Election)
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
        case .fetchedSingle: ()
        case .fetchedFeature(let election):
            self.featuredElection = election
        case .refreshedSingle(let election):
            elections.replace(with: election)
        }
    }
    
    static func emptyState() -> ElectionState {
        return ElectionState(elections: [], featuredElection: nil)
    }
}

extension Election: Equatable {
    static func ==(lhs: Election, rhs: Election) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Array where Element == Election {
    mutating func replace(with election: Election) {
        if let oldElection = self.filter({ $0.id == election.id }).first {
            let index = self.firstIndex(where: { $0.id == oldElection.id })!
            self[index] = election
        }
    }
}
