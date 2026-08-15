/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版 `NecSuf.FreeEntropy.cross_mul_eq_of_pointwise_sub_eq_necSuf` に
  I := Nat.Primes, G := ℤ, e := p ↦ n ↦ (v_p(n) : ℤ)
を代入し、数の分離（すべての素数で指数が一致すれば等しい）に有限積表示
`nat_eq_of_primeExponent_eq` を渡すと、(i)+(ii) の `a b' = a' b` が出る。
残る (iii) は ℚ の約分だけである。

住処: ℕ・ℤ・ℚ・Λ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalLogInjective
import Ising2DLambda.NecSuf.FreeEntropy.RationalLogInjective

namespace Ising2DLambda.FreeEntropy

/-- 具体版の定理を、必要十分版から導いたもの。 -/
theorem logRat_injective_of_pos_from_necSuf {q q' : ℚ} (hq : 0 < q) (hq' : 0 < q')
    (h : logRat q = logRat q') : q = q' := by
  have ha : q.num.natAbs ≠ 0 := Int.natAbs_ne_zero.mpr (Rat.num_ne_zero.mpr hq.ne')
  have ha' : q'.num.natAbs ≠ 0 := Int.natAbs_ne_zero.mpr (Rat.num_ne_zero.mpr hq'.ne')
  have hb : q.den ≠ 0 := q.den_nz
  have hb' : q'.den ≠ 0 := q'.den_nz
  -- (i)+(ii) を必要十分版から
  have hnat : q.num.natAbs * q'.den = q'.num.natAbs * q.den :=
    NecSuf.FreeEntropy.cross_mul_eq_of_pointwise_sub_eq_necSuf
      (fun (p : Nat.Primes) (n : ℕ) => (primeExponent p n : ℤ))
      (fun p {m n} hm hn => by exact_mod_cast congrArg (Nat.cast : ℕ → ℤ) (primeExponent_mul hm hn p))
      (fun {m n} hm hn hall => nat_eq_of_primeExponent_eq hm hn (fun p => by exact_mod_cast hall p))
      ha hb ha' hb'
      (fun p => by
        have := congrArg (fun l : LogOrderGroup => l p) h
        simpa [logRat_apply, rationalExponent] using this)
  -- (iii) ℚ の約分
  rw [Rat.eq_iff_mul_eq_mul]
  have hz : ((q.num.natAbs * q'.den : ℕ) : ℤ) = ((q'.num.natAbs * q.den : ℕ) : ℤ) := by
    exact_mod_cast hnat
  push_cast at hz
  rw [abs_of_pos (Rat.num_pos.mpr hq), abs_of_pos (Rat.num_pos.mpr hq')] at hz
  exact hz

end Ising2DLambda.FreeEntropy
