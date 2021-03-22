# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit linux-info

DESCRIPTION="API to packets that have been queued by the kernel packet filter"
HOMEPAGE="https://www.netfilter.org/projects/libnetfilter_queue/"
SRC_URI="https://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm arm64 ~hppa ~mips ppc ppc64 ~sparc x86"
IUSE="doc static-libs"

RDEPEND="
	>=net-libs/libmnl-1.0.3
	>=net-libs/libnfnetlink-0.0.41
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	doc? ( app-doc/doxygen )
	virtual/pkgconfig
"
CONFIG_CHECK="~NETFILTER_NETLINK_QUEUE"

pkg_setup() {
	linux-info_pkg_setup
	kernel_is lt 2 6 14 && ewarn "requires at least 2.6.14 kernel version"
}

src_configure() {
	econf $(use_with doc doxygen)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
