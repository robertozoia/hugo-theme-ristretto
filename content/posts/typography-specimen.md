+++
title = 'Typography Specimen'
date = 2024-01-01T09:00:00-07:00
draft = false
tags = ['meta']
description = 'A kitchen-sink page exercising every typographic rule in the theme.'
+++

A reference page for judging the theme's type. It exercises every rule in
`src/input.css` — headings, prose weight, bold, italic, code, lists, tables,
blockquotes and footnotes — so a font or weight change can be evaluated at a
glance. Delete this file, or set `draft = true`, before deploying.

The body text you are reading now is the theme's default prose weight, set by
`--prose-weight` in `src/input.css`. This paragraph is deliberately long enough
to judge as a block rather than a line, because weight and colour only really
show up in mass. Look at the overall grey of the paragraph, then at whether
individual letterforms still feel crisp at the edges.

## The weight ladder

The single most useful test. Each line is the same sentence at a different
weight — the theme uses all five. If two adjacent lines are hard to tell apart,
the font isn't loading and you're seeing a synthesised fallback.

{{< specimen weight="300" >}}300 Light — Sphinx of black quartz, judge my vow. 0123456789{{< /specimen >}}
{{< specimen weight="400" >}}400 Regular — Sphinx of black quartz, judge my vow. 0123456789{{< /specimen >}}
{{< specimen weight="500" >}}500 Medium — Sphinx of black quartz, judge my vow. 0123456789{{< /specimen >}}
{{< specimen weight="600" >}}600 Semibold — Sphinx of black quartz, judge my vow. 0123456789{{< /specimen >}}
{{< specimen weight="700" >}}700 Bold — Sphinx of black quartz, judge my vow. 0123456789{{< /specimen >}}

Same ladder at display size, where light weights earn their keep:

{{< specimen weight="300" size="2.4em" >}}300 Light display{{< /specimen >}}
{{< specimen weight="400" size="2.4em" >}}400 Regular display{{< /specimen >}}

## Inline styles

Body copy with **bold text**, _italic text_, and **_bold italic_** mixed into a
sentence. The bold here is the important one: Tailwind's reset makes `strong`
relative to the inherited weight, so if bold stops looking bold, that rule has
regressed. Italic pulls in a second font file — it should show true cursive
letterforms (note the _a_, _e_, _f_ and _g_), not a mechanical slant.

Also inline: `monospace code`, a [link to somewhere](https://gohugo.io/),
an abbreviation like HTML, and punctuation that reveals a font's character —
"curly quotes", an em dash — like this — ellipsis…, plus accents for Spanish:
¿cómo está usted? ñ á é í ó ú ü ¡olé!

### Heading level three

Headings run h1 through h3 in `src/input.css`; h4–h6 have no rules of their own,
so the four below show what the browser defaults do.

#### Heading level four

##### Heading level five

###### Heading level six

## Lists

Unordered, with nesting:

- First item in the list
- Second item, which runs long enough to wrap onto a second line so the
  indentation and hanging alignment can be checked properly
  - A nested item
  - Another nested item
- Third item with **bold** and _italic_ inside it

Ordered, which the theme renders with CSS counters:

1. First step
2. Second step, also long enough to wrap so the negative text-indent used by the
   counter rule can be verified against a real line break
3. Third step

## Blockquote

> The details are not the details. They make the design. A blockquote is set
> smaller and lighter than body copy, so it is a good place to check whether the
> font holds together at reduced size and contrast.

## Table

| Weight | Name     | Used for                        |
| ------ | -------- | ------------------------------- |
| 300    | Light    | Display headings, metadata      |
| 400    | Regular  | **Body copy**                   |
| 500    | Medium   | Buttons, pagination             |
| 600    | Semibold | Card headings, logo             |
| 700    | Bold     | `article h3`, table headers     |

The **bold cell** above is the regression check: table headers and bold cells
must render heavier than the surrounding text.

## Code

Inline `const x = 42` first, then a block. Code should stay on the monospace
stack — unchanged by the font work — so this is a check that nothing leaked.

```go
// A fenced block: verifies the mono stack and syntax highlighting.
func main() {
	weights := []int{300, 400, 500, 600, 700}
	for _, w := range weights {
		fmt.Printf("Source Sans 3 @ %d\n", w)
	}
}
```

## Footnote

Body text carrying a footnote reference.[^1]

[^1]: Footnotes are set at 0.75rem — the smallest text on the page, and the
first place a too-light weight becomes unreadable.
