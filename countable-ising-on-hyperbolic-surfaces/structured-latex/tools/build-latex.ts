#!/usr/bin/env node
import { spawnSync } from "node:child_process";
import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

import type { ConvertedBlock, Node, TheoremLikeBlock } from "../schema.ts";
import { loadPublicationContentFiles, structuredLatexDir } from "./content-modules.ts";

const buildDir = join(structuredLatexDir, "build");
const texPath = join(buildDir, "document.tex");
const withPdf = process.argv.includes("--pdf");
const cjkMainFont = process.env.HYPERBOLIC_ISING_PDF_CJK_MAIN_FONT ?? "Hiragino Mincho ProN";
const cjkSansFont = process.env.HYPERBOLIC_ISING_PDF_CJK_SANS_FONT ?? "Hiragino Sans";
const blocks = (await loadPublicationContentFiles()).flatMap(({ blocks }) => blocks);
const labelOwner = new Set<string>(blocks.flatMap((block) => [...block.labels]));
const usedRefs: string[] = [];

const body = blocks.map(renderBlock).join("\n\n");
for (const target of usedRefs) if (!labelOwner.has(target)) throw new Error(`未解決参照: ${target}`);

mkdirSync(buildDir, { recursive: true });
writeFileSync(texPath, document(body), "utf8");
console.log(`generated ${texPath}: ${blocks.length} blocks, ${labelOwner.size} labels`);

if (withPdf) {
  const run = spawnSync("tectonic", ["-X", "compile", "--keep-logs", texPath], {
    cwd: buildDir,
    encoding: "utf8",
    maxBuffer: 64 * 1024 * 1024,
  });
  if (run.error !== undefined) throw run.error;
  if (run.status !== 0) throw new Error(`${run.stdout ?? ""}${run.stderr ?? ""}`);
  const log = readFileSync(join(buildDir, "document.log"), "utf8");
  if (/undefined references|multiply-defined labels|Missing character:/.test(log)) {
    throw new Error("PDF ログに未解決参照・重複ラベル・欠落文字がある");
  }
  console.log(`generated ${join(buildDir, "document.pdf")}`);
}

function renderBlock(block: ConvertedBlock): string {
  if (block.kind === "heading") {
    const commands = ["part", "section", "subsection", "subsubsection", "paragraph", "subparagraph"];
    return `\\${commands[block.level - 1]}{${escapeText(title(block.title))}}${labels(block.labels)}`;
  }
  if (block.kind === "figure") throw new Error(`figure は未対応: ${block.id}`);
  return renderTheorem(block);
}

function renderTheorem(block: TheoremLikeBlock): string {
  const environment = block.kind === "note" ? "structurednote" : block.kind;
  const heading = block.title === undefined || block.title === null ? "" : `[${escapeText(title(block.title))}]`;
  const proof = block.proof === undefined || block.proof.length === 0
    ? ""
    : `\n\\begin{proof}\n${renderNodes(block.proof, block.id)}\n\\end{proof}`;
  return `\\begin{${environment}}${heading}${labels(block.labels)}\n${renderNodes(block.statement, block.id)}\n\\end{${environment}}${proof}`;
}

function renderNodes(nodes: readonly Node[], blockId: string): string {
  return nodes.map((node) => renderNode(node, blockId)).join("\n");
}

function renderNode(node: Node, blockId: string): string {
  switch (node.type) {
    case "text": return escapeText(node.value);
    case "math": return `$${expandBlockRefs(node.tex)}$`;
    case "displayMath": return `\\[${expandBlockRefs(node.tex)}\\]`;
    case "paragraph": return `${renderNodes(node.children, blockId)}\n`;
    case "list": return `\\begin{itemize}\n${node.items.map((item) => `\\item ${renderNodes(item, blockId)}`).join("\n")}\n\\end{itemize}`;
    case "ref": usedRefs.push(node.target); return node.label === undefined ? `\\cref{lab:${node.target}}` : `\\hyperref[lab:${node.target}]{${escapeText(node.label)}}`;
    case "todo": return `\\textbf{[TODO] ${escapeText(node.value)}}`;
    case "cite": throw new Error(`cite は未対応: ${blockId}`);
    case "image": throw new Error(`image は未対応: ${blockId}`);
  }
}

function expandBlockRefs(tex: string): string {
  return tex.replace(/\\blkref\{([^}]+)\}/g, (_all, target: string) => {
    usedRefs.push(target);
    return `\\cref{lab:${target}}`;
  });
}

function labels(values: readonly string[]): string {
  return values.map((value) => `\\label{lab:${value}}`).join("");
}

function title(value: { text?: string; tex?: string }): string {
  return value.text ?? value.tex ?? "";
}

function escapeText(value: string): string {
  return value
    .replace(/\\/g, "\\textbackslash{}")
    .replace(/([#$%&_{}])/g, "\\$1")
    .replace(/~/g, "\\textasciitilde{}")
    .replace(/\^/g, "\\textasciicircum{}");
}

function document(body: string): string {
  return String.raw`\documentclass[11pt,a4paper]{article}
\usepackage{amsmath,amssymb,amsthm}
\usepackage[margin=25mm]{geometry}
\usepackage{xeCJK}
\setCJKmainfont{${cjkMainFont}}
\setCJKsansfont{${cjkSansFont}}
\usepackage[hidelinks]{hyperref}
\usepackage[nameinlink,noabbrev]{cleveref}
\renewcommand{\proofname}{証明}
\newtheorem{definition}{定義}[section]
\newtheorem{claim}[definition]{主張}
\newtheorem{theorem}[definition]{定理}
\theoremstyle{remark}
\newtheorem{remark}[definition]{注意}
\newtheorem{structurednote}[definition]{ノート}
\crefname{definition}{定義}{定義}
\crefname{claim}{主張}{主張}
\crefname{theorem}{定理}{定理}
\title{有限双曲曲面上の Ising 模型の可算構造}
\author{}
\date{}
\begin{document}
\maketitle
${body}
\end{document}
`;
}
