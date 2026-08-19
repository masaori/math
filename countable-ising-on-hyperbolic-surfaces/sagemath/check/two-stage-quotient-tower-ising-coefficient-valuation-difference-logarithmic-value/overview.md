# 固定次数における二段 Ising 係数付値差の対数順序群値の検算

**対象ラベル**: `def_quotient_tower_two_stage_ising_coefficient_valuation_difference_logarithmic_value`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_two_stage_ising_coefficient_valuation_difference_logarithmic_value`）
- 範囲: 固定次数の有限台上で二段 Ising 係数付値差を整数係数とする対数順序群値

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_logarithmic_value.sage` | 四頂点サイクルと二頂点二重辺グラフの共同正係数次数ごとに、非零付値差を有限台の整数座標として構成する | PASS | 次数 `0` は空の台、したがって対数順序群の零元。次数 `2` は座標 `((2,1),(3,1))`、したがって `ell_2 + ell_3` |

## 備考

- 対数順序群の元は、素数を添字とする有限台の整数係数写像として表現した。
- 既存の有限台検算が返す素数だけを走査し、完全因数分解は用いない。
- 自然数、整数、有限タプルだけを用いた厳密検算であり、浮動小数点、実対数、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-ising-coefficient-valuation-difference-logarithmic-value/check_logarithmic_value.sage
```
