# homebrew-tap

Official Homebrew tap for @gokcer formulae.

## Available Formulae

| Formula | Description | Installation |
| :--- | :--- | :--- |
| **`cursor-view`** | Browse, search, export, and share your entire Cursor AI chat history | `brew install gokcer/tap/cursor-view` |

---

## Installation & Usage

### 1. `cursor-view`

Browse, search, and export all your local Cursor AI chat histories.

#### Install:
```bash
brew install gokcer/tap/cursor-view
```

Or tap first:
```bash
brew tap gokcer/tap
brew install cursor-view
```

#### Run:
```bash
cursor-view
```

> The server will start locally and automatically open your default browser at `http://localhost:5000`.
> To specify a custom port:
> ```bash
> cursor-view --port 8080
> ```

---

## Using in a `Brewfile`

```ruby
tap "gokcer/tap"
brew "cursor-view"
```

---

## License

Formulae and configurations are available under the [Apache-2.0 License](LICENSE) / [MIT License](LICENSE).
