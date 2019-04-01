//
//  Model.swift
//  rush00
//
//  Created by Greg PHILIPS on 3/30/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import Foundation

struct Tags : Codable {
    let id : Int?
    let name : String?
    let kind : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case kind = "kind"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
    }
    
}

struct Language : Codable {
    let id : Int?
    let language_id : Int?
    let user_id : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case language_id = "language_id"
        case user_id = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        language_id = try values.decodeIfPresent(Int.self, forKey: .language_id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
    }
    
    init(user_id: Int?) {
        self.id = 1
        self.language_id = 1
        self.user_id = user_id
    }
}

struct User : Codable {
    let id : Int?
    let login : String?
    let languages_users : [Language]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case languages_users = "languages_users"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        languages_users = try values.decodeIfPresent([Language].self, forKey: .languages_users)
    }
    
}

struct Replies : Codable {
    let id : Int?
    let author : Author?
    let content : String?
    let created_at : String?
    let parent_id : Int?
    let is_root : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case author = "author"
        case content = "content"
        case created_at = "created_at"
        case parent_id = "parent_id"
        case is_root = "is_root"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        author = try values.decodeIfPresent(Author.self, forKey: .author)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        parent_id = try values.decodeIfPresent(Int.self, forKey: .parent_id)
        is_root = try values.decodeIfPresent(Bool.self, forKey: .is_root)
    }
    
}

struct Message : Codable {
    let id : Int?
    let author : Author?
    let content : String?
    let replies : [String]?
    let created_at : String?
    let parent_id : String?
    let is_root : Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case content = "content"
        case replies = "replies"
        case created_at = "created_at"
        case parent_id = "parent_id"
        case is_root = "is_root"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        author = try values.decodeIfPresent(Author.self, forKey: .author)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        if let r = try? values.decodeIfPresent([String].self, forKey: .replies) {
            replies = r
        }
        else {
            replies = nil
        }
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        parent_id = try values.decodeIfPresent(String.self, forKey: .parent_id)
        is_root = try values.decodeIfPresent(Bool.self, forKey: .is_root)
    }
}


struct Author : Codable {
    let id : Int?
    let login : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        login = try values.decodeIfPresent(String.self, forKey: .login)
    }
    
}

struct MessageTopic : Codable {
    let content : Content?
    
    enum CodingKeys: String, CodingKey {
        case content = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        content = try values.decodeIfPresent(Content.self, forKey: .content)
    }
}

struct Content : Codable {
    let markdown : String?
    
    enum CodingKeys: String, CodingKey {
        case markdown = "markdown"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        markdown = try values.decodeIfPresent(String.self, forKey: .markdown)
    }
    
}

struct Topic : Codable {
    let id : Int?
    let name : String?
    let author : Author?
    let kind: String?
    let created_at : String?
    let messages_url : String?
    let message : MessageTopic?
    let tags : [Tags]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case author = "author"
        case kind = "kind"
        case created_at = "created_at"
        case messages_url = "messages_url"
        case message = "message"
        case tags = "tags"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        author = try values.decodeIfPresent(Author.self, forKey: .author)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        messages_url = try values.decodeIfPresent(String.self, forKey: .messages_url)
        message = try values.decodeIfPresent(MessageTopic.self, forKey: .message)
        tags = try values.decodeIfPresent([Tags].self, forKey: .tags)
    }
    
}

struct Messages_attributes : Codable {
    let author_id : String?
    let content : String?
    
    enum CodingKeys: String, CodingKey {
        case author_id = "author_id"
        case content = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author_id = try values.decodeIfPresent(String.self, forKey: .author_id)
        content = try values.decodeIfPresent(String.self, forKey: .content)
    }
    
    init(author_id : String?, content : String?) {
        self.author_id = author_id
        self.content = content
    }
    
}

struct PostTopic : Codable {
    let name : String?
    let kind: String?
    let messages_attributes: [Messages_attributes]?
    let language_id: String?
    let cursus_ids: [String]?
    let tag_ids : [String]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case kind = "kind"
        case messages_attributes = "messages_attributes"
        case language_id = "language_id"
        case cursus_ids = "cursus_ids"
        case tag_ids = "tag_ids"
    }
    
    init (name: String?, messages_attributes: [Messages_attributes]?) {
        self.name = name
        self.kind = "normal"
        self.messages_attributes = messages_attributes
        self.language_id = "1"
        self.cursus_ids = ["1"]
        self.tag_ids = ["574", "578"]
    }
}

struct SetTopic : Codable {
    let topic: PostTopic?
    
    enum CodingKeys: String, CodingKey {
        case topic = "topic"
    }
    
    init (topic: PostTopic?) {
        self.topic = topic
    }
}

