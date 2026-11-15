/**
 * SageMath の検算（sagemath/check/<対象名>/）と本文（structured-latex/content/chapters/）の対応を検査する。
 *
 * 各 overview.md は「- 対象ラベル: `<label>`」の行で、検算の対象を本文のラベルで宣言する（一つの検算に何行でもよい。
 * exact-solution-of-2d-ising-model/ の「**対象ラベル**: `<label>`」の形も読む）。
 *
 * 検査すること:
 *   1. どの検算のディレクトリにも overview.md があり、対象ラベルを一つ以上宣言し、そのラベルが本文に実在すること。
 *   2. overview.md の「- 検算: [<file>](<file>)」が指す検算のファイルが実在すること。
 *   3. 本文の主張と定理のすべてが、どれかの検算の対象ラベルに入っているか、claims-without-check.ts で理由とともに外してあること。
 *   4. claims-without-check.ts で外したラベルが本文の主張か定理で、どの検算の対象ラベルにも入っておらず、二度載っていないこと。
 * 検算が通ることはこの検査では確かめない（各 overview.md の「結果」の行と、検算の実行が受け持つ）。
 *
 * 使い方: node sagemath/tools/verify-check-linkage.ts （終了コード 0 なら OK）
 */
import { existsSync, readdirSync, readFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

import { ALL_LABELS } from "../../structured-latex/labels.generated.ts";
import { excludedChapters, excludedLabels } from "./claims-without-check.ts";

const here = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(here, "..", "..");
const checkRoot = join(projectRoot, "sagemath", "check");
const chaptersDir = join(projectRoot, "structured-latex", "content", "chapters");

const LABEL_LINE = /^(?:-\s*対象ラベル|\*\*対象ラベル\*\*)\s*:\s*`([^`]+)`/gm;
const CHECK_FILE_LINE = /^-\s*検算\s*:\s*\[[^\]]*\]\(([^)]+)\)/gm;

const contentLabels = new Set<string>(ALL_LABELS);
const problems: string[] = [];
const checkedLabels = new Set<string>();
let checkDirs = 0;

for (const entry of readdirSync(checkRoot, { withFileTypes: true }).sort((a, b) => a.name.localeCompare(b.name))) {
  if (!entry.isDirectory()) continue;
  checkDirs += 1;
  const dir = join(checkRoot, entry.name);
  const overview = join(dir, "overview.md");
  if (!existsSync(overview)) {
    problems.push(`${entry.name}: overview.md が無い`);
    continue;
  }
  const text = readFileSync(overview, "utf8");
  const labels = [...text.matchAll(LABEL_LINE)].map((m) => m[1]);
  if (labels.length === 0) problems.push(`${entry.name}: overview.md に「- 対象ラベル: \`<label>\`」の行が無い`);
  for (const label of labels) {
    if (!contentLabels.has(label)) problems.push(`${entry.name}: 対象ラベル \`${label}\` が本文に無い`);
    checkedLabels.add(label);
  }
  const files = [...text.matchAll(CHECK_FILE_LINE)].map((m) => m[1]);
  if (files.length === 0) problems.push(`${entry.name}: overview.md に「- 検算: [<file>](<file>)」の行が無い`);
  for (const file of files) {
    if (!existsSync(join(dir, file))) problems.push(`${entry.name}: 検算のファイル ${file} が無い`);
  }
}

type Block = { kind: string; labels?: readonly string[] };
const chapterFiles = readdirSync(chaptersDir).filter((f) => f.endsWith(".ts")).sort();
const excludedChapterNames = new Set(excludedChapters.map((c) => c.chapter));
for (const c of excludedChapters) {
  if (!chapterFiles.includes(c.chapter)) problems.push(`claims-without-check.ts: 章のファイル ${c.chapter} が無い`);
  if (c.reason.trim() === "") problems.push(`claims-without-check.ts: 章 ${c.chapter} の理由が空`);
}
const excluded = new Map<string, string>();
for (const group of excludedLabels) {
  if (group.reason.trim() === "") problems.push(`claims-without-check.ts: 理由が空の組がある`);
  for (const label of group.labels) {
    if (excluded.has(label)) problems.push(`claims-without-check.ts: ${label} が二度載っている`);
    excluded.set(label, group.reason);
  }
}

const theoremLikeLabels = new Set<string>();
let theoremLike = 0;
let checked = 0;
let byChapter = 0;
let byLabel = 0;
for (const chapter of chapterFiles) {
  const mod = (await import(pathToFileURL(join(chaptersDir, chapter)).href)) as { default: readonly Block[] };
  for (const block of mod.default) {
    if (block.kind !== "claim" && block.kind !== "theorem") continue;
    const labels = block.labels ?? [];
    for (const l of labels) theoremLikeLabels.add(l);
    theoremLike += 1;
    if (labels.some((l) => checkedLabels.has(l))) checked += 1;
    else if (excludedChapterNames.has(chapter)) byChapter += 1;
    else if (labels.some((l) => excluded.has(l))) byLabel += 1;
    else problems.push(`${chapter} ${labels[0] ?? "(ラベルなし)"}: 検算が無く、claims-without-check.ts にも理由が無い`);
  }
}
for (const label of excluded.keys()) {
  if (!theoremLikeLabels.has(label)) problems.push(`claims-without-check.ts: ${label} は本文の主張でも定理でもない`);
  if (checkedLabels.has(label)) problems.push(`claims-without-check.ts: ${label} には検算があるので、ここから消す`);
}

if (problems.length > 0) {
  for (const p of problems) console.error(`NG: ${p}`);
  console.error(`NG: ${problems.length} 件`);
  process.exit(1);
}
console.log(
  `OK: 検算 ${checkDirs} 件の対象ラベル ${checkedLabels.size} 個はすべて本文に在る。本文の主張と定理 ${theoremLike} 件のうち、` +
    `検算があるもの ${checked} 件、章ごと外したもの ${byChapter} 件、理由つきで外したもの ${byLabel} 件`,
);
