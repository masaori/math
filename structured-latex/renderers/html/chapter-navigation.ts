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

const renderTree = (nodes: readonly ChapterNode[], rootId?: string): string => {
  const items = nodes.map((node) => {
    const currentRootId = rootId ?? node.id
    const children = node.children.length === 0 ? '' : renderTree(node.children, currentRootId)
    return (
      `<li><a class="chapter-link" data-target="${node.id}" data-root-target="${currentRootId}" href="#${node.id}">` +
      `${entryLabel(node)}</a>${children}</li>`
    )
  }).join('')
  return `<ul>${items}</ul>`
}

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
  const mobileTabs = roots.map((root) =>
    `<li><a class="chapter-link" data-target="${root.id}" data-root-target="${root.id}" href="#${root.id}">${entryLabel(root)}</a></li>`,
  ).join('')
  const mobileHtml =
    `<nav class="chapter-navigation chapter-navigation--mobile" aria-label="章の目次">` +
    `<ul>${mobileTabs}</ul></nav>`

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
  .chapter-navigation--mobile { position:sticky; top:0; z-index:20; display:block; overflow-x:auto;
    overscroll-behavior-x:contain; scrollbar-width:none; background:color-mix(in srgb, var(--bg) 94%, transparent);
    border-bottom:1px solid var(--line); backdrop-filter:blur(12px); }
  .chapter-navigation--mobile::-webkit-scrollbar { display:none; }
  .chapter-navigation--mobile ul { display:flex; width:max-content; min-width:100%; padding:8px 12px; box-sizing:border-box; }
  .chapter-navigation--mobile li { flex:0 0 auto; }
  .chapter-navigation--mobile a { padding:8px 12px; border-radius:999px; white-space:nowrap; font-size:.86rem; }
  .chapter-navigation--mobile a.is-active { color:var(--fg); background:var(--panel); box-shadow:inset 0 0 0 1px var(--line); }
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
  var activeTarget = '';
  var activeRoot = '';
  var update = function () {
    var threshold = window.matchMedia('(max-width: 860px)').matches ? 80 : 32;
    var current = targets[0];
    targets.forEach(function (target) {
      if (target.getBoundingClientRect().top <= threshold) current = target;
    });
    if (current === undefined || current.id === activeTarget) return;
    activeTarget = current.id;
    var matchingLink = links.find(function (link) { return link.dataset.target === activeTarget; });
    activeRoot = matchingLink === undefined ? activeTarget : matchingLink.dataset.rootTarget;
    links.forEach(function (link) {
      var isMobile = link.closest('.chapter-navigation--mobile') !== null;
      var isActive = isMobile ? link.dataset.target === activeRoot : link.dataset.target === activeTarget;
      link.classList.toggle('is-active', isActive);
      if (isActive) link.setAttribute('aria-current', 'location');
      else link.removeAttribute('aria-current');
    });
    if (mobileNav !== null) {
      var activeTab = mobileNav.querySelector('.is-active');
      if (activeTab !== null) {
        var left = activeTab.offsetLeft - (mobileNav.clientWidth - activeTab.offsetWidth) / 2;
        mobileNav.scrollTo({ left: Math.max(0, left), behavior: 'smooth' });
      }
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
