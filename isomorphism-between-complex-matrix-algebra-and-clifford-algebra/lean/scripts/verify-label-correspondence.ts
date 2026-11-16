/**
 * 本文（structured-latex/content/chapters/）のラベルと Lean の宣言の対応を検査する。
 *
 * 検査すること:
 *   1. 本文のブロック（見出しを除く）のラベルのどれかが、具体版の宣言の docstring に現れること。
 *   2. 主張と定理のブロックについて、必要十分版の宣言があること。必要十分版の宣言とは、docstring にラベルのどれかが
 *      現れる必要十分版の宣言か、ラベルを docstring に持つ具体版の宣言と同じ名前の必要十分版の宣言である
 *      （導出版のファイルの冒頭に書いた約束「必要十分版の主張も具体版と同じ名前」）。名前は名前空間まで比べる
 *      （必要十分版の名前空間は、具体版の名前空間の CliffordMatrixIsomorphism. の後ろに NecSuf. を挟んだもの。
 *      線型空間と代数の名前空間だけは VectorSpace・AlgebraOver に替えてある）。
 *   3. 主張と定理のブロックについて、導出版の宣言があること。導出版の宣言とは、名前が `_of_necSuf`・`_eq_of_necSuf`・
 *      `_eq_necSuf` のどれかで終わる導出版の宣言で、docstring にラベルのどれかが現れるか、名前（名前空間まで）からその接尾辞を
 *      除くとラベルを docstring に持つ具体版の宣言の名前になるものである（導出版の多くは docstring を持たず、名前で対応する）。
 *   4. 主張と定理のブロックについて、導出版が必要十分版を特殊化していること。導出版のどれかの本文（コメントを除く）が、
 *      対応する必要十分版の宣言を、必要十分版と分かる形（`NecSuf.` で始まる名前か、`toNecSuf.` の後の名前）で引いていること。
 *      本文のラベルを持たない導出版の補題（系の定理の本体の導出版など）を一段だけ中継してよく、その補題は自分の名前から
 *      接尾辞を除いた必要十分版の宣言を同じ形で引いていなければならない。本文のラベルを持つ別の主張の導出版から組み立てたもの、
 *      具体版の同じ名前の定理を引いたものは落ちる（docs/context/証明の書き方.md の「具体版が必要十分版の特殊化として得られること」）。
 *   5. docstring が引く本文のラベル（`claim_`・`def_`・`theorem_` で始まり、`` ` `` で囲んだもの）が本文に実在すること。
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
type Decl = { file: string; name: string; fullName: string; version: Version; labels: Set<string>; body: string };
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
// コメントと docstring を、改行を残して空白に置き換える（字面の位置を保ったまま、本文の字面だけを残す）。
const blankComments = (text: string): string =>
  text.replace(/\/-[\s\S]*?-\//g, (c) => c.replace(/[^\n]/g, " ")).replace(/--[^\n]*/g, (c) => " ".repeat(c.length));
const SCOPE_LINE = /^[ \t]*(?:(namespace)[ \t]+(\S+)|(?:noncomputable[ \t]+)?(section)\b(?:[ \t]+(\S+))?|(end)\b(?:[ \t]+(\S+))?)[ \t]*$/gm;
for (const file of leanFiles(sourceRoot)) {
  const text = readFileSync(file, "utf8");
  const code = blankComments(text);
  const docs = new Map<number, Set<string>>();
  for (const m of text.matchAll(DOC_THEN_DECL)) {
    const declStart = (m.index ?? 0) + m[0].length - m[2].length;
    docs.set(declStart, new Set([...m[1].matchAll(LABEL_IN_DOC)].map((x) => x[1])));
  }
  // 名前空間: namespace X で X の成分を積み、end X で降ろす。section と名前の無い end は名前空間を変えない。
  const scopeAt: { at: number; namespace: string }[] = [];
  // section の名前は名前空間に入らないので、name に持つだけで parts には積まない。
  const stack: { kind: "namespace" | "section"; name: string; parts: string[] }[] = [];
  const current = (): string => stack.flatMap((s) => s.parts).join(".");
  for (const m of code.matchAll(SCOPE_LINE)) {
    if (m[1]) stack.push({ kind: "namespace", name: m[2], parts: m[2].split(".") });
    else if (m[3]) stack.push({ kind: "section", name: m[4] ?? "", parts: [] });
    else if (m[5]) {
      const top = stack.pop();
      if (top === undefined) throw new Error(`${relative(leanRoot, file)}: 対応する namespace・section の無い end`);
      if ((m[6] ?? "") !== top.name) {
        throw new Error(`${relative(leanRoot, file)}: end ${m[6] ?? ""} が ${top.kind} ${top.name} と合わない`);
      }
    }
    scopeAt.push({ at: m.index ?? 0, namespace: current() });
  }
  const namespaceAt = (pos: number): string => scopeAt.filter((s) => s.at < pos).at(-1)?.namespace ?? "";
  const starts = [...code.matchAll(DECL_LINE)];
  starts.forEach((m, i) => {
    const declStart = (m.index ?? 0) + m[0].length - m[1].length;
    const ns = namespaceAt(m.index ?? 0);
    const fullName = m[1].startsWith("_root_.") ? m[1].slice("_root_.".length) : ns === "" ? m[1] : `${ns}.${m[1]}`;
    const end = i + 1 < starts.length ? (starts[i + 1].index ?? code.length) : code.length;
    decls.push({
      file: relative(leanRoot, file),
      name: lastComponent(m[1]),
      fullName,
      version: versionOf(file),
      labels: docs.get(declStart) ?? new Set(),
      body: code.slice(declStart + m[1].length, end),
    });
  });
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
const ROOT = "CliffordMatrixIsomorphism.";
// 必要十分版の名前空間は、具体版の名前空間の ROOT の後ろに NecSuf. を挟んだものである。ただし線型空間と代数の名前空間だけは、
// 係数を ℂ に固定しない名前に替えてある（lean/README.md の「置き場と名前空間」）。
const NECSUF_NAMESPACE_RENAMES: readonly (readonly [string, string])[] = [
  ["VectorSpace", "ComplexVectorSpace"],
  ["AlgebraOver", "ComplexAlgebra"],
];
const withoutRoot = (fullName: string): string => (fullName.startsWith(ROOT) ? fullName.slice(ROOT.length) : fullName);
// 宣言の名前を、版によらない名前（ROOT を除き、必要十分版は NecSuf. を除いて名前空間を具体版の名前に戻したもの）にする。
const keyOf = (d: Decl): string => {
  const rel = withoutRoot(d.fullName);
  if (d.version !== "necSuf") return rel;
  if (!rel.startsWith("NecSuf.")) return `NecSuf-outside:${rel}`;
  const parts = rel.slice("NecSuf.".length).split(".");
  const renamed = NECSUF_NAMESPACE_RENAMES.find(([from]) => from === parts[0]);
  if (renamed !== undefined && parts.length > 1) parts[0] = renamed[1];
  return parts.join(".");
};
const derivedBaseKeys = (d: Decl): string[] =>
  DERIVED_SUFFIXES.filter((x) => d.name.endsWith(x)).map((x) => keyOf(d).slice(0, -x.length));
const mentioned = (labels: readonly string[], pred: (d: Decl) => boolean): boolean =>
  decls.some((d) => pred(d) && labels.some((l) => d.labels.has(l)));
const concreteKeys = (labels: readonly string[]): Set<string> =>
  new Set(decls.filter((d) => d.version === "concrete" && labels.some((l) => d.labels.has(l))).map(keyOf));
// 主張の必要十分版の宣言：docstring にラベルを持つか、ラベルを docstring に持つ具体版と同じ名前（名前空間も込み）のもの。
const necSufDecls = (labels: readonly string[]): Decl[] => {
  const keys = concreteKeys(labels);
  return decls.filter((d) => d.version === "necSuf" && (labels.some((l) => d.labels.has(l)) || keys.has(keyOf(d))));
};
// 主張の導出版の宣言：名前が導出版の接尾辞で終わり、docstring にラベルを持つか、接尾辞を除いた名前（名前空間も込み）が
// ラベルを docstring に持つ具体版の名前であるもの。
const derivedDecls = (labels: readonly string[]): Decl[] => {
  const keys = concreteKeys(labels);
  return decls.filter(
    (d) =>
      d.version === "derived" &&
      DERIVED_NAME.test(d.name) &&
      (labels.some((l) => d.labels.has(l)) || derivedBaseKeys(d).some((k) => keys.has(k))),
  );
};

// 導出版が必要十分版を特殊化していること。導出版の本文（コメントを除く）が、対応する必要十分版の宣言を、
// 必要十分版と分かる形（`NecSuf.` で始まる名前、`toNecSuf.` の後の名前）で引いていれば、直接に特殊化している。
// 対応する必要十分版の宣言は、主張の必要十分版の宣言と、導出版の名前から接尾辞を除いた名前の必要十分版の宣言である。
// もう一つの形として、導出版のファイルにある本文のラベルを持たない導出版の補題（系の定理の本体の導出版など。名前が導出版の
// 接尾辞で終わるもの）を引き、その補題が自分の名前から接尾辞を除いた必要十分版の宣言を直接に引いていてもよい。中継は一段に限る。
// 本文のラベルを持つ別の主張の導出版を引いて組み立てたものは、特殊化と認めない（docs/context/証明の書き方.md の
// 「具体版が必要十分版の特殊化として得られること」）。
const IDENT_CHAR = String.raw`[\p{L}\p{N}_'!?₀-₉]`;
const escapeRegExp = (x: string): string => x.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
const refersAsNecSuf = (body: string, name: string): boolean =>
  new RegExp(String.raw`(?:NecSuf\.(?:${IDENT_CHAR}+\.)*|toNecSuf\)?\.)${escapeRegExp(name)}(?!${IDENT_CHAR})`, "u").test(body);
const refersTo = (body: string, name: string): boolean =>
  new RegExp(String.raw`(?<!${IDENT_CHAR})${escapeRegExp(name)}(?!${IDENT_CHAR})`, "u").test(body);
const labelledDecls = new Set<Decl>();
for (const { block } of blocks) {
  const labels = block.labels ?? [];
  if (labels.length === 0 || block.kind === "heading") continue;
  for (const d of [...necSufDecls(labels), ...derivedDecls(labels)]) labelledDecls.add(d);
  for (const d of decls) if (labels.some((l) => d.labels.has(l))) labelledDecls.add(d);
}
const necSufNames = new Set(decls.filter((d) => d.version === "necSuf").map((d) => d.name));
const ownNecSufNames = (d: Decl): string[] =>
  DERIVED_SUFFIXES.filter((x) => d.name.endsWith(x)).map((x) => d.name.slice(0, -x.length));
const specializesDirectly = (d: Decl, names: readonly string[]): boolean =>
  names.filter((n) => necSufNames.has(n)).some((n) => refersAsNecSuf(d.body, n));
const relayHelpers = decls.filter(
  (d) => d.version === "derived" && DERIVED_NAME.test(d.name) && !labelledDecls.has(d) && specializesDirectly(d, ownNecSufNames(d)),
);
const isGrounded = (d: Decl, counterparts: readonly string[]): boolean =>
  specializesDirectly(d, [...counterparts, ...ownNecSufNames(d)]) ||
  relayHelpers.some((h) => h !== d && refersTo(d.body, h.name));

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
  const necSufFound = necSufDecls(labels);
  const derivedFound = derivedDecls(labels);
  const necSuf = necSufFound.length > 0;
  const derived = derivedFound.length > 0;
  if (labels.some((l) => noNecSuf.has(l))) {
    excepted += 1;
    if (necSuf || derived) problems.push(`${where}: 必要十分版か導出版の宣言があるので、例外（必要十分版を置かない主張）から外す`);
    continue;
  }
  if (!necSuf) problems.push(`${where}: 必要十分版の宣言が無い`);
  if (!derived) problems.push(`${where}: 導出版（…_of_necSuf・…_eq_of_necSuf・…_eq_necSuf）の宣言が無い`);
  if (necSuf && derived) {
    const counterparts = necSufFound.map((d) => d.name);
    if (!derivedFound.some((d) => isGrounded(d, counterparts))) {
      problems.push(
        `${where}: 導出版（${derivedFound.map((d) => d.name).join("・")}）が必要十分版（${[...new Set(counterparts)].join("・")}）を` +
          `特殊化していない（本文のラベルを持つ別の主張の導出版から組み立てている）`,
      );
    }
  }
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
