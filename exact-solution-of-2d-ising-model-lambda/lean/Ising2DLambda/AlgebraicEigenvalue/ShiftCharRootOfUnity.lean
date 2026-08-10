/-
章「固有値の代数性」の「シフト行列の特性多項式の値を 0 にする代数的数は 1 の L 乗根である」
の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_shift_char_root_of_unity`）に対応する。

  人手証明                                     このファイル
  鎖の第 1 段（仮定）                          h
  鎖の第 2 段（χ_U が軌道ごとの因子の積）      charPoly_shiftMatrix_eq_prod_orbit_factor
  鎖の第 3 段（積の値は値の積）                evalSecond_prod
  0 である因子 O₀ を取る                       exists_eq_zero_of_prod_eq_zero
  その因子から z ∈ μ_{|O₀|}                    rootOfUnity_of_orbitFactor_eval_eq_zero
  |O₀| = e(τ₀) と e(τ₀) ∣ L から |O₀| ∣ L      orbitCard_dvd_L
  μ_{|O₀|} ⊆ μ_L から z ∈ μ_L                  rootOfUnity_of_dvd

いずれも本文で示した主張であり、mathlib の一般論（`Polynomial.roots` や
`IsPrimitiveRoot` 等）へは委ねていない。

住処: 人手証明のこのブロックは Qbar を宣言している。ここに ℝ / ℂ は現れない
（値は ℚ の代数閉包の元、係数は ℤ[x]、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharOrbitFactorization
import Ising2DLambda.AlgebraicEigenvalue.SecondEvaluationProd
import Ising2DLambda.AlgebraicEigenvalue.OrbitFactorRoot
import Ising2DLambda.AlgebraicEigenvalue.QbarProdZero
import Ising2DLambda.AlgebraicEigenvalue.OrbitSumDividesPowL

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

variable {L : ℕ} [NeZero L]

/-- 人手証明の主張。`ev_{ξ,z}(χ_U) = 0` ならば `z ∈ μ_L` である。 -/
theorem rootOfUnity_of_charPoly_shiftMatrix_eval_eq_zero (L : ℕ) [NeZero L] {ξ z : Qbar}
    (h : evalSecond ξ z (charPoly L (shiftMatrix L)) = 0) :
    z ∈ RootOfUnity L := by
  classical
  -- 人手証明の鎖（0 から始めて値の積まで）。
  have hchain : (0 : Qbar)
      = ∏ O : OrbitIndex L,
          evalSecond ξ z ((X : SecondPoly) ^ O.1.card + constSecond (-(constPoly 1))) :=
    calc (0 : Qbar)
        -- 鎖の第 1 段。仮定。
        = evalSecond ξ z (charPoly L (shiftMatrix L)) := h.symm
        -- 鎖の第 2 段。特性多項式は軌道ごとの因子の積である。
      _ = evalSecond ξ z
            (∏ O : OrbitIndex L, ((X : SecondPoly) ^ O.1.card + constSecond (-(constPoly 1)))) := by
          rw [charPoly_shiftMatrix_eq_prod_orbit_factor]
        -- 鎖の第 3 段。値を取る写像は有限積を有限積へ写す。
      _ = ∏ O : OrbitIndex L,
            evalSecond ξ z ((X : SecondPoly) ^ O.1.card + constSecond (-(constPoly 1))) :=
          evalSecond_prod ξ z Finset.univ _
  -- 値が 0 である因子を 1 つ取る（代数的数の有限積が 0 ならば 0 である因子がある）。
  obtain ⟨O₀, _, hO₀⟩ :=
    exists_eq_zero_of_prod_eq_zero
      (fun O : OrbitIndex L =>
        evalSecond ξ z ((X : SecondPoly) ^ O.1.card + constSecond (-(constPoly 1))))
      Finset.univ hchain.symm
  -- その因子から z ∈ μ_{|O₀|} が出て、|O₀| ∣ L により μ_{|O₀|} ⊆ μ_L へ移す。
  exact rootOfUnity_of_dvd (orbitCard_dvd_L O₀) (rootOfUnity_of_orbitFactor_eval_eq_zero hO₀)

end Ising2DLambda.AlgebraicEigenvalue
