/-
章「固有値の代数性」の主張「固有空間へ落とす写像から列ベクトルを復元できる」の具体版。

人手証明の正本は `structured-latex/content/main-text.ts`。
一つの成分で有限和を開き、1 の L 乗根にわたる冪の和の値によって
k = 0 の項だけを残す。

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarProjector
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSumValue

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset BigOperators Ising2DLambda.TransferMatrix

set_option maxHeartbeats 800000 in
/-- 1 の `L` 乗根ごとの落とす写像の像を `L`で割って足すと、もとの列ベクトルに戻る。 -/
theorem qbarProjector_reconstruction (L : ℕ) [NeZero L] [Fintype (RootOfUnity L)]
    (A : QbarRowMatrix L) (v : QbarRowVector L) :
    qbarVectorSum L Finset.univ (fun z : RootOfUnity L =>
      qbarVectorSmul L ((L : Qbar)⁻¹) (qbarProjector L A z.1 v)) = v := by
  funext τ
  have hL : 1 ≤ L := Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)
  simp only [qbarVectorSum, qbarVectorSmul, qbarProjector]
  rw [← Finset.mul_sum]
  rw [Finset.sum_comm]
  simp_rw [Finset.mul_sum]
  have hcoeff : ∀ k ∈ Finset.range L,
      (∑ z : RootOfUnity L, (z.1) ^ (L - k)) = if k = 0 then (L : Qbar) else 0 := by
    intro k hk
    rw [← powerSum]
    rw [powerSumValue hL]
    by_cases hk0 : k = 0
    · subst k
      simp
    · have hklt : k < L := Finset.mem_range.mp hk
      have hpos : 0 < L - k := Nat.sub_pos_of_lt hklt
      have hlt : L - k < L := Nat.sub_lt (Nat.pos_of_ne_zero (NeZero.ne L)) (Nat.pos_of_ne_zero hk0)
      have hndiv : ¬ L ∣ L - k := by
        intro hd
        obtain ⟨c, hc⟩ := hd
        have hcpos : 0 < c := by
          by_contra hc0
          have hcz : c = 0 := Nat.eq_zero_of_not_pos hc0
          rw [hcz, Nat.mul_zero] at hc
          omega
        have : L ≤ L - k := by
          rw [hc]
          exact Nat.le_mul_of_pos_right L hcpos
        exact (Nat.not_le_of_lt hlt) this
      simp [hk0, hndiv]
  calc
    ∑ x ∈ range L, ∑ i : RootOfUnity L,
        (L : Qbar)⁻¹ * (i.1 ^ (L - x) * qbarAction L (qbarMatrixPow L A x) v τ)
        = ∑ x ∈ range L, (L : Qbar)⁻¹ *
            ((∑ i : RootOfUnity L, i.1 ^ (L - x)) *
              qbarAction L (qbarMatrixPow L A x) v τ) := by
          apply Finset.sum_congr rfl
          intro x hx
          rw [← Finset.mul_sum, Finset.sum_mul]
    _ = (L : Qbar)⁻¹ *
          (∑ x ∈ range L, (∑ i : RootOfUnity L, i.1 ^ (L - x)) *
            qbarAction L (qbarMatrixPow L A x) v τ) := by
          rw [Finset.mul_sum]
    _ = qbarAction L (qbarMatrixPow L A 0) v τ := by
          have hsum :
              (∑ x ∈ range L, (∑ i : RootOfUnity L, i.1 ^ (L - x)) *
                qbarAction L (qbarMatrixPow L A x) v τ) =
                (L : Qbar) * qbarAction L (qbarMatrixPow L A 0) v τ := by
            rw [Finset.sum_eq_single 0]
            · rw [hcoeff 0 (Finset.mem_range.mpr hL)]
              simp
            · intro b hb hb0
              rw [hcoeff b hb, if_neg hb0, zero_mul]
            · exact fun h => (h (Finset.mem_range.mpr hL)).elim
          rw [hsum]
          rw [← mul_assoc, inv_mul_cancel₀ (by exact_mod_cast (NeZero.ne L)), one_mul]
    _ = v τ := by
          have hact : qbarAction L (qbarMatrixPow L A 0) v = v :=
            qbarIdentity_action L v
          rw [congrFun hact τ]

end Ising2DLambda.AlgebraicEigenvalue
