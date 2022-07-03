//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by hungnm98 on 06/06/2022.
//

import Domain
import Foundation

final class NetworkProvider {
    func makeMoviesNetwork() -> MoviesNetwork {
        return MoviesNetwork(network: Network<Movies>())
    }
}
