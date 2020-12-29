//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Deivid Willyan Rodrigues Fabiano on 29/12/20.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(_ matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
