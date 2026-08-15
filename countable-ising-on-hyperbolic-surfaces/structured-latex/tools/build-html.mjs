#!/usr/bin/env node
/**
 * `content/` の構造化本文を、MathJax で数式を組版した単一 HTML へ変換する。
 * 数式はビルド時に inline SVG へ変換するため、生成物は外部 CDN に依存しない。
 */

import { spawnSync } from "node:child_process";
import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";

import MathJax from "mathjax";

import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";

const outputPath = process.argv[2] ?? join(structuredLatexDir, "build", "document.html");
const blocks = (await loadContentFiles()).flatMap(({ blocks: values }) => values);

await MathJax.init({
  loader: { load: ["input/tex", "output/svg"] },
  svg: { fontCache: "local" },
});

const theoremNames = {
  definition: "定義",
  claim: "主張",
  theorem: "定理",
  remark: "注意",
  note: "ノート",
};

const labelTargets = new Map();
for (const block of blocks) {
  const anchor = block.kind === "heading" ? `heading-${block.id}` : `block-${block.id}`;
  const title = titleText(block.title) || theoremNames[block.kind] || "本文";
  for (const label of block.labels) labelTargets.set(label, { anchor, title });
}

function reference(target, from) {
  const value = labelTargets.get(target);
  if (value === undefined) throw new Error(`未解決参照: ${from} -> ${target}`);
  return value;
}

function expandBlockRefs(tex, blockId) {
  return tex.replace(/\\blkref\{([^}]+)\}/g, (_all, target) => {
    const value = reference(target, blockId);
    return `\\href{#${value.anchor}}{\\text{${value.title}}}`;
  });
}

async function renderMath(tex, display, blockId) {
  try {
    const converted = await MathJax.tex2svgPromise(expandBlockRefs(tex, blockId), { display });
    return MathJax.startup.adaptor.serializeXML(converted);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    throw new Error(`MathJax 変換失敗: ${blockId}: ${message}`);
  }
}

function escapeHtml(value) {
  return value
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

function titleText(value) {
  if (value === undefined || value === null) return "";
  return value.text ?? value.tex ?? "";
}

async function renderTitle(value, blockId) {
  if (value === undefined || value === null) return "";
  return value.tex === undefined ? escapeHtml(value.text ?? "") : await renderMath(value.tex, false, blockId);
}

async function renderNodes(nodes, blockId) {
  return (await Promise.all(nodes.map((node) => renderNode(node, blockId)))).join("");
}

async function renderNode(node, blockId) {
  switch (node.type) {
    case "text":
      return escapeHtml(node.value);
    case "math":
      return await renderMath(node.tex, false, blockId);
    case "displayMath":
      return `<div class="display-math">${await renderMath(node.tex, true, blockId)}</div>`;
    case "paragraph":
      return `<p>${await renderNodes(node.children, blockId)}</p>`;
    case "list": {
      const items = await Promise.all(node.items.map(async (item) => `<li>${await renderNodes(item, blockId)}</li>`));
      return `<ul>${items.join("")}</ul>`;
    }
    case "ref": {
      const value = reference(node.target, blockId);
      return `<a href="#${value.anchor}">${escapeHtml(node.label ?? value.title)}</a>`;
    }
    case "todo":
      return `<p class="todo"><strong>未完了:</strong> ${escapeHtml(node.value)}</p>`;
    case "cite":
      throw new Error(`引用ノードは未対応: ${blockId}`);
    case "image":
      throw new Error(`画像ノードは未対応: ${blockId}`);
  }
}

const navigation = [];
const body = [];
for (const block of blocks) {
  if (block.kind === "heading") {
    const title = await renderTitle(block.title, block.id);
    const anchor = `heading-${block.id}`;
    const level = Math.min(block.level + 1, 6);
    navigation.push(`<li class="nav-level-${block.level}"><a href="#${anchor}">${title}</a></li>`);
    body.push(`<h${level} id="${anchor}">${title}</h${level}>`);
    continue;
  }
  if (block.kind === "figure") throw new Error(`図表ブロックは未対応: ${block.id}`);
  const title = await renderTitle(block.title, block.id);
  const heading = `${theoremNames[block.kind]}${title === "" ? "" : `「${title}」`}`;
  const proof = block.proof === undefined || block.proof.length === 0
    ? ""
    : `<div class="proof"><div class="proof-heading">証明</div>${await renderNodes(block.proof, block.id)}<div class="qed">□</div></div>`;
  body.push(`<section class="theorem ${block.kind}" id="block-${block.id}"><div class="theorem-heading">${heading}<span class="habitat">${escapeHtml(block.habitat)}</span></div><div class="statement">${await renderNodes(block.statement, block.id)}</div>${proof}</section>`);
}

function gitValue(args) {
  const result = spawnSync("git", args, { cwd: structuredLatexDir, encoding: "utf8" });
  return result.status === 0 ? result.stdout.trim() : "";
}

const commit = gitValue(["rev-parse", "--short", "HEAD"]);
const committedAt = gitValue(["log", "-1", "--format=%cd", "--date=format:%Y-%m-%d %H:%M %Z"]);
const version = commit === "" ? "" : `版 ${commit}${committedAt === "" ? "" : `・${committedAt}`}`;

const html = `<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>有限双曲曲面上の Ising 模型の可算構造</title>
<style>
:root { color-scheme: light dark; --bg:#fcfbf7; --fg:#24211d; --muted:#716b62; --line:#d9d2c6; --panel:#f4f0e8; --accent:#8b3525; --code:#5d2d21; }
@media (prefers-color-scheme:dark) { :root { --bg:#171614; --fg:#ece7df; --muted:#aaa197; --line:#39352f; --panel:#211f1c; --accent:#e59a83; --code:#edaa94; } }
* { box-sizing:border-box; }
html { scroll-behavior:smooth; }
body { margin:0; background:var(--bg); color:var(--fg); font-family:-apple-system,BlinkMacSystemFont,"Hiragino Mincho ProN","Yu Mincho","Noto Serif JP",serif; line-height:1.9; }
.layout { display:grid; grid-template-columns:minmax(220px,280px) minmax(0,780px); gap:48px; max-width:1160px; margin:0 auto; padding:42px 30px 80px; }
nav { position:sticky; top:24px; align-self:start; max-height:calc(100vh - 48px); overflow:auto; border-right:1px solid var(--line); padding-right:24px; }
nav h2 { margin:0 0 14px; border:0; font-size:.92rem; color:var(--muted); }
nav ul { list-style:none; padding:0; margin:0; }
nav li { margin:8px 0; }
nav a { text-decoration:none; color:var(--fg); font-size:.9rem; }
main { min-width:0; }
h1 { font-size:clamp(1.7rem,4vw,2.35rem); line-height:1.45; margin:0; letter-spacing:.02em; }
.lead { color:var(--muted); margin:12px 0 4px; }
.version { color:var(--muted); font-size:.82rem; margin:0 0 38px; }
h2,h3,h4,h5,h6 { line-height:1.5; margin:48px 0 16px; scroll-margin-top:24px; }
h2 { font-size:1.35rem; border-bottom:1px solid var(--line); padding-bottom:8px; }
.theorem { background:var(--panel); border:1px solid var(--line); border-radius:8px; padding:18px 22px; margin:22px 0; scroll-margin-top:24px; }
.theorem-heading { font-weight:700; margin-bottom:7px; }
.habitat { float:right; color:var(--accent); border:1px solid currentColor; border-radius:999px; padding:0 8px; font-family:ui-monospace,SFMono-Regular,Menlo,monospace; font-size:.72rem; line-height:1.7; }
.proof { margin-top:15px; padding:12px 0 0 17px; border-left:2px solid var(--line); }
.proof-heading { color:var(--muted); font-style:italic; }
.qed { text-align:right; }
p { margin:.65em 0; }
a { color:var(--accent); text-underline-offset:3px; }
.display-math { overflow-x:auto; padding:5px 0; }
mjx-container[jax="SVG"][display="true"] { margin:1em 0 !important; min-width:max-content; }
.todo { color:#b46600; }
footer { border-top:1px solid var(--line); color:var(--muted); font-size:.82rem; margin-top:64px; padding-top:16px; }
@media (max-width:800px) { .layout { display:block; padding:24px 18px 56px; } nav { position:static; border:1px solid var(--line); border-radius:8px; padding:14px 18px; margin-bottom:32px; } .theorem { padding:15px 16px; } .habitat { float:none; margin-left:8px; } }
</style>
</head>
<body><div class="layout">
<nav aria-label="本文目次"><h2>本文</h2><ul>${navigation.join("")}</ul></nav>
<main>
<h1>有限双曲曲面上の Ising 模型の可算構造</h1>
<p class="lead">有限セル分割・整数係数多項式・有限体上のホモロジーから出発する構造化本文</p>
<p class="version">${escapeHtml(version)}</p>
${body.join("\n")}
<footer>正本は <code>structured-latex/content/</code>。数式は MathJax でビルド時に inline SVG へ変換している。</footer>
</main></div></body></html>`;

mkdirSync(dirname(outputPath), { recursive: true });
writeFileSync(outputPath, html, "utf8");
console.log(`generated ${outputPath}: ${(Buffer.byteLength(html) / 1024 / 1024).toFixed(2)} MB, ${blocks.length} blocks`);
