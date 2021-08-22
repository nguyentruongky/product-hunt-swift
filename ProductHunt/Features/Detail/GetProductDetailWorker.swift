//  Created by Ky Nguyen

import Foundation
struct GetProductDetailWorker {
    func execute(onSuccess: @escaping(ProductDetail) -> Void, onFailure: @escaping(Error) -> Void) {
        Network.shared.apollo.fetch(query: ProductDetailQuery()) { result in
            switch result {
                case .success(let detailRaw):
                    guard let raw = detailRaw.data?.post else {
                        onFailure(NSError(domain: "No data", code: -1, userInfo: nil))
                        return
                    }
                    
                    let product = ProductDetail(raw: raw)
                    onSuccess(product)
                case .failure(let error):
                    onFailure(error)
            }
        }
    }
}
