# GenP-2.7

Reversed source code for GenP v2.7. 

I wanted to practice my reverse engineering skills, so I picked some software I found online as I would not violate any agreements. I am making my findings public here, be sure to use responsibly.

## Overview

The executables `RunMe.exe`, `Adobe-GenP-2.7.exe`, `GenPPP-2.7.exe`, and `HotkeySet.exe` are AutoIt scripts. `NSudo.exe` appears to be an unmodified version of [NSudo](https://github.com/m2team/NSudo).

`RunMe.exe` calls `NSudo.exe` to start `Adobe-GenP-2.7.exe` as TrustedInstaller.

`Adobe-GenP-2.7.exe` displays the GUI and starts `HotkeySet.exe`, which closes the programs (`Adobe-GenP-2.7.exe` and `GenPPP-2.7.exe`) upon pressing Escape.

When the patch (cure) button is pressed, `Adobe-GenP-2.7.exe` calls `GenPPP-2.7.exe` for patching. `GenPPP-2.7.exe` searches for x86 instruction patterns within Adobe files and replaces them with appropriate counterparts.

## Building

1. Use Aut2exe to convert each of the AutoIt scripts to an executable
2. Use Visual Studio to build NSudo
3. Place the resulting executables in the following hierarchy
4. Run `RunMe.exe`

```
│   RunMe.exe
│
└───Resources
    │   Adobe-GenP-2.7.exe
    │   GenPPP-2.7.exe
    │   HotkeySet.exe
    │   NSudo.exe
    │
    └───ICONS
```

## Signatures

|File|SHA256|
|-|-|
|RunMe.exe|d250df329d47be781f3c765a861d5419679ff01ac8edfdb148e95c16e2b0300e|
|Adobe-GenP-2.7.exe|7b8d9ff34315e1787cdb62e682b3ba8dedd9f28d7cd374afe057babaf335edd4|
|GenPPP-2.7.exe|38be210ba106521f2f9252f1e449114e79ca87c6573f63e95070f03a15489672|
|HotkeySet.exe|bad9e6dfbf82dd82d851eda9dc884c710349ce338203833b7d1e9615fa7b55b6|
|NSudo.exe|19896a23d7b054625c2f6b1ee1551a0da68ad25cddbb24510a3b74578418e618|
