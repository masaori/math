# SageMath Check: 整数の有理点で分子を定数項へ帰着する

## 対象

**対象ラベル**: `claim_integer_point_numerator_divides_twice_zero_multiplicity_minus_one`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 分配多項式の定数項分離、有限和からの共通因子のくくり出し、整除の差による保存

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_constant_term_split.sage` | 分配多項式を定数項と `a` の倍数へ分ける三つの等式 | PASS | 係数を不定元にした `ZZ` 上の多項式恒等式として成立 |
| `check_scaled_difference_identity.sage` | 定数項分離後に 1 を引いて 2 倍する等式 | PASS | `ZZ` 上の多項式恒等式として成立 |
| `check_divisibility_subtraction.sage` | 全体と `a` の倍数の整除から定数項側の整除を得る段 | PASS | `ZZ` 上の有限標本で成立 |

## 備考

- `ZZ` の厳密計算だけを使う。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 実行日: 2026-08-26。三検査とも `RESULT: PASS`。

## 実行方法

```sh
for f in sagemath/check/integer-point-numerator-divides-twice-zero-multiplicity-minus-one/check_*.sage; do sage "$f"; done
```
