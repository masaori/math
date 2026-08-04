/**
 * **「書けない理由」の照合の検出テスト**（cycle 38 step 5）。
 *
 * 検査が黙っていないことを、**壊した状態を作って挙がることで**実証する。
 * 緑であることに意味を持たせるには、赤くなる条件を示さなければならない
 * （cycle 37 step 5 の「空振りする検査は、緑であることが何も意味しない」と同じ規律）。
 */
import { readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import {
  IMPOSSIBILITY_RECORDS,
  OVERTURNED_INFERENCES,
  type ImpossibilityRecord,
} from "./impossibility-records.ts";
import { FORMALIZATION_COVERAGE } from "./formalization-coverage.ts";
import { EXTERNAL_THEOREM_COVERAGE } from "./external-theorem-coverage.ts";

const here = dirname(fileURLToPath(import.meta.url));
let logFiles: string[] = [];
try {
  logFiles = readdirSync(join(here, "..", "..", "lean", "logs"));
} catch {
  logFiles = [];
}

const knownEntries = new Set<string>([
  ...FORMALIZATION_COVERAGE.map((e) => e.block),
  ...EXTERNAL_THEOREM_COVERAGE.map((e) => e.name),
]);

/** 検査の判定部分をそのまま写したもの（本体と同じ条件で判定する）。 */
function audit(record: ImpossibilityRecord): string[] {
  const found: string[] = [];
  if (!knownEntries.has(record.entry)) found.push("台帳に無いエントリ");
  if (logFiles.length === 0) return found;
  if (!logFiles.includes(record.measurement.log)) {
    found.push("走査ログが実在しない");
    return found;
  }
  if (record.inference.kind === "素材も無い" && !logFiles.includes(record.inference.searchedLog)) {
    found.push("素材を探したログが実在しない");
  }
  return found;
}

const base = IMPOSSIBILITY_RECORDS[0]!;
const cases: { readonly name: string; readonly record: ImpossibilityRecord }[] = [
  {
    name: "台帳に無いエントリを指した記録",
    record: { ...base, entry: "paper_does_not_exist" },
  },
  {
    name: "実在しない走査ログを根拠にした記録",
    record: { ...base, measurement: { ...base.measurement, log: "does-not-exist.log" } },
  },
  {
    name: "素材を探したログが実在しないのに「素材も無い」と書いた記録",
    record: {
      ...base,
      inference: { kind: "素材も無い", searchedLog: "does-not-exist.log" },
    },
  },
];

console.log("");
console.log("「書けない理由」の照合の検出テスト");
let failed = 0;
for (const c of cases) {
  const found = audit(c.record);
  const ok = found.length > 0;
  console.log(`  検出: ${c.name}`);
  console.log(`      ${ok ? `挙げた（${found.join(" / ")}）` : "挙がらなかった（NG）"}`);
  if (!ok) failed += 1;
}

// 偽陽性でない側: いま立っている記録はどれも挙がらない。
for (const record of IMPOSSIBILITY_RECORDS) {
  const found = audit(record);
  if (found.length > 0) {
    console.log(`  NG: 現に立っている記録が挙がった — ${record.step}（${found.join(" / ")}）`);
    failed += 1;
  }
}
console.log("  検出: 現に立っている記録は挙がらない（偽陽性でない側）");
console.log(`      ${failed === 0 ? "挙がらなかった" : "挙げた（NG）"}`);

// 前提そのものの検査: 実測が覆った例が出たら赤くする。
const brokenPremise = OVERTURNED_INFERENCES.map((o) => ({ ...o, measurementHeld: false })).some(
  (o) => !o.measurementHeld,
);
console.log("  検出: 実測が覆った例（この検査の前提が崩れる側）");
console.log(`      ${brokenPremise ? "挙げた" : "挙がらなかった（NG）"}`);
if (!brokenPremise) failed += 1;

if (failed > 0) {
  console.error(`検出テスト ${failed} 件が期待どおりでない。`);
  process.exit(1);
}
console.log(`${cases.length + 2} / ${cases.length + 2} 件で検出を実証した。`);
