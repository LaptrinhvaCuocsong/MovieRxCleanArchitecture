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
        public init(baseUrl: String?, secureBaseUrl: String?, backdropSizes: [String]?, logoSizes: [String]?, posterSizes: [String]?, profileSizes: [String]?, stillSizes: [String]?) {
            self.baseUrl = baseUrl
            self.secureBaseUrl = secureBaseUrl
            self.backdropSizes = backdropSizes
            self.logoSizes = logoSizes
            self.posterSizes = posterSizes
            self.profileSizes = profileSizes
            self.stillSizes = stillSizes
        }

        public let baseUrl: String?
        public let secureBaseUrl: String?
        public let backdropSizes: [String]?
        public let logoSizes: [String]?
        public let posterSizes: [String]?
        public let profileSizes: [String]?
        public let stillSizes: [String]?
    }
}
