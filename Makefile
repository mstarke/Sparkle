.PHONY: all localizable-strings release build test travis

BUILDDIR := $(shell mktemp -d "$(TMPDIR)/Sparkle.XXXXXX")

localizable-strings:
	rm -f Sparkle/en.lproj/Sparkle.strings
	genstrings -o Sparkle/en.lproj -s SULocalizedString Sparkle/*.m Sparkle/*.h
	iconv -f UTF-16 -t UTF-8 < Sparkle/en.lproj/Localizable.strings > Sparkle/en.lproj/Sparkle.strings
	rm Sparkle/en.lproj/Localizable.strings

release:
	xcodebuild -scheme Distribution -configuration Release -derivedDataPath "$(BUILDDIR)" build
	open -R "$(BUILDDIR)/Build/Products/Release/Sparkle-"*.tar.bz2

build:
	xcodebuild clean build

test:
	xcodebuild -scheme Distribution -configuration Debug test

travis: test
