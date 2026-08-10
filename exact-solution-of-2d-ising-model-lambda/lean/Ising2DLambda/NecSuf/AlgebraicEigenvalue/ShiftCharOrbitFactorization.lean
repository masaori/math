/-
主張「シフト行列の特性多項式は、軌道ごとに、その軌道の元の個数を指数とする冪と単位元の
逆元との和を掛け合わせたものである」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.ShiftCharOrbitFactorization`）の鎖のうち、
新しく必要十分性を問うべきなのは第 2 段（有限積の各因子を書き換える段）だけである
（第 1 段は前セクションの主張そのものであり、それ自身の必要十分版を既に持っている）。
証明手順は具体版と同じ（添字の集合の元の個数についての帰納法。空集合の段 → 元を 1 つ足す段で
両側の有限積を分け、その因子の等式と帰納法の仮定を当てる）。

  使っている性質                なぜ削れないか
  `CommMonoid M`                有限積を取ること（単位元・結合則）に要る。
                                `Finset.prod` がこの構造の上でしか定義されていない。
  `DecidableEq ι`               `insert` で帰納法を回すのに要る（`Finset.induction_on` が要求する）。

削れたもの: 加法・零元・分配則（この段は積しか使わない）、値が多項式であること、
添字が軌道であること、添字の型が有限であること、因子が和として作られていること、
順序 `≺`。すなわちこの段は**特性多項式の話も軌道の話も一切使っていない**。

住処: ここに ℝ / ℂ は現れない（値は一般の可換モノイド）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版の本体。`s` のすべての元 `i` で `a i = b i` ならば
`(∏ i ∈ s, a i) = ∏ i ∈ s, b i`。 -/
theorem prod_congr_of_eq_necSuf {ι : Type*} [DecidableEq ι] {M : Type*} [CommMonoid M]
    (a b : ι → M) :
    ∀ s : Finset ι, (∀ i ∈ s, a i = b i) → (∏ i ∈ s, a i) = ∏ i ∈ s, b i := by
  intro s
  refine Finset.induction_on s ?_ ?_
  · -- 出発点。空集合にわたる有限積はどちらも単位元である。
    intro _
    rw [Finset.prod_empty, Finset.prod_empty]
  · -- 一歩。`s` に属さない `i₀` を 1 つ足す。
    intro i₀ s hi₀ ih h
    rw [Finset.prod_insert hi₀, Finset.prod_insert hi₀,
      h i₀ (Finset.mem_insert_self i₀ s),
      ih (fun i hi => h i (Finset.mem_insert_of_mem hi))]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
