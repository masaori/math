/-
章「熱力学極限」の「一次因子を 1 つ割り出すと、その点の重複度は 1 しか下がらない」
（`claim_qbar_root_multiplicity_le_quotient_succ`）の具体版。人手証明と 1 対 1 に対応させる。

  人手証明                                                          このファイル
  g = 0 なら f = (t-ŵ)·0 = 0 で矛盾、よって g ≠ 0                    `qbarQuotientNeZero`
  M := mult_w(f)、M = 0 の場合は ℕ の順序で済む                       `rcases … Nat.eq_zero_or_pos`
  M = M'+1 のとき読み取り 1 で f = (t-ŵ)^{M'+1}h の証人 h            `qbarRootMultiplicity_divides`
  (t-ŵ)((t-ŵ)^{M'}h) = (t-ŵ)^{M'+1}h = f = (t-ŵ)g                    `calc`（三段）
  非零係数の番号の最大元の大きい方を n として一次因子を消去           `qbarPolyLinearFactorCancellation`
  (t-ŵ)^{M'} ∣ g、読み取り 2 で M' ≤ mult_w(g)                        `qbarRootMultiplicity_ge_of_divides`

住処: Q̄（実数体・複素数体は現れない）。
-/
import Ising2DLambda.ThermodynamicLimit.QbarRootMultiplicity
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorCancellation

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

/-- `f = (t-ŵ)g` と `f ≠ 0` から `g ≠ 0`（`g = 0` なら積は零元になる）。 -/
theorem qbarQuotientNeZero (w : Qbar) (f g : QbarPoly) (hf : f ≠ 0)
    (hfg : f = (Polynomial.X - qbarConst w) * g) : g ≠ 0 := by
  intro hg0
  exact hf (by rw [hfg, hg0, mul_zero])

theorem qbarRootMultiplicityLeQuotientSucc (w : Qbar) (f g : QbarPoly) (hf : f ≠ 0) (hg : g ≠ 0)
    (hfg : f = (Polynomial.X - qbarConst w) * g) :
    qbarRootMultiplicity w f hf ≤ qbarRootMultiplicity w g hg + 1 := by
  rcases Nat.eq_zero_or_pos (qbarRootMultiplicity w f hf) with hzero | hpos
  · omega
  · -- M = M' + 1 と書き、読み取り 1 で整除の証人 h を取る。
    obtain ⟨M', hM'⟩ : ∃ M' : ℕ, qbarRootMultiplicity w f hf = M' + 1 :=
      ⟨qbarRootMultiplicity w f hf - 1, by omega⟩
    obtain ⟨h, hh⟩ := qbarRootMultiplicity_divides w f hf
    rw [hM'] at hh
    -- A := (t-ŵ)^{M'}·h は零でない（零なら上の等式から f = 0 になる）。
    have hA : (Polynomial.X - qbarConst w) ^ M' * h ≠ 0 := by
      intro hA0
      refine hf ?_
      calc f = (Polynomial.X - qbarConst w) ^ (M' + 1) * h := hh
        _ = (Polynomial.X - qbarConst w) * ((Polynomial.X - qbarConst w) ^ M' * h) := by ring
        _ = 0 := by rw [hA0, mul_zero]
    -- 一次因子を掛けた形が一致する。
    have hmul : (Polynomial.X - qbarConst w) * ((Polynomial.X - qbarConst w) ^ M' * h)
        = (Polynomial.X - qbarConst w) * g := by
      calc (Polynomial.X - qbarConst w) * ((Polynomial.X - qbarConst w) ^ M' * h)
          = (Polynomial.X - qbarConst w) ^ (M' + 1) * h := by ring
        _ = f := hh.symm
        _ = (Polynomial.X - qbarConst w) * g := hfg
    -- 係数の上界は、両者の非零係数の番号の最大元の大きい方を取る。
    set n := max (qbarPolyTopIndex ((Polynomial.X - qbarConst w) ^ M' * h) hA)
      (qbarPolyTopIndex g hg) with hn
    have hAbound : ∀ k, n < k → ((Polynomial.X - qbarConst w) ^ M' * h).coeff k = 0 := by
      intro k hk
      exact qbarPolyTopIndex_coeff_bound _ hA k (lt_of_le_of_lt (le_max_left _ _) hk)
    have hgbound : ∀ k, n < k → g.coeff k = 0 := by
      intro k hk
      exact qbarPolyTopIndex_coeff_bound g hg k (lt_of_le_of_lt (le_max_right _ _) hk)
    have hcancel : (Polynomial.X - qbarConst w) ^ M' * h = g :=
      qbarPolyLinearFactorCancellation w _ g n hAbound hgbound hmul
    -- 読み取り 2 で M' ≤ mult_w(g)。
    have hle : M' ≤ qbarRootMultiplicity w g hg :=
      qbarRootMultiplicity_ge_of_divides w g hg M' ⟨h, hcancel.symm⟩
    omega

end Ising2DLambda.ThermodynamicLimit
