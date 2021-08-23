//  Created by Ky Nguyen

import UIKit

class DetailInteractor {
    private weak var controller: DetailController?
    
    init(controller: DetailController) {
        self.controller = controller
    }
    
    func freshGetData(productId: String) {
        print("productId: \(productId)")
        GetProductDetailWorker(productId: productId).execute(onSuccess: { [weak self] product in
            self?.controller?.updateUI(product)
        }, onFailure: { [weak self] error in
            self?.controller?.showError(message: error.localizedDescription)
        })
    }
}
