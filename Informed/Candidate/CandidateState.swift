//
//  CandidateState.swift
//  Informed
//
//  Created by Ethan Pippin on 7/10/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

enum CandidateEventChange {
    case fetchedAll([Candidate])
    case fetchedSingle(Candidate)
}

private let sharedCore: Core<CandidateState> = {
    return Core(state: CandidateState.emptytate())
}()

struct CandidateState: State {
    var candidates: [Candidate]
    var following: [Candidate]
    
    typealias EventType = CandidateEventChange
    
    static var core: Core<CandidateState> {
        return sharedCore
    }
    
    mutating func respond(to event: CandidateEventChange) {
        switch event {
        case .fetchedAll(let candidates):
            self.candidates += candidates
        case .fetchedSingle(let candidate):
            self.candidates.append(candidate)
        }
    }
    
    static func emptytate() -> CandidateState {
        return CandidateState(candidates: [], following: [])
    }
}
