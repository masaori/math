/-
# 半整数運動量のフェルミオン `ψ̌_μ`, `ψ̌_μ^†` の定義と、`γ_1, γ_2` の周期性

対応する人手証明（正本は `structured-latex/content/016_even_sector_fermions.ts`）:

* `evenfermi_001_definition_check_fermi`（ラベル `def_check_fermi`）
* `evenfermi_002_claim_periodicity`（ラベル `periodicity_of_check_fermi`）

## 形式化の方針

* 原文の定義は行ベクトル記法 `(ψ̌_μ^†, ψ̌_μ) := (Ž_μ, Y̌_μ) P̌_μ` だが、
  **`P̌_μ`（`diagonalization_check_P_D`）は 015 章の内容であり、本セッションと並行して
  形式化中である**。そこで本ファイルは、原文が「すなわち」として与えている**明示式**

      ψ̌_μ^† := (-r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ
      ψ̌_μ   := (+r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ
      （a := γ_2(θ̃_μ), b := γ_2(-θ̃_μ), r := |a|）

  を定義として採用する。この式は 013 章（`Ž, Y̌`）と 008 章（`γ_1, γ_2`）だけで書けるので、
  本章の内容は 015 章の完成を待たずに閉じられる。
  015 章が `P̌_μ` を用意したら、その列と本定義が一致することを別途 1 行で確認すればよい。
* `r := |γ_2(θ̃_μ)|` は `Real.sqrt (Complex.normSq (γ_2(θ̃_μ)))` で表す。
  **008 章の `ψ` と違い、平方根の分枝を選ぶ仮定（`hbr`）が要らない**のはこのためである
  （原文 `anticommutator_of_check_psi` の Step 1 の指摘そのもの）。
  `r` は非負実数として一意に定まり、`(r : ℂ)^2 = -(γ_2(θ̃_μ)γ_2(-θ̃_μ))` が無条件に成り立つ
  （`checkR_sq`）。
* 原文が statement へ格上げしている「定義が意味をもつ条件」`γ_2(θ̃_μ) ≠ 0`
  （015 章の `gamma_2_theta_tilde_nonzero`）は、各定理の仮定
  `hga : gamma2 K (thetaTilde M μ) ≠ 0` として明示する。
  **015 章がこれを無条件に閉じれば、本章の仮定はそのまま消える。**
  （`γ_2(-θ̃_μ) ≠ 0` は `gamma2_neg_eq_zero_iff` から従うので別に仮定しない。）
-/
import Ising2D.Part008.Definition030_Fermi
import Ising2D.Part013.Claim003b_ConjugateIndex
import Ising2D.Part013.Claim006_RecoverZY

namespace Ising2D

variable {M : ℕ}

/-! ## `γ_1` の `2π` 周期性（原文 `periodicity_of_check_fermi` (1)）

`γ_2` 側（`gamma2_add_int_mul_two_pi`）は 008 章で済んでいる。 -/

/-- 原文 `periodicity_of_check_fermi` (1) の `γ_1` 側: `γ_1(θ + 2kπ) = γ_1(θ)`。 -/
theorem gamma1_add_int_mul_two_pi (K : IsingConst) (θ : ℝ) (k : ℤ) :
    gamma1 K (θ + k * (2 * Real.pi)) = gamma1 K θ := by
  rw [gamma1, gamma1, Real.cos_add_int_mul_two_pi]

/-- 原文 `periodicity_of_check_fermi` (2): `θ̃_{μ+kM} = θ̃_μ + 2kπ`。 -/
theorem thetaTilde_add_int_mul (M : ℕ) (hM : M ≠ 0) (μ k : ℤ) :
    thetaTilde M (μ + k * M) = thetaTilde M μ + k * (2 * Real.pi) := by
  have hM' : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hM
  rw [thetaTilde, thetaTilde]
  push_cast
  field_simp
  ring

/-- 原文 `periodicity_of_check_fermi` (2): `γ_1(θ̃_{μ+kM}) = γ_1(θ̃_μ)`。 -/
theorem gamma1_thetaTilde_add_int_mul (K : IsingConst) (hM : M ≠ 0) (μ k : ℤ) :
    gamma1 K (thetaTilde M (μ + k * M)) = gamma1 K (thetaTilde M μ) := by
  rw [thetaTilde_add_int_mul M hM, gamma1_add_int_mul_two_pi]

/-- 原文 `periodicity_of_check_fermi` (2): `γ_2(θ̃_{μ+kM}) = γ_2(θ̃_μ)`。 -/
theorem gamma2_thetaTilde_add_int_mul (K : IsingConst) (hM : M ≠ 0) (μ k : ℤ) :
    gamma2 K (thetaTilde M (μ + k * M)) = gamma2 K (thetaTilde M μ) := by
  rw [thetaTilde_add_int_mul M hM, gamma2_add_int_mul_two_pi]

/-- 原文 `periodicity_of_check_fermi` (2): `γ_2(-θ̃_{μ+kM}) = γ_2(-θ̃_μ)`。 -/
theorem gamma2_neg_thetaTilde_add_int_mul (K : IsingConst) (hM : M ≠ 0) (μ k : ℤ) :
    gamma2 K (-thetaTilde M (μ + k * M)) = gamma2 K (-thetaTilde M μ) := by
  have h : -thetaTilde M (μ + k * M) = -thetaTilde M μ + ((-k : ℤ) : ℝ) * (2 * Real.pi) := by
    rw [thetaTilde_add_int_mul M hM]; push_cast; ring
  rw [h, gamma2_add_int_mul_two_pi]

/-! ## 共役添字 `M+1-μ`（原文 `periodicity_of_check_fermi` (3)） -/

/-- 原文 `periodicity_of_check_fermi` (3): `γ_2(θ̃_{M+1-μ}) = γ_2(-θ̃_μ)`。 -/
theorem gamma2_thetaTilde_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    gamma2 K (thetaTilde M ((M : ℤ) + 1 - μ)) = gamma2 K (-thetaTilde M μ) := by
  have h : thetaTilde M ((M : ℤ) + 1 - μ) = -thetaTilde M μ + (1 : ℤ) * (2 * Real.pi) := by
    rw [thetaTilde_conj hM]; push_cast; ring
  rw [h, gamma2_add_int_mul_two_pi]

/-- 原文 `periodicity_of_check_fermi` (3): `γ_2(-θ̃_{M+1-μ}) = γ_2(θ̃_μ)`。 -/
theorem gamma2_neg_thetaTilde_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    gamma2 K (-thetaTilde M ((M : ℤ) + 1 - μ)) = gamma2 K (thetaTilde M μ) := by
  have h : -thetaTilde M ((M : ℤ) + 1 - μ) = thetaTilde M μ + (-1 : ℤ) * (2 * Real.pi) := by
    rw [thetaTilde_conj hM]; push_cast; ring
  rw [h, gamma2_add_int_mul_two_pi]

/-- 原文 `periodicity_of_check_fermi` (3): `γ_1(θ̃_{M+1-μ}) = γ_1(θ̃_μ)`。 -/
theorem gamma1_thetaTilde_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    gamma1 K (thetaTilde M ((M : ℤ) + 1 - μ)) = gamma1 K (thetaTilde M μ) := by
  have h : thetaTilde M ((M : ℤ) + 1 - μ) = -thetaTilde M μ + (1 : ℤ) * (2 * Real.pi) := by
    rw [thetaTilde_conj hM]; push_cast; ring
  rw [h, gamma1_add_int_mul_two_pi, gamma1_neg]

/-! ## `r := |γ_2(θ̃_μ)|` -/

/-- 原文 `def_check_fermi` の `r := |γ_2(θ̃_μ)| ∈ ℝ_{≥0}`。

**008 章の `ψ` と違い、これは平方根の分枝を選ばない量である。** -/
noncomputable def checkR (K : IsingConst) (M : ℕ) (μ : ℤ) : ℝ :=
  Real.sqrt (Complex.normSq (gamma2 K (thetaTilde M μ)))

theorem checkR_nonneg (K : IsingConst) (M : ℕ) (μ : ℤ) : 0 ≤ checkR K M μ :=
  Real.sqrt_nonneg _

/-- **分枝の議論が要らないことの核**: `(r : ℂ)^2 = -(γ_2(θ̃_μ) γ_2(-θ̃_μ))` が**無条件**に成り立つ。

008 章では `t^2 = γ_2(θ_μ)γ_2(-θ_μ)` を満たす `t` を仮定として受け取るため
`t = ±r i` の自由度が残り、`μ` と `ν` で同じ分枝を選ぶ仮定 `hbr` が必要だった。 -/
theorem checkR_sq (K : IsingConst) (M : ℕ) (μ : ℤ) :
    ((checkR K M μ : ℝ) : ℂ) ^ 2
      = -(gamma2 K (thetaTilde M μ) * gamma2 K (-thetaTilde M μ)) := by
  rw [gamma2_mul_gamma2_neg_eq_neg_normSq, neg_neg, checkR, ← Complex.ofReal_pow,
    Real.sq_sqrt (Complex.normSq_nonneg _)]

theorem checkR_pos (K : IsingConst) (M : ℕ) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) : 0 < checkR K M μ :=
  Real.sqrt_pos.2 ((Complex.normSq_pos).2 hga)

theorem checkR_ne_zero (K : IsingConst) (M : ℕ) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) : ((checkR K M μ : ℝ) : ℂ) ≠ 0 := by
  simpa using (checkR_pos K M hga).ne'

/-- 原文 `periodicity_of_check_fermi` (3) の絶対値版（`anticommutator_of_check_psi` Step 1）:
`r_{M+1-μ} = r_μ`。 -/
theorem checkR_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    checkR K M ((M : ℤ) + 1 - μ) = checkR K M μ := by
  rw [checkR, checkR, gamma2_thetaTilde_conj K hM, gamma2_neg_eq_neg_conj,
    Complex.normSq_neg, Complex.normSq_conj]

/-! ## `ψ̌_μ^†`, `ψ̌_μ` の定義（原文 `def_check_fermi`） -/

/-- 原文 `def_check_fermi` の `Ž_μ` の係数 `p_μ := -r_μ/(2√M γ_2(-θ̃_μ))`。 -/
noncomputable def checkP (K : IsingConst) (M : ℕ) (μ : ℤ) : ℂ :=
  -((checkR K M μ : ℝ) : ℂ) / (2 * sqrtM M * gamma2 K (-thetaTilde M μ))

/-- 原文 `def_check_fermi` の `Y̌_μ` の係数 `q := 1/(2√M)`（`μ` に依らない）。 -/
noncomputable def checkQ (M : ℕ) : ℂ := 1 / (2 * sqrtM M)

/-- **原文 `def_check_fermi`**: `ψ̌_μ^† := (-r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ`。 -/
noncomputable def checkPsiDag (K : IsingConst) (M : ℕ) (μ : ℤ) : TensorPow M :=
  checkP K M μ • checkZ M μ + checkQ M • checkY M μ

/-- **原文 `def_check_fermi`**: `ψ̌_μ := (+r/(2√M b)) Ž_μ + (1/(2√M)) Y̌_μ`。 -/
noncomputable def checkPsi (K : IsingConst) (M : ℕ) (μ : ℤ) : TensorPow M :=
  (-checkP K M μ) • checkZ M μ + checkQ M • checkY M μ

/-- 原文の「すなわち」の明示式との一致（`ψ̌^†` 側）。 -/
theorem checkPsiDag_eq (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsiDag K M μ
      = (-((checkR K M μ : ℝ) : ℂ) / (2 * sqrtM M * gamma2 K (-thetaTilde M μ)))
          • checkZ M μ + (1 / (2 * sqrtM M)) • checkY M μ := rfl

/-- 原文の「すなわち」の明示式との一致（`ψ̌` 側）。 -/
theorem checkPsi_eq (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsi K M μ
      = (((checkR K M μ : ℝ) : ℂ) / (2 * sqrtM M * gamma2 K (-thetaTilde M μ)))
          • checkZ M μ + (1 / (2 * sqrtM M)) • checkY M μ := by
  rw [checkPsi, checkP, checkQ]
  congr 2
  rw [neg_div, neg_neg]

end Ising2D
