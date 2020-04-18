# 🛠 X-SwiftFormat [![](https://img.shields.io/badge/license-MIT-eb3d33.svg)](https://raw.githubusercontent.com/ruiaureliano/X-SwiftFormat/master/LICENSE) ![](https://img.shields.io/badge/swift-5.2-eb3d33.svg)

![](./assets/xsf_header.png)

### 🔗 Download [X-SwiftFormat 0.9.5 (β95)](https://github.com/ruiaureliano/X-SwiftFormat/releases/download/β95/x-swiftformat_0.9.5_95.zip)

X-SwiftFormat is a Xcode Plugin built on top of two cool frameworks:

1. **Formatting technology for Swift source code** - https://github.com/apple/swift-format
1. **SwiftPM package for SwiftSyntax library** - https://github.com/apple/swift-syntax

**Note:** _This still under development and its βeta. Feedback is very appreciated 🍺_

---

#### ⚠️ Please make sure your setup is complete (see how [here](https://github.com/ruiaureliano/X-SwiftFormat/blob/master/README.md))

**1)** Open **Swift** file with **Xcode**

![](./docs/1.png)

**2)** Once you are editing a **Swift** file in **Xcode**, you can format this file using the **X-SwiftFormat Extension**. Just go to **Editor** ▸ **X-SwiftFormat** ▸ **Format Swift Code**. Done, code is formatted with default settings.

![](./docs/2.png)

**3)** You can open **X-SwiftFormat** app to change some settings. Read more [here](https://github.com/apple/swift-format/blob/master/Documentation/Configuration.md)

![](./docs/3.png)

**4)** I will just change two options here, `Line Length = 120` and use `Tabs = 1`. We have more options to change.

![](./docs/4.png)

**5)** Formatting the code again will use my custom settings, i.e will use tabs and 120 is the maximum allowed length of a line, in characters.

![](./docs/5.png)

**6)** Another cool feature is the ability to suppress formatting within a section of source code. Read more [here](https://github.com/apple/swift-format/blob/master/Documentation/IgnoringSource.md)

1. `// swift-format-ignore`
1. `// swift-format-ignore: OrderedImports`
1. `// swift-format-ignore: DoNotUseSemicolons`

Using those rules, imports will not be sorted, the block `[17-23]` will not be formatted and we can use semicolons on the block `[26-30]`.

![](./docs/6.png)

**7)** **X-SwiftFormat** app also allows setting rules to suppress formatting. **Ordered Imports** is now disabled.

![](./docs/7.png)

**8)** This means even with no comments, imports will not be sorted.

![](./docs/8.png)

---

I'm [Rui Aureliano](http://ruiaureliano.com), iOS and macOS Engineer at [Olá Brothers](https://theolabrothers.com). We make [Sip](https://sipapp.io) 🤓

[Linkedin](https://www.linkedin.com/in/ruiaureliano) | [AngelList](https://angel.co/ruiaureliano) | [Twitter](https://twitter.com/ruiaureliano) | [Github](https://github.com/ruiaureliano) | [Medium](https://medium.com/@ruiaureliano) | [Stackoverflow](https://stackoverflow.com/users/881095/ruiaureliano)
