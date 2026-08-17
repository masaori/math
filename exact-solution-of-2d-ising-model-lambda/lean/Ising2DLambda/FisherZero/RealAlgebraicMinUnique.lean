/-
章「零点の詰め寄り」の「実閉部分体の空でない有限集合は最小元をちょうど 1 つ持つ」
（`claim_real_algebraic_min_unique`）の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                        このファイル
  「X の最小元」の条件                             `IsRealAlgebraicMin`
  存在（|X| の帰納法。1 元の場合 → 元を 1 つ足す） `existsUnique_realAlgebraicMin` の前半
  x₁ ≺ x₂ の場合の推移律                           `realAlgebraicLt_trans`
  一意性（三分法の「ちょうど 1 つ」）              `existsUnique_realAlgebraicMin` の後半

mathlib の `Finset.min'` / `LinearOrder` のインスタンスは引かない。引くと
「三分法と推移律から最小元を作る」という人手証明の議論が、既製の順序の一般論へ置き換わる。
使うのは `Finset.Nonempty.cons_induction`（人手証明の「元を 1 つ足す」帰納法そのもの）だけである。

住処: Qbar。実数体・複素数体は現れない（元は R の元、個数は ℕ）。
-/
import Ising2DLambda.FisherZero.RealAlgebraicOrderTransitive

namespace Ising2DLambda.FisherZero

open Finset

/-- 人手証明の「`X` の最小元」の条件。 -/
def IsRealAlgebraicMin (data : RealClosedSubfieldData) (X : Finset data.carrier)
    (m : data.carrier) : Prop :=
  m ∈ X ∧ ∀ y ∈ X, y = m ∨ realAlgebraicLt data m y

/-- 人手証明の主張「実閉部分体の空でない有限集合は最小元をちょうど 1 つ持つ」。

存在は人手証明と同じ帰納法（1 元の場合 → 元を 1 つ足す場合）、
一意性は三分法の「ちょうど 1 つ」による。 -/
theorem existsUnique_realAlgebraicMin (data : RealClosedSubfieldData)
    {X : Finset data.carrier} (hX : X.Nonempty) :
    ∃! m : data.carrier, IsRealAlgebraicMin data X m := by
  classical
  -- 存在（人手証明の帰納法）。
  have hexists : ∀ {Y : Finset data.carrier}, Y.Nonempty →
      ∃ m, IsRealAlgebraicMin data Y m := by
    intro Y hY
    induction hY using Finset.Nonempty.cons_induction with
    | singleton x₁ =>
      -- |X| = 1 の場合。X = {x₁} なのでどの元も x₁ である。
      exact ⟨x₁, Finset.mem_singleton_self x₁, by
        intro y hy
        exact Or.inl (Finset.mem_singleton.mp hy)⟩
    | cons x₁ Y hx₁ _hY ih =>
      -- |X| = n + 1 の場合。x₁ を取り除いた Y の最小元 x₂ と x₁ を比べる。
      obtain ⟨x₂, hx₂mem, hx₂min⟩ := ih
      have hne : x₁ ≠ x₂ := fun h => hx₁ (h ▸ hx₂mem)
      rcases (realAlgebraicLt_trichotomy data x₁ x₂).1 with h | h | h
      · -- x₁ <_R x₂ の場合: x₁ が最小元である（ここで推移律を使う）。
        refine ⟨x₁, Finset.mem_cons_self x₁ Y, ?_⟩
        intro y hy
        rcases Finset.mem_cons.mp hy with hy | hy
        · exact Or.inl hy
        · rcases hx₂min y hy with hy | hy
          · exact Or.inr (hy ▸ h)
          · exact Or.inr (realAlgebraicLt_trans data x₁ x₂ y h hy)
      · exact absurd h hne
      · -- x₂ <_R x₁ の場合: x₂ が最小元である。
        refine ⟨x₂, Finset.mem_cons_of_mem hx₂mem, ?_⟩
        intro y hy
        rcases Finset.mem_cons.mp hy with hy | hy
        · exact Or.inr (hy ▸ h)
        · exact hx₂min y hy
  obtain ⟨m, hm⟩ := hexists hX
  refine ⟨m, hm, ?_⟩
  -- 一意性（人手証明の三分法による議論）。
  intro m' hm'
  by_contra hne
  have h1 : realAlgebraicLt data m' m := (hm'.2 m hm.1).resolve_left (Ne.symm hne)
  have h2 : realAlgebraicLt data m m' := (hm.2 m' hm'.1).resolve_left hne
  exact (realAlgebraicLt_trichotomy data m m').2.2.1 ⟨h2, h1⟩

end Ising2DLambda.FisherZero
