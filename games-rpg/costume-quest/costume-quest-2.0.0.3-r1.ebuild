# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="A Halloween adventure from Tim Schafer's Double Fine Productions"
HOMEPAGE="https://www.doublefine.com"
SRC_URI="gog_${PN//-/_}_${PV}.sh"
S="${WORKDIR}/data/noarch/game"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="bindist fetch splitdebug"

RDEPEND="
	media-libs/glu[abi_x86_32]
	media-libs/libglvnd[abi_x86_32,X]
	media-libs/libsdl2[abi_x86_32,joystick,opengl,sound,threads(+),video]
	sys-libs/zlib[abi_x86_32]
"

DIR="/opt/${PN}"
QA_PREBUILT="${DIR}/*"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  https://www.gog.com/game/${PN//-/_}"
	einfo "and move it to your distfiles directory."
}

src_unpack() {
	unpack_zip ${A}
}

src_prepare() {
	default

	# I think our SDL2 package has a newer database.
	rm -v Data/Config/SDLGamepad.config || die
}

src_install() {
	exeinto "${DIR}"
	newexe Cq.bin.x86 Cq.bin
	dosym "${DIR}"/Cq.bin /usr/bin/${PN}

	insinto "${DIR}"
	doins -r DFCONFIG Data/ Linux/ OGL/ Win/

	exeinto "${DIR}/lib"
	doexe lib/libfmod*.so

	newicon -s 256 CostumeQuest.png ${PN}.png
	make_desktop_entry ${PN} "Costume Quest"
}
