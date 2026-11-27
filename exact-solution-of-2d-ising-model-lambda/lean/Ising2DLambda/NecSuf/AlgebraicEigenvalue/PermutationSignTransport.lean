/-
主張「全単射で移した置換の符号はもとの置換の符号に等しい」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign.finiteOrderedSign_permCongr`）と
同じ手順（写像 `Π_f`、四つの集合 `A, B, B', C` の各対での偶奇、`|B'| = |B|`）で示す。
使っている性質と、なぜ削れないか:

  `Fintype α`・`Fintype β`        順序対の全体を有限集合として数えるため。
  `DecidableRel ltα`・`ltβ`       順序対と転倒の集合を `Finset.filter` で作るため。
  三分律 `htα`・`htβ`             `Π_f` が順序対の中へ入ること（像の二点のどちらが小さいかがちょうど一つ決まる）と、
                                  各対の場合分けで条件がちょうど一方だけ成り立つことに使う。

**推移律は仮定していない。** 二つの集合の関係は互いに無関係でよく、全単射 `d` が順序を保つことも仮定しない。
値の側は `ℤ` に固定する（必要十分版 `sign` と同じ理由）。mathlib の `Equiv.Perm.sign` は引かない。

住処: ℝ / ℂ は現れない（数え上げは ℕ、符号は ℤ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationSign

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {α β : Type*} [Fintype α] [Fintype β]
  (ltα : α → α → Prop) [DecidableRel ltα] (ltβ : β → β → Prop) [DecidableRel ltβ]

/-- 人手証明の `Π_f`。 -/
def transportPairMap (f : α ≃ β) (p : α × α) : β × β :=
  if ltβ (f p.1) (f p.2) then (f p.1, f p.2) else (f p.2, f p.1)

lemma transportPairMap_mem (htα : Trichotomous ltα) (htβ : Trichotomous ltβ) (f : α ≃ β)
    {p : α × α} (hp : p ∈ orderedPairs ltα) :
    transportPairMap ltβ f p ∈ orderedPairs ltβ := by
  have hne : p.1 ≠ p.2 := ne_of_lt' ltα htα ((mem_orderedPairs ltα).mp hp)
  have hf : f p.1 ≠ f p.2 := fun h => hne (f.injective h)
  rw [mem_orderedPairs, transportPairMap]
  by_cases h : ltβ (f p.1) (f p.2)
  · simp [h]
  · rcases lt_or_lt_of_ne ltβ htβ hf with h' | h'
    · exact absurd h' h
    · simpa [h] using h'

lemma transportPairMap_symm_pairMap (htα : Trichotomous ltα) (f : α ≃ β)
    {p : α × α} (hp : p ∈ orderedPairs ltα) :
    transportPairMap ltα f.symm (transportPairMap ltβ f p) = p := by
  have hlt : ltα p.1 p.2 := (mem_orderedPairs ltα).mp hp
  have hnot : ¬ ltα p.2 p.1 := not_lt_of_lt' ltα htα hlt
  by_cases h : ltβ (f p.1) (f p.2)
  · simp [transportPairMap, h, hlt]
  · simp [transportPairMap, h, hnot]

lemma transportPairMap_pairMap_symm (htβ : Trichotomous ltβ) (f : α ≃ β)
    {q : β × β} (hq : q ∈ orderedPairs ltβ) :
    transportPairMap ltβ f (transportPairMap ltα f.symm q) = q := by
  have h := transportPairMap_symm_pairMap ltβ ltα htβ f.symm hq
  rwa [Equiv.symm_symm] at h

/-- 人手証明の `|C| = inv(τ)`。 -/
lemma inversionCount_permCongr_eq_card (htα : Trichotomous ltα) (htβ : Trichotomous ltβ)
    (d : α ≃ β) (σ : Equiv.Perm α) :
    inversionCount ltβ (d.permCongr σ)
      = ((orderedPairs ltα).filter fun p =>
          ltβ (d.permCongr σ (transportPairMap ltβ d p).2)
            (d.permCongr σ (transportPairMap ltβ d p).1)).card := by
  refine card_nbij' (transportPairMap ltα d.symm) (transportPairMap ltβ d) ?_ ?_ ?_ ?_
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq ⊢
    refine ⟨transportPairMap_mem ltβ ltα htβ htα d.symm hq.1, ?_⟩
    rw [transportPairMap_pairMap_symm ltα ltβ htβ d hq.1]
    exact hq.2
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp ⊢
    exact ⟨transportPairMap_mem ltα ltβ htα htβ d hp.1, hp.2⟩
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq
    exact transportPairMap_pairMap_symm ltα ltβ htβ d hq.1
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp
    exact transportPairMap_symm_pairMap ltα ltβ htα d hp.1

/-- 人手証明の `|B'| = |B|`。 -/
lemma card_transportPairMap_preimage (htα : Trichotomous ltα) (d : α ≃ β) (σ : Equiv.Perm α) :
    ((orderedPairs ltα).filter fun p =>
        ltβ (d (transportPairMap ltα σ p).2) (d (transportPairMap ltα σ p).1)).card
      = ((orderedPairs ltα).filter fun p => ltβ (d p.2) (d p.1)).card := by
  refine card_nbij' (transportPairMap ltα σ) (transportPairMap ltα σ.symm) ?_ ?_ ?_ ?_
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp ⊢
    exact ⟨transportPairMap_mem ltα ltα htα htα σ hp.1, hp.2⟩
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq ⊢
    refine ⟨transportPairMap_mem ltα ltα htα htα σ.symm hq.1, ?_⟩
    rw [transportPairMap_pairMap_symm ltα ltα htα σ hq.1]
    exact hq.2
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp
    exact transportPairMap_symm_pairMap ltα ltα htα σ hp.1
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq
    exact transportPairMap_pairMap_symm ltα ltα htα σ hq.1

/-- 人手証明の「各対で `A, B, B', C` に属するものの個数は偶数」。 -/
lemma transport_parity_at_pair (htα : Trichotomous ltα) (htβ : Trichotomous ltβ)
    (d : α ≃ β) (σ : Equiv.Perm α) {p : α × α} (hp : p ∈ orderedPairs ltα) :
    (if ltβ (d.permCongr σ (transportPairMap ltβ d p).2) (d.permCongr σ (transportPairMap ltβ d p).1)
        then (-1 : ℤ) else 1)
      * (if ltα (σ p.2) (σ p.1) then (-1 : ℤ) else 1)
      * (if ltβ (d p.2) (d p.1) then (-1 : ℤ) else 1)
      * (if ltβ (d (transportPairMap ltα σ p).2) (d (transportPairMap ltα σ p).1)
          then (-1 : ℤ) else 1)
      = 1 := by
  have hlt : ltα p.1 p.2 := (mem_orderedPairs ltα).mp hp
  have hne : p.1 ≠ p.2 := ne_of_lt' ltα htα hlt
  have hdne : d p.1 ≠ d p.2 := fun h => hne (d.injective h)
  have hσne : σ p.1 ≠ σ p.2 := fun h => hne (σ.injective h)
  have hdσne : d (σ p.1) ≠ d (σ p.2) := fun h => hσne (d.injective h)
  have hτ (u : α) : d.permCongr σ (d u) = d (σ u) := by simp [Equiv.permCongr_apply]
  rcases lt_or_lt_of_ne ltβ htβ hdne with hd | hd
  · have hdB : ¬ ltβ (d p.2) (d p.1) := not_lt_of_lt' ltβ htβ hd
    rcases lt_or_lt_of_ne ltα htα hσne with hs | hs
    · have hsA : ¬ ltα (σ p.2) (σ p.1) := not_lt_of_lt' ltα htα hs
      by_cases hx : ltβ (d (σ p.2)) (d (σ p.1))
      · simp [transportPairMap, hd, hdB, hs, hsA, hx, hτ]
      · simp [transportPairMap, hd, hdB, hs, hsA, hx, hτ]
    · have hsA : ¬ ltα (σ p.1) (σ p.2) := not_lt_of_lt' ltα htα hs
      rcases lt_or_lt_of_ne ltβ htβ hdσne with hx | hx
      · have hx' : ¬ ltβ (d (σ p.2)) (d (σ p.1)) := not_lt_of_lt' ltβ htβ hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]
      · have hx' : ¬ ltβ (d (σ p.1)) (d (σ p.2)) := not_lt_of_lt' ltβ htβ hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]
  · have hdB : ¬ ltβ (d p.1) (d p.2) := not_lt_of_lt' ltβ htβ hd
    rcases lt_or_lt_of_ne ltα htα hσne with hs | hs
    · have hsA : ¬ ltα (σ p.2) (σ p.1) := not_lt_of_lt' ltα htα hs
      rcases lt_or_lt_of_ne ltβ htβ hdσne with hx | hx
      · have hx' : ¬ ltβ (d (σ p.2)) (d (σ p.1)) := not_lt_of_lt' ltβ htβ hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]
      · have hx' : ¬ ltβ (d (σ p.1)) (d (σ p.2)) := not_lt_of_lt' ltβ htβ hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]
    · have hsA : ¬ ltα (σ p.1) (σ p.2) := not_lt_of_lt' ltα htα hs
      rcases lt_or_lt_of_ne ltβ htβ hdσne with hx | hx
      · have hx' : ¬ ltβ (d (σ p.2)) (d (σ p.1)) := not_lt_of_lt' ltβ htβ hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]
      · have hx' : ¬ ltβ (d (σ p.1)) (d (σ p.2)) := not_lt_of_lt' ltβ htβ hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]

/-- 人手証明の主張。三分律を満たす二つの関係について、`d ∘ σ ∘ d⁻¹` の符号は `σ` の符号に等しい。 -/
theorem sign_permCongr (htα : Trichotomous ltα) (htβ : Trichotomous ltβ)
    (d : α ≃ β) (σ : Equiv.Perm α) :
    sign ltβ (d.permCongr σ) = sign ltα σ := by
  have hprod' :
      (-1 : ℤ) ^ inversionCount ltβ (d.permCongr σ)
        * (-1) ^ inversionCount ltα σ
        * (-1) ^ ((orderedPairs ltα).filter fun p => ltβ (d p.2) (d p.1)).card
        * (-1) ^ ((orderedPairs ltα).filter fun p =>
            ltβ (d (transportPairMap ltα σ p).2) (d (transportPairMap ltα σ p).1)).card = 1 := by
    rw [inversionCount_permCongr_eq_card ltα ltβ htα htβ d σ]
    simp only [inversionCount]
    rw [← prod_ite_neg_one, ← prod_ite_neg_one, ← prod_ite_neg_one, ← prod_ite_neg_one]
    rw [← prod_mul_distrib, ← prod_mul_distrib, ← prod_mul_distrib,
      prod_congr rfl fun p hp => transport_parity_at_pair ltα ltβ htα htβ d σ hp, prod_const_one]
  have hprod :
      (-1 : ℤ) ^ inversionCount ltβ (d.permCongr σ)
        * (-1) ^ inversionCount ltα σ
        * (-1) ^ ((orderedPairs ltα).filter fun p => ltβ (d p.2) (d p.1)).card
        * (-1) ^ ((orderedPairs ltα).filter fun p => ltβ (d p.2) (d p.1)).card = 1 := by
    rw [card_transportPairMap_preimage ltα ltβ htα d σ] at hprod'
    exact hprod'
  have hsq (n : ℕ) : (-1 : ℤ) ^ n * (-1) ^ n = 1 := by
    rw [← pow_add, ← two_mul, pow_mul, neg_one_sq, one_pow]
  calc sign ltβ (d.permCongr σ)
      = (-1 : ℤ) ^ inversionCount ltβ (d.permCongr σ) := rfl
    _ = (-1 : ℤ) ^ inversionCount ltβ (d.permCongr σ)
          * ((-1) ^ inversionCount ltα σ * (-1) ^ inversionCount ltα σ)
          * ((-1) ^ ((orderedPairs ltα).filter fun p => ltβ (d p.2) (d p.1)).card
            * (-1) ^ ((orderedPairs ltα).filter fun p => ltβ (d p.2) (d p.1)).card) := by
        rw [hsq, hsq, mul_one, mul_one]
    _ = ((-1 : ℤ) ^ inversionCount ltβ (d.permCongr σ)
          * (-1) ^ inversionCount ltα σ
          * (-1) ^ ((orderedPairs ltα).filter fun p => ltβ (d p.2) (d p.1)).card
          * (-1) ^ ((orderedPairs ltα).filter fun p => ltβ (d p.2) (d p.1)).card)
          * (-1) ^ inversionCount ltα σ := by ring
    _ = 1 * (-1) ^ inversionCount ltα σ := by rw [hprod]
    _ = sign ltα σ := by rw [one_mul]; rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
