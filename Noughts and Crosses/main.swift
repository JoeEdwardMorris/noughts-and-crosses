import Foundation


let gameType = "game"
// test code

if (gameType == "game") {
    // set up text input/output modules
    var textInputOutput = TextInputOutput ()
    var keepPlaying = true



    var thisGame: Game
    
    var playerOneDesignation = "One"
    var playerTwoDesignation = "Two"
    
    var playerOneType = textInputOutput.playerType(playerOneDesignation)
    
    var playerTwoType = textInputOutput.playerType(playerTwoDesignation)

    var playerOneName = textInputOutput.playerQuestion(playerOneDesignation)

    var playerTwoName = textInputOutput.playerQuestion(playerTwoDesignation)
    
    var isPlayerOneHuman = true
    var isPlayerTwoHuman = true
    
    if playerOneType > 0 {
        isPlayerOneHuman = false
    }

    if playerTwoType > 0 {
        isPlayerTwoHuman = false
    }
    
    // Initialise players
    var playerOne = Player (name: playerOneName, isPlayerHuman: isPlayerOneHuman, playerValue: 1, playerType: playerOneType)

    var playerTwo = Player (name: playerTwoName, isPlayerHuman: isPlayerTwoHuman, playerValue: -1, playerType: playerTwoType)
    
    var playerArray = [playerOne, playerTwo]

    while (keepPlaying == true) {

        thisGame = Game (playerOne: playerArray[0], playerTwo: playerArray[1])

        thisGame.runGame()
        
        //swap players for next game
        swap(&playerArray[0], &playerArray[1])

        if (textInputOutput.anotherGameAnswer() == false) {
            keepPlaying = false
        }

    }
}

//if (gameType == "simulation") {
  //  var modelBoard = [[1,0,0], [-1,1,0], [-1,0,0]]
    //var simulation = Simulation(simulationBoard: modelBoard, simulatedPlayerValue: -1)
    //let bestMove = simulation.runSimulationStrategy(-5.0, drawScore: 0, distanceWeighting: 1)()
    //if let bestMoveUnwrapped = bestMove {
    //   print (bestMoveUnwrapped)
    //}
    //else {print ("no valid moves")}
    
//}



