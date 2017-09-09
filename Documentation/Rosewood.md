## Table of contents 

* [Logging](#logging)
* [Pretty Print](#pretty-print)
* [Benchmark](#benchmark)
* [Log Formatter](#log-formatter)
* [Credits](#credits)





## Rosewood

The following examples can be found in the `RosewoodTest.swift` file.

Rosewood logging is enabled by default. To disable, use the following code...

```swift
Rosewood.Configuration.enabled = false
```

Rosewood logging is async by default. To make it sync, use the following code...

```swift
Rosewood.Configuration.isAsync = false
```

You can set a minimim log level. For example, to show only errors, use the following code...

```swift
Rosewood.Configuration.minLevel = .error
```




## Logging

Use the following methods for basic logging capabilities

```swift
Rosewood.verbose()
Rosewood.debug()
Rosewood.info()
Rosewood.warning()
Rosewood.error()
```


### Examples

```swift
Rosewood.verbose("Who am I?: ", self)
Rosewood.debug("1 + 1 = ", 1 + 1)
Rosewood.info("IsMainThread: ", Thread.current.isMainThread)
Rosewood.warning(1, 2, "3", separator: " - ")
Rosewood.error("Error: ", NSError(domain: "Error", code: -999, userInfo: [ "Hello": "World", "Number": 0 ]))
```

Will produce the following results...

> 💚VERBOSE  2017-09-02 21:53:07.486  
>  Source: RosewoodTest:testRosewoodLogDefaultFormat():10  
> Message: Who am I?:  -[RosewoodTest testRosewoodLogDefaultFormat]  

> 💜DEBUG    2017-09-02 21:53:07.490  
>  Source: RosewoodTest:testRosewoodLogDefaultFormat():11  
> Message: 1 + 1 =  2

> 💙INFO     2017-09-02 21:53:07.491  
>  Source: RosewoodTest:testRosewoodLogDefaultFormat():12  
> Message: IsMainThread:  true

> 💛WARNING  2017-09-02 21:53:07.491  
>  Source: RosewoodTest:testRosewoodLogDefaultFormat():13  
> Message: 1 - 2 - 3

> ❤️️ERROR    2017-09-02 21:53:07.492  
>  Source: RosewoodTest:testRosewoodLogDefaultFormat():14  
> Message: Error:  Error Domain=Error Code=-999 "(null)" UserInfo={Number=0, Hello=World}





## Pretty Print

Use the following methods for pretty print logging capabilities.

```swift
Rosewood.prettyprint()
```


### Examples

```swift
Rosewood.prettyprint(nil)
Rosewood.prettyprint(Float(2.0))
Rosewood.prettyprint(String("Hello"))
Rosewood.prettyprint(Bool(true))
Rosewood.prettyprint([ "Hello", "World" ])
Rosewood.prettyprint([ "Hello": "World", "Number": 0 ])
Rosewood.prettyprint(NSError(domain: "Error", code: -999, userInfo: [ "Hello": "World", "Number": 0 ]))
```

Will produce the following results...

> 💖PRETTIFY 2017-09-02 22:07:28.766  
> &nbsp;&nbsp; Source: RosewoodTest:testRosewoodPrettyPrint():83  
> Message: [nil] - nil

> 💖PRETTIFY 2017-09-02 22:07:28.773  
> &nbsp;&nbsp; Source: RosewoodTest:testRosewoodPrettyPrint():86  
> Message: [Float] - 2.0

> 💖PRETTIFY 2017-09-02 22:07:28.773  
> &nbsp;&nbsp; Source: RosewoodTest:testRosewoodPrettyPrint():87  
> Message: [String] - Hello

> 💖PRETTIFY 2017-09-02 22:07:28.773  
> &nbsp;&nbsp; Source: RosewoodTest:testRosewoodPrettyPrint():88  
> Message: [Bool] - true

> 💖PRETTIFY 2017-09-02 22:07:28.778  
> &nbsp;&nbsp; Source: RosewoodTest:testRosewoodPrettyPrint():90  
> Message: [Array\<String>]  
> &nbsp; [  
> &nbsp;&nbsp;&nbsp;&nbsp; "Hello",  
> &nbsp;&nbsp;&nbsp;&nbsp; "World"  
> &nbsp; ]  

> 💖PRETTIFY 2017-09-02 22:07:28.779  
> &nbsp;&nbsp; Source: RosewoodTest:testRosewoodPrettyPrint():91  
> Message: [Dictionary\<String, Any>]  
> &nbsp; {  
> &nbsp;&nbsp;&nbsp;&nbsp; "Number" : 0,  
> &nbsp;&nbsp;&nbsp;&nbsp; "Hello" : "World"  
> &nbsp; }  

> 💖PRETTIFY 2017-09-02 22:07:28.783  
> &nbsp;&nbsp; Source: RosewoodTest:testRosewoodPrettyPrint():92  
> Message: [NSError]  
> &nbsp;&nbsp; {  
> &nbsp;&nbsp;&nbsp;&nbsp; "localizedDescription" : "The operation couldn’t be completed. (Error error -999.)",  
> &nbsp;&nbsp;&nbsp;&nbsp; "code" : -999,  
> &nbsp;&nbsp;&nbsp;&nbsp; "domain" : "Error",  
> &nbsp;&nbsp;&nbsp;&nbsp; "userInfo" : {  
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "Number" : 0,  
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "Hello" : "World"  
> &nbsp;&nbsp;&nbsp;&nbsp; }  
> &nbsp;&nbsp; }  





## Benchmark

Use the following methods for benchmarking.

```swift
Rosewood.benchmark()
```

### Examples

```swift
var count = 0

func longtask() -> Void {

    count += 1
    if count % 2 == 0 {
        Thread.sleep(forTimeInterval: 0.25)
    } else {
        Thread.sleep(forTimeInterval: 0.5)
    }
}

Rosewood.benchmark("Long calculations 1", block: longtask)

Rosewood.benchmark("Long calculations 10", iterations: 5, block: longtask)

Rosewood.benchmark("Long calculations Inline", block: {
longtask()
Rosewood.benchmarkLog(message: "Hello", includeTimeStamp: true)
    longtask()
    longtask()
    longtask()
    Rosewood.benchmarkLog(message: "Hi", includeTimeStamp: true)
    longtask()
})
```

Will produce the following results...

> 🖤Measure Long calculations 1  
> 🖤Long calculations 1: 500.21ms  

> 🖤Measure Long calculations 10  
> 🖤Iteration 1: 250.12ms  
> 🖤Iteration 2: 500.06ms  
> 🖤Iteration 3: 250.05ms  
> 🖤Iteration 4: 500.39ms  
> 🖤Iteration 5: 250.15ms  
> 🖤 &nbsp;&nbsp;&nbsp;&nbsp; - Total: 1750.78ms  
> 🖤 &nbsp;&nbsp;&nbsp;&nbsp; - Average: 350.16ms  
> 🖤 &nbsp;&nbsp;&nbsp;&nbsp; - STD Dev: 15.01ms  

> 🖤Measure Long calculations Inline  
> 🖤 &nbsp;&nbsp;&nbsp;&nbsp; Hello  501.18ms  
> 🖤 &nbsp;&nbsp;&nbsp;&nbsp; Hi  1503.55ms  
> 🖤Long calculations Inline: 2004.71ms  





## Log Formatter

`LogFormatter` object allows you to design how your messages are shown in the console.  
3 formats are provided for your convenience. `default`, `oneline`, and `detailed.`

### Designing a format
```swift    
let short = LogFormatter("%@: %@", [.level, .message])
```

### Setting the log's format

```swift
Rosewood.Configuration.formatter = short
Rosewood.verbose("Who am I?: ", self)
```

> 💚VERBOSE : Who am I?:  -[RosewoodTest testRosewoodLogCustomFormat]


#### You can also use the results of a method in your log format.

```swift
class func getUserID() -> String {
    return "User: 123"
}

let block = LogFormatter("[%@] %@: %@", [.block(RosewoodTest.getUserID), .level, .message])
Rosewood.Configuration.formatter = block
Rosewood.verbose("Who am I?: ", self)
```

> [User: 123] 💚VERBOSE : Who am I?:  -[RosewoodTest testRosewoodLogBlockFormat]





## Credits

The basic logging methods and logformatter was inspired by [Log](https://github.com/delba/Log)  
The pretty-print methods was inspired by [Atlantis](https://github.com/DrewKiino/Atlantis)  
The benchmarking methods was inspired by [Duration](https://github.com/SwiftStudies/Duration)

