import Data
import Domain
import XCTest

class RemoteFetchPokemonsTests: XCTestCase {
    func test_fetch_should_completes_with_error_when_requester_completes_with_request_error() {
        let (sut, requestSpy) = makeSut()
        expect(sut, completeWith: .failure(.errorFetchingData), when: {
            requestSpy.complete(withError: .requestFailed)
        })
    }
    
    func test_fetch_should_completes_with_error_when_requester_completes_with_failed_request() {
        let (sut, requestSpy) = makeSut()
        expect(sut, completeWith: .failure(.errorFetchingData), when: {
            requestSpy.complete(withError: .requestFailed)
        })
    }
    
    func test_fetch_should_completes_with_error_when_requester_completes_with_parsing_error() {
        let (sut, requestSpy) = makeSut()
        expect(sut, completeWith: .failure(.errorFetchingData), when: {
            requestSpy.complete(withError: .jsonParsingFailure)
        })
    }
    
    func test_fetch_should_completesn_with_pokemons_when_requester_completes_with_data() {
        let (sut, requestSpy) = makeSut()
        expect(sut, completeWith: .success([makePokemon()]), when: {
            requestSpy.complete(withList: makePokemonListModel())
            requestSpy.complete(withPokemon: makePokemon())
        })
    }
    
    func test_fetch_should_completesn_with_error_when_requester_completes_with_invalid_data() {
        let (sut, requestSpy) = makeSut()
        expect(sut, completeWith: .failure(.errorFetchingData), when: {
            requestSpy.complete(withList: makeEmptyPokemonListModel())
        })
    }
    
    func test_fetch_should_not_complete_when_sut_is_deallocated() {
        let requesterSpy = RequestObjectSpy()
        let fetchReference = RemoteFetchReferences(client: requesterSpy)
        let fetchAllPokemons = RemoteFetchAllPokemons(client: requesterSpy)
        var sut: RemoteFetchPokemons? = RemoteFetchPokemons(fetchReferences: fetchReference, fetchAllPokemons: fetchAllPokemons)
        var receivedResult: Result<[Pokemon], FetchError>?
        
        sut?.fetch(offset: 0) { receivedResult = $0 }
        sut = nil
        
        requesterSpy.complete(withError: .requestFailed)
        XCTAssertNil(receivedResult)
    }
}

extension RemoteFetchPokemonsTests {
    
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: RemoteFetchPokemons, httpClientSpy: RequestObjectSpy) {
        let requesterSpy = RequestObjectSpy()
        let fetchReference = RemoteFetchReferences(client: requesterSpy)
        let fetchAllPokemons = RemoteFetchAllPokemons(client: requesterSpy)
        let sut = RemoteFetchPokemons(fetchReferences: fetchReference, fetchAllPokemons: fetchAllPokemons)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: requesterSpy, file: file, line: line)
        return (sut, requesterSpy)
    }
    
    func expect(_ sut: RemoteFetchPokemons, completeWith expectedResult: Result<[Pokemon], FetchError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let expect = expectation(description: "wait")
        sut.fetch(offset: 0) { receivedResult in
            switch (expectedResult, receivedResult) {
            
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedPokemonList), .success(let receivedPokemonList)):
                XCTAssertEqual(expectedPokemonList, receivedPokemonList, file: file, line: line)

            default: XCTFail("expecting \(expectedResult), got \(receivedResult)", file: file, line: line)
            }
            expect.fulfill()
        }
        action()
        wait(for: [expect], timeout: 1.0)
    }
}
