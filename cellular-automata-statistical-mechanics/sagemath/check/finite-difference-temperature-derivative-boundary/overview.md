# SageMath 検算: 有限差分逆温度と実数微分の境界

## 対象

**対象ラベル**: `claim_binary_ca_finite_difference_does_not_determine_derivative`

- 併せて検証するラベル: `claim_prime_vector_real_evaluation_of_prime_logarithm`、
  `claim_binary_ca_unit_difference_real_evaluation`、`def_binary_ca_real_entropy_interpolants`、
  `def_binary_ca_interpolated_derivative_temperature`。
- 正の有理数の実対数評価、正の有限状態数二つの差の一致、二補間の端点一致、
  非零刻みの差分商と一点の微分値の相違を、本文の定義と証明の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_positive_rational_real_evaluation.sage` | 正の有理数の有限素因数表と、実対数の積法則適用後の形式係数恒等式 | PASS | 647 有理数・1,596 素数係数で成立 |
| `check_unit_difference_real_evaluation.sage` | 正の有限状態数の比の素数指数と、二つの実対数の差の形式係数恒等式 | PASS | 4,096 状態数対・11,288 素数係数で成立 |
| `check_interpolant_endpoints.sage` | 一次・二次補間が同じ二端点値を持つ実多項式恒等式 | PASS | 6 多項式恒等式で成立 |
| `check_difference_quotients_and_derivatives.sage` | 二補間の非零刻み差分商と、左端で一だけ異なる微分値 | PASS | 2 差分商・3 微分恒等式で成立 |

## 範囲と限界

- 正の有理数は分子・分母 1..32 から得る既約値、正の有限状態数は 1..64 の全 4,096 対を検査する。
  これは明示した有限範囲のプログラミングによる検証であり、一般証明は構造化記述にある。
- 実対数を数値近似せず、有限素因数分解に実対数の積・商の法則を適用した後の係数恒等式を、
  素数ごとの独立な形式変数を持つ有理係数多項式環で厳密に検査する。
- 二つの補間は有理係数の形式多項式として端点、差分商、形式微分を厳密に検査する。
  これらの多項式恒等式は有理数の標準像を含む実数体でも成り立つ。浮動小数点は使わない。
- 実数脱出は、本文で素数の実対数を選ぶ箇所と、実数上の補間・微分・極限を定義する箇所にある。
  本検算は実対数の解析的構成や一般の微分可能関数の極限を機械証明せず、本文で用いる有限素因数係数と
  明示した二つの実多項式の代数的な各段を検査する。
- 状態数零への対数、無限和、完備化、複素数体、任意の連続補間の分類は扱わない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-difference-temperature-derivative-boundary/check_*.sage; do sage "$file"; done
```
