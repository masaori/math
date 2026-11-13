# SageMath Check: H1_plus_in_sigma_z_form

## 対象

**対象ラベル**: `H1_plus_in_sigma_z_form`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_004_claim_H1_plus_in_sigma_z_form`（M_col ∈ ℤ_{≥2} について iH_1^{(+)} = D_0 + εG。D_0 = Σ_{m=1}^{M_col−1} σ_m^zσ_{m+1}^z、G = σ_{M_col}^zσ_1^z）
- 範囲: 証明の準備 1〜4 と最後の鎖の全ての行と、主張そのもの。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| 準備 1 の (k)（F_j^{(z)} = σ_j^{a_j^{(z)}}、F_j^{(y)} = σ_j^{a_j^{(y)}} の各 2 行） | `check_chain.sage` | 厳密（QQ(i)） |
| 準備 1 の Z_m・Y_m の表示の各 4 行（def_jordan_wigner_Z/Y_matrices の有限積、(k)、site_pauli_prefix_product_kronecker_form、a_j の定義。m ∈ {1,…,M_col}） | `check_chain.sage` | 厳密 |
| 準備 1 の Y_m・Z_{m+1} の各 1 行（準備 1 の表示を m ≤ M_col−1・m → m+1 で引く） | `check_chain.sage` | 厳密 |
| 準備 1 の σ_m^zσ_{m+1}^z の 4 行（def_site_pauli_matrices、kronecker_product_rule (1)、右単位、左単位） | `check_chain.sage` | 厳密 |
| 準備 2 の Y_M の 1 行（準備 1 の Y_m の表示を m → M）・Z_1 の 2 行、ε の 1 行、σ_M^zσ_1^z の 4 行 | `check_chain.sage` | 厳密 |
| 準備 3 の 11 行（i(Y_mZ_{m+1}) から σ_m^zσ_{m+1}^z まで） | `check_chain.sage` | 厳密 |
| 準備 4 の 17 行（−(i(Y_MZ_1)) から εG まで） | `check_chain.sage` | 厳密 |
| 最後の鎖の 7 行（iH_1^{(+)} から D_0 + εG まで） | `check_chain.sage` | 厳密 |
| 引いた 1 サイトの積 σ^yσ^x = (−i)σ^z・σ^xσ^z = (−i)σ^y | `../pauli_y_times_pauli_x/`・`../pauli_x_times_pauli_z/` | 厳密 |

各行は行に書かれた形のとおりに組む。サイトの積の行は def_site_pauli_matrices の σ_k^a を mat_mult の成分の式で左から掛けて、
「A_1⊠⋯⊠A_M」の行は def_kronecker (2) の成分の式で（Sage の tensor_product との一致も毎回確かめる）、因子の積 (AB) は 2 次の mat_mult で、
スカラー倍・和・有限和・符号反転・差は本文の定義の成分の式で組む。有限積 Π F_j は def_finite_product_of_matrices のとおり左から mat_mult で掛ける。スカラーの積 i·(−i)・(−1)·i は definition_of_cc の積を QQ の対で計算した値で組み、
−i は multiply_by_minus_one の (−1)·i で作る。M_col = 2..5、準備 1 の表示は全ての m ∈ {1,…,M_col}、準備 1 の残りと準備 3 は全ての m ∈ {1,…,M_col−1}。M_col = 2 では「M_col−2 個並べる」因子が無い場合も含む。

構成上一致する比較（行の組み方が同じ値を作るので、等号が検算として働かないもの）:

- 定義を開く段は、両辺を同じ因子の列や同じ積から組むので構成上一致する。準備 1 の表示の「Z_m」「Y_m」と「Π F_j」（`jw` は `prefix_product` を返す）、(k) の各行と「Π F_j」と「Π σ_j^{a_j}」（同じ `site` の列）、「σ^{a_1}⊠…」と a_j の定義を開いた行（同じ因子の列）、準備 2 の「Z_1」の 1 段目、準備 2 の「σ_1^z」と「σ^z⊠I…」（`site` は同じ因子の列を `kron` で組む）、準備 1 の σ_m^zσ_{m+1}^z と準備 2 の σ_M^zσ_1^z の 1 段目（def_site_pauli_matrices を開く段）、最後の鎖の「iH_1^{(+)}」と「i(ΣY_mZ_{m+1} − Y_MZ_1)」（`H1_plus` は同じ式）。これらの段の実際の検証は、`jw`・`epsilon`・`kron` の中で毎回行う Sage の経路（`tensor_product` と `*`）との assert が担う。
- 準備 2 の ε の行と ε の値は、`pauli_sites_exact.sage` の `epsilon` が prefix_product で組んだ値で、kron([σ^x]*M) との比較だけが検算である。
- 準備 3 の最後の 2 行（「I…σ^zσ^zI…」と σ_m^zσ_{m+1}^z）の比較は、準備 1 の σσ の鎖と同じ比較である（証明もその鎖を引く）。
- 準備 4 の「ε(σ_M^zσ_1^z)」と「εG」は def_G_boundary_operator で同じ式を組むので構成上一致する。
- 最後の鎖の「Σσ_m^zσ_{m+1}^z − …」と「D_0 − …」は def_D0_open_chain_operator で同じ式を組むので構成上一致する。

主張そのものは、Sage の tensor_product・`*`・`+` だけで組んだ独立な経路（iH = D_0 + ε(σ_M^zσ_1^z)）でも確かめ、本文の経路の iH・D_0 と一致することも見る。

否定コントロール（各 M_col で 4 件と、準備 1 の各 m で 1 件）: 第 m 因子の文字を y に取り違えた並びは Z_m と一致しない。ε を落とした D_0 + G、境界項の符号を + にした H_1、σ^yσ^x を (+i)σ^z に替えた準備 3 の行、
符号を落とした i(Y_MZ_1) = εG は、いずれも外れる。

浮動小数点は使わない。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | 準備 1〜4 と最後の鎖の全ての行、主張（M_col = 2..5） | 実行済み | PASS（等号・主張 486 件、否定コントロール 30 件） |

旧い浮動小数点の検算 `../053_claim_even_sector_closing/check_03` は対象ラベルを宣言していない（M = 2..5 で残差 0）。

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh H1_plus_in_sigma_z_form
```
