# 🛠 X-SwiftFormat [![](https://img.shields.io/badge/license-MIT-eb3d33.svg)](https://raw.githubusercontent.com/ruiaureliano/X-SwiftFormat/master/LICENSE) ![](https://img.shields.io/badge/swift-5.2-eb3d33.svg)
![](./assets/xsf_header.png)

### 🔗 Download [X-SwiftFormat 0.9.5 (β95)](https://github.com/ruiaureliano/X-SwiftFormat/releases/download/β95/x-swiftformat_0.9.5_95.zip)

---

### 1) Open X-SwiftFormat

**X-SwiftFormat** works as Xcode Extension to format your swift code. You will need to open this once to activate it 👍

![](./assets/xsf_running.png)

**a)** You case use the **Preview** to see the format running in the app 🦾

![](./assets/xsf_format.gif)

**b)** You can export a configuration file (`.swift-format`) to use later 🖥

### 2) Enable X-SwiftFormat

Open **System Preferences** ▸ **Extensions** ▸ **Xcode Source Editor** and make sure **X-SwiftFormat** is selected ✅

![](./assets/xsf_extensions.png)

### 3) Use X-SwiftFormat

Open Xcode and use the **Format Swift Code** command in Xcode's **Editor** menu 🚀

![](./assets/xsf_usage.png)

### 4) Add X-SwiftFormat Shortcut

Open **System Preferences**, click on **Keyboard** and switch to the **Shortcuts** tab. Select **App Shortcuts**, then hit the <kbd>+</kbd> button. Select **Xcode**, enter `Format Swift Code` and set your **Shortcut**.👏

![](./assets/xsf_shortcuts.png)

---

# Installing [Apple Swift Format](https://github.com/apple/swift-format) (Xcode or Mint)

## a) Using XCode
if you are using **Xcode 11.4 (Swift 5.2)**, you can check out and build swift-format using the following commands:

```
git clone -b swift-5.2-branch https://github.com/apple/swift-format.git
cd swift-format
swift build
```
You should see this
```
[207/207] Linking swift-format
```
👍👍👍

## b) Using Mint 

If you dint have **Homebrew**, install [here](https://brew.sh)

```
brew install mint
mint install apple/swift-format@swift-5.2-branch
```
You should see this
```
🌱 Cloning swift-format swift-5.2-branch
🌱 Resolving package
🌱 Building package
🌱 Installed swift-format swift-5.2-branch
🌱 Linked swift-format swift-5.2-branch to /usr/local/bin
```
👍👍👍

### Command Line Usage

```
swift-format -v
0.0.1
```

|Command | Description |
|-|-|
|`swift-format swift`|Display formatted code|
|`swift-format -i file.swift`|Overwrites formatted code|
|`swift-format -r folder`|Format all files in a folder|
|`swift-format -r -i folder`|Format all files in a folder and overwrites|

Check more info here: [https://github.com/apple/swift-format](https://github.com/apple/swift-format)

---

I'm [Rui Aureliano](http://ruiaureliano.com), iOS and macOS Engineer at [Olá Brothers](https://theolabrothers.com). We make [Sip](https://sipapp.io) 🤓

[Linkedin](https://www.linkedin.com/in/ruiaureliano) | [AngelList](https://angel.co/ruiaureliano) | [Twitter](https://twitter.com/ruiaureliano) | [Github](https://github.com/ruiaureliano) | [Medium](https://medium.com/@ruiaureliano) | [Stackoverflow](https://stackoverflow.com/users/881095/ruiaureliano)
