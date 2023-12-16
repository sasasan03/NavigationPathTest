import UIKit

func addCurly(_ a: Int) -> (Int) -> Void {
    return { b in print( b + a )}
}

addCurly(222)
