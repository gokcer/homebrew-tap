class CursorView < Formula
  include Language::Python::Virtualenv

  desc "Browse, search, export, and share your entire Cursor AI chat history"
  homepage "https://github.com/saharmor/cursor-view"
  url "https://github.com/saharmor/cursor-view/archive/21426e22b9239ec7473bc91ba9103739852e2b86.tar.gz"
  version "0.1.0"
  sha256 "84e1f846e076baa77a556fbc7ea0a3dd33f3e1cea61e123e935e7249c3bb1e91"
  license "Apache-2.0"
  head "https://github.com/saharmor/cursor-view.git", branch: "main"

  depends_on "node" => :build
  depends_on "python@3.12"

  def install
    cd "frontend" do
      system "npm", "install", *std_npm_args(prefix: false)
      system "npm", "run", "build"
      rm_r "node_modules"
    end

    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install [
      "blinker>=1.9.0",
      "click>=8.1.3",
      "itsdangerous>=2.2.0",
      "jinja2>=3.1.2",
      "markupsafe>=2.1.1",
      "werkzeug>=3.1.0",
      "flask>=2.0.0",
      "flask-cors>=3.0.10",
    ]

    libexec.install Dir["*"]

    (bin/"cursor-view").write <<~EOS
      #!/usr/bin/env bash
      PORT=5000
      ARGS=()

      while [[ $# -gt 0 ]]; do
        case "$1" in
          -h|--help)
            exec "#{libexec}/bin/python3" "#{libexec}/server.py" --help
            ;;
          --port)
            PORT="$2"
            ARGS+=("$1" "$2")
            shift 2
            ;;
          -p)
            PORT="$2"
            ARGS+=("--port" "$2")
            shift 2
            ;;
          *)
            if [[ "$1" =~ ^[0-9]+$ ]]; then
              PORT="$1"
              ARGS+=("--port" "$1")
            else
              ARGS+=("$1")
            fi
            shift
            ;;
        esac
      done

      if [[ ${#ARGS[@]} -eq 0 ]]; then
        ARGS+=("--port" "$PORT")
      fi

      echo "Starting Cursor View on http://localhost:${PORT} ..."
      (sleep 1.5 && open "http://localhost:${PORT}") &
      cd "#{libexec}" || exit 1
      exec "#{libexec}/bin/python3" "#{libexec}/server.py" "${ARGS[@]}"
    EOS
    chmod 0755, bin/"cursor-view"
  end

  test do
    assert_match "Run the Cursor Chat View server", shell_output("#{bin}/cursor-view --help")
  end
end
