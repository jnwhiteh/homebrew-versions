require 'formula'

class Automake112 < Formula
  homepage 'http://www.gnu.org/software/automake/'
  url 'http://ftpmirror.gnu.org/automake/automake-1.12.5.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/automake/automake-1.12.5.tar.gz'
  sha1 'e3c4331e53a95d195a8e51eea4f0ec3785bdb800'

  # Always needs a newer autoconf, even on Snow Leopard.
  depends_on 'autoconf'

  if MacOS::Xcode.provides_autotools? or File.file? "/usr/bin/automake"
    keg_only "Xcode (up to and including 4.2) provides (a rather old) Automake."
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"

    # Our aclocal must go first. See:
    # https://github.com/mxcl/homebrew/issues/10618
    (share/"aclocal/dirlist").write <<-EOS.undent
      #{HOMEBREW_PREFIX}/share/aclocal
      /usr/share/aclocal
    EOS
  end

  def test
    system "#{bin}/automake", "--version"
  end
end
