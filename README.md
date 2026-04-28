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

For HTML/revealjs output, the extension appends an anchor link to each display
equation with an `eq-` identifier so readers can copy a direct URL to that
equation.

## Example

See [`example.qmd`](example.qmd) for a minimal demonstration.
