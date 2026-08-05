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

The theme ships no `content/` directory, so importing it adds layouts, assets,
static files and archetypes to your site and nothing else. The demo pages you
see in the [example site](#developing-the-theme) — including the typography
specimen — live under `exampleSite/`, which is its own Go module and is
therefore excluded from the module consuming sites download.

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
copyright = "&copy; {year} Your Name. All rights reserved."
reply_to_email = "you@example.com"
mailchimp_user_id = "your_mailchimp_user_id"
mailchimp_audience_id = "your_mailchimp_audience_id"
goatcounter_code = "your_goatcounter_code"

# Homepage
home_latest_post_full = false
home_featured_exclude_categories = ["notes"]

# Section listings
section_exclude_categories = []

# Author information (used in RSS feed)
[params.author]
name = "Your Name"
email = "you@example.com"
```

In `copyright`, the token `{year}` is replaced with the current year each time the
site is built, so the footer never goes stale. Everything else in the string is
left alone, and it is rendered as Markdown — a config with a literal year still
works unchanged. For a range, write it out: `"&copy; 2015–{year} Your Name"`.

### Menu Configuration

Configure your navigation menus. Any main-menu entry that has children renders as
a dropdown, so you can define several:

```toml
# Main navigation
[[menus.main]]
name = "Home"
url = "/"
weight = 1

# A dropdown: an entry with an identifier, plus entries naming it as `parent`
[[menus.main]]
name = "Reading"
identifier = "reading"
weight = 2

[[menus.main]]
name = "Book Reviews"
parent = "reading"
url = "/book-reviews"
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

### Merged Sections

Leave `categories` off a section's `_index.md` and it becomes a merged listing:
every post in the `posts` section, minus the categories named in
`section_exclude_categories`. Use it to replace several topic sections with one
combined view.

```toml
# hugo.toml
[params]
section_exclude_categories = ["book-reviews"]
```

```yaml
# content/posts/_index.md
---
title: "Writing"
aliases: ["/tech-ai/", "/insights/"]   # keep the old section URLs working
---
```

The exclusion applies **only** to sections without their own `categories`. A
section that does set them keeps its include filter and ignores the list — so a
section devoted to an excluded category still lists its posts, which is what you
want for a book-reviews landing page alongside a merged feed that omits them.

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

The homepage leads with the most recent post, followed by the newsletter form and
a grid of the next six posts. It is configured from `[params]` in `hugo.toml`, not
from front matter:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `home_latest_post_full` | boolean | `false` | Render the featured post in full. When `false`, its first two paragraphs are shown with a "Read more →" link. |
| `home_featured_exclude_categories` | array | `["notes"]` | Categories barred from the featured slot. Set to `[]` to exclude nothing. |

Posts excluded from the featured slot still appear in the "Recent Articles" grid —
only `notes` is kept out of that. So excluding `book-reviews` here keeps reviews
out of the hero position while leaving them in the grid.

A post whose front matter sets `layout: book-review` is featured using the
book-review layout (cover and rating on the left, review text on the right), the
same one its own page uses.

Body copy in `content/_index.md` is not rendered on the homepage.

### Control Parameters

Disable specific features on individual pages:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `disableSubscribeForm` | boolean | false | Hide newsletter subscription form |
| `disableReplyByMail` | boolean | false | Hide "reply by email" option |

Example:
```yaml
---
title: "About"
disableSubscribeForm: true
disableReplyByMail: true
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

The theme uses TailwindCSS v4, which is configured **in CSS** — there is no
`tailwind.config.js`. Styles are authored in `src/input.css` and compiled to
`assets/css/styles.css`, which is **committed to the repo**. Hugo never runs
Tailwind, so after editing `src/input.css` you must rebuild:

```bash
npm install
npm run build:css      # one-shot
npm run watch:css      # rebuild on change while developing
```

Colors, fonts and other design tokens live in the `@theme` block at the top of
`src/input.css`:

```css
@theme {
    --font-sans: "Your Font", ui-sans-serif, system-ui, sans-serif;
    --color-accent: rgb(252, 108, 12);
}
```

#### Fonts

The theme ships **[Source Sans 3](https://github.com/adobe-fonts/source-sans)**,
self-hosted from `assets/fonts/` — no Google Fonts request, so no visitor IPs go
to a third party. Both files are variable woff2 covering the whole 200–900 weight
axis (~28 KB each), so every weight the theme uses comes from one download. The
`@font-face` rules are in `layouts/_partials/head/fonts.html` rather than in
`src/input.css`, because in production the stylesheet is inlined into a `<style>`
block, where a relative `url()` would resolve against the page URL and break.

Two variables in `src/input.css` control the theme's overall weight:

```css
:root {
    --prose-weight: 300;    /* body copy; 400 for a more solid look */
    --display-weight: 300;  /* article h1 */
    --prose-size: 18px;     /* base size for article content */
}
```

`--prose-size` sets the size of the whole article, not just paragraphs. Headings,
blockquotes, tables, code and footnotes are all sized in `em` off that base, so
changing this one value scales the article as a system and keeps every
relationship intact. It is set to 18px rather than the more usual 16px because
Source Sans 3 has a modest x-height and reads smaller than a system sans at the
same nominal size.

Article text colour comes from the `@theme` tokens, not from utility classes on
the layouts — so it is also a single place to change:

```css
@theme {
    --color-text-light: #333333;           /* body and headings */
    --color-text-dark: #e5e5e5;            /* the same, in dark mode */
    --color-text-secondary-light: #666666; /* h6, muted text */
    --color-text-secondary-dark: #a3a3a3;
}
```

`#333` is deliberately softer than a true black; Tailwind's stock palette has no
equivalent (`neutral-700` is `#404040`, `neutral-800` is `#262626`). On white it
gives a 12.6:1 contrast ratio, still well past WCAG AAA.

Headings below h1 use a fixed scale where weight rises as size falls
(h2 1.75em/400 → h6 0.875em/700 uppercase), so the hierarchy holds no matter how
you set the two knobs above. Note that Tailwind's reset zeroes heading margins,
so every level sets its own — if you add a heading rule, give it a margin.

Body copy is Light (300), which makes the `article strong, article b` rule
load-bearing — keep it. Tailwind's reset sets `font-weight: bolder` on those, and
`bolder` is *relative*: from a 300 base the CSS spec resolves it to 400, so bold
prose would stop looking bold.

The monospace stack is pinned to 400 for a related reason: it isn't Source Sans 3,
and faces like Menlo, Monaco and Consolas ship no Light weight, so an inherited
300 would resolve differently depending on which font the OS supplies.

Dark mode deliberately uses the same weight as light. Light-on-dark text blooms
optically, so it reads *heavier* than the same weight on white, not lighter — if
dark ever needs adjusting, soften `--color-text-dark` rather than adding weight.

To swap in a different font, replace the files in `assets/fonts/`, update the
`@font-face` rules in `layouts/_partials/head/fonts.html`, and change `--font-sans`.
Note that a family name containing a digit — like `"Source Sans 3"` — **must** be
quoted; unquoted it is a CSS parse error.

To use a CDN instead, delete `assets/fonts/` and `head/fonts.html` and put this in
`layouts/_partials/head.html` — at the cost of two extra origins on the critical
path and the privacy tradeoff above:

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Source+Sans+3:ital,wght@0,200..900;1,200..900&display=swap">
```

The example site's `/posts/typography-specimen/` is a kitchen-sink page for
checking type changes — a weight ladder, headings, bold/italic, tables, code and
footnotes on one page. See [Developing the theme](#developing-the-theme) for how
to run it.

2. **Add Custom Styles**: Create custom CSS in your site's `assets/css/` directory and import it in your layouts.

## Developing the theme

The theme repository root holds only the theme itself. The demo site lives in
`exampleSite/` and consumes the theme the same way a real site does — through a
Hugo module import, with a `replace` directive pointing at the working tree — so
mount and config problems surface in development rather than in someone's blog.

Run it from the repository root:

```bash
hugo server -s exampleSite
```

Rebuild the stylesheet while working on `src/input.css`:

```bash
./run_tailwind.sh   # or: npm run watch:css
```

Two rules keep the theme from leaking demo material into consuming sites:

- **Never add a `content/` directory to the repository root.** Hugo mounts a
  module's `content/` into the importing site by default, so demo pages placed
  there are published on every site that uses the theme. Put them in
  `exampleSite/content/`.
- **Keep the root `hugo.toml` minimal.** It is merged into consuming sites, so
  anything defined there — `params`, `menus`, `baseURL` — becomes a silent
  fallback for sites that don't override it. Demo configuration belongs in
  `exampleSite/hugo.toml`.

## License

[Your License Here]

### Bundled fonts

[Source Sans 3](https://github.com/adobe-fonts/source-sans) by Adobe, licensed
under the [SIL Open Font License 1.1](assets/fonts/OFL.txt). The font files in
`assets/fonts/` are the Latin subsets published by
[Fontsource](https://fontsource.org/fonts/source-sans-3); redistributing them
requires keeping `OFL.txt` alongside them.
