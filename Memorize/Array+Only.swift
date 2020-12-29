//
//  Array+Only.swift
//  Memorize
//
//  Created by Deivid Willyan Rodrigues Fabiano on 29/12/20.
//

import Foundation

extension Array {
    var only : Element? {
        count == 1 ? first : nil
    }
}
