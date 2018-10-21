# Mia

[![CI Status](http://img.shields.io/travis/multinerd/Mia.svg?style=flat)](https://travis-ci.org/multinerd/Mia)
[![codebeat badge](https://codebeat.co/badges/c2d27f95-2d07-4e0f-a321-2c98c629fd1f)](https://codebeat.co/projects/github-com-multinerd-mia-master)
[![codecov](https://codecov.io/gh/multinerd/Mia/branch/master/graph/badge.svg)](https://codecov.io/gh/multinerd/Mia)

Mia is a bunch of tools to streamline my developement. See [usage](#usage) for more information.





## Table of contents 

* [Example](#example)
* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
* [License](#license)





## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.  
I will *try* to keep this as up to date as possible.





## Requirements

![Requires iOS 10.0 or higher.][iosBadge]
![Support for macOS is unknown.][macBadge]
![Support for tvOS is unknown.][tvBadge]
![Support for watchOS is unknown.][watchBadge]

![Requires Swift 3.0 or higher.][swiftBadge]
![Support for Objective-C is unknown.][objcBadge]

![Requires Xcode 8.0 or higher.][xcodeBadge]

[iosBadge]: https://img.shields.io/badge/ios-10.0+-a.svg?style=flat&colorA=212121&colorB=616161 
[macBadge]: https://img.shields.io/badge/macos-unknown-a.svg?style=flat&colorA=212121&colorB=616161 
[tvBadge]: https://img.shields.io/badge/tvos-unknown-a.svg?style=flat&colorA=212121&colorB=616161 
[watchBadge]: https://img.shields.io/badge/watchos-unknown-a.svg?style=flat&colorA=212121&colorB=616161 

[swiftBadge]: https://img.shields.io/badge/swift-3.0+-a.svg?style=flat&colorA=212121&colorB=FD7935
[objcBadge]: https://img.shields.io/badge/objective--c-unknown-a.svg?style=flat&colorA=212121&colorB=616161 

[xcodeBadge]: https://img.shields.io/badge/xcode-8.0+-a.svg?style=flat&colorA=212121&colorB=00B0FF 





## Installation





    
    
### [CocoaPods][cocoapodsURL]  [![Mia is compatible with cocoapods.][cocoapodsBadge]][cocoapodsURL]
<details>
     <summary>Instructions</summary>
     
To integrate Mia into your project using `cocoapods`, specify it in your `podfile`.
```ruby
pod 'Mia', :git => 'https://github.com/Multinerd/Mia.git'
```
</details>


### [Carthage][carthageURL]  [![Mia is incompatible with carthage.][carthageBadge]][carthageURL]
<details>
     <summary>Instructions</summary>
    
Not yet compatible with `carthage`. Feel free to submit a pull request.
</details>

### [Swift Package Manager][spmURL]  [![Mia is incompatible with swift package manager.][spmBadge]][spmURL]
<details>
     <summary>Instructions</summary>
    
Not yet compatible with `swift package manager`. Feel free to submit a pull request.
</details>

[cocoapodsBadge]: https://img.shields.io/badge/cocoapods-compatible-a.svg?style=flat&colorA=212121&colorB=00C853
[carthageBadge]: https://img.shields.io/badge/carthage-incompatible-red.svg?style=flat&colorA=212121&colorB=E53935
[spmBadge]: https://img.shields.io/badge/spm-incompatible-red.svg?style=flat&colorA=212121&colorB=E53935 

[cocoapodsURL]: http://cocoapods.org
[carthageURL]: https://github.com/Carthage/Carthage
[spmURL]: https://swift.org/package-manager/





## Usage

- `Data Management`
    - `JSON`  
        - [![Codable][codableBadge]][codableURL]
- `Logging` 
    - [![Rosewood][rosewoodBadge]][rosewoodURL]


[rosewoodBadge]: https://img.shields.io/badge/rosewood-a_simple_to_use_logging_framework-a.svg?style=flat&colorA=212121&colorB=F48FB1 
[rosewoodURL]: https://github.com/multinerd/Mia/blob/master/Documentation/Rosewood.md

[codableBadge]: https://img.shields.io/badge/codablekit-encode_objects_to_json_and_back_(based_on_swift_4's_codable_protocol)-a.svg?style=flat&colorA=212121&colorB=26C6DA 
[codableURL]: https://github.com/multinerd/Mia/blob/master/Documentation/Codable.md




## Todo

- [ ] Complete Example App that showcases all functionalities of Mia.
- [ ] 100% Documentation
- [ ] 100% Code Coverage w/ Unit Tests
- [ ] Refactor Code to get an _A_ from codebeat.


## Why Open-Source?

Look, ladies and gents, you are much smarter than I. I am a working developer who is still learning everyday. I made this open-source for one reasons:

- If smarter, more experienced Swift developers can suggest improvements or fix my bugs, I will learn from them.

Which is a nice segue to...

## How to Contribute

1. Fork.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Added some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create new Pull Request.


## License

![License][licenseBadge]

See the [license][licenseURL] file for more information about MIA.  
See the [documentation][documentationURL] file for more information about each components.  

[licenseBadge]: https://img.shields.io/badge/license-MIT-a.svg?style=flat&colorA=212121&colorB=616161 
[licenseURL]: https://github.com/multinerd/Mia/blob/master/LICENSE
[documentationURL]: https://github.com/multinerd/Mia/tree/master/Documentation
