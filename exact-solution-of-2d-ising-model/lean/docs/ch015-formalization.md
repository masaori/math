# 章 015「半整数運動量における `A(θ~)` の対角化」の Lean 形式化

対象: `structured-latex/content/015_A_theta_tilde_diagonalization.ts`（9 主張）。

この章は **008 章後半（`A(θ)` の固有ベクトル・対角化・`det A`）の半整数運動量版**である。
`A(θ)` は `θ ∈ ℝ` について述べられた 2×2 の主張なので、
**008 章で形式化済みの定理の多くは `θ := θ~_μ` を代入するだけで使える**。
実際、固有ベクトル・対角化・行列式は既存の
`Ising2D.AMat_mulVec_eigen` / `AMat_mul_Pmat` / `AMat_eq_Pmat_mul_Dmat_mul_inv` /
`det_AMat_eq_one`（`Part008/Claim027_EigenATheta.lean`）の特殊化として得られ、再証明していない。

**本章に固有で、かつ本章の最大の価値は `γ_2(θ~_μ) ≠ 0` を無条件に閉じたこと**である
（`Ising2D.gamma2_thetaTilde_ne_zero`）。これにより整数運動量にあった臨界点の例外処理
（`μ = ±M` の除外）が偶セクターでは不要になることが機械的に確定した。

## 1. 形式化した定理の一覧

### 具体版（`lean/Ising2D/Part015/`）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.AMat_thetaTilde_eq` | `A(θ~_μ) = !![γ_1, γ_2(θ~); -γ_2(-θ~), γ_1]` | `def_gamma1_gamma2_of_theta` |
| `Ising2D.thetaTilde_mul_M` | `M·θ~_μ = (2μ-1)π`（**奇数**倍。015 章の要） | 同上（Step 2 の前提） |
| `Ising2D.cos_thetaTilde_eq_neg_one_of_sin_eq_zero` | `sin θ~_μ = 0 ⟹ cos θ~_μ = -1` | `gamma_2_theta_tilde_nonzero` Step 2+3 |
| **`Ising2D.gamma2_thetaTilde_ne_zero`** | **`γ_2(θ~_μ) ≠ 0`（無条件・全 `μ ∈ ℤ`）** | **`gamma_2_theta_tilde_nonzero`** |
| `Ising2D.gamma2_neg_thetaTilde_ne_zero` | `γ_2(-θ~_μ) ≠ 0` | 同上（statement 末尾） |
| `Ising2D.gamma2_thetaTilde_ne_zero_checkIndex` | 同上の `μ ∈ 𝓜̌` 版（人手証明と 1 対 1） | 同上 |
| `Ising2D.absGamma2` | `|γ_2(θ)| := √(normSq γ_2(θ))` | `relation_of_gamma_2_theta_tilde` |
| `Ising2D.gamma2_neg_thetaTilde_eq` | (1) `γ_2(-θ~) = -conj γ_2(θ~)` | 同 (1) |
| `Ising2D.gamma2_mul_gamma2_neg_eq_neg_absSq` | (2) `γ_2(θ~)γ_2(-θ~) = -|γ_2|^2` | 同 (2) |
| `Ising2D.sq_absGamma2` | (4) `(|γ_2|)^2 = -γ_2(θ~)γ_2(-θ~)` | 同 (4) |
| `Ising2D.sq_I_absGamma2` | (5) `(i|γ_2|)^2 = γ_2(θ~)γ_2(-θ~)` | 同 (5) |
| `Ising2D.absGamma2_thetaTilde_pos` | `|γ_2(θ~_μ)| > 0` | 同 (2)(4) の狭義部分 |
| `Ising2D.lambdaPlusR` / `lambdaMinusR` | `λ_{±,μ} = γ_1(θ~_μ) ± |γ_2(θ~_μ)| ∈ ℝ` | `eigenvector_of_A_theta_tilde` |
| `Ising2D.charPoly_factor_thetaTilde` | 特性多項式 `= (λ-λ_+)(λ-λ_-)` | 同 Step 1 |
| `Ising2D.AMat_mulVec_eigen_pos` / `..._neg` | `v_± = (∓|γ_2|, γ_2(-θ~))` が固有ベクトル | 同 Step 2 |
| `Ising2D.lambdaPlusR_ne_lambdaMinusR` | `λ_+ ≠ λ_-`（固有値の分離） | 同 Step 1 末尾 |
| `Ising2D.checkT` | 008 章の `Pmat` へ渡す分岐 `t := i|γ_2|`（`t^2 = γ_2γ_2(-θ~)`） | 形式化の都合（分岐の確定） |
| `Ising2D.checkPmat` / `checkDmat` | 人手証明の `P̌_μ`, `Ď_μ` | `diagonalization_check_P_D` |
| `Ising2D.checkPmat_eq_Pmat` / `checkDmat_eq_Dmat` | 008 章の `P_μ`, `D_μ` の特殊化であること | 同上 |
| `Ising2D.det_checkPmat` | `det P̌_μ = -|γ_2|/(2M γ_2(-θ~_μ))` | 同 Step 3 |
| `Ising2D.det_checkPmat_ne_zero` | `det P̌_μ ≠ 0`（可逆性） | 同 Step 3 |
| `Ising2D.AMat_mul_checkPmat` | `A P̌ = P̌ Ď` | 同 Step 2 |
| **`Ising2D.AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv`** | **`A(θ~_μ) = P̌_μ Ď_μ P̌_μ⁻¹`（場合分けなし）** | **`diagonalization_check_P_D`** |
| `Ising2D.det_AMat_thetaTilde_eq_one` | `det A(θ~_μ) = 1` | `det_A_theta_tilde` |
| `Ising2D.det_AMat_thetaTilde_eq_one_of_abstract` | 同上を抽象版の系として導出した版 | 同上 |
| `Ising2D.gamma1_sq_add_gamma2_mul_thetaTilde` | `γ_1^2 + γ_2γ_2(-θ~) = 1` | 同 第 2 式 |
| `Ising2D.gamma1R_sq_thetaTilde` | `γ_1(θ~_μ)^2 = 1 + |γ_2(θ~_μ)|^2` | 同 最終式 |
| `Ising2D.lambda_mul_lambda_thetaTilde` | `λ_+λ_- = 1` | 同 第 3 式 |
| `Ising2D.one_lt_gamma1R_sq_thetaTilde` | `γ_1(θ~_μ)^2 > 1` | `gamma1_gt_1_theta_tilde` Step 2 |
| **`Ising2D.one_lt_gamma1R_thetaTilde`** | **`γ_1(θ~_μ) > 1`（狭義）** | **`gamma1_gt_1_theta_tilde`** |
| `Ising2D.one_le_gamma1R_thetaTilde` | `γ_1(θ~_μ) ≥ 1` | 同上（併記） |
| `Ising2D.gammaTilde` | `γ(θ~_μ) := arccosh(γ_1(θ~_μ))` | `def_gamma_theta_tilde_mu` |
| `Ising2D.cosh_gammaTilde` / `gammaTilde_nonneg` | `cosh γ = γ_1`、`γ ≥ 0` | 同上 |
| **`Ising2D.gammaTilde_pos`** | **`γ(θ~_μ) > 0`（狭義）** | 同上（後半） |
| `Ising2D.sinh_gammaTilde` | `sinh γ(θ~_μ) = |γ_2(θ~_μ)|` | `lambda_eq_exp_gamma_theta_tilde` Step 1 |
| `Ising2D.lambdaPlusR_eq_exp` / `lambdaMinusR_eq_exp` | `λ_{±,μ} = e^{±γ(θ~_μ)}` | 同 Step 2 |
| `Ising2D.lambda_separation` | `λ_+ > 1 > λ_- > 0` | 同 Step 3 |

補助として `Ising2D.IsingParam.c1_pos` / `c2_pos` / `c1_sq_sub_s1_sq` / `c2star_sq_sub_s2star_sq`
（`c_1 = cosh 2K_1 > 0` 等）を置いた。

### 抽象版（`lean/Ising2D/Abstract/`）

| ファイル | Lean の名前 | 内容 |
| --- | --- | --- |
| `OddModePhase.lean` | `Abstract.cos_eq_neg_one_of_sin_eq_zero_of_odd` | `N·θ = mπ`（`m` 奇数）かつ `sin θ = 0` なら `cos θ = -1` |
| `NegConjPair.lean` | `Abstract.mul_of_eq_neg_conj` / `ne_zero_of_eq_neg_conj` / `sq_absOf_eq_neg_mul` / `sq_I_mul_absOf_eq_mul` / `absOf_pos` | `w = -conj z` だけから出る 4 つの帰結 |
| `TwoByTwoSkew.lean` | `Abstract.skew2_charPoly` / `skew2_charPoly_factor` / `skew2_mulVec` / `skew2_mul_col` / `skew2_det_col` / `eq_conj_of_mul_eq` | `!![g,a;-b,g]` の固有値・固有ベクトル・対角化（**任意の可換環**） |
| `GammaDetIdentity.lean` | `Abstract.gamma_det_identity` | `det A = 1` の中身は**可換環の多項式恒等式** |
| `ArcoshExp.lean` | `Abstract.one_lt_of_sq_gt_one` / `sinh_arcosh_of_sq` / `exp_arcosh_of_sq` / `exp_neg_arcosh_of_sq` / `arcosh_pos_of_one_lt` | `g^2 = 1+r^2` から `e^{±arcosh g} = g ± r` |

## 2. 2 本立ての対応表と「抽象版で判明した本質」

| 人手証明のラベル | 具体版 | 抽象版 | 抽象版から具体版の導出 |
| --- | --- | --- | --- |
| `gamma_2_theta_tilde_nonzero` | `gamma2_thetaTilde_ne_zero` | `Abstract.cos_eq_neg_one_of_sin_eq_zero_of_odd` | `cos_thetaTilde_eq_neg_one_of_sin_eq_zero`（抽象版へ `N := M`, `m := 2μ-1` を代入） |
| `relation_of_gamma_2_theta_tilde` | `gamma2_mul_gamma2_neg_eq_neg_absSq`, `sq_absGamma2`, `sq_I_absGamma2` | `Abstract.mul_of_eq_neg_conj`, `sq_absOf_eq_neg_mul`, `sq_I_mul_absOf_eq_mul` | 具体版はいずれも抽象版に `gamma2_neg_eq_neg_conj` を渡しただけ |
| `eigenvector_of_A_theta_tilde`, `diagonalization_check_P_D` | `AMat_mulVec_eigen_pos/neg`, `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv` | `Abstract.skew2_mulVec`, `Abstract.skew2_charPoly_factor`, `Abstract.eq_conj_of_mul_eq` | 対角化は `eq_conj_of_mul_eq` の系として導出 |
| `det_A_theta_tilde` | `det_AMat_thetaTilde_eq_one` | `Abstract.gamma_det_identity` | `det_AMat_thetaTilde_eq_one_of_abstract`（同じ主張を抽象版の系として再証明） |
| `gamma1_gt_1_theta_tilde` | `one_lt_gamma1R_thetaTilde` | `Abstract.one_lt_of_sq_gt_one` | 具体版は抽象版の系 |
| `def_gamma_theta_tilde_mu`, `lambda_eq_exp_gamma_theta_tilde` | `gammaTilde_pos`, `sinh_gammaTilde`, `lambdaPlusR_eq_exp`, `lambdaMinusR_eq_exp` | `Abstract.arcosh_pos_of_one_lt`, `sinh_arcosh_of_sq`, `exp_arcosh_of_sq`, `exp_neg_arcosh_of_sq` | 具体版はいずれも抽象版の系 |

抽象版から得られた知見（本文には持ち込まない）:

- **半整数運動量で例外が消える理由は 1 行に還元される。**
  `γ_2(θ~_μ) ≠ 0` に効いているのは「`M θ~_μ = (2μ-1)π` が `π` の**奇数**倍であること」と
  「`sin θ~_μ = 0`」の 2 つだけで、`M`・`μ`・`2π/M` という形も、`θ` が運動量であることも、
  Ising 模型の定数も効いていない。整数運動量が `M θ_μ = 2μ·π`（偶数倍）であることと対比すると、
  008 章が臨界点で場合分けを強いられた原因がこの偶奇の 1 点にあると分かる。
  正値性の側で使うのは `c_1, s_1, c_2, s_2^* > 0` の 4 つだけである。
- **`relation_of_gamma_2_theta_tilde` の (1)〜(5) に効いているのは `w = -conj z` の 1 本だけ。**
  `γ_2` の具体形も `θ` が半整数運動量であることも `M` も効かない。
  `z ≠ 0` が効くのは狭義の不等号（`|γ_2| > 0`）だけで、等式は `z = 0` でも成り立つ。
  さらに、人手証明が `arg^{[0,2π)}` 分岐の複素平方根 `def_sqrt_cc` を経由して (3)(4)(5) を出す部分は、
  **「2 乗が何になるか」だけを述べれば分岐の議論が完全に消える**（本形式化はそうしている）。
- **`A(θ~_μ)` の固有値・固有ベクトル・対角化に効いているのは
  「行列が `!![g,a;-b,g]` の形（対角成分が等しい）」と「`s^2 = -(ab)` を満たす `s` が取れる」の 2 つだけ**で、
  係数は**任意の可換環**でよい。複素数であることも `γ_1` が実数であることも効いていない。
  人手証明が `√(-γ_2γ_2(-θ~))` として導入する量は、抽象版では「2 乗が `-(ab)` の元」に退化し、
  分岐の選択は `s ↦ -s`（＝ `P` の 2 列と `D` の 2 成分の同時入れ替え）にすぎない。
- **`det A = 1` は可換環の多項式恒等式である。** 効いているのは
  `u^2+v^2 = 1`, `c_1^2-s_1^2 = 1`, `(c_2^*)^2-(s_2^*)^2 = 1`, `c_2s_2^* = c_2^*` の 4 本だけで、
  `u, v` が三角関数であることも、`θ` が半整数運動量か整数運動量かも、実数・複素数であることも、
  `c_1 = cosh 2K_1` という出自も効いていない。
- **固有値の分離 `λ_+ > 1 > λ_- > 0` に効いているのは `r = |γ_2| > 0` の一点だけ。**
  `e^{±γ} = g ± r` 自体は `cosh^2-sinh^2 = 1`、`γ ≥ 0`、`e^{±x} = cosh x ± sinh x` の 3 つだけから出る。
  整数運動量で分離が壊れうるのは、そこで `r` が `0` になりうるからである。

## 3. 形式化できなかった主張とその理由

**無い。** 章 015 の 9 主張はすべて形式化した。ただし次の 2 点は形式化の形が人手証明と異なる。

1. **`relation_of_gamma_2_theta_tilde` (3)（`arg^{[0,2π)}(γ_2γ_2(-θ~)) = π`）に直接の対応物を置いていない。**
   これは人手証明が (4)(5) を `def_sqrt_cc`（偏角 `[0,2π)` の一価な複素平方根）から導くための
   中間段階である。本形式化は複素平方根関数を導入せず、(4)(5) を 2 乗の等式
   （`sq_absGamma2` / `sq_I_absGamma2`）として述べるので、偏角の計算が不要になる。
   「積が負の実数である」という (3) の内容自体は (2)（`gamma2_mul_gamma2_neg_eq_neg_absSq` と
   `absGamma2_thetaTilde_pos`）で述べてある。この方針は 008 章
   （`Part008/Claim027_EigenATheta.lean`）と同じである。
2. **`eigenvector_of_A_theta_tilde` Step 3（固有空間が 1 次元で尽きること）を独立の定理にしていない。**
   固有値が `λ_±` の 2 つに限ることは `charPoly_factor_thetaTilde`（特性多項式の因数分解）で、
   固有ベクトルが `v_±` のスカラー倍で尽きることは対角化
   `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv`（`P̌` が可逆）でそれぞれ言えており、
   後段が使うのはこの 2 つである。

## 4. `det A = 1` に必要な仮定について（008 章と同じ）

`det A(θ~_μ) = 1` は `A(θ)` の定義だけからは出ず、双対関係の帰結
`c_2 s_2^* = c_2^*`（人手証明 Step 0 の (iii)、`duality_c2_star_eq_s2_star_c2`）が要る。
`Ising2D.IsingParam` は `K_1, K_2, K_2^*` を独立な正数として持つだけなので、この関係は
仮定 `hdual` として明示してある（`Part008/Definition016_TV.lean` の `hdual` と同じ扱い）。
`det A(θ~_μ) = 1` に依存する `gamma1_gt_1_theta_tilde` 以降（`γ(θ~_μ) > 0`、`λ_± = e^{±γ}`、
固有値の分離）も同じ仮定を引き継ぐ。**これは形式化に由来する穴ではなく、数学的に必要な仮定である。**

## 5. 人手証明に見つかった誤り・穴

**無い。** 章 015 の 9 主張は、上記の `hdual`（人手証明も Step 0 で明示的に引用している）を除き、
すべて書かれているとおりに閉じた。008 章について既知の問題
（`det A = 1` に (iii) が要ること、`P_μ` の可逆性が確認されていないこと）は、
015 章では人手証明の側で解消されている（Step 0 で (iii) を引用し、Step 3 で `det P̌_μ ≠ 0` を確認している）。

なお `gamma_2_theta_tilde_nonzero` は人手証明が `μ ∈ 𝓜̌ = {1,…,M}` に限って述べているが、
**Lean の証明は `μ ∈ ℤ` 全体で通る**（`μ` の範囲はどこにも効かない）。
人手証明が誤っているわけではなく、仮定が必要以上に強いだけである。
