# SageMath 検算: 互いに漸近一致しない有限和差量 Cauchy 列の非可算族

## 対象

**対象ラベル**: `claim_rational_prime_vector_asymptotically_distinct_cauchy_sequences_uncountable`

- 併せて検証するラベル: `def_rational_prime_vector_cauchy_sequence_asymptotic_agreement`、
  `def_rational_prime_vector_finite_sum_cauchy`、`def_rational_prime_vector_finite_sum_distance`。
- 二元列ごとの Cauchy 上界と、相異なる二元列から作る二列の正の距離下界を、本文の証明段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_binary_truncation_cauchy_bound.sage` | 二元列の打ち切り間の差量、選択された有限尾、完全な有限等比級数尾、逆数上界 | PASS | 全 256 二元列・16,384 段階対で成立 |
| `check_distinct_sequences_positive_lower_bound.sage` | 相異なる二元列が異なる係数の正有理下界を全後続段階で保つこと | PASS | 全 8,128 相異なる対・49,216 後続段階で成立 |

## 範囲と限界

- Cauchy 上界は長さ八の全 256 二元列と、打ち切り段階 1..8 の全 16,384 対を検査する。
- 漸近不一致の下界は長さ七の全 128 二元列から得る全 8,128 相異なる対と、最初の相違位置以後の有限段階を検査する。
- これはプログラミングによる有限範囲の検証であり、全二元列の非可算性または一般の Cauchy 性の証明ではない。一般主張は構造化記述を正本とする。
- 自然数、整数、有理数、有限集合、有限台辞書だけを使う。浮動小数点、漸近一致条件の同値関係、商集合、完備化、無限和、実数値ノルム、実数体、複素数体は使わない。

## 実行方法

```bash
for file in sagemath/check/rational-prime-vector-asymptotically-distinct-cauchy-sequences/check_*.sage; do sage "$file"; done
```
