/-
章「固有値の代数性」の「各因子の積が同じ値であるとき、軌道の集合にわたる 2 つの有限積の積は、
その値の個数を指数とする冪である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_prod_pair_eq_pow_card`）に対応する。

  人手証明                                                このファイル
  s の元の個数についての帰納法                             Finset.induction_on
  出発点（空集合にわたる有限積は単位元）の 5 段            empty の場合の rw の並び
  一歩の第 1・2 段（有限積を分ける）                       Finset.prod_insert 2 回
  一歩の第 3 段（乗法の結合則と可換則）                    mul_mul_mul_comm
  一歩の第 4 段（帰納法の仮定）                            ih hsub
  一歩の第 5 段（仮定 a(O₀) b(O₀) = c）                    h O₀ (mem_insert_self ..)
  一歩の第 6 段（冪の定義）                                pow_succ
  一歩の第 7 段（元の個数が 1 増える）                     Finset.card_insert_of_notMem

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（値は `Polynomial (Polynomial ℤ)`、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitSumDividesPowL

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {L : ℕ} [NeZero L]

/-- 人手証明の主張。`s` のすべての軌道 `O` で `a O * b O = c` ならば

`(∏_{O ∈ s} a O) * (∏_{O ∈ s} b O) = c ^ |s|`。 -/
theorem prod_pair_eq_pow_card (a b : OrbitIndex L → SecondPoly) (c : SecondPoly) :
    ∀ s : Finset (OrbitIndex L), (∀ O ∈ s, a O * b O = c) →
      (∏ O ∈ s, a O) * ∏ O ∈ s, b O = c ^ s.card := by
  intro s
  refine Finset.induction_on s ?_ ?_
  · -- 出発点。空集合にわたる有限積は単位元であり、零乗は単位元である。
    intro _
    rw [Finset.prod_empty, Finset.prod_empty, one_mul, Finset.card_empty, pow_zero]
  · -- 一歩。`s` に属さない軌道 `O₀` を 1 つ足す。
    intro O₀ s hO₀ ih h
    have hsub : ∀ O ∈ s, a O * b O = c := fun O hO => h O (Finset.mem_insert_of_mem hO)
    calc (∏ O ∈ insert O₀ s, a O) * ∏ O ∈ insert O₀ s, b O
        = ((∏ O ∈ s, a O) * a O₀) * ∏ O ∈ insert O₀ s, b O := by
          rw [Finset.prod_insert hO₀, mul_comm (a O₀)]
      _ = ((∏ O ∈ s, a O) * a O₀) * ((∏ O ∈ s, b O) * b O₀) := by
          rw [Finset.prod_insert hO₀, mul_comm (b O₀)]
      _ = ((∏ O ∈ s, a O) * ∏ O ∈ s, b O) * (a O₀ * b O₀) :=
          mul_mul_mul_comm _ _ _ _
      _ = c ^ s.card * (a O₀ * b O₀) := by rw [ih hsub]
      _ = c ^ s.card * c := by rw [h O₀ (Finset.mem_insert_self O₀ s)]
      _ = c ^ (s.card + 1) := (pow_succ c s.card).symm
      _ = c ^ (insert O₀ s).card := by rw [Finset.card_insert_of_notMem hO₀]

end Ising2DLambda.AlgebraicEigenvalue
