/-
章「固有値の代数性」の「行配位の空でない部分集合の最小元」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_row_config_min_unique`）・定義 1 件（`def_row_config_min`）・主張 1 件
（`claim_orbit_min_ne`）に対応する。

  人手証明                                    このファイル
  空でない X の最小元がちょうど 1 つ           existsUnique_rowConfigMin
  μ(X)                                        rowConfigMin
  μ(X) ∈ X                                    rowConfigMin_mem
  τ = μ(X) または μ(X) ≺ τ                    rowConfigMin_le
  相異なる軌道の最小元は相異なる               rowConfigMin_orbit_ne

存在の帰納法は、人手証明と同じ形（1 元の場合から始め、元を 1 つ足す）で書く。
mathlib の `Finset.min'` / `LinearOrder` のインスタンスは引いていない。引くと
「三分律と推移律から最小元を作る」という人手証明の議論が、既製の順序の一般論へ置き換わる。
使ったのは `Finset.Nonempty.cons_induction`（人手証明の「元を 1 つ足す」帰納法そのもの）だけである。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（元は行配位、個数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.CrossOrbitInversions

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の「`X` の最小元」の条件。 -/
def IsRowConfigMin (L : ℕ) [NeZero L] (X : Finset (RowConfig L)) (τ₀ : RowConfig L) : Prop :=
  τ₀ ∈ X ∧ ∀ τ ∈ X, τ = τ₀ ∨ rowConfigLess L τ₀ τ

/-- 人手証明の主張「行配位の空でない部分集合は最小元をちょうど 1 つ持つ」。

存在は人手証明と同じ帰納法（1 元の場合 → 元を 1 つ足す場合）、
一意性は三分律の「ちょうど 1 つ」による。 -/
theorem existsUnique_rowConfigMin {X : Finset (RowConfig L)} (hX : X.Nonempty) :
    ∃! τ₀ : RowConfig L, IsRowConfigMin L X τ₀ := by
  classical
  -- 存在（人手証明の帰納法）。
  have hexists : ∀ {Y : Finset (RowConfig L)}, Y.Nonempty → ∃ τ₀, IsRowConfigMin L Y τ₀ := by
    intro Y hY
    induction hY using Finset.Nonempty.cons_induction with
    | singleton τ₁ =>
      -- |X| = 1 の場合。X = {τ₁} なのでどの元も τ₁ である。
      exact ⟨τ₁, Finset.mem_singleton_self τ₁, by
        intro τ hτ
        exact Or.inl (Finset.mem_singleton.mp hτ)⟩
    | cons τ₁ Y hτ₁ _hY ih =>
      -- |X| = n + 1 の場合。τ₁ を取り除いた Y の最小元 τ₂ と τ₁ を比べる。
      obtain ⟨τ₂, hτ₂mem, hτ₂min⟩ := ih
      have hne : τ₁ ≠ τ₂ := fun h => hτ₁ (h ▸ hτ₂mem)
      rcases rowConfigLess_trichotomy τ₁ τ₂ with h | h | h
      · -- τ₁ ≺ τ₂ の場合: τ₁ が最小元である。
        refine ⟨τ₁, Finset.mem_cons_self τ₁ Y, ?_⟩
        intro τ hτ
        rcases Finset.mem_cons.mp hτ with hτ | hτ
        · exact Or.inl hτ
        · rcases hτ₂min τ hτ with hτ | hτ
          · exact Or.inr (hτ ▸ h.1)
          · exact Or.inr (rowConfigLess_trans h.1 hτ)
      · exact absurd h.2.1 hne
      · -- τ₂ ≺ τ₁ の場合: τ₂ が最小元である。
        refine ⟨τ₂, Finset.mem_cons_of_mem hτ₂mem, ?_⟩
        intro τ hτ
        rcases Finset.mem_cons.mp hτ with hτ | hτ
        · exact Or.inr (hτ ▸ h.2.2)
        · exact hτ₂min τ hτ
  obtain ⟨τ₀, hτ₀⟩ := hexists hX
  refine ⟨τ₀, hτ₀, ?_⟩
  -- 一意性（人手証明の三分律による議論）。
  intro τ₀' hτ₀'
  by_contra hne
  have h1 : rowConfigLess L τ₀' τ₀ := (hτ₀'.2 τ₀ hτ₀.1).resolve_left (Ne.symm hne)
  have h2 : rowConfigLess L τ₀ τ₀' := (hτ₀.2 τ₀' hτ₀'.1).resolve_left hne
  rcases rowConfigLess_trichotomy τ₀ τ₀' with h | h | h
  · exact h.2.2 h1
  · exact hne (h.2.1.symm)
  · exact h.1 h2

/-- 人手証明の定義「行配位の空でない部分集合の最小元」`μ(X)`。 -/
noncomputable def rowConfigMin (L : ℕ) [NeZero L] {X : Finset (RowConfig L)}
    (hX : X.Nonempty) : RowConfig L :=
  (existsUnique_rowConfigMin hX).choose

theorem rowConfigMin_isMin {X : Finset (RowConfig L)} (hX : X.Nonempty) :
    IsRowConfigMin L X (rowConfigMin L hX) :=
  (existsUnique_rowConfigMin hX).choose_spec.1

/-- 人手証明が定義の中で書いている `μ(X) ∈ X`。 -/
theorem rowConfigMin_mem {X : Finset (RowConfig L)} (hX : X.Nonempty) :
    rowConfigMin L hX ∈ X :=
  (rowConfigMin_isMin hX).1

/-- 人手証明が定義の中で書いている「任意の `τ ∈ X` について `τ = μ(X)` または `μ(X) ≺ τ`」。 -/
theorem rowConfigMin_le {X : Finset (RowConfig L)} (hX : X.Nonempty) {τ : RowConfig L}
    (hτ : τ ∈ X) : τ = rowConfigMin L hX ∨ rowConfigLess L (rowConfigMin L hX) τ :=
  (rowConfigMin_isMin hX).2 τ hτ

/-- 軌道は空でない（`claim_row_config_orbit_partition` の第 1 の条件）。
`μ(O)` を書くために要る。 -/
theorem rowShiftOrbit_nonempty (τ : RowConfig L) : (rowShiftOrbit L τ).Nonempty :=
  ⟨τ, self_mem_rowShiftOrbit τ⟩

/-- 人手証明の主張「相異なる軌道の最小元は相異なる」。

`μ(O) ∈ O` と、相異なる軌道が互いに素であること（`claim_row_config_orbit_partition`）による。

`O` と `O'` が空でないことは `rowShiftOrbitSet_partition` の第 1 の条件から出るが、
`rowConfigMin` の引数として渡す必要があるので仮定として受ける
（`Finset.Nonempty` は Prop なので、どの証明を渡しても同じ元を指す）。 -/
theorem rowConfigMin_orbit_ne {O O' : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L)
    (hO' : O' ∈ rowShiftOrbitSet L) (hOO' : O ≠ O')
    (hOne : O.Nonempty) (hO'ne : O'.Nonempty) :
    rowConfigMin L hOne ≠ rowConfigMin L hO'ne := by
  intro hcon
  -- 一致すると、その行配位が O ∩ O' の元になってしまう。
  exact disjoint_of_ne_of_mem_orbitSet hO hO' hOO' (rowConfigMin_mem hOne)
    (hcon ▸ rowConfigMin_mem hO'ne)

end Ising2DLambda.AlgebraicEigenvalue
