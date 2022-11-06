import BattleswiftApi

public class PlayerBoard : Board {
    override public func inputShips() {
        var errorMessage: String? = nil
        var i: Int = 0
        while i < ClientGame.sizes.count {
            let size = ClientGame.sizes[i]
            do {
                print("\u{000C}")
                self.display(showShips: true)
                if let errorMessage = errorMessage {
                    print(errorMessage)
                }
                print("Enter the coordinates of your \(size) ship:")
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
                guard abs(x1 - x2) + abs(y1 - y2) + 1 == size else {
                    throw InputError.WrongSize
                }
                let orientation: Orientation = x1 == x2 ? Orientation.vertical : Orientation.horizontal
                guard noOverlap(x: x1, y: y1, size: size, orientation: orientation) else {
                    throw InputError.Overlapping
                }
                for j in 0..<size {
                    if orientation == .horizontal {
                        setType(x: x1 + j, y: y1, type: .ship)
                    } else {
                        setType(x: x1, y: y1 + j, type: .ship)
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
                errorMessage = "The size of your ship is not \(size)"
            } catch InputError.OutOfBounds {
                errorMessage = "Please enter positions within the board"
            } catch InputError.Overlapping {
                errorMessage = "Please enter positions that do not overlap"
            } catch {
                errorMessage = "An unknown error occurred"
            }
        }
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
