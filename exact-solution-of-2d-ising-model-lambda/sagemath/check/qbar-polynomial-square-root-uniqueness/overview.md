# SageMath Check: 定数項を一に正規化した多項式平方根の一意性

**対象ラベル**: `claim_qbar_polynomial_square_root_unique`

## 範囲

本文の因数分解の八つの等号、定数項の矛盾を示す五つの等号、差が零から等号へ戻す三つの等号を、それぞれ独立ファイルで検算する。
係数は `QQbar`、多項式は `QQbar[x]` で厳密に計算し、浮動小数点・実数への脱出は用いない。

定数項一の標本は `1`, `1+x`, `1-x`, `1+sqrt(2)x`, `1+ix`,
`1+sqrt(2)x+ix^2`, `1+x^3`, `1-ix^3+sqrt(2)x^4` の八個。
仮定不要の恒等式は全64組、同じ平方の仮定は正負両方の16組、差が零の仮定は8組で検算する。

`ac_0(0)=ac_0(S+T)` は和が零の8組 `(S,-S)` に対して検算する。
これらは第二の多項式の定数項が `-1` であり、両方の定数項が一という仮定を満たさない。
`ac_0(S)+ac_0(T)=1+1` は定数項一の64組に対して検算する。
**両方の仮定を満たす標本は存在しない**ので、矛盾の連鎖全体を実在する標本で検算したとは主張しない。
到達不能な分岐を排除する論理は本文とLeanの責務であり、補助検算では `0 != 2` と反対符号の候補の棄却を確かめる。

SageMath の有限標本は一般命題の証明ではない。一意性は平方根の存在を主張しない。
その境界の補足例として、定数項一の `1+x` が多項式の平方でないことも検算する。

## チェック一覧

| ファイル | 式ペア・内容 | ステータス | 結果 |
|---|---|---|---|
| `check_distribute_difference.sage` | `(S-T)*(S+T) = S*(S+T)-T*(S+T)` | PASS | 64等式 |
| `check_expand_first_product.sage` | `S*(S+T)-T*(S+T) = (S*S+S*T)-T*(S+T)` | PASS | 64等式 |
| `check_expand_second_product.sage` | `(S*S+S*T)-T*(S+T) = (S*S+S*T)-(T*S+T*T)` | PASS | 64等式 |
| `check_commute_mixed_product.sage` | `(S*S+S*T)-(T*S+T*T) = (S*S+S*T)-(S*T+T*T)` | PASS | 64等式 |
| `check_associate_subtraction.sage` | `(S*S+S*T)-(S*T+T*T) = ((S*S+S*T)-S*T)-T*T` | PASS | 64等式 |
| `check_cancel_mixed_product.sage` | `((S*S+S*T)-S*T)-T*T = S*S-T*T` | PASS | 64等式 |
| `check_substitute_equal_squares.sage` | `S*S-T*T = T*T-T*T` | PASS | 16等式 |
| `check_subtract_self.sage` | `T*T-T*T = zero` | PASS | 64等式 |
| `check_constant_zero.sage` | `scalar_zero = zero[0]` | PASS | 64等式 |
| `check_substitute_zero_sum.sage` | `zero[0] = (S+T)[0]` | PASS | 8等式 |
| `check_constant_addition.sage` | `(S+T)[0] = S[0]+T[0]` | PASS | 64等式 |
| `check_constant_normalization.sage` | `S[0]+T[0] = scalar_one+scalar_one` | PASS | 64等式 |
| `check_one_plus_one.sage` | `scalar_one+scalar_one = scalar_two` | PASS | 64等式 |
| `check_restore_difference.sage` | `S = (S-T)+T` | PASS | 64等式 |
| `check_substitute_zero_difference.sage` | `(S-T)+T = zero+T` | PASS | 8等式 |
| `check_zero_addition.sage` | `zero+T = T` | PASS | 64等式 |
| `check_zero_product_cases.sage` | 零積の両分岐、反対符号の棄却、定数項二の非零性 | PASS | 一致8組・反対符号8組・非零和64組 |
| `check_existence_boundary.sage` | `1+x` の多項式平方根不存在 | PASS | 平方でないことを確認 |

## 実行

2026-10-24、SageMath 10.9（micromamba の `sage` 環境）で、
統合起動と18ファイルの個別起動がすべて終了コード0・`RESULT: PASS` となった。
16等号の合計864件と補助検算2本が通過した。

プロジェクトディレクトリから:

```sh
sage sagemath/check/qbar-polynomial-square-root-uniqueness/check.sage
for f in sagemath/check/qbar-polynomial-square-root-uniqueness/check_*.sage; do sage "$f"; done
```

実行環境に応じて `sage` を `micromamba run -n sage sage` に置き換える。

## 実行時エラーの記録

初回の統合実行は検算ファイル数の assertion、初回の単独実行は `_prelude.sage` の読込で停止した。
この環境の Sage CLI が `__file__` を入力ファイルへ設定しないことが原因である。
入力の `.sage` ファイルを指す `__file__` が無ければ `sys.argv[0]` を使うよう修正した。
等式の失敗ではなく起動経路のエラーであり、数学的な条件は変更していない。
