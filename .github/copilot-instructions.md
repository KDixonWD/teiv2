This repository contains an Astro-based static site located in the `TEIV2/` subfolder. Use these focused guidelines when making changes or creating new code.

- Project root: work primarily inside `TEIV2/` — that's the Astro site.
- Start/dev/build: run commands from `TEIV2/`:
  - `npm install`
  - `npm run dev` (local dev server)
  - `npm run build` (production build)

- Key files to inspect before editing:
  - `TEIV2/astro.config.mjs` — site `base` and `site` are set here (`base: '/teiv2/'`).
  - `TEIV2/package.json` — scripts and Astro version (v5.x).
  - `TEIV2/src/pages/` — page routes (each `.astro` file maps to a route).
  - `TEIV2/src/components/` — UI components (e.g., `Header.astro`, `Hero.astro`).
  - `public/` and `TEIV2/src/assets/` — static images and icons. `src/assets` files are imported in components; `public/` is for static files served as-is.
  - `public/styles/global.css` — global styles and CSS variables used across components.

- Routing and links:
  - Many templates use absolute paths prefixed with `/teiv2/` (see `src/components/Header.astro`). Keep this pattern when editing links unless you're intentionally changing `astro.config.mjs` `base`.
  - To add a page, create `TEIV2/src/pages/<name>.astro`; link from nav using the same `/teiv2/<name>` pattern or a relative link consistent with other pages.

- Component patterns and conventions to follow:
  - Components are plain `.astro` files combining frontmatter, markup, inline `<style>` and inline `<script>` blocks (see `Header.astro`). Keep related CSS/JS scoped inside the component unless the change affects global layout.
  - Images are sometimes imported (example: `import logoUrl from '../assets/global/TEI_logo.png'`) — prefer asset imports when the image is inside `src/assets/` so bundling works.
  - Accessibility is used (ARIA attributes on nav and mobile controls). Preserve `aria-*` attributes and semantic elements when refactoring.

- Build/deploy considerations:
  - `astro.config.mjs` sets `base: '/teiv2/'` and `site` for GitHub Pages — do not change base unless changing the deployment target.
  - When testing local dev, run `npm run dev` from `TEIV2/`. Built output lives in `dist/` after `npm run build` and will include `base` in URLs.

- Coding style notes (discoverable patterns):
  - Small, self-contained components live in `src/components/`; page-level composition is in `src/pages/`.
  - Dropdowns use `<details>` + `summary` and custom scripts to enforce one-open-at-a-time behavior (see `Header.astro`).
  - Navigation links use strong BEM-like classes (`nav-item`, `nav-link`, etc.) and CSS variables for colors — prefer reusing existing variables in `global.css`.

- When making edits:
  - Run `npm run dev` and open the local server to verify visual changes.
  - Check console output for Astro build errors (incorrect imports, missing assets, or JSX-like syntax in `.astro` frontmatter).
  - Keep changes minimal and isolated to the component/page unless a cross-cutting change is required.

- Styles / colors (important):
  - Primary global stylesheet: `public/styles/global.css`.
  - The project uses CSS custom properties for theming (example seen in `Header.astro`: `--color-accent`). Prefer reusing existing variables rather than hard-coding colors in components.
  - To change a site-wide color, update the variable in `public/styles/global.css` (search for `:root` or the variables block).
  - Component-scoped styles exist inside `.astro` components. For layout-wide changes (spacing, breakpoints, colors) prefer `global.css` so changes cascade consistently.
  - When adding new variables, use a clear name (`--color-accent`, `--color-bg-muted`) and add a short comment in `global.css` to explain usage.
  - Example: `Header.astro` applies `var(--color-accent)` to navigation elements and icons — changing that variable will update the header theme.

If anything here is unclear or you want me to add deployment steps or testing commands, tell me which areas to expand.
