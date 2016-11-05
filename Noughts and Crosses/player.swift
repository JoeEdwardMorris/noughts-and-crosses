import Foundation

class Player {
    
    let name: String //Any name
    let isPlayerHuman: Bool // True if human player, false if computer player
    let playerValue: Int
    let playerType: Int
    var score: Int
    
    // constructor methods
    init(name: String, isPlayerHuman: Bool, playerValue: Int, playerType: Int) {
        self.name = name
        self.isPlayerHuman = isPlayerHuman
        self.playerValue = playerValue
        self.score = 0
        self.playerType = playerType
    }
    
    // set methods
    func incrementScore () {
        score += 1
    }
    
    // get methods
    func getName() -> String {return name}
    func getisPlayerHuman () -> Bool {return isPlayerHuman}
    func getPlayerValue () -> Int {return playerValue}
    
    func getScore () -> Int {return score}
    
    func chooseStrategy (modelBoard: Array <Array <Int> >, playerValue: Int, strategy: Int) -> Int? {
        switch (strategy) {
        case (1): return generateMove1(modelBoard, playerValue: playerValue)
        case (2): return generateMove3(modelBoard, playerValue: playerValue)
        case (3): return generateMove5(modelBoard, playerValue: playerValue)
        case (4): return generateMoveHalf(modelBoard, playerValue: playerValue)
        case (5): return generateMoveOneDrawHalf(modelBoard, playerValue: playerValue)
        case (6): return generateMoveHalfDrawHalf(modelBoard, playerValue: playerValue)
        case (7): return generateMoveWeighting(modelBoard, playerValue: playerValue)
        case (8): return generateMoveWeighting2(modelBoard, playerValue: playerValue)
        case (9): return strategyRandom(modelBoard, playerValue: playerValue)
        default : return generateMove1(modelBoard, playerValue: playerValue)
        }
    }
    
    func strategyRandom (modelBoard: Array <Array <Int> >, playerValue: Int)  -> Int? {
        let simulation = Simulation(simulationBoard: modelBoard, simulatedPlayerValue: playerValue)
        let bestMove = simulation.runRandomStrategy()
        if let bestMoveUnwrapped = bestMove {
            return (bestMoveUnwrapped)
        }
        else {return nil}
    }


    func generateMove1 (modelBoard: Array <Array <Int> >, playerValue: Int) -> Int? {
        let simulation = Simulation(simulationBoard: modelBoard, simulatedPlayerValue: playerValue)
        let bestMove = simulation.runSimulationStrategy(-1, drawScore: 0, distanceWeighting: 0)
        if let bestMoveUnwrapped = bestMove {
            return (bestMoveUnwrapped)
        }
        else {return nil}
        
    }
    
    func generateMove3 (modelBoard: Array <Array <Int> >, playerValue: Int) -> Int? {
        let simulation = Simulation(simulationBoard: modelBoard, simulatedPlayerValue: playerValue)
        let bestMove = simulation.runSimulationStrategy(-3, drawScore: 0, distanceWeighting: 1)
        if let bestMoveUnwrapped = bestMove {
            return (bestMoveUnwrapped)
        }
        else {return nil}
        
    }
    
    func generateMove5 (modelBoard: Array <Array <Int> >, playerValue: Int) -> Int? {
        let simulation = Simulation(simulationBoard: modelBoard, simulatedPlayerValue: playerValue)
        let bestMove = simulation.runSimulationStrategy(-5, drawScore: 0, distanceWeighting: 1)
        if let bestMoveUnwrapped = bestMove {
            return (bestMoveUnwrapped)
        }
        else {return nil}
        
    }
    
    func generateMoveHalf (modelBoard: Array <Array <Int> >, playerValue: Int) -> Int? {
        let simulation = Simulation(simulationBoard: modelBoard, simulatedPlayerValue: playerValue)
        let bestMove = simulation.runSimulationStrategy(-0.5, drawScore: 0, distanceWeighting: 1)
        if let bestMoveUnwrapped = bestMove {
            return (bestMoveUnwrapped)
        }
        else {return nil}
        
    }
    
    func generateMoveOneDrawHalf (modelBoard: Array <Array <Int> >, playerValue: Int) -> Int? {
        let simulation = Simulation(simulationBoard: modelBoard, simulatedPlayerValue: playerValue)
        let bestMove = simulation.runSimulationStrategy(-1, drawScore: 0.5, distanceWeighting: 1)
        if let bestMoveUnwrapped = bestMove {
            return (bestMoveUnwrapped)
        }
        else {return nil}
    }
    
    func generateMoveHalfDrawHalf (modelBoard: Array <Array <Int> >, playerValue: Int) -> Int? {
        let simulation = Simulation(simulationBoard: modelBoard, simulatedPlayerValue: playerValue)
        let bestMove = simulation.runSimulationStrategy(-0.5, drawScore: 0.5, distanceWeighting: 1)
        if let bestMoveUnwrapped = bestMove {
            return (bestMoveUnwrapped)
        }
        else {return nil}
        
    }
    
    func generateMoveWeighting (modelBoard: Array <Array <Int> >, playerValue: Int) -> Int? {
        let simulation = Simulation(simulationBoard: modelBoard, simulatedPlayerValue: playerValue)
        let bestMove = simulation.runSimulationStrategy(-5, drawScore: 0, distanceWeighting: 1)
        if let bestMoveUnwrapped = bestMove {
            return (bestMoveUnwrapped)
        }
        else {return nil}
        
    }
    
    func generateMoveWeighting2 (modelBoard: Array <Array <Int> >, playerValue: Int) -> Int? {
        let simulation = Simulation(simulationBoard: modelBoard, simulatedPlayerValue: playerValue)
        let bestMove = simulation.runSimulationStrategy(-1, drawScore: 0, distanceWeighting: 2)
        if let bestMoveUnwrapped = bestMove {
            return (bestMoveUnwrapped)
        }
        else {return nil}
        
    }
    
}
