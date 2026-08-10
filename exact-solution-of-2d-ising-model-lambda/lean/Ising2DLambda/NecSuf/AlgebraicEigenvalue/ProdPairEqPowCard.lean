/-
主張「各因子の積が同じ値であるとき、軌道の集合にわたる 2 つの有限積の積は、
その値の個数を指数とする冪である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.ProdPairEqPowCard`）の証明は、
`s` の元の個数についての帰納法である。証明手順は具体版と同じ
（空集合の段 → 元を 1 つ足す段で有限積を 2 回分け、乗法を組み替え、帰納法の仮定と
仮定 `a O₀ * b O₀ = c` を当て、冪の定義と元の個数が 1 増えることで閉じる）。

  使っている性質                なぜ削れないか
  `CommMonoid M`                有限積を取ること（単位元・結合則）と、
                                `(P * a) * (Q * b) = (P * Q) * (a * b)` の組み替え（可換則）に要る。
  `DecidableEq ι`               `insert` で帰納法を回すのに要る（`Finset.induction_on` が要求する）。

削れたもの: 加法・零元・分配則（この段は積しか使わない）、値が多項式であること、
添字が軌道であること、添字の型が有限であること、`c` が `a i`・`b i` から作られていること。
すなわちこの段は**特性多項式の話も軌道の話も一切使っていない**。

住処: ここに ℝ / ℂ は現れない（値は一般の可換モノイド、個数は ℕ）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版の本体。`s` のすべての元 `i` で `a i * b i = c` ならば
`(∏ i ∈ s, a i) * (∏ i ∈ s, b i) = c ^ |s|`。 -/
theorem prod_pair_eq_pow_card_necSuf {ι : Type*} [DecidableEq ι] {M : Type*} [CommMonoid M]
    (a b : ι → M) (c : M) :
    ∀ s : Finset ι, (∀ i ∈ s, a i * b i = c) →
      (∏ i ∈ s, a i) * ∏ i ∈ s, b i = c ^ s.card := by
  intro s
  refine Finset.induction_on s ?_ ?_
  · -- 出発点。空集合にわたる有限積は単位元である。
    intro _
    rw [Finset.prod_empty, Finset.prod_empty, one_mul, Finset.card_empty, pow_zero]
  · -- 一歩。`s` に属さない `i₀` を 1 つ足す。
    intro i₀ s hi₀ ih h
    have hsub : ∀ i ∈ s, a i * b i = c := fun i hi => h i (Finset.mem_insert_of_mem hi)
    calc (∏ i ∈ insert i₀ s, a i) * ∏ i ∈ insert i₀ s, b i
        -- 第 1 段。添字の集合に属さない元を 1 つ足した有限積は、もとの積とその項の積である（`a` 側）。
        = ((∏ i ∈ s, a i) * a i₀) * ∏ i ∈ insert i₀ s, b i := by
          rw [Finset.prod_insert hi₀, mul_comm (a i₀)]
        -- 第 2 段。同じことを `b` 側で行う。
      _ = ((∏ i ∈ s, a i) * a i₀) * ((∏ i ∈ s, b i) * b i₀) := by
          rw [Finset.prod_insert hi₀, mul_comm (b i₀)]
        -- 第 3 段。乗法の結合則と可換則。
      _ = ((∏ i ∈ s, a i) * ∏ i ∈ s, b i) * (a i₀ * b i₀) :=
          mul_mul_mul_comm _ _ _ _
        -- 第 4 段。帰納法の仮定。
      _ = c ^ s.card * (a i₀ * b i₀) := by rw [ih hsub]
        -- 第 5 段。仮定を `i = i₀` に当てたもの。
      _ = c ^ s.card * c := by rw [h i₀ (Finset.mem_insert_self i₀ s)]
        -- 第 6 段。冪の定義。
      _ = c ^ (s.card + 1) := (pow_succ c s.card).symm
        -- 第 7 段。属さない元を 1 つ足した有限集合の元の個数は 1 増える。
      _ = c ^ (insert i₀ s).card := by rw [Finset.card_insert_of_notMem hi₀]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
