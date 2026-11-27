/-
主張「全単射で移した置換の符号はもとの置換の符号に等しい」（`claim_permutation_sign_transport`）の具体版。
人手証明と 1 対 1 に対応させる。

  人手証明                                         このファイル
  全単射 f の像を並べ直す写像 Π_f : P_𝒥 → P_𝒦      transportPairMap
  Π_f が P_𝒦 の中へ入ること                        transportPairMap_mem
  Π_{f⁻¹} が Π_f の逆写像であること                 transportPairMap_symm_pairMap・transportPairMap_pairMap_symm
  |C| = inv(τ)                                     inversionCount_permCongr_eq_card
  |B'| = |B|                                       card_transportPairMap_preimage
  各対で A, B, B', C が偶数個                       transport_parity_at_pair
  主張の式変形                                     finiteOrderedSign_permCongr

符号・転倒数・順序対の集合は本文の定義を書いた `finiteOrderedSign`・`finiteOrderedInversionCount`・
`finiteOrderedPairs` を使う。本文の他の主張の具体版は引かない。mathlib の `Equiv.Perm.sign` も引かない。
順序について使うのは三分律の帰結（`ne_of_lt`・`lt_asymm`・`lt_or_gt_of_ne`）だけである。

住処: 有限集合の数え上げと整数の積だけで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.PermutationSignFiniteOrderedSetIndependent

namespace Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign

open Finset

variable {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]

/-- 本文の写像 `Π_f`。全単射 `f` の像の二点を `≺_𝒦` について並べ直した対を返す。 -/
def transportPairMap (f : J ≃ K) (p : J × J) : K × K :=
  if f p.1 < f p.2 then (f p.1, f p.2) else (f p.2, f p.1)

/-- 本文の「`Π_f` は `P_𝒦` の中へ入る」。 -/
theorem transportPairMap_mem (f : J ≃ K) {p : J × J}
    (hp : p ∈ finiteOrderedPairs (J := J)) :
    transportPairMap f p ∈ finiteOrderedPairs (J := K) := by
  have hne : p.1 ≠ p.2 := ne_of_lt (finiteOrdered_mem_orderedPairs.mp hp)
  have hf : f p.1 ≠ f p.2 := fun h => hne (f.injective h)
  rw [finiteOrdered_mem_orderedPairs, transportPairMap]
  by_cases h : f p.1 < f p.2
  · simp [h]
  · rcases lt_or_gt_of_ne hf with h' | h'
    · exact absurd h' h
    · simpa [h] using h'

/-- 本文の「`Π_{f⁻¹}(Π_f(u,u')) = (u,u')`」。 -/
theorem transportPairMap_symm_pairMap (f : J ≃ K) {p : J × J}
    (hp : p ∈ finiteOrderedPairs (J := J)) :
    transportPairMap f.symm (transportPairMap f p) = p := by
  have hlt : p.1 < p.2 := finiteOrdered_mem_orderedPairs.mp hp
  have hnot : ¬ p.2 < p.1 := lt_asymm hlt
  by_cases h : f p.1 < f p.2
  · simp [transportPairMap, h, hlt]
  · simp [transportPairMap, h, hnot]

/-- 本文の「`f` と `f⁻¹` を入れ替えれば `Π_f(Π_{f⁻¹}(v,v')) = (v,v')`」。 -/
theorem transportPairMap_pairMap_symm (f : J ≃ K) {q : K × K}
    (hq : q ∈ finiteOrderedPairs (J := K)) :
    transportPairMap f (transportPairMap f.symm q) = q := by
  have h := transportPairMap_symm_pairMap f.symm hq
  rwa [Equiv.symm_symm] at h

/-- 本文の「`C` は `Π_d` による `τ` の転倒の集合の逆像であり、`|C| = inv(τ)`」。
`τ = d ∘ σ ∘ d⁻¹` は mathlib では `d.permCongr σ` と書かれる。 -/
theorem inversionCount_permCongr_eq_card (d : J ≃ K) (σ : Equiv.Perm J) :
    finiteOrderedInversionCount (d.permCongr σ)
      = ((finiteOrderedPairs (J := J)).filter fun p =>
          d.permCongr σ (transportPairMap d p).2
            < d.permCongr σ (transportPairMap d p).1).card := by
  refine card_nbij' (transportPairMap d.symm) (transportPairMap d) ?_ ?_ ?_ ?_
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq ⊢
    refine ⟨transportPairMap_mem d.symm hq.1, ?_⟩
    rw [transportPairMap_pairMap_symm d hq.1]
    exact hq.2
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp ⊢
    exact ⟨transportPairMap_mem d hp.1, hp.2⟩
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq
    exact transportPairMap_pairMap_symm d hq.1
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp
    exact transportPairMap_symm_pairMap d hp.1

/-- 本文の「`B'` は `Π_σ` による `B` の逆像であり、`|B'| = |B|`」。 -/
theorem card_transportPairMap_preimage (d : J ≃ K) (σ : Equiv.Perm J) :
    ((finiteOrderedPairs (J := J)).filter fun p =>
        d (transportPairMap σ p).2 < d (transportPairMap σ p).1).card
      = ((finiteOrderedPairs (J := J)).filter fun p => d p.2 < d p.1).card := by
  refine card_nbij' (transportPairMap σ) (transportPairMap σ.symm) ?_ ?_ ?_ ?_
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp ⊢
    exact ⟨transportPairMap_mem σ hp.1, hp.2⟩
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq ⊢
    refine ⟨transportPairMap_mem σ.symm hq.1, ?_⟩
    rw [transportPairMap_pairMap_symm σ hq.1]
    exact hq.2
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp
    exact transportPairMap_symm_pairMap σ hp.1
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq
    exact transportPairMap_pairMap_symm σ hq.1

/-- 本文の「各対について `A, B, B', C` のうちその対が属するものの個数は偶数」、
すなわち `f_C(u,u')·f_A(u,u')·f_B(u,u')·f_{B'}(u,u') = 1`。場合分けは本文と同じ四つ。 -/
theorem transport_parity_at_pair (d : J ≃ K) (σ : Equiv.Perm J) {p : J × J}
    (hp : p ∈ finiteOrderedPairs (J := J)) :
    (if d.permCongr σ (transportPairMap d p).2 < d.permCongr σ (transportPairMap d p).1
        then (-1 : ℤ) else 1)
      * (if σ p.2 < σ p.1 then (-1 : ℤ) else 1)
      * (if d p.2 < d p.1 then (-1 : ℤ) else 1)
      * (if d (transportPairMap σ p).2 < d (transportPairMap σ p).1 then (-1 : ℤ) else 1)
      = 1 := by
  have hlt : p.1 < p.2 := finiteOrdered_mem_orderedPairs.mp hp
  have hne : p.1 ≠ p.2 := ne_of_lt hlt
  have hdne : d p.1 ≠ d p.2 := fun h => hne (d.injective h)
  have hσne : σ p.1 ≠ σ p.2 := fun h => hne (σ.injective h)
  have hdσne : d (σ p.1) ≠ d (σ p.2) := fun h => hσne (d.injective h)
  have hτ (u : J) : d.permCongr σ (d u) = d (σ u) := by simp [Equiv.permCongr_apply]
  -- 一つめの場合分け: `d` が対 `(u,u')` を入れ替えるか（`B` に属するか）。
  rcases lt_or_gt_of_ne hdne with hd | hd
  · have hdB : ¬ d p.2 < d p.1 := lt_asymm hd
    -- 二つめの場合分け: `σ` が対を入れ替えるか（`A` に属するか）。
    rcases lt_or_gt_of_ne hσne with hs | hs
    · have hsA : ¬ σ p.2 < σ p.1 := lt_asymm hs
      by_cases hx : d (σ p.2) < d (σ p.1)
      · simp [transportPairMap, hd, hdB, hs, hsA, hx, hτ]
      · simp [transportPairMap, hd, hdB, hs, hsA, hx, hτ]
    · have hsA : ¬ σ p.1 < σ p.2 := lt_asymm hs
      rcases lt_or_gt_of_ne hdσne with hx | hx
      · have hx' : ¬ d (σ p.2) < d (σ p.1) := lt_asymm hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]
      · have hx' : ¬ d (σ p.1) < d (σ p.2) := lt_asymm hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]
  · have hdB : ¬ d p.1 < d p.2 := lt_asymm hd
    rcases lt_or_gt_of_ne hσne with hs | hs
    · have hsA : ¬ σ p.2 < σ p.1 := lt_asymm hs
      rcases lt_or_gt_of_ne hdσne with hx | hx
      · have hx' : ¬ d (σ p.2) < d (σ p.1) := lt_asymm hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]
      · have hx' : ¬ d (σ p.1) < d (σ p.2) := lt_asymm hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]
    · have hsA : ¬ σ p.1 < σ p.2 := lt_asymm hs
      rcases lt_or_gt_of_ne hdσne with hx | hx
      · have hx' : ¬ d (σ p.2) < d (σ p.1) := lt_asymm hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]
      · have hx' : ¬ d (σ p.1) < d (σ p.2) := lt_asymm hx
        simp [transportPairMap, hd, hdB, hs, hsA, hx, hx', hτ]

/-- 本文の主張 `sgn_𝒦(d ∘ σ ∘ d⁻¹) = sgn_𝒥(σ)` の式変形。 -/
theorem finiteOrderedSign_permCongr (d : J ≃ K) (σ : Equiv.Perm J) :
    finiteOrderedSign (d.permCongr σ) = finiteOrderedSign σ := by
  have hprod' :
      (-1 : ℤ) ^ finiteOrderedInversionCount (d.permCongr σ)
        * (-1) ^ finiteOrderedInversionCount σ
        * (-1) ^ ((finiteOrderedPairs (J := J)).filter fun p => d p.2 < d p.1).card
        * (-1) ^ ((finiteOrderedPairs (J := J)).filter fun p =>
            d (transportPairMap σ p).2 < d (transportPairMap σ p).1).card = 1 := by
    -- `|C| = inv(τ)`、`|A| = inv(σ)`。
    rw [inversionCount_permCongr_eq_card d σ]
    simp only [finiteOrderedInversionCount]
    -- 属するときだけ `-1` を掛けた有限積は `(-1)` の個数乗。
    rw [← finiteOrdered_prod_ite_neg_one, ← finiteOrdered_prod_ite_neg_one,
      ← finiteOrdered_prod_ite_neg_one, ← finiteOrdered_prod_ite_neg_one]
    -- 有限積を因子ごとにまとめ、各因子が 1 であることを使う。
    rw [← prod_mul_distrib, ← prod_mul_distrib, ← prod_mul_distrib,
      prod_congr rfl fun p hp => transport_parity_at_pair d σ hp, prod_const_one]
  -- `|B'| = |B|`。
  have hprod :
      (-1 : ℤ) ^ finiteOrderedInversionCount (d.permCongr σ)
        * (-1) ^ finiteOrderedInversionCount σ
        * (-1) ^ ((finiteOrderedPairs (J := J)).filter fun p => d p.2 < d p.1).card
        * (-1) ^ ((finiteOrderedPairs (J := J)).filter fun p => d p.2 < d p.1).card = 1 := by
    rw [card_transportPairMap_preimage d σ] at hprod'
    exact hprod'
  have hsq (n : ℕ) : (-1 : ℤ) ^ n * (-1) ^ n = 1 := by
    rw [← pow_add, ← two_mul, pow_mul, neg_one_sq, one_pow]
  calc finiteOrderedSign (d.permCongr σ)
      = (-1 : ℤ) ^ finiteOrderedInversionCount (d.permCongr σ) := rfl
    _ = (-1 : ℤ) ^ finiteOrderedInversionCount (d.permCongr σ)
          * ((-1) ^ finiteOrderedInversionCount σ * (-1) ^ finiteOrderedInversionCount σ)
          * ((-1) ^ ((finiteOrderedPairs (J := J)).filter fun p => d p.2 < d p.1).card
            * (-1) ^ ((finiteOrderedPairs (J := J)).filter fun p => d p.2 < d p.1).card) := by
        rw [hsq, hsq, mul_one, mul_one]
    _ = ((-1 : ℤ) ^ finiteOrderedInversionCount (d.permCongr σ)
          * (-1) ^ finiteOrderedInversionCount σ
          * (-1) ^ ((finiteOrderedPairs (J := J)).filter fun p => d p.2 < d p.1).card
          * (-1) ^ ((finiteOrderedPairs (J := J)).filter fun p => d p.2 < d p.1).card)
          * (-1) ^ finiteOrderedInversionCount σ := by ring
    _ = 1 * (-1) ^ finiteOrderedInversionCount σ := by rw [hprod]
    _ = finiteOrderedSign σ := by rw [one_mul]; rfl

end Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign
