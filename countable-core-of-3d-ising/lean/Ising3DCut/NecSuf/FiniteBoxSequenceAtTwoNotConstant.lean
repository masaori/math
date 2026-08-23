/-
「有理点 2 では有限箱の量の列は定数列でない」の Lean 必要十分版。

具体版が実際に使っているのは次の三つだけである。
片方の添字での値が分かっていること、もう片方の添字での値が冪の等式を満たすこと、
そしてその二つが両立しないこと。Ising 分配多項式・正の実数乗根・実数の順序は、
この二つの仮定を用意する具体版の段にだけ属するので落とす。
冪だけが残るのでモノイドで足り、添字の型も一般の型でよい。
箱の大きさの極限は使わない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising3DCut.NecSuf

/-- 一方の添字で値が `c` に定まり、他方の添字の `n` 乗が `v` であって、
`c ^ n ≠ v` ならば、その族は定数族でない。 -/
theorem not_constant_of_pow_ne {M : Type*} [Monoid M] {ι : Type*}
    (f : ι → M) (i j : ι) (n : ℕ) (c v : M)
    (hi : f i = c) (hj : f j ^ n = v) (hne : c ^ n ≠ v) :
    ¬ ∃ d : M, f = fun _ => d := by
  rintro ⟨d, hd⟩
  apply hne
  have hfi : f i = d := congrFun hd i
  have hfj : f j = d := congrFun hd j
  rw [← hi, hfi, ← hfj, hj]

end Ising3DCut.NecSuf
