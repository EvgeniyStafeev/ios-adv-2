//
//  ProfilePostModel.swift
//  Navigation
//
//  Created by Евгений Стафеев on 20.11.2022.
//

import Foundation
public struct ProfilePostModel: Codable {
    public var author: String
    public var postDescription: String
    public var image: String
    public var likes: Int
    public var views: Int
    
    
    public static let posts = [
        ProfilePostModel(author: "В Мире Животных", postDescription: "Котик", image: "krasivye-kartinki-kotov-31", likes: 2, views: 12),
        ProfilePostModel(author: "Ждун", postDescription: "Ждун-Ждуныч", image: "5631", likes: 5, views: 1112)
    ]
}
