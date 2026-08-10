/-
章「固有値の代数性」の「軌道ごとの和は、格子の一辺を指数とする冪と単位元の逆元との和の
因子である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_sum_divides_pow_L`）に対応する。

  人手証明                                                    このファイル
  準備（O = O(τ₀) を取り、|O| = e(τ₀)、e(τ₀) ∣ L）            orbitCard_dvd_L
  L = |O| k を満たす k の存在                                 orbitSum_mul_geom_eq_pow_L の obtain
  鎖の第 1 段（L = |O| k の代入）                             同じ証明の rw [hk]
  鎖の第 2 段（前のセクションの等式。d = |O|）                 powerSumTelescope
  鎖の第 3 段（軌道ごとの和の値）                              orbitSum_shiftMatrix

人手証明の `u := ι(-κ(1))` は前のセクションの `negUnitSecond` である。

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（値は `Polynomial (Polynomial ℤ)`、指数と個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitSumTwoTerms
import Ising2DLambda.AlgebraicEigenvalue.PowerSumTelescope

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {L : ℕ} [NeZero L]

/-- 人手証明の準備。軌道の元の個数は格子の一辺を割り切る。

`O = O(τ₀)` を満たす `τ₀` を取り（`mem_rowShiftOrbitSet`）、`|O(τ₀)| = e(τ₀)`
（`card_rowShiftOrbit`）と `e(τ₀) ∣ L`（`rowShiftMinimalPeriod_dvd_L`）をつなぐ。 -/
theorem orbitCard_dvd_L (O : OrbitIndex L) : O.1.card ∣ L := by
  obtain ⟨τ₀, hτ₀⟩ := mem_rowShiftOrbitSet.mp O.2
  rw [← hτ₀, card_rowShiftOrbit]
  exact rowShiftMinimalPeriod_dvd_L L τ₀

/-- 人手証明の主張。`L = |O| k` を満たす `k` が取れて

`t ^ L + u = (Σ_{ψ ∈ 𝔅_O} W_O(ch(U), ψ)) * Σ_{j<k} t ^ (|O| j)`

が成り立つ。すなわち軌道ごとの和は `t ^ L + u` を `ℤ[x][t]` の中で割る。 -/
theorem orbitSum_mul_geom_eq_pow_L (O : OrbitIndex L) :
    ∃ k : ℕ, L = O.1.card * k ∧
      (Polynomial.X : SecondPoly) ^ L + negUnitSecond
        = (∑ ψ : OrbitBij O.1,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ))
          * ∑ j ∈ Finset.range k, (Polynomial.X : SecondPoly) ^ (O.1.card * j) := by
  -- 準備。整除から `k` を取る（人手証明の「`k` を作る」段）。
  obtain ⟨k, hk⟩ := orbitCard_dvd_L O
  refine ⟨k, hk, ?_⟩
  -- 指数の中の `L` だけを `|O| k` へ書き換える（`L` は `O` の型にも現れるので、
  -- ゴール全体を `rw [hk]` で書き換えることはできない）。
  have hexp : (Polynomial.X : SecondPoly) ^ L = (Polynomial.X : SecondPoly) ^ (O.1.card * k) :=
    congrArg (fun n => (Polynomial.X : SecondPoly) ^ n) hk
  calc (Polynomial.X : SecondPoly) ^ L + negUnitSecond
      -- 第 1 段。`L = |O| k` の代入。
      = (Polynomial.X : SecondPoly) ^ (O.1.card * k) + negUnitSecond := by rw [hexp]
      -- 第 2 段。前のセクションの等式（`d = |O|` の場合）。
    _ = ((Polynomial.X : SecondPoly) ^ O.1.card + negUnitSecond)
          * ∑ j ∈ Finset.range k, (Polynomial.X : SecondPoly) ^ (O.1.card * j) :=
        powerSumTelescope O.1.card k
      -- 第 3 段。軌道ごとの和の値（前のセクション）。
    _ = (∑ ψ : OrbitBij O.1,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ))
          * ∑ j ∈ Finset.range k, (Polynomial.X : SecondPoly) ^ (O.1.card * j) := by
        rw [orbitSum_shiftMatrix O]
        rfl

end Ising2DLambda.AlgebraicEigenvalue
