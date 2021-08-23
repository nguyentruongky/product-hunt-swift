//  Created by Ky Nguyen

import Foundation

struct Product {
    let id: String
    let name: String
    let description: String?
    let thumbnailUrl: String?
    let isVoted: Bool
    let votesCount: Int
    
    init?(raw: ProductListQuery.Data.Post.Edge.Node) {
        isVoted = raw.isVoted
        votesCount = raw.votesCount
        id = raw.id
        name = raw.name
        description = raw.tagline
        thumbnailUrl = raw.thumbnail?.url
    }
}
