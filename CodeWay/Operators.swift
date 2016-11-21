//
//  Operators.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/21/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

infix operator <*>

func <*><A>(_ x: A?, _ f: ((A) -> ())?) {
    guard let x = x, let f = f else {
        return
    }
    f(x)
}
