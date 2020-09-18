import XCTest
import Data
import Domain
import Infra

class GetPokemonsIntegrationTests: XCTestCase {
    func test_get_pokemons_references() {
        let urlSessionAdapter = URLSessionAdapter()
        let sut = RemoteFetchReferences(client: RequestObjectClient(client: urlSessionAdapter))
        
        let exp = expectation(description: "wait")
        sut.fetchReferences(offset: 10) { (result) in
            switch result {
            case .success(let references):
                XCTAssertFalse(references.results.isEmpty)
                
            case .failure: XCTFail("expecting success, got \(result)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_get_fetch_all_pokemons() {
        let urlSessionAdapter = URLSessionAdapter()
        let sut = RemoteFetchAllPokemons(client: RequestObjectClient(client: urlSessionAdapter))
        let refs = [
            Reference(name: "wobbuffet", url: "https://pokeapi.co/api/v2/pokemon/202/"),
            Reference(name: "girafarig", url: "https://pokeapi.co/api/v2/pokemon/203/"),
        ]
        
        let exp = expectation(description: "wait")
        sut.fetchAllPokemon(for: refs) { (result) in
            switch result {
            case .success(let pokemonList):
                XCTAssertFalse(pokemonList.filter { $0.name ==  "wobbuffet" }.isEmpty)
                
            case .failure: XCTFail("expecting success, got \(result)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_fetch_pokemons() {
        let urlSessionAdapter = URLSessionAdapter()
        let client = RequestObjectClient(client: urlSessionAdapter)
        
        let sut = RemoteFetchPokemons(fetchReferences: RemoteFetchReferences(client: client),
                                      fetchAllPokemons: RemoteFetchAllPokemons(client: client))
        
        let exp = expectation(description: "wait")
        sut.fetch(offset: 10) { (result) in
            switch result {
            case .success(let pokemons):
                XCTAssertFalse(pokemons.isEmpty)
                
            case .failure: XCTFail("expecting success, got \(result)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2.0)
    }
}
