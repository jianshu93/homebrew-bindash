class Bindash < Formula
  # cite Zhao_2018: "https://academic.oup.com/bioinformatics/article/35/4/671/5058094"
  desc "B-bit One-Permutation Rolling MinHash with Optimal/Faster Densification for Genome Search and Comparisons"
  homepage "https://github.com/zhaoxiaofei/bindash"
  url "https://github.com/jianshu93/bindash/archive/refs/tags/v2.3.tar.gz"
  sha256 "6e4bf36fd04195ed0738ea8bf835eca1e400b5ce6eef3902bdf0673955d15166"
  head "https://github.com/zhaoxiaofei/bindash"

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libomp" => :build

  uses_from_macos "zlib"

  def install
    system "cmake", "."
    system "make"

    # ideally we should be using "make install" here
    bin.install "bindash"
    pkgshare.install "benchmark"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bindash --version 2>&1")
    system bin/"bindash", "sketch", "--outfname=test", pkgshare/"benchmark/testdata/testgenome1.fna"
  end
end
