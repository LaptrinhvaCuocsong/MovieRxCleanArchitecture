//
//  MovieConfiguration.swift
//  Domain
//
//  Created by hungnm98 on 03/08/2022.
//

import Foundation

public struct MovieConfiguration: Codable {
    public init(images: MovieConfiguration.Images?) {
        self.images = images
    }

    public let images: Images?

    public struct Images: Codable {
        public init(baseURL: String?, secureBaseURL: String?, backdropSizes: [String]?, logoSizes: [String]?, posterSizes: [String]?, profileSizes: [String]?, stillSizes: [String]?) {
            self.baseURL = baseURL
            self.secureBaseURL = secureBaseURL
            self.backdropSizes = backdropSizes
            self.logoSizes = logoSizes
            self.posterSizes = posterSizes
            self.profileSizes = profileSizes
            self.stillSizes = stillSizes
        }

        public let baseURL: String?
        public let secureBaseURL: String?
        public let backdropSizes: [String]?
        public let logoSizes: [String]?
        public let posterSizes: [String]?
        public let profileSizes: [String]?
        public let stillSizes: [String]?
    }
}
