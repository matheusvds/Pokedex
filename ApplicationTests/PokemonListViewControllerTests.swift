@testable import Application
@testable import UI
import XCTest

class PokemonListViewControllerTests: XCTestCase {
    
    var sut: PokemonListViewController!
    var window: UIWindow!
    
    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: - Test setup
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Test Doubles
    
    class PokemonListViewLogicSpy: PokemonListViewLogic {
        var view: UIView { return UIView () }
        var selectedRow: Int? = 0
        var setViewModelCalled = false
        var viewModel: PokemonListViewModel?
        
        func set(viewModel: PokemonListViewModel) {
            setViewModelCalled = true
            self.viewModel = viewModel
        }
        
        func getSelectedRow() -> Int? {
            return selectedRow
        }
    }
    
    class PokemonListBusinessLogicSpy: PokemonListBusinessLogic {
        var fetchPokemonsCalled = false
        
        func fetchPokemons(request: PokemonList.FetchPokemons.Request) {
            fetchPokemonsCalled = true
        }
    }
    
    class PokemonListRoutingLogicSpy: PokemonListRoutingLogic, PokemonListDataPassing {
        var dataStore: PokemonListDataStore?
        
        var routeToPokemonDetailCalled = false
        
        func routeToPokemonDetail() {
            routeToPokemonDetailCalled = true
        }
    }
    
    // MARK: - Tests
    
    func test_should_fetch_pokemons_when_view_loads() {
        let (sut, _, businessLogicSpy, _) = makeSut()
        loadView()
        sut.viewDidLoad()
        
        XCTAssert(businessLogicSpy.fetchPokemonsCalled)
    }
    
    func test_display_pokemons_should_set_view_logic_viewmodel() {
        let (sut, viewLogicSpy, _, _) = makeSut()
        sut.displayFetchPokemons(viewModel: PokemonList.FetchPokemons.ViewModel(pokemons: [makeDisplayedPokemon()]))
        
        XCTAssert(viewLogicSpy.setViewModelCalled)
    }
    
    func test_display_pokemons_should_not_set_view_logic_when_viewModel_has_nil_data() {
        let (sut, viewLogicSpy, _, _) = makeSut()
        sut.displayFetchPokemons(viewModel: PokemonList.FetchPokemons.ViewModel(pokemons: nil))
        
        XCTAssertFalse(viewLogicSpy.setViewModelCalled)
    }
    
    func test_select_pokemon_should_route_to_pokemon_detail() {
        let (sut, _, _, routerSpy) = makeSut()
        sut.didSelectRow()
        
        XCTAssert(routerSpy.routeToPokemonDetailCalled)
    }
}

extension PokemonListViewControllerTests {
    func makeSut() -> (PokemonListViewController, PokemonListViewLogicSpy, PokemonListBusinessLogicSpy, PokemonListRoutingLogicSpy)  {
        let viewLogicSpy = PokemonListViewLogicSpy()
        let businessLogicSpy = PokemonListBusinessLogicSpy()
        let routingLogicSpy = PokemonListRoutingLogicSpy()
        sut = PokemonListViewController(viewLogic: viewLogicSpy, interactor: businessLogicSpy, router: routingLogicSpy)

        return (sut, viewLogicSpy, businessLogicSpy, routingLogicSpy)
    }
}
