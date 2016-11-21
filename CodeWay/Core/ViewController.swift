//
//  ViewController.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/20/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

struct ViewController<Result> {
    private let build: ( @escaping (Result) -> ()) -> UIViewController
    
    init(_ build: @escaping ( @escaping (Result) -> ()) -> UIViewController) {
        self.build = build
    }
    
    func run(f: @escaping (Result) -> ()) -> UIViewController {
        return build(f)
    }
    
}

//func map<A,B>(vc: ViewController<A>, f: @escaping (A) -> B) -> ViewController<B> {
//    return ViewController { callback in
//        return vc.run { y in
//            callback(f(y))
//        }
//    }
//}
//
//extension UIViewController {
//    func presentModal<A>(screen: NavigationController<A>, callback: @escaping (A) -> ()) {
//        let vc = screen.build { [unowned self] x, nc in
//            callback(x)
//            self.dismiss(animated: true, completion: nil)
//        }
//        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
//        present(vc, animated: true, completion: nil)
//    }
//}
