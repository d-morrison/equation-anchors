local function in_html_output()
  if quarto and quarto.doc and quarto.doc.is_format then
    return quarto.doc.is_format("html") or quarto.doc.is_format("revealjs")
  end

  return false
end

local function anchor_script()
  return [[
<script>
function getQuartoHeadingAnchorIcon() {
  const afterBodyScript = document.getElementById("quarto-html-after-body");
  if (!afterBodyScript) {
    return null;
  }

  const match = afterBodyScript.textContent.match(/const icon = ["']([^"']+)["']/);
  return match ? match[1] : null;
}

// Quarto chain-link glyph from Bootstrap Icons.
const chainLinkIconFallback = "\ue9cb";
const headingAnchorIcon = getQuartoHeadingAnchorIcon();
const defaultAnchorIconFallback =
  headingAnchorIcon && headingAnchorIcon !== "#" ? headingAnchorIcon : chainLinkIconFallback;

function getDefaultAnchorTemplate() {
  // Prefer Quarto heading anchors first so the visible chain-link icon is reused.
  const defaultAnchor =
    document.querySelector(".anchored > a.anchorjs-link") ||
    document.querySelector("a.anchorjs-link[data-anchorjs-icon]");
  if (!defaultAnchor) {
    return null;
  }

  return {
    // Detect icon value from the template anchor's attribute or text.
    icon: defaultAnchor.getAttribute("data-anchorjs-icon") || defaultAnchor.textContent.trim(),
    hasDataIcon: defaultAnchor.hasAttribute("data-anchorjs-icon"),
    style: defaultAnchor.getAttribute("style")
  };
}

function normalizeAnchorIcon(icon) {
  if (!icon || icon === "#") {
    return defaultAnchorIconFallback;
  }

  return icon;
}

function alignEquationAnchorWithDefault(anchor, template) {
  if (!anchor) {
    return;
  }

  anchor.classList.remove("external");
  anchor.classList.add("no-external");

  const normalizedIcon = normalizeAnchorIcon(template && template.icon);
  anchor.setAttribute("data-anchorjs-icon", normalizedIcon);
  anchor.textContent = normalizedIcon;

  if (template && template.style) {
    anchor.setAttribute("style", template.style);
  } else {
    anchor.removeAttribute("style");
  }
}

function alignEquationAnchorsWithDefault() {
  const template = getDefaultAnchorTemplate();
  document.querySelectorAll("a.equation-anchor").forEach(function (anchor) {
    alignEquationAnchorWithDefault(anchor, template);
  });
}

function ensureEquationAnchorStyles() {
  if (document.getElementById("equation-anchor-styles")) {
    return;
  }

  const style = document.createElement("style");
  style.id = "equation-anchor-styles";
  style.textContent = `
    .equation-anchor-target {
      --equation-anchor-offset: 1.2rem;
      position: relative;
      display: block;
    }
    .equation-anchor {
      position: absolute;
      right: calc(-1 * var(--equation-anchor-offset));
      top: 50%;
      transform: translateY(-50%);
      text-decoration: none;
      opacity: 0.7;
      font-size: 0.9em;
    }
    .equation-anchor:hover {
      opacity: 1;
    }
  `;
  document.head.appendChild(style);
}

document.addEventListener("DOMContentLoaded", function () {
  ensureEquationAnchorStyles();

  const equations = document.querySelectorAll("[id^='eq-']");
  equations.forEach(function (equation) {
    if (equation.querySelector(".equation-anchor")) {
      return;
    }

    const isDisplayMath =
      equation.matches(".math.display") || equation.querySelector(".math.display");
    if (!isDisplayMath) {
      return;
    }

    const id = equation.getAttribute("id");
    if (!id) {
      return;
    }

    equation.classList.add("equation-anchor-target");

    const anchor = document.createElement("a");
    anchor.className = "equation-anchor anchorjs-link";
    anchor.href = "#" + id;
    anchor.setAttribute("aria-label", "Permalink to this equation");
    equation.appendChild(anchor);
  });

  alignEquationAnchorsWithDefault();
});

window.addEventListener("load", alignEquationAnchorsWithDefault);
</script>
]]
end

function Pandoc(doc)
  if not in_html_output() then
    return nil
  end

  table.insert(doc.blocks, pandoc.RawBlock("html", anchor_script()))
  return doc
end
