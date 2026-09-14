# SageMath Check: epsilon_action_eigenvalues_are_signs

## 対象

**対象ラベル**: `epsilon_action_eigenvalues_are_signs`（structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
- 範囲: 非零ベクトル `f` が `epsilon f=lambda f` を満たすならば、`lambda=1` または `lambda=-1` であること
- 対象外: 二つの固有空間の次元公式と相補射影の性質

## チェック一覧

| ファイル | 本文の一段 | ステータス | 結果 |
|---|---|---|---|
| `check_assoc_component_action_definition.sage` | 準備: `((epsilon^2)f)_i` を作用の成分和へ展開 | **PASS** | `M=1,…,5`、両符号、全成分で厳密等号 |
| `check_assoc_component_matrix_product.sage` | 準備: `(epsilon^2)_{ik}` を積の成分和へ展開 | **PASS** | 同上 |
| `check_assoc_component_distribute_vector.sage` | 準備: 分配律でベクトル成分を内側の和へ入れる | **PASS** | 同上 |
| `check_assoc_component_reassociate_products.sage` | 準備: 各項で積を結合し直す | **PASS** | 同上 |
| `check_assoc_component_finite_sum.sage` | 準備: 有限二重和の順序交換 | **PASS** | 同上 |
| `check_assoc_component_factor_matrix_entry.sage` | 準備: 分配律で行列成分を括り出す | **PASS** | 同上 |
| `check_assoc_component_nested_action.sage` | 準備: 二重和を `(epsilon(epsilon f))_i` へ戻す | **PASS** | 同上 |
| `check_linearity_component_action_definition.sage` | 準備: `(epsilon(lambda f))_i` を成分和へ展開 | **PASS** | 同上 |
| `check_linearity_component_scalar_association.sage` | 準備: 各項で最初の積を結合し直す | **PASS** | 同上 |
| `check_linearity_component_commute_scalar.sage` | 準備: 行列成分と `lambda` を交換する | **PASS** | 同上 |
| `check_linearity_component_reassociate_scalar.sage` | 準備: 交換後の積を結合し直す | **PASS** | 同上 |
| `check_linearity_component_factor_scalar.sage` | 準備: 有限和から `lambda` を括り出す | **PASS** | 同上 |
| `check_linearity_component_result.sage` | 準備: 成分和を `(lambda(epsilon f))_i` へ戻す | **PASS** | 同上 |
| `check_identity_action_component_definition.sage` | 単位行列の作用を成分和へ展開 | **PASS** | `M=1,…,5`、両符号、全成分で厳密等号 |
| `check_identity_action_zero_one.sage` | 単位行列の成分と `0,1` の法則で成分和を `f_i` へ戻す | **PASS** | 同上 |
| `check_vector_identity_action.sage` | `f=If` | **PASS** | `M=1,…,5`、両符号で厳密等号 |
| `check_replace_identity_by_epsilon_square.sage` | `If=epsilon^2f` | **PASS** | 同上 |
| `check_matrix_product_action.sage` | `epsilon^2f=epsilon(epsilon f)` | **PASS** | 同上 |
| `check_eigenvector_substitution_inner.sage` | `epsilon(epsilon f)=epsilon(lambda f)` | **PASS** | 同上 |
| `check_scalar_extraction.sage` | `epsilon(lambda f)=lambda(epsilon f)` | **PASS** | 同上 |
| `check_eigenvector_substitution_outer.sage` | `lambda(epsilon f)=lambda(lambda f)` | **PASS** | 同上 |
| `check_nested_scalar_product.sage` | `lambda(lambda f)=(lambda lambda)f` | **PASS** | 同上 |
| `check_scalar_square_definition.sage` | `(lambda lambda)f=lambda^2f` | **PASS** | 同上 |
| `check_component_difference_zero.sage` | `lambda^2f_j-f_j=0` | **PASS** | `f_0=1` の成分で厳密等号 |
| `check_component_factor_expansion.sage` | `(lambda^2-1)f_j=lambda^2f_j-1f_j` | **PASS** | 同上 |
| `check_component_one_product.sage` | `lambda^2f_j-1f_j=lambda^2f_j-f_j` | **PASS** | 同上 |
| `check_component_product_zero.sage` | 展開後の積へ `lambda^2f_j-f_j=0` を代入 | **PASS** | 同上 |
| `check_component_cancel_nonzero.sage` | `f_j!=0` による消去 | **PASS** | `lambda^2-1=0` |
| `check_factor_difference_of_squares.sage` | 平方差の因数分解 | **PASS** | 厳密等号 |
| `check_factor_substitute_zero.sage` | 平方差へ `lambda^2-1=0` を代入 | **PASS** | 因数分解後の積が零 |
| `check_zero_product_alternatives.sage` | 零積の法則 | **PASS** | 二因子の少なくとも一方が零 |
| `check_solve_linear_factors.sage` | 一次方程式を解く | **PASS** | `lambda=1` または `lambda=-1` |

全成分を `QQ` 上に置き、`QQ -> C` の包含前に浮動小数点を使わず判定する。
`M=1,…,5` の各全スピン反転行列について、最初と最後の標準基底ベクトルから作る
固有値 `+1` と `-1` の二つの非零固有ベクトルを使い、行列作用の結合則・複素線型性を
成分から示す準備十三段と主計算の十九段、計三十二段を一段一ファイルで検査した。
これは有限例のプログラミングによる検証であり、一般の `M` と任意の非零固有ベクトルに対する
証明は Lean の `epsilon_action_eigenvalues_are_signs` が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_action_eigenvalues_are_signs
```

実行ログは `sagemath/check/epsilon_action_eigenvalues_are_signs/logs/` に保存する。
