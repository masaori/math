/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版に α := RowConfig L、lt := rowConfigLess L、s := F(O,O) を代入すると、
具体版の乗法性が出る。代入する仮定は次の 8 つだけである。

  非対称性 / 全順序性               ← claim_row_config_order_linear の三分律の 2 つの帰結（2 つ）
  並べ直しの写像が台の中へ入ること  ← orbitSortPair_mem（ψ₂ と ψ₂⁻¹ の 2 つぶん）
  両向きの往復が恒等写像であること  ← orbitSortPair_sortPair（同上。2 つ）
  台の対で値が相異なること          ← ψ₂ と ψ₁∘ψ₂ の単射性（2 つ）

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・台が軌道から作られていること・型の有限性・≺ が推移的であること。

住処: ℕ と ℤ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitPermutationSignMul
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitPermutationSignMul

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の `orbitPermSign` が、必要十分版の `signOn` の特殊化であること。 -/
theorem orbitPermSign_eq_necSuf' (O : Finset (RowConfig L)) (g : RowConfig L → RowConfig L) :
    orbitPermSign L O g
      = NecSuf.AlgebraicEigenvalue.signOn (rowConfigLess L) (crossOrderedPairs L O O) g := rfl

/-- 具体版の並べ直しの写像が、必要十分版のものの特殊化であること。 -/
theorem orbitSortPair_eq_necSuf (g : RowConfig L → RowConfig L)
    (p : RowConfig L × RowConfig L) :
    orbitSortPair L g p = NecSuf.AlgebraicEigenvalue.sortPair (rowConfigLess L) g p := rfl

/-- 具体版の乗法性を、必要十分版から導いたもの。 -/
theorem orbitPermSign_comp_from_necSuf {O : Finset (RowConfig L)}
    {g₁ g₂ g₂' : RowConfig L → RowConfig L}
    (hmem₂ : ∀ τ ∈ O, g₂ τ ∈ O) (hmem₂' : ∀ τ ∈ O, g₂' τ ∈ O)
    (hleft : ∀ τ ∈ O, g₂' (g₂ τ) = τ) (hright : ∀ τ ∈ O, g₂ (g₂' τ) = τ)
    (hinj₁ : ∀ τ ∈ O, ∀ τ' ∈ O, g₁ τ = g₁ τ' → τ = τ') :
    orbitPermSign L O (fun τ => g₁ (g₂ τ))
      = orbitPermSign L O g₁ * orbitPermSign L O g₂ := by
  have hinj₂ : ∀ τ ∈ O, ∀ τ' ∈ O, g₂ τ = g₂ τ' → τ = τ' := injOn_of_leftInverse hleft
  have hinj₂' : ∀ τ ∈ O, ∀ τ' ∈ O, g₂' τ = g₂' τ' → τ = τ' := injOn_of_leftInverse hright
  rw [orbitPermSign_eq_necSuf', orbitPermSign_eq_necSuf', orbitPermSign_eq_necSuf']
  exact NecSuf.AlgebraicEigenvalue.signOn_comp
    (fun _ _ h => not_rowConfigLess_of_rowConfigLess h)
    (fun _ _ h => rowConfigLess_or_rowConfigLess h)
    (fun p hp => orbitSortPair_mem hmem₂ hinj₂ hp)
    (fun p hp => orbitSortPair_mem hmem₂' hinj₂' hp)
    (fun p hp => orbitSortPair_sortPair hleft hp)
    (fun p hp => orbitSortPair_sortPair hright hp)
    (fun p hp => by
      obtain ⟨⟨h1, h2⟩, hlt⟩ := mem_crossOrderedPairs.mp hp
      exact fun h => (ne_of_rowConfigLess hlt) (hinj₂ p.1 h1 p.2 h2 h))
    (fun p hp => by
      obtain ⟨⟨h1, h2⟩, hlt⟩ := mem_crossOrderedPairs.mp hp
      exact fun h => (ne_of_rowConfigLess hlt)
        (hinj₂ p.1 h1 p.2 h2 (hinj₁ _ (hmem₂ p.1 h1) _ (hmem₂ p.2 h2) h)))

end Ising2DLambda.AlgebraicEigenvalue
