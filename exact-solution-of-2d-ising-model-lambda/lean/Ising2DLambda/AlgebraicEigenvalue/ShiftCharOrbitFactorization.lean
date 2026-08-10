/-
章「固有値の代数性」の「シフト行列の特性多項式は、軌道ごとに、その軌道の元の個数を指数とする
冪と単位元の逆元との和を掛け合わせたものである」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_shift_char_orbit_factorization`）に対応する。

  人手証明                                          このファイル
  鎖の第 1 段（特性多項式が軌道ごとの和の積）        charPoly_shiftMatrix_eq_prod_orbit_sum
  鎖の第 2 段（各因子へ軌道ごとの和の値を当てる）    prod_congr で各 O ごとに orbitSum_shiftMatrix

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（値は `Polynomial (Polynomial ℤ)`、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitSumTwoTerms
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharOrbitProduct

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {L : ℕ} [NeZero L]

/-- 人手証明の第 2 段が使う事実（有限積の各因子が等しければ有限積が等しい）。
mathlib の一般論へ委ねず、添字の集合の元の個数についての帰納法で示す。 -/
theorem prod_congr_of_eq (a b : OrbitIndex L → SecondPoly) :
    ∀ s : Finset (OrbitIndex L), (∀ O ∈ s, a O = b O) →
      (∏ O ∈ s, a O) = ∏ O ∈ s, b O := by
  classical
  intro s
  refine Finset.induction_on s ?_ ?_
  · -- 出発点。空集合にわたる有限積はどちらも単位元である。
    intro _
    rw [Finset.prod_empty, Finset.prod_empty]
  · -- 一歩。`s` に属さない `O₀` を 1 つ足す。
    intro O₀ s hO₀ ih h
    rw [Finset.prod_insert hO₀, Finset.prod_insert hO₀,
      h O₀ (Finset.mem_insert_self O₀ s),
      ih (fun O hO => h O (Finset.mem_insert_of_mem hO))]

/-- 人手証明の主張。`χ_U = ∏_{O} (t ^ |O| + u)`。 -/
theorem charPoly_shiftMatrix_eq_prod_orbit_factor (L : ℕ) [NeZero L] :
    charPoly L (shiftMatrix L)
      = ∏ O : OrbitIndex L,
          ((Polynomial.X : SecondPoly) ^ O.1.card + constSecond (-(constPoly 1))) := by
  classical
  calc charPoly L (shiftMatrix L)
      -- 鎖の第 1 段。特性多項式は軌道ごとの和の積である。
      = ∏ O : OrbitIndex L, ∑ ψ : OrbitBij O.1,
          orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ) :=
        charPoly_shiftMatrix_eq_prod_orbit_sum L
      -- 鎖の第 2 段。各因子に軌道ごとの和の値を当てる。
    _ = ∏ O : OrbitIndex L,
          ((Polynomial.X : SecondPoly) ^ O.1.card + constSecond (-(constPoly 1))) :=
        prod_congr_of_eq _ _ Finset.univ (fun O _ => orbitSum_shiftMatrix O)

end Ising2DLambda.AlgebraicEigenvalue
