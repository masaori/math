/-
章「熱力学極限」の「根の重複度が 1 以上であることと、その点で値が零であることは同じである」
（`claim_qbar_root_multiplicity_ge_one_iff_root`）の具体版。人手証明と 1 対 1 に対応させる。

  人手証明                                                          このファイル
  mult ≥ 1 ⇒ m := mult - 1、(t-ŵ)^{m+1} ∣ f の証人 g                `qbarRootMultiplicity_divides`
  aev_w(t-ŵ) = aev_w(t) - aev_w(ŵ) = w - w = 0                      `hlin`
  鎖 aev_w(f) = aev_w((t-ŵ)^m)·0·aev_w(g) = 0                       `calc`（代入が積を保つ）
  aev_w(f) = 0 ⇒ 上界 n_f で (t-ŵ)^1 ∣ f ⇒ 1 ≤ mult                 `qbarLinearFactorPowDivides_one_of_root`,
                                                                     `qbarRootMultiplicity_ge_of_divides`

住処: Q̄（実数体・複素数体は現れない）。`natDegree` は使わず係数で書く。
-/
import Ising2DLambda.ThermodynamicLimit.QbarRootMultiplicity
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalIndeterminatePow

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

theorem qbarRootMultiplicityGeOneIffRoot (w : Qbar) (f : QbarPoly) (hf : f ≠ 0) :
    1 ≤ qbarRootMultiplicity w f hf ↔ qbarPolyEval w f = 0 := by
  constructor
  · -- mult ≥ 1 から aev_w(f) = 0。
    intro hge
    -- 重複度そのものは以下では使わないので、指数 k（1 以上）と整除の証人 g へ移す。
    obtain ⟨k, hk, g, hg⟩ :
        ∃ k : ℕ, 1 ≤ k ∧ ∃ g : QbarPoly, f = (Polynomial.X - qbarConst w) ^ k * g :=
      ⟨qbarRootMultiplicity w f hf, hge, qbarRootMultiplicity_divides w f hf⟩
    obtain ⟨m, hm⟩ := Nat.exists_eq_add_of_le hk
    -- 準備: aev_w(t - ŵ) = w - w = 0。
    have hlin : qbarPolyEval w (Polynomial.X - qbarConst w) = 0 := by
      rw [qbarPolyEval_eq_eval, Polynomial.eval_sub, Polynomial.eval_X, qbarConst,
        Polynomial.eval_C, sub_self]
    -- 鎖（代入が積を保つことを二回使う）。
    calc qbarPolyEval w f
        = qbarPolyEval w ((Polynomial.X - qbarConst w) ^ k * g) := by
          rw [hg]
      _ = qbarPolyEval w
            ((Polynomial.X - qbarConst w) ^ m * (Polynomial.X - qbarConst w) * g) := by
          rw [hm, add_comm 1 m, pow_succ]
      _ = qbarPolyEval w ((Polynomial.X - qbarConst w) ^ m)
            * qbarPolyEval w (Polynomial.X - qbarConst w) * qbarPolyEval w g := by
          simp only [qbarPolyEval_eq_eval, Polynomial.eval_mul]
      _ = qbarPolyEval w ((Polynomial.X - qbarConst w) ^ m) * 0 * qbarPolyEval w g := by
          rw [hlin]
      _ = 0 := by
          rw [mul_zero, zero_mul]
  · -- aev_w(f) = 0 から mult ≥ 1（上界 n_f で (t-ŵ)^1 ∣ f）。
    intro hroot
    have hone : qbarLinearFactorPowDivides w 1 f :=
      qbarLinearFactorPowDivides_one_of_root f w (qbarPolyTopIndex f hf)
        (qbarPolyTopIndex_coeff_bound f hf) hroot
    exact qbarRootMultiplicity_ge_of_divides w f hf 1 hone

end Ising2DLambda.ThermodynamicLimit
