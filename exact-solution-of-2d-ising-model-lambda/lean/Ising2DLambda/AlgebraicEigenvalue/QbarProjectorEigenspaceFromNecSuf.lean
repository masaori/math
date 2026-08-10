/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  V := Qbar（代数的数）   n := L-1   g := (i ↦ z^{L+1-i} a_i)   a_k := (A^k·v)(τ)
  h_bdry := 準備 2（a_L = a_0）と準備 3（z^{L+1} = z）から出る境界の 2 項の一致

すなわち、添字をずらす段が要求するのは「和が可換で消去できること」と
「境界の 2 項が一致すること」だけである。行列であることも、係数が冪の形であることも、
値が代数的数であることも使っていない。`A^L = I` と `z^L = 1` は、境界の 2 項の一致
（h_bdry）を作るためだけに使う。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarProjectorEigenspace
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ProjectorImageEigenspace

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarProjector_mem_eigenspace_from_necSuf (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L)
    (hA : qbarMatrixPow L A L = qbarIdentityMatrix L) (hz : z ^ L = 1) :
    qbarProjector L A z v ∈ qbarEigenspace L A z := by
  obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (NeZero.ne L)
  show qbarAction (n + 1) A (qbarProjector (n + 1) A z v)
      = qbarVectorSmul (n + 1) z (qbarProjector (n + 1) A z v)
  rw [qbarProjector_action (n + 1) A z v]
  funext τ
  set a : ℕ → Qbar := fun k => qbarAction (n + 1) (qbarMatrixPow (n + 1) A k) v τ with ha
  set g : ℕ → Qbar := fun i => z ^ (n + 1 + 1 - i) * a i with hg
  have h_aL : a (n + 1) = v τ := by
    have : qbarAction (n + 1) (qbarMatrixPow (n + 1) A (n + 1)) v = v := by
      rw [hA]; exact qbarIdentity_action (n + 1) v
    simpa [ha] using congrFun this τ
  have h_a0 : a 0 = v τ := by
    have : qbarAction (n + 1) (qbarMatrixPow (n + 1) A 0) v = v :=
      qbarIdentity_action (n + 1) v
    simpa [ha] using congrFun this τ
  have h_prep3 : z ^ (n + 1 + 1) = z := by rw [pow_succ, hz, one_mul]
  have h_bdry : g (n + 1) = g 0 := by
    have h1 : g (n + 1) = z * v τ := by simp [hg, h_aL]
    have h2 : g 0 = z * v τ := by simp [hg, h_a0, h_prep3]
    rw [h1, h2]
  have h_left : ∀ k, z ^ (n + 1 - k) * a (k + 1) = g (k + 1) := by
    intro k; simp [hg, Nat.succ_sub_succ]
  have h_right : ∀ k ∈ range (n + 1), z * (z ^ (n + 1 - k) * a k) = g k := by
    intro k hk
    have hk' : k ≤ n + 1 := Nat.le_of_lt_succ (Nat.lt_succ_of_lt (mem_range.mp hk))
    have hsub : n + 1 + 1 - k = (n + 1 - k) + 1 := Nat.succ_sub hk'
    rw [hg]
    simp only [hsub, pow_succ]
    ring
  calc ∑ k ∈ range (n + 1), z ^ (n + 1 - k) * a (k + 1)
      = ∑ k ∈ range (n + 1), g (k + 1) := sum_congr rfl fun k _ => h_left k
    _ = ∑ k ∈ range (n + 1), g k :=
        NecSuf.AlgebraicEigenvalue.projector_image_eigenspace_necSuf n g h_bdry
    _ = ∑ k ∈ range (n + 1), z * (z ^ (n + 1 - k) * a k) :=
        sum_congr rfl fun k hk => (h_right k hk).symm
    _ = z * ∑ k ∈ range (n + 1), z ^ (n + 1 - k) * a k := (mul_sum _ _ _).symm

end Ising2DLambda.AlgebraicEigenvalue
