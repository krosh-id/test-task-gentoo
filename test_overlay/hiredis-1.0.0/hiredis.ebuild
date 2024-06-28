# BEGIN ebuild
# Copyright (c) 2024 Bard
#
# This is a free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2 of the License, or (at your
# option) any later version.

EAPI="7"

# Подробная информация о hiredis
DESCRIPTION="Минималистичная C-библиотека-клиент для базы данных Redis"
HOMEPAGE="https://github.com/redis/hiredis"
SRC_URI="https://github.com/redis/hiredis/archive/refs/heads/main.tar.gz"

# Версия hiredis
VERSION="master"

LICENSE="GPL-2.0"

# Зависимости
DEPENDENCIES="
    dev-libs/libssl
    sys-devel/autoconf
    sys-devel/cmake
    sys-devel/gcc
"

# Функции USE
USE_FLAGS="
    doc
    man
    tests
"

# Функции NOUSE
NOUSE_FLAGS="
    ccache
    compiler-binutils
    compiler-gcc-cross
    compiler-libcxx
    compiler-obsolercxx
    compiler-portageqmake
    compiler-zlib
    doc-chm
    doc-epub
    doc-info
    doc-latex
    doc-manpages
    doc-pdf
    doc-sgml
    doc-wiki
    man-pages
    ssl-ca-certificates
    ssl-certs
    test
"

# Сборка hiredis
SRC_DIR="hiredis-${VERSION}"

configure() {
    # CMake-based build
    cmake .
}

compile() {
    # Use the default compiler
    cmake --build .
}

install() {
    # Install headers and libraries
    make install DESTDIR="${D}"

    # Install documentation
    if use doc; then
        make install-doc DESTDIR="${D}"
    fi

    # Install man pages
    if use man; then
        make install-man DESTDIR="${D}"
    fi
}

# Тестирование hiredis
test() {
    # Проверка тестов
    if use test; then
        make test
    fi
}

# Чистка после сборки
gentoo_clean() {
    # Удаление временных файлов
    rm -rf "${S}"
}

# Метаданные
KEYWORDS="~amd64 ~x86"
PROVIDES="dev-libs/hiredis=${VERSION}"
SLOT="0"
REQUIRED_USE="~ssl"
AUTOGEN="true"
# END ebuild
