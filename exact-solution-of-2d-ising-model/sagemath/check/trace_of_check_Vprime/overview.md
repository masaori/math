# SageMath Check: trace_of_check_Vprime

## 対象

**対象ラベル**: `trace_of_check_Vprime`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_007_claim_trace_of_check_Vprime`（V̌' は可逆で (V̌')^{-1} = exp(−X̌)（`def_check_Vprime` (2)）であり、
  tr(V̌') = tr((V̌')^{-1}) = Π_{μ=1}^{M_col} 2cosh(γ(θ̃_μ)/2) ∈ ℝ_{>0}）
- 範囲: 証明の Step 1（8 行の鎖）、Step 2（包含の 1 行、指数法則の 2 行、展開と続く 7 行）、Step 3（トレースの 9 行の鎖と、続く 4 行）、Step 4（正値性の不等号）の全ての行と、主張そのもの。
- 記号: X̌ := Σ_μ γ(θ̃_μ)(ň_μ − (1/2)I)、V̌' := exp(X̌)、Q̌_ε := Π_μ R_μ^{(ε_μ)}（R^{(1)} := ň_μ、R^{(0)} := I − ň_μ）、
  ǧ(ε) := Σ_μ γ(θ̃_μ)(ε_μ − 1/2)。

## ň_μ と γ_μ の供給元

ň_μ を使う検算（`check_step1_chain.sage`・`check_step3_chain.sage`・`check_claim_statement.sage`）は、
`sagemath/check/eigenvalues_of_check_Vprime/_vprime_settings.sage`（ň_μ はその先の `check_joint_eigenspace_decomposition/_number_operators.sage`）を
そのまま読み込む（複製しない）。

- **既定（Jordan–Wigner の模型）**: n_μ := c_μ^Tc_μ（`QQ`、M_col = 2, 3, 4）。鎖が ň_μ について使う性質は、引いた主張の
  (2) Σ_εQ̌_ε = I、(4) tr(Q̌_ε) = 1、V̌'Q̌_ε = (exp ǧ(ε))_ℂQ̌_ε、(V̌')^{-1}Q̌_ε = (exp(−ǧ(ε)))_ℂQ̌_ε だけで、模型はこれらを満たす（各検算が前提として確かめる）。
- **本物の ψ̌（`check_with_check_psi.sage`）**: `USE_CHECK_PSI = True` と置いてから同じ検算を読み込む。ň_μ は本文の ψ̌ の ň_μ := ψ̌_μ^†ψ̌_{σ(μ)}
  （数体 F := E_1 の厳密な行列。結合定数 3 組 × M_col = 2, 3）。

Step 2 と Step 3・4 の実数の値の検算は ň_μ を使わず、γ(θ̃_μ) を有理数の結合定数 (K_1, K_2) の 4 組から本文の式（K_2^*・γ_1(θ̃_μ)・arccosh）で作る。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| Step 1 の 8 行（`identity_matrix_is_right_unit_of_mat_mult`、`check_joint_eigenspace_decomposition` (2)、`sum_over_binary_words_distributes_in_right_factor`、`trace_of_sum_over_binary_words`、`eigenvalues_of_check_Vprime`、`trace_of_scalar_multiple`、(4) の tr(Q̌_ε) = 1、1_ℂ は単位元） | `check_step1_chain.sage` | 厳密（成分の環の中の等号）。和は二つの定義の帰納法どおりに組む |
| Step 2 の 1 行目 Σ_ε(exp ǧ)_ℂ = (Σ_ε exp ǧ)_ℂ（`real_inclusion_preserves_sum_over_binary_words`） | `check_step2_real_inclusion.sage` | 厳密（ℂ を実数の対で持ち、二つの和を定義どおりに組む） |
| Step 2 の指数法則の 2 行（ǧ の定義、`real_exp_of_finite_sum`） | `check_step2_exp_product.sage` | 球 |
| Step 2 の展開の 2 行（直前の鎖を各項へ、`expansion_of_finite_product_of_two_term_sums_of_real_numbers` を右辺から左辺へ） | `check_step2_expansion.sage` | 展開の行は厳密（a_μ^{2e−1} の置き方）と球、両端の比較は球 |
| Step 2 の展開に続く 6 行（1 − 1/2 = 1/2、0 − a = −a、a(−b) = −(ab)、a·(1/2) = a/2、b = 2·(b/2)、`def_cosh_sinh` の cosh） | `check_step2_cosh.sage` | 書き換えの 5 行は厳密（QQ[γ]・QQ(b)）、cosh の行は球 |
| 主張の (V̌')^{-1} = exp(−X̌) が使う −X̌ = Σ_μ(−γ(θ̃_μ))(ň_μ − (1/2)I)（Step 3 の旧い前置き。いまの Step 3 の段落は −ǧ(ε) = Σ_μ(−γ(θ̃_μ))(ε_μ − 1/2) を書く） | `check_step3_chain.sage` | 厳密（γ_μ は模型では有理数、本物の ψ̌ では F 上の不定元） |
| Step 3 のトレースの鎖の 1〜8 行（Step 1 の 8 行と同じ根拠で、5 行目だけ `eigenvalues_of_inverse_of_check_Vprime`） | `check_step3_chain.sage`（行列の部） | 厳密（成分の環の中の等号）。和は二つの定義の帰納法どおりに組む |
| Step 3 のトレースの鎖の 9 行目 Σ_ε(exp(−ǧ))_ℂ = (Σ_ε exp(−ǧ))_ℂ（`real_inclusion_preserves_sum_over_binary_words`） | `check_step3_real_inclusion.sage` | 厳密（ℂ を実数の対で持ち、二つの和を定義どおりに組む） |
| 続く 1 行目 (Σ_ε exp(−ǧ))_ℂ = (Π_μ 2cosh(−γ/2))_ℂ（根拠「Step 2 を γ ↦ −γ として適用」） | `check_step3_chain.sage`（a の形）と `check_step3_and_step4_real_lines.sage`（値） | 根拠が名前だけなので、a の形の厳密な比較と球の値の比較で確かめる |
| 続く 2 行目 ℝ で (−a)/2 = −(a/2) | `check_step3_and_step4_real_lines.sage` | 厳密（QQ[γ]）と球 |
| 続く 3 行目 `cosh_is_even`（x → γ/2） | `check_step3_and_step4_real_lines.sage` | 球（各因子の cosh(−x) = cosh(x) と積） |
| 続く 4 行目 = tr(V̌')（Step 1〜2 のトレース表示） | `check_step3_chain.sage`（a の形で厳密）と `check_step3_and_step4_real_lines.sage`（Σ_ε exp ǧ(ε) との値の比較） | 厳密と球 |
| Step 4 の γ(θ̃_μ) > 0（`gamma_theta_tilde_mu_positive`）、2cosh(γ/2) ≥ 2·1（`cosh_at_least_one`、x → γ/2 の両辺に 2 を掛ける）、2·1 = 2、2 > 0、正数の有限積は正 | `check_step3_and_step4_real_lines.sage` | 球の全体が不等式を満たすこと。有限積は左から畳み込み、各段の積が正であることを見る |
| 主張そのもの（V̌' = exp(X̌) の実際の値で） | `check_claim_statement.sage` | 球（下の「主張の検算」） |

置き方（`check_step1_chain.sage`・`check_step3_chain.sage`）: exp(γ(θ̃_μ)/2) をローラン多項式環 F[a_1^{±1}, …, a_M^{±1}] の不定元 a_μ に置き、
V̌' := Π_μ(a_μň_μ + a_μ^{-1}(I − ň_μ))、(V̌')^{-1} := Π_μ(a_μ^{-1}ň_μ + a_μ(I − ň_μ)) とする（逆元であることは Sage の積で両側から確かめる）。
exp(±ǧ(ε)) = Π_μ a_μ^{±(2ε_μ−1)}。V̌' = exp(X̌) そのものはこの置き方では確かめず、`eigenvalues_of_check_Vprime` の検算と `check_claim_statement.sage` が確かめる。
両端は Sage の `trace` と Π_μ(a_μ + a_μ^{-1}) とも比べる。

Step 3 の 2 行目 (−a)/2 = −(a/2) は a の形では同じ元で、3 行目 `cosh_is_even` は a の形では Π_μ(a_μ^{-1} + a_μ) = Π_μ(a_μ + a_μ^{-1}) という ℂ の和の交換に縮むので、`check_step3_chain.sage` の
その段は同語反復に近い。値としての 2・3 行目は `check_step3_and_step4_real_lines.sage` が受け持つ。

否定コントロール:
- `check_step1_chain.sage`: (4) の tr(Q̌_ε) = 1 の代わりに ň_μ の積のトレースを使うと最後の行が外れる。
- `check_step3_chain.sage`: 各 ε で (V̌')^{-1}Q̌_ε は (exp(+ǧ(ε)))_ℂQ̌_ε と外れる（固有値の符号の誤り。行列の段で捉える。
  固有値を exp(+ǧ(ε)) にした和は ε ↦ 1 − ε の並べ替えで同じ値になるので、トレースでは見分けられない）。(V̌')^{-1} の固有値を exp(−2ǧ(ε)) にした和は
  tr((V̌')^{-1}) と外れる。−X̌ ≠ X̌（X̌ ≠ O と同じで、写し間違いはほとんど捉えない弱い対照）。
- `check_step3_real_inclusion.sage`: 左辺で ε = (1, …, 1) の項を落とすと右辺と外れる。
- `check_step3_and_step4_real_lines.sage`: Σ_ε exp(−2ǧ(ε)) は Π_μ 2cosh(−γ/2) と重ならない。2sinh(−γ/2) は 2 以上でなく、M_col が奇数なら
  Π_μ 2sinh(−γ/2) は負。下界を 3 に上げた 2cosh(γ/2) ≥ 3 は成り立たない μ がある（球の全体が 3 より小さい。球の不等号が下界の違いを見分ける）。(−γ)/2 ≠ γ/2（何も捉えない弱い対照）。
- Step 2 の 4 本はそれぞれの冒頭に書いた否定コントロールを持つ（移す前と同じ）。

### 主張の検算（`check_claim_statement.sage`）

V̌' = exp(X̌) を Sage の球の行列の exp と、`def_exp` の部分和に尾の上界を足した球（`exp_ball_by_partial_sums`）の二つの経路で作り、
重なることを確かめる。(V̌')^{-1} は Sage の球の逆行列と exp(−X̌)（主張の前置き）の二通りで作って重なることと、(V̌')^{-1}V̌'・V̌'(V̌')^{-1} が
I と重なることを確かめる。そのうえで (i) tr(V̌')・tr((V̌')^{-1})・Π_μ 2cosh(γ_μ/2) の三つが重なる、(ii) tr(V̌')・tr((V̌')^{-1}) の虚部の球が 0 を含み、
実部の球が 0 より大きい、を確かめる。虚部がちょうど 0 であること（値が ℝ_{>0} の包含の像に入ること）は球では言えず、
`check_step1_chain.sage` の厳密な鎖の右辺が実数の包含の和であることと Step 2 が受け持つ。
否定コントロール: Π_μ 2cosh(γ_μ)（引数の 1/2 を落とす）と Π_μ 2sinh(γ_μ/2)（cosh を sinh にする）は tr(V̌') と重ならない。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_step1_chain.sage` | 模型の ň_μ（`QQ`、M_col = 2, 3, 4）で Step 1 の 8 行 | **PASS** | 鎖 24 段（移す前と一致）、否定コントロール 3 件 |
| `check_step2_real_inclusion.sage` | Step 2 の 1 行目（M_col = 1..5） | **PASS** | 5 通り、否定コントロール 5 件（移す前と一致） |
| `check_step2_exp_product.sage` | Step 2 の指数法則の 2 行（M_col = 2..6、(K_1, K_2) の 4 組、全ての ε） | **PASS** | 等号 992 個、否定コントロール 496 件（移す前と一致） |
| `check_step2_expansion.sage` | Step 2 の展開の行（球: M_col = 2..6、4 組。厳密: M_col = 1..6） | **PASS** | 球の行 80 個、厳密 6 通り、否定コントロール 20 件（移す前と一致） |
| `check_step2_cosh.sage` | 展開に続く 6 行（厳密 6 段、球: M_col = 2..6、4 組） | **PASS** | 厳密 6 段、球の行 120 個、否定コントロール 3 + 60 件（移す前と一致） |
| `check_step3_real_inclusion.sage` | Step 3 のトレースの鎖の 9 行目（M_col = 1..5） | **PASS** | 5 通り、否定コントロール 5 件 |
| `check_step3_chain.sage` | 模型の ň_μ で Step 3 の行列の部（(V̌')^{-1} の 8 行の鎖、a の形の 3 行、−X̌ の行） | **PASS** | 鎖 24 段、Step 3 の行 12 個、否定コントロール 34 件 |
| `check_step3_and_step4_real_lines.sage` | Step 3 の値の 4 行と各因子の cosh(−x) = cosh(x)、(−a)/2 = −(a/2) の厳密な 1 行、Step 4 の不等号（M_col = 2..6、4 組） | **PASS** | Step 3 の行 161 個、Step 4 の不等号 400 個（μ ごとに γ > 0・cosh ≥ 1・2cosh ≥ 2·1・2cosh > 0・部分積 > 0 の 5 個。2·1 = 2 と 2 > 0 は μ に依らない）、否定コントロール 126 件 |
| `check_claim_statement.sage` | 模型の ň_μ と有理数 γ_μ（M_col = 2, 3, 4）で主張 | **PASS** | 主張 15 件、否定コントロール 6 件 |
| `check_with_check_psi.sage` | 本物の ψ̌ の ň_μ（数体 F、結合定数 3 組 × M_col = 2, 3）で `check_step1_chain.sage`・`check_step3_chain.sage`・`check_claim_statement.sage` | **PASS** | Step 1 の鎖 48 段・否定コントロール 6 件、Step 3 の鎖 48 段・Step 3 の行 24 個・否定コントロール 48 件、主張 30 件・否定コントロール 12 件。この VM で約 4 分 |

## 計算の帰属と範囲

- **厳密**: 行列の鎖（`QQ` か数体 F の上のローラン多項式環）、Q̌_ε、−X̌ の行（`QQ` か F 上の多項式環）、Step 2 の包含・展開・書き換えの行（`QQ` 上の有理関数体・多項式環）。
- **ℝ への脱出（球）**: γ(θ̃_μ)（(K_1, K_2) から log tanh・cosh・sinh・cos・arccosh で作る。本物の ψ̌ の主張の検算では γ_1(θ̃_μ) の `AA` の値から
  実対数 log(g + √(g^2 − 1)) で作る。模型の主張の検算では有理数）、ǧ(ε) の値、実数の exp・cosh・sinh と行列の exp の値、行列の逆行列とトレースの球。
  球は丸めの誤差を半径に含めて真の値を囲む。等号は球の重なりで確かめ、半径が 10^{-40}（`RealBallField(200)` の検算）、10^{-80}（`check_claim_statement.sage`）
  未満であることも確かめる。不等号は球の全体が満たすことで確かめる。
- **作り方で自明な比較**: Step 2 の指数法則の 1 行目（ǧ の定義）は検算でも同じ和から組むので同語反復。Step 3 の 2・3 行目の a の形の段は同じ元か ℂ の和の交換。Step 1 の最後の行 Σ_ε(exp ǧ)_ℂ1_ℂ = Σ_ε(exp ǧ)_ℂ は、成分の環の中で同じ元になる。
- Step 3 のトレースの鎖の 9 行目（包含の行の −ǧ 版）は、`check_step3_real_inclusion.sage` が ℂ を実数の対で持って厳密に確かめる。
- 範囲外: 本物の ψ̌ の M_col ≥ 4（`check_joint_eigenspace_decomposition` の overview と同じ理由）。M_col = 4 は模型が受け持つ。

## 本文について

- 2026-11-04、Lean の通しの証明の連続実行が、Step 3 の 1 行目の名前だけの根拠「Step 1〜2 を γ(θ̃_μ) ↦ −γ(θ̃_μ) として適用」のうちトレースの部分を、
  Step 1 の 8 行の鎖を (V̌')^{-1} で組み 5 行目を `eigenvalues_of_inverse_of_check_Vprime` に替えたものと包含の行の 9 行の鎖として本文に書いた
  （`check_step3_chain.sage` の 8 行の鎖と `check_step3_real_inclusion.sage`）。残る「Step 2 を γ ↦ −γ として適用」は名前だけの根拠である。
- Step 4 の「cosh x ≥ 1」の根拠に `cosh_sinh_basic_properties` を引いていたが、その主張（(1)〜(4)）に cosh x ≥ 1 は無かった（レビューで見つかった）。
  `cosh_at_least_one`（x → γ(θ̃_μ)/2）を行末で引き、両辺に 2 を掛ける行と 2·1 = 2 の行に分けた。計算の誤りではない。
- Step 3 の旧い 2 行目の根拠「cosh は偶関数」はラベル参照が無かった（二回目のレビューで見つかった）。ℝ で (−a)/2 = −(a/2) の行と
  `cosh_is_even`（x → γ(θ̃_μ)/2。`cosh_at_least_one` と同じ `020_critical_point.ts` にあり、文書順で前）を引く行に分けた。計算の誤りではない。
- Step 4 の「正数の有限積は正」は、ラベル参照の無い一般論である（引けるブロックが本文に無い）。
  Step 3・4 は ℂ の値（トレース）と ℝ の値（Π 2cosh）を包含 (·)_ℂ を書かずに等号で結んでいる（Step 1〜2 は包含を書いて区別している）。計算の誤りではない。
- 検算で計算の誤りは見つからなかった。

## 由来

2026-11-04 まで、この主張の各行の検算は `050_claim_even_sector_eigenvalues/` にあった（そのディレクトリの対象ラベルは `eigenvalues_of_V_plus` だけなので、
この主張は未検算に数えられていた）。主張の浮動小数点の確認 `check_04_trace_Vprime.sage` は 050 に残してある。

| いまの名前 | 旧い名前 |
|---|---|
| `check_step1_chain.sage` | `check_trace_of_check_Vprime_step1_chain.sage`（ň_μ を `_vprime_settings.sage` から取り、成分の環を QQ(a_1, …, a_M) からローラン多項式環 F[a_1^{±1}, …, a_M^{±1}] にした。鎖の各行の式は不変） |
| `check_step2_real_inclusion.sage` | `check_trace_of_check_Vprime_step2_real_inclusion.sage`（中身は不変） |
| `check_step2_exp_product.sage` | `check_trace_of_check_Vprime_step2_exp_product.sage`（中身は不変） |
| `check_step2_expansion.sage` | `check_trace_of_check_Vprime_step2_expansion.sage`（中身は不変） |
| `check_step2_cosh.sage` | `check_trace_of_check_Vprime_step2_cosh.sage`（中身は不変） |
| `check_step3_chain.sage`、`check_step3_and_step4_real_lines.sage`、`check_claim_statement.sage`、`check_with_check_psi.sage`、`check_step3_real_inclusion.sage` | 新しく足した |

## 実行

```bash
bash sagemath/tools/run-all-checks.sh trace_of_check_Vprime
# 個別（本物の ψ̌ の検算は M_col を引数で絞れる）
cd sagemath/check/trace_of_check_Vprime && sage check_with_check_psi.sage 2 3
```
