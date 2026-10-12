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

Lean具体版と必要十分版は本文と同じ十七等号を持つ。必要十分版は結合則・実際に使う二つの可換性・
右逆元・単位元の法則から各等号を導き、途中の並べ替えの結論を仮定しない。
導出版は有理数の法則と「有理数の平方は二にならない」の導出版を供給する。
背理仮定の代入と終点での矛盾はLeanで確認する。

## 実行記録

2026-10-12: 全18ファイルを再実行した。数値検算する十六行は各33,306組、合計532,896等式でPASS、
既存回帰も640,800組でPASS。背理仮定代入の一行は数値事例なしの扱いを保った。
本文・独立具体版・必要十分版の十七等号を突き合わせ、Lean三モジュールの対象buildが通過した。
通常CLIでの `check_ratio_definition.sage` の初回起動は、Sage側の `__file__` を使って共有定義を探すため
ERRORになった。行別16ファイルに `sys.argv[0]` で元ファイルの場所を得る経路を加え、
同ファイルの通常CLI再実行で33,306組がPASSとなった。検査する式・標本・仮定は変更していない。

2026-10-10: 全18ファイルを実行した。数値検算する十六行は各33,306組、合計532,896等式で全てPASS。
背理仮定代入の一行は数値事例なしとして報告し、数値PASSには含めない。
既存回帰検算も640,800組でPASS。全ての検算で $b\ne0$ を維持した。
対象のLean具体版・導出版のbuildも通過した。

2026-08-13の既存記録は、分子・分母1から20の正負と零を用いた640,800組の回帰検算が通過したもの。
この組数には重複する有理数の組を含む。仮定代入行の数値検査が通過したことは意味しない。

## 実行方法

個別起動は `sage sagemath/check/rational-square-ne-double-square/check_ratio_definition.sage` の形で行う。
一括起動はプロジェクト直下で、読み込むファイルを `__file__` へ明示する。

```sh
sage -c "import glob; fs=sorted(glob.glob('sagemath/check/rational-square-ne-double-square/check*.sage')); exec('for f in fs:\n    __file__ = f\n    load(f)')"
```
