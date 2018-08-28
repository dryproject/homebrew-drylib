class DrylibC < Formula
  desc "DRYlib for C"
  homepage "https://drylib.org/c.html"
  version "0.0.0"
  revision 0
  head "https://github.com/dryproject/drylib.c.git"

  depends_on "gcc@8" => :build
  depends_on "drylib-cpp" => :build

  def install
    cxx = "#{Formula["gcc"].prefix.realpath}/bin/g++-8"
    ENV.prepend "CPPFLAGS", "-I#{Formula["drylib-cpp"].opt_include}"
    system "make", *%W[CXX=#{cxx}]
    system "make", "install", *%W[prefix=#{prefix}]
  end

  test do
    cc = "#{Formula["gcc"].prefix.realpath}/bin/gcc-8"
    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <drylib.h>
      int main(void) {
        assert(dry_meta_module_exists("base"));
        return 0;
      }
    EOS
    system cc, *%W[-std=c11 -L#{lib} -ldry -o test test.c]
    system "./test"
  end
end
