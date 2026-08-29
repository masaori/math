#!/usr/bin/env node
/**
 * 論文を 1 枚の HTML にする生成器。**入力は `content/` だけ**（`notes/` は読まない）。
 *
 * なぜ要るか: 公開して人が読むのは HTML であり、PDF は手元で読む（ユーザー指示）。
 * `tools/build-latex.ts` と同じ入力・同じ文書順・同じ採番から、出力先だけを変える。
 *
 * 自己完結させる: KaTeX 本体・CSS・フォントを 1 つの .html へ埋め込み、外部の CDN を参照しない
 * （公開先で読み込みが塞がれても壊れないため）。
 *
 * **数式はここでは組まず、TeX のまま埋めてブラウザ側で組む。** ここで組むと出力が 13.6MB になり、
 * 公開先の git 履歴へ 30 分ごとにその大きさが積まれる（公開先は履歴を消さない）。
 * TeX のまま置けば 1.3MB で済む。読んでいる位置の数式だけを組むので、開いたときの待ちも出ない。
 *
 * 採番は LaTeX 側と一致させる。定義・主張・定理・注意・ノートは通し番号を共有し、
 * `\section`（見出し level 2）ごとに振り直す。したがって番号は「章番号.通し番号」になる。
 *
 * 使い方: node tools/build-html.ts [出力先.html]
 */

import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { spawnSync } from "node:child_process";
import { dirname, join } from "node:path";
import { createRequire } from "node:module";

import {
  CHAPTER_NAVIGATION_CSS,
  CHAPTER_NAVIGATION_SCRIPT,
  renderChapterNavigation,
} from "../../../structured-latex/renderers/html/chapter-navigation.ts";
import {
  renderStandingAwareBlock,
  THEOREM_STANDING_CSS,
} from "../../../structured-latex/renderers/html/theorem-standing.ts";
import {
  PRIMARY_ELEMENTS_CSS,
  primaryElementEntriesOf,
  renderPrimaryElementsLead,
} from "../../../structured-latex/renderers/html/primary-elements.ts";
import { standingOf } from "../../../structured-latex/domain-model/index.ts";
import { compileDocumentStructure } from "../schema.ts";
import { finiteGraphDocumentStructure } from "../content/main-text.ts";
import type { HeadingBlock, Node, ProjectMeta, TheoremLikeBlock, TheoremLikeKind } from "../schema.ts";
import type { Label } from "../labels.generated.ts";
import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";

const require = createRequire(import.meta.url);
const katexDist = dirname(require.resolve("katex/dist/katex.min.css"));

const outPath = process.argv[2] ?? join(structuredLatexDir, "build", "document.html");

/** 定理型 kind → 見出し語。LaTeX 側の crefname と一致させる（参照文字列が変わらないように）。 */
const HEADINGS: Record<TheoremLikeKind, string> = {
  definition: "定義",
  claim: "主張",
  theorem: "定理",
  remark: "注意",
  note: "ノート",
};

const escapeHtml = (s: string): string =>
  s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");

const contentFiles = await loadContentFiles();
const compiledStructureResult = compileDocumentStructure<Label, ProjectMeta>(finiteGraphDocumentStructure);
if (!compiledStructureResult.success) {
  throw new Error(`文書構造を解決できない: ${JSON.stringify(compiledStructureResult.error)}`);
}
const compiledStructure = compiledStructureResult.data;

// --- 採番（LaTeX と同じ規則）-------------------------------------------------

type Numbered = { kind: TheoremLikeKind; number: string; blockId: string };
const byLabel = new Map<string, Numbered>();
const sectionOfLabel = new Map<string, string>(); // 見出しラベル → 章番号
let sectionNumber = 0;
let counter = 0;

for (const { blocks } of contentFiles) {
  for (const block of blocks) {
    if (block.kind === "heading") {
      if (block.level === 2) {
        sectionNumber += 1;
        counter = 0;
      }
      for (const label of block.labels) sectionOfLabel.set(label, String(sectionNumber));
      continue;
    }
    if (block.kind === "figure") continue;
    counter += 1;
    const number = `${sectionNumber}.${counter}`;
    for (const label of block.labels) {
      byLabel.set(label, { kind: block.kind, number, blockId: block.id });
    }
  }
}

/** 参照の表示文字列（「定義 3.4」「節 5」）と飛び先。未解決なら生成を止める。 */
function reference(target: string, from: string): { text: string; href: string } {
  const numbered = byLabel.get(target);
  if (numbered !== undefined) {
    return { text: `${HEADINGS[numbered.kind]} ${numbered.number}`, href: `#blk-${numbered.blockId}` };
  }
  const section = sectionOfLabel.get(target);
  if (section !== undefined) return { text: `節 ${section}`, href: `#sec-${target}` };
  throw new Error(`未解決の相互参照がある（生成を中止）: ${from} -> "${target}"`);
}

// --- 数式 --------------------------------------------------------------------

/**
 * 数式の中からブロックを引く `\blkref{ラベル}` は、KaTeX の巨集では解決できない
 * （引数ごとに違う番号へ展開する必要があるため）。組む前に文字列として置き換える。
 */
function expandBlockRefs(tex: string, blockId: string): string {
  return tex.replace(/\\blkref\{([^}]+)\}/g, (_all, target: string) => {
    const { text, href } = reference(target, blockId);
    return `\\href{${href}}{\\text{${text}}}`;
  });
}

function renderMath(tex: string, display: boolean, blockId: string): string {
  const source = expandBlockRefs(tex, blockId);
  // 組むのはブラウザ側。ここでは TeX を属性に持たせるだけにする
  // （組んだ結果を埋めると出力が 10 倍になる）。
  const attr = escapeHtml(source);
  return display
    ? `<div class="display math" data-tex="${attr}" data-display="1"></div>`
    : `<span class="math" data-tex="${attr}"></span>`;
}

// --- 本文 --------------------------------------------------------------------

const toc: { level: number; id: string; title: string; number: string }[] = [];
const body: string[] = [];
let sectionSeen = 0;

for (const { blocks } of contentFiles) {
  for (const block of blocks) {
    if (block.kind === "heading") {
      body.push(renderHeading(block));
      continue;
    }
    if (block.kind === "figure") {
      throw new Error(`図表ブロックは、この出力器がまだ対応していない: ${block.id}`);
    }
    body.push(renderTheoremLike(block));
  }
}

function renderHeading(block: HeadingBlock): string {
  if (block.level === 2) sectionSeen += 1;
  const number = block.level === 2 ? String(sectionSeen) : "";
  const anchor = block.labels[0] ?? block.id;
  const title = renderTitle(block.title, block.id);
  toc.push({ level: block.level, id: `sec-${anchor}`, title, number });
  const tag = `h${Math.min(block.level + 1, 6)}`;
  const ids = block.labels.map((label) => `<span id="sec-${label}"></span>`).join("");
  const shown = number === "" ? title : `${number}　${title}`;
  const heading = `${ids}<${tag} id="sec-${anchor}" class="lv${block.level}">${shown}</${tag}>`;
  const primaryEntries = primaryElementEntriesOf(compiledStructure, block.id, (candidate) => {
    if (candidate.kind === "heading" || candidate.kind === "figure") return "";
    return headLine(candidate);
  })
    .map((entry) => ({ ...entry, anchor: `blk-${entry.anchor}` }));
  return heading + renderPrimaryElementsLead(primaryEntries);
}

/** ブロックの見出し行。見出し冒頭の一覧とブロック本体で同じ文字列を使う。 */
function headLine(block: TheoremLikeBlock): string {
  const numbered = block.labels.map((l) => byLabel.get(l)).find((n) => n !== undefined);
  const number = numbered?.number ?? "";
  const title = renderTitle(block.title, block.id);
  return `${HEADINGS[block.kind]} ${number}${title === "" ? "" : `（${title}）`}`;
}

function renderTheoremLike(block: TheoremLikeBlock): string {
  const statement = renderNodes(block.statement, block.id);
  const proof =
    block.proof !== undefined && block.proof.length > 0
      ? `<div class="proof"><span class="proofhead">証明.</span> ${renderNodes(block.proof, block.id)}<span class="qed">□</span></div>`
      : "";
  return renderStandingAwareBlock({
    standing: standingOf(block),
    elementId: `blk-${block.id}`,
    kind: block.kind,
    headHtml: headLine(block),
    bodyHtml: `<div class="statement">${statement}</div>${proof}`,
  });
}

function renderTitle(title: { text?: string; tex?: string } | null | undefined, blockId: string): string {
  if (title === null || title === undefined) return "";
  if (title.tex !== undefined) return renderMath(title.tex, false, blockId);
  return escapeHtml(title.text ?? "");
}

function renderNodes(nodes: readonly Node[], blockId: string): string {
  return nodes.map((node) => renderNode(node, blockId)).join("");
}

function renderNode(node: Node, blockId: string): string {
  switch (node.type) {
    case "text":
      return escapeHtml(node.value);
    case "math":
      return renderMath(node.tex, false, blockId);
    case "displayMath":
      return renderMath(node.tex, true, blockId);
    case "paragraph":
      return `<p>${node.children.map((child) => renderNode(child, blockId)).join("")}</p>`;
    case "list": {
      const items = node.items
        .map((item) => `<li>${item.map((child) => renderNode(child, blockId)).join("")}</li>`)
        .join("");
      return `<ul>${items}</ul>`;
    }
    case "ref": {
      const { text, href } = reference(node.target, blockId);
      return `<a href="${href}">${escapeHtml(node.label ?? text)}</a>`;
    }
    case "cite":
      throw new Error(`引用ノードは、この出力器がまだ対応していない: ${blockId}`);
    case "todo":
      return `<p class="todo"><strong>[TODO]</strong> ${escapeHtml(node.value)}</p>`;
    case "image":
      throw new Error(`画像ノードは、この出力器がまだ対応していない: ${blockId}`);
  }
}

// --- 版 ----------------------------------------------------------------------

function versionLine(): string {
  const git = (args: readonly string[]): string => {
    const run = spawnSync("git", [...args], { cwd: structuredLatexDir, encoding: "utf8" });
    return run.status === 0 && typeof run.stdout === "string" ? run.stdout.trim() : "";
  };
  const commit = git(["rev-parse", "--short", "HEAD"]);
  if (commit === "") return "";
  const at = git(["log", "-1", "--format=%cd", "--date=format:%Y-%m-%d %H:%M"]);
  const dirty = git(["status", "--porcelain"]) === "" ? "" : "+（未コミットの変更を含む）";
  return `版 ${commit}${dirty}${at === "" ? "" : `・${at}`}`;
}

// --- 組み立て ----------------------------------------------------------------

/** KaTeX の CSS。フォントは woff2 だけを data URI で埋め、それ以外の書式は捨てる。 */
function katexCss(): string {
  const css = readFileSync(join(katexDist, "katex.min.css"), "utf8");
  const cache = new Map<string, string>();
  return css.replace(/url\(([^)]+)\)\s*format\("([^"]+)"\)(,)?/g, (_all, rawPath: string, format: string) => {
    if (format !== "woff2") return ""; // woff / ttf は落とす（woff2 だけで足りる）
    const file = rawPath.replace(/["']/g, "").replace(/^fonts\//, "");
    let data = cache.get(file);
    if (data === undefined) {
      data = readFileSync(join(katexDist, "fonts", file)).toString("base64");
      cache.set(file, data);
    }
    return `url(data:font/woff2;base64,${data}) format("woff2")`;
  }).replace(/,\s*;/g, ";");
}

const { desktopHtml, mobileHtml } = renderChapterNavigation(toc);

const html = `<!doctype html>
<html lang="ja"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>有限グラフ上の Ising 分配多項式と Fisher 零点</title>
<style>${katexCss()}</style>
<style>
:root { color-scheme: light dark; --fg:#1a1a1a; --bg:#fff; --muted:#666; --line:#dcdcdc; --panel:#f7f7f7; --accent:#9b3e28; }
@media (prefers-color-scheme: dark) { :root { --fg:#e6e6e6; --bg:#151515; --muted:#9a9a9a; --line:#333; --panel:#1e1e1e; --accent:#e58d72; } }
body { margin:0; background:var(--bg); color:var(--fg);
  font-family:-apple-system,"Hiragino Mincho ProN","Noto Serif JP",serif; line-height:1.9; }
h1 { font-size:1.6rem; line-height:1.5; margin:0 0 6px; }
.version { color:var(--muted); font-size:.85rem; margin:0 0 32px; }
h2,h3,h4,h5,h6 { line-height:1.5; margin:44px 0 12px; }
h2 { font-size:1.3rem; border-bottom:1px solid var(--line); padding-bottom:6px; }
h3 { font-size:1.1rem; } h4,h5,h6 { font-size:1rem; }
.block { margin:22px 0; }
.block .head { font-weight:600; }
.definition .head, .claim .head, .theorem .head, .remark .head, .note .head { color:var(--fg); }
.statement { margin-top:2px; }
.proof { margin:10px 0 0; padding-left:14px; border-left:2px solid var(--line); }
.proofhead { font-style:italic; color:var(--muted); }
.qed { float:right; }
p { margin:.6em 0; }
ul { padding-left:1.4em; }
a { color:inherit; text-decoration:underline; text-decoration-color:var(--line); }
.display { overflow-x:auto; overflow-y:hidden; padding:4px 0; }
.todo { color:#b26a00; }
.matherror { color:#c00; font-family:ui-monospace,monospace; font-size:.85em; }
footer { margin-top:64px; border-top:1px solid var(--line); padding-top:14px; color:var(--muted); font-size:.8rem; }
${CHAPTER_NAVIGATION_CSS}
${THEOREM_STANDING_CSS}
${PRIMARY_ELEMENTS_CSS}
</style></head><body>
${mobileHtml}
<div class="page-layout">
${desktopHtml}
<main class="document">
<h1>有限グラフ上の Ising 分配多項式と Fisher 零点</h1>
<p class="version">${escapeHtml(versionLine())}</p>
${body.join("\n")}
<script>${readFileSync(join(katexDist, "katex.min.js"), "utf8")}</script>
<script>
// 読んでいる位置に来た数式だけを組む。全部まとめて組むと、開いた瞬間に数秒固まる。
(function () {
  var render = function (el) {
    if (el.dataset.done === "1") return;
    el.dataset.done = "1";
    try {
      katex.render(el.dataset.tex, el, {
        displayMode: el.dataset.display === "1",
        throwOnError: false,
        strict: false,
        // ここは HTML へそのまま出る JavaScript なので、\href と書くには 4 つ重ねる
        // （テンプレートリテラルで 1 段、JavaScript の文字列で 1 段ほどける）。
        trust: function (c) { return c.command === "\\\\href"; },
      });
    } catch (e) {
      el.textContent = el.dataset.tex;
      el.className += " matherror";
    }
  };
  var targets = document.querySelectorAll(".math");
  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) { render(entry.target); observer.unobserve(entry.target); }
    });
  }, { rootMargin: "800px 0px" });
  targets.forEach(function (el) { observer.observe(el); });

  // 参照をたどった先は、まだ組まれていないことがある。飛ぶ前にその周辺を組む。
  var renderAround = function (id) {
    var target = document.getElementById(id);
    if (target === null) return;
    for (var node = target; node !== null; node = node.parentElement) {
      if (node.tagName === "DETAILS") node.open = true;
    }
    target.querySelectorAll("details").forEach(function (el) { el.open = true; });
    target.querySelectorAll(".math").forEach(render);
    target.scrollIntoView();
  };
  window.addEventListener("hashchange", function () { renderAround(location.hash.slice(1)); });
  if (location.hash !== "") { renderAround(location.hash.slice(1)); }
})();
${CHAPTER_NAVIGATION_SCRIPT}
</script>
<footer>証明の正本はリポジトリの <code>structured-latex/content/</code> であり、このページはそこから生成している。
自動ループが前進するたびに作り直す。</footer>
</main></div>
</body></html>
`;

mkdirSync(dirname(outPath), { recursive: true });
writeFileSync(outPath, html, "utf8");

console.log(
  `generated ${outPath}: ${(html.length / 1024 / 1024).toFixed(2)} MB、` +
    `見出し ${toc.length} 件、番号付きブロック ${byLabel.size} ラベル分`,
);
