# equation-anchors

A [Quarto](https://quarto.org/) extension that adds visual URL anchor links to
display equations in HTML output.

## Installation

```bash
quarto add d-morrison/equation-anchors
```

This installs the extension into `_extensions/d-morrison/equation-anchors/`
in your Quarto project.

## Usage

Add the extension as a filter in your document or project configuration:

```yaml
filters:
  - d-morrison/equation-anchors
```

For HTML/revealjs output, the extension adds a left-side anchor link to every
display equation so readers can copy a direct URL to that equation.
Unlabeled equations receive an auto-generated `eq-anchor-N` identifier;
labeled equations (those with an `{#eq-*}` identifier) use their existing id.

## Example

See [`example.qmd`](example.qmd) for a minimal demonstration.
