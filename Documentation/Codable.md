## Table of contents

* [Configuration](#configuration)
* [Encoding](#encoding)
* [Decoding](#decoding)
* [Helpers](#helpers)






## Configuration

```swift
CodableKit.isLoggingEnabled = true
```






## Encoding

Use the following methods to Encode

```swift
model.toDictionary() // or .toArray()
model.toString()     // JSON String
model.toData()       // Data
```

### Examples

#### `Object -> [String: Any]`
```swift
let mike = Person(name: "Michael", age: 26, dob: Date(year: 1991, month: 8, day: 15))
print(mike.toDictionary()) 
```
> ["name": Michael, "age": 26, "dob": 1991-08-15T04:00:00Z] 


#### `[Object] -> [[String: Any]]`

```swift
let sara = Person(name: "Sara", age: 23, dob: Date(year: 1994, month: 9, day: 22))
let array = [ mike, sara ]
print(array.toArray()) // Returns [[String: Any]]
```
> [  
> &nbsp;&nbsp;["name": Michael, "age": 26, "dob": 1991-08-15T04:00:00Z],  
> &nbsp;&nbsp;["name": Sara, "age": 23, "dob": 1994-09-22T04:00:00Z]  
> ]   


#### `Object -> JSONString`

```swift
let mikeJsonString = mike.toString()
print(mikeJsonString)
```
> {  
> &nbsp;&nbsp;	"name": "Michael",  
> &nbsp;&nbsp;	"age": 26,  
> &nbsp;&nbsp;	"dob": "1991-08-15T04:00:00Z"  
> } 


#### `[Object] -> JSONString`

```swift
let arrayJsonString = array.toString()
print(arrayJsonString)
```

> [  
> &nbsp;&nbsp; {  
> &nbsp;&nbsp;&nbsp;&nbsp; "name": "Michael",  
> &nbsp;&nbsp;&nbsp;&nbsp; "age": 26,  
> &nbsp;&nbsp;&nbsp;&nbsp; "dob": "1991-08-15T04:00:00Z"  
> &nbsp;&nbsp;},   
> &nbsp;&nbsp;{  
> &nbsp;&nbsp;&nbsp;&nbsp; "name": "Sara",  
> &nbsp;&nbsp;&nbsp;&nbsp; "age": 23,  
> &nbsp;&nbsp;&nbsp;&nbsp; "dob": "1994-09-22T04:00:00Z"  
> &nbsp;&nbsp;}  
> ]


#### `Object -> Data`

```swift
let mikeData = mike.toData()
// print(mikeData)
```


#### `[Object] -> Data`
```swift
let arrayData = array.toData()
// print(arrayData)
```






## Decoding

Use the following methods to Decode

```swift
Model.decode(from data: Data)                         // from data
Model.decode(from string: String, keyPath: String?)   // from JSON String
```

### Examples


#### `Data -> Object`
```swift
let mike = Person.decode(from: mikeData)!
print(mike) 
```
> Person(name: "Michael", age: 26, dob: 1991-08-15 04:00:00 +0000)


#### `Data -> [Object]`

```swift
let array = [ Person ].decode(from: arrayData)!
print(array) // Returns [[String: Any]]
```

> [  
> &nbsp;&nbsp; Person(name: "Michael", age: 26, dob: 1991-08-15 04:00:00 +0000),  
> &nbsp;&nbsp; Person(name: "Sara", age: 23, dob: 1994-09-22 04:00:00 +0000)  
> ]  


#### `JsonString -> Object`
```swift
let mike = Person.decode(from: mikeJsonString)!
print(mike) 
```
> Person(name: "Michael", age: 26, dob: 1991-08-15 04:00:00 +0000)


#### `JsonString -> [Object]`

```swift
let array = [ Person ].decode(from: arrayJsonString)!
print(array) // Returns [[String: Any]]
```

> [  
> &nbsp;&nbsp; Person(name: "Michael", age: 26, dob: 1991-08-15 04:00:00 +0000),  
> &nbsp;&nbsp; Person(name: "Sara", age: 23, dob: 1994-09-22 04:00:00 +0000)  
> ]  






## Helpers 

There are 2 typealias for your convenience.
```swift
public typealias JSONDictionary = [String: Any]
public typealias JSONArray = [[String: Any]]
```