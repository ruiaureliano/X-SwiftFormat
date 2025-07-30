# 👨‍🏫 Docs

[![](https://img.shields.io/badge/MIT-License-0f73b4.svg)](./LICENSE.md) [![](https://img.shields.io/badge/swift-6.2-0f73b4.svg)](https://swift.org/blog/swift-6.2-released/) [![](https://img.shields.io/badge/docs-2.1-0f73b4.svg)](./DOCS.md)

![](./assets/readme/xsf-header.png)

X-SwiftFormat is a Xcode Plugin built on top of two cool frameworks:

1. **Formatting technology for Swift source code** - https://github.com/apple/swift-format
1. **SwiftPM package for SwiftSyntax library** - https://github.com/apple/swift-syntax

---

#### ⚠️ Please make sure your setup is complete (see how [here](./README.md))

**1)** Open **Swift** file with **Xcode**

![1-light](./assets/docs/1-light.png#gh-light-mode-only)
![1-dark](./assets/docs/1-dark.png#gh-dark-mode-only)

**2)** Once you are editing a **Swift** file in **Xcode**, you can format this file using the **X-SwiftFormat Extension**. Just go to **Editor** ▸ **X-SwiftFormat** ▸ **Format Swift Code**. Done, code is formatted with default settings.

![2-light](./assets/docs/2-light.png#gh-light-mode-only)
![2-dark](./assets/docs/2-dark.png#gh-dark-mode-only)

**3)** You can open **X-SwiftFormat** app to change some settings. Read more [here](https://github.com/apple/swift-format/blob/master/Documentation/Configuration.md)

![3-light](./assets/docs/3-light.png#gh-light-mode-only)
![3-dark](./assets/docs/3-dark.png#gh-dark-mode-only)

**4)** I will just change two options here, `Line Length = 120` and use `Tabs = 1` . We have more options to change.

![4-light](./assets/docs/4-light.png#gh-light-mode-only)
![4-dark](./assets/docs/4-dark.png#gh-dark-mode-only)

**5)** Formatting the code again will use my custom settings, i.e will use tabs and 120 is the maximum allowed length of a line, in characters.

![5-light](./assets/docs/5-light.png#gh-light-mode-only)
![5-dark](./assets/docs/5-dark.png#gh-dark-mode-only)

**6)** Another cool feature is the ability to suppress formatting within a section of source code. Read more [here](https://github.com/apple/swift-format/blob/master/Documentation/IgnoringSource.md)

1. `// swift-format-ignore`
1. `// swift-format-ignore: OrderedImports`
1. `// swift-format-ignore: DoNotUseSemicolons`

Using those rules, imports will not be sorted, the block `[17-23]` will not be formatted and we can use semicolons on the block `[26-30]` .

![6-light](./assets/docs/6-light.png#gh-light-mode-only)
![6-dark](./assets/docs/6-dark.png#gh-dark-mode-only)

**7)** **X-SwiftFormat** app also allows setting rules to suppress formatting. **Ordered Imports** is now disabled.

![7-light](./assets/docs/7-light.png#gh-light-mode-only)
![7-dark](./assets/docs/7-dark.png#gh-dark-mode-only)

**8)** This means even with no comments, imports will not be sorted.

![8-light](./assets/docs/8-light.png#gh-light-mode-only)
![8-dark](./assets/docs/8-dark.png#gh-dark-mode-only)

**9)** After version 1.1, its possible to have multiple environments, this will help if you work with multiple porjects and **multiple configurations**. Press the `(+)` and add the name you want.

![9-light](./assets/docs/9-light.png#gh-light-mode-only)
![9-dark](./assets/docs/9-dark.png#gh-dark-mode-only)

**10)** You can switch between configuration using the dropdown.

![10-light](./assets/docs/10-light.png#gh-light-mode-only)
![10-dark](./assets/docs/10-dark.png#gh-dark-mode-only)

---

I'm [Rui Aureliano](http://ruiaureliano.com), iOS and macOS Engineer at [Olá Brothers](https://theolabrothers.com). We make [Sip](https://sipapp.io) 🤓

[Linkedin](https://www.linkedin.com/in/ruiaureliano) | [Twitter](https://twitter.com/ruiaureliano) | [Github](https://github.com/ruiaureliano) | [Stackoverflow](https://stackoverflow.com/users/881095/ruiaureliano)
