//
//  Observable+Operators.swift
//  Prelens-jinny
//
//  Created by vinova on 3/13/18.
//  Copyright © 2018 Lamp. All rights reserved.
//

import RxSwift

public protocol OptionalType {
    associatedtype Wrapped

    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

internal extension Observable where Element: OptionalType {
    internal func ignoreNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}

extension ObservableType {
    public func showProgressIndicator() -> Observable<Self.E> {
        return self.do(onError: { _ in
            print("Dismiss onError progress")
            ProgressLoadingHelper.shared.hideIndicator()
        }, onCompleted: {
            print("Dismiss onCompleted progress")
            ProgressLoadingHelper.shared.hideIndicator()
        }, onSubscribe: {
            print("Show progress")
            ProgressLoadingHelper.shared.showIndicator()
        })
    }
}

