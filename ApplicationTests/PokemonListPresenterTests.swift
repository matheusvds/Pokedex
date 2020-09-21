import XCTest
@testable import Application

class PokemonListPresenterTests: XCTestCase {
    
    // MARK: Test doubles
    
    class PokemonListDisplayLogicSpy: PokemonListDisplayLogic {
        var displayFetchedPokemonsCalled = false
        var fetchPokemonsViewModel: PokemonList.FetchPokemons.ViewModel?
        
        func displayFetchPokemons(viewModel: PokemonList.FetchPokemons.ViewModel) {
            displayFetchedPokemonsCalled = true
            fetchPokemonsViewModel = viewModel
        }
    }
    
    // MARK: - Fetch Pokemons Tests

    func test_present_fetched_pokemons_should_ask_display_logic_to_output_viewmodel() {
        let (sut, displayLogicSpy) = makeSut()
        
        sut.presentFetchPokemons(response: PokemonList.FetchPokemons.Response(pokemons: []))
        
        XCTAssert(displayLogicSpy.displayFetchedPokemonsCalled, "displayFetchPokemons should be called")
    }
    
    func test_present_fetch_pokemons_should_display_formatted_viewmodel() {
        let (sut, displayLogicSpy) = makeSut()
        
        let pokemons = [makePokemon()]
        sut.presentFetchPokemons(response: PokemonList.FetchPokemons.Response(pokemons: pokemons))
        
        displayLogicSpy.fetchPokemonsViewModel?.pokemons?.forEach { pokemon in
            XCTAssertEqual(pokemon.name, "Bulbasaur 65")
            XCTAssertEqual(pokemon.firstType, "grass")
            XCTAssertEqual(pokemon.secType, nil)
            XCTAssertEqual(pokemon.image, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")
        }
    }
}

extension PokemonListPresenterTests {
    func makeSut() -> (PokemonListPresenter, PokemonListDisplayLogicSpy) {
        let displayLogicSpy = PokemonListDisplayLogicSpy()
        let sut = PokemonListPresenter()
        sut.displayLogic = displayLogicSpy
        return (sut, displayLogicSpy)
    }
}
