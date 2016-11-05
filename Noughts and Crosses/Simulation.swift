import Foundation

// Contains information for running a set of simulations to return optimum best next move

class Simulation {
    
    var simulationBoard: Array <Array<Int>>
    
    let simulatedPlayerValue: Int
    
    let unusedSpace = 0
    
    var winLoseRatio = -5.0
    
    var loseScore = -5.0
    
    var drawScore = 0.0
    
    var winScore = 1.0
    
    var distanceWeighting = 1.0
    
    init (simulationBoard: Array <Array <Int> >, simulatedPlayerValue: Int) {
        self.simulationBoard = simulationBoard
        self.simulatedPlayerValue = simulatedPlayerValue
    }
    
    // Take model board, run all possible remaining games and return optimum move or nil if no move possible
    
    func runSimulationStrategy (winLoseRatio: Double, drawScore: Double, distanceWeighting: Double) -> Int? {
        self.winLoseRatio = winLoseRatio
        self.drawScore = drawScore
        loseScore = winScore * winLoseRatio
        self.distanceWeighting = distanceWeighting
        // produce set containing all of the remaining available moves by space number
        let unusedSpacesSet = generateUnusedSpacesSet()
        if (unusedSpacesSet.isEmpty) { //If the set of available moves is empty no simulation can run
            return nil // so we return nil
        }
        //Now we need to generate every permutation of moves in the set and run it!
        //We need a function in to which we can send a set and get back a multidimensional array of all permutations...
        let allPossibleGames = setPermutationsAsArray (unusedSpacesSet)
        // Now we send our array of all possible moves to be played and evaluated and get back our suggested next move...
        let gameScoreDictionary = runAllPossibleGames (allPossibleGames)
        // Then we return a move depending on the analysis of the dictionary
        if let moveAdvice = scoreAnalysisFirstOptimum (gameScoreDictionary) {
            return moveAdvice
        }
        else {
            return nil
        }
    }
    
    func runRandomStrategy () -> Int? {
        // produce set containing all of the remaining available moves by space number
        let unusedSpacesSet = generateUnusedSpacesSet()
        if (unusedSpacesSet.isEmpty) { //If the set of available moves is empty no simulation can run
            return nil // so we return nil
        }
        let unusedSpacesArray = Array(unusedSpacesSet)
        let randomIndex = Int(arc4random_uniform(UInt32(unusedSpacesArray.count)))
        let moveAdvice = unusedSpacesArray[randomIndex]
        return moveAdvice
    }
    
    // takes the simulation's simulationBoard and returns a set containing remaining valid moves
    func generateUnusedSpacesSet () -> Set <Int> {
        // place array grid into one dimensional array
        var oneDimensionalBoard = simulationBoard[0] + simulationBoard[1] + simulationBoard[2]
        // Initialise a set to contain numberRefs (0-8) of unused spaces on board
        var unusedSpaces: Set<Int> = [-1] //(Initialises with -1 to remove later)
        let boardSquareRange = Range (0...8) // Sets range to number of board positions
        for i in (boardSquareRange) {
            if (oneDimensionalBoard[i] == unusedSpace) {
                unusedSpaces.insert(i)
            }
        }
        unusedSpaces.remove (-1) //removes -1 that was used to initialise set
        // We now have a set containing remaining board positions
        return unusedSpaces
    }

    // Takes a set of moves and returns a 2-D array containing all permutations of that set
    func setPermutationsAsArray (setToPermutate: Set <Int> ) -> Array<Array<Int>> {
        //convert to array
        var arrayToPermutate = Array(setToPermutate)
        // Initialise 2-D array used for output
        var arrayToOutput = Array<Array<Int>> ()
        
        // Nested function to calculate all permutations and append to output array
        func calcPermutations(n:Int, inout _ a:Array<Int>) {
            if n == 1 {arrayToOutput.append(a); return}
            for i in 0..<n-1 {
                calcPermutations(n-1,&a)
                swap(&a[n-1], &a[(n%2 == 1) ? 0 : i])
            }
            calcPermutations(n-1,&a)
        }
        
        calcPermutations (arrayToPermutate.count,&arrayToPermutate)
        return arrayToOutput
        
    }
    
    // Takes a 2-D array of all permutations of moves, plays through each set of moves and returns a dictionary with
    // a score for each move
    func runAllPossibleGames (allPossibleGames: Array <Array <Int > >) -> Dictionary <Int, Double> {
        let numberOfGames = allPossibleGames.count // find total number of games
        //let numberOfGamesRange = (0...(numberOfGames-1))
        let firstGame = allPossibleGames[0]
        var scoresForEachMove = [Int: Double]() // Initialise dictionary to contain a score for each available move
        //Populate the dictionary with keys for each possible move
        for i in 0..<firstGame.count {
            scoresForEachMove[firstGame[i]] = 0
        }
        // Run through each game in turn
        for i in 0..<numberOfGames {
            let thisGame = allPossibleGames[i]
            // Run this game and return a score
            let scoreForGame = runSimulatedGame (thisGame, simulatedPlayerValue: simulatedPlayerValue)
            // find first move of this game
            let firstMove = thisGame[0]
            // add the score to the accumulated score for the first move's dictionary element
            if let currentScore = scoresForEachMove[firstMove] {
                scoresForEachMove[firstMove] = currentScore + scoreForGame
            }
            
            
        }
        return scoresForEachMove
        
    }
    
    //
    func runSimulatedGame (thisGame: Array <Int>, simulatedPlayerValue: Int) -> Double {
        //let loseScore = -5 // Initialise values to be returned for losing,
        //let drawScore = 0 // drawing,
        //let winScore = 1 // and winning. Declared here so we can change these easily to experiment.
        let simulatedOppositionValue = simulatedPlayerValue * -1 // Produces opposite value for other player
        let thisGameBoard = ModelBoard () // produce board model object to run this game on
        thisGameBoard.modelBoard = simulationBoard // Set board with simulation starting conditions
        let gameLength = thisGame.count
        
        
        // Main game loop iterating through number of moves in array, 
        // alternating between simulated player and their opposition
        for i in 0..<gameLength {
            let scoreBonus = Double(gameLength-i) // adds bonus that decreases every turn
            if (i % 2 == 0) { // If turn number is even then it is the simulated player's turn
                thisGameBoard.updateModelWithMove(thisGame[i], playerValue: simulatedPlayerValue)
                if (thisGameBoard.hasPlayerWon(simulatedPlayerValue) == true) {
                    return winScore+((scoreBonus)*distanceWeighting) // If player has won, return
                }
            }
            else { // If turn number is odd then it is the simulated opposition's turn
                thisGameBoard.updateModelWithMove(thisGame[i], playerValue: simulatedOppositionValue)
                if (thisGameBoard.hasPlayerWon(simulatedOppositionValue) == true) {
                    return loseScore+((scoreBonus)*distanceWeighting)
                }
            }
        }
        return drawScore
        
    }
    
    func scoreAnalysisFirstOptimum (gameScoreDictionary: Dictionary <Int, Double>) -> Int? {
        for (key, value) in gameScoreDictionary {
            if value == gameScoreDictionary.values.maxElement() {
                return key
            }
        }
        
        return nil
    }

}

    