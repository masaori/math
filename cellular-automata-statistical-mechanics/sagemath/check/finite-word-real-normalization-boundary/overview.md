# SageMath 検算: 有限語個数の実数実現による規格化境界

## 対象

**対象ラベル**: `claim_full_two_symbol_word_realized_density_constant`

- 併せて検証するラベル: `def_prime_vector_additive_real_realization`、
  `claim_prime_vector_additive_realization_natural_multiple`、
  `def_finite_word_realized_logarithmic_density`。
- 素数指数ベクトルの有限表、加法的実数実現の有理値有限例、正の語長による除算、
  全二元語族の有限段階一定性を、本文の定義と証明の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_prime_exponent_finite_table.sage` | 正の有限二元語個数と、その対数順序群値の有限な素数指数表 | PASS | 語長 1..64 の 64 個数で、素数二の係数が語長に一致 |
| `check_additive_realization_natural_multiple.sage` | 有理値加法写像の零・加法・自然数倍 | PASS | 三素数上の 125 ベクトルについて、零 1 件、加法 15,625 件、自然数倍 2,125 件で成立 |
| `check_positive_length_division.sage` | 正の語長の非零性と規格化除算 | PASS | 四つの有理値実現、語長 1..128 の全 512 除算で成立 |
| `check_full_word_density_constancy.sage` | 素数指数表の自然数倍と有限段階規格化値の一定性 | PASS | 語長 1..128 の 128 対数等式、四つの有理値実現による 512 規格化等式で成立 |

## 範囲と限界

- 明示した有限範囲のプログラミングによる検証であり、任意の正の語長または任意の加法写像に対する
  一般証明ではない。一般証明は構造化記述にある。
- 実数実現の有限例には、指定した有限個の素数に有理値を与え、それ以外の素数を零へ送る加法写像を
  使う。有理数から実数への標準単射の前で全等号を厳密に判定するため、浮動小数点による近似はない。
  これは一般の実数値加法写像の全数検査ではない。
- 状態数は正の全二元語個数、分母は正の語長だけに限定する。状態数零への対数と語長零による除算へ
  既定値を置かない。
- 一般語族の実数列、収束概念、極限、位相的エントロピーの存在は定義も検査もしていない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-word-real-normalization-boundary/check_*.sage; do sage "$file"; done
```
