/-
章「固有値の代数性」の「シフト行列の特性多項式は、格子の一辺を指数とする冪と単位元の逆元との和の、
軌道の個数を指数とする冪の因子である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_shift_char_dvd_pow_L`）に対応する。

  人手証明                                                  このファイル
  写像 a を置く段                                            ゴールに現れる軌道ごとの和そのもの
  各 O について相手 h を選び b とする段                      choose b hb using hpair
  g := ∏_{O} b(O) と置く段                                   refine ⟨∏ O, b O, ?_⟩
  鎖の第 1 段（g の定義）                                    calc の出発点（g を展開した形）
  鎖の第 2 段（claim_shift_char_orbit_product と a の定義）  charPoly_shiftMatrix_eq_prod_orbit_sum
  鎖の第 3 段（claim_prod_pair_eq_pow_card の s = O_L）      prod_pair_eq_pow_card .. univ

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（値は `Polynomial (Polynomial ℤ)`、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.ProdPairEqPowCard
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharOrbitProduct

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {L : ℕ} [NeZero L]

/-- 人手証明の主張。`χ_U * g = (t ^ L + u) ^ |O_L|` を満たす `g` が存在する。
すなわち `χ_U` は `t ^ L + u` の `|O_L|` 乗を `ℤ[x][t]` の中で割り切る。 -/
theorem charPoly_shiftMatrix_dvd_pow_L (L : ℕ) [NeZero L] :
    charPoly L (shiftMatrix L) ∣
      ((Polynomial.X : SecondPoly) ^ L + negUnitSecond) ^ Fintype.card (OrbitIndex L) := by
  classical
  -- 各軌道について、その和に掛けると `t ^ L + u` になる相手が存在する（前セクション）。
  have hpair : ∀ O : OrbitIndex L, ∃ g : SecondPoly,
      (∑ ψ : OrbitBij O.1,
          orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ)) * g
        = (Polynomial.X : SecondPoly) ^ L + negUnitSecond := by
    intro O
    obtain ⟨k, _, hk⟩ := orbitSum_mul_geom_eq_pow_L O
    exact ⟨_, hk.symm⟩
  -- 相手を 1 つずつ選び、その有限積を商とする（人手証明の `b` と `g`）。
  choose b hb using hpair
  refine ⟨∏ O : OrbitIndex L, b O, ?_⟩
  calc ((Polynomial.X : SecondPoly) ^ L + negUnitSecond) ^ Fintype.card (OrbitIndex L)
      -- 個数を `univ` の元の個数へ書き換える。
      = ((Polynomial.X : SecondPoly) ^ L + negUnitSecond) ^
          (Finset.univ : Finset (OrbitIndex L)).card := by rw [Finset.card_univ]
      -- 鎖の第 3 段を逆向きに使う（`s = O_L`、`c = t ^ L + u`）。
    _ = (∏ O : OrbitIndex L, ∑ ψ : OrbitBij O.1,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ))
          * ∏ O : OrbitIndex L, b O :=
        (prod_pair_eq_pow_card _ b _ Finset.univ (fun O _ => hb O)).symm
      -- 鎖の第 2 段を逆向きに使う（特性多項式が軌道ごとの和の積であること）。
    _ = charPoly L (shiftMatrix L) * ∏ O : OrbitIndex L, b O := by
        rw [← charPoly_shiftMatrix_eq_prod_orbit_sum L]

end Ising2DLambda.AlgebraicEigenvalue
