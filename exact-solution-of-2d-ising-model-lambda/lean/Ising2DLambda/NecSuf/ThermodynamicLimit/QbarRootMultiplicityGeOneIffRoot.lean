/-
「根の重複度が 1 以上であることと、その点で値が零であることは同じである」の必要十分版。

重複度そのもの（最大元）を経由せず、同じ内容を「指数 1 以上の整除が存在すること」で述べる
（具体版では最大元の読み取り 1・2 でこの形と重複度が結ばれる）。
必要なのは可換環だけである（一次式 X - C w に加法の逆元が要り、
因数定理 `Polynomial.dvd_iff_isRoot` が可換環で成り立つ）。体・代数閉性・零因子の非存在は要らない。
-/
import Mathlib.Algebra.Polynomial.Roots

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Polynomial

theorem poly_root_multiplicity_ge_one_iff_root_necSuf {R : Type*} [CommRing R]
    (w : R) (f : R[X]) :
    (∃ k : ℕ, 1 ≤ k ∧ (X - Polynomial.C w) ^ k ∣ f) ↔ f.eval w = 0 := by
  constructor
  · -- 指数 1 以上の整除から、一次因子そのものが割り切ることを経て値が零であること。
    intro h
    obtain ⟨k, hk, g, hg⟩ := h
    obtain ⟨m, hm⟩ := Nat.exists_eq_add_of_le hk
    have hdvd : (X - Polynomial.C w) ∣ f := by
      refine ⟨(X - Polynomial.C w) ^ m * g, ?_⟩
      rw [hg, hm, pow_add, pow_one, mul_assoc]
    exact (Polynomial.dvd_iff_isRoot).mp hdvd
  · -- 値が零なら因数定理で一次因子が割り切るので、k := 1 が証人になる。
    intro h
    exact ⟨1, le_rfl, by rw [pow_one]; exact (Polynomial.dvd_iff_isRoot).mpr h⟩

end Ising2DLambda.NecSuf.ThermodynamicLimit
