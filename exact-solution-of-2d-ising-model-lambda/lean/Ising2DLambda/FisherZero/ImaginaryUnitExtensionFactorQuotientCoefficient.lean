/-
主張「虚数単位を足した体の根で割った商の係数は虚数単位を足した体に入る」
（ラベル `claim_imaginary_unit_extension_factor_quotient_coefficient`）の具体版。

  人手証明                                                    このファイル
  準備 (一) 一次式の値の全体は 0・1・和・積で閉じる           `imaginaryUnitLinearValues_ringClosed`
  準備 (二) 有限和の所属（項の個数の帰納法）                    `imaginaryUnitLinearValues_sum_mem`
  集合 𝒫（係数が全て `Lin_F(ω)` に属する多項式）              `imaginaryUnitCoefficientPolys`
  準備 (三) 和の係数                                            `imaginaryUnitCoefficientPolys_add`
  準備 (四) 積の係数（二行の式鎖）                              `imaginaryUnitCoefficientPolys_mul`
  準備 (五) 定数多項式                                          `imaginaryUnitCoefficientPolys_const`
  準備 (六) 不定元の冪                                          `imaginaryUnitCoefficientPolys_X_pow`
  準備 (七) `K_k(w)`（`k` の帰納法）                            `imaginaryUnitCoefficientPolys_powDiffSum`
  準備 (八) 有限和（項の個数の帰納法）                          `imaginaryUnitCoefficientPolys_sum`
  主張                                                          `imaginaryUnitExtension_factor_quotient_coefficient`

正錐と共役は使わない。根の条件 `aev_w(f) = 0` と次数の条件も使わない。
住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionConjugateEvaluation
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyIndeterminatePowerCoefficient
import Mathlib.Algebra.BigOperators.NatAntidiagonal

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 準備 (二): 各項が `Lin_F(ω)` に属する有限和は `Lin_F(ω)` に属する（項の個数 `m` の帰納法）。 -/
theorem imaginaryUnitLinearValues_sum_mem
    (F : Subfield Qbar) (omega : Qbar) (homega : omega * omega = -1) (x : ℕ → Qbar)
    (hx : ∀ i, x i ∈ imaginaryUnitLinearValues F omega) (m : ℕ) :
    (∑ i ∈ Finset.range m, x i) ∈ imaginaryUnitLinearValues F omega := by
  obtain ⟨h0, _, hadd, _⟩ := imaginaryUnitLinearValues_ringClosed F omega homega
  induction m with
  | zero =>
      -- 出発点: 空の和は零元。
      rw [Finset.sum_range_zero]; exact h0
  | succ m ih =>
      -- 一歩: 最後の項を分け、帰納法の仮定と和の閉性。
      rw [Finset.sum_range_succ]; exact hadd _ _ ih (hx m)

/-- 人手証明の集合 `𝒫 = {h ∈ Qbar[t] | ∀ j, ac_j(h) ∈ Lin_F(ω)}`。 -/
def imaginaryUnitCoefficientPolys (F : Subfield Qbar) (omega : Qbar) : Set QbarPoly :=
  {h | ∀ j : ℕ, h.coeff j ∈ imaginaryUnitLinearValues F omega}

/-- 準備 (三): `𝒫` は和で閉じる。 -/
theorem imaginaryUnitCoefficientPolys_add
    (F : Subfield Qbar) (omega : Qbar) (homega : omega * omega = -1) (h₁ h₂ : QbarPoly)
    (h₁P : h₁ ∈ imaginaryUnitCoefficientPolys F omega)
    (h₂P : h₂ ∈ imaginaryUnitCoefficientPolys F omega) :
    h₁ + h₂ ∈ imaginaryUnitCoefficientPolys F omega := by
  obtain ⟨_, _, hadd, _⟩ := imaginaryUnitLinearValues_ringClosed F omega homega
  intro j
  -- 和の係数（多項式環の演算の定義）と和の閉性。
  rw [Polynomial.coeff_add]
  exact hadd _ _ (h₁P j) (h₂P j)

/-- 準備 (四): `𝒫` は積で閉じる。`ac_j(h₁ h₂) = Σ_{i=0}^{j} ac_i(h₁) ac_{j-i}(h₂)` は
多項式環の積の定義（`Polynomial.coeff_mul` を番号の和へ書き直したもの）。 -/
theorem imaginaryUnitCoefficientPolys_mul
    (F : Subfield Qbar) (omega : Qbar) (homega : omega * omega = -1) (h₁ h₂ : QbarPoly)
    (h₁P : h₁ ∈ imaginaryUnitCoefficientPolys F omega)
    (h₂P : h₂ ∈ imaginaryUnitCoefficientPolys F omega) :
    h₁ * h₂ ∈ imaginaryUnitCoefficientPolys F omega := by
  obtain ⟨_, _, _, hmul⟩ := imaginaryUnitLinearValues_ringClosed F omega homega
  intro j
  -- 第一行（積の係数の定義）。
  have hcoeff : (h₁ * h₂).coeff j
      = ∑ i ∈ Finset.range (j + 1), h₁.coeff i * h₂.coeff (j - i) := by
    rw [Polynomial.coeff_mul,
      Finset.Nat.sum_antidiagonal_eq_sum_range_succ (fun a b => h₁.coeff a * h₂.coeff b) j]
  -- 第二行（各項の所属と準備 (二) を `m := j + 1` へ）。
  rw [hcoeff]
  exact imaginaryUnitLinearValues_sum_mem F omega homega
    (fun i => h₁.coeff i * h₂.coeff (j - i)) (fun i => hmul _ _ (h₁P i) (h₂P (j - i))) (j + 1)

/-- 準備 (五): `a ∈ Lin_F(ω)` なら定数多項式 `â ∈ 𝒫`。 -/
theorem imaginaryUnitCoefficientPolys_const
    (F : Subfield Qbar) (omega : Qbar) (homega : omega * omega = -1) (a : Qbar)
    (ha : a ∈ imaginaryUnitLinearValues F omega) :
    qbarConst a ∈ imaginaryUnitCoefficientPolys F omega := by
  obtain ⟨h0, _, _, _⟩ := imaginaryUnitLinearValues_ringClosed F omega homega
  intro j
  -- `ac_0(â) = a`、`j ≥ 1` で `ac_j(â) = 0`（定数として送る写像の定義）。
  rw [qbarConst, Polynomial.coeff_C]
  split_ifs
  · exact ha
  · exact h0

/-- 準備 (六): 不定元の冪 `t^k ∈ 𝒫`（`claim_qbar_poly_indeterminate_power_coefficient`）。 -/
theorem imaginaryUnitCoefficientPolys_X_pow
    (F : Subfield Qbar) (omega : Qbar) (homega : omega * omega = -1) (k : ℕ) :
    (Polynomial.X : QbarPoly) ^ k ∈ imaginaryUnitCoefficientPolys F omega := by
  obtain ⟨h0, h1, _, _⟩ := imaginaryUnitLinearValues_ringClosed F omega homega
  intro j
  rw [qbarPolyIndeterminatePowerCoefficient k j]
  split_ifs
  · exact h1
  · exact h0

/-- 準備 (七): `w ∈ Lin_F(ω)` なら任意の `k` で `K_k(w) ∈ 𝒫`（`k` の帰納法）。 -/
theorem imaginaryUnitCoefficientPolys_powDiffSum
    (F : Subfield Qbar) (omega : Qbar) (homega : omega * omega = -1) (w : Qbar)
    (hw : w ∈ imaginaryUnitLinearValues F omega) (k : ℕ) :
    qbarPolyPowDiffSum w k ∈ imaginaryUnitCoefficientPolys F omega := by
  obtain ⟨h0, _, _, _⟩ := imaginaryUnitLinearValues_ringClosed F omega homega
  induction k with
  | zero =>
      -- 出発点: `K_0(w) = 0` は零多項式で、全ての係数が零元。
      intro j
      rw [qbarPolyPowDiffSum, Polynomial.coeff_zero]
      exact h0
  | succ k ih =>
      -- 一歩: `K_{k+1}(w) = K_k(w) ŵ + t^k` と準備 (五)・(四)・(六)・(三)。
      rw [qbarPolyPowDiffSum]
      exact imaginaryUnitCoefficientPolys_add F omega homega _ _
        (imaginaryUnitCoefficientPolys_mul F omega homega _ _ ih
          (imaginaryUnitCoefficientPolys_const F omega homega w hw))
        (imaginaryUnitCoefficientPolys_X_pow F omega homega k)

/-- 準備 (八): 各項が `𝒫` に属する有限和は `𝒫` に属する（項の個数 `m` の帰納法）。 -/
theorem imaginaryUnitCoefficientPolys_sum
    (F : Subfield Qbar) (omega : Qbar) (homega : omega * omega = -1) (y : ℕ → QbarPoly)
    (hy : ∀ k, y k ∈ imaginaryUnitCoefficientPolys F omega) (m : ℕ) :
    (∑ k ∈ Finset.range m, y k) ∈ imaginaryUnitCoefficientPolys F omega := by
  obtain ⟨h0, _, _, _⟩ := imaginaryUnitLinearValues_ringClosed F omega homega
  induction m with
  | zero =>
      -- 出発点: 空の和は零多項式。
      intro j
      rw [Finset.sum_range_zero, Polynomial.coeff_zero]
      exact h0
  | succ m ih =>
      -- 一歩: 最後の項を分け、帰納法の仮定と準備 (三)。
      rw [Finset.sum_range_succ]
      exact imaginaryUnitCoefficientPolys_add F omega homega _ _ ih (hy m)

/-- `claim_imaginary_unit_extension_factor_quotient_coefficient` の具体版。
`g = Σ_{k=0}^{n} ac_k(f)^ K_k(w)` の係数は全て `Lin_F(ω)` に属する。 -/
theorem imaginaryUnitExtension_factor_quotient_coefficient
    (F : Subfield Qbar) (omega : Qbar) (homega : omega * omega = -1) (f : QbarPoly)
    (hf : ∀ k : ℕ, f.coeff k ∈ imaginaryUnitLinearValues F omega)
    (w : Qbar) (hw : w ∈ imaginaryUnitLinearValues F omega) (n : ℕ) (j : ℕ) :
    (∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k) * qbarPolyPowDiffSum w k).coeff j
      ∈ imaginaryUnitLinearValues F omega := by
  -- 各項は準備 (五)・(七)・(四) で `𝒫` に属し、準備 (八) を `m := n + 1` へ当てる。
  have hterm : ∀ k, qbarConst (f.coeff k) * qbarPolyPowDiffSum w k
      ∈ imaginaryUnitCoefficientPolys F omega := fun k =>
    imaginaryUnitCoefficientPolys_mul F omega homega _ _
      (imaginaryUnitCoefficientPolys_const F omega homega _ (hf k))
      (imaginaryUnitCoefficientPolys_powDiffSum F omega homega w hw k)
  exact imaginaryUnitCoefficientPolys_sum F omega homega _ hterm (n + 1) j

end Ising2DLambda.FisherZero
