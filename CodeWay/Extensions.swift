//
//  Extensions.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/21/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

extension Array {
    func find(includedElement: (Element) -> Bool) -> Int? {
        for (idx, element) in enumerated() {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
}
