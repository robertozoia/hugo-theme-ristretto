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

### Site Configuration

Add these parameters to your `hugo.toml`:

```toml
baseURL = 'https://yoursite.com/'
languageCode = 'en-us'
title = 'Your Site Title'
theme = 'ristretto'

# Permalinks
[permalinks]
posts = "/posts/:slug/"

# Markup settings (allows HTML in markdown)
[markup.goldmark.renderer]
unsafe = true

# Global parameters
[params]
description = "Your site description"
copyright = "&copy; 2025 Your Name. All rights reserved."
reply_to_email = "you@example.com"
mailchimp_user_id = "your_mailchimp_user_id"
mailchimp_audience_id = "your_mailchimp_audience_id"
goatcounter_code = "your_goatcounter_code"
```

### Menu Configuration

Configure your navigation menus:

```toml
# Main navigation
[[menus.main]]
name = "Home"
url = "/"
weight = 1

[[menus.main]]
name = "Categories"
identifier = "categories"
weight = 2

# Categories submenu
[[menus.categories]]
name = "Tech & AI"
url = "/tech-ai"
weight = 1

# Footer menu
[[params.footerMenu]]
name = "Mastodon"
url = "https://mastodon.example/@user"
rel = "me"
```

## Content Types

### Regular Blog Posts

Standard posts with image cards in grid layout:

```yaml
---
date: "2024-10-24"
title: "Your Post Title"
slug: "your-post-slug"
categories: ["tech", "ai"]
tags: ["machine-learning", "strategy"]
cover: "cover.jpg"
cover_alt: "Cover image description"
draft: false
---

Your content here...
```

**Display**: Posts appear as cards with cover image, title, and publication date in a responsive grid (1 column mobile, 2 tablet, 3 desktop).

### Book Reviews

Special layout for book reviews with sidebar cover:

```yaml
---
date: "2024-10-24"
title: "Book Title, by Author Name"
slug: "book-title-review"
layout: book-review
book_title: "The Book Title"
book_author: "Author Name"
cover: "book-cover.jpg"
book_cover_alt: "Book Title by Author Name"
rating: "5/5"
categories: ["book-reviews"]
tags: ["personal-growth", "productivity"]
---

Your review content here...
```

**Display**: Book cover appears in a fixed-width left sidebar, review content flows in the main column on the right. Cover maintains 2:3 aspect ratio.

### Homepage Configuration

Configure your homepage in `content/_index.md`:

```yaml
---
title: "Welcome"
hero_image: "hero-pic.jpg"
tagline: "Your tagline here"
subheading: |
  Your introduction text. This supports markdown and
  can span multiple lines.

cta_primary_label: "Work with me"
cta_primary_link: "mailto:you@example.com"
cta_secondary_label: "Read articles"
cta_secondary_link: "/tech-ai/"

featured_categories: ["ai", "tech", "strategy"]
---
```

**Featured Posts**: The homepage automatically shows recent posts matching the `featured_categories` list.

### Category Sections

Create filtered content sections using categories. Example in `content/tech-ai/_index.md`:

```yaml
---
title: "Tech & AI"
categories: ["tech", "ai", "cybersecurity"]
cover: "section-header.jpg"
---

Section description goes here.
```

**How Category Filtering Works**:
1. The section's `categories` list acts as a filter
2. Posts with ANY matching category appear in this section
3. Uses Hugo's `intersect` function for flexible filtering
4. Displays 12 posts per page with pagination
5. Posts appear in reverse chronological order

Example: If a post has `categories: ["tech", "startups"]` and the section has `categories: ["tech", "ai"]`, the post appears because "tech" matches.

## Front Matter Parameters

### Common Parameters (All Content Types)

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `title` | string | Yes | Page/post title |
| `date` | date | Yes | Publication date (YYYY-MM-DD) |
| `slug` | string | Recommended | URL slug (auto-generated from title if omitted) |
| `draft` | boolean | No | Draft status (default: false) |
| `categories` | array | No | Content categories for filtering |
| `tags` | array | No | Content tags |
| `cover` | string | No | Cover/featured image path |
| `cover_alt` | string | No | Alt text for cover image |
| `aliases` | array | No | URL aliases for redirects |

### Book Review Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `layout` | string | Yes | Must be `"book-review"` |
| `book_title` | string | Yes | Book title |
| `book_author` | string | Yes | Book author |
| `rating` | string | No | Book rating (e.g., "5/5", "4/5 stars") |
| `book_cover_alt` | string | Recommended | Alt text for book cover |

### Homepage Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `hero_image` | string | No | Hero image (displayed as circle) |
| `tagline` | string | No | Tagline below title |
| `subheading` | string | No | Introduction text (supports markdown) |
| `cta_primary_label` | string | No | Primary call-to-action button text |
| `cta_primary_link` | string | No | Primary button URL |
| `cta_secondary_label` | string | No | Secondary button text |
| `cta_secondary_link` | string | No | Secondary button URL |
| `featured_categories` | array | No | Categories to feature on homepage |

### Control Parameters

Disable specific features on individual pages:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `disableSubscribeForm` | boolean | false | Hide newsletter subscription form |
| `disableSocialShare` | boolean | false | Hide social sharing buttons |
| `disableReplyByMail` | boolean | false | Hide "reply by email" option |

Example:
```yaml
---
title: "About"
disableSubscribeForm: true
disableSocialShare: true
---
```

## Content Organization

### Recommended Directory Structure

```
content/
├── _index.md                    # Homepage
├── posts/                       # Blog posts
│   ├── 20241024-post-name/
│   │   ├── index.md
│   │   └── cover.jpg
│   └── 20241025-another-post/
│       └── index.md
├── tech-ai/                     # Category section
│   └── _index.md                # categories: ["tech", "ai"]
├── reading-books/               # Book reviews section
│   └── _index.md                # categories: ["book-reviews"]
├── archive/                     # Archive page
│   └── _index.md
└── about/
    └── index.md
```

### Taxonomies

The theme uses two taxonomies:

1. **Categories**: Primary content organization and filtering
   - Used for section filtering
   - Displayed with posts in archives
   - Multi-category support (posts can have multiple)

2. **Tags**: Detailed topical tagging
   - Displayed in post metadata
   - Used for content discovery
   - Not used for section filtering

## Special Features

### Archive Page

Create an archive at `content/archive/_index.md`:

```yaml
---
title: "Archive"
---
```

Posts automatically group by year and month in reverse chronological order.

### Newsletter Subscription

Configure Mailchimp integration in `hugo.toml`:

```toml
[params]
mailchimp_user_id = "your_user_id"
mailchimp_audience_id = "your_audience_id"
```

The subscription form appears at the bottom of posts (unless `disableSubscribeForm: true`).

### Social Sharing

Social sharing buttons appear automatically below post content. Supports:
- Facebook
- Twitter/X
- LinkedIn
- Email

Disable per page with `disableSocialShare: true`.

### Reply by Email

Readers can reply to posts via email. Configure in `hugo.toml`:

```toml
[params]
reply_to_email = "you@example.com"
```

Disable per page with `disableReplyByMail: true`.

### Dark Mode

Dark mode toggle appears in the header. User preference persists via localStorage.

### Analytics

GoatCounter analytics support. Configure in `hugo.toml`:

```toml
[params]
goatcounter_code = "your_code"
```

## Customization

### Custom Layouts

Create custom layouts in your site's `layouts` directory:

```
layouts/
└── posts/
    └── custom-layout.html
```

Use in front matter:
```yaml
layout: custom-layout
```

### Archetypes

Create default front matter templates in `archetypes/`:

```toml
# archetypes/posts.md
+++
date = '{{ .Date }}'
draft = true
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
categories = [""]
tags = [""]
slug = ""
cover = ""
+++
```

Use with: `hugo new posts/my-post.md`

### Styling

The theme uses TailwindCSS for styling. To customize the theme:

1. **Extend Tailwind Configuration**: Create or modify `tailwind.config.js` in your site root:

```javascript
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: '#your-color',
      },
      fontFamily: {
        sans: ['Your Font', 'sans-serif'],
      },
    },
  },
}
```

2. **Add Custom Styles**: Create custom CSS in your site's `assets/css/` directory and import it in your layouts.

## License

[Your License Here]
