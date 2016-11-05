// Contains the code for the graphical output of the board.
// This is a command line text version but could be swapped for a graphical version
// so needs to be kept modular with that in mind!

import Foundation

class PhysicalBoard {

    let boardDictionary = [-1: "X", 1: "O"]

    // var physicalBoard = [["0","1","2"],["3","4","5"],["6","7","8"]]
    var physicalBoard = [[".",".","."],[".",".","."],[".",".","."]]

    init () {
        
    }
    
    func updatePhysicalWithMove (thisMove: Int, playerValue: Int, modelBoard: ModelBoard) {
        // takes move location and player value and updates board model using grid ref convertor and model move function
        let thisMoveCoordinates = modelBoard.convertNumRefToGridRef (thisMove) // takes converted coordinates
        physicalMove (thisMoveCoordinates.xCoordinate, by: thisMoveCoordinates.yCoordinate, with: playerValue) // updates physical board
    }

    func physicalMove (xCoordinate: Int, by yCoordinate: Int, with playerValue: Int) {
        // Updates physical board with new string value
        // at given co-ordinate depending on playerValue (each player has a value)
        // Part A: find correct string to add from input and dictionary
        let newMoveString = boardDictionary[playerValue]
        // Part B: add string to correct co-ordinate and raise error if does not exist
        if let newMoveString = newMoveString {
            physicalBoard [yCoordinate][xCoordinate] = newMoveString
        }
        else {print ("error: player value does not exist in board dictionary")}
        
        
    }

    func printBoard () {
        // Prints current state of board
        print ("\n")
        for i in (0...2) {
            printRow (physicalBoard[i])
        }
        print ("\n")
    }

    func printRow (physicalRow: Array <String>) {
        // Prints rows of board (called by printBoard)
        var rowString = physicalRow[0]
        for i in (1...2) {
            rowString += "|"
            rowString += physicalRow[i]
        }
        print(rowString)
    }

}