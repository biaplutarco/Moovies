//
//  MoviesViewModelTests.swift
//  MooviesTests
//
//  Created by aluno on 18/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import XCTest
@testable import Moovies

class FavoriteViewModelTests: XCTestCase {
    var favoriteViewModel: FavoriteViewModel!

    override func setUp() {
        favoriteViewModel = FavoriteViewModel()
    }

    override func tearDown() {
        favoriteViewModel = nil
    }

    func test_createMovie_return_movie() {
        let favoriteMovie = FavoriteMovie(context: FavoriteMovie.context)
        favoriteMovie.id = Int32(42)
        favoriteMovie.title = "filme de teste"
        favoriteMovie.overview = "esse filme foi criado para fins de teste"
        
        let mockMovie = Movie(id: 42, title: "filme de teste",
                              overview: "esse filme foi criado para fins de teste",
                              posterPath: nil)
        let movie = favoriteViewModel.createMovie(from: favoriteMovie)
        
        XCTAssertTrue(movie == mockMovie)
    }

    func test_createMovie_return_nil() {
        let favoriteMovie = FavoriteMovie(context: FavoriteMovie.context)
        favoriteMovie.id = Int32(42)
        
        let movie = favoriteViewModel.createMovie(from: favoriteMovie)
        
        XCTAssertNil(movie)
    }
}
