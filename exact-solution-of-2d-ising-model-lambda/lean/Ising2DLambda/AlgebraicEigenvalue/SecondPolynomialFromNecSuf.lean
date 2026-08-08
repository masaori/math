/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版 `NecSuf.AlgebraicEigenvalue` の 5 つの補題に
  S := Polynomial ℤ（すなわち人手証明の ℤ[x]）
を代入すると、具体版の 4 主張がそのまま出る。書き換えが 1 箇所だけ要るのは、具体版の
`MonicDeg` が最高次の係数を `κ(1)` と書いているのに対し、必要十分版が係数環の単位元 `1` と
書いている点である（`constPoly_one : constPoly 1 = 1` で移る）。

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
係数が整数であること・不定元 `x` があること・`ℤ[x]` に零因子が無いこと・引き算（環であること）。
2 つの元についての補題については、積の可換性も使っていない
（必要十分版はそこを `[Semiring S]` で証明してある）。

住処: ℤ[x] と ℕ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.SecondPolynomial
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.SecondPolynomial

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 具体版の `DegLe` は、必要十分版の `DegLe` に `S := Polynomial ℤ` を代入したものである。 -/
theorem degLe_iff_necSuf (f : SecondPoly) (n : ℕ) :
    DegLe f n ↔ NecSuf.AlgebraicEigenvalue.DegLe f n := Iff.rfl

/-- 具体版の `MonicDeg` は、必要十分版の `MonicDeg` に `S := Polynomial ℤ` を代入したものである
（最高次の係数の書き方だけが `κ(1)` と `1` で異なる）。 -/
theorem monicDeg_iff_necSuf (f : SecondPoly) (n : ℕ) :
    MonicDeg f n ↔ NecSuf.AlgebraicEigenvalue.MonicDeg f n := by
  simp [MonicDeg, NecSuf.AlgebraicEigenvalue.MonicDeg,
    NecSuf.AlgebraicEigenvalue.DegLe, DegLe, constPoly_one]

/-- 次数が `n` 以下である元の有限和の具体版を、必要十分版から導いたもの。 -/
theorem degLe_sum_from_necSuf {ι : Type*} {T : Finset ι} {f : ι → SecondPoly} {n : ℕ}
    (h : ∀ s ∈ T, DegLe (f s) n) : DegLe (∑ s ∈ T, f s) n :=
  NecSuf.AlgebraicEigenvalue.degLe_sum h

/-- 次数の上界が有限積で足し合わされることの具体版を、必要十分版から導いたもの。 -/
theorem degLe_prod_from_necSuf {ι : Type*} {f : ι → SecondPoly} {n : ι → ℕ} {T : Finset ι}
    (h : ∀ s ∈ T, DegLe (f s) (n s)) : DegLe (∏ s ∈ T, f s) (∑ s ∈ T, n s) :=
  NecSuf.AlgebraicEigenvalue.degLe_prod h

/-- モニックな元の有限積についての具体版を、必要十分版から導いたもの。 -/
theorem monicDeg_prod_from_necSuf {ι : Type*} {f : ι → SecondPoly} {n : ι → ℕ} {T : Finset ι}
    (h : ∀ s ∈ T, MonicDeg (f s) (n s)) : MonicDeg (∏ s ∈ T, f s) (∑ s ∈ T, n s) :=
  (monicDeg_iff_necSuf _ _).mpr
    (NecSuf.AlgebraicEigenvalue.monicDeg_prod
      fun s hs => (monicDeg_iff_necSuf _ _).mp (h s hs))

/-- モニックな元に次数の低い元を足す主張の具体版を、必要十分版から導いたもの。 -/
theorem monicDeg_add_of_degLe_from_necSuf {f g : SecondPoly} {n n' : ℕ}
    (hf : MonicDeg f n) (hg : DegLe g n') (hlt : n' < n) : MonicDeg (f + g) n :=
  (monicDeg_iff_necSuf _ _).mpr
    (NecSuf.AlgebraicEigenvalue.monicDeg_add_of_degLe
      ((monicDeg_iff_necSuf _ _).mp hf) hg hlt)

end Ising2DLambda.AlgebraicEigenvalue
