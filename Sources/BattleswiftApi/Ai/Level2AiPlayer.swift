// Random Placement and Probabilistic Targeting
public class Level2AiPlayer: ComputerPlayer {
    open override func inputShips() {
        let available = self.getAvailableShots();
        for shipType in ShipType.allCases {
            while true {
                let coordinate = available[Int.random(in: 0..<available.count)]
                let x = coordinate[0]
                let y = coordinate[1]
                let horizontal = Bool.random()
                // Validate
                if x + shipType.getSize() > 10 && horizontal {
                    continue
                }
                if y + shipType.getSize() > 10 && !horizontal {
                    continue
                }
                if !self.noOverlap(x: x, y: y, size: shipType.getSize(), orientation: horizontal ? .horizontal : .vertical) {
                    continue
                }
                for i in 0..<shipType.getSize() {
                    if horizontal {
                        self.setType(x: x + i, y: y, type: .ship(shipType))
                    } else {
                        self.setType(x: x, y: y + i, type: .ship(shipType))
                    }
                }
                break
            }
        }
    }

    open override func nextShot(otherShot: [Int]?, otherPlayerName: String) -> [Int] {
        let heatMap = generateHeatmap()
        var maxRow = 0
        var maxCol = 0
        for i in 0..<10 {
            for j in 0..<10 {
                if heatMap[i][j] > heatMap[maxRow][maxCol] {
                    maxRow = i
                    maxCol = j
                }
            }
        }
        return [maxRow, maxCol]
    }

    override open func onAction(coordinates: [Int], type: PosType) {
        super.onAction(coordinates: coordinates, type: type)
        // TODO
    }

    private func getSunkShipCoordinates() -> [[Int]] {
        var coordinates = [[Int]]()
        for shipType in ShipType.allCases {
            var partialCoordinates: [[Int]] = []
            for i in 0..<10 {
                for j in 0..<10 {
                    if self.partialOtherBoard[i][j].isHit() && self.partialOtherBoard[i][j].getShipType() == shipType {
                        partialCoordinates.append([i, j])
                    }
                }
            }
            if partialCoordinates.count == shipType.getSize() {
                coordinates.append(contentsOf: partialCoordinates)
            }
        }
        return coordinates
    }

    private func generateHeatmap() -> [[Int]] {
        let sunkShipCoordinates = getSunkShipCoordinates()
        var heatMap = [[Int]]()
        for _ in 0..<10 {
            var row = [Int]()
            for _ in 0..<10 {
                row.append(0)
            }
            heatMap.append(row)
        }
        for shipType in ShipType.allCases {
            let shipSize = shipType.getSize()
            let useSize = shipSize - 1
            for i in 0..<10 {
                for j in 0..<10 {
                    if !self.partialOtherBoard[i][j].isAttacked() {
                        var endpoints: [[[Int]]] = []
                        if i - useSize >= 0 {
                            endpoints.append([[i - useSize, j], [i, j]])
                        }
                        if i + useSize < 10 {
                            endpoints.append([[i, j], [i + useSize, j]])
                        }
                        if j - useSize >= 0 {
                            endpoints.append([[i, j - useSize], [i, j]])
                        }
                        if j + useSize < 10 {
                            endpoints.append([[i, j], [i, j + useSize]])
                        }
                        for ep in endpoints {
                            let startRow = ep[0][0]
                            let startCol = ep[0][1]
                            let endRow = ep[1][0]
                            let endCol = ep[1][1]
                            var all = true
                            for row in startRow...endRow {
                                for col in startCol...endCol {
                                    if self.partialOtherBoard[row][col].isAttacked() {
                                        all = false
                                        break
                                    }
                                }
                            }
                            if all {
                                for row in startRow...endRow {
                                    for col in startCol...endCol {
                                        heatMap[row][col] += 1
                                    }
                                }
                            }
                        }
                    }

                    if self.partialOtherBoard[i][j].isHit() && !sunkShipCoordinates.contains([i, j]) {
                        if i + 1 < 10 && !self.partialOtherBoard[i + 1][j].isAttacked() {
                            if i - 1 > 0 && !sunkShipCoordinates.contains([i - 1, j]) && self.partialOtherBoard[i - 1][j].isHit() {
                                heatMap[i + 1][j] += 15
                            } else {
                                heatMap[i + 1][j] += 10
                            }
                        }

                        if i - 1 >= 0 && !self.partialOtherBoard[i - 1][j].isAttacked() {
                            if i + 1 < 10 && !sunkShipCoordinates.contains([i + 1, j]) && self.partialOtherBoard[i + 1][j].isHit() {
                                heatMap[i - 1][j] += 15
                            } else {
                                heatMap[i - 1][j] += 10
                            }
                        }

                        if j + 1 < 10 && !self.partialOtherBoard[i][j + 1].isAttacked() {
                            if j - 1 > 0 && !sunkShipCoordinates.contains([i, j - 1]) && self.partialOtherBoard[i][j - 1].isHit() {
                                heatMap[i][j + 1] += 15
                            } else {
                                heatMap[i][j + 1] += 10
                            }
                        }

                        if j - 1 >= 0 && !self.partialOtherBoard[i][j - 1].isAttacked() {
                            if j + 1 < 10 && !sunkShipCoordinates.contains([i, j + 1]) && self.partialOtherBoard[i][j + 1].isHit() {
                                heatMap[i][j - 1] += 15
                            } else {
                                heatMap[i][j - 1] += 10
                            }
                        }
                    } else if self.partialOtherBoard[i][j].isAttacked() {
                        heatMap[i][j] = 0
                    }
                }
            }
        }
        return heatMap
    }
}
