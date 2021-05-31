/*
This program get three sides or angles and shows information of the triangle.
author  Jay Lee
version 1.0
since   2021-05-30
*/

enum InvalidInputError : Error {
  case invalidInput
}

print("\nTriangle△\n")
print("All sides and angles are corresponding in order.")
print("So the first side and angle face each other, not attached.")
print("If you don’t know the side or angle, just skip it by entering nothing,")
print("but you should enter at least three things without only three angles.")

do {
  print("\nEnter the first side: ", terminator:"")
  let strSide1 = String(readLine()!)
  if (!strSide1.isEmpty) {
    guard let side1 = Double(strSide1) else {
      throw InvalidInputError.invalidInput
    }
  } else {
    let side1 = 0.0
  }
  print("\nEnter the second side: ", terminator:"")
  let strSide2 = String(readLine()!)
  if (!strSide2.isEmpty) {
    guard let side2 = Double(strSide2) else {
      throw InvalidInputError.invalidInput
    }
  } else {
    let side2 = 0.0
  }
  print("\nEnter the third side: ", terminator:"")
  let strSide3 = String(readLine()!)
  if (!strSide3.isEmpty) {
    guard let side3 = Double(strSide3) else {
      throw InvalidInputError.invalidInput
    }
  } else {
    let side3 = 0.0
  }
  print("\nEnter the first angle(°): ", terminator:"")
  let strAngle1 = String(readLine()!)
  if (!strAngle1.isEmpty) {
    guard let angle1 = Double(strAngle1) else {
      throw InvalidInputError.invalidInput
    }
  } else {
    let angle1 = 0.0
  }
  print("\nEnter the second angle: ", terminator:"")
  let strAngle2 = String(readLine()!)
  if (!strAngle2.isEmpty) {
    guard let angle2 = Double(strAngle2) else {
      throw InvalidInputError.invalidInput
    }
  } else {
    let angle2 = 0.0
  }
  print("\nEnter the third angle: ", terminator:"")
  let strAngle3 = String(readLine()!)
  if (!strAngle3.isEmpty) {
    guard let angle3 = Double(strAngle3) else {
      throw InvalidInputError.invalidInput
    }
  } else {
    let angle3 = 0.0
  }

  let myTriangle = Triangle(side1: side1, side2: side2, side3: side3, angle1: angle1, angle2: angle2, angle3: angle3)

  if (myTriangle.IsTriangleValid()) {
    let area = myTriangle.GetArea()
    print("\nArea: \(area) u^2")
    print("\nPerimeter: \(myTriangle.GetPerimeter())")
    print("\nType: \(myTriangle.GetName())")
    print("\nHighest height: \(myTriangle.GetHeight(area: area))")
    print("\nRadius of the largest inscribed circle: \(myTriangle.GetRadiusOfLargestInscribedCircle(triangleArea: area))")
    print("\nCircumcircle Area: \(myTriangle.GetCircumcircleArea(triangleArea: area))")
  } else {
    print("\nInvalid triangle.")
  }
} catch {
  print("\nInvalid input.")
}
print("\nDone.")
