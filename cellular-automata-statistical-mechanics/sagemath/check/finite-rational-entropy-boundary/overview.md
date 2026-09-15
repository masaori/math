# SageMath 検算: 有限有理確率分布のエントロピーと実数境界

## 対象

**対象ラベル**: `claim_finite_rational_entropy_real_comparison`

- 併せて検証するラベル: `def_finite_rational_probability_distribution_support`、
  `def_finite_rational_prime_vector_entropy`、`def_rational_prime_vector_logarithmic_real_evaluation`、
  `claim_finite_real_distribution_not_always_rational`。
- 正の台だけの素数指数表、有限有理加重和、実対数の積法則適用後の係数恒等式、
  無理数重みを持つ二元分布の非対応を、本文の定義と証明の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_prime_exponent_table.sage` | 零重みを除いた正の台の各有理重みを素因数分解し、指数表から復元すること | PASS | 1,070 分布・3,085 正重みで成立し、921 零重みを除外 |
| `check_finite_weighted_sum.sage` | 有理重みによる有限加重和の各素数係数と台の有限合併への包含 | PASS | 1,070 分布・2,518 係数で成立 |
| `check_real_logarithmic_comparison.sage` | 素数の実対数を独立な形式変数として、実対数の積法則適用後の有限係数恒等式 | PASS | 非自明な 1,060 分布で成立 |
| `check_irrational_weight_noncorrespondence.sage` | 平方根二の二分の一を含む二元分布の正値性・正規化・有理数像との非対応 | PASS | 二重みで厳密に成立 |

## 範囲と限界

- 有理分布は台の大きさ一から四、共通分母一から十までの全ての非負整数組を既約有理数へ移した有限範囲で検査する。
  これは明示した有限範囲のプログラミングによる検証であり、任意の有限有理分布に対する一般証明ではない。
- 実対数比較は、正の有理数の素因数分解へ実対数の積法則を適用した後の係数恒等式を、
  素数ごとの独立な形式変数を持つ有理係数多項式環で厳密に検査する。実対数の解析的性質そのものは
  SageMath へ委ねず、一般証明は構造化記述に置く。
- 無理数反例は実代数的数体で厳密に扱い、最小多項式の次数二により有理数の標準像にないことを判定する。
  浮動小数点は使わない。
- 零重みへ素数指数または実対数を適用せず、無限和、極限、完備化、複素数体、任意の実数値分布の分類は扱わない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-rational-entropy-boundary/check_*.sage; do sage "$file"; done
```
