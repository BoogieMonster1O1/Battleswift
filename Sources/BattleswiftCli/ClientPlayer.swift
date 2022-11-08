import BattleswiftApi
import Foundation

public class ClientPlayer : Player {
    public let uuid: UUID

    public override init() {
        self.uuid = UUID.init()
    }

    override public func inputShips() {
        var errorMessage: String? = nil
        var i: Int = 0
        while i < ShipType.allCases.count {
            let shipType = ShipType.allCases[i]
            do {
                print("\u{001B}[2J")
                self.display(showShips: true)
                if let errorMessage = errorMessage {
                    print(errorMessage)
                }
                print("Enter the coordinates of your \(shipType.getName()) (\(shipType.getSize())):")
                let input = readLine()

                guard let input = input else {
                    throw InputError.Null
                }

                if input.count != 4 {
                    throw InputError.MalformedSize
                }
                let x1Index = input.startIndex
                let y1Index = input.index(after: x1Index)
                let x2Index = input.index(after: y1Index)
                let y2Index = input.index(after: x2Index)
                let x1Char = input[x1Index]
                let y1Char = input[y1Index]
                let x2Char = input[x2Index]
                let y2Char = input[y2Index]
                guard x1Char.isASCII && x1Char.isUppercase && y1Char.isASCII && y1Char.isNumber && x2Char.isASCII && x2Char.isUppercase && y2Char.isASCII && y2Char.isNumber else {
                    throw InputError.MalformedPosition
                }
                let x1 = Int(x1Char.asciiValue! - 65)
                let y1 = Int(String(y1Char))!
                let x2 = Int(x2Char.asciiValue! - 65)
                let y2 = Int(String(y2Char))!
                guard x1 == x2 || y1 == y2 else {
                    throw InputError.MalformedOrientation
                }
                guard x1 <= x2 && y1 <= y2 else {
                    throw InputError.MalformedPosition
                }
                guard x1 >= 0 && x1 < 10 && y1 >= 0 && y1 < 10 && x2 >= 0 && x2 < 10 && y2 >= 0 && y2 < 10 else {
                    throw InputError.OutOfBounds
                }
                guard abs(x1 - x2) + abs(y1 - y2) + 1 == shipType.getSize() else {
                    throw InputError.WrongSize
                }
                let orientation: Orientation = x1 == x2 ? Orientation.vertical : Orientation.horizontal
                guard noOverlap(x: x1, y: y1, size: shipType.getSize(), orientation: orientation) else {
                    throw InputError.Overlapping
                }
                for j in 0..<shipType.getSize() {
                    if orientation == .horizontal {
                        setType(x: x1 + j, y: y1, type: .ship(shipType))
                    } else {
                        setType(x: x1, y: y1 + j, type: .ship(shipType))
                    }
                }
                i += 1
            } catch InputError.Null {
                errorMessage = "Please enter a value"
            } catch InputError.MalformedSize {
                errorMessage = "The size of your input string is not 4 characters"
            } catch InputError.MalformedPosition {
                errorMessage = "Please enter valid positions"
            } catch InputError.MalformedOrientation {
                errorMessage = "Please choose a valid orientation - ships cannot be diagonal"
            } catch InputError.WrongSize {
                errorMessage = "The size of your shipType is not \(shipType.getSize())"
            } catch InputError.OutOfBounds {
                errorMessage = "Please enter positions within the board"
            } catch InputError.Overlapping {
                errorMessage = "Please enter positions that do not overlap"
            } catch {
                errorMessage = "An unknown error occurred"
            }
        }
    }

    override public func nextShot(otherShot: [Int]?, otherPlayerName: String) -> [Int] {
        print("\u{001B}[2J")
        if let otherShot = otherShot {
            print("\(otherPlayerName) played \(Character(UnicodeScalar(otherShot[0] + 65)!))\(otherShot[1])")
        }
        print("")
        print("\(otherPlayerName): ")
        Player.display(types: self.partialOtherBoard, showShips: false)
        print("")
        print("\(self.getName()): ")
        self.display(showShips: true)
        return inputNextShot()
    }

    private func inputNextShot() -> [Int] {
        print("Enter the coordinates of your next shot: ")
        let input = readLine()
        guard let input = input else {
            print("Please enter a value")
            return inputNextShot()
        }
        if input.count != 2 {
            print("The size of your input string is not 2 characters")
            return inputNextShot()
        }
        let xIndex = input.startIndex
        let yIndex = input.index(after: xIndex)
        let xChar = input[xIndex]
        let yChar = input[yIndex]
        guard xChar.isASCII && xChar.isUppercase && yChar.isASCII && yChar.isNumber else {
            print("Please enter valid positions")
            return inputNextShot()
        }
        let x = Int(xChar.asciiValue! - 65)
        let y = Int(String(yChar))!
        guard x >= 0 && x < 10 && y >= 0 && y < 10 else {
            print("Please enter positions within the board")
            return inputNextShot()
        }
        return [x, y]
    }

    override public func getName() -> String {
        return "You"
    }

    override open func lose() {
        print("You lose!")
    }

    override open func win() {
        print("You win!")
    }
}

enum InputError: Error {
    case Null
    case MalformedSize
    case MalformedPosition
    case MalformedOrientation
    case WrongSize
    case OutOfBounds
    case Overlapping
}
