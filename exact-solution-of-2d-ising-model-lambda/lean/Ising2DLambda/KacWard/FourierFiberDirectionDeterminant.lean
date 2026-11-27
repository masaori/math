import Ising2DLambda.KacWard.FourierFiberDirectionBijection
import Ising2DLambda.KacWard.FourierBlockFiberDeterminantProduct
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFunctionExpansion
import Ising2DLambda.AlgebraicEigenvalue.PermutationSignTransport

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 本文の主張 `claim_fourier_fiber_direction_determinant`。
両辺の行列式を本文の定義 `def_qbar_polynomial_determinant` の置換の有限和へ開き
（定義の橋 `qbarPolynomialDeterminant_eq_mathlib`。順序はどちらの添字集合でも一つ固定すればよい）、
置換 `σ` を `d_m ∘ σ ∘ d_m⁻¹` へ移す全単射で再添字付けする。符号は
`claim_permutation_sign_transport`（`finiteOrderedSign_permCongr`）で一致し、
成分の有限積は `claim_fourier_mode_block_entries` の成分の一致を `d_m` で再添字付けして一致する。 -/
theorem fourier_fiber_direction_determinant {L : ℕ} [NeZero L]
    (z : Qbar) (s : SpinStructure)
    (κ : OrientedEdge L ≃ {u // u ∈ fourierModeIndexSet L s})
    (m : FourierModePair L s) :
    Matrix.det (fun i j :
      {e : OrientedEdge L // fourierModeBlockIndex s κ e = m} =>
        (1 - (Polynomial.X : QbarPoly) •
          (modeBlockMatrix z s κ).map Polynomial.C) i.1 j.1) =
      Matrix.det (1 - (Polynomial.X : QbarPoly) •
        (modeSmallMatrix z m.1.1 m.1.2).map Polynomial.C) := by
  classical
  let Jm := {u : OrientedEdge L // fourierModeBlockIndex s κ u = m}
  letI : LinearOrder (OrientedEdge L) :=
    inferInstanceAs (LinearOrder (Fin (2 * L ^ 2) ×ₗ Bool))
  letI : LinearOrder Jm := Subtype.instLinearOrder _
  letI : LinearOrder (ZMod 4) := inferInstanceAs (LinearOrder (Fin 4))
  let e : Jm ≃ ZMod 4 := fourierFiberDirectionEquiv s κ m
  let A : Matrix Jm Jm QbarPoly :=
    fun i j => (1 - (Polynomial.X : QbarPoly) •
      (modeBlockMatrix z s κ).map Polynomial.C) i.1 j.1
  let M : Matrix (ZMod 4) (ZMod 4) QbarPoly :=
    1 - (Polynomial.X : QbarPoly) • (modeSmallMatrix z m.1.1 m.1.2).map Polynomial.C
  -- 本文の成分の等式 `(T|_{𝒥_m×𝒥_m})_{d_m⁻¹(δ),d_m⁻¹(δ')} = (I - x M̆)_{δ,δ'}`。
  have hentry (δ δ' : ZMod 4) : A (e.symm δ) (e.symm δ') = M δ δ' := by
    change (1 - (Polynomial.X : QbarPoly) •
      (modeBlockMatrix z s κ).map Polynomial.C)
        (κ.symm ⟨(m.1.1, m.1.2, δ), m.2⟩)
        (κ.symm ⟨(m.1.1, m.1.2, δ'), m.2⟩) = _
    rw [fourier_mode_block_entries]
    simp [M]
  change Matrix.det A = Matrix.det M
  calc Matrix.det A
      = qbarPolynomialDeterminant A := (qbarPolynomialDeterminant_eq_mathlib A).symm
    _ = ∑ σ : Equiv.Perm Jm,
          Polynomial.C ((qbarPermutationSign σ : ℤ) : Qbar) * ∏ i : Jm, A i (σ i) := rfl
    -- 置換 `σ` を `d_m ∘ σ ∘ d_m⁻¹` へ移す全単射による有限和の再添字付け。
    _ = ∑ τ : Equiv.Perm (ZMod 4),
          Polynomial.C ((qbarPermutationSign (e.permCongr.symm τ) : ℤ) : Qbar) *
            ∏ i : Jm, A i (e.permCongr.symm τ i) :=
        Fintype.sum_equiv e.permCongr _ _ fun σ => by rw [Equiv.symm_apply_apply]
    -- 符号: `sgn_𝒥(d_m⁻¹ ∘ τ ∘ d_m) = sgn_{ℤ/4ℤ}(τ)`（`claim_permutation_sign_transport`）。
    _ = ∑ τ : Equiv.Perm (ZMod 4),
          Polynomial.C ((qbarPermutationSign τ : ℤ) : Qbar) *
            ∏ i : Jm, A i (e.permCongr.symm τ i) := by
        refine Finset.sum_congr rfl fun τ _ => ?_
        have hsign : qbarPermutationSign (e.permCongr.symm τ) = qbarPermutationSign τ := by
          have h := IndependentFiniteOrderedSign.finiteOrderedSign_permCongr e
            (e.permCongr.symm τ)
          rw [Equiv.apply_symm_apply] at h
          exact h.symm
        rw [hsign]
    -- 成分の有限積: `δ = d_m(i)` と再添字付けし、成分の等式を使う。
    _ = ∑ τ : Equiv.Perm (ZMod 4),
          Polynomial.C ((qbarPermutationSign τ : ℤ) : Qbar) * ∏ δ : ZMod 4, M δ (τ δ) := by
        refine Finset.sum_congr rfl fun τ _ => ?_
        congr 1
        refine Fintype.prod_equiv e (fun i : Jm => A i (e.permCongr.symm τ i))
          (fun δ : ZMod 4 => M δ (τ δ)) fun i => ?_
        rw [← hentry (e i) (τ (e i)), Equiv.symm_apply_apply]
        simp [Equiv.permCongr_apply]
    _ = qbarPolynomialDeterminant M := rfl
    _ = Matrix.det M := qbarPolynomialDeterminant_eq_mathlib M

end Ising2DLambda.KacWard
