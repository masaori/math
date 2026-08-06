/**
 * **欄を閉じる前提の検査**（cycle 49 step 1 で新設）。
 *
 * 設計と限界は `closing-precondition-model.ts` を正本とする。
 *
 * 対応表（どの `lean/` のファイルがどの主張に対応するか）は宣言しない。機械が導く——
 * 本文のブロックが宣言する Lean の定理名と、各ファイルが宣言する定理名の重なりで決める
 * （残り一覧の照合と同じ導き方である。宣言を二重に持つと片方だけが腐る）。
 */

import { readFileSync, readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import {
  LEAN_REMAINING_LEDGER,
  parseRemainingSection,
} from "./lean-remaining-model.ts";
import { FORMALIZATION_COVERAGE } from "./formalization-coverage.ts";
import { CLOSING_PRECONDITION_DISPOSITIONS } from "./closing-precondition-dispositions.ts";
import {
  auditClosingPrecondition,
  type ClosingEntry,
  type ClosingNamedItem,
} from "./closing-precondition-model.ts";
import { loadContentFiles } from "./content-modules.ts";

const here = dirname(fileURLToPath(import.meta.url));
const leanDir = join(here, "..", "..", "lean", "IntegrableLattice");

const leanFiles = readdirSync(leanDir).filter((name) => name.endsWith(".lean"));
const declaredIn = new Map<string, Set<string>>();
for (const file of leanFiles) {
  const names = new Set<string>();
  for (const m of readFileSync(join(leanDir, file), "utf8").matchAll(
    /^(?:private\s+|protected\s+|noncomputable\s+)*(?:theorem|lemma|def|abbrev|instance)\s+([A-Za-z_][A-Za-z0-9_'!?]*)/gm,
  )) {
    names.add(m[1]!);
  }
  declaredIn.set(file, names);
}

const jaBlocks: { id: string; lean?: readonly string[]; labels?: readonly string[] }[] = [];
for (const { blocks } of await loadContentFiles()) {
  for (const block of blocks) {
    jaBlocks.push(block as { id: string; lean?: readonly string[]; labels?: readonly string[] });
  }
}

/** 本文ブロックの地の文（`対象外（本文が要求していない）` の照合に使う。id でもラベルでも引ける）。 */
function stringLeaves(node: unknown, out: string[]): void {
  if (typeof node === "string") {
    out.push(node);
    return;
  }
  if (Array.isArray(node)) {
    for (const child of node) stringLeaves(child, out);
    return;
  }
  if (node !== null && typeof node === "object") {
    for (const child of Object.values(node)) stringLeaves(child, out);
  }
}

const blockPlainText = new Map<string, string>();
for (const { blocks } of await loadContentFiles()) {
  for (const block of blocks) {
    const b = block as { id: string; labels?: readonly string[] };
    const leaves: string[] = [];
    stringLeaves(block, leaves);
    const text = leaves.join("\n");
    blockPlainText.set(b.id, text);
    for (const label of b.labels ?? []) blockPlainText.set(label, text);
  }
}
const allPlainText = [...new Set(blockPlainText.values())].join("\n");

function blocksFor(file: string): string[] {
  const names = declaredIn.get(file) ?? new Set<string>();
  const out: string[] = [];
  for (const block of jaBlocks) {
    const leanNames: readonly string[] = block.lean ?? [];
    if (leanNames.length === 0) continue;
    if (leanNames.some((name) => names.has(name.split(".").pop()!))) out.push(block.id);
  }
  return out;
}

/** 欄ごとに、`lean/` が未形式化として名指している事柄を集める。 */
const namedByBlock = new Map<string, ClosingNamedItem[]>();
let unlinked = 0;
for (const entry of LEAN_REMAINING_LEDGER) {
  const section = parseRemainingSection(readFileSync(join(leanDir, entry.file), "utf8"));
  if (!section) continue;
  const linked = blocksFor(entry.file);
  for (const item of entry.items) {
    if (item.kind !== "未形式化") continue;
    if (linked.length === 0) {
      // 本文の主張へ紐づかないファイルは外部定理の台帳が受け持つ（残り一覧の照合が見ている）。
      unlinked += 1;
      continue;
    }
    for (const block of linked) {
      if (!namedByBlock.has(block)) namedByBlock.set(block, []);
      namedByBlock.get(block)!.push({
        file: entry.file,
        phrase: item.crossFilePhrase,
        fragment: item.ledgerFragment,
      });
    }
  }
}

const entries: ClosingEntry[] = FORMALIZATION_COVERAGE.map((entry) => {
  const e = entry as unknown as {
    block: string;
    state: string;
    remainingItems?: readonly string[];
    partStates?: readonly { part: string; state: string }[];
  };
  return {
    block: e.block,
    state: e.state,
    remainingItems: e.remainingItems ?? [],
    parts: e.partStates ?? [],
    named: namedByBlock.get(e.block) ?? [],
  };
});

const openBlocks = new Set(
  FORMALIZATION_COVERAGE.filter((e) => e.state !== "完了").map((e) => e.block),
);

const { violations, counts } = auditClosingPrecondition({
  entries,
  dispositions: CLOSING_PRECONDITION_DISPOSITIONS,
  openBlockExists: (block) => openBlocks.has(block),
  blockText: (block) => blockPlainText.get(block) ?? null,
  allText: allPlainText,
});

console.log("");
console.log("欄を閉じる前提の検査（cycle 49 step 1 で新設）");
console.log(
  `  欄 ${entries.length} 件 / うち lean が未形式化を名指している欄 ${namedByBlock.size} 件 / ` +
    `名指された事柄 ${counts.named} 件`,
);
console.log(
  `  内訳: 残り項目にそのまま当たる ${counts.autoCounted} 件 / ` +
    `部で数えている ${counts.byPart} 件 / 別の言い方の残り項目 ${counts.byAlias} 件 / ` +
    `別の欄で数えている ${counts.byOtherBlock} 件 / ` +
    `本文が要求していない（本文の走査で確かめる）${counts.byTextScan} 件 / ` +
    `**道具の一般性として対象外（機械が確かめられない）${counts.byHumanReading} 件**`,
);
console.log(
  `  本文の主張へ紐づかない未形式化の項目 ${unlinked} 件（外部定理の台帳が受け持つ。残り一覧の照合を見よ）`,
);
console.log(
  "  **なぜこれを測るか**: 残り一覧の照合が持っている「残りがあるのに完了」の判定は、" +
    "台帳の欄が 完了 になって初めて発火する。**欄が 部分的 である限り、" +
    "`lean/` 側が何を挙げていても緑のままだった。** cycle 48 は 1 つの欄を 完了 に書いた瞬間に" +
    "16 件の異議を受け、そのうち 4 件は既に済んでいた腐りだった。" +
    "**他の欄でも同じ腐りが在るかは、閉じてみるまで分からない。だから閉じる前に全数で当てる。**",
);
console.log(
  "  **cycle 50 step 4 で、機械が確かめられない処分を 1 件ずつ開けた。2 件は本文の走査で確かめられた。そう書く**——" +
    "「一般の有限アーベル群による指標分解は本文の内容ではない」の根拠は" +
    "「本文が voltage 群を巡回群 2 つの積として定義しており、一般の有限アーベル群を 1 度も要求していない」" +
    "ことであって、本文を読めば決まる。**そこで、本文に在るべき語と本文に無いべき語の両方を宣言させ、" +
    "機械が本文で確かめる種別へ移した。**残る「道具の一般性」は、本文の走査では決まらないものだけである。",
);
console.log(
  "  限界: **拾えるのは `lean/` が残り一覧に書いた事柄だけ**であり、" +
    "残り一覧に載っていない段が存在しうることはこの検査でも塞げない。" +
    "**塞げないので、機械が確かめられない処分（道具の一般性）の件数を毎回出す。**",
);

if (violations.length > 0) {
  console.log("");
  for (const v of violations) console.log(`  ${v}`);
  console.log("");
  console.log(`違反 ${violations.length} 件。`);
  process.exit(1);
}
console.log("");
console.log("違反 0 件。");
