/-
章「固有値の代数性」の「軌道ごとの因子の値を 0 にする代数的数は 1 の冪根である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_second_evaluation`）と主張 1 件（`claim_orbit_factor_root`）に対応する。

  人手証明                                   このファイル
  ev_{ξ,z} : ℤ[x][t] → Qbar                  evalSecond ξ z
  ι(-κ(1))（因子の定数項）                   constSecond (-(constPoly 1))
  t^m + ι(-κ(1))（軌道ごとの因子）           X ^ m + constSecond (-(constPoly 1))
  鎖の第 1 段（和を保つ）                    Polynomial.eval₂_add
  鎖の第 2 段（t^m の値は z^m）              Polynomial.eval₂_X_pow
  鎖の第 3 段（ι(a) の値は a(ξ)）            Polynomial.eval₂_C
  鎖の第 4 段（逆元を逆元へ）                map_neg
  鎖の第 5 段（κ(1) の値は 1）               constPoly_one と map_one
  z^m - 1 = 0 から z^m = 1                   sub_eq_zero の展開

`Polynomial.eval₂_add` / `eval₂_X_pow` / `eval₂_C` は代入の定義そのもの（和の値は値の和、
単項式の値、定数の値は係数の像）であり、人手証明が `def_second_evaluation` の約束として
置いたものに 1 対 1 で対応する。特性多項式や 1 の冪根についての一般論は引いていない。

住処: 人手証明のこれらのブロックは Qbar を宣言している。ここに ℝ / ℂ は現れない
（値は ℚ の代数閉包の元、係数は ℤ[x]、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.AlgebraicEigenvalue.SecondPolynomial

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- 人手証明の `ev_ξ : ℤ[x] → Qbar`。係数環 `ℤ[x]` の元を `x = ξ` で評価する環準同型。 -/
noncomputable def evalFirstHom (ξ : Qbar) : Polynomial ℤ →+* Qbar :=
  Polynomial.eval₂RingHom (Int.castRingHom Qbar) ξ

/-- 人手証明の `ev_{ξ,z} : ℤ[x][t] → Qbar`（`def_second_evaluation`）。
係数を `evalFirstHom ξ` で送り、不定元 `t` に `z` を代入する。 -/
noncomputable def evalSecond (ξ z : Qbar) (f : SecondPoly) : Qbar :=
  Polynomial.eval₂ (evalFirstHom ξ) z f

/-- 人手証明の鎖そのもの。軌道ごとの因子の値は `z ^ m - 1` である。 -/
theorem evalSecond_orbitFactor {m : ℕ} (ξ z : Qbar) :
    evalSecond ξ z ((X : SecondPoly) ^ m + constSecond (-(constPoly 1))) = z ^ m - 1 := by
  calc evalSecond ξ z ((X : SecondPoly) ^ m + constSecond (-(constPoly 1)))
      = Polynomial.eval₂ (evalFirstHom ξ) z ((X : SecondPoly) ^ m)
          + Polynomial.eval₂ (evalFirstHom ξ) z (constSecond (-(constPoly 1))) := by
        rw [evalSecond, Polynomial.eval₂_add]      -- 第 1 段。和を保つ。
    _ = z ^ m + Polynomial.eval₂ (evalFirstHom ξ) z (constSecond (-(constPoly 1))) := by
        rw [Polynomial.eval₂_X_pow]                -- 第 2 段。t^m の値は z^m。
    _ = z ^ m + evalFirstHom ξ (-(constPoly 1)) := by
        rw [constSecond, Polynomial.eval₂_C]       -- 第 3 段。ι(a) の値は a(ξ)。
    _ = z ^ m - evalFirstHom ξ (constPoly 1) := by
        rw [map_neg, ← sub_eq_add_neg]             -- 第 4 段。逆元を逆元へ送る。
    _ = z ^ m - 1 := by
        rw [constPoly_one, map_one]                -- 第 5 段。κ(1) の値は 1。

/-- 人手証明の主張。因子の値が 0 なら `z` は 1 の `m` 乗根である（`claim_orbit_factor_root`）。 -/
theorem rootOfUnity_of_orbitFactor_eval_eq_zero {m : ℕ} {ξ z : Qbar}
    (h : evalSecond ξ z ((X : SecondPoly) ^ m + constSecond (-(constPoly 1))) = 0) :
    z ∈ RootOfUnity m := by
  rw [mem_rootOfUnity]
  have h' : z ^ m - 1 = 0 := by rw [← evalSecond_orbitFactor ξ z]; exact h
  exact sub_eq_zero.mp h'

end Ising2DLambda.AlgebraicEigenvalue
