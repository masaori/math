# SageMath 検算: 有限有理遷移重みと有限 Gibbs 重みの境界

## 対象

**対象ラベル**: `claim_rational_transition_weight_not_always_finite_gibbs`

- 併せて検証するラベル: `def_rational_transition_real_comparison`、
  `def_finite_real_row_partition_sum`、`def_finite_gibbs_transition_weight`、
  `claim_finite_gibbs_transition_weight_strictly_positive`、
  `claim_finite_gibbs_transition_weight_normalized`、
  `def_single_cell_identity_rational_transition_weight`。
- 有理零一遷移重みの標準実数像、有限指数重みと行分配和の正値性、各行の規格化、
  零重みと正の有限 Gibbs 重みの非対応を、本文の定義と証明の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_rational_real_comparison.sage` | 一セル恒等規則の四つの有理遷移重みを標準埋め込みで送り、零・一・順序が保たれること | PASS | 四成分で厳密に成立 |
| `check_exponential_weights_and_partition_sum.sage` | 有限実数値エネルギーの指数重み、行分配和、規格化後の各重みの正値性 | PASS | 75 行・150 指数重みで記号的に成立 |
| `check_row_normalization.sage` | 有限和を分配和で割った各行の和が一になること | PASS | 75 行で記号的に成立 |
| `check_zero_weight_noncorrespondence.sage` | 恒等規則の非対角零重みが有限実数値エネルギーから作る正の Gibbs 重みと一致しないこと | PASS | 75 個の有限入力で記号的に成立 |

## 範囲と限界

- エネルギー行は二配位に対する整数値を -2 から 2、正の逆温度は `1/2, 1, 2` とした
  75 個の有限入力を検査する。これは明示した有限範囲のプログラミングによる検証であり、
  任意の有限実数値エネルギーと正の実数値逆温度に対する一般証明ではない。一般証明は構造化記述にある。
- 有理重みの実数比較は、有理数を実代数的数体 `AA` へ厳密に埋め込み、その標準実数像を比較する。
  指数値は SageMath の記号環で保持し、正値性と有限和の等式を記号的に判定する。
  浮動小数点による近似は使わない。
- 実指数関数と正の実数値による除算は有限舞台でも実数への脱出である。対数、無限舞台、極限、
  完備化、無限 Gibbs 仕様、Gibbs 測度、相転移は定義も検査もしていない。
- 零重みの非対応だけを示す。一つの反例により全ての有理遷移重みが有限 Gibbs 重みになるという主張を
  否定するが、正の有理遷移重みの表現可能性は分類していない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-gibbs-weight-boundary/check_*.sage; do sage "$file"; done
```
