# 🛠 X-SwiftFormat [![GitHub License](https://img.shields.io/badge/license-MIT-eb3d33.svg)](https://raw.githubusercontent.com/ruiaureliano/X-SwiftFormat/master/LICENSE)
![](./assets/xsf_header.png)

### 🔗 Download [X-SwiftFormat 0.9.1 βeta](https://github.com/ruiaureliano/X-SwiftFormat/releases/latest)

---

### 1) Open X-SwiftFormat

**X-SwiftFormat** works as Xcode Extension to format your swift code. You will need to open this once to activate it 👍

![](./assets/xsf_running.png)

You case use the **Preview** to see the format running in the app 🦾

![](./assets/xsf_format.gif)

### 2) Enable X-SwiftFormat

Open **System Preferences** ▸ **Extensions** ▸ **Xcode Source Editor** and make sure **X-SwiftFormat** is selected ✅

![](./assets/xsf_extensions.png)

### 3) Use X-SwiftFormat

Open Xcode and use the **Format Source Code** command in Xcode's **Editor** menu 🚀

![](./assets/xsf_usage.png)

### 4) Add X-SwiftFormat Shortcut

Ppen **System Preferences**, click on **Keyboard**, and switch to the **Shortcuts** tab. Select **App Shortcuts**, then hit the <kbd>+</kbd> button. Select **Xcode**, enter `Format Swift Code` and set your **Shortcut**.👏

![](./assets/xsf_shortcuts.png)

---

# Installing [Apple Swift Format](https://github.com/apple/swift-format) (XCode or Mint)

## a) Using XCode
if you are using **Xcode 11.0 (Swift 5.1)**, you can check out and build swift-format using the following commands:

```
git clone -b swift-5.1-branch https://github.com/apple/swift-format.git
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
mint install apple/swift-format@swift-5.1-branch
```
You should see this
```
🌱 Cloning swift-format swift-5.1-branch
🌱 Resolving package
🌱 Building package
🌱 Installed swift-format swift-5.1-branch
🌱 Linked swift-format swift-5.1-branch to /usr/local/bin
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

---

Check more info here: [https://github.com/apple/swift-format](https://github.com/apple/swift-format)
