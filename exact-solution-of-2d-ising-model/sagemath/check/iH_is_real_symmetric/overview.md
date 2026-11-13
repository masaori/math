# SageMath Check: iH_is_real_symmetric

## 対象

**対象ラベル**: `iH_is_real_symmetric`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `eigenvalues_of_V_014_claim_iH_is_real_symmetric`（`S_1^{(+)} := i(K_1)_ℂH_1^{(+)}` と `S_2 := i(K_2^*)_ℂH_2` は実対称で、エルミート）
- 範囲: 主張の 2 つの表示と、証明の Step 0〜Step 3 の全ての鎖と段落

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| Step 0 の準備の 2 本と 2×2 の積の 3 本の鎖 | `check_step0_pauli_product_chains.sage` | `iH_is_real_symmetric` の Step 0 の準備 `(-i)·i = 1`（4 行）・`(-i)·(-i) = -1`（6 行）と、2×2 の積の鎖 `σ^zσ^y = (-i)σ^x`（11 行）・`σ^yσ^x = (-i)σ^z`（12 行）・`σ^xσ^z = (-i)σ^y`（11 行）を 1 行ずつ（`mat_mult`・`def_matrix_scalar_multiple` は成分の式どおりに組み Sage の演算とも比べる）。否定コントロール: スカラーの符号を取り違えた 3 本と、準備の符号を取り違えた 2 本は一致しない | PASS | `QQ(i)` で厳密等号（44 段、否定コントロール 5 件） |
| Step 1 の準備（(k) と `Z_m`・`Y_m` の表示）と `Z_mY_m` の 8 行 | `check_step1_ZY_kronecker_chain.sage` | `iH_is_real_symmetric` の Step 1 の準備（(k) の `F_j^{(z)} = σ_j^{a_j^{(z)}}`・`F_j^{(y)} = σ_j^{a_j^{(y)}}` の全ての `j` と、`Z_m`・`Y_m` の各 4 行: `def_jordan_wigner_Z_matrices`・`def_jordan_wigner_Y_matrices` の有限積 `Π F_j`（`def_finite_product_of_matrices` どおり左から掛ける）→ (k) → `site_pauli_prefix_product_kronecker_form` → `a_j` の定義）と、`Z_mY_m` の 8 行（準備の `Z_m`・`Y_m` の表示・`kronecker_product_rule` (1)・`σ^xσ^x = I`・`identity_matrix_is_left_unit_of_mat_mult`・Step 0 の `σ^zσ^y = (-i)σ^x`・`kronecker_multilinear`・`def_site_pauli_matrices`）を、`M_col = 1..5` の全ての `m` で `QQ[i]` の厳密等号で一行ずつ。各行は本文の字面どおりの 2×2 の因子の並びのクロネッカー積として組む。否定コントロール: スカラーを `i` に替えると偽、`σ^x` を置くサイトを替えると偽（`M_col ≥ 2`）、第 `m` 因子の文字を `y` に取り違えた並びは `Z_m` と違う。準備の `Z_m` の表示の行と鎖の 1 行目は Sage の中では同じ行列なので、写し間違いの検出だけに効く | **PASS** | 280 段、否定コントロール 3 種 |
| Step 1 の `H_2`（3 行）・`S_2`（8 行）と Step 2 の `S_1^{(+)}`（13 行）の鎖、主張の 2 つの表示 | `check_step1_step2_scalar_chains.sage` | `iH_is_real_symmetric` の Step 1 の `H_2` の 3 行（`def_H2`・上で得た `Z_mY_m`・`finite_sum_of_scalar_multiples`）と `S_2` の 8 行（`S_2` の定義・`H_2` の表示・`scalar_multiple_is_associative`・ℂ の積の結合律・交換律・結合律・`i(-i) = 1`・乗法の単位元）、Step 2 の `S_1^{(+)}` の 13 行（`def_H1_plus`・上で得た `Y_mZ_{m+1}` を各項へ・上で得た `Y_{M_col}Z_1`・`finite_sum_of_scalar_multiples`・`scalar_multiple_distributes_over_matrix_difference` を右辺から左辺へ・`scalar_multiple_is_associative`・ℂ の積の 3 行・`i(-i) = 1`・乗法の単位元・`scalar_multiple_distributes_over_matrix_difference`）を一行ずつ。スカラー倍・和・差・有限和は本文の定義どおり成分から組む。ℂ の積の結合律・交換律・単位元の行は、成分を可換な多項式環に置くので構成上かならず一致し、写し間違いは検出できない。否定コントロールとして、境界項の符号を取り違えた `K_1Σσ^zσ^z + K_1G` とは一致しないことを確かめる | **PASS** | 成分は `QQ(i)[K_1, K_2^*]`（不定元）で厳密等号、`M = 2, 3, 4, 5` |
| Step 2 の準備（`Y_m`・`Z_{m+1}`・`σ_m^zσ_{m+1}^z` の表示）と `Y_mZ_{m+1}` の 9 行 | `check_step2_YZ_kronecker_chain.sage` | `iH_is_real_symmetric` の Step 2 の準備（`Y_m`・`Z_{m+1}` を Step 1 の準備の表示（`m → m`・`m+1`）で引く各 1 段。左辺は `def_jordan_wigner_Y_matrices`・`def_jordan_wigner_Z_matrices` の有限積で組む。と、`σ_m^zσ_{m+1}^z` の 6 行（`def_site_pauli_matrices` 2 回・`kronecker_product_rule` (1)・`identity_matrix_is_right_unit_of_mat_mult`・`identity_matrix_is_left_unit_of_mat_mult` 2 回））と、`Y_mZ_{m+1}` の 9 行（準備の `Y_m`・`Z_{m+1}` の表示・`kronecker_product_rule` (1)・`σ^xσ^x = I`・`identity_matrix_is_left_unit_of_mat_mult` 2 回・Step 0 の `σ^yσ^x = (-i)σ^z`・`kronecker_multilinear`・準備の `σ_m^zσ_{m+1}^z` の表示）を、`M_col = 2..6` の全ての `m ∈ {1,…,M_col-1}` で `QQ[i]` の厳密等号で一行ずつ。各行は本文の字面どおりの 2×2 の因子の並びのクロネッカー積として組む。否定コントロール: スカラーを `i` に替えると偽、`σ^z` を置く 2 サイトを 1 つずらすと偽（`M_col ≥ 3`）。鎖の 1・2 行目と 2・3 行目の比較は、準備の `Y_m`・`Z_{m+1}` の比較と同じ等式をもう一度確かめる | **PASS** | 255 段、否定コントロール 29 件 |
| Step 2 の境界項の準備（`Y_{M_col}`・`Z_1`・(kG)・`G` の表示）と `Y_{M_col}Z_1` の 8 行 | `check_step2_boundary_YZ_kronecker_chain.sage` | `iH_is_real_symmetric` の Step 2 の境界項の準備（`Y_{M_col}`・`Z_1` の各 2 行（Step 1 の準備の表示を `m → M_col`・`1` で引く行と、第 1・最後の因子を分けて書く行）、(kG) の `F_j^{(G)} = σ_j^{a_j^{(G)}}` の全ての `j`、`G` の 4 行（主張の `G` の定義の有限積 `Π F_j^{(G)}` → (kG) → `site_pauli_prefix_product_kronecker_form` → `a_j^{(G)}` の定義））と、`Y_{M_col}Z_1` の 8 行（準備の `Y_{M_col}`・`Z_1` の表示・`kronecker_product_rule` (1)・`identity_matrix_is_right_unit_of_mat_mult` 2 回（`A → σ^x`・`A → σ^y`）・Step 0 の `σ^xσ^z = (-i)σ^y`・`kronecker_multilinear`・準備の `G` の表示）を、`M_col = 2..7` で `QQ[i]` の厳密等号で一行ずつ。各行は本文の字面どおりの 2×2 の因子の並びのクロネッカー積として組む。否定コントロール: スカラーを `i` に替えると偽、第 1 因子の `σ^y` を `σ^x` に替えると偽（`Y_{M_col}Z_1` と、`a_1^{(G)}` を取り違えた `G` の並びの 2 か所）。Sage は行列の積をその場で計算するので、鎖の左辺 `Y_{M_col}Z_1` を 1 行目と数えて 4・5 行目と 5・6 行目（`identity_matrix_is_right_unit_of_mat_mult` の 2 行）の比較は構成上かならず一致し、写し間違いの検出だけに効く。鎖の 1・2 行目と 2・3 行目の比較は、準備の `Y_{M_col}`・`Z_1` の比較と同じ等式をもう一度確かめる | **PASS** | 117 段、否定コントロール 18 件 |
| Step 3 の転置の 3 本の鎖（`(σ_m^x)^⊤`・`(σ_m^zσ_{m+1}^z)^⊤`・`G^⊤`） | `check_step3_transpose_chains.sage` | `iH_is_real_symmetric` の Step 3 の転置の 3 本の鎖を、`M_col = 2..7` で `QQ[i]` の厳密等号で一行ずつ。`(σ_m^x)^⊤ = σ_m^x` の 5 行（`def_site_pauli_matrices`・`kronecker_transpose`・`transpose_of_identity_matrix_of_order_two`・`transpose_of_pauli_x`・`def_site_pauli_matrices`。全ての `m ∈ {1,…,M_col}`）、`(σ_m^zσ_{m+1}^z)^⊤ = σ_m^zσ_{m+1}^z` の 5 行（Step 2 の準備の表示・`kronecker_transpose`・`transpose_of_identity_matrix_of_order_two`・`transpose_of_pauli_z`・準備の表示。全ての `m ∈ {1,…,M_col-1}`）、`G^⊤ = G` の 11 行（準備の表示・`kronecker_transpose`・`transpose_of_pauli_x`・`transpose_of_pauli_y`・`negation_is_scalar_multiple_by_minus_one`・`kronecker_multilinear` 2 回・`scalar_multiple_is_associative`・`(-1)(-1) = 1`・`scalar_multiple_by_one`・準備の表示）。左辺の行列は本文の定義（サイト行列とその左から掛けた積）で組み、各行は本文の字面どおりの 2×2 の因子の並びのクロネッカー積として組む。否定コントロール: 第 `m+1` 因子を `I` に替えた行列は `σ_m^zσ_{m+1}^z` と違う、`σ^y` が 1 個だけの因子の並びは転置で `-1` 倍になり対称でない、`σ_1^y` は転置で符号が変わる。Sage は転置と積をその場で計算するので、因子ごとの転置を付けたままの行とそれを外した行の比較は、引いた 2×2 の主張の両端を確かめたことと同じである | **PASS** | 306 段、否定コントロール 33 件 |
| Step 3 の `σ_m^x`・`σ_m^zσ_{m+1}^z` の成分の実性の 2 段落 | `check_step3_real_entries.sage` | `iH_is_real_symmetric` の Step 3 の成分の実性のうち `σ_m^x`・`σ_m^zσ_{m+1}^z` の 2 段落を、`M_col = 2..7` で `QQ[i]` の厳密計算で。本文の定義で組んだ行列が段落の因子の並び（`def_site_pauli_matrices`・Step 2 の準備の表示）のクロネッカー積に等しいこと、因子 `I`・`σ^x`・`σ^z` の成分が `ι(r)`（`identity_matrix_of_order_two_has_real_entries`・`pauli_x_has_real_entries`・`pauli_z_has_real_entries`）であること、積の全成分が `r := ∏_k r_k` の `ι(r)` であること（`kronecker_of_real_entry_matrices_has_real_entries` の結論）。否定コントロール: `σ_1^y` は虚部 0 でない成分を持つ | **PASS** | 48 個の行列、否定コントロール 6 件 |
| Step 3 の `G` の成分の実性の 7 行の鎖と続く段落 | `check_step3_G_real_entries.sage` | `iH_is_real_symmetric` の Step 3 の `G` の成分の実性の 7 行の鎖（Step 2 の準備の `G` の表示 → `pauli_y_is_i_times_real_factor` → `kronecker_multilinear` 2 回 → `scalar_multiple_is_associative` → `i·i = -1` → `inclusion_rr_to_cc` の略記）を、`M_col = 2..7` で `QQ[i]` の厳密計算で一行ずつ。1 行目の左辺は主張の定義どおり `σ_1^yσ_2^x⋯σ_{M_col-1}^xσ_{M_col}^y` を左から掛けて組む。続く段落の `R^y`・`σ^x`・`R^y⊠σ^x⊠⋯⊠σ^x⊠R^y`・`(-1)_ℂ` 倍・`G` の全成分の虚部が 0 であること。否定コントロール: `σ^y` を第 1 因子だけに置いた並びは虚部 0 でない成分を持つ | **PASS** | 42 段、否定コントロール 6 件 |
| Step 3 の `(S_2)^⊤`（5 行）・`(S_1^{(+)})^⊤`（7 行）の鎖 | `check_step3_S_transpose_chains.sage` | `iH_is_real_symmetric` の Step 3 の `(S_2)^⊤ = S_2` の 5 行（Step 1 の表示 → `transpose_of_matrix_scalar_multiple` → `transpose_of_finite_sum_of_matrices` → `(σ_m^x)^⊤ = σ_m^x` を各項へ → Step 1 の表示）と `(S_1^{(+)})^⊤ = S_1^{(+)}` の 7 行（Step 2 の表示 → `transpose_of_matrix_difference` → `transpose_of_matrix_scalar_multiple` を 2 箇所 → `transpose_of_finite_sum_of_matrices` → `(σ_m^zσ_{m+1}^z)^⊤` を各項へ → `G^⊤ = G` → Step 2 の表示）の鎖を、`M_col = 2..7` で、係数 `K_1`・`K_2^*` を `QQ[i]` 上の不定元にした厳密計算で一行ずつ。1 行目の `S_2`・`S_1^{(+)}` は `iK_2^*H_2`・`iK_1H_1^{(+)}`（Jordan–Wigner の `Z_m`・`Y_m` から組む）とし、Step 1・Step 2 の表示と一致することも確かめる。否定コントロール: 鎖の `G^⊤ = G` の行の `-K_1G` を `+K_1G` に壊すと一致しない（`M_col` ごと）、「`(σ_m^zσ_{m+1}^z)^⊤` を各項へ」の行は、転置で不変でない項 `σ_1^yσ_2^z`（`σ^y` が 1 個だけ）を和に混ぜると前後が一致しない（`M_col = 3`） | **PASS** | 72 段、否定コントロール 7 件 |
| Step 3 の `S_2`・`S_1^{(+)}` の成分の実性の 2 段落 | `check_step3_S_real_entries.sage` | `iH_is_real_symmetric` の Step 3 の最後の 2 段落（`σ_m^x` の成分が実 → `finite_sum_of_real_entry_matrices_has_real_entries`（`r → M_col`） → Step 1 の表示と `real_scalar_multiple_of_real_entry_matrix_has_real_entries`（`c → K_2^*`）で `S_2`。`σ_m^zσ_{m+1}^z` の成分が実 → 有限和（`r → M_col−1`） → `real_scalar_multiple_of_real_entry_matrix_has_real_entries`（`c → K_1`、`B → Σσ^zσ^z` と `B → G`） → Step 2 の表示と `difference_of_real_entry_matrices_has_real_entries` で `S_1^{(+)}`）の各項の成分の実性を、`M_col = 2..7` で、係数 `K_1`・`K_2^*` を `QQ` 上の不定元（実数の代表）にして `QQ[i]` 係数の多項式環の厳密計算で。`S_2`・`S_1^{(+)}` は `iK_2^*H_2`・`iK_1H_1^{(+)}` から組み、Step 1・Step 2 の表示と一致することも確かめる。否定コントロール: `i` を掛けない `H_2`・`H_1^{(+)}` は成分が実でない（`M_col` ごと） | **PASS** | 66 項、否定コントロール 6 件 |
| Step 3 の最後の文（実対称、よってエルミート）と主張の結論 | `check_step3_hermitian.sage` | `iH_is_real_symmetric` の Step 3 の最後の文（`S_2`・`S_1^{(+)}` は成分が実で転置について対称なので実対称（`def_real_symmetric_complex_matrix`）、`real_symmetric_matrix_is_hermitian`（`n → 2^{M_col}`、`A → S_1^{(+)}` と `A → S_2`）よりエルミート）を、`M_col = 2..7` で、係数 `K_1`・`K_2^*` を `QQ` 上の不定元（実数の代表）にして `QQ[i]` 係数の多項式環の厳密計算で。共役転置は係数の共役と転置で組む。否定コントロール: `i` を掛けない `H_2` は転置で対称だが成分が実でなく、エルミートでない（`M_col` ごと） | **PASS** | 36 項、否定コントロール 6 件 |

確かめていない行: Step 0 の最後の段落（`pauli_matrix_products` の `σ^xσ^x = I` を述べるだけで、計算を含まない。`σ^xσ^x = I` は Step 1・Step 2 の鎖の検算の中で使われ、その行の両辺の一致として確かめている）。

## 計算の帰属と範囲

- **厳密**: 全てのファイルが `QQ(i)`（ガウス有理数体）またはそれを係数とする多項式環の上の厳密等号で確かめる。係数 `K_1`・`K_2^*` は不定元（実数の代表）で、不定元で成り立つ等号は任意の実数を代入しても成り立つ。浮動小数点と ℝ/ℂ への脱出はない。
- 範囲: `M_col` はファイルごとに表の範囲（`1..5` から `2..7`）。主張は全ての `M_col ≥ 2` についてのものなので、有限個の `M_col` での確認である。
- 構成上かならず一致する比較（ℂ の積の結合律・交換律・単位元の行、Sage が積をその場で計算する行）は各ファイルの冒頭と表に書いた。写し間違いの検出だけに効き、中身は否定コントロールが確かめる。
- (k)・(kG) の比較（`F_j` と `σ_j^{a_j}`）は、両辺を同じサイト行列から組むので構成上かならず一致し、`a_j` の定義の写し間違いの検出だけに効く。中身は、文字を取り違えた並びが一致しない否定コントロールが確かめる。
- このほかに構成上かならず一致する比較: `Z_mY_m`・`Y_mZ_{m+1}`・`σ_m^zσ_{m+1}^z` の鎖で `II → I`・`Iσ^z → σ^z`・`σ^zI → σ^z` を因子へ当てる行（`identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult` の行。Sage は因子の積をその場で計算する）と、`H_2`・`S_2`・`S_1^{(+)}` の鎖の 1 行目から 2 行目への定義を書くだけの行（`def_H2`・`S` の定義・`def_H1_plus`。検算の左辺がその定義そのもの）。これらも写し間違いの検出だけに効く。

## 由来

この 11 本は、2026-11-02〜11-03 に `050_claim_even_sector_eigenvalues/` の `check_22`・`check_37`〜`check_46` として足したものを、2026-11-03 にこのディレクトリへ移した（中身は変えていない）。旧い記録（`MEMORY.md`・Lean の状態台帳）の「050 の check_37」などは、ここの同じ内容のファイルを指す。

| 旧い名前 | このディレクトリの名前 |
|---|---|
| `check_37_…` | `check_step0_pauli_product_chains.sage` |
| `check_38_…` | `check_step1_ZY_kronecker_chain.sage` |
| `check_22_…` | `check_step1_step2_scalar_chains.sage` |
| `check_39_…` | `check_step2_YZ_kronecker_chain.sage` |
| `check_40_…` | `check_step2_boundary_YZ_kronecker_chain.sage` |
| `check_41_…` | `check_step3_transpose_chains.sage` |
| `check_42_…` | `check_step3_real_entries.sage` |
| `check_43_…` | `check_step3_G_real_entries.sage` |
| `check_44_…` | `check_step3_S_transpose_chains.sage` |
| `check_45_…` | `check_step3_S_real_entries.sage` |
| `check_46_…` | `check_step3_hermitian.sage` |

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh iH_is_real_symmetric
```

実行ログは `logs/` に保存する。
