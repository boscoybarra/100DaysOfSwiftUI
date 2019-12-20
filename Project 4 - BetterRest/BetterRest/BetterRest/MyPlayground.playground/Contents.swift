import UIKit

var str = "Hello, playground"


let now = Date()
let tomorrow = Date().addingTimeInterval(86400)
let range = now ... tomorrow


//So, if we wanted a date that represented 8am today, we could write code like this:
var components = DateComponents()
components.hour = 8
components.minute = 0
//Now, because of difficulties around date validation, that date(from:) method actually returns an optional date, so it’s a good idea to use nil coalescing to say “if that fails, just give me back the current date”, like this:
let date = Calendar.current.date(from: components) ?? Date()
//let date = Calendar.current.date(from: components)


//Again, DateComponents comes to the rescue: we can ask iOS to provide specific components from a date, then read those back out.

let components = Calendar.current.dateComponents([.hour, .minute], from: someDate)
let hour = components.hour ?? 0
let minute = components.minute ?? 0


//For example, if we just wanted the time from a date we would write this:
let formatter = DateFormatter()
formatter.timeStyle = .short
let dateString = formatter.string(from: Date())

