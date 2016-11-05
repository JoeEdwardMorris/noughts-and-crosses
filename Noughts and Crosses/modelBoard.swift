import Foundation

class ModelBoard {

    var modelBoard = [[0,0,0], [0,0,0], [0,0,0]]
    
    init () {
    // initialises blank playing board. We don't need any params as this will always be an empty 3x3 grid.
    }
    
    func isMoveAllowed (thisMove: Int) -> Bool {
        // Takes move number and determines if valid - between 0-8 and not already taken by a piece.
        // Returns true if it is allowed and false if it isn't.
        
        let emptySquare = 0 // initialise what an empty square is in grid (only places a valid move can be made)
        // A: Check if out of range (0-8)
        if (thisMove < 0 || thisMove > 8) {return false}
        // B: Convert to Coordinates
        var thisMoveCoordinates = (xCoordinate: 0, yCoordinate: 0) // Initialise the tuple for this move's coordinates
        thisMoveCoordinates = convertNumRefToGridRef (thisMove) // Use function that converts input to Coords
        if (modelBoard[thisMoveCoordinates.yCoordinate][thisMoveCoordinates.xCoordinate]==emptySquare) {
            return true // If position on board model contains emptySquare value then move is allowed
        }
        else {
            return false // If it contains any other value it isn't allowed
        }
    }
    
    func areAnyMovesAllowed () -> Bool {
        //tests if there are any valid moves in order to see if we have reached a draw
        for i in (0...8) {
            if (isMoveAllowed(i)) {
                return true
            }
        }
        return false
    }

    func updateModelWithMove (thisMove: Int, playerValue: Int) {
        // takes move location and player value and updates board model using grid ref convertor and model move function
        let thisMoveCoordinates = convertNumRefToGridRef (thisMove) // takes converted coordinates
        modelMove (thisMoveCoordinates.xCoordinate, by: thisMoveCoordinates.yCoordinate, with: playerValue) // updates model
    }
    
    func modelMove (xCoordinate: Int, by yCoordinate: Int, with playerValue: Int) {
        // Updates game model board with new Integer value
        // at given co-ordinate depending on playerValue (each player has a value)
        modelBoard [yCoordinate][xCoordinate] = playerValue
    }

    func convertNumRefToGridRef (numRef: Int) -> (xCoordinate: Int, yCoordinate: Int) {
        // Takes a number between 0-8 to represent the 9 squares of board
        // with 0-2 top row left to right, 3-5 middle and 6-8 bottom.
        // Returns an x, y grid reference with top left as 0,0.
        let gridColumns = 3
        let yCoordinate = numRef / gridColumns
        let xCoordinate = numRef % gridColumns
        return (xCoordinate, yCoordinate)
    }

    func hasPlayerWon (playerValue: Int) -> Bool {
        // scans through model by rows, colums and diagonals to find if we have three in a row
        // (calculated by 3x playerValue)
        
        let sumToWin = playerValue * 3
        //ROWS
        var rowSum = 0
        for xCoordinate in (0...2) {
            rowSum = modelBoard[xCoordinate].reduce(0, combine: +) // uses .reduce to sum row elements
            if (rowSum == sumToWin) {return true} // if sum of row equals winning sum, player has won
        }
        
        //COLUMNS
        var columnSum = 0 // initialise new sum for column
        for xCoordinate in (0...2) { //cycle through row positions from left to right
            columnSum = 0
            for yCoordinate in (0...2) { //cycle through each position of the column from top to bottom
                columnSum += modelBoard[yCoordinate][xCoordinate] //increment sum of column
            }
            if (columnSum == sumToWin) {return true} // if sum of column equals winning sum, player has won
        }
        
        //FORWARD DIAGONAL
        var forwardDiagonalSum = 0
        for diagonalCoordinate in (0...2) {
            forwardDiagonalSum += modelBoard[diagonalCoordinate][diagonalCoordinate]
        }
        if (forwardDiagonalSum == sumToWin) {return true} // if sum equals winning sum, player has won
        
        //BACKWARD DIAGONAL
        var backwardDiagonalSum = 0
        for diagonalCoordinate in (-1...1) {
            let xCoordinate = diagonalCoordinate + 1
            let yCoordinate = (diagonalCoordinate * -1) + 1
            backwardDiagonalSum += modelBoard[xCoordinate][yCoordinate]
        }
        if (backwardDiagonalSum == sumToWin) {return true} // if sum equals winning sum, player has won
        
        
        return false
        
    }
}
