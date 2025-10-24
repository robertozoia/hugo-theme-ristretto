# Ristretto Hugo Theme

A minimalist Hugo theme designed for personal blogs.

## Installation

### As a Hugo Module (Recommended)

1. Initialize your Hugo site as a module (if not already done):
```bash
hugo mod init github.com/yourusername/yoursite
```

2. Add the theme to your `hugo.toml`:
```toml
[module]
[[module.imports]]
  path = "github.com/robertozoia/hugo-theme-ristretto"
```

3. Update your modules:
```bash
hugo mod get -u
```

### Traditional Installation

Clone the theme into your `themes` directory:
```bash
git clone https://github.com/robertozoia/hugo-theme-ristretto.git themes/ristretto
```

Then set the theme in your `hugo.toml`:
```toml
theme = "ristretto"
```

## Configuration

See the example configuration in `hugo.toml` for all available options.

## License

[Your License Here]
