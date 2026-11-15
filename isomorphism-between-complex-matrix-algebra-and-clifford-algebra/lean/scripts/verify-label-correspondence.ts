/**
 * 本文（structured-latex/content/chapters/）のラベルと Lean の宣言の対応を検査する。
 *
 * 検査すること:
 *   1. 本文のブロック（見出しを除く）のラベルのどれかが、具体版の宣言の docstring に現れること。
 *   2. 主張と定理のブロックについて、必要十分版の宣言があること。必要十分版の宣言とは、docstring にラベルのどれかが
 *      現れる必要十分版の宣言か、ラベルを docstring に持つ具体版の宣言と同じ名前の必要十分版の宣言である
 *      （導出版のファイルの冒頭に書いた約束「必要十分版の主張も具体版と同じ名前」）。
 *   3. 主張と定理のブロックについて、導出版の宣言があること。導出版の宣言とは、名前が `_of_necSuf`・`_eq_of_necSuf`・
 *      `_eq_necSuf` のどれかで終わる導出版の宣言で、docstring にラベルのどれかが現れるか、名前からその接尾辞を除くと
 *      ラベルを docstring に持つ具体版の宣言の名前になるものである（導出版の多くは docstring を持たず、名前で対応する）。
 *   4. docstring が引く本文のラベル（`claim_`・`def_`・`theorem_` で始まり、`` ` `` で囲んだもの）が本文に実在すること。
 *
 * 版は置き場で決める（lean/README.md の「置き場と名前空間」）。
 *   具体版:     CliffordMatrixIsomorphism/ の下で、NecSuf/ の外の、名前が FromNecSuf.lean で終わらないファイル
 *   必要十分版: CliffordMatrixIsomorphism/NecSuf/ の下のファイル
 *   導出版:     名前が FromNecSuf.lean で終わるファイル
 * 検査から外すラベルとその理由は label-correspondence-exceptions.ts に置く（ℂ を含まない主張、宣言を置かない定義など）。
 * 見るのは本文のラベルだけである。本文のラベルを持たない Lean の中だけの途中の補題は数えない。
 * ソースの字面を読むので、宣言が `sorry` に依存しないことは scripts/check-no-sorry.sh が受け持つ。
 *
 * 使い方: node lean/scripts/verify-label-correspondence.ts （終了コード 0 なら OK）
 */
import { readdirSync, readFileSync } from "node:fs";
import { dirname, join, relative, resolve } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

import { type Exception, withoutDeclaration, withoutNecSuf } from "./label-correspondence-exceptions.ts";

const here = dirname(fileURLToPath(import.meta.url));
const leanRoot = resolve(here, "..");
const projectRoot = resolve(leanRoot, "..");
const sourceRoot = join(leanRoot, "CliffordMatrixIsomorphism");
const chaptersDir = join(projectRoot, "structured-latex", "content", "chapters");

type Version = "concrete" | "necSuf" | "derived";
type Decl = { file: string; name: string; version: Version; labels: Set<string> };
// 宣言の名前は、ソースに書いた名前（名前空間の外側の部分を含まない）の最後の成分で比べる。
const lastComponent = (name: string): string => name.split(".").at(-1) ?? name;

function leanFiles(dir: string): string[] {
  const out: string[] = [];
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    const path = join(dir, entry.name);
    if (entry.isDirectory()) out.push(...leanFiles(path));
    else if (entry.name.endsWith(".lean")) out.push(path);
  }
  return out.sort();
}

function versionOf(path: string): Version {
  const rel = relative(sourceRoot, path);
  if (rel.startsWith("NecSuf/")) return "necSuf";
  if (rel.endsWith("FromNecSuf.lean")) return "derived";
  return "concrete";
}

const DECL_PREFIX = String.raw`(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|nonrec|partial|unsafe)\s+)*(?:theorem|lemma|def|abbrev|structure|class|instance|inductive)\s+([^\s(:{[]+)`;
const DECL_LINE = new RegExp(String.raw`^[ \t]*` + DECL_PREFIX, "gm");
const DOC_THEN_DECL = new RegExp(String.raw`/--([\s\S]*?)-/\s*` + DECL_PREFIX, "g");
const LABEL_IN_DOC = /`((?:claim|def|theorem)_[A-Za-z0-9_]+)`/g;

const decls: Decl[] = [];
for (const file of leanFiles(sourceRoot)) {
  const text = readFileSync(file, "utf8");
  const docs = new Map<number, Set<string>>();
  for (const m of text.matchAll(DOC_THEN_DECL)) {
    const declStart = (m.index ?? 0) + m[0].length - m[2].length;
    docs.set(declStart, new Set([...m[1].matchAll(LABEL_IN_DOC)].map((x) => x[1])));
  }
  for (const m of text.matchAll(DECL_LINE)) {
    const declStart = (m.index ?? 0) + m[0].length - m[1].length;
    decls.push({ file: relative(leanRoot, file), name: lastComponent(m[1]), version: versionOf(file), labels: docs.get(declStart) ?? new Set() });
  }
}

type Block = { kind: string; id: string; labels?: readonly string[] };
const blocks: { chapter: string; block: Block }[] = [];
for (const file of readdirSync(chaptersDir).filter((f) => f.endsWith(".ts")).sort()) {
  const mod = (await import(pathToFileURL(join(chaptersDir, file)).href)) as { default: readonly Block[] };
  for (const block of mod.default) blocks.push({ chapter: file, block });
}

const contentLabels = new Set(blocks.flatMap(({ block }) => block.labels ?? []));
const DERIVED_SUFFIXES = ["_of_necSuf", "_eq_of_necSuf", "_eq_necSuf"];
const DERIVED_NAME = /(?:_of_necSuf|_eq_necSuf)$/;
const mentioned = (labels: readonly string[], pred: (d: Decl) => boolean): boolean =>
  decls.some((d) => pred(d) && labels.some((l) => d.labels.has(l)));
const concreteNames = (labels: readonly string[]): Set<string> =>
  new Set(decls.filter((d) => d.version === "concrete" && labels.some((l) => d.labels.has(l))).map((d) => d.name));
const hasNecSuf = (labels: readonly string[]): boolean => {
  const names = concreteNames(labels);
  return decls.some((d) => d.version === "necSuf" && (labels.some((l) => d.labels.has(l)) || names.has(d.name)));
};
const hasDerived = (labels: readonly string[]): boolean => {
  const names = concreteNames(labels);
  return decls.some(
    (d) =>
      d.version === "derived" &&
      DERIVED_NAME.test(d.name) &&
      (labels.some((l) => d.labels.has(l)) ||
        DERIVED_SUFFIXES.some((x) => d.name.endsWith(x) && names.has(d.name.slice(0, -x.length)))),
  );
};

const reasonOf = (list: readonly Exception[]): Map<string, string> =>
  new Map(list.flatMap(({ reason, labels }) => labels.map((l) => [l, reason] as const)));
const noDeclaration = reasonOf(withoutDeclaration);
const noNecSuf = reasonOf(withoutNecSuf);
const concreteText = leanFiles(sourceRoot)
  .filter((f) => versionOf(f) === "concrete")
  .map((f) => readFileSync(f, "utf8"))
  .join("\n");

const problems: string[] = [];
let theoremLike = 0;
let labelled = 0;
let excepted = 0;
const blockOfLabel = new Map<string, Block>();
for (const { block } of blocks) for (const l of block.labels ?? []) blockOfLabel.set(l, block);
for (const l of [...noDeclaration.keys(), ...noNecSuf.keys()]) {
  if (!blockOfLabel.has(l)) problems.push(`label-correspondence-exceptions.ts: 例外のラベル ${l} が本文に無い`);
}
for (const { chapter, block } of blocks) {
  if (block.kind === "heading") continue;
  const labels = block.labels ?? [];
  if (labels.length === 0) continue;
  labelled += 1;
  const where = `${chapter} ${labels[0]}`;
  const inConcrete = mentioned(labels, (d) => d.version === "concrete");
  if (labels.some((l) => noDeclaration.has(l))) {
    excepted += 1;
    if (inConcrete) problems.push(`${where}: 具体版の docstring に現れるので、例外（宣言を置かない定義）から外す`);
    if (!labels.some((l) => concreteText.includes(l))) problems.push(`${where}: 宣言を置かない定義なのに、具体版のどのファイルにも書かれていない`);
    continue;
  }
  if (!inConcrete) problems.push(`${where}: 具体版の docstring に現れない`);
  if (block.kind !== "claim" && block.kind !== "theorem") continue;
  theoremLike += 1;
  const necSuf = hasNecSuf(labels);
  const derived = hasDerived(labels);
  if (labels.some((l) => noNecSuf.has(l))) {
    excepted += 1;
    if (necSuf || derived) problems.push(`${where}: 必要十分版か導出版の宣言があるので、例外（必要十分版を置かない主張）から外す`);
    continue;
  }
  if (!necSuf) problems.push(`${where}: 必要十分版の宣言が無い`);
  if (!derived) problems.push(`${where}: 導出版（…_of_necSuf・…_eq_of_necSuf・…_eq_necSuf）の宣言が無い`);
}
for (const d of decls) {
  for (const l of d.labels) {
    if (!contentLabels.has(l)) problems.push(`${d.file} ${d.name}: docstring のラベル ${l} が本文に無い`);
  }
}

if (problems.length > 0) {
  for (const p of problems) console.error(`NG: ${p}`);
  console.error(`NG: ${problems.length} 件`);
  process.exit(1);
}
console.log(
  `OK: 本文のラベルを持つブロック ${labelled} 件と主張・定理 ${theoremLike} 件を調べた。例外 ${excepted} 件` +
    `（label-correspondence-exceptions.ts の理由による）を除き、どのブロックも具体版の docstring に現れ、` +
    `どの主張・定理も必要十分版と導出版の宣言を持つ`,
);
