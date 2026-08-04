/**
 * **検査 M（空集合になりうる最小・最大の規約）**。本文の全ロケールについて、
 * 集合・添字族の上に取っている $\min$ / $\max$ が 1 つ残らず台帳に登録され、
 * その根拠の目印が本文に実在することを確かめる。
 *
 * 何をなぜ見るかは `extremum-model.ts` の doc を正本とする。要点だけ:
 * **空になりうるかは機械で判定できないが、「判断を書いたか」は機械で強制できる。**
 * 同型の事故が 4 回起きており、うち 2 回は 1 つの素数だけが落ちるので目視で見つからなかった。
 */

import { readFileSync, readdirSync } from "node:fs";
import { join, relative } from "node:path";

import type { TranslatedNode } from "../schema.ts";
import {
  contentDirForLocale,
  knownLocales,
  loadContentFilesForLocale,
  structuredLatexDir,
} from "./content-modules.ts";
import { EXTREMUM_ALLOWANCES } from "./extremum-allowances.ts";

/** `lean/` に実在する宣言名。台帳が指す定理が消えていないことを毎回確かめるために読む。 */
const declaredInLean = new Set<string>();
{
  const leanDir = join(structuredLatexDir, "..", "lean", "IntegrableLattice");
  for (const file of readdirSync(leanDir).filter((name) => name.endsWith(".lean"))) {
    for (const match of readFileSync(join(leanDir, file), "utf8").matchAll(
      /^(?:private\s+|protected\s+|noncomputable\s+)*(?:theorem|lemma|def|abbrev|instance)\s+([A-Za-z_][A-Za-z0-9_'!?]*)/gm,
    )) {
      declaredInLean.add(match[1]!);
    }
  }
}
import { classifyTex, type ExtremumForm, type ExtremumSite, keyOf, needsJudgement } from "./extremum-model.ts";

/** ブロックの中身（地の文と数式）を 1 本の文字列にする。目印の実在を見るのに使う。 */
const flatten = (nodes: readonly TranslatedNode[]): string => {
  let out = "";
  for (const node of nodes) {
    switch (node.type) {
      case "text":
      case "todo":
        out += node.value;
        break;
      case "math":
      case "displayMath":
        out += node.tex;
        break;
      case "paragraph":
        out += flatten(node.children);
        break;
      case "list":
        for (const item of node.items) out += flatten(item);
        break;
      default:
        break;
    }
  }
  return out;
};

const collect = (
  nodes: readonly TranslatedNode[],
  base: Omit<ExtremumSite, "op" | "form" | "fingerprint">,
  out: ExtremumSite[],
): void => {
  for (const node of nodes) {
    switch (node.type) {
      case "math":
      case "displayMath":
        for (const found of classifyTex(node.tex)) out.push({ ...base, ...found });
        break;
      case "paragraph":
        collect(node.children, base, out);
        break;
      case "list":
        for (const item of node.items) collect(item, base, out);
        break;
      default:
        break;
    }
  }
};

const sites: ExtremumSite[] = [];
/** ラベル → そのラベルを持つブロックの中身（原文ロケール）。前方参照の目印を見るのに使う。 */
const textByLabel = new Map<string, string>();
/** ブロック id → 中身（原文ロケール）。 */
const textByBlock = new Map<string, string>();
const perLocale: { locale: string; blocks: number; occurrences: number }[] = [];

for (const locale of knownLocales) {
  const files = await loadContentFilesForLocale(locale);
  const before = sites.length;
  let blocks = 0;
  for (const { file, blocks: loaded } of files) {
    for (const block of loaded) {
      if (block.kind === "heading" || block.kind === "figure") continue;
      blocks += 1;
      const base = {
        locale,
        blockId: block.id,
        file: relative(structuredLatexDir, `${contentDirForLocale(locale)}/${file}`),
        where: "statement" as const,
      };
      collect(block.statement, base, sites);
      if (block.proof !== undefined) collect(block.proof, { ...base, where: "proof" }, sites);
      if (locale === knownLocales[0]) {
        const body = flatten(block.statement) + (block.proof ? flatten(block.proof) : "");
        textByBlock.set(block.id, body);
        for (const label of block.labels ?? []) textByLabel.set(label, body);
      }
    }
  }
  perLocale.push({ locale, blocks, occurrences: sites.length - before });
}

const byForm = new Map<ExtremumForm, number>();
for (const site of sites) byForm.set(site.form, (byForm.get(site.form) ?? 0) + 1);

const sourceLocale = knownLocales[0];
const judged = sites.filter((site) => needsJudgement(site.form) && site.locale === sourceLocale);

const declared = new Map<string, (typeof EXTREMUM_ALLOWANCES)[number]>();
const duplicates: string[] = [];
for (const allowance of EXTREMUM_ALLOWANCES) {
  const key = keyOf(allowance);
  if (declared.has(key)) duplicates.push(key);
  declared.set(key, allowance);
}

const observed = new Map<string, number>();
for (const site of judged) {
  const key = keyOf(site);
  observed.set(key, (observed.get(key) ?? 0) + 1);
}

type Violation = { kind: string; detail: string; where?: string };
const violations: Violation[] = [];

for (const key of duplicates) {
  violations.push({ kind: "台帳に同じ指紋が 2 度登録されている", detail: key });
}

for (const [key, count] of observed) {
  const allowance = declared.get(key);
  if (allowance === undefined) {
    const site = judged.find((candidate) => keyOf(candidate) === key);
    violations.push({
      kind: "未登録の最小・最大",
      detail: key,
      where: site === undefined ? undefined : `${site.file} (${site.where})`,
    });
    continue;
  }
  if (allowance.count !== count) {
    violations.push({
      kind: "登録した個数が実測と合わない",
      detail: `${key} — 台帳 ${allowance.count} 件 / 実測 ${count} 件`,
    });
  }
}

for (const [key, allowance] of declared) {
  if (!observed.has(key)) {
    violations.push({ kind: "宣言が余っている（その出現がもう本文に無い）", detail: key });
    continue;
  }
  const ground = allowance.ground;
  if (ground.type === "nonempty-by-construction") continue;
  const haystack =
    ground.type === "nonempty-argued-elsewhere"
      ? textByLabel.get(ground.label)
      : textByBlock.get(allowance.block);
  if (haystack === undefined) {
    violations.push({
      kind:
        ground.type === "nonempty-argued-elsewhere"
          ? "根拠が指すラベルのブロックが本文に無い"
          : "登録したブロックが本文に無い",
      detail: key,
    });
    continue;
  }
  if (!haystack.includes(ground.marker)) {
    violations.push({
      kind: "根拠の目印が本文から消えている",
      detail: `${key} — 目印「${ground.marker}」`,
    });
  }
}

const byGround = new Map<string, number>();
for (const allowance of EXTREMUM_ALLOWANCES) {
  byGround.set(allowance.ground.type, (byGround.get(allowance.ground.type) ?? 0) + 1);
}

const GROUND_LABEL: Record<string, string> = {
  "nonempty-by-construction": "構成から空でない",
  "nonempty-argued-here": "空でないことを本文が論じている",
  "nonempty-argued-elsewhere": "空でないことを別のブロックが論じている",
  "empty-convention-stated": "空になりうるので読み方を書いた",
};

console.log("");
console.log("空集合になりうる最小・最大の検査（検査 M）");
console.log(
  `  走査: ロケール ${perLocale.length} 件 / ${perLocale
    .map((entry) => `${entry.locale}: ブロック ${entry.blocks}・出現 ${entry.occurrences}`)
    .join(" / ")}`,
);
console.log(
  `  形の内訳（${sourceLocale}）: ` +
    (["set-builder", "indexed", "tuple", "decoration", "bare-mention", "about-convention"] as const)
      .map(
        (form) =>
          `${form} ${sites.filter((site) => site.locale === sourceLocale && site.form === form).length}`,
      )
      .join(" / "),
);
console.log(
  `  **判断が要る出現: ${judged.length} 件**（集合の上・添字族の上に取っているもの）` +
    ` / 指紋 ${observed.size} 件 / 台帳 ${EXTREMUM_ALLOWANCES.length} 件`,
);
console.log("");
console.log("  根拠の内訳:");
for (const [type, label] of Object.entries(GROUND_LABEL)) {
  console.log(`    ${label}: ${byGround.get(type) ?? 0} 件`);
}
const byConstruction = EXTREMUM_ALLOWANCES.filter(
  (allowance) => allowance.ground.type === "nonempty-by-construction",
);
const backed = byConstruction.filter(
  (allowance) =>
    allowance.ground.type === "nonempty-by-construction" && allowance.ground.leanTheorem !== undefined,
);
for (const allowance of backed) {
  const ground = allowance.ground;
  if (ground.type !== "nonempty-by-construction" || ground.leanTheorem === undefined) continue;
  const short = ground.leanTheorem.split(".").at(-1)!;
  if (!declaredInLean.has(short)) {
    violations.push({
      kind: "根拠が指す Lean の定理が lean/ に無い",
      detail: `${allowance.block} — ${ground.leanTheorem}`,
    });
  }
}

console.log(
  `    ↑ このうち「${GROUND_LABEL["nonempty-by-construction"]}」${byConstruction.length} 件は` +
    "tex の文字列からは判定できない。「この添字族は空でない」は数学の判断だからである。" +
    "残り 3 種類は目印の実在を毎回確かめている（本文からその一文が消えれば赤くなる）。",
);
console.log(
  `    そのうち **${backed.length} 件は Lean の定理で裏を取ってある**` +
    `（残り ${byConstruction.length - backed.length} 件は人の判断のまま）。` +
    "定理名が `lean/` に実在することは毎回確かめる。",
);
if (byConstruction.length > backed.length) {
  console.log("    裏が取れていないもの:");
  for (const allowance of byConstruction) {
    const ground = allowance.ground;
    if (ground.type !== "nonempty-by-construction" || ground.leanTheorem !== undefined) continue;
    console.log(`      ${allowance.block} — ${allowance.fingerprint.slice(0, 44)}`);
  }
}

if (violations.length > 0) {
  console.log("");
  console.log(`  **違反 ${violations.length} 件**`);
  for (const violation of violations) {
    console.log(`    [${violation.kind}] ${violation.detail}`);
    if (violation.where !== undefined) console.log(`      ${violation.where}`);
  }
  console.log("");
  console.log("  直し方: 空になりうるかを判断し、`tools/extremum-allowances.ts` へ根拠つきで登録する。");
  console.log("  空になりうるなら、空のときの読み方を**本文**へ書いてから登録する（規約は注記ではない）。");
  console.log("");
  console.log(`違反 ${violations.length} 件。`);
  process.exit(1);
}

console.log("");
console.log(
  "  限界: 見るのは `math` / `displayMath` の tex だけで、地の文に日本語で書かれた「最小」は対象外。" +
    "`\\operatorname{min}` のような別綴りも拾わない（本文に 0 件であることを実測している）。",
);
console.log("");
console.log("違反 0 件。");
