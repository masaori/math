/-
「実際の Ising 有限箱データから生じる列の族の上での非十分性の証人」の Lean 具体版。

本文と同じ順に、十分性を「極限量が存在する二点について、全ての正の箱で粗視化値が
一致すれば極限量が一致する」と定義し、その否定が極限量の異なる証人の存在と同値である
ことを示す。有限箱の値には実際の Ising 分配多項式の有理点での値を用いる。
-/
import Ising3DCut.LimitQuantity.PointwiseCollisionFreeCoarseGrainingFamilySufficient

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 実際の Ising 有限箱データから生じる列の族の上で、粗視化 `π` が極限量 `α` に
対して十分であること。`Domain q` は `α q` が存在する有理点を表す。 -/
def SufficientOnIsingRealizableFamily {S : Type*}
    (π : ℚ → S) (Domain : ℚ → Prop) (α : ℚ → ℝ) : Prop :=
  ∀ q q' : ℚ, Domain q → Domain q' →
    (∀ L : ℕ, 0 < L →
      π (evalAtRational q (partitionPolynomial L)) =
        π (evalAtRational q' (partitionPolynomial L))) →
    α q = α q'

/-- 粗視化が実現列の族の上で十分でないことと、極限量が異なる二つの実現可能な有理点が
全ての正の箱で同じ粗視化値を持つことは同値である。 -/
theorem not_sufficient_on_ising_realizable_family_iff_exists_witness
    {S : Type*} (π : ℚ → S) (Domain : ℚ → Prop) (α : ℚ → ℝ) :
    ¬ SufficientOnIsingRealizableFamily π Domain α ↔
      ∃ q q' : ℚ, Domain q ∧ Domain q' ∧ α q ≠ α q' ∧
        ∀ L : ℕ, 0 < L →
          π (evalAtRational q (partitionPolynomial L)) =
            π (evalAtRational q' (partitionPolynomial L)) := by
  constructor
  · intro hNotSufficient
    -- 人手証明の第一段：十分性の全称含意を否定して、二点の証人を取り出す。
    unfold SufficientOnIsingRealizableFamily at hNotSufficient
    push_neg at hNotSufficient
    obtain ⟨q, q', hq, hq', hagree, hne⟩ := hNotSufficient
    exact ⟨q, q', hq, hq', hne, hagree⟩
  · rintro ⟨q, q', hq, hq', hne, hagree⟩ hSufficient
    -- 人手証明の第二段：証人の全箱一致を十分性へ入れると、極限量の不一致に反する。
    exact hne (hSufficient q q' hq hq' hagree)

end Ising3DCut.LimitQuantity
