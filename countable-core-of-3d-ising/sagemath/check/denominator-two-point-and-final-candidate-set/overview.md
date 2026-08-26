# SageMath Check: 分母 2 の有理点と候補集合の確定

## 対象

**対象ラベル**: `claim_denominator_two_point_and_final_candidate_set`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 分配多項式へ $a/2$ を代入して分母を払う段、定数項の分離と分子のくくり出し、
  両辺から 1 を引いて 2 倍する等式、奇数の分子が 2 の冪を割ることからの結論、候補集合の確定

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_scaled_constant_term_split.sage` | $a/2$ の代入に $2^E$ を掛けた有限和が定数項と $a$ の倍数へ分かれる三つの等式 | PASS | 係数を不定元にした多項式恒等式として成立。くくり出した和の各項の 2 の冪指数が非負であることも確認 |
| `check_scaled_difference_identity.sage` | 両辺から $2^E$ を引いて 2 倍する等式 | PASS | $c^n$ を仮定から消去した形の多項式恒等式として成立 |
| `check_odd_divisor_and_candidate_set.sage` | 奇数の分子が $2^{E+1}$ を割ることから $a=1$ が従う段と、候補が三つに限られること | PASS | 33 件が仮定を満たしそのすべてで $a=1$、2079 件は仮定で除かれる。候補集合は $\{1/2,1,2\}$ |

## 備考

- `ZZ` と `QQ` の厳密計算だけを使う。$a/2$ の代入を扱うため第一・第二の検査は `QQ` 上で行う。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 定数項が 2 であることは `claim_zero_breakage_multiplicity_is_two` から取り、ここでは仮定して使う。
- 実行日: 2026-08-26。三検査とも `RESULT: PASS`。

## 実行方法

```sh
for f in sagemath/check/denominator-two-point-and-final-candidate-set/check_*.sage; do sage "$f"; done
```
