//  Created by Ky Nguyen

import Foundation

struct GetProductListResult {
    let products: [Product]
    let lastCursor: String?
}

struct GetProductListWorker {
    let cursor: String?
    func execute(onSuccess: @escaping(GetProductListResult) -> Void, onFailure: @escaping(Error) -> Void) {
        Network.shared.apollo.fetch(query: ProductListQuery(cursor: cursor)) { result in
            switch result {
                case .success(let productsRaw):
                    let raw = productsRaw.data?.posts.edges ?? []
                    let products = raw.compactMap { Product(raw: $0.node)}
                    let lastCursor = raw.last?.cursor
                    onSuccess(GetProductListResult(products: products, lastCursor: lastCursor))
                case .failure(let error):
                    onFailure(error)
            }
        }
    }
}
