# 二段 Ising 係数比と付値差の対数順序群値の一致の検算

**対象ラベル**: `theorem_quotient_tower_two_stage_ising_coefficient_ratio_logarithmic_value_compatibility`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_two_stage_ising_coefficient_ratio_logarithmic_value_compatibility`）
- 範囲: 共同正係数次数における細段係数と粗段係数の比の素指数、および二段付値差の有限台集約の一致
- 併せて検証: `def_quotient_tower_positive_rational_logarithmic_value_map`、`def_quotient_tower_two_stage_ising_coefficient_valuation_difference_logarithmic_value`

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_prime_exponent_cancellation.sage` | 既約化で共通因子の付値が相殺し、係数比の素指数が細段付値から粗段付値を引いた差になる | PASS | 全共同正係数次数・全候補素数で一致 |
| `check_support_equality.sage` | 係数比の非零素指数の台と付値差の非零台が一致する | PASS | 次数 `0,2` の両方で一致 |
| `check_logarithmic_coordinate_sum_equality.sage` | 両方の有限台整数座標和が一致する | PASS | 次数 `0` は空座標、次数 `2` は `((2,1),(3,1))` |
| `check_final_logarithmic_value_identity.sage` | 正有理係数比の対数順序群像が付値差の対数順序群値に一致する | PASS | 全共同正係数次数で一致 |

## 備考

- 四頂点サイクルを細段、二頂点二重辺グラフを粗段とする既存有限例の共同正係数次数 `0,2` を全て検算する。
- 次数 `0` の係数比は `1` で両辺とも零元、次数 `2` の係数比は `12/2=6` で両辺とも `ell_2 + ell_3` である。
- `ZZ`、`QQ`、有限台整数タプルだけを用いる厳密検算であり、浮動小数点、実対数、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 失敗記録

- 初回実行では `check_prime_exponent_cancellation.sage` が、有限探索で得た Python 整数に `is_prime` を適用して `AttributeError` となった。候補素数を `ZZ` へ明示的に写してから再実行するよう修正した。数学的等式や検算範囲の緩和は行っていない。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-ising-coefficient-ratio-logarithmic-value-compatibility/check_*.sage; do
  sage "$f"
done
```
