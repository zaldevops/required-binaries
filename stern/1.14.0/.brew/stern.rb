class Stern < Formula
  desc "Tail multiple Kubernetes pods & their containers"
  homepage "https://github.com/stern/stern"
  url "https://github.com/stern/stern/archive/v1.14.0.tar.gz"
  sha256 "f166462dd2b0fb8227dfd1d15c4e718b0917a5d5bb33aeb609affa8e7ac41b4f"
  license "Apache-2.0"
  head "https://github.com/stern/stern.git"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w -X github.com/stern/stern/cmd.version=#{version}", *std_go_args

    # Install shell completion
    output = Utils.safe_popen_read("#{bin}/stern", "--completion=bash")
    (bash_completion/"stern").write output

    output = Utils.safe_popen_read("#{bin}/stern", "--completion=zsh")
    (zsh_completion/"_stern").write output
  end

  test do
    assert_match "version: #{version}", shell_output("#{bin}/stern --version")
  end
end
