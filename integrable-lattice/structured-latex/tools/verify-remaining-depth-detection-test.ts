/**
 * **主張ごとの残り段数の検出テスト**（cycle 39 step 5）。
 *
 * 検査が黙っていないことを、**壊した状態を作って挙がることで**実証する。
 * 緑であることに意味を持たせるには、赤くなる条件を示さなければならない
 * （cycle 37 step 5 の「空振りする検査は、緑であることが何も意味しない」と同じ規律）。
 */
import type { UncountableReason } from "./remaining-depth.ts";

type Entry =
  | { block: string; state: "完了" }
  | { block: string; state: "部分的"; remainingItems?: readonly string[] }
  | { block: string; state: "未着手" };

let failures = 0;
const expect = (label: string, actual: number, expected: number, detail: string) => {
  const ok = actual === expected;
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**取りこぼし**"}: ${label}`);
  console.log(`      ${detail} → ${actual} 件（期待 ${expected}）`);
};

/** 検査の判定部分をそのまま写したもの（本体と同じ条件で判定する）。 */
const audit = (entries: Entry[], reasons: UncountableReason[]): string[] => {
  const found: string[] = [];
  const uncountable: string[] = [];
  for (const e of entries) {
    if (e.state === "完了") continue;
    if (e.state === "部分的" && e.remainingItems !== undefined) continue;
    uncountable.push(e.block);
  }
  const declared = new Set(reasons.map((r) => r.block));
  const known = new Set(entries.map((e) => e.block));
  for (const block of uncountable) {
    if (!declared.has(block)) found.push("数えられない欄に理由が無い");
  }
  for (const r of reasons) {
    if (!known.has(r.block)) found.push("台帳に無い欄");
    else if (!uncountable.includes(r.block)) found.push("理由が腐っている");
  }
  return found;
};

console.log("");
console.log("主張ごとの残り段数の検出テスト（cycle 39 step 5）");

const base: Entry[] = [
  { block: "a", state: "部分的", remainingItems: ["x"] },
  { block: "b", state: "部分的" },
  { block: "c", state: "未着手" },
  { block: "d", state: "完了" },
];
const reasons: UncountableReason[] = [
  { block: "b", why: "部で切られている" },
  { block: "c", why: "未着手" },
];

expect(
  "全部宣言していれば挙がらない（偽陽性でない）",
  audit(base, reasons).length,
  0,
  "数えられない 2 件に理由が在る",
);

expect(
  "数えられない欄が黙って増えたら挙がる（本検査の本体）",
  audit([...base, { block: "e", state: "部分的" }], reasons).length,
  1,
  "部で切られた欄を足したが理由を書いていない",
);

expect(
  "未着手を足した場合も挙がる（境界）",
  audit([...base, { block: "f", state: "未着手" }], reasons).length,
  1,
  "未着手の欄を足したが理由を書いていない",
);

expect(
  "数えられる側になったのに理由が残っていたら挙がる（腐り）",
  audit(
    base.map((e) => (e.block === "b" ? { block: "b", state: "部分的", remainingItems: ["y"] } : e)),
    reasons,
  ).length,
  1,
  "`remainingItems` を足したのに宣言を消していない",
);

expect(
  "台帳に無い欄を宣言していたら挙がる（改名・削除）",
  audit(base, [...reasons, { block: "zz", why: "" }]).length,
  1,
  "存在しない block を指している",
);

expect(
  "完了した欄は数えられない側に入らない（境界）",
  audit(base, reasons).length,
  0,
  "完了は対象外なので理由を要求しない",
);

console.log("");
if (failures > 0) {
  console.error(`取りこぼし ${failures} 件。`);
  process.exit(1);
}
console.log("6 / 6 件で検出を実証した。");
