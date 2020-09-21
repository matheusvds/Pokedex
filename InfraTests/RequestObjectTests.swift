import Foundation
import XCTest
import Infra
import Data

class RequestObjectTests: XCTestCase {
    
    func test_fetch_should_complete_with_success_when_client_completes_with_valid_data() {
        let (sut, spy) = makeSut()
        let expectedData = makeValidData()
        let expectedObject = try! JSONDecoder().decode(DummyDecodable.self, from: expectedData)
        expect(sut, completeWith: .success(expectedObject), when: {
            spy.complete(withData: expectedData)
        })
    }
    
    func test_fetch_should_complete_with_error_when_client_completes_with_invalid_data() {
        let (sut, spy) = makeSut()
        let invalidData = makeInvalidData()
        expect(sut, completeWith: .failure(.jsonParsingFailure), when: {
            spy.complete(withData: invalidData)
        })
    }
    
    func test_fetch_should_complete_with_error_when_client_completes_with_nil_data() {
        let (sut, spy) = makeSut()
        expect(sut, completeWith: .failure(.responseUnsuccessful), when: {
            spy.completeWithNilData()
        })
    }
    
    func test_fetch_should_complete_with_error_when_client_completes_with_error() {
        let (sut, spy) = makeSut()
        expect(sut, completeWith: .failure(.requestFailed), when: {
            spy.complete(withError: .badRequest)
        })
    }
}

extension RequestObjectTests {
    func makeSut() -> (RequestObject, HttpClientSpy) {
        let spy = HttpClientSpy()
        let sut = RequestObjectClient(client: spy)
        return (sut, spy)
    }
    
    func expect(_ sut: RequestObject, completeWith expectedResult: Result<DummyDecodable, RequestError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let expect = expectation(description: "wait")
        sut.fetch(with: URLRequest(url: makeDummyURL())) { (receivedResult: Result<DummyDecodable, RequestError>) in
            switch (expectedResult, receivedResult) {
            
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedObject), .success(let receivedObject)):
                XCTAssertEqual(expectedObject, receivedObject, file: file, line: line)

            default: XCTFail("expecting \(expectedResult), got \(receivedResult)", file: file, line: line)
            }
            expect.fulfill()
        }
        action()
        wait(for: [expect], timeout: 1.0)
    }
}
