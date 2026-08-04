/**
 * 記号の初出の全数走査の**免除表**。
 *
 * 走査は「`:=` の左辺に立った位置」を定義とみなす。この判定が拾えない形が実際にあるので、
 * **順序として正しいと人が読んで確かめたものだけ**をここへ理由つきで置く。
 * 理由を書けないものは免除しない（免除は本文を直さずに済ませる口実ではない）。
 */

export type SymbolSweepAllowance = { readonly reason: string };

/**
 * 3 件とも「同じ字面が別の量を指している」か「初出の側で存在量化して導入している」であり、
 * 定義の順序の問題ではない。**同じ字面が 2 つの意味で使われていること自体は事実**なので、
 * 走査の report（`outputs/reports/cycle29_ops_definition_order_symbol_sweep.md`）に記録した。
 */
const REASONS = {
  Z_N:
    "分配多項式 Z_N(x) は初出のブロック（Massieu 自由エントロピーの定義）で `=` を使って" +
    "その場で導入されている。走査が定義とみなす `:=` は命題 A の Z_N:=Tr T^N のほうで、" +
    "こちらは転送行列のトレース列という別の量である。順序の問題ではない。",
  T_1:
    "双対の章の T_1,…,T_d は群環の生成元、ℓ=2 族の T_1:=… は付値の項であり、別の量である。",
  r_0:
    "初出（命題 J の (J4)）は「ある r_0≥1 があって」と存在量化して導入している。" +
    "命題 M の r_0:=max(…) はその半径を具体的に選び直したもので、初出がこの定義に依存していない。",
} as const;

export const SYMBOL_SWEEP_ALLOWANCES: Readonly<
  Record<string, Readonly<Record<string, SymbolSweepAllowance>>>
> = {
  ja: {
    "Z_{N}": { reason: REASONS.Z_N },
    "T_{1}": { reason: REASONS.T_1 },
    "r_{0}": { reason: REASONS.r_0 },
  },
  en: {
    "Z_{N}": { reason: REASONS.Z_N },
    "T_{1}": { reason: REASONS.T_1 },
    "r_{0}": { reason: REASONS.r_0 },
  },
};
