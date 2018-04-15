
import XCTest
@testable import SuddenDieGeneratorCore

class SuddenDieGeneratorTests: XCTestCase {
    
    private var generator: Generator!
    
    override func setUp() {
        
        super.setUp()
        
        generator = Generator("test")
    }
    
    
    func testGenerate() {
        
        XCTAssertEqual(generator.generate(), "＿人人人人＿\n＞　test　＜\n￣Y^Y^Y￣")
    }
}
