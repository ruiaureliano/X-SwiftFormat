# 🛠 X-SwiftFormat

[![](https://img.shields.io/badge/MIT-License-0f73b4.svg)](./LICENSE.md) [![](https://img.shields.io/badge/swift-6.2-0f73b4.svg)](https://swift.org/blog/swift-6.2-released/) [![](https://img.shields.io/badge/docs-2.1-0f73b4.svg)](./DOCS.md)

![](./assets/readme/xsf-header.png)

## Installation

### Using Github

[![](https://img.shields.io/badge/Download-2.1-0f73b4.svg?logo=github)](https://github.com/ruiaureliano/X-SwiftFormat/releases/download/2.1/x-swiftformat_2.1.zip)

### Using Cask

`brew install --cask x-swiftformat`

## Usage

### 1) Open X-SwiftFormat

**X-SwiftFormat** works as Xcode Extension to format your swift code. You will need to open this once to activate it 👍

![xsf-running-light](./assets/readme/xsf-running-light.png#gh-light-mode-only)
![xsf-running-light](./assets/readme/xsf-running-dark.png#gh-dark-mode-only)

**a)** You case use the **Preview** to see the format running in the app 💪

![xsf-format-light](./assets/readme/xsf-format-light.png#gh-light-mode-only)
![xsf-format-light](./assets/readme/xsf-format-dark.png#gh-dark-mode-only)

**b)** You can export a configuration file ( `.swift-format` ) to use later 🖥

### 2) Enable X-SwiftFormat

Open **System Preferences** ▸ **Privacy & Security** ▸ **Extensions** ▸ **Xcode Source Editor** and make sure **X-SwiftFormat** is selected ✅

![xsf-extensions-light](./assets/readme/xsf-extensions-light.png#gh-light-mode-only)
![xsf-extensions-light](./assets/readme/xsf-extensions-dark.png#gh-dark-mode-only)

### 3) Use X-SwiftFormat

Open Xcode and use the **Format Swift Code** command in Xcode's **Editor** menu 🚀

![xsf-usage-light](./assets/readme/xsf-usage-light.png#gh-light-mode-only)
![xsf-usage-light](./assets/readme/xsf-usage-dark.png#gh-dark-mode-only)

### 4) Add X-SwiftFormat Shortcut

Open **System Preferences** ▸ **PKeyboard** ▸ **Keyboard Shortcuts** ▸ **App Shortcuts**, then hit the <kbd>+</kbd> button. Select **Xcode**, enter `Format Swift Code` and set your **Shortcut**.👏

![xsf-shortcuts-light](./assets/readme/xsf-shortcuts-light.png#gh-light-mode-only)
![xsf-shortcuts-light](./assets/readme/xsf-shortcuts-dark.png#gh-dark-mode-only)

---

# Installing [Apple Swift Format](https://github.com/apple/swift-format) (Xcode or Mint)

## a) Using Xcode

if you are using **Xcode 15 (Swift 6.2)**, you can check out and build swift-format using the following commands:

```
git clone -b release/6.2 https://github.com/apple/swift-format.git
cd swift-format
swift build
```

You should see this

```
Build complete! (50.00s)
```

👍👍👍

## b) Using Mint

If you did not have **Homebrew**, install [here](https://brew.sh)

```
brew install mint
mint install apple/swift-format@release/6.2
```

You should see this

```
🌱 Cloning swift-format release/6.2
🌱 Resolving package
🌱 Building package
🌱 Installed swift-format release/6.2
🌱 Linked swift-format release/6.2
```

👍👍👍

### Command Line Usage

```
swift-format -v
600.0.0
```

| Command                      | Description                                 |
| ---------------------------- | ------------------------------------------- |
| `swift-format swift`         | Display formatted code                      |
| `swift-format -i file.swift` | Overwrites formatted code                   |
| `swift-format -r folder`     | Format all files in a folder                |
| `swift-format -r -i folder`  | Format all files in a folder and overwrites |

Check more info here: [https://github.com/apple/swift-format](https://github.com/apple/swift-format)

---

I'm [Rui Aureliano](http://ruiaureliano.com), iOS and macOS Engineer at [Olá Brothers](https://theolabrothers.com). We make [Sip](https://sipapp.io) 🤓

[Linkedin](https://www.linkedin.com/in/ruiaureliano) | [Twitter](https://twitter.com/ruiaureliano) | [Github](https://github.com/ruiaureliano) | [Stackoverflow](https://stackoverflow.com/users/881095/ruiaureliano)
