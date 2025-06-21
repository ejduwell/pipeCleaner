# Markdown Syntax Examples

This document provides examples of common Markdown syntax that you can use in your README.md files.

First though, presuming you are editing/updating your README.md/other markdown .md files on "in place" directly on your GitHub (if you're not I highly recommend this), if you haven't already, try playing with the "edit" and "preview" buttons in the upper left. 

I.E. these ones:

![buttonPic](https://github.com/ejduwell/pipeCleaner/blob/main/GitHubHelp/previewCodeButtons.png)

These will only be available for you on your own repositories, but they are very useful for learning/editing markdown (.md files) syntax. 

When you press the "code" button, it shows the underlying markdown code as currently written.

When you press the "preview" button, it shows how that markdown code will render on the webpage.

This is super useful to play with if you're wondering if you did something correctly/want to double check before committing changes after editing.

---

## 🔤 Section Headings

Use the `#` symbol to define headings:

```markdown
# H1 Heading
## H2 Heading
### H3 Heading
#### H4 Heading
##### H5 Heading
###### H6 Heading
```

---

## 🔗 Links

To include a link:

```markdown
[Link Text](https://www.example.com)
```

Example:

[Visit MATLAB](https://www.mathworks.com/)

---

## 🔀 Internal Links (Jump to Sections)

To link to another section of the same file:

```markdown
[Go to Usage Section](#usage)
```

Make sure the section title matches exactly (in lowercase with hyphens for spaces).

---

## 🖼️ Images

To include an image:

```markdown
![Alt Text](https://example.com/image.png)
```

Example:

![OpenAI Logo](https://upload.wikimedia.org/wikipedia/commons/4/4d/OpenAI_Logo.svg)

---

## 🧩 Code Snippets

Use backticks for inline code:

```markdown
Use the `addpath` function in MATLAB.
```

Use triple backticks for blocks:

<pre>
```matlab
% MATLAB example
data = load('myData.mat');
plot(data.x, data.y);
```
</pre>

Specify the language (`matlab`, `bash`, `python`, etc.) after the opening triple backticks to enable syntax highlighting.

---

## 📋 Lists

Unordered list:

```markdown
- Item 1
- Item 2
  - Subitem 2a
  - Subitem 2b
```

Ordered list:

```markdown
1. First
2. Second
3. Third
```

---

## 📑 Blockquotes

Use `>` for blockquotes:

```markdown
> This is a blockquote.
> Great for notes or highlighting important info.
```

---

## 🛠 Horizontal Rule

Use three dashes:

```markdown
---
```

---

## ⛓ Code Reference (Linking to GitHub Files)

Linking to a file in your GitHub repository:

```markdown
[Script Name](./scripts/myScript.m)
```

Jumping to a section within a GitHub README:

```markdown
[See Overview](#overview)
```

---

## 📚 Helpful/Cool Resources

- [Markdown Cheat Sheet](https://www.markdownguide.org/cheat-sheet/)
- [Basic Syntax](https://www.markdownguide.org/basic-syntax/)
- [Extended Syntax](https://www.markdownguide.org/extended-syntax/)
- [Jekyll: Cool free tool for converting .md files into websites](https://jekyllrb.com/)
- [GitHub Pages: allows you to build a from-scratch website (using Jekyll) and host for free from on your GitHub](https://pages.github.com/)

---
