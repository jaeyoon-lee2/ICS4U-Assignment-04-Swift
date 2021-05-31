/*
This class get three sides and angles.
author  Jay Lee
version 1.0
since   2021-05-30
*/

import Foundation

class Triangle {
  // Fields
  private var dataMembers = [Double](repeating: 0.0, count: 6)
  private var triangleType: String

  // Constructor
  public init(side1: Double, side2: Double, side3: Double,
       angle1: Double, angle2: Double, angle3: Double) {
    self.dataMembers[0] = side1
    self.dataMembers[1] = side2
    self.dataMembers[2] = side3
    self.dataMembers[3] = angle1 * Double.pi / 180
    self.dataMembers[4] = angle2 * Double.pi / 180
    self.dataMembers[5] = angle3 * Double.pi / 180
    self.triangleType = ""
  }

  // This method check the triangle is valid and return boolean.
  public func IsTriangleValid() -> Bool {
    if (dataMembers[0] != 0 || dataMembers[1] != 0 || dataMembers[2] != 0) {
      FillAllSides()
      // find the biggest side to check the triangle is valid.
      var biggestSide = dataMembers[0]
      for index in 1..<3 {
        biggestSide = max(biggestSide, dataMembers[index])
      }
      // check if there is any sides,
      // sum of angles are pi (180°) or less(if not define),
      // and the biggest side is less than other two sides.
      if ((dataMembers[3] + dataMembers[4] + dataMembers[5] <= Double.pi) && (biggestSide < GetSemiperimeter())) {
        return true
      }
    }
    return false
  }

// This method fills all sides of the triangle.
  private func FillAllSides() {
    let validIndex = GetValidValues()
    var side1 = dataMembers[0]
    var side2 = dataMembers[1]
    var side3, angle1, angle2, angle3: Double
    if (triangleType != "SSS") {
      if (triangleType == "SAS") {
        angle3 = dataMembers[validIndex[2]]
        side3 = sqrt(pow(side1, 2.0) + pow(side2, 2.0) - 2.0 * side1 * side2 * cos(angle3))
        self.dataMembers[validIndex[2] - 3] = side3
      } else if (triangleType == "SSA") {
        if (validIndex[2] - validIndex[0] == 3) {
          angle1 = dataMembers[validIndex[2]]
          angle2 = asin(side2 * sin(angle1) / side1)
        } else {
          angle2 = dataMembers[validIndex[2]]
          angle1 = asin(side1 * sin(angle2) / side2)
        }
        angle3 = Double.pi - angle1 - angle2
        side3 = side1 * sin(angle3) / sin(angle1)
      } else {
        side3 = dataMembers[validIndex[0]]
        let leftAngleIndex = 12 - validIndex[1] - validIndex[2]
        if (validIndex[0] + validIndex[1] + validIndex[2] == 9) {
          angle1 = dataMembers[validIndex[1]]
          angle2 = dataMembers[validIndex[2]]
          angle3 = Double.pi - angle1 - angle2
        } else if (validIndex[0] + leftAngleIndex + validIndex[1] == 9) {
          angle2 = dataMembers[validIndex[1]]
          angle3 = dataMembers[validIndex[2]]
          angle1 = Double.pi - angle2 - angle3
        } else {
          angle3 = dataMembers[validIndex[1]]
          angle2 = dataMembers[validIndex[2]]
          angle1 = Double.pi - angle2 - angle3
        }
        side1 = side3 * sin(angle1) / sin(angle3)
        side2 = side3 * sin(angle2) / sin(angle3)
        self.dataMembers[validIndex[1] - 3] = side1
        self.dataMembers[validIndex[2] - 3] = side2
      }
    }
  }

  // This method returns indexes of the valid sides or angles
  // and set the type of the triangle (SSS, SAS, SSA, ASA).
  private func GetValidValues() -> [Int] {
    var sideCount = 0, angleCount = 0, sumOfIndex = 0, counter = 0
    var indexArray = [Int](repeating: 0, count: 3)
    for index in 0..<dataMembers.count {
      if (dataMembers[index] != 0) {
        if (index <= 2) {
          sideCount += 1
        } else {
          angleCount += 1
        }
        sumOfIndex += index
        indexArray[counter] = index
        counter += 1
      }
    }
    if (sideCount == 3) {
      self.triangleType = "SSS"
    } else if (angleCount > 1) {
      self.triangleType = "ASA"
    } else if (sumOfIndex == 6) {
      self.triangleType = "SAS"
    } else {
      self.triangleType = "SSA"
    }
    return indexArray
  }

  // This method calculate the triangle area by using Heron's formula.
  public func GetArea() -> Double {
    let semiperimeter = GetSemiperimeter()
    let side1 = dataMembers[0]
    let side2 = dataMembers[1]
    let side3 = dataMembers[2]
    return sqrt(semiperimeter * (semiperimeter - side1) * (semiperimeter - side2) * (semiperimeter - side3))
  }

  // This method returns name of the triangle.
  public func GetName() -> String {
    let side1 = round(dataMembers[0] * 100) / 100
    let side2 = round(dataMembers[1] * 100) / 100
    let side3 = round(dataMembers[2] * 100) / 100
    if (side1 == side2 && side2 == side3) {
      return "Equilateral"
    } else if (side1 == side2 || side2 == side3 || side1 == side3) {
      return "Isosceles"
    } else {
      return "Scalene"
    }
  }

  // This method returns the semiperimeter of the triangle.
  public func GetPerimeter() -> Double {
    return dataMembers[0] + dataMembers[1] + dataMembers[2]
  }

  // This method returns the perimeter of the triangle.
  public func GetSemiperimeter() -> Double {
    return GetPerimeter() / 2.0
  }

  // This method returns the radius of the largest inscribed circle.
  public func GetRadiusOfLargestInscribedCircle(triangleArea: Double) -> Double {
    return triangleArea / GetSemiperimeter()
  }

  // This method returns circumcircle area.
  public func GetCircumcircleArea(triangleArea: Double) -> Double {
    let radius = dataMembers[0] * dataMembers[1] * dataMembers[2] / (4.0 * triangleArea)
    return Double.pi * pow(radius, 2.0)
  }

  // This method returns highest height of the triangle.
  public func GetHeight(area: Double) -> Double {
    var height = 0.0
    for index in 0..<3 {
      let newHeight = 2.0 * area / dataMembers[index]
      height = max(height, newHeight)
    }
    return height
  }
}
