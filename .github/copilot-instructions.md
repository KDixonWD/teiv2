This repository contains an Astro-based static site for TEI Electrical located in the `TEIV2/` subfolder. Use these focused guidelines when making changes or creating new code.

## Project Setup & Commands
- **Project root**: Work primarily inside `TEIV2/` — that's the Astro site
- **Start/dev/build**: Run commands from `TEIV2/`:
  - `npm install` — Install dependencies
  - `npm run dev` — Start local dev server (localhost:4321)
  - `npm run build` — Build production site to `./dist/`
  - Always test changes with `npm run dev` before committing

## Key Files & Structure
- `TEIV2/astro.config.mjs` — Site `base: '/teiv2/'` and `site` URL for GitHub Pages deployment
- `TEIV2/src/pages/` — Page routes (each `.astro` file = route, e.g., `contact.astro` → `/teiv2/contact`)
- `TEIV2/src/components/` — Reusable UI components
- `TEIV2/src/layouts/BaseLayout.astro` — Main layout wrapper (includes Header, Footer, WhyChooseUs, Testimonials, ContactModal)
- `TEIV2/public/` — Static assets served as-is (images, favicon, global.css)
- `TEIV2/src/assets/` — Bundled assets imported in components
- `TEIV2/public/styles/global.css` — CSS variables and global styles

## Routing & Links
- **CRITICAL**: All internal links use absolute paths prefixed with `/teiv2/` (see `Header.astro`, `Footer.astro`)
- To add a page: Create `TEIV2/src/pages/<name>.astro` and link using `/teiv2/<name>`
- Never change `base` in `astro.config.mjs` without updating all links site-wide

## Component Architecture Patterns
- **Standard page structure**: Import `BaseLayout` → use `PageHero` for non-index pages → add sections
- **Section headers**: Use `SectionHeader.astro` component OR inline pattern:
  ```astro
  <div class="section-header">
    <div class="section-line"></div>
    <h2 class="section-title">Title</h2>
  </div>
  ```
- **Section line**: 3px yellow-to-green gradient: `linear-gradient(90deg, var(--color-accent) 0%, var(--color-primary) 50%, transparent 100%)`
- **Section wrapper**: Use `Section.astro` component for consistent lightning SVG decorations and theme control
- **Hero patterns**: `Hero.astro` (carousel for index) vs `PageHero.astro` (static hero for subpages)

## Design System & Styling
### Color Tokens (from `global.css`)
```css
--brand-dark: #606061 (grey)
--brand-yellow: #FDEE21 (accent)
--brand-green: #2A9134 (primary)
--brand-green-deep: #054A29
--brand-black: #0D0D0E
```
- Use `var(--color-accent)` for yellow, `var(--color-primary)` for green
- Never hardcode colors — always use CSS variables

### Typography & Gradients
- **Font stack**: 'Roboto', system-ui, -apple-system (from global.css)
- **White gradient text** (section titles):
  ```css
  background: linear-gradient(135deg, #ffffff 0%, rgba(255, 255, 255, 0.8) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  ```
- **Yellow-to-white gradient** (emphasis):
  ```css
  background: linear-gradient(135deg, var(--color-accent) 0%, #ffffff 100%);
  ```

### Dark Theme Cards (Footer, Contact, Emergency)
- **Background**: `linear-gradient(135deg, rgba(46, 46, 46, 0.95) 0%, rgba(38, 38, 38, 0.95) 100%)`
- **Border**: `1px solid rgba(96, 96, 97, 0.3)` — hover: `rgba(253, 238, 33, 0.3)`
- **Text colors**: White at 85-95% opacity for body, 50% for labels
- **Danger variant** (emergency): Red-tinted background `rgba(60, 30, 35, 0.95)`, border `rgba(220, 53, 69, 0.4)`

### Button Styling
- **Primary button**: Yellow background (`var(--color-accent)`), black text, rounded (`border-radius: 50px`)
- **Hover effect**: Slide-in overlay using `::before` pseudo-element with `transform: translateX(-100%)`
- **Shadow**: `box-shadow: 0 4px 16px rgba(253, 238, 33, 0.4)`
- See `ContactForm.astro` button for reference implementation

## Component Conventions
- **Scoped styles**: Keep CSS inside `<style>` blocks unless it affects global layout
- **Scripts**: Use TypeScript-aware vanilla JS with proper type assertions:
  ```typescript
  const form = document.querySelector<HTMLFormElement>('.contact-form');
  if (!form) return;
  ```
- **Asset imports**: Import images from `src/assets/` for bundling: `import logoUrl from '../assets/global/TEI_logo.png'`
- **SVG icons**: Import and use as components: `import PhoneIcon from '../assets/icons/phone.svg'` → `<PhoneIcon class="icon" />`
- **Accessibility**: Always include ARIA attributes (`aria-label`, `aria-hidden`, `role`) on interactive elements

## Form Handling (Netlify Forms)
- `ContactForm.astro` and `ContactModal.astro` use Netlify Forms
- Required attributes: `data-netlify="true"`, `netlify-honeypot="bot-field"`, hidden `form-name` field
- JS handles submission with fetch POST to `/` as `application/x-www-form-urlencoded`
- Success/error messages styled with `.form-message--success` / `.form-message--error`

## Layout Components
- **BaseLayout**: Auto-includes Header, Footer, WhyChooseUs, Testimonials, ContactModal on every page
- **ContactModal**: Triggered site-wide via `data-open-contact-modal` attribute on buttons
- **Mobile nav**: Slide-in panel from right, uses `details`/`summary` for dropdowns with one-open-at-a-time JS enforcement

## Responsive Breakpoints
- Mobile-first approach
- Key breakpoint: `768px` for two-column layouts
- Large screens: `1024px` for expanded spacing/padding
- Max container width: `1200px`

## TypeScript Considerations
- Astro components support TS in frontmatter and script blocks
- Always type-cast DOM queries: `querySelector<HTMLElement>`, `querySelector<HTMLFormElement>`
- Use null checks before accessing properties: `if (!element) return;`
- Non-null assertions (`element!`) only when already checked in parent scope

## Common Pitfalls
- ❌ Don't forget `/teiv2/` prefix on internal links
- ❌ Don't hardcode colors — use CSS variables
- ❌ Don't mix `public/` static paths with `src/assets/` imports
- ❌ Don't skip `aria-*` attributes on interactive elements
- ❌ Don't use `var` — use `const`/`let` in scripts
- ✅ Always test with `npm run dev` before pushing
- ✅ Check browser console for Astro build errors

## Deployment
- Target: GitHub Pages (hence `base: '/teiv2/'`)
- Forms require Netlify deployment for backend processing
- Build output: `TEIV2/dist/` after `npm run build`
