class DrylibJava < Formula
  desc "DRYlib for Java"
  homepage "https://drylib.org/java.html"
  version "0.0.0"
  revision 0
  head "https://github.com/dryproject/drylib.java.git"

  depends_on "gradle" => :build
  depends_on :java => "1.8+"

  def install
    system "./gradlew", "-q", "build", "-x", "test"
    libexec.install Dir["build/**/*.jar"].first => "drylib-java.jar"
  end

  test do
    (testpath/"Test.java").write <<~EOS
      import dry.meta.*;
      public final class Test {
        public static void main(final String[] args) {
          // TODO
        }
      }
    EOS
    ENV.prepend "CLASSPATH", "#{libexec}/drylib-java.jar", ":"
    system "javac", "Test.java"
  end
end
