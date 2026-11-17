# Folk Linux — Make hedefleri
# Kullanım: make build | make clean | make checksum

ISO_NAME := $(shell echo FolkLinux-$$(date +%Y.%m.%d)-x86_64.iso)
OUTPUT   := output
SHELL    := /bin/bash

.PHONY: all build clean checksum help

all: build

help:
	@echo "Folk Linux build hedefleri:"
	@echo "  make build     — ISO'yu derle (root gerekir)"
	@echo "  make clean     — Çıktı ve geçici dosyaları temizle"
	@echo "  make checksum  — Mevcut ISO için SHA512 üret"
	@echo "  make help      — Bu yardımı göster"

build:
	@sudo ./build.sh

clean:
	@rm -rf $(OUTPUT) work
	@echo "Temizlendi."

checksum:
	@cd $(OUTPUT) && sha512sum $(ISO_NAME) > $(ISO_NAME).sha512
