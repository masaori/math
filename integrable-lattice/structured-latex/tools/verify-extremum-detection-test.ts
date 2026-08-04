#!/usr/bin/env node
/**
 * **検査 M（空集合になりうる最小・最大の規約）が実際に検出できることの実証。**
 *
 * 「本番で違反 0 件だった」は検査が効いていることの根拠にならない（cycle 22 の教訓）。
 * この検査は**実際に 4 回起きた事故**を対象にしているので、
 * **実際に落ちていた形そのもの**を再現データとして持ち、それが挙がることを確かめる。
 *
 * **ファイルは 1 バイトも書き換えない。** 台帳と本文はメモリ上で差し替える。
 *
 * 見るのは 2 つの層である。
 *   1. **分類**（`classifyTex`）— 判断が要る形と、要らない形を取り違えないこと。
 *      取り違えれば、判断が要る出現が黙って素通りする。
 *   2. **台帳の照合** — 未登録・個数違い・目印の消失・宣言の余りが挙がること。
 */

import { classifyTex, type ExtremumAllowance, keyOf, needsJudgement } from "./extremum-model.ts";
import { EXTREMUM_ALLOWANCES } from "./extremum-allowances.ts";

let failures = 0;
let checks = 0;
const report = (name: string, ok: boolean, detail: string): void => {
  checks += 1;
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**失敗**"}: ${name}`);
  console.log(`      ${detail}`);
};

// =============================================================================
// 分類 — 判断が要る形／要らない形
// =============================================================================
console.log("");
console.log("検査 M（空集合になりうる最小・最大）の検出テスト");
console.log("  再現データ: 本文で実際に 4 回落ちていた形そのもの。");

/** 実際に規約が落ちていた 4 件（直す前の本文の書き方）。 */
const REAL_ACCIDENTS: { name: string; tex: string; form: string }[] = [
  {
    name: "命題 G′ の m_1（cycle 26 step 6 が Lean で検出。min∅=0 と読むと ℓ=3 だけが落ちた）",
    tex: String.raw`m_1:=\min\{m<\theta^*:B_m\neq0\}`,
    form: "set-builder",
  },
  {
    name: "命題 G の (G1′) の δ（原本の「δ:=+∞」が本文へ運ばれていなかった）",
    tex: String.raw`\delta:=\min_{d<k}\bigl(\varepsilon_d(\ell-1)+d\bigr)-k`,
    form: "indexed",
  },
  {
    name: "命題 G の (G6) の θ（min∅=0 と読むと仮定が偽から真へ反転した）",
    tex: String.raw`\theta(P):=\min\{m:\ell\nmid A_m(a_0,b_0)\}`,
    form: "set-builder",
  },
  {
    name: "命題 K の r_0（S_∞ = ∅ すなわち型 II で空集合上の max になっていた）",
    tex: String.raw`r_0:=\max\Bigl(1+\max_{P\neq P'}v_\ell\bigl(\det(u,u')\bigr),\ \max_{P}\lambda_u\Bigr)`,
    form: "indexed",
  },
];

for (const accident of REAL_ACCIDENTS) {
  const found = classifyTex(accident.tex).filter((occurrence) => needsJudgement(occurrence.form));
  report(
    accident.name,
    found.length >= 1 && found.some((occurrence) => occurrence.form === accident.form),
    `判断が要る出現 ${found.length} 件（形: ${found.map((o) => o.form).join(", ") || "なし"}）`,
  );
}

/** 判断が要らない形。ここで偽陽性を出すと台帳が意味の無い登録で膨らむ。 */
const NOT_APPLICATIONS: { name: string; tex: string }[] = [
  { name: "記号の名前の一部（上付き）", tex: String.raw`\theta_G^{\max}\ge\varphi(\ell^{M})` },
  { name: "記号の名前の一部（下付き）", tex: String.raw`\rho_{\max}:=M` },
  { name: "記号の名前の一部（前置きの下付き）", tex: String.raw`\mu_{\min}(p)` },
  { name: "2 引数の最小（空にならない）", tex: String.raw`\min\bigl(2,\,v_2(p-1)\bigr)` },
  { name: "規約そのものを書いている行", tex: String.raw`\min\emptyset=0` },
  { name: "地の文で演算子に言及しているだけ", tex: String.raw`\min` },
];

for (const benign of NOT_APPLICATIONS) {
  const found = classifyTex(benign.tex).filter((occurrence) => needsJudgement(occurrence.form));
  report(
    `偽陽性でない: ${benign.name}`,
    found.length === 0,
    `"${benign.tex}" → 判断が要る出現 ${found.length} 件（期待 0）`,
  );
}

report(
  "同じ数式の中の 2 つ目以降の出現も拾う（\\max が入れ子になっている行）",
  classifyTex(REAL_ACCIDENTS[3]!.tex).filter((o) => needsJudgement(o.form)).length === 2,
  `入れ子の max → ${classifyTex(REAL_ACCIDENTS[3]!.tex).filter((o) => needsJudgement(o.form)).length} 件（期待 2）`,
);

// =============================================================================
// 台帳の照合 — 4 つの壊し方
// =============================================================================
console.log("");
console.log("  台帳の照合（本番と同じ突き合わせを、壊した台帳に対して回す）");

const sample = EXTREMUM_ALLOWANCES[0];
if (sample === undefined) throw new Error("台帳が空になっている（この検査自体が意味を失う）");

/** 本番の照合と同じ判定。壊した入力に対して違反が出ることだけを見る。 */
const mismatches = (
  ledger: readonly ExtremumAllowance[],
  observed: ReadonlyMap<string, number>,
  bodyOf: (block: string) => string,
): string[] => {
  const problems: string[] = [];
  const declared = new Map(ledger.map((entry) => [keyOf(entry), entry] as const));
  for (const [key, count] of observed) {
    const entry = declared.get(key);
    if (entry === undefined) problems.push(`未登録: ${key}`);
    else if (entry.count !== count) problems.push(`個数違い: ${key}`);
  }
  for (const [key, entry] of declared) {
    if (!observed.has(key)) {
      problems.push(`宣言の余り: ${key}`);
      continue;
    }
    if (entry.ground.type === "nonempty-by-construction") continue;
    if (!bodyOf(entry.block).includes(entry.ground.marker)) problems.push(`目印の消失: ${key}`);
  }
  return problems;
};

const withMarker = (allowance: ExtremumAllowance): string =>
  allowance.ground.type === "nonempty-by-construction" ? "" : allowance.ground.marker;

const conventionEntry = EXTREMUM_ALLOWANCES.find(
  (entry) => entry.ground.type === "empty-convention-stated",
);
if (conventionEntry === undefined) {
  throw new Error("規約を書いた登録が 1 件も無い（再現データが作れない）");
}

const observedOf = (entries: readonly ExtremumAllowance[]): Map<string, number> =>
  new Map(entries.map((entry) => [keyOf(entry), entry.count] as const));

report(
  "新しく書いた最小・最大が台帳に無い（登録するまで赤くなる）",
  mismatches(
    EXTREMUM_ALLOWANCES.filter((entry) => entry !== sample),
    observedOf(EXTREMUM_ALLOWANCES),
    () => "",
  ).some((problem) => problem.startsWith("未登録")),
  "台帳から 1 件外して実測はそのままにすると「未登録」で挙がる",
);

report(
  "同じ形の出現が増えたのに登録の個数が据え置き",
  mismatches(
    EXTREMUM_ALLOWANCES,
    new Map([...observedOf(EXTREMUM_ALLOWANCES)].map(([key, n]) => [key, n + 1])),
    (block) => EXTREMUM_ALLOWANCES.filter((entry) => entry.block === block).map(withMarker).join(" "),
  ).some((problem) => problem.startsWith("個数違い")),
  "実測を 1 件増やすと「個数違い」で挙がる",
);

report(
  "本文から出現が消えたのに宣言が残っている",
  mismatches(
    EXTREMUM_ALLOWANCES,
    observedOf(EXTREMUM_ALLOWANCES.filter((entry) => entry !== sample)),
    (block) => EXTREMUM_ALLOWANCES.filter((entry) => entry.block === block).map(withMarker).join(" "),
  ).some((problem) => problem.startsWith("宣言の余り")),
  "実測から 1 件外すと「宣言の余り」で挙がる（直したのに宣言が残る状態を作れない）",
);

report(
  "根拠の目印（規約の一文）が本文から消えた",
  mismatches(EXTREMUM_ALLOWANCES, observedOf(EXTREMUM_ALLOWANCES), () => "").some((problem) =>
    problem.startsWith("目印の消失"),
  ),
  `本文を空にすると「目印の消失」で挙がる（例: 「${conventionEntry.ground.type === "nonempty-by-construction" ? "" : conventionEntry.ground.marker}」）`,
);

report(
  "目印がそろっていれば静か（偽陽性でない）",
  mismatches(EXTREMUM_ALLOWANCES, observedOf(EXTREMUM_ALLOWANCES), (block) =>
    EXTREMUM_ALLOWANCES.filter((entry) => entry.block === block).map(withMarker).join(" "),
  ).length === 0,
  "台帳と実測が一致し目印もそろっていれば違反 0 件",
);

console.log("");
if (failures > 0) {
  console.log(`**${failures} / ${checks} 件で検出できなかった。**`);
  process.exit(1);
}
console.log(`${checks} / ${checks} 件で検出を実証した。`);
