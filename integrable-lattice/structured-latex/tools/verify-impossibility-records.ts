/**
 * **「書けない理由」の照合**（cycle 38 step 5 で新設。検査 I）。
 *
 * 台帳は `impossibility-records.ts`。そこに書いた根拠を機械が確かめる:
 *
 * 1. **実測の層**が指す走査ログが `lean/logs/` に実在すること。
 * 2. **推論の層**が `素材あり` なら、挙げた素材の名前がその走査ログに現れること
 *    （名前だけ書いて実在を確かめない道を塞ぐ）。
 * 3. `素材も無い` なら、**素材を探したこと自体のログ**が実在すること
 *    （探さずに「素材も無い」と書く道を塞ぐ）。
 * 4. 台帳の `entry` が、検査 F の台帳（本文の主張／外部定理）に実在すること。
 * 5. **覆った記録の実測がすべて保たれていること**——
 *    もし実測の側が覆った例が出たら、この検査の前提そのものが崩れるので赤くする。
 *
 * そのうえで **`素材あり` の記録を毎回印字する。** これが本検査の主目的である——
 * それらは**書けないのではなく、書いていないだけ**であり、着手する前に見える候補である。
 */
import { readFileSync, readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import {
  IMPOSSIBILITY_RECORDS,
  OVERTURNED_INFERENCES,
} from "./impossibility-records.ts";
import { FORMALIZATION_COVERAGE } from "./formalization-coverage.ts";
import { EXTERNAL_THEOREM_COVERAGE } from "./external-theorem-coverage.ts";

const here = dirname(fileURLToPath(import.meta.url));
const logDir = join(here, "..", "..", "lean", "logs");

const violations: string[] = [];

let logFiles: string[] = [];
let logBody = new Map<string, string>();
try {
  logFiles = readdirSync(logDir);
  for (const name of logFiles) logBody.set(name, readFileSync(join(logDir, name), "utf8"));
} catch {
  // `lean/` を持たない環境でも `npm run check` が通る前提に合わせる。
  logFiles = [];
}

const knownEntries = new Set<string>([
  ...FORMALIZATION_COVERAGE.map((e) => e.block),
  ...EXTERNAL_THEOREM_COVERAGE.map((e) => e.name),
]);

for (const record of IMPOSSIBILITY_RECORDS) {
  if (!knownEntries.has(record.entry)) {
    violations.push(
      `[台帳に無いエントリ] ${record.step} — 「${record.entry}」が検査 F の台帳に無い`,
    );
  }
  if (logFiles.length === 0) continue;
  if (!logFiles.includes(record.measurement.log)) {
    violations.push(
      `[走査ログが実在しない] ${record.step} — 「${record.measurement.log}」が lean/logs/ に無い`,
    );
    continue;
  }
  if (record.inference.kind === "素材あり") {
    const body = logBody.get(record.measurement.log)!;
    for (const material of record.inference.materials) {
      if (!body.includes(material)) {
        violations.push(
          `[素材が走査ログに現れない] ${record.step} — 「${material}」が ${record.measurement.log} に無い` +
            "（名前だけ書いて実在を確かめない道は塞いである）",
        );
      }
    }
  } else if (!logFiles.includes(record.inference.searchedLog)) {
    violations.push(
      `[素材を探したログが実在しない] ${record.step} — 「${record.inference.searchedLog}」が lean/logs/ に無い` +
        "（探さずに「素材も無い」と書く道は塞いである）",
    );
  }
}

for (const overturned of OVERTURNED_INFERENCES) {
  if (!overturned.measurementHeld) {
    violations.push(
      `[実測が覆った] ${overturned.cycle} — この検査は「実測は覆らず、覆るのは推論だけ」を前提にしている。` +
        "前提そのものが崩れたので、台帳の設計から見直すこと",
    );
  }
}

const writable = IMPOSSIBILITY_RECORDS.filter((r) => r.inference.kind === "素材あり");
const notWritable = IMPOSSIBILITY_RECORDS.filter((r) => r.inference.kind === "素材も無い");

console.log("");
console.log("「書けない理由」の照合（cycle 38 step 5 で追加）");
console.log(
  `  立っている記録 ${IMPOSSIBILITY_RECORDS.length} 件 / ` +
    `**素材あり（書けないのではなく書いていないだけ）${writable.length} 件** / ` +
    `素材も無い ${notWritable.length} 件 / 覆った推論 ${OVERTURNED_INFERENCES.length} 件`,
);
console.log(
  "  **測って分かったこと**: 覆った記録を全数で読むと、どれも「実測（mathlib に X が無い）」と" +
    "「推論（だから書けない）」の 2 層でできており、" +
    `**実測が覆った回数は 0、推論が覆った回数は ${OVERTURNED_INFERENCES.length} である。**` +
    "cycle 37 step 3 の記録がそれを 1 文で言っている——" +
    "「実測そのものは正しく、誤っていたのは『だからこの段は書けない』という推論のほうである」。",
);
console.log(
  "  **したがって着手せずに疑える形はある**——2 つの層を型で分け、" +
    "推論の側に「自前で書く素材を探したか」を必ず書かせる。" +
    "**素材が在ると分かっているものは、書けないのではなく書いていないだけである。**",
);
if (writable.length > 0) {
  console.log("  素材があるのに書いていないもの（着手する前に見える候補）:");
  for (const r of writable) {
    const materials = r.inference.kind === "素材あり" ? r.inference.materials.join(" / ") : "";
    console.log(`    - ${r.step}`);
    console.log(`        無いもの: ${r.measurement.absent}（${r.measurement.log}）`);
    console.log(`        素材: ${materials}`);
  }
}
console.log(
  "  **この形は既に 1 度、着手前の判断材料として働いている**——cycle 37 step 1 は" +
    "「Gauss 型の補題は無い。ただし素材そのものは在るので自前で書ける見込みはある」と書いており、" +
    "**cycle 38 step 1 はその 1 行を読んで着手し、実際に書けた。**",
);
console.log(
  "  限界: **「素材を探した」と書いたかどうかしか見られない**（探し方が十分だったかは人の判断）。" +
    "**「素材も無い」と書いた記録が正しいかは、依然として着手するまで分からない。**" +
    "塞げるのは「探さずに書けないと書く」道までである。" +
    `また覆った ${OVERTURNED_INFERENCES.length} 件は**試された件数と同じ**なので、` +
    "言えるのは「推論はいつも誤り」ではなく**「試されたものは全部誤りだった」**までである（標本はこちらが選んでいる）。",
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
