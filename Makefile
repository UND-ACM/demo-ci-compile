CC := go
SOURCE := main.go
DEST := dist

OS_MAC := darwin
OS_WINDOWS := windows
OS_LINUX := linux

ARCH_ARM64 := arm64
ARCH_ARM32 := arm
ARCH_X86_64 := amd64
ARCH_X86_32 := 386

all: mac win linux

linux: ensure_dest
	GOOS=$(OS_LINUX) GOARCH=$(ARCH_ARM64) $(CC) build -o $(DEST)/out.linux.arm64 $(SOURCE)
	GOOS=$(OS_LINUX) GOARCH=$(ARCH_X86_64) $(CC) build -o $(DEST)/out.linux.amd64 $(SOURCE)
	GOOS=$(OS_LINUX) GOARCH=$(ARCH_X86_32) $(CC) build -o $(DEST)/out.linux.i386 $(SOURCE)
	GOOS=$(OS_LINUX) GOARCH=$(ARCH_ARM32) GOARM=6 $(CC) build -o $(DEST)/out.linux.rpi_zero $(SOURCE)

win: ensure_dest
	GOOS=$(OS_WINDOWS) GOARCH=$(ARCH_ARM64) $(CC) build -o $(DEST)/out.win.arm.exe $(SOURCE)
	GOOS=$(OS_WINDOWS) GOARCH=$(ARCH_X86_64) $(CC) build -o $(DEST)/out.win.x64.exe $(SOURCE)
	GOOS=$(OS_WINDOWS) GOARCH=$(ARCH_X86_32) $(CC) build -o $(DEST)/out.win.x32.exe $(SOURCE)

mac: ensure_dest
	GOOS=$(OS_MAC) GOARCH=$(ARCH_ARM64) $(CC) build -o $(DEST)/out.macos.apple_silicon $(SOURCE)
	GOOS=$(OS_MAC) GOARCH=$(ARCH_x86_64) $(CC) build -o $(DEST)/out.macos.intel $(SOURCE)

ensure_dest:
	mkdir -p $(DEST)

release_message:
	echo "# Hello World (commit \`$(shell git log -1 --pretty=%h)\`)  " > release.md
	echo >> release.md
	echo "Latest commit message: \`$(shell git log -1 --pretty=%s)\`  " >> release.md
	echo "Commit author: $(shell git log -1 --pretty='[%cn](mailto:%ce) on %cs')  " >> release.md

clean:
	rm -r $(DEST)