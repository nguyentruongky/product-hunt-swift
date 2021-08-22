//  Created by Ky Nguyen

import UIKit

class HomeInteractor {
    private weak var controller: HomeController?
    private var cursor: String?
    private var isLoading = false
    init(controller: HomeController) {
        self.controller = controller
    }

    func freshGetData() {
        if isLoading { return }
        isLoading = true
        GetProductListWorker(cursor: nil).execute(onSuccess: { [weak self] result in
            self?.isLoading = false
            self?.controller?.freshUpdateDatasource(result.products)
            self?.cursor = result.lastCursor
        }, onFailure: { [weak self] error in
            self?.isLoading = false
            self?.controller?.showError(message: error.localizedDescription)
        })
    }

    func loadMoreData() {
        if isLoading { return }
        isLoading = true
        print("Loading more")
        GetProductListWorker(cursor: cursor).execute(onSuccess: { [weak self] result in
            self?.isLoading = false
            self?.controller?.updateDatasource(result.products)
            self?.cursor = result.lastCursor
        }, onFailure: { [weak self] error in
            self?.isLoading = false
            self?.controller?.showError(message: error.localizedDescription)
        })
    }
}
