# SageMath Check: 二次体の表示の一意性

**対象ラベル**: `claim_quadratic_representation_unique`

- 対象: `structured-latex/content/main-text.ts` の「二次体の表示の一意性」の証明。
- 実行日: 2026-10-04。
- 結果: 28行・120,344等式と、既存の主張全体の標本検査がすべて通過。
- 帰属: 係数とその差は `QQ`、根は `QQbar`、包含写像 $\iota:\mathbb Q\hookrightarrow\overline{\mathbb Q}$ は `QQbar(...)`。浮動小数点計算と実数・複素数への脱出はない。

## 行別検算

主鎖16等号と、二つの係数復元の各6等号を表の順で検査する。
分子 $-2,\ldots,2$・分母 $1,2$ から重複を除いた7有理数の四つ組と、
$s^2=2$ の2根の全4,802組を標本とする。
純粋な四則・包含写像の保存を使う25行は、非同一表示4,704組も含めて検査する。
表示の等号を代入する1行と、係数差零を代入する2行は、仮定を満たす同一表示98組に限る。
したがって検査数は $25\cdot4802+3\cdot98=120344$ 等式である。

| ファイル | 検証内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| [check_difference_definitions.sage](check_difference_definitions.sage) | 係数差の定義を展開する | 通過 | 4802 等式 |
| [check_embedding_addition.sage](check_embedding_addition.sage) | 包含写像が加法を保つ | 通過 | 4802 等式 |
| [check_embedding_negation.sage](check_embedding_negation.sage) | 包含写像が加法の逆元を保つ | 通過 | 4802 等式 |
| [check_distribute_difference.sage](check_distribute_difference.sage) | 係数差と根の積を分配する | 通過 | 4802 等式 |
| [check_associate_first_sum.sage](check_associate_first_sum.sage) | 最初の加法を結合する | 通過 | 4802 等式 |
| [check_commute_negative_coefficient.sage](check_commute_negative_coefficient.sage) | 負の係数を和の右へ移す | 通過 | 4802 等式 |
| [check_associate_inner_sum.sage](check_associate_inner_sum.sage) | 内側の加法を結合する | 通過 | 4802 等式 |
| [check_group_first_representation.sage](check_group_first_representation.sage) | 最初の表示をまとめる | 通過 | 4802 等式 |
| [check_substitute_equal_representation.sage](check_substitute_equal_representation.sage) | 表示が等しいという仮定を代入する | 通過 | 98 等式 |
| [check_associate_equal_representation.sage](check_associate_equal_representation.sage) | 代入後の加法を結合する | 通過 | 4802 等式 |
| [check_group_root_terms.sage](check_group_root_terms.sage) | 根を含む二項をまとめる | 通過 | 4802 等式 |
| [check_factor_root_terms.sage](check_factor_root_terms.sage) | 根を共通因子として取り出す | 通過 | 4802 等式 |
| [check_cancel_root_coefficient.sage](check_cancel_root_coefficient.sage) | 根の係数とその逆元を消去する | 通過 | 4802 等式 |
| [check_zero_root_product.sage](check_zero_root_product.sage) | 零元と根の積を消去する | 通過 | 4802 等式 |
| [check_remove_inner_zero.sage](check_remove_inner_zero.sage) | 内側の零元を除く | 通過 | 4802 等式 |
| [check_cancel_constant_coefficient.sage](check_cancel_constant_coefficient.sage) | 定数係数とその逆元を消去する | 通過 | 4802 等式 |
| [check_restore_a_insert_zero.sage](check_restore_a_insert_zero.sage) | 係数 a の復元で零元を挿入する | 通過 | 4802 等式 |
| [check_restore_a_insert_additive_inverse.sage](check_restore_a_insert_additive_inverse.sage) | 係数 a の復元で加法の逆元の和を挿入する | 通過 | 4802 等式 |
| [check_restore_a_associate_sum.sage](check_restore_a_associate_sum.sage) | 係数 a の復元で加法を結合する | 通過 | 4802 等式 |
| [check_restore_a_difference_definition.sage](check_restore_a_difference_definition.sage) | 係数 a の復元で係数差の定義を代入する | 通過 | 4802 等式 |
| [check_restore_a_zero_difference.sage](check_restore_a_zero_difference.sage) | 係数 a の復元で係数差が零であることを代入する | 通過 | 98 等式 |
| [check_restore_a_remove_zero.sage](check_restore_a_remove_zero.sage) | 係数 a の復元で零元を除く | 通過 | 4802 等式 |
| [check_restore_b_insert_zero.sage](check_restore_b_insert_zero.sage) | 係数 b の復元で零元を挿入する | 通過 | 4802 等式 |
| [check_restore_b_insert_additive_inverse.sage](check_restore_b_insert_additive_inverse.sage) | 係数 b の復元で加法の逆元の和を挿入する | 通過 | 4802 等式 |
| [check_restore_b_associate_sum.sage](check_restore_b_associate_sum.sage) | 係数 b の復元で加法を結合する | 通過 | 4802 等式 |
| [check_restore_b_difference_definition.sage](check_restore_b_difference_definition.sage) | 係数 b の復元で係数差の定義を代入する | 通過 | 4802 等式 |
| [check_restore_b_zero_difference.sage](check_restore_b_zero_difference.sage) | 係数 b の復元で係数差が零であることを代入する | 通過 | 98 等式 |
| [check_restore_b_remove_zero.sage](check_restore_b_remove_zero.sage) | 係数 b の復元で零元を除く | 通過 | 4802 等式 |

## Lean との対応

具体版 `quadraticRepresentationUnique` と必要十分版
`quadratic_representation_unique_necSuf` は、係数差の定義・加法保存・逆元保存を別々の等号にし、
本文と同じ16行・6行・6行を持つ。具体版は必要十分版を呼ばずに証明する。
必要十分版の仮定は、係数側と値側の加法可換群、加法準同型、右作用の加法保存と零元保存、一次独立性である。
導出版 `quadraticRepresentationUnique_from_necSuf` は実際の包含写像・右乗法と、
二の平方根について既に証明した一次独立性を供給する。
対象三モジュールの `lake build` は2026-10-04に通過した。

## 主張全体の有限標本検査

既存の `check.sage` は、4,704非同一表示で値が異なること、4,802組で恒等変形、
98同一表示で仮定代入を検査する。2026-10-04の再実行はすべて通過した。
この組数は行別の120,344等式へ加算しない。
2026-08-13 の実行は、この三種の検査について全件通過している。
行別検算は上の28ファイルで式の両辺を個別に確認する。
一次独立性から二つの係数差が零と結論する推論は Lean が確認する。

## 実行方法

プロジェクト直下で実行する。

```sh
sage -c "__file__='sagemath/check/quadratic-representation-unique/check.sage'; load(__file__)"
```
