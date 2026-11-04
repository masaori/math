# SageMath Check: V_plus_is_positive_definite

## 対象

**対象ラベル**: `V_plus_is_positive_definite`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_008_claim_V_plus_is_positive_definite`（V^{(+)} = ((2s_2)^{M_col/2})_ℂ exp((1/2)S_1^{(+)}) exp(S_2) exp((1/2)S_1^{(+)}) と書け、正定値）
- 範囲: 証明の Step 1（二つの鎖と最後の段落）、Step 2（各因子の性質）、Step 3（鎖と最後の段落）の全ての行と、主張そのもの。
- 記号: S_1^{(+)} := i(K_1)_ℂH_1^{(+)}、S_2 := i(K_2^*)_ℂH_2、B := exp((1/2)S_1^{(+)})、B' := exp(−(1/2)S_1^{(+)})、A := exp(S_2)、
  c := (2s_2)^{M_col/2}。H_1^{(+)}・H_2・Z_m・Y_m・V_2 の成分は共有の準備 `sagemath/_shared/transfer_matrix_factor_inverses.sage`
  （その先の `pauli_sites_exact.sage`・`row_configurations.sage`）から読み込む。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| Step 1 の (V_1^{(+)})^{1/2} の鎖の 9 行（`def_V1_plus_square_root`、K_1 の包含（`inclusion_rr_to_cc`）、i/2 = i·2_ℂ^{-1} の読み、`real_inclusion_of_one_half_is_inverse_of_two`、ℂ の積の交換律、結合律、`scalar_multiple_is_associative`、S_1^{(+)} = i(K_1)_ℂH_1^{(+)}、主張の略記） | `check_exact_chain_and_positivity.sage` (a) | 読み・`real_inclusion_of_one_half_is_inverse_of_two`・交換律・結合律・`scalar_multiple_is_associative` の 5 行の肩の等号を `KG[K_1]`（K_1 は実の不定元）で一行ずつ厳密に。1 行目（`def_V1_plus_square_root` の定義を書く行）、2 行目（定義の読みと K_1 の包含）、S_1^{(+)} の置き方と主張の略記の行は、定義・不定元の K_1・同じ式 S1 を書くだけで確かめる中身が無いので比べない。読み・`real_inclusion_of_one_half_is_inverse_of_two`・交換律・結合律の 4 行は可換な多項式環で同じ元を比べるので（2 の逆元と 1/2 も同じ元）、式の書き間違いだけを捕まえる検算である。exp は等しい肩に同じ値を返す |
| Step 1 の V_2 の鎖の 1 行目（`V2_exponential_representation`） | `check_exact_chain_and_positivity.sage` (b)、`check_balls_by_partial_sums.sage` | V_2（`def_transfer_matrix` の成分）= c·exp(iK_2^*H_2) を AA で厳密に、とボールで |
| Step 1 の V_2 の鎖の 2〜4 行目（係数の包含、K_2^* の包含、S_2 = i(K_2^*)_ℂH_2） | なし | 包含と S_2 の定義を書くだけの行で、確かめる中身が無いので比べない（1 行目の V_2 = c·exp(iK_2^*H_2) は上の行で確かめる） |
| Step 1 の最後の鎖の 4 行（`def_V_plus`、上の二つの鎖の代入、`scalar_multiple_factors_out_of_right_factor`、`scalar_multiple_factors_out_of_left_factor`）と続く括弧の省略（`mat_mult_associative`） | `check_exact_chain_and_positivity.sage` (b)、`check_balls_by_partial_sums.sage` | (BV_2)B → (B(cA))B → (c(BA))B → c((BA)B) の 3 段を厳密に、とボールで |
| Step 2 の S_1^{(+)} は実対称（`iH_is_real_symmetric`）、よってエルミート（`real_symmetric_matrix_is_hermitian`） | `check_exact_chain_and_positivity.sage` (a) | 成分の係数の虚部が 0、転置で不変、共役転置で不変を `KG[K_1, K_2^*]` で厳密に |
| Step 2 の S_2 は実対称（`iH_is_real_symmetric`）、よってエルミート（`real_symmetric_matrix_is_hermitian`、A → S_2）と、(1/2)S_1^{(+)} はエルミート（`real_multiple_of_hermitian_is_hermitian`） | `check_exact_chain_and_positivity.sage` (a) | 厳密 |
| Step 2 の B は正定値（とくにエルミート）、B'B = I、A は正定値（`exp_hermitian_is_positive_definite`、`exp_of_negative_is_left_inverse`） | 両方 | 厳密版は B^* = B・B'B = I を AA の等号で、正定値性を下の二つの判定で。ボール版は重なりと首座小行列式 |
| Step 3 の鎖の 3 行（Step 1 の最後の鎖、`mat_mult_associative`、B^* = B（`def_hermitian_positive_definite`）） | 両方 | V^{(+)} = c((BA)B) = c(B(AB)) = c(B^*(AB)) を AA で一行ずつ厳密に、とボールで |
| Step 3 の残りの行（B^*(AB) は正定値（`congruence_preserves_positive_definite`）、(2s_2)^{M_col/2} = (2 sinh 2K_2)^{M_col/2} ∈ ℝ_{>0}（`def_indexed_hyperbolic_abbreviations`・`def_second_transfer_matrix_prefactor`）、V^{(+)} = c(B^*(AB)) は正定値（`positive_real_multiple_preserves_positive_definite`）） | 両方 | s_2 > 0・c > 0 は AA（厳密版）と球の全体（ボール版）、正定値性は下の判定 |
| 主張そのもの（表示と正定値性） | 両方 | `def_V_plus` から作った V^{(+)} が c·exp((1/2)S_1)exp(S_2)exp((1/2)S_1) に等しく、正定値。具体の x で x^*V^{(+)}x ∈ ℝ_{>0}（厳密版は QQbar で 3 本、ボール版は 2 本） |

正定値性の判定（`def_hermitian_positive_definite` の「エルミートで、∀x ≠ 0 で x^*Ax ∈ ℝ_{>0}」）: 厳密版は共役転置の等号でエルミート性を確かめ、
(1) 首座小行列式が全て正（Sylvester の判定法）と (2) 特性多項式 det(tI − A) の係数の符号が厳密に交代する（エルミート行列の固有値は実なので根が全て正と同値）の
二つを AA で求め、一致することも確かめる（`_prelude.sage` の `is_positive_definite_exact`）。二つの判定法は本文には無い独立な経路である。
ボール版は B^* と B のボールの重なりと、首座小行列式のボールの実部が正・虚部が 0 を含むことで見る（エルミート性がちょうど成り立つことは厳密版が受け持つ）。

否定コントロール:
- (a): i を掛けない H_1^{(+)} はエルミートでない（M_col = 2..5）。肩の 1/2 を落とした (iK_1)H_1^{(+)} は (1/2)S_1^{(+)} と外れる（M_col = 2..5）。
- (b) と ボール版: 肩の K_2^* を K_2 に替えた exp(iK_2H_2) では V_2 = c·exp(·) が外れる。係数を c^2 = (2s_2)^{M_col} にすると V^{(+)} と外れる。
  exp((1/2)S_1) を左右に置かずに exp(S_1)exp(S_2) = BBA とすると外れる。B^*(−A)B は正定値でない（ボール版では首座小行列式の実部が全体として負）。
  BA（合同でない積）はエルミートでない（厳密版）。A − λI（λ は A の最小と 2 番目に小さい固有値の間の有理数）を合同で移した B^*(A − λI)B は
  エルミートだが不定値で、二つの判定がどちらも正定値でないと判定する（厳密版。首座小行列式の後ろの段で落ちる場合を含む）。

構成上かならず一致する比較（写し間違いの検出だけに効く）:
- 厳密版の Step 1 の最後の鎖のスカラーの移動 2 段（`scalar_multiple_factors_out_of_right_factor`・`..._left_factor`）と Step 3 の結合律 (B^*A)B = B^*(AB) は、
  AA の成分の計算規則だけで必ず成り立つ。
- 厳密版の B'B = I は、B・B' を同じ射影の和 Σ_λ y^{±λ}P_λ で作るので必ず成り立つ。def_exp の部分和を通した独立な確認はボール版が受け持つ。
- 厳密版の B^* = B は、B が QQ の対称行列の多項式であることから必ず成り立つ（中身はエルミート性の判定の前提として効く）。

## 計算の帰属と範囲

- `check_exact_chain_and_positivity.sage`: (a) は `KG = QQ(i)` 上の実の不定元 K_1・K_2^* の多項式環で、任意の実数の結合定数で成り立つ形（M_col = 2..5）。
  (b) は K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3}、M_col = 2..4）と選び、B = Σ_λ y^λ P_λ（iH_1^{(+)} の固有値 λ の射影）を QQ に、
  A = Σ_λ (√t)^{−λ}P_λ（t = tanh K_2 = (x^2−1)/(x^2+1)）と c = (√(2s_2))^{M_col}（s_2 = (x^2 − x^{−2})/2）を AA に、V_2 を成分 x^n で QQ に作る。
  **ℝ への脱出は K_1・K_2 の選び方の一点だけ**で、以後の等号・不等号は全て AA の厳密計算である。exp の値は def_exp の級数ではなく固有値の射影から作る（独立な経路）。
- `check_balls_by_partial_sums.sage`: K_1 ∈ {1/4, 1/2}、K_2^* ∈ {1/3, 1/2}（有理数）、M_col = 2..4。K_2 := artanh(u)（u := exp(−2K_2^*)）とすると
  `def_second_dual_coupling_constant` の K_2^* = −(1/2)log tanh K_2 を満たし、exp(K_2 n) = ((1+u)/(1−u))^{n/2}、s_2 = 2u/(1−u^2)。
  exp は def_exp の部分和（`KG` で厳密）に尾の上界を各成分の半径として足した 256 ビットのボールで、Sage の exp とも重なることを確かめる（ℝ への脱出: exp の極限）。
  許容誤差は置かず、等号はボールの重なり、不等号はボールの全体で判定する。
- 範囲外: M_col ≥ 6（(a)）、M_col ≥ 5（(b) とボール版）。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_exact_chain_and_positivity.sage` | (a) 肩の書き換えとエルミート性、(b) Step 1〜3 の行と主張を AA で | **PASS** | 等号 146 個（(a) 44、(b) 102）、正定値性の判定（各 M_col・x・y で A・B・B^*(AB)・V^{(+)}）、否定コントロール 74 件 |
| `check_balls_by_partial_sums.sage` | 同じ行を def_exp の部分和のボールで | **PASS** | 重なりを確かめた行 90 個、否定コントロール 42 件 |

人手証明の計算の誤りは見つからなかった。レビューの指摘で人手証明の根拠を三か所直した（Step 1 の最後の段落を、`scalar_identity_commutes`（[cI, A] = O）では出ない B(cA) = c(BA)・(cX)B = c(XB) を `scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_factors_out_of_left_factor` で引く鎖に。Step 2 の S_2 のエルミート性を、実係数倍ではなく `iH_is_real_symmetric` と `real_symmetric_matrix_is_hermitian` で。Step 3 の (2s_2)^{M_col/2} > 0 に `def_second_transfer_matrix_prefactor` を引いた）。主張は変えていない。

2026-11-04（Lean の通しの証明のゴールラインの確認）に、人手の Step 1 の (V_1^{(+)})^{1/2} の鎖の「S_1^{(+)} = iK_1H_1^{(+)}」の 1 行を、包含・i/2 = i·2_ℂ^{-1} の読み・`real_inclusion_of_one_half_is_inverse_of_two`・交換律・結合律・`scalar_multiple_is_associative`・S_1^{(+)} の置き方・主張の略記の 8 行に分けたので、(a) の肩の等号 1 個を、確かめる中身のある 5 行の等号 5 個に置き換え（M_col ごと）、否定コントロールを 1 件足した。Step 3 は鎖 c((BA)B) = c(B(AB)) = c(B^*(AB)) と係数の行 (2s_2)^{M_col/2} = (2 sinh 2K_2)^{M_col/2} ∈ ℝ_{>0} に書き直した（いずれも (b) の等号・不等号が受け持つ）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh V_plus_is_positive_definite
```

実行ログは `logs/` に保存する。
