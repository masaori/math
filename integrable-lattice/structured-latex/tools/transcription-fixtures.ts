/**
 * **過去に実際に起きた転記事故の再現データ。**
 *
 * 「ツールがエラーを出さなかった」ことは、検査が効いていることの根拠にならない。
 * そこで、事故が起きていた頃の本文を**現在の本文へ適用する差分**として持ち、
 * 検査がそれを挙げることを `verify-transcription-detection-test.ts` が確かめる。
 *
 * **本文ファイル（`content/`）は書き換えない。** 読み込んだ後のメモリ上の値へ差分を当てるだけである
 * （本文は別 step の担当であり、触ってはならない）。
 *
 * 差分の文言は git の履歴から取った（事故時点のコミットと、それを直したコミット）:
 *   - cycle 18: 2d414ed が直した 命題 N の例外集合。直前の版が `find` 側である。
 *   - cycle 20: ac98013 が足した 命題 J (J1) の $A_1\equiv0$。足す前が `find` 側である。
 *   - cycle 21: 5c59660 が直した 命題 R (R1) の係数の添字。直す前が `find` 側である。
 */

export type FixtureOp =
  | { op: "replaceProse"; find: string; replace: string }
  | { op: "dropProse"; find: string }
  | { op: "replaceFormula"; find: string; replace: string }
  | { op: "dropFormula"; find: string };

export type Fixture = {
  name: string;
  /** 事故が起きたサイクルと、そのときの一次情報。 */
  provenance: string;
  block: string;
  ops: readonly FixtureOp[];
  /** どの検査が、何を挙げれば「検出できた」と言えるか。 */
  expect: { check: "A" | "B"; contains: string };
};

export const FIXTURES: readonly Fixture[] = [
  {
    name: "cycle18: 命題 N の例外集合が「有限個の N」になっていた",
    provenance:
      "コミット 2d414ed が直した。根拠 report は outputs/reports/cycle3_T1_D-U2_rigorous.md で、" +
      "そこには「Skolem–Mahler–Lech 例外（算術級数の有限和）」と正しく書いてある。" +
      "算術級数の有限和は一般に無限集合なので、「有限個の N」は誤りである。",
    block: "paper_044_theorem_newton",
    ops: [
      {
        op: "replaceProse",
        find: "**ただし Skolem–Mahler–Lech 型の相殺により例外が生じる。**",
        replace: "**ただし Skolem–Mahler–Lech 型の相殺により、有限個の ",
      },
      { op: "dropProse", find: "例外集合は算術級数の有限和であり" },
      { op: "dropProse", find: "を取り違えたものである）。" },
      { op: "dropProse", find: "（cycle 18 の Lean 形式化で発見した本文の誤り" },
    ],
    expect: { check: "A", contains: "算術級数" },
  },
  {
    name: "cycle20: 桁定理（命題 J (J1)）が使う $A_1\\equiv0$ が本文に無かった",
    provenance:
      "コミット ac98013 が足した。根拠 report は outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md の " +
      "定理 J2 の証明で、最後の等号が cycle 18 補題 A2 (1)（$A_1\\equiv0$）から従うと書いてある。" +
      "この仮定を落とすと $m=\\ell^L$ ちょうどの段は偽になる（本文に反例が入っている）。",
    block: "paper_091_theorem_theta_padic",
    ops: [{ op: "dropFormula", find: "A_1\\equiv0" }],
    expect: { check: "A", contains: "A_{1}" },
  },
  {
    name: "cycle21: 命題 R (R1) の係数が添字なしの $\\mu$ になっていた",
    provenance:
      "コミット 5c59660 が直した。根拠 report は outputs/reports/cycle20_T3_cancellation_recursion.md で、" +
      "係数は指数 $\\gamma$ ごとに決まる族である（$\\mu_\\gamma$）。" +
      "桁 $c$ の枝では $\\gamma$ 番目の係数が $\\mu_{c+\\ell\\gamma}$ になる。",
    block: "paper_101_theorem_digit_branch",
    ops: [{ op: "replaceFormula", find: "\\mu_{c+\\ell\\gamma}", replace: "\\mu" }],
    expect: { check: "B", contains: "\\mu" },
  },
];

/** 差分を当てる。1 つでも当たらなければ例外（再現データが腐ったまま緑になるのを防ぐ）。 */
export function applyFixture(
  view: { proseParts: string[]; prose: string; formulas: string[] },
  fixture: Fixture,
): { proseParts: string[]; prose: string; formulas: string[] } {
  let proseParts = [...view.proseParts];
  let formulas = [...view.formulas];
  for (const op of fixture.ops) {
    let hits = 0;
    if (op.op === "replaceProse") {
      proseParts = proseParts.map((part) => {
        if (!part.includes(op.find)) return part;
        hits += 1;
        return part.replaceAll(op.find, op.replace);
      });
    } else if (op.op === "dropProse") {
      const kept = proseParts.filter((part) => !part.includes(op.find));
      hits = proseParts.length - kept.length;
      proseParts = kept;
    } else if (op.op === "replaceFormula") {
      formulas = formulas.map((tex) => {
        if (!tex.includes(op.find)) return tex;
        hits += 1;
        return tex.replaceAll(op.find, op.replace);
      });
    } else {
      const kept = formulas.filter((tex) => !tex.includes(op.find));
      hits = formulas.length - kept.length;
      formulas = kept;
    }
    if (hits === 0) {
      throw new Error(
        `再現データが現在の本文に当たらない: ${fixture.name} / ${op.op} "${op.find}"。` +
          "本文が書き換わったなら再現データも更新すること（当たらないまま緑にしない）。",
      );
    }
  }
  return { proseParts, prose: proseParts.join(" "), formulas };
}
