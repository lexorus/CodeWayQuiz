//
//  NavigationController.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/20/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

struct NavigationController<A> {
    let build: ( _ f: @escaping (A, UINavigationController) -> ()) -> UINavigationController
    
    func run() -> UINavigationController {
        return build { _ in }
    }
    
}

extension NavigationController {
    
    init(_ viewConroller: ViewController<A>) {
        build = { callback in
            let navigationController = UINavigationController()
            let viewControllerCallback: (A) -> () = { a in callback(a, navigationController) }
            let viewController = viewConroller.run(f: viewControllerCallback)
            navigationController.pushViewController(viewController, animated: true)
            
            return navigationController
        }
    }
    
    func flatMap<B>(f: @escaping ((A) -> NavigationController<B>)) -> NavigationController<B> {
        return NavigationController<B> { callback in
            let navigationController = self.build({ (result, navigationController) in
                let _ = f(result).build(callback)
            })
            
            return navigationController
        }
    }
    
    func run( callback: @escaping ((A) -> ())) -> UIViewController {
        let navigationController = UINavigationController()
        let _ = self.build { (result, navigationController) in
            callback(result)
        }
        
        return navigationController
    }
    
}

func navigationController<Result>(viewController: ViewController<Result>) -> NavigationController<Result> {
    return NavigationController { callback in
        let navigationController = UINavigationController()
        let rootController = viewController.run(f: { result in
            callback(result, navigationController)
        })
        navigationController.viewControllers = [rootController]
        return navigationController
    }
}

precedencegroup LeftAssociativity {
    associativity: left
    higherThan: DefaultPrecedence
}

infix operator >>> : LeftAssociativity

func >>><A,B>(l: NavigationController<A>, r: @escaping (A) -> ViewController<B>) -> NavigationController<B> {
    return NavigationController { (callback) in
        let nc = l.build { a, nc in
            let rvc = r(a).run { c in
                callback(c, nc)
            }
            nc.pushViewController(rvc, animated: true)
            
        }
        return nc
    }
}

func map<A,B>(nc: NavigationController<A>, f: @escaping (A) -> B) -> NavigationController<B> {
    return NavigationController { callback in
        return nc.build { (y, nc) in
            callback(f(y), nc)
        }
    }
}
