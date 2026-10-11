# SageMath Check: 対角相似とスカラー倍による行列式の保存

**対象ラベル**: `claim_gauged_terminal_matrix_determinant`

実行日: 2026-10-11。実行結果: 38本・2,716等式がすべて通過した。

帰属は厳密な円分体 `CyclotomicField(8)` とその多項式環。辺長1・2・3、四つのスピン構造、四つの原始八乗根の全48入力を用いる。単位行列の置換展開は辺長1の24置換を全列挙し、根の準備は相異なる四根を使う。行列式は各行列から直接計算し、保存の結論を代入して作らない。有限検算であり、一般の証明は Lean が担う。

| 計算の部分 | 行別ファイル | 状態 |
|---|---|---|
| 単位行列の対角外成分 | `check_identity_off_diagonal_zero.sage` | 通過（368等式） |
| 恒等置換以外の積 | `check_identity_nonidentity_product_zero.sage` | 通過（368等式） |
| 恒等置換以外の項 | `check_identity_zero_factor_substitution.sage` | 通過（368等式） |
| 恒等置換以外の項 | `check_identity_zero_weighted_term.sage` | 通過（368等式） |
| 恒等置換の符号 | `check_identity_sign.sage` | 通過（16等式） |
| 恒等置換の符号 | `check_identity_constant_one.sage` | 通過（16等式） |
| 単位行列の置換展開 | `check_identity_permutation_expansion.sage` | 通過（16等式） |
| 単位行列の置換展開 | `check_identity_only_term.sage` | 通過（16等式） |
| 単位行列の置換展開 | `check_identity_diagonal_entries.sage` | 通過（16等式） |
| 単位行列の置換展開 | `check_identity_weight_one.sage` | 通過（16等式） |
| 単位行列の置換展開 | `check_identity_product_of_ones.sage` | 通過（16等式） |
| 単位行列の置換展開 | `check_identity_unit_product.sage` | 通過（16等式） |
| 八乗根の準備 | `check_root_power_grouping.sage` | 通過（4等式） |
| 八乗根の準備 | `check_root_fourth_power.sage` | 通過（4等式） |
| 八乗根の準備 | `check_root_negative_one_square.sage` | 通過（4等式） |
| スカラーの冪 | `check_scalar_cardinality.sage` | 通過（48等式） |
| スカラーの冪 | `check_scalar_constant_power.sage` | 通過（48等式） |
| スカラーの冪 | `check_scalar_power_flattening.sage` | 通過（48等式） |
| スカラーの冪 | `check_scalar_exponent_arithmetic.sage` | 通過（48等式） |
| スカラーの冪 | `check_scalar_eighth_power_grouping.sage` | 通過（48等式） |
| スカラーの冪 | `check_scalar_eighth_power_substitution.sage` | 通過（48等式） |
| スカラーの冪 | `check_scalar_power_of_one.sage` | 通過（48等式） |
| スカラーの冪 | `check_scalar_constant_one.sage` | 通過（48等式） |
| 逆行列の行列式の積 | `check_inverse_determinant_product.sage` | 通過（48等式） |
| 逆行列の行列式の積 | `check_inverse_matrix_product.sage` | 通過（48等式） |
| 逆行列の行列式の積 | `check_inverse_identity_determinant.sage` | 通過（48等式） |
| 変換後の行列式 | `check_gauged_matrix_definition.sage` | 通過（48等式） |
| 変換後の行列式 | `check_determinant_scalar_factor.sage` | 通過（48等式） |
| 変換後の行列式 | `check_scalar_factor_one.sage` | 通過（48等式） |
| 変換後の行列式 | `check_scalar_unit_removal.sage` | 通過（48等式） |
| 変換後の行列式 | `check_outer_determinant_product.sage` | 通過（48等式） |
| 変換後の行列式 | `check_inner_determinant_product.sage` | 通過（48等式） |
| 変換後の行列式 | `check_determinant_association_right.sage` | 通過（48等式） |
| 変換後の行列式 | `check_determinant_commutation.sage` | 通過（48等式） |
| 変換後の行列式 | `check_determinant_association_left.sage` | 通過（48等式） |
| 変換後の行列式 | `check_inverse_factor_one.sage` | 通過（48等式） |
| 変換後の行列式 | `check_inverse_unit_removal.sage` | 通過（48等式） |
| 変換後の行列式 | `check_terminal_determinant_value.sage` | 通過（48等式） |

プロジェクト直下で `sage sagemath/check/gauged-terminal-matrix-determinant/check.sage` を実行する。各行別ファイルは単独でも実行できる。
