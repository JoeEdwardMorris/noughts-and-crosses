import Foundation

// This could be a static class really - handles all text based inputs and outputs and could be 
// Replaced by a graphic user interface. only carries out functions - doesn't hold variables accessible
// to rest of program. MAYBE LOOK INTO CONVERTING WHEN KNOW MORE ABOUT SWIFT?

class TextInputOutput {
    
    init () {
        
    }
    
    func declareScore (playerOne: Player, playerTwo: Player) {
        let playerOneName = playerOne.getName()
        let playerOneScore = playerOne.getScore()
        let playerTwoName = playerTwo.getName()
        let playerTwoScore = playerTwo.getScore()
        print ("\n")
        print ("Score: \(playerOneName) \(playerOneScore) \(playerTwoName) \(playerTwoScore)")
    }

    func newTurnMessage (playerName: String) {
        // When it's a player's turn.
        print ("It is \(playerName)'s turn.")
    }

    func winMessage (playerName: String) {
        // When a player wins...
        print ("\(playerName) has won! Congratulations.")
    }

    func drawMessage () {
        // When it's a draw...
        print("It is a draw!")
    }
    
    func playerType (playerNumber: String) -> Int {
        let validAnswer = false
        print ("\n")
        print ("Please enter Player \(playerNumber)'s type.")
        print ("0 = Human, 1 - 9 = Computer strategies")
        let playerErrorMessage = "That answer is not allowed. Please try again!:"
        // repeats following section until valid input is produced
        while (validAnswer == false) { // Repeat while a valid move has not been produced
            let inputAsInt: Int? = Int(input()) // Get user input as optional integer
            if let inputUnwrapped = inputAsInt { // Unwrap input
                let finalInput = inputUnwrapped
                if (0...9 ~= finalInput) { // If unwrappable, is input a valid move?
                    return finalInput // If so then return the move made
                }
            }
            print (playerErrorMessage) // If not, print request for another move and repeat
        }
    }
    
    func playerQuestion (playerNumber: String) -> String {
        print ("\n")
        print ("Please enter Player \(playerNumber)'s name:")
        let userInput = input() // Get user input
        print ("\n")
        return userInput
    }
    
    func anotherGameAnswer () -> Bool {
        print ("\n")
        print ("Play another game? (Y/N)")
        let userInput = input() // Get user input
        if (userInput.uppercaseString == "Y" )  { //is input 'Y or y'?
            return true // If so then return true
        }
        else {
            return false
        }
        
    }

    func humanPlayerTextInput (modelBoard: ModelBoard) -> Int {
        // Handles the user input for the game on command line - takes text input,
        // ensures that the input represents a valid move, if not,
        // requests more input until a valid move is achieved
        // Rewuires the baord object in question to be specified.
        
        // Set initial values
        let playerInputMessage = "Please input a grid number to place your piece:"
        let playerErrorMessage = "That move is not allowed. Please try again!:"
        let validMoveMade = false
        
        //Prints initial message
        print (playerInputMessage) // prints this message once
        // repeats following section until valid input is produced
        while (validMoveMade == false) { // Repeat while a valid move has not been produced
            let inputAsInt: Int? = Int(input()) // Get user input as optional integer
            if let inputUnwrapped = inputAsInt { // Unwrap input
                let finalInput = inputUnwrapped - 1 // Turns 1-9 grid (for the user) to 0-8 (for prog) (as suggested by R)
                if (modelBoard.isMoveAllowed(finalInput)==true) { // If unwrappable, is input a valid move?
                    return finalInput // If so then return the move made
                }
            }
            print (playerErrorMessage) // If not, print request for another move and repeat
        }
        
    }


    func input() -> String {
        // User input code taken from Ray Wenderlich 'Swift Apprentice'
        let keyboard = NSFileHandle.fileHandleWithStandardInput()
        let inputData = keyboard.availableData
        let rawString = NSString(data: inputData, encoding:NSUTF8StringEncoding)
        if let string = rawString {
            return string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        } else {
            return "Invalid input"
        }
    }

}


