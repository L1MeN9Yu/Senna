# Senna

a log engine based on [spdlog](https://github.com/gabime/spdlog)

## Platforms

* iOS : 10.0+
* macOS : 10.14+

## Install

specify it in your `Cartfile`:

```shell script
github "L1MeN9Yu/Senna"
```

## Usage

See Demo

## Log Format

### Backend format

See spdlog wiki : [Custom formatting](https://github.com/gabime/spdlog/wiki/3.-Custom-formatting)

The default pattern is : `[%D %T] [%=10n] %^[process id : %P] [thread id : %t] [%8l] %v%$`

### Frontend format

All the frontend message will be the `%v` value to backend.

The default `MessageConvert` is below:

```swift
public typealias MessageConvert = (_ message: CustomStringConvertible?, _ filename: String, _ function: String, _ line: Int) -> String

public func register(messageConvert: @escaping MessageConvert) {
    __messageConvert = messageConvert
}

var __messageConvert: MessageConvert = { message, filename, function, line in
    let allMessage = "[\(URL(fileURLWithPath: filename).lastPathComponent):\(line)] \(function) - \(message?.description ?? "")"
    return allMessage
}
```

You can call
```swift
Senna.register(messageConvert: your_custom_message_convert)
``` 
to disable `filename`,`function`,`line` or whatever you want.