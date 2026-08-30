/-
必要十分版: 軌道ごとの置換符号 `(-1)^(n-1)` と、成分積から出る
`(-x)^n w` を掛けると、各軌道の寄与が `-x^n w` になる。

使う構造は可換環、有限積、各軌道の大きさが正であることだけである。
軌道・置換・行列・多項式は使わない。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.KacWard

open Finset

variable {I R : Type*} [CommRing R]

/-- 符号因子と `(-x)` の冪を軌道ごとに結合する。 -/
theorem signedOrbitWeights_combine (s : Finset I) (n : I → ℕ) (w : I → R) (x : R)
    (hn : ∀ i ∈ s, 1 ≤ n i) :
    (∏ i ∈ s, (-1 : R) ^ (n i - 1)) *
        (∏ i ∈ s, (-x) ^ n i * w i) =
      ∏ i ∈ s, -(x ^ n i) * w i := by
  rw [← Finset.prod_mul_distrib]
  refine Finset.prod_congr rfl ?_
  intro i hi
  have hpos := hn i hi
  obtain ⟨k, hk⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : n i ≠ 0)
  rw [hk]
  simp only [Nat.succ_sub_one, pow_succ]
  ring_nf
  simp [mul_comm k 2, pow_mul]

end Ising2DLambda.NecSuf.KacWard
