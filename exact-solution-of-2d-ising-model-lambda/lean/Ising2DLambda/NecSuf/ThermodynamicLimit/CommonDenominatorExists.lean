/-
「有理係数の対数順序群の元は共通分母を持つ」の必要十分版。

使うのは、有限集合 `S` の外で `f` が `0` であること、`S` の各点に「分母」`d p ≥ 1` と
「分子」`w p` があって `d p · f p = toK (w p)` を満たすこと、`toK` が `ℕ` 倍を保つこと、
そして値の側 `K` が可換半環であること（`ℕ` の積の像・結合則・可換則・`0` との積）だけである。
有理数であることも、素数であることも、既約分数の一意性も本質でない（既約性は
`den · f = num` を与える一つの手段にすぎない）。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {P K : Type*} [CommSemiring K] [DecidableEq P]

theorem denominator_product_clears_necSuf
    (S : Finset P) (f : P → K) (hf : ∀ p, p ∉ S → f p = 0)
    (d : P → ℕ) (hd : ∀ p, 1 ≤ d p)
    (w : P → ℤ) (toK : ℤ → K)
    (hw : ∀ p, p ∈ S → ((d p : ℕ) : K) * f p = toK (w p))
    (htoK_nsmul : ∀ (n : ℕ) (m : ℤ), toK ((n : ℤ) * m) = (n : K) * toK m)
    (htoK_zero : toK 0 = 0) :
    let N := S.prod d
    let ν : P → ℤ := fun p => if p ∈ S then ((N / d p : ℕ) : ℤ) * w p else 0
    1 ≤ N ∧ ∀ p, ((N : ℕ) : K) * f p = toK (ν p) := by
  intro N ν
  refine ⟨?_, ?_⟩
  · -- 1 以上の整数の有限積は 1 以上（空積は 1）
    exact Nat.one_le_iff_ne_zero.mpr
      (Finset.prod_ne_zero_iff.mpr (fun p _ => Nat.one_le_iff_ne_zero.mp (hd p)))
  · intro p
    by_cases hp : p ∈ S
    · have hdvd : d p ∣ N := Finset.dvd_prod_of_mem d hp
      calc
        ((N : ℕ) : K) * f p
            = (((N / d p * d p : ℕ) : K)) * f p := by rw [Nat.div_mul_cancel hdvd]
        _ = (((N / d p : ℕ) : K)) * (((d p : ℕ) : K) * f p) := by rw [Nat.cast_mul, mul_assoc]
        _ = (((N / d p : ℕ) : K)) * toK (w p) := by rw [hw p hp]
        _ = toK ((((N / d p : ℕ) : ℤ)) * w p) := (htoK_nsmul _ _).symm
        _ = toK (ν p) := by simp only [ν, if_pos hp]
    · calc
        ((N : ℕ) : K) * f p = ((N : ℕ) : K) * 0 := by rw [hf p hp]
        _ = 0 := mul_zero _
        _ = toK 0 := htoK_zero.symm
        _ = toK (ν p) := by simp only [ν, if_neg hp]

end Ising2DLambda.NecSuf.ThermodynamicLimit
