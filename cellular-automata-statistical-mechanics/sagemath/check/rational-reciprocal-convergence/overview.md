# SageMath 検算: 正有理数の許容誤差による逆数列の収束

## 対象

**対象ラベル**: `claim_shift_rationalized_logarithmic_density_converges_rationally`

- 併せて検証するラベル: `def_positive_rational_epsilon_convergence`、
  `claim_positive_integer_reciprocal_converges_rationally`、
  `def_shift_rationalized_logarithmic_density_sequence`。
- 正有理数の分数表示から選ぶ開始段階以後の各不等式と、シフト正規化列の素数二係数が
  正整数の逆数列へ一致する特殊化を、本文の証明段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_reciprocal_epsilon_witness.sage` | 正有理数 `a/b` に開始段階 `b+1` を選んだとき、逆数列の絶対差が許容誤差未満となる各不等式 | PASS | 分子・分母 1..64 の全 4,096 許容誤差と、その開始段階から 64 段先までの計 266,240 段階で成立 |
| `check_shift_coefficient_specialization.sage` | 一方向シフトの不動点数二から作る素数二係数が各段階で逆数 `1/L` に一致すること | PASS | 舞台サイズ 1..16 の全 131,070 配位を分類して成立 |

## 範囲と限界

- 逆数列の検算は分子・分母 1..64 の全 4,096 許容誤差について、開始段階から 64 段先までの
  各不等式を `QQ` で厳密に検査する。
- シフト係数の特殊化は舞台サイズ 1..16 の全 131,070 配位を走査し、不動点を再計算する。
- これは明記した有限範囲のプログラミングによる検証であり、任意の正有理数と全ての後続段階に
  対する一般証明ではない。一般の収束は構造化記述の量化された証明を正本とする。
- 自然数、整数、有理数、有限配位だけを使う。分母は正整数に限定し、零除算へ既定値を置かない。
  浮動小数点、実数体、実対数、位相、距離空間、完備化は使わない。

## 実行方法

```bash
for file in sagemath/check/rational-reciprocal-convergence/check_*.sage; do sage "$file"; done
```
