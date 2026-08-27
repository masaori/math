/-
接続の第六段の第六歩。前歩で得た「有理点の既約分母は破れ数ゼロの多重度と
底の既約分母の点数乗との積を割る」を、実際の自由境界の箱へ渡す一段。

渡すのに要るのは二つだけである。一つは回文性 `Ω_L(#E_L) = Ω_L(0)`
（`NullModel.multiplicity_palindrome` を破れ数 `#E_L` で読む）。
もう一つは破れ数ゼロの多重度がちょうど `2` であること
（`NullModel.multiplicity_zero_eq_two`）。この二つを入れると、
前歩の結論の右辺が `2 * c.den ^ N` という箱に依存しない形になる。

一つの箱に固定した有限の主張であり、極限も無限和も現れない。
-/
import Ising3DCut.LimitQuantity.EventuallyConstantOnlyAtOneBundle
import Ising3DCut.LimitQuantity.NullModelEvalNeInv
import Ising3DCut.NullModel.MultiplicityPalindrome
import Ising3DCut.NullModel.ZeroBreakageConstant

namespace Ising3DCut.LimitQuantity

/-- 自由境界の箱 `L` の多重度を入れると、前歩の整除は
`q.den ∣ 2 * c.den ^ N` という箱に依存しない形になる。 -/
theorem point_den_dvd_two_mul_base_den_pow_from_free_box
    {q c : ℚ} {L N : ℕ} (hL : 0 < L) (hc : 0 < c)
    (hE : 1 ≤ Fintype.card (NullModel.Edge L))
    (hrep : (brokenCountSum (NullModel.multiplicity L) q.num.natAbs q.den
          (Fintype.card (NullModel.Edge L)) : ℚ) /
        (q.den : ℚ) ^ (Fintype.card (NullModel.Edge L)) = c ^ N) :
    q.den ∣ 2 * c.den ^ N := by
  have hpal : NullModel.multiplicity L (Fintype.card (NullModel.Edge L)) = NullModel.multiplicity L 0 := by
    have h := NullModel.multiplicity_palindrome (L := L) (m := Fintype.card (NullModel.Edge L)) (le_refl _)
    simpa using h
  have hdvd := point_den_dvd_zero_multiplicity_mul_base_den_pow_from_finite_box
    (q := q) (c := c) (E := Fintype.card (NullModel.Edge L)) (N := N)
    (NullModel.multiplicity L) hc hE hpal hrep
  rwa [NullModel.multiplicity_zero_eq_two hL] at hdvd

/-- 閾値の箱が少なくとも二点幅なら、末尾の点数乗表示そのものから
束ね定理が要求する法 `q.den` の整除が得られる。 -/
theorem point_den_dvd_two_mul_base_den_pow_of_rational_value_form
    {q c : ℚ} {L₀ : ℕ} (hq : 0 < q) (hL₀ : 2 ≤ L₀) (hc : 0 < c)
    (hform : ∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) :
    q.den ∣ 2 * c.den ^ (L₀ ^ 3) := by
  apply point_den_dvd_two_mul_base_den_pow_from_free_box
    (L := L₀) (N := L₀ ^ 3) (lt_of_lt_of_le (by norm_num) hL₀) hc
    (one_le_card_edge hL₀)
  calc
    (brokenCountSum (NullModel.multiplicity L₀) q.num.natAbs q.den
          (Fintype.card (NullModel.Edge L₀)) : ℚ) /
        (q.den : ℚ) ^ (Fintype.card (NullModel.Edge L₀))
        = rationalValueSeq q L₀ := by
          have hqrep : q = (q.num.natAbs : ℚ) / (q.den : ℚ) := by
            rw [Nat.cast_natAbs, abs_of_pos (Rat.num_pos.mpr hq), Rat.num_div_den]
          simp only [brokenCountSum, rationalValueSeq, NullModel.partitionPolynomial,
            evalAtRational, map_sum, Polynomial.coe_eval₂RingHom,
            Polynomial.eval₂_monomial, eq_intCast]
          rw [div_eq_iff (pow_ne_zero _ (by exact_mod_cast q.den_nz)), Finset.sum_mul]
          push_cast
          apply Finset.sum_congr rfl
          intro m hm
          have hmle : m ≤ Fintype.card (NullModel.Edge L₀) :=
            Nat.le_of_lt_succ (Finset.mem_range.mp hm)
          have hpow : q ^ m * (q.den : ℚ) ^ Fintype.card (NullModel.Edge L₀) =
              (q.num.natAbs : ℚ) ^ m * (q.den : ℚ) ^
                (Fintype.card (NullModel.Edge L₀) - m) := by
            nth_rewrite 1 [hqrep]
            rw [div_pow]
            field_simp
            rw [← pow_add, Nat.add_sub_of_le hmle]
          simpa [mul_assoc] using
            congrArg (fun x : ℚ => (NullModel.multiplicity L₀ m : ℚ) * x) hpow.symm
    _ = c ^ (L₀ ^ 3) := hform L₀ (le_refl _)

end Ising3DCut.LimitQuantity
