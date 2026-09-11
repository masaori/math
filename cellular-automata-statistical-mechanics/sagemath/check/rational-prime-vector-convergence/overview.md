# SageMath 検算: 有限台有理素数ベクトル列の有限和差量による収束

## 対象

**対象ラベル**: `claim_shift_rationalized_logarithmic_density_vector_converges`

- 併せて検証するラベル: `def_rational_prime_vector_zero`、
  `def_rational_prime_vector_finite_sum_distance`、
  `def_rational_prime_vector_finite_sum_convergence`、
  `claim_rational_prime_vector_finite_sum_distance_nonnegative`、
  `def_shift_rationalized_logarithmic_density_sequence`、
  `claim_positive_integer_reciprocal_converges_rationally`。
- 有限和差量の非負性、シフト正規化列の台、零ベクトルまでの差量の逆数表示、
  正有理数の許容誤差に対する収束証人を、本文の証明段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_finite_sum_distance_nonnegative.sage` | 二つの有限台の合併上の有理絶対差と、その有限和の非負性 | PASS | 三素数上の係数 `-2..2` の全 15,625 ベクトル対で成立 |
| `check_shift_vector_support.sage` | シフト正規化列の台が素数二だけであり、零ベクトルの台が空であること | PASS | 舞台サイズ 1..128 の各段階と三素数上の全 384 係数で成立 |
| `check_shift_finite_sum_distance.sage` | シフト正規化ベクトルと零ベクトルの有限和差量が正整数の逆数に一致すること | PASS | 舞台サイズ 1..256 の全 256 段階で成立 |
| `check_vector_convergence_witness.sage` | 正有理数 `a/b` に開始段階 `b+1` を選んだとき、有限和差量が許容誤差未満となる各不等式 | PASS | 分子・分母 1..64 の全 4,096 許容誤差と、その開始段階から 64 段先までの計 266,240 段階で成立 |

## 範囲と限界

- 非負性は素数二・三・五と係数 `-2..2`、シフト列は舞台サイズ 1..256、収束証人は
  分子・分母 1..64 の正有理数と各開始段階から 64 段先までという明示した有限範囲を検査する。
- これはプログラミングによる有限範囲の検証であり、任意の有限台有理ベクトル対、全ての正有理数、
  全ての後続段階に対する一般証明ではない。一般の非負性と収束は構造化記述を正本とする。
- 自然数、整数、有理数、有限集合、有限台辞書だけを使う。分母は正整数に限定し、零除算へ既定値を置かない。
  浮動小数点、実数値ノルム、無限和、完備化、実数体、複素数体は使わない。

## 実行方法

```bash
for file in sagemath/check/rational-prime-vector-convergence/check_*.sage; do sage "$file"; done
```
