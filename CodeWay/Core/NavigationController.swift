//
//  NavigationController.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/20/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

struct NavigationController<Result> {
    let build: ( _ f: @escaping (Result, UINavigationController) -> ()) -> UINavigationController
    
    func run() -> UINavigationController {
        return build { _ in }
    }
    
    func flatMap<B>(_ transform: @escaping (Result) -> ViewController<B>) -> NavigationController<B> {
        return NavigationController<B> { (callback) in
            let nc = self.build { a, nc in
                let rvc = transform(a).run { c in
                    callback(c, nc)
                }
                nc.pushViewController(rvc, animated: true)
                
            }
            return nc
        }
    }
    
}

func navigationController<Result>(_ viewController: ViewController<Result>) -> NavigationController<Result> {
    return NavigationController { callback in
        let navigationController = UINavigationController()
        let rootController = viewController.run(f: { result in
            callback(result, navigationController)
        })
        navigationController.viewControllers = [rootController]
        return navigationController
    }
}

//func map<A,B>(nc: NavigationController<A>, f: @escaping (A) -> B) -> NavigationController<B> {
//    return NavigationController { callback in
//        return nc.build { (y, nc) in
//            callback(f(y), nc)
//        }
//    }
//}
//
//func flatMap<A, B>(l: NavigationController<A>, f: @escaping ((A) -> NavigationController<B>)) -> NavigationController<B> {
//    return NavigationController<B> { callback in
//        let navigationController = l.build({ (result, navigationController) in
//            let _ = f(result).build(callback)
//        })
//        
//        return navigationController
//    }
//}
//
//precedencegroup LeftAssociativity {
//    associativity: left
//    higherThan: DefaultPrecedence
//}
//
//infix operator >>> : LeftAssociativity
//
//func >>><A,B>(l: NavigationController<A>, r: @escaping (A) -> ViewController<B>) -> NavigationController<B> {
//    return l.flatMap(r)
//}
//
