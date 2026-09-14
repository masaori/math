# SageMath Check: global_spin_flip_jordan_wigner_representation

## 対象

**対象ラベル**: `global_spin_flip_jordan_wigner_representation`

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
- 範囲: `ε=i^M(Z_1Y_1)⋯(Z_MY_M)` の二次行列計算、二つの有限帰納法、終端の係数計算
- 帰属: 全成分を Gaussian 有理数体 `QQ(i)` 上で扱い、浮動小数点と `RR` / `CC` は使わない

## チェック一覧

本文の各等号を一ファイル一等号で検算する。各ファイルは `M=1,…,5`、サイトまたは接頭積を
含む場合はその全範囲を検査する。

| ファイル | 検査内容 | ステータス |
|---|---|---|
| `check_pauli_definition.sage` | `σ^zσ^y` を定義行列の積へ展開 | **PASS** |
| `check_pauli_matrix_product.sage` | 二次行列の積を成分ごとに計算 | **PASS** |
| `check_pauli_scalar_factor.sage` | 積の結果からスカラー `-i` を取り出す | **PASS** |
| `check_pauli_zy.sage` | 残った行列を `σ^x` と同定 | **PASS** |
| `check_sigma_prefix_base_definition.sage` | `P_0=I` | **PASS** |
| `check_sigma_prefix_base_kronecker.sage` | 単位行列の全因子表示 | **PASS** |
| `check_sigma_prefix_kronecker_representation.sage` | `P_r` のクロネッカー積表示（`M=1,\dots,5`、全 `0\leq r\leq M`） | **PASS** |
| `check_sigma_prefix_step_definition.sage` | `P_{r+1}` の定義 | **PASS** |
| `check_sigma_prefix_step_hypothesis.sage` | 第一帰納法の仮定の代入 | **PASS** |
| `check_sigma_prefix_step_site_expansion.sage` | サイト行列の展開 | **PASS** |
| `check_sigma_prefix_step_factorwise_product.sage` | 因子ごとの積 | **PASS** |
| `check_sigma_prefix_step_identity.sage` | 単位因子の簡約 | **PASS** |
| `check_z_definition.sage` | `Z_m` の定義 | **PASS** |
| `check_z_prefix_substitution.sage` | `P_{m-1}` 表示の代入 | **PASS** |
| `check_z_site_expansion.sage` | `σ_m^z` の展開 | **PASS** |
| `check_z_factorwise_product.sage` | `Z_m` の因子ごとの積 | **PASS** |
| `check_z_identity.sage` | `Z_m` の単位因子の簡約 | **PASS** |
| `check_y_definition.sage` | `Y_m` の定義 | **PASS** |
| `check_y_prefix_substitution.sage` | `P_{m-1}` 表示の代入 | **PASS** |
| `check_y_site_expansion.sage` | `σ_m^y` の展開 | **PASS** |
| `check_y_factorwise_product.sage` | `Y_m` の因子ごとの積 | **PASS** |
| `check_y_identity.sage` | `Y_m` の単位因子の簡約 | **PASS** |
| `check_pair_use_derived_expansions.sage` | 導出済み `Z_m,Y_m` 表示の代入 | **PASS** |
| `check_pair_factorwise_product.sage` | `Z_mY_m` の因子ごとの積 | **PASS** |
| `check_pair_sigma_x_square.sage` | `(σ^x)^2=I` の代入 | **PASS** |
| `check_pair_identity_square.sage` | `I^2=I` の代入 | **PASS** |
| `check_pair_pauli_substitution.sage` | `σ^zσ^y=-iσ^x` の代入 | **PASS** |
| `check_pair_extract_scalar.sage` | `-i` のクロネッカー積外への移動 | **PASS** |
| `check_pair_site_definition.sage` | サイト行列 `σ_m^x` への同定 | **PASS** |
| `check_pair_prefix_base_definition.sage` | `Q_0=I` | **PASS** |
| `check_pair_prefix_base_scalar_power.sage` | `I=(-i)^0I` | **PASS** |
| `check_pair_prefix_base_sigma_prefix.sage` | `(-i)^0I=(-i)^0P_0` | **PASS** |
| `check_pair_prefix_step_definition.sage` | `Q_{r+1}` の定義 | **PASS** |
| `check_pair_prefix_step_hypothesis.sage` | 第二帰納法の仮定の代入 | **PASS** |
| `check_pair_prefix_step_local_product.sage` | `Z_{r+1}Y_{r+1}` の局所積の代入 | **PASS** |
| `check_pair_prefix_step_left_scalar.sage` | 左側のスカラー倍と行列積の両立 | **PASS** |
| `check_pair_prefix_step_right_scalar.sage` | 右側のスカラー倍と行列積の両立 | **PASS** |
| `check_pair_prefix_step_scalar_product.sage` | 二つのスカラー倍の結合 | **PASS** |
| `check_pair_prefix_step_power.sage` | `(-i)` の冪の再帰 | **PASS** |
| `check_pair_prefix_step_sigma_prefix.sage` | `P_{r+1}` の定義の代入 | **PASS** |
| `check_final_pair_prefix_definition.sage` | `Q_M` の定義 | **PASS** |
| `check_final_induction_terminal.sage` | 第二帰納法の終端 | **PASS** |
| `check_final_power_product.sage` | 二つの冪の積 | **PASS** |
| `check_final_i_product.sage` | `i(-i)=1` | **PASS** |
| `check_final_one_power.sage` | `1^M=1` | **PASS** |
| `check_final_sigma_product_definition.sage` | `P_M` の定義 | **PASS** |
| `check_final_epsilon_definition.sage` | `ε` の定義 | **PASS** |

以上47等号は有限例のプログラミングによる検算であり、一般の `M` に対する証明は Lean の
`zyPrefixProduct_eq_neg_i_pow_smul_xString` と `epsilon_eq_i_pow_smul_zyPrefixProduct` が
本文の有限帰納法に対応して担う。必要十分版は
`NecSuf.prefix_eq_pow_smul_of_local_smul` であり、具体版がその特殊化であることも Lean で示す。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh global_spin_flip_jordan_wigner_representation
```

実行ログは `sagemath/check/global_spin_flip_jordan_wigner_representation/logs/` に保存する。
