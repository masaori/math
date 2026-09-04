export type ChapterEntry = {
  level: number
  id: string
  title: string
  number: string
}

export type ChapterNode = ChapterEntry & { children: ChapterNode[] }

export const buildChapterTree = (entries: readonly ChapterEntry[]): ChapterNode[] => {
  const roots: ChapterNode[] = []
  const stack: ChapterNode[] = []

  for (const entry of entries) {
    const node: ChapterNode = { ...entry, children: [] }
    while (stack.length > 0 && stack[stack.length - 1]!.level >= node.level) stack.pop()
    const parent = stack[stack.length - 1]
    if (parent === undefined) roots.push(node)
    else parent.children.push(node)
    stack.push(node)
  }

  return roots
}

const entryLabel = (entry: ChapterEntry): string =>
  `${entry.number === '' ? '' : `${entry.number}　`}${entry.title}`

const renderTree = (nodes: readonly ChapterNode[]): string => {
  const items = nodes.map((node) => {
    const children = node.children.length === 0 ? '' : renderTree(node.children)
    return (
      `<li><a class="chapter-link" data-target="${node.id}" href="#${node.id}">` +
      `${entryLabel(node)}</a>${children}</li>`
    )
  }).join('')
  return `<ul>${items}</ul>`
}

// モバイルの目次パネルはページに 1 つだけ置く。ハンバーガーの aria-controls から引くので id を固定する。
const MOBILE_MENU_ID = 'chapter-navigation-menu'

export type ChapterNavigation = {
  desktopHtml: string
  mobileHtml: string
}

export const renderChapterNavigation = (entries: readonly ChapterEntry[]): ChapterNavigation => {
  const roots = buildChapterTree(entries)
  if (roots.length === 0) return { desktopHtml: '', mobileHtml: '' }

  const desktopHtml =
    `<aside class="chapter-navigation chapter-navigation--desktop" aria-label="章の目次">` +
    `<div class="chapter-navigation__title">目次</div>${renderTree(roots)}</aside>`
  const mobileHtml =
    `<nav class="chapter-navigation chapter-navigation--mobile" aria-label="章の目次">` +
    `<div class="chapter-navigation__bar">` +
    `<button type="button" class="chapter-navigation__toggle" aria-expanded="false"` +
    ` aria-controls="${MOBILE_MENU_ID}" aria-label="目次を開く">` +
    `<span class="chapter-navigation__burger" aria-hidden="true"></span>` +
    `<span class="chapter-navigation__toggle-text">目次</span></button>` +
    `<span class="chapter-navigation__current" data-chapter-current></span>` +
    `</div>` +
    `<div class="chapter-navigation__menu" id="${MOBILE_MENU_ID}" hidden>${renderTree(roots)}</div>` +
    `</nav>`

  return { desktopHtml, mobileHtml }
}

export const CHAPTER_NAVIGATION_CSS = String.raw`
.page-layout { width:min(100%, 1260px); margin:0 auto; padding:32px 24px 96px; display:grid;
  grid-template-columns:minmax(220px, 300px) minmax(0, 860px); gap:48px; box-sizing:border-box; }
.document { min-width:0; }
.chapter-navigation { font-family:-apple-system,"Hiragino Sans","Noto Sans JP",sans-serif; }
.chapter-navigation ul { list-style:none; margin:0; padding:0; }
.chapter-navigation a { display:block; color:var(--muted); text-decoration:none; line-height:1.45; }
.chapter-navigation a:hover { color:var(--fg); }
.chapter-navigation a.is-active { color:var(--fg); font-weight:650; }
.chapter-navigation a[aria-current="location"] { color:var(--accent); }
.chapter-navigation--desktop { position:sticky; top:24px; align-self:start; max-height:calc(100vh - 48px);
  overflow:auto; overscroll-behavior:contain; border-right:1px solid var(--line); padding:4px 24px 12px 0; }
.chapter-navigation__title { margin-bottom:12px; color:var(--fg); font-size:.78rem; font-weight:700;
  letter-spacing:.12em; }
.chapter-navigation--desktop li { position:relative; margin:3px 0; }
.chapter-navigation--desktop li > a { padding:5px 7px; border-radius:6px; font-size:.82rem; }
.chapter-navigation--desktop li > a.is-active { background:var(--panel); }
.chapter-navigation--desktop li > ul { margin:2px 0 4px 12px; padding-left:12px; border-left:1px solid var(--line); }
.chapter-navigation--desktop li > ul > li::before { content:""; position:absolute; top:1.05em; left:-12px;
  width:9px; border-top:1px solid var(--line); }
.chapter-navigation--mobile { display:none; }
[id^="sec-"] { scroll-margin-top:24px; }
@media (max-width: 860px) {
  .chapter-navigation--desktop { display:none; }
  .chapter-navigation--mobile { position:sticky; top:0; z-index:20; display:block;
    background:color-mix(in srgb, var(--bg) 94%, transparent);
    border-bottom:1px solid var(--line); backdrop-filter:blur(12px); }
  .chapter-navigation__bar { display:flex; align-items:center; gap:10px; padding:6px 12px; }
  .chapter-navigation__toggle { display:inline-flex; align-items:center; gap:8px; flex:0 0 auto;
    padding:8px 12px; border:1px solid var(--line); border-radius:999px; background:transparent;
    color:var(--fg); font:inherit; font-size:.86rem; line-height:1; cursor:pointer; }
  .chapter-navigation__toggle:focus-visible { outline:2px solid var(--accent); outline-offset:2px; }
  .chapter-navigation__toggle[aria-expanded="true"] { background:var(--panel); }
  .chapter-navigation__burger { position:relative; display:inline-block; width:14px; height:10px; }
  .chapter-navigation__burger::before, .chapter-navigation__burger::after { content:""; }
  .chapter-navigation__burger, .chapter-navigation__burger::before, .chapter-navigation__burger::after {
    border-top:2px solid currentColor; box-sizing:border-box; }
  .chapter-navigation__burger::before { position:absolute; left:0; right:0; top:4px; }
  .chapter-navigation__burger::after { position:absolute; left:0; right:0; top:8px; }
  .chapter-navigation__current { flex:1 1 auto; min-width:0; overflow:hidden; text-overflow:ellipsis;
    white-space:nowrap; color:var(--muted); font-size:.82rem; }
  .chapter-navigation__menu { max-height:min(70vh, 520px); overflow:auto; overscroll-behavior:contain;
    padding:4px 14px 14px; border-top:1px solid var(--line); }
  .chapter-navigation__menu[hidden] { display:none; }
  .chapter-navigation__menu li { margin:2px 0; }
  .chapter-navigation__menu a { padding:9px 8px; border-radius:6px; font-size:.88rem; }
  .chapter-navigation__menu a.is-active { color:var(--fg); background:var(--panel);
    box-shadow:inset 0 0 0 1px var(--line); }
  .chapter-navigation__menu li > ul { margin:2px 0 4px 10px; padding-left:10px; border-left:1px solid var(--line); }
  .page-layout { display:block; padding:24px 18px 80px; }
  [id^="sec-"] { scroll-margin-top:72px; }
}`

export const CHAPTER_NAVIGATION_SCRIPT = String.raw`
(function () {
  var links = Array.prototype.slice.call(document.querySelectorAll('.chapter-link'));
  if (links.length === 0) return;
  var targets = [];
  var seen = Object.create(null);
  links.forEach(function (link) {
    var id = link.dataset.target;
    if (seen[id]) return;
    var target = document.getElementById(id);
    if (target !== null) { seen[id] = true; targets.push(target); }
  });

  var mobileNav = document.querySelector('.chapter-navigation--mobile');
  var toggle = mobileNav === null ? null : mobileNav.querySelector('.chapter-navigation__toggle');
  var menu = mobileNav === null ? null : mobileNav.querySelector('.chapter-navigation__menu');
  var currentLabel = mobileNav === null ? null : mobileNav.querySelector('[data-chapter-current]');

  var setMenuOpen = function (open) {
    if (toggle === null || menu === null) return;
    menu.hidden = !open;
    toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
    toggle.setAttribute('aria-label', open ? '目次を閉じる' : '目次を開く');
    if (!open) return;
    var activeItem = menu.querySelector('.is-active');
    if (activeItem !== null) activeItem.scrollIntoView({ block: 'center' });
  };
  var isMenuOpen = function () { return toggle !== null && toggle.getAttribute('aria-expanded') === 'true'; };

  if (toggle !== null && menu !== null) {
    toggle.addEventListener('click', function () { setMenuOpen(!isMenuOpen()); });
    // 目次から章を選んだら閉じる。開いたまま残ると本文が読めない。
    menu.addEventListener('click', function (event) {
      if (event.target.closest('.chapter-link') !== null) setMenuOpen(false);
    });
    document.addEventListener('keydown', function (event) {
      if (event.key !== 'Escape' || !isMenuOpen()) return;
      setMenuOpen(false);
      toggle.focus();
    });
    // 外側の操作で閉じる。キーボードで目次の外へ移ったときも閉じる。
    document.addEventListener('pointerdown', function (event) {
      if (!isMenuOpen() || mobileNav.contains(event.target)) return;
      setMenuOpen(false);
    });
    document.addEventListener('focusin', function (event) {
      if (!isMenuOpen() || mobileNav.contains(event.target)) return;
      setMenuOpen(false);
    });
    window.addEventListener('resize', function () {
      if (isMenuOpen() && !window.matchMedia('(max-width: 860px)').matches) setMenuOpen(false);
    });
  }

  var activeTarget = '';
  var update = function () {
    var threshold = window.matchMedia('(max-width: 860px)').matches ? 80 : 32;
    var current = targets[0];
    targets.forEach(function (target) {
      if (target.getBoundingClientRect().top <= threshold) current = target;
    });
    if (current === undefined || current.id === activeTarget) return;
    activeTarget = current.id;
    links.forEach(function (link) {
      var isActive = link.dataset.target === activeTarget;
      link.classList.toggle('is-active', isActive);
      if (isActive) link.setAttribute('aria-current', 'location');
      else link.removeAttribute('aria-current');
    });
    if (currentLabel !== null) {
      // 目次を閉じている間も、いまどこを読んでいるかがバーに残る。
      var activeLink = links.find(function (link) { return link.dataset.target === activeTarget; });
      currentLabel.textContent = activeLink === undefined ? '' : activeLink.textContent;
    }
  };

  var queued = false;
  var requestUpdate = function () {
    if (queued) return;
    queued = true;
    requestAnimationFrame(function () { queued = false; update(); });
  };
  window.addEventListener('scroll', requestUpdate, { passive: true });
  window.addEventListener('resize', requestUpdate);
  window.addEventListener('hashchange', requestUpdate);
  update();
})();`
