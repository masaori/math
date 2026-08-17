# 固定剰余類格子の Ising 分配多項式係数

**対象ラベル**: `theorem_fixed_quotient_ising_partition_polynomial`

## 対象

- ファイル: `structured-latex/content/finite-quotient-lattice.ts`（ブロック `finite_quotient_lattice_theorem_fixed_quotient_ising_partition_polynomial`）
- 範囲: 出典を固定した `24` 頂点、`84` 辺の剰余類格子について、全スピン配位を破れ辺数ごとに数えた Ising 分配多項式
- 併せて検証: `theorem_generated_quotient_cellulation_is_hyperbolic_regular` が生成・検査した有限グラフ入力

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coefficients.sage` | 入力の三置換から剰余類格子を再生成し、二十四ビット Gray 符号で全 `2^24` 配位を重複なく走査して、破れ辺数別係数と `ZZ[x]` の多項式を照合する | PASS | 係数総和は `2^24=16777216`、最高次数は `56` であり、本文の全係数と一致した |

## 備考

- 有限置換、有限集合、自然数、整数係数多項式だけを用いた厳密計算である。浮動小数点、実数、複素数、極限、積分を用いていない。
- Gray 符号の隣り合う配位で反転する一頂点に接する七辺だけを更新するが、列挙範囲は二十四ビット列全体であり、近似や標本抽出ではない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-ising-partition-polynomial/check_coefficients.sage
```
