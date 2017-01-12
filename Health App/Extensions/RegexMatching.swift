//
//  RegexMatching.swift
//  myDriver-Driver-V3.0
//
//  Created by Cong Phu on 12/21/16.
//  Copyright © 2016 Cong Phu. All rights reserved.
//

import Foundation

struct Regex {
    let pattern: String

    fileprivate var matcher: NSRegularExpression? {
        do {
            return try NSRegularExpression(pattern: self.pattern, options: [])
        } catch _ {
            return nil
        }
    }

    init(pattern: String) {
        self.pattern = pattern
    }

    func match(_ string: String) -> Bool {
        guard let matcher = self.matcher else {
            return false
        }
        return matcher.numberOfMatches(in: string, range: NSRange.init(location: 0, length: string.utf16.count)) != 0
    }
}

protocol RegularExpressionMatchable {
    func match(_ regex: Regex) -> Bool
}

extension String: RegularExpressionMatchable {
    func match(_ regex: Regex) -> Bool {
        return regex.match(self)
    }
}

func ~=<T: RegularExpressionMatchable>(pattern: Regex, matchable: T) -> Bool {
    return matchable.match(pattern)
}
