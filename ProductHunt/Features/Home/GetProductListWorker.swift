//  Created by Ky Nguyen

import Foundation

struct GetProductListWorker {
    func execute(onSuccess: @escaping([Product]) -> Void, onFailure: @escaping(Error) -> Void) {
        Network.shared.apollo.fetch(query: ProductListQuery()) { result in
            switch result {
                case .success(let productsRaw):
                    let raw = productsRaw.data?.posts.edges ?? []
                    let products = raw.compactMap { Product(raw: $0.node)}
                    onSuccess(products)
                case .failure(let error):
                    onFailure(error)
            }
        }
    }
}
