//
// Created by Mengyu Li on 2022/3/1.
//

public protocol Compatible {
    associatedtype CompatibleType
    var senna: CompatibleType { get }
}

public extension Compatible {
    var senna: Box<Self> {
        Box<Self>(value: self)
    }
}
