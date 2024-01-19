//
//  Extensions.swift
//  Quiz
//
//  Created by c035 DIT UPM on 17/11/23.
//

import Foundation

infix operator =+-= : ComparisonPrecedence

extension String {
    static func =+-=(s1:String, s2:String) -> Bool {
        var a = s1.lowercased().trimmingCharacters(in: .whitespaces)
        var b = s2.lowercased().trimmingCharacters(in: .whitespaces)
        return a==b
    }
}


