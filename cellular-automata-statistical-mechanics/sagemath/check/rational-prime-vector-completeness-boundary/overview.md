# SageMath 検算: 有限台有理素数ベクトルの完備性の境界

## 対象

**対象ラベル**: `claim_rational_prime_vector_geometric_truncations_no_limit`

- 併せて検証するラベル: `def_rational_prime_vector_finite_sum_cauchy`、
  `def_increasing_prime_sequence`、`def_rational_prime_vector_geometric_truncation_sequence`、
  `claim_rational_prime_vector_geometric_truncations_cauchy`、
  `def_rational_prime_vector_finite_sum_convergence`。
- 有限等比級数の尾、正有理数に対する Cauchy 証人、任意の有限台候補から外れる素数係数の
  正の距離下界を、本文の証明段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_geometric_tail.sage` | 二つの打ち切り列の差量、有限等比級数の尾、その閉式と上界 | PASS | 段階 1..16 の全 256 対で成立 |
| `check_cauchy_witness.sage` | 正有理数 `a/b` に開始段階 `b+1` を選んだときの Cauchy 条件 | PASS | 64 許容誤差・全 1,600 後続段階対で成立 |
| `check_missing_coefficient_lower_bound.sage` | 有限台候補から外れる素数係数と、任意の開始段階に対する正の距離下界 | PASS | 81 候補・全 648 開始段階で成立 |

## 範囲と限界

- 等比級数の尾は段階 1..16 の全 256 対、Cauchy 証人は分子・分母 1..8 の正有理数と、
  各開始段階から 4 段先までの全二段階対を検査する。
- 非収束の下界は先頭四素数上の係数 `-1,0,1` の全 81 候補について、先頭五素数内から
  台の外の素数を選び、開始段階 1..8 の各反例段階を検査する。
- これはプログラミングによる有限範囲の検証であり、全ての正有理数、全ての後続段階、任意の
  有限台有理素数ベクトルに対する一般証明ではない。一般の Cauchy 性と非収束は構造化記述を正本とする。
- 自然数、整数、有理数、有限集合、有限台辞書だけを使う。浮動小数点、無限和、実数値ノルム、
  完備化、実数体、複素数体は使わない。

## 実行方法

```bash
for file in sagemath/check/rational-prime-vector-completeness-boundary/check_*.sage; do sage "$file"; done
```
