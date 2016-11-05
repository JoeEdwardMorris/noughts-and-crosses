import Foundation

class Game {
    
    let playerOne: Player
    let playerTwo: Player
    
    var isThereAWinnerOrDraw = false
    
    var textInputOutput = TextInputOutput ()
    
    // Initialise board (both version to output (physical) and version used for game mechanics (model))
    var physicalBoard = PhysicalBoard ()
    var modelBoard = ModelBoard ()
    
    // Constructor
    
    init (playerOne: Player, playerTwo: Player) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo        
    }

    // Things that happen in a player's turn -
    func playersTurn (player: Player) {
        
        let thisMove: Int
        let playerName = player.getName()
        
        textInputOutput.newTurnMessage(playerName) // Player's 'your turn' message
        
        if (player.getisPlayerHuman() == true) { // if human player, get input for move
            thisMove = textInputOutput.humanPlayerTextInput(modelBoard)
        }
        else { // If computer program run computer strategies to return a move
            print ("\(playerName) is thinking... (all \(playerName)s think a lot :) )")
            let wrappedMove = player.chooseStrategy(modelBoard.modelBoard, playerValue: player.getPlayerValue(), strategy: player.playerType)
            if let unwrappedMove = wrappedMove {
                thisMove = unwrappedMove
            }
            else { // TODO - make this error handling robust somehow!
                print ("error")
                thisMove = 0
            }
        }
        
        modelBoard.updateModelWithMove(thisMove, playerValue: player.getPlayerValue())
        
        physicalBoard.updatePhysicalWithMove(thisMove, playerValue: player.getPlayerValue(), modelBoard: modelBoard)
        
        physicalBoard.printBoard()
        
        if (modelBoard.hasPlayerWon(player.getPlayerValue())) {
            textInputOutput.winMessage(player.getName())
            player.incrementScore()
            isThereAWinnerOrDraw = true
        }
            
        else if (modelBoard.areAnyMovesAllowed() == false) {
            textInputOutput.drawMessage()
            isThereAWinnerOrDraw = true
        }
        
    }
    
    func runGame () {
        gameSetup()
        gameLoop()
        gameExit()
    }
    
    func gameSetup () {
        physicalBoard.printBoard()
    }
    
    func gameLoop () {
        while (isThereAWinnerOrDraw == false) {
            playersTurn (playerOne)
            if (isThereAWinnerOrDraw == true) {break}
                playersTurn (playerTwo)
        }
    }

    func gameExit () {
        textInputOutput.declareScore(playerOne, playerTwo: playerTwo)
        print ("\n")
    }
}
