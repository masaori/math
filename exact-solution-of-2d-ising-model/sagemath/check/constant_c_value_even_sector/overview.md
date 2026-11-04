# SageMath Check: constant_c_value_even_sector

## 対象

**対象ラベル**: `constant_c_value_even_sector`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_009_claim_constant_c_value_even_sector`（V^{(+)} = cV̌' の c は ((2s_2)^{M_col/2})_ℂ）
- 範囲: 証明の準備（H + H = S_1 の 8 行、exp(H)exp(H) = exp(S_1) の 2 行、exp(−H)exp(−H) = exp(−S_1) の 3 行、c^{-1}・t・r の置き方）、
  Step 1 の二つの鎖（各 6 行）、Step 2 の鎖（8 行）、Step 3 の二つの積の鎖（各 7 行）と逆元の一意性、二つのトレースの鎖（各 3 行）、
  Step 4 の w の鎖（10 行）・c^2w の鎖（15 行）・c^2 の鎖（7 行）、Step 5 の c = ρ_ℂ の鎖（8 行）・(ρρ, 0) の鎖（6 行）・ρ = a・c の値の鎖（4 行）・主張の鎖（2 行）の全てと、主張そのもの。
- 記号: H := (1/2)_ℂS_1、a := (2s_2)^{M_col/2}、τ := tr(exp(S_1)exp(S_2))、τ' := tr(exp(−S_1)exp(−S_2))、W := c^{-1}(V̌')^{-1}、
  w := tr((V^{(+)})^{-1})、t := Π_μ 2cosh(γ(θ̃_μ)/2)、tr(V^{(+)}) = r_ℂ、ρ := rt^{-1}。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| 準備の H + H = S_1 の 8 行 | `check_steps1_2_exact.sage` (a) | K_1 を KG 上の実の不定元に置き、全ての成分 (k, l) で各行を作って隣どうしを比べる（M_col = 2..5） |
| 準備の exp(H)exp(H)・exp(−H)exp(−H) の鎖 | `check_steps1_2_exact.sage` (b) | exp(H)・exp(S_1)・exp(−S_1) を肩の整数行列（N_1、2N_1、−2N_1。H = (log y)N_1）の射影から作り、1 行目（theorem_exp_product の中身）exp(H)exp(H) = exp(S_1)・exp(−H)exp(−H) = exp((−H)+(−H)) を比べる |
| Step 1 の二つの鎖 | 同上 | V^{(+)} は def_V_plus の積、(V^{(+)})^{-1} は Sage の inverse、R^{(+)} は V_plus_is_invertible の式で作り、各行を QQbar で作って隣どうしを比べる。Sage の inverse と R^{(+)} の一致も見る |
| Step 2 の鎖 | 同上 | U は sign_flip_conjugation の EF をクロネッカー積の成分の式で、U^{-1} は Sage の inverse で作る。肩を T_U で共役した整数行列が −2N_1・−N_2 に等しいこと（sign_flip_conjugation の中身。2 行目の実質）を比べ、T_U(exp(S_1))・T_U(exp(S_2)) は実際に共役して作る（3 行目の実質） |
| Step 3 の V^{(+)}W・WV^{(+)} の鎖、逆元の一意性、二つのトレースの鎖 | `check_steps3_to_5_with_check_Vprime.sage` | 本文の ψ̌ から作った ň_μ で V̌'・(V̌')^{-1} を作り、c を V^{(+)} = cV̌' を満たす数として成分の比から作る（全成分で確かめる）。各行を QQbar で作る |
| Step 4 の三つの鎖 | 同上 | τ・τ' を Step 1・2 と同じ作り方で作り、各行の値を QQbar・AA で作って隣どうしを比べる。q > 0・w ≠ 0 も確かめる |
| Step 5 の鎖、ρρ = aa、ρ = a、c の値、主張 | 同上 | 同上。ρ = a を AA で、主張 V^{(+)} = a_ℂV̌' を行列の全成分で |
| 準備の t・r（trace_of_check_Vprime、trace_V_plus_is_positive の結論） | 同上 | tr(V̌') = tr((V̌')^{-1}) = Π_μ (exp(γ_μ/2) + exp(−γ_μ/2)) と tr(V^{(+)}) ∈ ℝ_{>0} |

否定コントロール:
- `check_steps1_2_exact.sage`: H 自身は S_1 でない。因子を一つ多くした tr(exp(S_1)exp(S_2)exp(S_2)) は τ でない。exp(S_1)exp(S_1) は exp(S_1) でない。
  Step 1 の係数を a^{-1} にすると tr(V^{(+)}) に一致しない。U を F だけにすると S_1 の符号は反転しない。
- `check_steps3_to_5_with_check_Vprime.sage`: c = −a は V^{(+)} = cV̌' を満たさない（−a も c^2 = (a^2)_ℂ は満たすので、Step 5 の符号の確定が要る。この事実の確認は件数に数えない）。
  Step 4 の w の係数を a にすると w に一致しない。γ_μ を 2γ_μ にした V̌' は V^{(+)} の定数倍にならない。

構成上かならず一致する比較（写し間違いの検出だけに効く）:
- 準備の exp(H + H) = exp(S_1) の行は、H + H と S_1 が成分まで同じ行列なので、同じ射影から作ることになり必ず一致する（中身は (a) が受け持つ）。
  exp((−H)+(−H)) = exp(−(H+H)) = exp(−S_1) の 2 行も、肩が成分まで同じ整数行列なので必ず一致する（negation_distributes_over_matrix_sum の中身は肩の整数行列の比較）。
- Step 2 の 1 行目→2 行目の exp(T_U(S_1))・exp(T_U(S_2)) は、T_U で共役した肩が −2N_1・−N_2 と成分まで同じなので、射影は exp(−S_1)・exp(−S_2) と同じ行列から作られ必ず一致する。中身は肩の比較（`TN1q == -2*N1`・`TN2q == -N2`）である。
- Step 2 の 5 行目→6 行目（T_U の定義）は、T_U を同じ成分の式で作るので必ず一致する。
- Step 1 の最後の行（τ・τ' の定義）、Step 2 の 1 行目・最後の行は、両辺を同じ式から作る。
- Step 3〜5 のスカラーの鎖の「乗法の結合律」「1_ℂ は単位元」「逆元」「real_inclusion_preserves_product」の行は、QQbar の計算規則だけで必ず成り立つ。
  中身として効くのは、V^{(+)} = cV̌'、trace_of_check_Vprime の tr(V̌') = tr((V̌')^{-1}) = t、Step 1・2 の結論（tr(V^{(+)}) = a_ℂτ、w = (a^{-1})_ℂτ'、τ' = τ）、
  逆元の一意性（W が Sage の inverse に一致すること）、w ≠ 0、ρ > 0・a > 0 と ρ = a である。

## 計算の帰属と範囲

- `check_steps1_2_exact.sage`: (a) は KG 上の多項式環（厳密、M_col = 2..5）。(b) は K_1 := 2 log y、K_2 := log x（x, y ∈ {2, 3}、M_col = 2..4）と選び、
  exp の値を整数行列の射影に y^λ・(√t)^{-λ}（t = tanh K_2）を掛けて QQ・AA に作る（def_exp の級数とは独立な経路。射影の exp と def_exp の部分和のボールの一致は
  V_plus_is_invertible の検算が確かめている）。鎖は QQbar で持つ。
- `check_steps3_to_5_with_check_Vprime.sage`: (x, y) ∈ {(2, 2), (3, 3/2), (5/4, 3)}、M_col = 2, 3。ψ̌ と ň_μ は数体 E_1 で作り（`check_joint_eigenspace_decomposition/_number_operators.sage` の本物の ψ̌ の設定）、
  E_1 → QQbar の埋め込みで移す。V̌' は eigenvalues_of_check_Vprime の主張の形 Σ_ε exp(Σ_μ γ_μ(ε_μ − 1/2))Q̌_ε で作る（V̌' = exp(X̌) からこの形への移行はその主張の検算が受け持つ）。
  exp(γ_μ/2) は exp(γ_μ) = g + √(g^2 − 1)（g = γ_1(θ̃_μ) ∈ AA、def_arccosh の実対数の中身）の平方根として AA で作る。V^{(+)} は同じ数体の def_V_plus の積で作り、`check_steps1_2_exact.sage` の作り方（AA）と一致することも見る。
- **ℝ への脱出は K_1・K_2 の選び方と γ_μ を arccosh の式から作る一点だけ**で、以後の等号・不等号は全て厳密計算である。浮動小数点は使わない。
- 範囲外: M_col ≥ 5（(b)）、M_col ≥ 4（Step 3〜5）、他の結合定数。

## 由来

浮動小数点で U S_1^{(+)} U^{-1} = −S_1^{(+)}・τ' = τ・tr(V)/tr(V^{-1}) = (2s_2)^M・c の値を見る旧い検算 `050_claim_even_sector_eigenvalues/check_05` は 050 に残してある。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_steps1_2_exact.sage` | 準備の H + H = S_1 と二つの exp の鎖、Step 1・Step 2 | **PASS** | 等号 328 個、否定コントロール 52 件 |
| `check_steps3_to_5_with_check_Vprime.sage` | 準備の c^{-1}・t・r、Step 3〜5、主張 | **PASS** | 等号 438 個、否定コントロール 18 件 |

人手証明の計算の誤りは見つからなかった。人手証明の書き方を直した（Step 2 の散文の U exp(S)U^{-1} = exp(USU^{-1}) を新しい主張 `conjugation_commutes_with_matrix_exp` へ切り出し、
各段を (∵) とラベル参照付きの鎖に、本文に定義の無い ℂ の商を逆元の積に、(V^{(+)})^{-1} = c^{-1}(V̌')^{-1} を左右の積と逆元の一意性で示す形に、
零因子を持たないことに頼っていた符号の確定を c = ρ_ℂ（ρ ∈ ℝ_{>0}）と positive_real_square_injective に、主張の c を像の記号 ((2s_2)^{M_col/2})_ℂ に）。主張の値は変えていない。
Lean の `ClaimConstantCEvenSector.lean`・`NecSuf/ConstantC.lean` は旧い道筋（c^2 = a^2 から (c−a)(c+a) = 0 を割る）のままで、新しい Step 3〜5 と一般の B の `conjugation_commutes_with_matrix_exp` とは 1 対 1 でない（Lean の連続実行の受け持ち）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh constant_c_value_even_sector
```
