/**
 * **閉じる前提の処分の台帳**（cycle 49 step 1 で新設）。
 *
 * `lean/` が未形式化として名指している事柄のうち、その欄の残り項目にそのまま当たらないものを、
 * 1 件ずつどう扱うかを宣言する。種別と検査の内容は `closing-precondition-model.ts` を正本とする。
 *
 * **ここに書かれた処分のうち、機械が確かめるのは宣言先の実在だけである。**
 * `対象外（道具の一般性）` は人の読みなので確かめられない。**だから件数を毎回印字する。**
 */

import type { ClosingDisposition } from "./closing-precondition-model.ts";

export const CLOSING_PRECONDITION_DISPOSITIONS: readonly ClosingDisposition[] = [
  {
    block: "paper_043b_theorem_trace_bound",
    file: "TracePeriodAssembly.lean",
    phrase: "しきい値 $w^*+1$ の最良性（反例の族）",
    kind: "対象外（別の欄で数えている）",
    target: "paper_045_theorem_trace_ladder",
    why:
      "しきい値の最良性は 命題 C″ の (1) の内容であって、命題 C′ の上界の主張ではない。" +
      "このファイルは 2 つの欄の宣言を持つので、両方の欄に同じ名指しが出る。",
  },
  {
    block: "paper_045_theorem_trace_ladder",
    file: "TracePeriodAssembly.lean",
    phrase: "しきい値 $w^*+1$ の最良性（反例の族）",
    kind: "数に当たる（別の言い方の残り項目）",
    target: "全ての $k$ で破れる形",
    why:
      "最良性そのものは cycle 40 step 3 が書いた（`TracePeriodThresholdSharp.ladder_fails_at_two`）。" +
      "残っているのは、全ての $k$ で破れる形 と 一般の $T$ についての配線 の 2 つで、" +
      "欄はその 2 つを数えている。**この箇条書きは cycle 40 の時点で古くなっていたので、本 step で直した。**",
  },
  {
    block: "paper_045_theorem_trace_ladder",
    file: "TracePeriodStructure.lean",
    phrase: "しきい値 $w^*+1$ の最良性（反例の族）",
    kind: "数に当たる（別の言い方の残り項目）",
    target: "全ての $k$ で破れる形",
    why:
      "同上。cycle 40 step 3 が書いた後も、2 つのファイルが同じ事柄を未形式化として挙げ続けていた" +
      "（cycle 48 step 1 が 命題 C′ で見つけたのと同じ腐りである）。本 step で直した。",
  },
  {
    block: "paper_051_theorem_duality",
    file: "DualityPAdicFiniteL.lean",
    phrase: "簡約周期点数の $d\\ge2$ の場合",
    kind: "数に当たる（部で数えている）",
    target: "p 素点, 有限 L",
    why:
      "本文の (p 素点, 有限 L) の部そのものが $d$ 変数の主張であり、形式化してあるのは $d=1$ に限る。" +
      "部が 残り なので段数に入っている。",
  },
  {
    block: "paper_056_theorem_ell2_family",
    file: "EllTwoClosedForm.lean",
    phrase: "4 通りの閉形式の導出",
    kind: "数に当たる（部で数えている）",
    target: "G″2",
    why:
      "本文の 4 通りの閉形式は部 (G″2)–(G″5) であり、4 つとも 残り として数えている。",
  },
  {
    block: "paper_062_theorem_T",
    file: "CharacterDecomposition.lean",
    phrase: "一般の有限アーベル群による指標分解",
    // cycle 50 step 4: 本文の走査で確かめられる側へ移した（機械が確かめない処分を 1 件減らす）。
    kind: "対象外（本文が要求していない）",
    target: "paper_def_graph_tower",
    textPresent: "\\mathbb{Z}/N\\times\\mathbb{Z}/N'",
    textAbsent: "有限アーベル群",
    why:
      "本文は voltage 群を巡回群 2 つの積として定義しており（塔は $\\mathbb{Z}_\\ell^2$）、" +
      "一般の有限アーベル群を 1 度も要求していない。**この 2 つは本文を走査すれば決まるので、" +
      "cycle 50 step 4 で機械に確かめさせる側へ移した。**",
  },
  {
    block: "paper_062_theorem_T",
    file: "CharacterDecomposition.lean",
    phrase: "voltage グラフの基礎グラフの型",
    kind: "対象外（道具の一般性）",
    why:
      "導来グラフの側を voltage ごとの辺の本数として受け取る書き方は、本文の主張が要求する形を満たす。" +
      "基礎グラフを型として持つかは道具の作りの話である。**この判断は人の読みであり、機械は確かめていない。**",
  },
  {
    block: "paper_062_theorem_T",
    file: "CharacterDecompositionTwoVariable.lean",
    phrase: "一般の有限アーベル群による指標分解",
    kind: "対象外（本文が要求していない）",
    target: "paper_def_graph_tower",
    textPresent: "\\mathbb{Z}/N\\times\\mathbb{Z}/N'",
    textAbsent: "有限アーベル群",
    why: "同上（同じ事柄を 2 つのファイルが挙げている）。**本文の走査で機械が確かめる。**",
  },
  {
    block: "paper_062_theorem_T",
    file: "CharacterDecompositionTwoVariable.lean",
    phrase: "voltage グラフの基礎グラフの型",
    kind: "対象外（道具の一般性）",
    why: "同上（同じ事柄を 2 つのファイルが挙げている）。**機械は確かめていない。**",
  },
  {
    block: "paper_062_theorem_T",
    file: "PropTHenselLift.lean",
    phrase: "2 の上での完備化が、この舞台の形",
    kind: "数に当たる（別の言い方の残り項目）",
    target:
      "付値の位相が $\\mathfrak m$ 進位相であること（完備化の整数環が Hensel 的な舞台であることへ渡る 1 本）",
    why:
      "**cycle 49 step 3 で開けると、step 1 の見立てが 1 件だけ二重計上だった。そう書く**——" +
      "剰余体の側そのものは cycle 44 step 2 で入っており、この箇条書きに残っていたのは舞台の同定だけである。" +
      "舞台の同定は 付値の位相の項目と同じものなので、そちらで数える。",
  },
  {
    block: "paper_062_theorem_T",
    file: "PropTResidueRoot.lean",
    phrase: "2 の上での完備化が、この舞台の形",
    kind: "数に当たる（別の言い方の残り項目）",
    target:
      "付値の位相が $\\mathfrak m$ 進位相であること（完備化の整数環が Hensel 的な舞台であることへ渡る 1 本）",
    why:
      "cycle 48 step 2 の実測で、この段に残っているのは付値の位相が $\\mathfrak m$ 進位相であることの 1 本だけだと分かっている。" +
      "同じ段を別の言い方で挙げている。",
  },
  {
    // cycle 50 step 2 で新設。$\kappa_n$ の独立計算の芯を書いた file が、残りを 2 つ挙げている。
    block: "paper_055_theorem_theta_infinity",
    file: "KappaProductFormula.lean",
    phrase: "本ファイルの結論を 2 回当てる",
    kind: "数に当たる（別の言い方の残り項目）",
    target: "$\\kappa_n$ の独立計算（指標分解と matrix-tree を塔へ当てて全域木数を出す段）",
    why:
      "$\\mathbb{Z}_\\ell^2$ の 2 変数の塔への当てはめは、$\\kappa_n$ の独立計算 の内側である" +
      "（1 変数の結論を 2 回当てる形になる）。欄はその段を 1 件として数えている。",
  },
  {
    block: "paper_056_theorem_ell2_family",
    file: "KappaProductFormula.lean",
    phrase: "本ファイルの結論を 2 回当てる",
    kind: "数に当たる（別の言い方の残り項目）",
    target: "塔の値 $\\kappa_n$ の独立計算（指標分解と matrix-tree を塔へ当てて全域木数を出す段）",
    why: "同上（同じ段を 3 つの欄が共有している）。",
  },
  {
    block: "paper_063_theorem_W",
    file: "KappaProductFormula.lean",
    phrase: "$\\kappa_n$ の独立計算",
    kind: "数に当たる（別の言い方の残り項目）",
    target: "積公式の段（全域木数と行列式を繋ぐ余因子の側が要る）",
    why:
      "命題 W の欄はこの段を 積公式の段 という名前で数えている" +
      "（cycle 48 step 4 の測定で、その中身が全域木数と行列式を繋ぐ余因子の側だと分かっている）。",
  },
  {
    block: "paper_063_theorem_W",
    file: "KappaProductFormula.lean",
    phrase: "本ファイルの結論を 2 回当てる",
    kind: "数に当たる（別の言い方の残り項目）",
    target: "積公式の段（全域木数と行列式を繋ぐ余因子の側が要る）",
    why: "同上（2 変数の塔への当てはめも 積公式の段 の内側である）。",
  },
  {
    block: "paper_101_theorem_s_infinity_decision",
    file: "PropKW2Converse.lean",
    phrase: "$j^*$（重複度）",
    kind: "数に当たる（部で数えている）",
    target: "K4",
    why: "重複度の主張は本文の部 (K4) そのものであり、部が 残り なので段数に入っている。",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    file: "Cycle25Corrections.lean",
    phrase: "voltage グラフのラプラシアン行列式",
    kind: "対象外（別の欄で数えている）",
    target: "paper_112_theorem_coefficient_layers",
    why:
      "このファイルの箇条書きが指しているのは本文 (U4)(U5) の $\\tilde E$ であり、" +
      "命題 U の部として数えている（どちらの部も 残り）。命題 M の残りではない。",
  },
  {
    block: "paper_112_theorem_coefficient_layers",
    file: "TruncatedValuationStability.lean",
    phrase: "$\\Phi^{[k]}$ が $\\mathcal{O}_k$ 係数の線形式であることの配線",
    kind: "数に当たる（部で数えている）",
    target: "U6",
    why:
      "本文の (U6) の逆向きが 2 つに割れたうちの片方であり（cycle 42 step 4 の測定）、" +
      "部 (U6) が 残り なので段数に入っている。",
  },
];
