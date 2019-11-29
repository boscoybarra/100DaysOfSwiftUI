import UIKit

//For loops

let count = 1...10
for number in count {
    print("Number is \(number)")
}

//

let albums = ["Red", "1989", "Reputation"]

for album in albums {
    print("\(album) is on Apple Music")
}

//

print("Players gonna ")

//If you don’t use the constant that for loops give you, you should use an underscore instead so that Swift doesn’t create needless values:

for _ in 1...5 {
    print("play")
}

for _ in 0...3 {
    print("Hip hip hurray!")
}


for i in 4...6 {
    print("Star Wars: Episode \(i)")
}

var numbers = [1, 2, 3, 4, 5, 6]
for number in numbers {
    if number % 2 == 0 {
        print(number)
    }
}


//While loops

var number = 1

while number <= 20 {
    print(number)
    number += 1
}

print("Ready or not, here I come!")


let colors = ["Red", "Green", "Blue", "Orange", "Yellow"]
var colorCounter = 0
while colorCounter < 5 {
    print("\(colors[colorCounter]) is a popular color.")
    colorCounter += 1
}

var cats: Int = 0
while cats < 10 {
    cats += 1
    print("I'm getting another cat.")
    if cats == 4 {
        print("Enough cats!")
        cats = 10
    }
}

// This will print nothign
var itemsSold: Int = 0
while itemsSold < 5000 {
    itemsSold += 100
    if itemsSold % 1000 == 1000 {
        print("\(itemsSold) items sold - a big milestone!")
    }
}

// Print 5 lines
var numberLoop: Int = 10
while number > 0 {
    number -= 2
    if number % 2 == 0 {
        print("\(number) is an even number.")
    }
}

//Repeat loops
repeat {
    print("This is false")
} while false

// Swift has repeat loops and while loops, but you can't combine them together into repeat while.

//var testRuns = 0
//repeat while testRuns < 10 {
//    print("Testing!")
//    testRuns += 1
//}

//Exiting loops

var countDownLoop = 0

while countDownLoop >= 0 {
    print(countDownLoop)

    if countDownLoop == 4 {
        print("I'm bored. Let's go now!")
        break
    }

    countDownLoop -= 1
}

//Exiting multiple loops

//As an example, we could write some code to calculate the times tables from 1 through 10 like this:

//for i in 1...10 {
//    for j in 1...10 {
//        let product = i * j
//        print ("\(i) * \(j) is \(product)")
//    }
//}


outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

//Skipping items

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }

    print("\(i) It´s an even number")
}

var hoursStudied = 0
var goal = 10
repeat {
//    repeat passes all the options when reached to the if condition of 5 it exist the repeat loop
    hoursStudied += 1
    if hoursStudied > 4 {
        goal -= 1
        continue
    }
    print("I've studied for \(hoursStudied) hours")
} while hoursStudied < goal


let fibonacci = [1, 1, 2, 3, 5, 8, 13, 21]
var position = 0
while position <= 7 {
    let value = fibonacci[position]
    position += 1
    if value < 2 {
       continue
    }
    print("Fibonacci number \(position) is \(value)")
}

var counting = 0
while counting <= 20 {
    counting += 1
    if counting > 5 {
        continue
    }
    print("\(counting)...")
}
print("Ready or not, here I come!")


var distanceFlown = 0
while true {
    distanceFlown += 100
    if distanceFlown == 500 {
        continue
    }
    print(distanceFlown)
    if distanceFlown == 1000 {
        break
    }
}


for i in 1...100 {
    if 100 % i == 0 {
        print("100 divides evenly into \(i)")
    } else {
        continue
    }
}

var carsProduced = 0
print("It's me again!")
repeat {
    carsProduced += 1
    if carsProduced % 2 == 0 {
        continue
    }
    print("Another car was built.\(carsProduced)")
} while carsProduced < 20

//the carsProduced on the while loop does not exit until carsProduced < 20 satifies that condition


//Infinite loops

//To make an infinite loop, just use true as your condition. true is always true, so the loop will repeat forever. Warning: Please make sure you have a check that exits your loop, otherwise it will never end.

var counter = 0

while true {
    print(" ")
    counter += 1

    if counter == 273 {
        break
    }
}

var kids = 1
repeat {
    print("Kids in the class: \(kids)")
    kids += 1
} while kids != 10
//When kids reaches 10 this loop will terminate.

var securityHoles = 1
repeat {
    print("Security hole reported!")
    securityHoles += 1
} while securityHoles < 10
//When securityHoles reaches 10 this loop will terminate.

var counter = 1
repeat {
    print("Counting: \(counter)")
    counter += 2
} while counter != 10
//This is an infinite loop because counter will reach 7, then 9, then 11, then continue upwards without ever reaching 10.

var isVisible = true
while isVisible == true {
    isVisible = false
    if isVisible == false {
        isVisible = true
    }
}
//This is an infinite loop because isVisible will always be true.

//
//1. Loops let us repeat code until a condition is false.
//2. The most common loop is for, which assigns each item inside the loop to a temporary constant.
//3. If you don’t need the temporary constant that for loops give you, use an underscore instead so Swift can skip that work.
//4. There are while loops, which you provide with an explicit condition to check.
//5. Although they are similar to while loops, repeat loops always run the body of their loop at least once.
//6. You can exit a single loop using break, but if you have nested loops you need to use break followed by whatever label you placed before your outer loop.
//7. You can skip items in a loop using continue.
//8. Infinite loops don’t end until you ask them to, and are made using while true. Make sure you have a condition somewhere to end your infinite loops!

//var username = "twostraws"
//repeat {
//    print("Your username is \(username)")
//} while username
//while username is an invalid condition.


