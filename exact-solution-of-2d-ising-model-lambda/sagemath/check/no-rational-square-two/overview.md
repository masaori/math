# SageMath Check: 有理数の平方は二にならない

**対象ラベル**: `claim_no_rational_square_two`。

`QQ`、`ZZ`、素数を添字とする有限台の整数値関数で厳密に計算し、浮動小数点は使わない。
本文の六計算鎖は計27行（21等号・6不等号）。24行を数値検査し、残る3行は
背理法の仮定の使用として区別する。

`q*q=2` を満たす有理数の数値例は存在しないため、正負の枝の仮定の再掲と
`w2(2)=w2(r*r)` の行は「数値検算対象なし・Leanで仮定代入確認」と記録する。
空の条件付きループを検算として数えず、この3行を PASS の等式数に含めない。
具体版と導出版の対応する `hSquare` の使用が、仮定からの導出を形式検証する。

正・負の有理数はそれぞれ分子・分母1から40の1,600入力組を使う。
同じ有理数を表す入力組の重複を含む。零の枝は別に零で検査する。
整数の上側は1から80、下側は-80から0を取り、定数の等式・不等式は各一件検査する。
有限の入力組に対する検算を、一般の有理数についての証明とは扱わない。

| ファイル | 本文の行 | 状態 | 件数 |
|---|---|---|---:|
| `check.sage` | 既存の統合検算：平方非二・指数の加法性・整数の矛盾 | PASS | 3,200入力組、161整数 |
| `check_zero_substitution.sage` | 零の枝：q=0 の代入 | PASS | 1 |
| `check_zero_product.sage` | 零の枝：零元との積 | PASS | 1 |
| `check_positive_definition.sage` | 正の枝：r=q の定義 | PASS | 1,600 |
| `check_positive_assumption.sage` | 正の枝：q*q=2 の仮定 | 数値検算対象なし・Leanで仮定代入確認 | 0 |
| `check_negative_definition.sage` | 負の枝：r=-q の定義 | PASS | 1,600 |
| `check_negative_left_product.sage` | 負の枝：左の負号の積 | PASS | 1,600 |
| `check_negative_right_product.sage` | 負の枝：右の負号の積 | PASS | 1,600 |
| `check_negative_double_negation.sage` | 負の枝：加法逆元の二重適用 | PASS | 1,600 |
| `check_negative_assumption.sage` | 負の枝：q*q=2 の仮定 | 数値検算対象なし・Leanで仮定代入確認 | 0 |
| `check_one_subtract_zero.sage` | 指数：零の減法 | PASS | 1 |
| `check_prime_two_exponent.sage` | 指数：v2(2)=1 | PASS | 1 |
| `check_prime_one_exponent.sage` | 指数：v2(1)=0 | PASS | 1 |
| `check_two_rational_exponent.sage` | 指数：2=2/1 での w2 | PASS | 1 |
| `check_square_assumption.sage` | 指数：r*r=2 による w2 の引数の置換 | 数値検算対象なし・Leanで仮定代入確認 | 0 |
| `check_log_product_definition.sage` | 指数：積の対数の成分 | PASS | 1,600 |
| `check_log_additivity.sage` | 指数：対数の加法性 | PASS | 1,600 |
| `check_log_component_addition.sage` | 指数：対数順序群の成分の加法 | PASS | 1,600 |
| `check_rational_exponent_definition.sage` | 指数：二つの対数成分を w2 へ戻す | PASS | 1,600 |
| `check_integer_exponent_definition.sage` | 指数：m=w2(r) の定義 | PASS | 1,600 |
| `check_high_left_addition.sage` | 整数 m>=1：左の加数を比較 | PASS | 80 |
| `check_high_right_addition.sage` | 整数 m>=1：右の加数を比較 | PASS | 80 |
| `check_high_two_definition.sage` | 整数 m>=1：二の定義 | PASS | 1 |
| `check_high_strict_comparison.sage` | 整数 m>=1：二は一より大きい | PASS | 1 |
| `check_low_left_addition.sage` | 整数 m<=0：左の加数を比較 | PASS | 81 |
| `check_low_right_addition.sage` | 整数 m<=0：右の加数を比較 | PASS | 81 |
| `check_low_zero_addition.sage` | 整数 m<=0：零の加法 | PASS | 1 |
| `check_low_strict_comparison.sage` | 整数 m<=0：零は一より小さい | PASS | 1 |

実行方法（プロジェクト直下）:

```sh
micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage -c "__file__ = 'sagemath/check/no-rational-square-two/check.sage'; load(__file__)"
```

2026-08-13: 既存の統合検算が通過した。記録中の3,200は異なる有理数の個数ではなく入力組数である。

2026-10-04: 既存の3,200入力組と161整数、および行別24本の16,332等式・不等式が通過した。
仮定の使用3本は数値検算の対象外とし、数値行数・件数には含めていない。
