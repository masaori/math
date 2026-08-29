/**
 * 成果整理の第一層: 本文の全ブロック（定義・主張・定理ほか）を旧章から外して一覧化し、
 * 参照依存を抽出する。
 *
 * 章の見出しは「どの章に属していたか」の記録としてだけ持ち、分類の根拠には使わない。
 * 依存は 2 経路から集める: ノード木の `ref`（type: "ref"）と、数式文字列中の `\blkref{...}`。
 * どちらも解決先はラベルなので、ラベル → 所有ブロック id の表で引き当てる。
 *
 * 出力は Markdown（既定 docs/整理/全定義定理の一覧と参照依存.md）。
 * `--check` を付けると、既存の出力ファイルと一致するかだけを検査して差分があれば落ちる。
 */

import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { dirname, join } from "node:path";

import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";

type Entry = {
  file: string;
  chapter: string;
  id: string;
  kind: string;
  title: string;
  labels: string[];
  deps: string[];
  directCaMarkers: string[];
  ambientCaContext: boolean;
  classification?: "数学的道具立て" | "2 値セルオートマトンのセマンティクスを持つもの";
  classificationBasis?: string;
};

const blkrefPattern = /\\blkref\{([^}]+)\}/g;
const caSemanticMarkers = [
  "2 値",
  "二値",
  "セルオートマトン",
  "有限 CA",
  "状態集合",
  "局所真理値表",
  "局所規則",
  "大域写像",
  "時間発展",
  "一段発展",
  "配位",
  "イベント集合",
  "一段依存",
  "依存経路",
] as const;
const ambientCaSemanticFiles = new Set([
  "global-map-iteration.ts",
  "iterate-monoid-conjugacy-invariance.ts",
  "iterate-monoid-conjugacy-numerical-profile.ts",
  "iterate-monoid-cycle-idempotent.ts",
  "iterate-monoid-cyclic-group.ts",
  "iterate-monoid-idempotents.ts",
  "iterate-monoid-minimal-period.ts",
  "iterate-monoid-principal-ideal-tail.ts",
  "iterate-monoid-root-depth-preperiod-correspondence.ts",
  "iterate-monoid-stabilization-index.ts",
  "iterate-monoid-stable-fiber-depth.ts",
  "iterate-monoid-stable-fiber-dynamics.ts",
  "iterate-monoid-stable-fiber-layer-branching.ts",
  "iterate-monoid-stable-fiber-layer-preimage.ts",
  "iterate-monoid-stable-fiber-predecessor-count.ts",
  "iterate-monoid-stable-fiber-rooted-tree.ts",
  "iterate-monoid-stable-image.ts",
  "iterate-monoid-stable-partition.ts",
  "iterate-monoid-tail-cycle-decomposition.ts",
  "iterate-monoid-tail-equivalence.ts",
  "iterate-monoid.ts",
]);

function collectFromNode(node: unknown, into: Set<string>): void {
  if (node === null || typeof node !== "object") return;
  if (Array.isArray(node)) {
    for (const child of node) collectFromNode(child, into);
    return;
  }
  const record = node as Record<string, unknown>;
  if (record.type === "ref" && typeof record.target === "string") into.add(record.target);
  for (const value of Object.values(record)) {
    if (typeof value === "string") {
      for (const match of value.matchAll(blkrefPattern)) {
        const label = match[1];
        if (label !== undefined) into.add(label);
      }
    } else {
      collectFromNode(value, into);
    }
  }
}

function titleOf(block: Record<string, unknown>): string {
  const title = block.title as { text?: string } | undefined;
  return typeof title?.text === "string" ? title.text : "";
}

function collectVisibleStrings(node: unknown, into: string[]): void {
  if (typeof node === "string") {
    into.push(node);
    return;
  }
  if (node === null || typeof node !== "object") return;
  if (Array.isArray(node)) {
    for (const child of node) collectVisibleStrings(child, into);
    return;
  }
  const record = node as Record<string, unknown>;
  for (const [key, value] of Object.entries(record)) {
    if (key === "id" || key === "labels" || key === "target") continue;
    collectVisibleStrings(value, into);
  }
}

const contentFiles = await loadContentFiles();

const entries: Entry[] = [];
const labelOwner = new Map<string, string>();
let chapter = "（見出し以前）";

for (const { file, blocks } of contentFiles) {
  for (const raw of blocks) {
    const block = raw as unknown as Record<string, unknown>;
    const kind = String(block.kind);
    if (kind === "heading") {
      chapter = titleOf(block);
      continue;
    }
    const deps = new Set<string>();
    collectFromNode(block.statement, deps);
    collectFromNode(block.proof, deps);
    const visibleStrings: string[] = [];
    collectVisibleStrings(block.title, visibleStrings);
    collectVisibleStrings(block.statement, visibleStrings);
    collectVisibleStrings(block.proof, visibleStrings);
    const visibleText = visibleStrings.join("\n");
    const directCaMarkers = caSemanticMarkers.filter((marker) => visibleText.includes(marker));
    const labels = (block.labels as string[] | undefined) ?? [];
    for (const label of labels) labelOwner.set(label, String(block.id));
    entries.push({
      file,
      chapter,
      id: String(block.id),
      kind,
      title: titleOf(block),
      labels,
      deps: [...deps].sort(),
      directCaMarkers,
      ambientCaContext: ambientCaSemanticFiles.has(file),
    });
  }
}

const caEntryIds = new Set(
  entries
    .filter((entry) => entry.directCaMarkers.length > 0 || entry.ambientCaContext)
    .map((entry) => entry.id),
);
let classificationChanged = true;
while (classificationChanged) {
  classificationChanged = false;
  for (const entry of entries) {
    if (caEntryIds.has(entry.id)) continue;
    const caDependency = entry.deps
      .map((label) => labelOwner.get(label))
      .find((owner) => owner !== undefined && caEntryIds.has(owner));
    if (caDependency !== undefined) {
      caEntryIds.add(entry.id);
      classificationChanged = true;
    }
  }
}

for (const entry of entries) {
  if (entry.directCaMarkers.length > 0) {
    entry.classification = "2 値セルオートマトンのセマンティクスを持つもの";
    entry.classificationBasis = `本文中の CA 固有語: ${entry.directCaMarkers.join("、")}`;
    continue;
  }
  if (entry.ambientCaContext) {
    entry.classification = "2 値セルオートマトンのセマンティクスを持つもの";
    entry.classificationBasis = "ファイル全体が有限 CA の大域写像の反復を共通文脈として仮定する";
    continue;
  }
  const caDependency = entry.deps
    .map((label) => ({ label, owner: labelOwner.get(label) }))
    .find(({ owner }) => owner !== undefined && caEntryIds.has(owner));
  if (caDependency !== undefined) {
    entry.classification = "2 値セルオートマトンのセマンティクスを持つもの";
    entry.classificationBasis = `CA セマンティクスを持つ参照先に依存: ${caDependency.label}`;
  } else {
    entry.classification = "数学的道具立て";
    entry.classificationBasis = "CA 固有語を含まず、CA セマンティクスを持つ参照先にも依存しない";
  }
}

const mathEntries = entries.filter((entry) => entry.classification === "数学的道具立て");
const caEntries = entries.filter(
  (entry) => entry.classification === "2 値セルオートマトンのセマンティクスを持つもの",
);
const contaminatedMathEntries = mathEntries.filter((entry) => {
  if (entry.directCaMarkers.length > 0) return true;
  if (entry.ambientCaContext) return true;
  return entry.deps.some((label) => {
    const owner = labelOwner.get(label);
    return owner !== undefined && caEntryIds.has(owner);
  });
});

const positionOf = new Map<string, number>();
entries.forEach((entry, index) => positionOf.set(entry.id, index));

const unresolved: string[] = [];
const backward: string[] = [];
for (const entry of entries) {
  for (const dep of entry.deps) {
    const owner = labelOwner.get(dep);
    if (owner === undefined) {
      unresolved.push(`${entry.id} → ${dep}`);
      continue;
    }
    if (owner === entry.id) continue;
    if ((positionOf.get(owner) ?? -1) > (positionOf.get(entry.id) ?? -1)) {
      backward.push(`${entry.id} → ${dep}（所有: ${owner}）`);
    }
  }
}

const kindCount = new Map<string, number>();
for (const entry of entries) kindCount.set(entry.kind, (kindCount.get(entry.kind) ?? 0) + 1);

const lines: string[] = [];
lines.push("# 全定義・全定理の一覧と参照依存（自動生成）");
lines.push("");
lines.push("このファイルは `structured-latex/tools/inventory-blocks.ts` が生成する。手で編集しない。");
lines.push("成果整理の「一覧化と参照依存の抽出」および「二章への全件分類」の出力である。");
lines.push("「旧章」列は分類の根拠ではなく、整理前にどの見出しの下にあったかの記録にすぎない。");
lines.push(
  "分類は、本文に CA 固有語がある項目と、それらへ参照依存する項目を CA セマンティクス側へ置く閉包で定める。",
);
lines.push(
  "数学的道具立て側は、2 元状態・局所規則・大域写像・時間発展を本文でも参照先でも仮定しない項目だけである。",
);
lines.push("");
lines.push("## 総数");
lines.push("");
lines.push("| 種別 | 件数 |");
lines.push("| --- | --- |");
for (const [kind, count] of [...kindCount].sort()) lines.push(`| ${kind} | ${count} |`);
lines.push(`| 合計 | ${entries.length} |`);
lines.push("");
lines.push(`本文ファイル数: ${contentFiles.length}。ラベル総数: ${labelOwner.size}。`);
lines.push(`未解決の参照: ${unresolved.length} 件。文書順で後ろを引く参照: ${backward.length} 件。`);
lines.push(
  `分類: 数学的道具立て ${mathEntries.length} 件、2 値セルオートマトンのセマンティクスを持つもの ${caEntries.length} 件。`,
);
lines.push(`数学的道具立てへの CA 固有語・CA 分類依存の混入: ${contaminatedMathEntries.length} 件。`);
lines.push("");
if (unresolved.length > 0) {
  lines.push("### 未解決の参照");
  lines.push("");
  for (const item of unresolved) lines.push(`- ${item}`);
  lines.push("");
}
if (backward.length > 0) {
  lines.push("### 文書順で後ろを引く参照");
  lines.push("");
  lines.push("現在の文書順（ファイル名昇順）では、次の参照だけが自分より後ろのブロックを引いている。");
  lines.push("章内をトポロジカル順へ並べ替える層で解消する対象である。");
  lines.push("");
  for (const item of backward) lines.push(`- ${item}`);
  lines.push("");
}
lines.push("## 一覧");
lines.push("");
lines.push("| 種別 | 表題 | 分類 | 分類根拠 | id | ラベル | 参照依存（ラベル） | 旧章 | ファイル |");
lines.push("| --- | --- | --- | --- | --- | --- | --- | --- | --- |");
entries.forEach((entry) => {
  const deps = entry.deps.length === 0 ? "—" : entry.deps.map((d) => `\`${d}\``).join("<br>");
  const labels = entry.labels.length === 0 ? "—" : entry.labels.map((l) => `\`${l}\``).join("<br>");
  lines.push(
    `| ${entry.kind} | ${entry.title} | ${entry.classification} | ${entry.classificationBasis} | \`${entry.id}\` | ${labels} | ${deps} | ${entry.chapter} | \`${entry.file}\` |`,
  );
});
lines.push("");

const output = lines.join("\n");
const target = join(structuredLatexDir, "..", "docs", "整理", "全定義定理の一覧と参照依存.md");

if (process.argv.includes("--check")) {
  const existing = readFileSync(target, "utf8");
  if (existing !== output) {
    console.error(`${target} が最新ではない。node tools/inventory-blocks.ts で再生成する。`);
    process.exit(1);
  }
  console.log(`一覧は最新（${entries.length} 件、未解決参照 ${unresolved.length} 件）。`);
} else {
  mkdirSync(dirname(target), { recursive: true });
  writeFileSync(target, output);
  console.log(`${target} を生成した（${entries.length} 件、未解決参照 ${unresolved.length} 件、後方参照 ${backward.length} 件）。`);
}
