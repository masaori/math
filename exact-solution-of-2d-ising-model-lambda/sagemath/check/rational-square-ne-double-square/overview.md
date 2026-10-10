# SageMath Check: 有理数の平方は二倍の平方にならない（混合符号の排除）

**対象ラベル**: `claim_rational_square_ne_double_square`

対象は `structured-latex/content/main-text.ts` の背理法の鎖である。
主張・仮定 $b\ne0$・背理法の構成は保ち、十七等号を一等号一理由で検査する。
全て `QQ` の厳密計算であり、浮動小数点は使わない。

## 行別の対応

| ファイル | 本文の等号 | ステータス | 結果 |
|---|---|---|---|
| `check_ratio_definition.sage` | 比の定義 | PASS | 33,306 組 |
| `check_numerator_outer_associate.sage` | 分子側の外側の結合則 | PASS | 33,306 組 |
| `check_numerator_inner_associate_left.sage` | 分子側の内側を左へ結合 | PASS | 33,306 組 |
| `check_numerator_commute.sage` | 分子側の逆元と分子を交換 | PASS | 33,306 組 |
| `check_numerator_inner_associate_right.sage` | 分子側の内側を右へ結合 | PASS | 33,306 組 |
| `check_numerator_square_associate.sage` | 分子の二項を結合 | PASS | 33,306 組 |
| `check_contradiction_assumption.sage` | 背理法の仮定の代入 | 数値事例なし | Leanの仮定代入で確認。数値PASSに数えない |
| `check_denominator_factor_two.sage` | 二を外側へ出す結合則 | PASS | 33,306 組 |
| `check_denominator_outer_associate_right.sage` | 分母側の外側を右へ結合 | PASS | 33,306 組 |
| `check_denominator_inner_associate_left.sage` | 分母側の内側を左へ結合 | PASS | 33,306 組 |
| `check_denominator_commute.sage` | 分母と逆元を交換 | PASS | 33,306 組 |
| `check_denominator_inner_associate_right.sage` | 分母側の内側を右へ結合 | PASS | 33,306 組 |
| `check_denominator_inverse_pairs.sage` | 分母と逆元の対を結合 | PASS | 33,306 組 |
| `check_first_inverse_cancel.sage` | 一つ目の逆元の積を一へ | PASS | 33,306 組 |
| `check_second_inverse_cancel.sage` | 二つ目の逆元の積を一へ | PASS | 33,306 組 |
| `check_inner_unit.sage` | 内側の単位元を除く | PASS | 33,306 組 |
| `check_outer_unit.sage` | 外側の単位元を除く | PASS | 33,306 組 |
| `check.sage` | 主張・恒等変形・偽同士の同値の既存回帰 | PASS | 640,800 組 |

行別検算の標本は、分子が $-12,\ldots,12$、分母が $1,\ldots,12$ の相異なる有理数183個である。
$a$ はその全て、$b$ は零を除く182個から取り、全33,306組を各行で調べる。
$a=0$、正負、整数、非整数を含み、全ての組で $b\ne0$ を保つ。

背理仮定 $a^2=2b^2$ と $b\ne0$ を同時に満たす有理数の数値事例は存在しない。
この一行は**数値事例なし、Leanの仮定代入で確認**とし、数値PASS件数に数えない。
$b\ne0$ を緩めた零の例は使わない。既存回帰の「$a^2=2b^2$ と $(ab^{-1})^2=2$ の同値」は
両辺が偽であることの確認であり、背理仮定の代入行の検証ではない。

Lean具体版は本文と同じ十七等号を持つ。導出版は最初の並べ替え五等号、
後の並べ替え六等号、単位元の二等号を明示し、$bb^{-1}=1$ を供給する。
必要十分版の任意の乗法と単位元、二つの並べ替え、右逆元、単位元の仮定は維持する。
背理仮定の代入と終点での矛盾はLeanで確認する。

## 実行記録

2026-10-10: 全18ファイルを実行した。数値検算する十六行は各33,306組、合計532,896等式で全てPASS。
背理仮定代入の一行は数値事例なしとして報告し、数値PASSには含めない。
既存回帰検算も640,800組でPASS。全ての検算で $b\ne0$ を維持した。
対象のLean具体版・導出版のbuildも通過した。

2026-08-13の既存記録は、分子・分母1から20の正負と零を用いた640,800組の回帰検算が通過したもの。
この組数には重複する有理数の組を含む。仮定代入行の数値検査が通過したことは意味しない。

## 実行方法

プロジェクト直下で、読み込むファイルを `__file__` へ明示する。

```sh
sage -c "import glob; fs=sorted(glob.glob('sagemath/check/rational-square-ne-double-square/check*.sage')); exec('for f in fs:\n    __file__ = f\n    load(f)')"
```
