//
//  Article.swift
//  TheNews
//
//  Created by manjil on 11/5/20.
//

import Foundation

//"source": {
//"id": "the-washington-post",
//"name": "The Washington Post"
//},
//"author": "Beth Reinhard, Lori Rozsa",
//"title": "Miami-Dade Hispanics helped sink Biden in Florida - The Washington Post",
//"description": "President Trump boasted a stronger ground game and message in a county where Democrats had a big margin in 2016.",
//"url": "https://www.washingtonpost.com/politics/biden-miami-dade-vote-drop/2020/11/04/ec06f13e-1ebd-11eb-ba21-f2f001f0554b_story.html",
//"urlToImage": "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/XY7FTUQ6JYI6XLKTJQP5USMQPU.jpg&w=1440",
//"publishedAt": "2020-11-05T01:49:00Z",
//"content": "Biden drew far fewer Hispanic voters than Democrats expected, carrying Floridas most populous county of Miami-Dade by only seven percentage points, compared with the 30-point margin boasted by Democr… [+7713 chars]"
struct Article: Codable {
    var source: Source
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String
    
    
    init(from decoder: Decoder) throws {
        let  container = try decoder.container(keyedBy: CodingKeys.self)
        source =  try container.decodeIfPresent(Source.self, forKey: .source) ?? Source()
        author =  try container.decodeIfPresent(String.self, forKey: .author) ?? ""
        title =  try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        description =  try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        url =  try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        urlToImage =  try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
        publishedAt =  try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        content =  try container.decodeIfPresent(String.self, forKey: .content) ?? ""
    }
}

struct Source: Codable {
    var identifer: String
    var name: String
    
    enum CodeKeys: String, CodingKey {
        case identifer = "id"
        case name
    }
    
    init() {
        identifer = ""
        name = ""
    }
    
    init(from decoder: Decoder) throws {
        let  container = try decoder.container(keyedBy: CodeKeys.self)
        identifer =  try container.decodeIfPresent(String.self, forKey: .identifer) ?? ""
        name =  try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
