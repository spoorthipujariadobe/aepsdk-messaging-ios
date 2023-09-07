//
//  ParsedPersonalizationResponse.swift
//  AEPMessaging
//
//  Created by steve benedick on 9/6/23.
//

import Foundation
import AEPCore
import AEPServices

struct ParsedPropositions {
    // store tracking information for propositions loaded into rules engines
    var propositionInfoToCache: [String: PropositionInfo] = [:]
    
    // non-in-app propositions should be cached and not persisted
    var propositionsToCache: [Surface: [Proposition]] = [:]
    
    // in-app propositions don't need to stay in cache, but must be persisted
    // also need to store tracking info for in-app propositions as `PropositionInfo`
    var propositionsToPersist: [Surface: [Proposition]] = [:]
    
    // in-app and feed rules that need to be applied to their respective rules engines
    var rulesByInboundType: [InboundType: [LaunchRule]] = [:]
    
    init(with propositions:[Surface: [Proposition]], requestedSurfaces: [Surface]) {
        for propositionsArray in propositions.values {
            for proposition in propositionsArray {
                guard let surface = requestedSurfaces.first(where: { $0.uri == proposition.scope }) else {
                    Log.debug(label: MessagingConstants.LOG_TAG,
                              "Ignoring proposition where scope (\(proposition.scope)) does not match one of the expected surfaces.")
                    continue
                }
                
                guard let contentString = proposition.items.first?.content, !contentString.isEmpty else {
                    Log.debug(label: MessagingConstants.LOG_TAG, "Ignoring Proposition with empty content.")
                    continue
                }
                
                // iam and feed items will be wrapped in a valid rules engine rule - code-based experiences are not
                guard let parsedRules = parseRule(contentString) else {
                    Log.debug(label: MessagingConstants.LOG_TAG, "Proposition did not contain a rule, adding as a code-based experience.")
                    propositionsToCache.add(proposition, forKey: surface)
                    continue
                }
                
                let consequence = parsedRules.first?.consequences.first
                if let messageId = consequence?.id {
                    // store reporting data for this payload
                    propositionInfoToCache[messageId] = PropositionInfo.fromProposition(proposition)
                }
                
                var inboundType: InboundType = .inapp
                let isInAppConsequence = consequence?.isInApp ?? false
                if isInAppConsequence {
                    propositionsToPersist.add(proposition, forKey: surface)
                } else {
                    inboundType = InboundType(from: consequence?.detailSchema ?? "")
                    let isFeedConsequence = consequence?.isFeedItem ?? false
                    if !isFeedConsequence {
                        propositionsToCache.add(proposition, forKey: surface)
                    }
                }
                
                rulesByInboundType.addArray(parsedRules, forKey: inboundType)
            }
        }
    }
    
    private func parseRule(_ rule: String) -> [LaunchRule]? {
        JSONRulesParser.parse(rule.data(using: .utf8) ?? Data())
    }
}
