# 固定次数における二段 Ising 係数付値差の有限台の検算

**対象ラベル**: `theorem_quotient_tower_two_stage_ising_coefficient_valuation_difference_finite_support`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_two_stage_ising_coefficient_valuation_difference_finite_support`）
- 範囲: 固定した共同正係数次数で、付値差が非零となる素数が二係数の積の素因数に含まれること

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_finite_support.sage` | 四頂点サイクルと二頂点二重辺グラフの共同正係数次数ごとに、二係数の積の素因数を有限探索し、非零付値差の台がその部分集合であることを照合する | PASS | 次数 `0` の台は空、次数 `2` の台は `{2,3}`。いずれも二係数の積の素因数集合に含まれた |

## 備考

- 素数は固定次数の二係数の積以下だけを有限探索し、完全因数分解は用いない。
- 自然数と整数だけを用いた厳密検算であり、浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-ising-coefficient-valuation-difference-finite-support/check_finite_support.sage
```
