# SageMath Check: eigenvalues_of_check_Vprime

## 対象

**対象ラベル**: `eigenvalues_of_check_Vprime`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_006_claim_eigenvalues_of_check_Vprime`（ε ∈ {0,1}^{M̌} について ǧ(ε) := Σ_μ γ(θ̃_μ)(ε_μ − 1/2) ∈ ℝ と置くと、
  V̌'Q̌_ε = Q̌_εV̌' = (exp(ǧ(ε)))_ℂ Q̌_ε。V̌' は対角化可能で、固有値は重複度を込めて {exp(ǧ(ε))}_ε（総個数 2^{M_col}）で尽くされ、
  すべて正の実数。相異なる ε が同じ固有値を与えることは実際に起こる）
- 範囲: 証明の全ての鎖（Step 1 の左右の 14 行、Step 2・Step 3' の帰納法、Step 3・Step 3' の部分和の 8 行と極限の鎖、
  Step 4 の Q̌_εy = y の 8 行と後半の 5 行、最後の段落の exp(ǧ(ε)) > 0）、直和から対角化可能性を述べる段落、主張そのもの。
- 記号: X̌ := Σ_μ γ(θ̃_μ)(ň_μ − (1/2)I)、V̌' := exp(X̌)（`def_check_number_operator` (2)）、Q̌_ε := Π_μ R_μ^{(ε_μ)}
  （R^{(1)} := ň_μ、R^{(0)} := I − ň_μ。`check_joint_eigenspace_decomposition`）、E_K := Σ_{k=0}^{K}(1/k!)X̌^k。

## ň_μ と γ_μ の供給元

鎖の検算と主張の検算は、ň_μ・γ_μ を `_vprime_settings.sage` から取る。ň_μ の作り方は `check_joint_eigenspace_decomposition/_number_operators.sage`
をそのまま読み込んで使う（複製しない）。

- **既定（Jordan–Wigner の模型）**: 鎖が ň_μ について使う性質は `check_joint_eigenspace_decomposition` の (1)（Q̌_ε^2 = Q̌_ε）と
  (3)（ň_μQ̌_ε = Q̌_εň_μ = ε_μQ̌_ε）だけなので、二つを満たす n_μ := c_μ^Tc_μ（`QQ`、M_col = 2, 3, 4）と有理数 γ_μ = 3/2, 5/7, 2, 11/3 を使う。
- **本物の ψ̌（`check_with_check_psi.sage`）**: `USE_CHECK_PSI = True` と置いてから、同じ検算を読み込む。ň_μ は本文の ψ̌ の ň_μ := ψ̌_μ^†ψ̌_{σ(μ)}
  （数体 F := E_1 の厳密な行列。結合定数 3 組 × M_col = 2, 3）。γ_μ は、
  - Step 1 の鎖（γ_μ について一次）では F 上の多項式環の不定元 γ_1, …, γ_M。不定元での等号は γ(θ̃_μ) の実際の値を代入しても成り立つ。
  - 冪 X̌^k を作る鎖（Step 2・Step 3'・部分和・Step 4 の前半）では有理数（模型と同じ値）。不定元では数体上の多項式の計算が重すぎて終わらなかった。
    有理数で足りる理由: これらの鎖のうち仮定（Step 1・帰納法の仮定・冪等性・Step 2）を使わない行は環の恒等式で、各検算の否定コントロールが
    不定元の行列と不定元の係数で成り立つことを確かめている。仮定を使う行の仮定 X̌Q̌_ε = ǧ(ε)Q̌_ε = Q̌_εX̌ は、Step 1 の検算が本物の ň_μ と
    不定元の γ_μ（すなわち全ての γ の値）で確かめている。
  - 極限の鎖と主張の検算では γ(θ̃_μ) = log(g + √(g^2 − 1))（g = γ_1(θ̃_μ)）の `RealBallField(512)` の球。F の元は `to_cb_factory(E_1)` で
    `ComplexBallField(512)` へ移す（`def_check_number_operator` の検算と同じ埋め込み）。

模型の n_μ は全て同じ基底で対角なので、模型では X̌ も対角になる。X̌ が対角でない場合の鎖と、V̌' を対角成分から作れない場合の極限は、
本物の ψ̌ で走らせる分が受け持つ。

## 証明の行との対応

| 証明の行 | 検算 | 段数（模型） |
|---|---|---|
| Step 1 の X̌Q̌_ε から ǧ(ε)Q̌_ε までの 14 行（`def_check_number_operator` (2)・`finite_sum_of_matrices_distributes_in_left_factor`・`scalar_multiple_factors_out_of_left_factor`・`matrix_difference_is_sum_with_negation`・`mat_mult_distributes_over_sum_in_left_factor`・`negation_factors_out_of_left_factor`・`identity_matrix_is_left_unit_of_mat_mult`・(3)・`difference_of_scalar_multiples_of_one_matrix`・`scalar_multiple_is_associative`・`finite_sum_of_scalar_multiples_of_one_matrix`・ǧ の定義）。両端は Sage の演算（独立な経路）とも比べる | `check_step1_left_chain.sage` | 405（否定コントロールの 13 段を含む） |
| Step 1 の Q̌_εX̌ から ǧ(ε)Q̌_ε までの 14 行（右から掛ける形の同じ主張たち）と、「とくに X̌Q̌_ε = Q̌_εX̌」（左右の鎖の終わりが同じ ǧ(ε)Q̌_ε） | `check_step1_right_chain.sage` | 405（同上） |
| Step 2 の帰納法（k = 0 の 4 行、k + 1 の 8 行）、Step 3' の帰納法（k = 0 の 4 行、k + 1 の 7 行）、Step 4 の Q̌_εy = y の 8 行（`def_exp` (1) の冪・`mat_mult_associative`・単位行列・`scalar_multiple_by_one`・スカラー倍の主張・ℂ の交換律・(1)）。k = 0, …, 4 | `check_step2_step3prime_induction_and_step4_idempotent_chains.sage` | 1129（否定コントロール 9 行） |
| Step 3 の E_KQ̌_ε と Step 3' の Q̌_εE_K から (Σ_{k≤K}(1/k!)ǧ^k)Q̌_ε までの各 8 行（K = 0, …, 4） | `check_step3_partial_sum_chains.sage` | 974（否定コントロールの 14 段を含む） |
| Step 3・Step 3' の極限の鎖（Step 3' の最後の行 = V̌'Q̌_ε は「主張の両辺」が受け持つ。E_K → V̌'、行列積の連続性の評価（左右）、(1/k!)z = z/k!、`scalar_sequence_times_matrix_converges` の評価、`scalar_exp_is_limit_of_partial_sums` の極限、`complex_exp_of_real_argument`、主張の両辺。ǧ(ε) < 0 の ε が在ること） | `check_step3_limit_chains.sage` | 1044 の関係 |
| Step 4 の後半の 5 行 V̌'y = V̌'(Q̌_εy) = (V̌'Q̌_ε)y = ((exp ǧ)_ℂQ̌_ε)y = (exp ǧ)_ℂ(Q̌_εy) = (exp ǧ)_ℂy（exp(γ_μ/2) を不定元 t_μ に置いた F[t^{±1}] で厳密に） | `check_step4_eigenvector_chain.sage` | 122（否定コントロール 3 行） |
| 最後の段落 exp(ǧ(ε)) > 0（`real_exp_positive`）と、`real_exp_positive` の二本の鎖を x := ǧ(ε) で（γ(θ̃_μ) の実際の値の球。M = 2..6、結合定数 4 組） | `check_last_paragraph_positivity.sage` | 4048 段、壊した行の検出 880 件、`ℤ` の反例 1 件 |
| 直和の段落（im Q̌_ε の基底を合わせると V̌' の固有ベクトルの基底になり、V̌' は対角化可能で固有値は exp(ǧ(ε)) が各 ε で 1 つずつ）と、主張そのもの（下の「主張の検算」） | `check_claim_statements.sage` | 主張 177 件、否定コントロール 34 件 |
| Step 3・Step 3' の極限の鎖の「鎖の係数 ǧ(ε) ∈ ℝ は ǧ(ε)_ℂ として掛けている」の行（包含で書き方を替えるだけで値は同じ）、「Step 3 の級数表示」「上の部分和の鎖を各 K へ」の行（前の鎖の引用） | 確かめない（作り方で自明） | — |

### 主張の検算（`check_claim_statements.sage`）

V̌' = exp(X̌) を Sage の球の行列の exp と、`def_exp` の部分和に尾の上界を足した球の二つの経路で作り、重なることを確かめてから、
(i) V̌'Q̌_ε = Q̌_εV̌' = (exp ǧ(ε))_ℂQ̌_ε、(ii) Q̌_ε の rank が 1 で、その 0 でない列を並べた P の rank が 2^{M_col}（F の上で厳密）かつ
P^{-1}V̌'P が diag(exp ǧ(ε)) と重なる（対角化可能、固有値は各 ε が重複度 1）、(iii) P を使わずに tr(V̌'^k) = Σ_ε exp(ǧ(ε))^k（k = 1..2^{M_col}。
固有多項式の一致）、(iv) exp(ǧ(ε)) > 0、(v)（本物の ψ̌ だけ）γ_1(θ̃_{σ(μ)}) = γ_1(θ̃_μ) を `AA` で厳密に確かめ、ε∘σ ≠ ε の組で
ǧ(ε) = ǧ(ε∘σ) を γ_μ の等しい類ごとの係数の和で厳密に確かめ、そのような組が在ること、を確かめる。
否定コントロール: exp(−ǧ(ε))Q̌_ε とは重ならない（ǧ(ε) ≠ 0 のとき）、固有値の並びを一つずらした対角行列とは重ならない、
周期性の無い模型の γ_μ では ε∘σ の固有値が分かれる組が在る。

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| 上の表の 8 本（`check_with_check_psi.sage` 以外） | 模型の ň_μ（`QQ`、M_col = 2, 3, 4）で、上の表の全ての鎖と主張 | **PASS** | 段数は上の表のとおり（移す前の段数と一致） |
| `check_with_check_psi.sage` | 本物の ψ̌ の ň_μ（数体 F、結合定数 3 組 × M_col = 2, 3）で、`check_last_paragraph_positivity.sage` 以外の 7 本を読み込んで走らせる | **PASS** | 下の「本物の ψ̌ での結果」 |

### 本物の ψ̌ での結果

結合定数 (x, y) = (2, 2), (3, 3/2), (5/4, 3) の 3 組 × M_col = 2, 3 の 6 組の ň_μ（数体 F の行列）で、7 本を全て走らせた。全て PASS。

| 検算 | 本物の ψ̌ での段数 | 否定コントロール |
|---|---|---|
| `check_step1_left_chain.sage`（γ_μ は不定元） | 517（否定コントロールの 13 段を含む） | 1 行 |
| `check_step1_right_chain.sage`（γ_μ は不定元） | 517（同上） | 1 行 |
| `check_step2_step3prime_induction_and_step4_idempotent_chains.sage` | 3313 | 9 行 |
| `check_step3_partial_sum_chains.sage` | 2894（否定コントロールの 14 段を含む） | 2 行 |
| `check_step3_limit_chains.sage`（γ(θ̃_μ) の球。K_max = 14〜33） | 4368 の関係 | — |
| `check_step4_eigenvector_chain.sage` | 362 | 3 行 |
| `check_claim_statements.sage`（γ(θ̃_μ) の球） | 主張 291 件 | 36 件 |

否定コントロールのうち `check_claim_statements.sage` 以外は `QQ` 上の不定元の行列で作るので、供給元に依らず同じ件数である。この VM で約 15 分かかる。

`check_last_paragraph_positivity.sage` は ň_μ を使わない（γ(θ̃_μ) と ǧ(ε) の値だけを扱い、既に実際の値の球で計算している）ので読み込まない。

## 計算の帰属と範囲

- **厳密**: 鎖の検算（`QQ`、数体 F、F 上の多項式環とローラン多項式環、否定コントロールの `QQ` 上の多項式環）、Q̌_ε・P の rank、
  主張の (v) の周期性と ǧ(ε) = ǧ(ε∘σ)。
- **ℝ への脱出（球または `RealField(256)`）**: γ(θ̃_μ)（arccosh の実対数）、ǧ(ε) の値、実数の exp と行列の exp の値、極限（E_K → V̌'、数の exp の部分和の極限）。
  球は丸めの誤差を半径に含めて真の値を囲む。等号は球の重なりで確かめ、半径が 10^{-100}（P^{-1}V̌'P は 10^{-60}、tr(V̌'^k) は 10^{-100}(1 + |値|)）
  未満であることも確かめる。ノルムの球は、2 乗和の球の下端を 0 で切ってから平方根を取る（2 乗和の真の値は 0 以上）。
  模型の極限の鎖は移す前と同じ `RealField(256)` の評価で、許容誤差 2^{-200} はその精度の丸めに対する余裕である。
- **作り方で自明な比較**: 1 行目と最後の行が X̌・ǧ・E_K の定義そのものの行（Step 1 の両端、部分和の鎖の 1・2 行目）、
  添字 0 からの和をずらす二つの定義の行（同じ項の並びから組む）、ℂ の積の交換律の行（可換な環の上ではいつも一致）、
  `def_exp` (1) の冪の定義の行と g^0 := 1・g^{k+1} := g^kg の行（冪を定義どおりに組む）、Step 4 の「y = Q̌_εx と書いた」の行、
  Step 4 の後半の `mat_mult_associative`・`scalar_multiple_factors_out_of_left_factor` の行（Sage の行列演算ではいつも成り立つ）、
  極限の鎖の (1/k!)z = z/k! と `complex_exp_of_real_argument`（Sage の中ではほぼ恒等的に成り立ち、写し間違いの検出だけに効く）。
- 範囲外: 本物の ψ̌ の M_col ≥ 4（`check_joint_eigenspace_decomposition` の overview と同じ理由）。M_col = 4 は模型が受け持つ。

## 由来

2026-11-04 まで、この主張の検算は `050_claim_even_sector_eigenvalues/` の番号付きの検算にあった（そのディレクトリの対象ラベルは
`eigenvalues_of_V_plus` だけなので、この主張は未検算に数えられていた）。移すときに ň_μ・γ_μ を `_vprime_settings.sage` から取るようにし
（模型の作り方と値は不変）、使わなくなったクロネッカー積の関数を消した。鎖の各行の式は変えていない。

| いまの名前 | 旧い名前 |
|---|---|
| `check_step1_left_chain.sage` | `check_eigenvalues_of_check_Vprime_step1_left_chain.sage` |
| `check_step1_right_chain.sage` | `check_eigenvalues_of_check_Vprime_step1_right_chain.sage` |
| `check_step2_step3prime_induction_and_step4_idempotent_chains.sage` | `check_25_Vprime_eigenvalue_power_chains.sage` |
| `check_step3_partial_sum_chains.sage` | `check_eigenvalues_of_check_Vprime_step3_partial_sum_chains.sage` |
| `check_step3_limit_chains.sage` | `check_eigenvalues_of_check_Vprime_step3_limit_chains.sage`（本物の ψ̌ の分岐を足した） |
| `check_step4_eigenvector_chain.sage` | `check_eigenvalues_of_check_Vprime_step4_eigenvector_chain.sage`（成分の環を QQ(t) から F[t^{±1}] にした） |
| `check_last_paragraph_positivity.sage` | `check_eigenvalues_of_check_Vprime_positivity.sage`（中身は不変） |
| `check_claim_statements.sage`、`check_with_check_psi.sage`、`_vprime_settings.sage` | 新しく足した |

主張を浮動小数点で確かめ、縮退の組の実在を記録した `050_claim_even_sector_eigenvalues/check_03_Vprime_eigenvalues.sage` は、そこに残した。

## 実行

```bash
bash sagemath/tools/run-all-checks.sh eigenvalues_of_check_Vprime
# 個別（本物の ψ̌ の検算は M_col を引数で絞れる）
cd sagemath/check/eigenvalues_of_check_Vprime && sage check_with_check_psi.sage 2 3
```
