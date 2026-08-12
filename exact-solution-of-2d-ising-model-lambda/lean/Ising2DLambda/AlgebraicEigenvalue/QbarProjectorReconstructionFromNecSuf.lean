/-
具体版が必要十分版の特殊化として得られることの導出。

根にわたる冪の和の値を係数の直交性として渡し、一般の有限線形結合の復元を
代数的数の列ベクトルの各成分へ特殊化する。

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarProjectorReconstruction
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarProjectorReconstruction

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset BigOperators Ising2DLambda.TransferMatrix

set_option maxHeartbeats 800000 in
/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarProjector_reconstruction_from_necSuf
    (L : ℕ) [NeZero L] [Fintype (RootOfUnity L)]
    (A : QbarRowMatrix L) (v : QbarRowVector L) :
    qbarVectorSum L Finset.univ (fun z : RootOfUnity L =>
      qbarVectorSmul L ((L : Qbar)⁻¹) (qbarProjector L A z.1 v)) = v := by
  funext τ
  have hL : 1 ≤ L := Nat.one_le_iff_ne_zero.mpr (NeZero.ne L)
  simp only [qbarVectorSum, qbarVectorSmul, qbarProjector]
  rw [← Finset.mul_sum, Finset.sum_comm]
  simp_rw [Finset.mul_sum]
  have hcoeff : ∀ k ∈ Finset.range L,
      (∑ z : RootOfUnity L, (z.1) ^ (L - k)) = if k = 0 then (L : Qbar) else 0 := by
    intro k hk
    rw [← powerSum, powerSumValue hL]
    by_cases hk0 : k = 0
    · subst k
      simp
    · have hklt : k < L := Finset.mem_range.mp hk
      have hlt : L - k < L :=
        Nat.sub_lt (Nat.pos_of_ne_zero (NeZero.ne L)) (Nat.pos_of_ne_zero hk0)
      have hndiv : ¬ L ∣ L - k := by
        intro hd
        obtain ⟨c, hc⟩ := hd
        have hcpos : 0 < c := by
          by_contra hc0
          rw [Nat.eq_zero_of_not_pos hc0, Nat.mul_zero] at hc
          omega
        exact (Nat.not_le_of_lt hlt) (hc ▸ Nat.le_mul_of_pos_right L hcpos)
      simp [hk0, hndiv]
  calc
    ∑ x ∈ range L, ∑ i : RootOfUnity L,
        (L : Qbar)⁻¹ * (i.1 ^ (L - x) * qbarAction L (qbarMatrixPow L A x) v τ)
        = (L : Qbar)⁻¹ *
            (∑ x ∈ range L, (∑ i : RootOfUnity L, i.1 ^ (L - x)) *
              qbarAction L (qbarMatrixPow L A x) v τ) := by
          rw [Finset.mul_sum]
          apply Finset.sum_congr rfl
          intro x hx
          rw [← Finset.mul_sum, Finset.sum_mul]
    _ = qbarAction L (qbarMatrixPow L A 0) v τ := by
          simpa only [smul_eq_mul] using
            (NecSuf.AlgebraicEigenvalue.finite_orthogonal_reconstruction_necSuf
              (ι := RootOfUnity L) (κ := ℕ) (K := Qbar) (V := Qbar)
              (s := range L) (k₀ := 0) (Finset.mem_range.mpr hL)
              (c := (L : Qbar)) (by exact_mod_cast (NeZero.ne L))
              (α := fun i x => i.1 ^ (L - x))
              (u := fun x => qbarAction L (qbarMatrixPow L A x) v τ) hcoeff)
    _ = v τ := by
          have hact : qbarAction L (qbarMatrixPow L A 0) v = v :=
            qbarIdentity_action L v
          rw [congrFun hact τ]

end Ising2DLambda.AlgebraicEigenvalue
