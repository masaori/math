/**
 * 研究の段取り（`../research-roadmap.ts`）を出版物へ描画する。
 *
 * 本文の採番へ触れないことがこの描画器の要件である。段取りは主張ではないので、
 * 定義・主張・定理の通し番号を進めてはならない。したがって LaTeX 側は番号を持たない見出し
 * （`\part*` / `\section*`）で組み、目次へは明示的に足す。HTML 側は本文ブロックの採番を行う
 * ループを一切通らない位置で組み立て、章の目次にだけ項目を足す。
 *
 * 依存は id ではなく段階名で表示する。人間が読む文書に内部識別子を出さないためである。
 */

import { roadmapPreamble, roadmapStages, roadmapTitle, type RoadmapStage } from "../research-roadmap.ts";

/** 段取りの正本は id が型で固定されているので、表示側は広い型で引く。 */
const stages: readonly RoadmapStage[] = roadmapStages;
const titleById = new Map<string, string>(stages.map((stage) => [stage.id, stage.title]));

const dependencyTitles = (stage: RoadmapStage): string[] =>
  stage.dependsOn.map((id) => {
    const title = titleById.get(id);
    if (title === undefined) throw new Error(`段取りの依存先が存在しない: ${stage.id} -> ${id}`);
    return title;
  });

const statusLine = (stage: RoadmapStage): string =>
  stage.current ? `${stage.status}（現在地）` : stage.status;

const evidenceLines = (stage: RoadmapStage): string[] =>
  stage.evidence.map((item) =>
    item.kind === "label" ? `本文の ${item.label}: ${item.why}` : `${item.path}: ${item.why}`,
  );

const dependencyLine = (stage: RoadmapStage): string => {
  const titles = dependencyTitles(stage);
  return titles.length === 0 ? "依存: 無し（この段取りの起点）" : `依存: ${titles.join("、")}`;
};

// --- LaTeX -------------------------------------------------------------------

const escapeLatex = (value: string): string =>
  value
    .replace(/\\/g, "\\textbackslash{}")
    .replace(/([&%$#_{}])/g, "\\$1")
    .replace(/~/g, "\\textasciitilde{}")
    .replace(/\^/g, "\\textasciicircum{}");

const itemize = (items: readonly string[]): string =>
  items.length === 0
    ? ""
    : `\\begin{itemize}\n${items.map((item) => `\\item ${escapeLatex(item)}`).join("\n")}\n\\end{itemize}\n`;

export function renderRoadmapLatex(): string {
  const parts: string[] = [
    `\\part*{${escapeLatex(roadmapTitle)}}`,
    `\\addcontentsline{toc}{part}{${escapeLatex(roadmapTitle)}}`,
    ...roadmapPreamble.map((paragraph) => escapeLatex(paragraph)),
  ];
  for (const stage of stages) {
    parts.push(
      `\\section*{${escapeLatex(stage.title)}}`,
      `\\addcontentsline{toc}{section}{${escapeLatex(stage.title)}}`,
      `\\noindent 状態: ${escapeLatex(statusLine(stage))}\\par`,
      `\\noindent ${escapeLatex(dependencyLine(stage))}\\par`,
      `\\noindent 範囲: ${escapeLatex(stage.scope)}\\par`,
      `\\noindent 量の住処: ${escapeLatex(stage.habitat)}\\par`,
      `\\noindent 完了条件:`,
      itemize(stage.completion),
    );
    const evidence = evidenceLines(stage);
    if (evidence.length > 0) {
      parts.push("\\noindent 根拠:", itemize(evidence));
    }
  }
  parts.push("\\clearpage");
  return parts.join("\n\n");
}

// --- HTML --------------------------------------------------------------------

const escapeHtml = (value: string): string =>
  value.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");

const stageAnchor = (stage: RoadmapStage): string => `sec-roadmap-${stage.id}`;

/** 章の目次へ足す項目。段取りの根を level 1、各段階を level 2 に置く。 */
export type RoadmapTocEntry = { level: number; id: string; title: string; number: string };

export function roadmapTocEntries(): RoadmapTocEntry[] {
  return [
    { level: 1, id: "sec-roadmap", title: roadmapTitle, number: "" },
    ...stages.map((stage) => ({
      level: 2,
      id: stageAnchor(stage),
      title: stage.title,
      number: "",
    })),
  ];
}

const htmlList = (items: readonly string[]): string =>
  items.length === 0 ? "" : `<ul>${items.map((item) => `<li>${escapeHtml(item)}</li>`).join("")}</ul>`;

export function renderRoadmapHtml(): string {
  const rendered = stages
    .map((stage) => {
      const evidence = evidenceLines(stage);
      return (
        `<section class="roadmap-stage${stage.current ? " roadmap-stage--current" : ""}"` +
        ` id="${stageAnchor(stage)}">` +
        `<h3 class="lv2">${escapeHtml(stage.title)}</h3>` +
        `<p class="roadmap-status">状態: ${escapeHtml(statusLine(stage))}</p>` +
        `<p class="roadmap-depends">${escapeHtml(dependencyLine(stage))}</p>` +
        `<p>範囲: ${escapeHtml(stage.scope)}</p>` +
        `<p>量の住処: ${escapeHtml(stage.habitat)}</p>` +
        `<p>完了条件:</p>${htmlList(stage.completion)}` +
        (evidence.length === 0 ? "" : `<p>根拠:</p>${htmlList(evidence)}`) +
        `</section>`
      );
    })
    .join("");
  const preambleHtml = roadmapPreamble.map((paragraph) => `<p>${escapeHtml(paragraph)}</p>`).join("");
  return (
    `<section class="roadmap" id="sec-roadmap">` +
    `<h2>${escapeHtml(roadmapTitle)}</h2>${preambleHtml}${rendered}</section>`
  );
}

export const ROADMAP_CSS = String.raw`
.roadmap-stage { margin:26px 0; padding-left:14px; border-left:3px solid var(--line); }
.roadmap-stage--current { border-left-color:var(--accent); }
.roadmap-status { font-weight:650; }
.roadmap-depends { color:var(--muted); }
`;
