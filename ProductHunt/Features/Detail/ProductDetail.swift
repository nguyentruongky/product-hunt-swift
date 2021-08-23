//  Created by Ky Nguyen

import Foundation

struct Media {
    enum `Type`: String {
        case video, image
    }
    let type: String
    let url: String?
    init(raw: ProductDetailQuery.Data.Post.Medium) {
        type = raw.type
        if type == "video" {
            url = raw.videoUrl
        } else {
            url = raw.url
        }
    }
    init(type: Type, url: String) {
        self.type = type.rawValue
        self.url = url
    }
}

struct User {
    let id: String
    let name: String
    let imageUrl: String?
    let headline: String?
    init(raw: UserFragment) {
        id = raw.id
        name = raw.name
        imageUrl = raw.profileImage
        headline = raw.headline
    }
}

struct Comment {
    let body: String
    let creator: User
    let voteCount: Int
    let createdAt: String
    let isVoted: Bool
    
    init(raw: CommentFragment) {
        body = raw.body
        creator = User(raw: raw.user.fragments.userFragment)
        isVoted = raw.isVoted
        voteCount = raw.votesCount
        let date = Date(iso8601String: raw.createdAt)
        createdAt = date.timeAgo.capitalized
    }
}

struct ProductDetail {
    let id: String
    let name: String
    let tagLine: String
    let tags: [String]
    let description: String?
    let thumbnailUrl: String?
    let medias: [Media]
    let featuredAt: String?
    let creator: User
    let makers: [User]
    let comments: [Comment]
    let isVoted: Bool
    
    init(raw: ProductDetailQuery.Data.Post) {
        id = raw.id
        name = raw.name
        tagLine = raw.tagline
        tags = raw.collections.edges.map { $0.node.name }
        description = raw.description ?? raw.tagline
        thumbnailUrl = raw.thumbnail?.url
        medias = raw.media.map { Media(raw: $0) }
        featuredAt = raw.featuredAt
        creator = User(raw: raw.user.fragments.userFragment)
        makers = raw.makers.map { User(raw: $0.fragments.userFragment )}
        comments = raw.comments.edges.map { Comment(raw: $0.node.fragments.commentFragment) }
        isVoted = raw.isVoted
    }
}
