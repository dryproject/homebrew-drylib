class DrylibCpp < Formula
  desc "DRYlib for C++"
  homepage "https://drylib.org/cpp.html"
  version "0.0.0"
  revision 0
  head "https://github.com/dryproject/drylib.cpp.git"

  depends_on "gcc@8" => :test

  def install
    system "make", "install", *%W[prefix=#{prefix}]
  end

  test do
    cxx = "#{Formula["gcc"].prefix.realpath}/bin/g++-8"
    (testpath/"test.cpp").write <<~EOS
      #include <cassert>
      #include <drylib.hpp>
      int main(void) {
        //assert(...); // TODO
        return 0;
      }
    EOS
    system cxx, *%w[-std=c++17 -o test test.cpp]
    system "./test"
  end
end
