import XCTest
import Domain
@testable import Application

class PokemonListInteractorTests: XCTestCase {
    
    // MARK: - Test doubles
    
    class FetchPokemonsSpy: FetchPokemons {
        var fetchCalled = false
        var completion: ((Result<[Pokemon], FetchError>) -> Void)?
        
        func fetch(offset: Int, completion: @escaping (Result<[Pokemon], FetchError>) -> Void) {
            fetchCalled = true
            self.completion = completion
        }
        
        func complete(withError error: FetchError) {
            self.completion?(.failure(error))
        }
        
        func complete(withPokemons pokemons: [Pokemon]) {
            self.completion?(.success(pokemons))
        }
    }
    
    class PokemonListPresentationLogicSpy: PokemonListPresentationLogic {
        var presentFetchPokemonsCalled = false
        
        func presentFetchPokemons(response: PokemonList.FetchPokemons.Response) {
            presentFetchPokemonsCalled = true
        }
    }
    
    // MARK: - Fetch Pokemons Tests
    
    func test_fetch_pokemons_should_ask_fetch_use_case_to_fetch() {
        let (sut, useCaseSpy, _) = makeSut()
        sut.fetchPokemons(request: PokemonList.FetchPokemons.Request(offset: 0))
        useCaseSpy.complete(withError: .errorFetchingData)
        XCTAssert(useCaseSpy.fetchCalled)
    }
    
    func test_fetch_pokemons_should_ask_presenter_to_output_response() {
        let (sut, useCaseSpy, presenterSpy) = makeSut()
        sut.fetchPokemons(request: PokemonList.FetchPokemons.Request(offset: 0))
        useCaseSpy.complete(withError: .errorFetchingData)
        XCTAssert(presenterSpy.presentFetchPokemonsCalled)
    }
}

extension PokemonListInteractorTests {
    func makeSut() -> (PokemonListInteractor, FetchPokemonsSpy, PokemonListPresentationLogicSpy) {
        let fetchPokemons = FetchPokemonsSpy()
        let presenterSpy = PokemonListPresentationLogicSpy()
        let sut = PokemonListInteractor(fetchPokemons: fetchPokemons)
        sut.presenter = presenterSpy
        return (sut, fetchPokemons, presenterSpy)
    }
}
