# SageMath Check: eigenvalues_of_inverse_of_check_Vprime

## 対象

**対象ラベル**: `eigenvalues_of_inverse_of_check_Vprime`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_claim_eigenvalues_of_inverse_of_check_Vprime`（ε ∈ {0,1}^{M̌} について (V̌')^{-1}Q̌_ε = (exp(−ǧ(ε)))_ℂ Q̌_ε。
  ǧ(ε) は `eigenvalues_of_check_Vprime`、Q̌_ε は `check_joint_eigenspace_decomposition`、(V̌')^{-1} は `def_check_Vprime` (2) の V̌' ∈ R^× の逆元）
- 範囲: 証明の 11 行の鎖の全ての行と、主張そのもの。
- 記号: X̌ := Σ_μ γ(θ̃_μ)(ň_μ − (1/2)I)、V̌' := exp(X̌)、Q̌_ε := Π_μ R_μ^{(ε_μ)}（R^{(1)} := ň_μ、R^{(0)} := I − ň_μ）、
  ǧ(ε) := Σ_μ γ(θ̃_μ)(ε_μ − 1/2)。

## ň_μ と γ_μ の供給元

ň_μ・γ_μ の作り方は `sagemath/check/eigenvalues_of_check_Vprime/_vprime_settings.sage`（ň_μ はその先の
`check_joint_eigenspace_decomposition/_number_operators.sage`）をそのまま読み込んで使う（複製しない）。

- **既定（Jordan–Wigner の模型）**: n_μ := c_μ^Tc_μ（`QQ`、M_col = 2, 3, 4）。鎖が ň_μ について使う性質は、引いた主張
  `eigenvalues_of_check_Vprime` の V̌'Q̌_ε = (exp ǧ(ε))_ℂQ̌_ε だけで、模型はこれを満たす。
- **本物の ψ̌（`check_with_check_psi.sage`）**: `USE_CHECK_PSI = True` と置いてから同じ検算を読み込む。ň_μ は本文の ψ̌ の ň_μ := ψ̌_μ^†ψ̌_{σ(μ)}
  （数体 F := E_1 の厳密な行列。結合定数 3 組 × M_col = 2, 3）。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| 1 行目 (V̌')^{-1}Q̌_ε = (V̌')^{-1}(1_ℂQ̌_ε)（`scalar_multiple_by_one`） | `check_chain.sage` | 厳密（成分の環の中の等号） |
| 2〜4 行目 1_ℂ → (exp 0)_ℂ → (exp(−ǧ+ǧ))_ℂ → (exp(−ǧ)exp ǧ)_ℂ（`scalar_exp_zero`・ℝ の −a+a=0・`scalar_exp_product`） | `check_chain.sage`（行列の行として）と `check_real_exp_lines.sage`（係数の実数の値として） | 行列の行は厳密だが、exp を不定元の冪に置くのでほぼ同語反復。値は `RealBallField(200)` の球 |
| 5 行目 (exp(−ǧ)exp ǧ)_ℂ = (exp(−ǧ))_ℂ(exp ǧ)_ℂ（`real_inclusion_preserves_product`） | `check_chain.sage` | 厳密。包含は成分の環の中で恒等なので作り方で自明 |
| 6 行目 スカラー倍の結合（`scalar_multiple_is_associative`） | `check_chain.sage` | 厳密（`body_scalar` の入れ子と積のスカラー倍） |
| 7 行目 スカラー倍を右の因子から外へ出す（`scalar_multiple_factors_out_of_right_factor`） | `check_chain.sage` | 厳密（`body_product` は mat_mult の成分の式） |
| 8 行目 (exp ǧ)_ℂQ̌_ε を V̌'Q̌_ε に戻す（`eigenvalues_of_check_Vprime`） | `check_chain.sage` | 厳密。前提 V̌'Q̌_ε = (exp ǧ(ε))Q̌_ε そのものも各 ε で確かめる |
| 9 行目 行列の積の結合律（`mat_mult_associative`） | `check_chain.sage` | 厳密 |
| 10 行目 (V̌')^{-1}V̌' = I（`def_invertible_elements_of_R`） | `check_chain.sage` | 厳密。前提として (V̌')^{-1}V̌' = V̌'(V̌')^{-1} = I を Sage の積で確かめる |
| 11 行目 IQ̌_ε = Q̌_ε（`identity_matrix_is_left_unit_of_mat_mult`） | `check_chain.sage` | 厳密 |
| 主張そのもの（V̌' = exp(X̌) の実際の値で） | `check_claim_statement.sage` | 球（下の「主張の検算」） |

`check_chain.sage` の置き方: exp(γ(θ̃_μ)/2) をローラン多項式環 F[a_1^{±1}, …, a_M^{±1}] の不定元 a_μ に置き、V̌' := Π_μ(a_μň_μ + a_μ^{-1}(I − ň_μ))、
(V̌')^{-1} := Π_μ(a_μ^{-1}ň_μ + a_μ(I − ň_μ)) とする。実数 Σ_μ k_μγ(θ̃_μ)/2（k_μ ∈ ZZ）を係数の組で持ち、exp を Π_μ a_μ^{k_μ} に置く。
V̌' = exp(X̌) そのものはこの置き方では確かめず、`eigenvalues_of_check_Vprime` の検算と `check_claim_statement.sage` が確かめる。
両端は Sage の行列の積とスカラー倍とも比べる（成分の式で組んだ積の実装の照合で、主張は試さない）。

否定コントロール（`check_chain.sage`）: (a) 右辺の係数を exp(+ǧ(ε)) にすると外れる（a_μ が独立な不定元なので全ての ε で外れる。
実際の γ では ǧ(ε) = 0 になる ε があり、そこでは外れない）。(b) 8 行目の右辺の V̌'Q̌_ε を Q̌_ε に、9 行目の右辺の (V̌')^{-1}V̌' を V̌'V̌' に壊すと、その行の左辺と外れる。
否定コントロール（`check_real_exp_lines.sage`）: ǧ(ε) が 0 を含まない ε で、exp(ǧ)exp(ǧ) は 1 と重ならない。

### 主張の検算（`check_claim_statement.sage`）

V̌' = exp(X̌) を Sage の球の行列の exp と、`def_exp` の部分和に尾の上界を足した球（`exp_ball_by_partial_sums`）の二つの経路で作り、
重なることを確かめる。(V̌')^{-1} は Sage の球の行列の逆行列で作り、(V̌')^{-1}V̌'・V̌'(V̌')^{-1} が I と重なることを確かめる。そのうえで
(i) (V̌')^{-1}Q̌_ε と (exp(−ǧ(ε)))_ℂQ̌_ε が重なる、(ii) 逆行列を作らない経路で V̌'((exp(−ǧ(ε)))_ℂQ̌_ε) が Q̌_ε と重なる、を全ての ε で確かめる。
否定コントロール: ǧ(ε) が 0 を含まない ε で、(V̌')^{-1}Q̌_ε は (exp(+ǧ(ε)))_ℂQ̌_ε と重ならない。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | 模型の ň_μ（`QQ`、M_col = 2, 3, 4、全ての ε）で 11 行の鎖 | **PASS** | 鎖 308 段、否定コントロール 84 件（移す前と一致） |
| `check_real_exp_lines.sage` | 2〜4 行目の実数の値（M_col = 2..6、(K_1, K_2) の 4 組、全ての ε） | **PASS** | 球の行 1488 個（移す前と一致）、否定コントロール 440 件 |
| `check_claim_statement.sage` | 模型の ň_μ と有理数 γ_μ（M_col = 2, 3, 4）で主張 | **PASS** | 主張 62 件、否定コントロール 28 件 |
| `check_with_check_psi.sage` | 本物の ψ̌ の ň_μ（数体 F、結合定数 3 組 × M_col = 2, 3）で `check_chain.sage` と `check_claim_statement.sage` | **PASS** | 鎖 396 段・否定コントロール 108 件、主張 84 件・否定コントロール 30 件（主張の否定コントロールが ε の総数（結合定数ごとに 4 + 8 = 12、計 36）より少ないのは、本文の γ では ǧ(ε) = 0 になる ε があり、そこでは exp(+ǧ) と exp(−ǧ) が一致して比べないため）。この VM で約 5 分 |

## 計算の帰属と範囲

- **厳密**: 鎖の検算（`QQ` か数体 F の上のローラン多項式環）、Q̌_ε。
- **ℝ への脱出（球）**: `check_real_exp_lines.sage` の γ(θ̃_μ)（(K_1, K_2) から log tanh・cosh・sinh・cos・arccosh で作る）、
  `check_claim_statement.sage` の γ(θ̃_μ)（本物の ψ̌ では γ_1(θ̃_μ) の `AA` の値から実対数 log(g + √(g^2 − 1)) で作る。模型では有理数）、
  ǧ(ε) の値、実数の exp と行列の exp の値、行列の逆行列の球。
  球は丸めの誤差を半径に含めて真の値を囲む。等号は球の重なりで確かめ、半径が 10^{-40}（`check_real_exp_lines.sage`）、
  10^{-80}（`check_claim_statement.sage`）未満であることも確かめる。
- **作り方で自明な比較**: 鎖の 2〜5 行目は、exp を不定元の冪に置くこの置き方では指数の組の整数の足し算と環の中の恒等に縮む。
  値としての 2〜4 行目は `check_real_exp_lines.sage` が受け持つ。5 行目の包含 ℝ → ℂ は Sage の成分の環の中で恒等である。
- 範囲外: 本物の ψ̌ の M_col ≥ 4（`check_joint_eigenspace_decomposition` の overview と同じ理由）。M_col = 4 は模型が受け持つ。

## 由来

2026-11-04 まで、この主張の鎖の検算は `050_claim_even_sector_eigenvalues/check_eigenvalues_of_inverse_of_check_Vprime.sage` にあった
（そのディレクトリの対象ラベルは `eigenvalues_of_V_plus` だけなので、この主張は未検算に数えられていた）。

| いまの名前 | 旧い名前 |
|---|---|
| `check_chain.sage` | 旧い検算の第 1 部（ň_μ を `_vprime_settings.sage` から取り、成分の環を QQ(a_1, …, a_M) からローラン多項式環 F[a_1^{±1}, …, a_M^{±1}] にした（本文の ψ̌ の数体の上の有理関数体では gcd が重くて終わらなかった）。鎖の各行の式は不変。逆元の確かめを Sage の `inverse` から両側の積に替えた） |
| `check_real_exp_lines.sage` | 旧い検算の第 2 部（中身は不変。否定コントロールを足した） |
| `check_claim_statement.sage`、`check_with_check_psi.sage` | 新しく足した |

## 実行

```bash
bash sagemath/tools/run-all-checks.sh eigenvalues_of_inverse_of_check_Vprime
# 個別（本物の ψ̌ の検算は M_col を引数で絞れる）
cd sagemath/check/eigenvalues_of_inverse_of_check_Vprime && sage check_with_check_psi.sage 2 3
```
