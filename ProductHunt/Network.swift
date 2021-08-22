//  Created by Ky Nguyen

import Apollo
import Foundation

class Network {
    private let rootUrl = "https://api.producthunt.com/v2/api/graphql?access_token=HJ8gAC2M5mjGQxw4fqwE2YFEtWNmJfszWmP6KtWy33s"
    static let shared = Network()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: rootUrl)!)
}
