/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版 `NecSuf.FreeEntropy.sub_eq_sub_of_mul_eq_mul` に
  G := ℤ
  e := n ↦ (v_p(n) : ℤ)   （素数 p を固定した指数）
を代入すると、具体版 `FreeEntropy.rationalExponent_well_defined` が出る。
残るのは Step 1（分母を払って `a b' = a' b` を得ること）だけであり、これは
必要十分版が仮定として受け取っている部分である。

このことは、具体版の証明が「素数であること」「指数が素因数分解から来ること」
「台が有限であること」を使っていないという主張の裏取りになっている。

住処: ℕ と ℤ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalExponent
import Ising2DLambda.NecSuf.FreeEntropy.RationalExponent

namespace Ising2DLambda.FreeEntropy

/-- 具体版の定理を、必要十分版から導いたもの。 -/
theorem rationalExponent_well_defined_from_necSuf (p : Nat.Primes) {a b a' b' : ℕ}
    (ha : a ≠ 0) (hb : b ≠ 0) (ha' : a' ≠ 0) (hb' : b' ≠ 0)
    (h : (a : ℚ) / b = (a' : ℚ) / b') :
    rationalExponent p a b = rationalExponent p a' b' :=
  NecSuf.FreeEntropy.sub_eq_sub_of_mul_eq_mul
    (fun n : ℕ => (primeExponent p n : ℤ))
    (fun {m n} hm hn => by exact_mod_cast congrArg (Nat.cast : ℕ → ℤ) (primeExponent_mul hm hn p))
    ha hb ha' hb' (mul_eq_mul_of_div_eq_div hb hb' h)

end Ising2DLambda.FreeEntropy
