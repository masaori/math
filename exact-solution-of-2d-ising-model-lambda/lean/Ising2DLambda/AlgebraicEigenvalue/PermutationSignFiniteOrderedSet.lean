/-
主張「符号は合成について乗法的である」（`claim_permutation_sign_mul`）の、線型順序を持つ
任意の有限集合 `𝒥` の上の具体版。人手証明と 1 対 1 に対応させる。

本文の定義 `def_permutation_sign` は有限集合 `𝒥` とその上の線型順序 `≺` を一般に置いて
述べている。`PermutationSign.lean` の `permSign_comp` は `𝒥` を行配位に取った場合であり、
完全マッチングの符号（`𝒥` は向き付き辺など任意の有限線型順序集合）はこちらを引く。

  人手証明                                  このファイル
  P_L（順序づけられた対の全体）             orderedPairs（本文の定義を書いたもの）
  inv(φ)、sgn(φ)                           inversionCount、sign（同上）
  符号の 2 乗は 1                           finiteOrderedSign_mul_self
  乗法性の証明の準備の写像 Ψ                finiteOrderedPairMap
  Ψ が P_L の中へ入ること                   finiteOrderedPairMap_mem
  Ψ' が Ψ の逆写像であること                finiteOrderedPairMap_inv_pairMap・finiteOrderedPairMap_pairMap_inv
  |C| = inv(φ)                              finiteOrderedInversionCount_eq_card_pairMap
  属するときだけ -1 を掛けた有限積          finiteOrdered_prod_ite_neg_one
  各対で A, B, C が偶数個                   finiteOrdered_parity_at_pair
  sgn(φ∘ψ)sgn(φ)sgn(ψ) = 1 の六行           finiteOrderedSign_comp_mul_mul
  乗法性の五行                              finiteOrderedSign_comp

符号・転倒数・順序対の集合は、本文の定義をそのまま書いた定義（`sign`・`inversionCount`・
`orderedPairs`）を使う。必要十分版の定理は一つも引かない。mathlib の `Equiv.Perm.sign` も引かない。
順序について使うのは三分律の三つの帰結（`ne_of_lt`・`lt_asymm`・`lt_or_gt_of_ne`）だけで、
推移律は使わない（本文の末尾の段落）。

住処: 有限集合の数え上げと整数の積だけで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign inversionCount orderedPairs)

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- `P_L` の元であることの言い換え（定義の展開）。 -/
theorem finiteOrdered_mem_orderedPairs {p : J × J} :
    p ∈ orderedPairs (fun x y : J => x < y) ↔ p.1 < p.2 := by
  simp [orderedPairs]

/-- 本文の「符号の 2 乗は 1」。 -/
theorem finiteOrderedSign_mul_self (φ : Equiv.Perm J) :
    sign (fun x y : J => x < y) φ * sign (fun x y : J => x < y) φ = 1 := by
  unfold sign
  rw [← pow_add, ← two_mul, pow_mul, neg_one_sq, one_pow]

/-- 本文の写像 `Ψ`。`ψ` の像を `≺` について並べ直した対を返す。 -/
def finiteOrderedPairMap (ψ : Equiv.Perm J) (p : J × J) : J × J :=
  if ψ p.1 < ψ p.2 then (ψ p.1, ψ p.2) else (ψ p.2, ψ p.1)

/-- 本文の「これが定まることを見る」。三分律から `u ≠ u'`、単射性から `ψ(u) ≠ ψ(u')`、
ふたたび三分律からどちらの場合も右辺は `P_L` の元。 -/
theorem finiteOrderedPairMap_mem (ψ : Equiv.Perm J) {p : J × J}
    (hp : p ∈ orderedPairs (fun x y : J => x < y)) :
    finiteOrderedPairMap ψ p ∈ orderedPairs (fun x y : J => x < y) := by
  have hne : p.1 ≠ p.2 := ne_of_lt (finiteOrdered_mem_orderedPairs.mp hp)
  have hψ : ψ p.1 ≠ ψ p.2 := fun h => hne (ψ.injective h)
  rw [finiteOrdered_mem_orderedPairs, finiteOrderedPairMap]
  by_cases h : ψ p.1 < ψ p.2
  · simp [h]
  · rcases lt_or_gt_of_ne hψ with h' | h'
    · exact absurd h' h
    · simpa [h] using h'

/-- 本文の「`ψ⁻¹` から同じ作り方で得られる写像 `Ψ'` について `Ψ'(Ψ(u,u')) = (u,u')`」。
二つの場合とも、成分を `ψ⁻¹` で戻すと `u, u'` か `u', u` で、`u ≺ u'` から `(u,u')` に並ぶ。 -/
theorem finiteOrderedPairMap_inv_pairMap (ψ : Equiv.Perm J) {p : J × J}
    (hp : p ∈ orderedPairs (fun x y : J => x < y)) :
    finiteOrderedPairMap ψ⁻¹ (finiteOrderedPairMap ψ p) = p := by
  have hlt : p.1 < p.2 := finiteOrdered_mem_orderedPairs.mp hp
  have hnot : ¬ p.2 < p.1 := lt_asymm hlt
  by_cases h : ψ p.1 < ψ p.2
  · simp [finiteOrderedPairMap, h, hlt]
  · simp [finiteOrderedPairMap, h, hnot]

/-- 本文の「`ψ` と `ψ⁻¹` を入れ替えれば同じ議論で `Ψ(Ψ'(u,u')) = (u,u')`」。 -/
theorem finiteOrderedPairMap_pairMap_inv (ψ : Equiv.Perm J) {p : J × J}
    (hp : p ∈ orderedPairs (fun x y : J => x < y)) :
    finiteOrderedPairMap ψ (finiteOrderedPairMap ψ⁻¹ p) = p := by
  have h := finiteOrderedPairMap_inv_pairMap ψ⁻¹ hp
  rwa [inv_inv] at h

/-- 本文の「`C` は `Ψ` による `{φ(υ') ≺ φ(υ)}` の逆像であり、`Ψ` が全単射なので `|C| = inv(φ)`」。 -/
theorem finiteOrderedInversionCount_eq_card_pairMap (φ ψ : Equiv.Perm J) :
    inversionCount (fun x y : J => x < y) φ
      = ((orderedPairs (fun x y : J => x < y)).filter fun p =>
          φ (finiteOrderedPairMap ψ p).2 < φ (finiteOrderedPairMap ψ p).1).card := by
  refine card_nbij' (finiteOrderedPairMap ψ⁻¹) (finiteOrderedPairMap ψ) ?_ ?_ ?_ ?_
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq ⊢
    refine ⟨finiteOrderedPairMap_mem ψ⁻¹ hq.1, ?_⟩
    rw [finiteOrderedPairMap_pairMap_inv ψ hq.1]
    exact hq.2
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp ⊢
    exact ⟨finiteOrderedPairMap_mem ψ hp.1, hp.2⟩
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq
    exact finiteOrderedPairMap_pairMap_inv ψ hq.1
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp
    exact finiteOrderedPairMap_inv_pairMap ψ hp.1

/-- 本文の「属するときだけ `-1` を掛けた有限積は `(-1)` の個数乗」（`f_X` の積）。 -/
theorem finiteOrdered_prod_ite_neg_one {β : Type*} (s : Finset β) (q : β → Prop) [DecidablePred q] :
    (∏ p ∈ s, if q p then (-1 : ℤ) else 1) = (-1) ^ (s.filter q).card := by
  rw [prod_ite, prod_const, prod_const_one, mul_one]

/-- 本文の「各対について `A, B, C` のうちその対が属するものの個数は偶数」、
すなわち `f_A(u,u')·f_C(u,u')·f_B(u,u') = 1`。場合分けは本文と同じ二つ。 -/
theorem finiteOrdered_parity_at_pair (φ ψ : Equiv.Perm J) {p : J × J}
    (hp : p ∈ orderedPairs (fun x y : J => x < y)) :
    (if (φ * ψ) p.2 < (φ * ψ) p.1 then (-1 : ℤ) else 1)
        * (if φ (finiteOrderedPairMap ψ p).2 < φ (finiteOrderedPairMap ψ p).1 then (-1 : ℤ) else 1)
        * (if ψ p.2 < ψ p.1 then (-1 : ℤ) else 1) = 1 := by
  have hlt : p.1 < p.2 := finiteOrdered_mem_orderedPairs.mp hp
  have hne : p.1 ≠ p.2 := ne_of_lt hlt
  have hψne : ψ p.1 ≠ ψ p.2 := fun hh => hne (ψ.injective hh)
  have hφne : φ (ψ p.1) ≠ φ (ψ p.2) := fun hh => hψne (φ.injective hh)
  by_cases h : ψ p.1 < ψ p.2
  · -- ψ(u) ≺ ψ(u') の場合。B に属さず、C の条件は A の条件と同じ。
    have hB : ¬ ψ p.2 < ψ p.1 := lt_asymm h
    by_cases hA : φ (ψ p.2) < φ (ψ p.1)
    · simp [finiteOrderedPairMap, h, hB, hA, Equiv.Perm.mul_apply]
    · simp [finiteOrderedPairMap, h, hB, hA, Equiv.Perm.mul_apply]
  · -- ψ(u') ≺ ψ(u) の場合。B に属し、A の条件と C の条件のちょうど一方が成り立つ。
    have hB : ψ p.2 < ψ p.1 := by
      rcases lt_or_gt_of_ne hψne with h' | h'
      · exact absurd h' h
      · exact h'
    by_cases hA : φ (ψ p.2) < φ (ψ p.1)
    · have hC : ¬ φ (ψ p.1) < φ (ψ p.2) := lt_asymm hA
      simp [finiteOrderedPairMap, h, hB, hA, hC, Equiv.Perm.mul_apply]
    · have hC : φ (ψ p.1) < φ (ψ p.2) := by
        rcases lt_or_gt_of_ne hφne with h' | h'
        · exact h'
        · exact absurd h' hA
      simp [finiteOrderedPairMap, h, hB, hA, hC, Equiv.Perm.mul_apply]

/-- 本文の一つめの式変形 `sgn(φ∘ψ)·sgn(φ)·sgn(ψ) = 1` の六行。 -/
theorem finiteOrderedSign_comp_mul_mul (φ ψ : Equiv.Perm J) :
    sign (fun x y : J => x < y) (φ * ψ) * sign (fun x y : J => x < y) φ
        * sign (fun x y : J => x < y) ψ = 1 := by
  -- 一行目と二行目: 符号の定義と |A| = inv(φ∘ψ), |C| = inv(φ), |B| = inv(ψ)。
  rw [sign, sign, sign, finiteOrderedInversionCount_eq_card_pairMap φ ψ]
  simp only [inversionCount]
  -- 三行目: 属するときだけ -1 を掛けた有限積は (-1) の個数乗。
  rw [← finiteOrdered_prod_ite_neg_one (orderedPairs (fun x y : J => x < y)) fun p =>
        (φ * ψ) p.2 < (φ * ψ) p.1,
      ← finiteOrdered_prod_ite_neg_one (orderedPairs (fun x y : J => x < y)) fun p =>
        φ (finiteOrderedPairMap ψ p).2 < φ (finiteOrderedPairMap ψ p).1,
      ← finiteOrdered_prod_ite_neg_one (orderedPairs (fun x y : J => x < y)) fun p =>
        ψ p.2 < ψ p.1]
  -- 四行目: 有限積の各因子ごとのまとめ。
  rw [← prod_mul_distrib, ← prod_mul_distrib]
  -- 五行目と六行目: 属するものの個数が偶数なので各因子は 1、1 の有限積は 1。
  rw [prod_congr rfl fun p hp => finiteOrdered_parity_at_pair φ ψ hp, prod_const_one]

/-- 本文の主張 `sgn(φ ∘ ψ) = sgn(φ)·sgn(ψ)`（二つめの式変形の五行）。
`(φ * ψ) u = φ (ψ u)` なので、mathlib の積が本文の合成にあたる。 -/
theorem finiteOrderedSign_comp (φ ψ : Equiv.Perm J) :
    sign (fun x y : J => x < y) (φ * ψ)
      = sign (fun x y : J => x < y) φ * sign (fun x y : J => x < y) ψ := by
  calc sign (fun x y : J => x < y) (φ * ψ)
      = sign (fun x y : J => x < y) (φ * ψ) * 1 * 1 := by ring
    _ = sign (fun x y : J => x < y) (φ * ψ)
          * (sign (fun x y : J => x < y) φ * sign (fun x y : J => x < y) φ)
          * (sign (fun x y : J => x < y) ψ * sign (fun x y : J => x < y) ψ) := by
        rw [finiteOrderedSign_mul_self, finiteOrderedSign_mul_self]
    _ = (sign (fun x y : J => x < y) (φ * ψ) * sign (fun x y : J => x < y) φ
            * sign (fun x y : J => x < y) ψ)
          * sign (fun x y : J => x < y) φ * sign (fun x y : J => x < y) ψ := by ring
    _ = 1 * sign (fun x y : J => x < y) φ * sign (fun x y : J => x < y) ψ := by
        rw [finiteOrderedSign_comp_mul_mul]
    _ = sign (fun x y : J => x < y) φ * sign (fun x y : J => x < y) ψ := by ring

end Ising2DLambda.AlgebraicEigenvalue
