class K8sify < Formula
  desc "Intelligent Docker Compose to Kubernetes migration tool with cost analysis, security scanning, and production patterns"
  homepage "https://github.com/sreniatnoc/k8sify"
  license "MIT"
  head "https://github.com/sreniatnoc/k8sify.git", branch: "main"

  # This will be updated automatically by CI when we create releases
  url "https://github.com/sreniatnoc/k8sify/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2f34ace40a58747f01ac671521c6f9701e719c4215b6315d8bebaab872541a80"
  version "0.1.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "."

    # Install shell completions (if supported)
    # generate_completions_from_executable(bin/"k8sify", "--generate", base: "k8sify")

    # Install man page if available
    if (buildpath/"docs/k8sify.1").exist?
      man1.install "docs/k8sify.1"
    end
  end

  test do
    # Test that the binary was installed and runs
    assert_match "k8sify", shell_output("#{bin}/k8sify --version")

    # Test basic functionality with a simple docker-compose file
    (testpath/"docker-compose.yml").write <<~EOS
      version: '3.8'
      services:
        web:
          image: nginx:latest
          ports:
            - "80:80"
    EOS

    # Test analyze command
    output = shell_output("#{bin}/k8sify analyze -i docker-compose.yml -f json")
    assert_match "services", output
    assert_match "nginx", output
  end
end