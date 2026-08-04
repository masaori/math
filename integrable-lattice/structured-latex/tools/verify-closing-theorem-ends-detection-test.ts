/**
 * **両端の棚卸しの検出テスト**（cycle 39 step 4）。
 *
 * 検査が黙っていないことを、**壊した状態を作って挙がることで**実証する。
 * 緑であることに意味を持たせるには、赤くなる条件を示さなければならない
 * （cycle 37 step 5 の「空振りする検査は、緑であることが何も意味しない」と同じ規律）。
 *
 * 再現データは**現に起きた外れ方**から取る——cycle 38 step 1 が
 * 「残り 1 件を書いた」と記録した定理は含意であり、その両端（無平方性と $\mu$）が
 * 数から落ちていた。**その落ち方をそのまま作って、挙がることを見る。**
 */
import { readBinders } from "./closing-theorem-ends.ts";

let failures = 0;
const expect = (label: string, actual: number, expected: number, detail: string) => {
  const ok = actual === expected;
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**取りこぼし**"}: ${label}`);
  console.log(`      ${detail} → ${actual} 件（期待 ${expected}）`);
};

/** 検査の判定部分をそのまま写したもの（本体と同じ条件で判定する）。 */
const audit = (source: string, theoremName: string, declared: string[]): string[] => {
  const found: string[] = [];
  const actual = readBinders(source, theoremName);
  if (actual === null) return ["定理が実在しない"];
  if (actual.some((n) => !declared.includes(n))) found.push("束縛子を数え落としている");
  if (declared.some((n) => !actual.includes(n))) found.push("署名に無い束縛子を挙げている");
  return found;
};

/** cycle 38 step 1 の当の形（含意。両端が仮定として出ている）。 */
const source = `
theorem det_weightedGram_ne_zero_of_squarefree (K : Type*) [Field K] [Algebra R K]
    [IsFractionRing R K] [CharZero K] {m : ℕ} {ρ : R[X]}
    (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) (hsq : Squarefree ρ)
    {μ : AdjoinRoot ρ} (hμ : μ ∈ nonZeroDivisors (AdjoinRoot ρ)) :
    (weightedGram (AdjoinRoot.root ρ) μ).det ≠ 0 := by
  sorry
`;

console.log("");
console.log("両端の棚卸しの検出テスト（cycle 39 step 4）");

const full = ["K", "m", "ρ", "hmonic", "hdeg", "hsq", "μ", "hμ"];

expect(
  "全数を挙げていれば挙がらない（偽陽性でない）",
  audit(source, "det_weightedGram_ne_zero_of_squarefree", full).length,
  0,
  "署名どおりに 8 件挙げた",
);

expect(
  "現に起きた落ち方: 含意の両端（無平方性と μ）を数えていない",
  audit(
    source,
    "det_weightedGram_ne_zero_of_squarefree",
    full.filter((n) => n !== "hsq" && n !== "hμ"),
  ).length,
  1,
  "cycle 38 step 1 が「残り 1 件を書いた」と記録した当の形",
);

expect(
  "端を 1 つだけ落とした場合も挙がる（境界）",
  audit(
    source,
    "det_weightedGram_ne_zero_of_squarefree",
    full.filter((n) => n !== "hμ"),
  ).length,
  1,
  "μ の側だけ数えていない",
);

expect(
  "改名で腐った場合も挙がる（逆向き）",
  audit(source, "det_weightedGram_ne_zero_of_squarefree", [...full, "hOld"]).length,
  1,
  "署名から消えた束縛子を台帳が持ったまま",
);

expect(
  "インスタンス束縛子は数えない（境界）",
  audit(source, "det_weightedGram_ne_zero_of_squarefree", full).length,
  0,
  "[Field K] などを挙げなくても挙がらない",
);

expect(
  "実在しない定理は挙がる",
  audit(source, "no_such_theorem", []).length,
  1,
  "名前が署名に無い",
);

console.log("");
if (failures > 0) {
  console.error(`取りこぼし ${failures} 件。`);
  process.exit(1);
}
console.log("6 / 6 件で検出を実証した。");
