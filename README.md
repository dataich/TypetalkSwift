# TypetalkSwift

[![Build Status](https://travis-ci.org/dataich/TypetalkSwift.svg?branch=master)](https://travis-ci.org/dataich/TypetalkSwift)

## Usage

```swift
Client.send(GetProfile()) { (result) in
  switch result {
  case .success(let value):
    print(value.account.name)
  case .failure(let error):
    print(error)
  }
}
```

## Build Instruction

### Requirements

#### [Sourcery](https://github.com/krzysztofzablocki/Sourcery)  
Install to generate public initializer for structs using brew.

```
$ brew install sourcery
```

Sourcery is executed on build process as run scripts.
