//  Created by Ky Nguyen

import UIKit

class HomeInteractor {
    weak var controller: HomeController?
    init(controller: HomeController) {
        self.controller = controller
    }
    
    func loadData() {
        GetProductListWorker().execute(onSuccess: { [weak self] products in
            self?.controller?.datasource = products
        }, onFailure: { [weak self] error in
            self?.controller?.showError(message: error.localizedDescription)
        })
    }
}
