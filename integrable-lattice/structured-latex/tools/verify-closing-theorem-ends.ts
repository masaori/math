/**
 * **「残りを閉じる定理」の両端の棚卸しの検査**（cycle 39 step 4 で新設。検査 E）。
 *
 * 台帳は `closing-theorem-ends.ts`。機械が見るのは 4 つ。
 *
 * 1. 登録したファイルと定理が `lean/` に実在すること。
 * 2. **列挙した束縛子の集合が、ソースから読み取った束縛子の集合と一致すること。**
 *    これが本検査の本体である——**書き落とすと赤くなる。**
 * 3. `構成で与える` が指す定理が `lean/` に実在すること。
 * 4. 登録した欄が検査 F の台帳に実在すること。
 *
 * そのうえで **`受け取る` の全数を印字する。** それが「まだ閉じていない端」であり、
 * 散文の「残りは N 件」が数え落としてきたものである。
 */
import { readFileSync, readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import { CLOSING_THEOREMS, readBinders } from "./closing-theorem-ends.ts";
import { FORMALIZATION_COVERAGE } from "./formalization-coverage.ts";
import { EXTERNAL_THEOREM_COVERAGE } from "./external-theorem-coverage.ts";

const here = dirname(fileURLToPath(import.meta.url));
const leanDir = join(here, "..", "..", "lean", "IntegrableLattice");

const violations: string[] = [];

let leanFiles: string[] = [];
const leanBody = new Map<string, string>();
try {
  leanFiles = readdirSync(leanDir).filter((n) => n.endsWith(".lean"));
  for (const name of leanFiles) leanBody.set(name, readFileSync(join(leanDir, name), "utf8"));
} catch {
  // `lean/` を持たない環境でも `npm run check` が通る前提に合わせる。
  leanFiles = [];
}
const allLean = [...leanBody.values()].join("\n");

const knownEntries = new Set<string>([
  ...FORMALIZATION_COVERAGE.map((e) => e.block),
  ...EXTERNAL_THEOREM_COVERAGE.map((e) => e.name),
]);

let received = 0;
let supplied = 0;
let data = 0;

for (const entry of CLOSING_THEOREMS) {
  if (!knownEntries.has(entry.entry)) {
    violations.push(
      `[台帳に無いエントリ] ${entry.theorem} — 「${entry.entry}」が検査 F の台帳に無い`,
    );
  }
  for (const end of entry.ends) {
    if (end.kind === "受け取る") received += 1;
    else if (end.kind === "構成で与える") supplied += 1;
    else data += 1;
  }
  if (leanFiles.length === 0) continue;
  const body = leanBody.get(entry.file);
  if (body === undefined) {
    violations.push(`[ファイルが実在しない] ${entry.theorem} — ${entry.file} が lean/ に無い`);
    continue;
  }
  const actual = readBinders(body, entry.theorem);
  if (actual === null) {
    violations.push(
      `[定理が実在しない] ${entry.theorem} — ${entry.file} にその名前の定理が無い`,
    );
    continue;
  }
  const declared = entry.ends.map((e) => e.binder);
  const missing = actual.filter((n) => !declared.includes(n));
  const extra = declared.filter((n) => !actual.includes(n));
  if (missing.length > 0) {
    violations.push(
      `[束縛子を数え落としている] ${entry.theorem} — 署名に在るのに台帳が挙げていない: ` +
        `${missing.join(" / ")}` +
        "（「残り」を含意として数える道はここで塞いである。データか・構成で与えるか・受け取るかを書くこと）",
    );
  }
  if (extra.length > 0) {
    violations.push(
      `[署名に無い束縛子を挙げている] ${entry.theorem} — 台帳に在るのに署名に無い: ${extra.join(" / ")}` +
        "（改名・削除で腐った）",
    );
  }
  for (const end of entry.ends) {
    if (end.kind !== "構成で与える") continue;
    if (!new RegExp(`\\b(?:theorem|lemma|def)\\s+${end.suppliedBy}\\b`).test(allLean)) {
      violations.push(
        `[構成で与えると書いた定理が実在しない] ${entry.theorem} の ${end.binder} — ` +
          `「${end.suppliedBy}」が lean/ に無い`,
      );
    }
  }
}

console.log("");
console.log("残りを閉じる定理の両端の棚卸し（cycle 39 step 4 で追加）");
console.log(
  `  登録した定理 ${CLOSING_THEOREMS.length} 件 / 束縛子 ${data + supplied + received} 件` +
    `（データ ${data} / 構成で与える ${supplied} / **受け取る ${received}**）`,
);
console.log(
  "  **測って分かったこと**: 「残りが N 件」と書かれた欄に入ると N 件ではない、が 4 サイクル続いた" +
    "（cycle 35・36・38・39）。4 件を全数で読むと外れ方は 1 つの形に集まる——" +
    "**残りを閉じたと書いた定理が実は含意であり、その仮定を誰が与えるのかを書き手が数えていない。**",
);
console.log(
  "  **したがって数える対象を散文から署名へ移した**——束縛子を 1 つ残らず列挙させ、" +
    "データか・構成で与えるか・受け取るかを分類させる。" +
    "**列挙が署名と一致しなければ赤くなるので、数え落とす道は塞がる。**",
);
if (received > 0) {
  console.log("  まだ閉じていない端（散文の「残りは N 件」が数え落としてきたもの）:");
  for (const entry of CLOSING_THEOREMS) {
    for (const end of entry.ends) {
      if (end.kind !== "受け取る") continue;
      console.log(`    - ${entry.theorem} の ${end.binder}（${entry.entry}）`);
      console.log(`        ${end.why}`);
    }
  }
}
console.log(
  "  限界: **分類そのものは人の判断である**（`受け取る` を `データ` と書けば静かに通る）。" +
    "塞げるのは**数え落とし**であって**言い換え**ではない。" +
    "読み取るのは束縛子の名前だけで、型が何を言っているかは読まない。" +
    "**`構成で与える` が指す定理が本当にその仮定を与えるかも確かめられない**（実在だけを見る）。" +
    "対象はこの台帳に登録した定理だけで、**登録の網羅性は測れない**" +
    "（狭めたのであって塞いだのではない。cycle 34 step 4 の登録の網羅性と同じ性質）。",
);

if (violations.length > 0) {
  console.log("");
  console.log(`違反 ${violations.length} 件`);
  for (const violation of violations) console.log(`    ${violation}`);
  console.error(`違反 ${violations.length} 件。`);
  process.exit(1);
}
console.log("");
console.log("違反 0 件。");
