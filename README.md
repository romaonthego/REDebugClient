# REDebugClient

Advanced remote Xcode logging in Terminal app. Allows to redirect log output of Xcode console to Terminal when running iPhone Simulator / Mac OS X app.

![Screenshot of REDebugClient](https://github.com/romaonthego/REDebugClient/raw/master/Screenshot.png "REDebugClient Screenshot")

## Requirements
* Xcode 5 or higher
* Apple LLVM compiler
* ARC

## Installation

### Server

First thing you'll need to do is to install [debugserver](https://github.com/sosedoff/debugserver) gem:

``` bash
$ [sudo] gem install debugserver
$ debugserver
```

You can specify host and port in debug server, for instance:
``` bash
$ debugserver -h 0.0.0.0 -p 9000
```

### Install REDebugClient

The recommended approach for installating REDebugClient is via the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Edit your Podfile and add REDebugClient:

``` bash
$ edit Podfile
platform :ios, '4.3' # or platform :osx, '10.7'
pod 'REDebugClient', '~> 1.0'
```

Install into your Xcode project:

``` bash
$ pod install
```

### without CocoaPods

There's only one dependency - [CocoaAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket), so you'll need to add it manually.

## Demo

First, you need to install dependencies using [CocoaPods](http://cocoapods.org/) package manager in the demo project:

``` bash
$ pod install
```

After that, build and run the `REDebugClientExample` project in Xcode to see `REDebugClient` in action.

## Example Usage

``` objective-c
RELogConnect(@"localhost", 9000);
RELogClear();

RELog(@"Default");
RELogInfo(@"Info multi\nLine");
RELogWarning(@"UIWindow: %@", self.window);
RELogError(@"Error");

NSDictionary *dictionary = @{@"test": @123,
                             @"demo": @{@"foo": @"bar",
                                        @"var": @2}};

RELog(@"NSDictionary: %@", dictionary);
```

## Contact

Roman Efimov

- https://github.com/romaonthego
- https://twitter.com/romaonthego
- romefimov@gmail.com

## License

REDebugClient is available under the MIT license.

Copyright © 2013 Roman Efimov.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
