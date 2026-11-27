/-
「非零項は閉歩道ごとのねじれ・回転位相の積に分かれる」の、項を向き付き対の列で書き直す段の必要十分版。
具体版と同じ手順（長い対の積と短い対の積を標識で読む一つの積へまとめ、昇順対の積を列 l の上の積へ
移し、各対で昇順へ直す符号を前へ出す）を、次の一般の対象で行う。

* 寄与: 有限線型順序 J の対から可換環 R への任意の二つの写像 ℓ（長い標識）と 𝔰（短い標識）。
  仮定は「対の向きを変えると値が負になる」（hℓ・h𝔰）だけである。外すと、降順の対で
  昇順へ直した寄与が η 倍にならない。二つのどちらかだけでは、t の中の対か外の対で破れる。
  反対称化した端末行列から来ること、z⁴ = -1、多項式環であることは使わない。
* マッチング: 任意の完全マッチング D と、昇順対の部分集合 t（ht）。t ⊆ 昇順対の集合を外すと、
  左辺の短い対の積に D の対でないものが入り、右辺の昇順対の積と一致しない。
* 列: 端点列が完全列挙で（hc）、各対が D の対である（hD）こと。昇順へ直した列が D の列挙になる
  ことにだけ使う。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatchingEnumeration
import Ising2DLambda.NecSuf.KacWard.AlternatingCycleMatchingSign
import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue
open scoped Classical

variable {J R : Type*} [Fintype J] [LinearOrder J] [CommRing R]

/-- 本文の向き直しの必要十分版。 -/
theorem tagged_matching_term_oriented_necSuf (ℓ 𝔰 : J × J → R)
    (hℓ : ∀ p : J × J, ℓ (p.2, p.1) = -ℓ p) (h𝔰 : ∀ p : J × J, 𝔰 (p.2, p.1) = -𝔰 p)
    (D : PerfectMatching J) (t : Finset (J × J)) (ht : t ⊆ orientedMatchingPairs D)
    (asc : J × J → J × J) (hasc : ∀ p, asc p = if p.1 < p.2 then p else (p.2, p.1))
    (l : List (J × J)) (hc : IsCompleteWord (matchingPairWord l))
    (hD : ∀ p ∈ l, ({p.1, p.2} : Set J) ∈ D.val) :
    (∏ p ∈ orientedMatchingPairs D \ t, ℓ p) * (∏ p ∈ t, 𝔰 p) =
      (l.map (pairOrientationIn R)).prod *
        (l.map (fun p => if asc p ∈ t then 𝔰 p else ℓ p)).prod := by
  let g : J × J → R := fun q => if q ∈ t then 𝔰 q else ℓ q
  let h : J × J → R := fun p => if asc p ∈ t then 𝔰 p else ℓ p
  have hvalue : ∀ p : J × J, g (asc p) = pairOrientationIn R p * h p := by
    intro p
    by_cases hlt : p.1 < p.2
    · have ha : asc p = p := by rw [hasc, if_pos hlt]
      simp only [g, h, ha, pairOrientationIn, if_pos hlt, one_mul]
    · have ha : asc p = (p.2, p.1) := by rw [hasc, if_neg hlt]
      simp only [g, h, ha, pairOrientationIn, if_neg hlt, neg_one_mul]
      split_ifs
      · exact h𝔰 p
      · exact hℓ p
  have hen : IsMatchingPairEnumeration D (l.map asc) := by
    have hne : ∀ p ∈ l, p.1 ≠ p.2 := by
      intro p hp
      have h := (List.nodup_flatMap.mp hc.1).1 p hp
      simpa using h
    have hset : ∀ p : J × J,
        ({(asc p).1, (asc p).2} : Set J) = {p.1, p.2} := by
      intro p
      rw [hasc]
      split_ifs
      · rfl
      · exact Set.pair_comm _ _
    have hasc' : ∀ p ∈ l, (asc p).1 < (asc p).2 := by
      intro p hp
      rw [hasc]
      split_ifs with h
      · exact h
      · exact lt_of_le_of_ne (not_lt.mp h) (hne p hp).symm
    have heq : ∀ p q : J × J, p.1 < p.2 → q.1 < q.2 →
        ({p.1, p.2} : Set J) = {q.1, q.2} → p = q := by
      intro p q hp hq he
      rcases Set.pair_eq_pair_iff.mp he with h | h
      · exact Prod.ext h.1 h.2
      · have : p.2 < p.1 := by simpa [h.1, h.2] using hq
        exact (hp.asymm this).elim
    have hlnd : l.Nodup := by
      apply (List.nodup_flatMap.mp hc.1).2.imp
      intro p q hd hpq
      subst hpq
      exact hd (by simp : p.1 ∈ [p.1, p.2]) (by simp)
    refine ⟨hlnd.map_on ?_, fun q => ?_⟩
    · intro p hp q hq hpq
      have hs : ({p.1, p.2} : Set J) = {q.1, q.2} := by
        rw [← hset p, ← hset q, hpq]
      have hpw := (List.nodup_flatMap.mp hc.1).2
      haveI : Std.Symm (fun a b : J × J =>
          List.Disjoint [a.1, a.2] [b.1, b.2]) :=
        ⟨fun _ _ h => List.disjoint_comm.mp h⟩
      have hdis := hpw.forall hp hq
      by_contra hnepq
      exact hdis hnepq (by simp : p.1 ∈ [p.1, p.2])
        (by simpa only [Set.mem_insert_iff, Set.mem_singleton_iff,
          List.mem_cons, List.not_mem_nil, or_false] using (show p.1 ∈ ({q.1, q.2} : Set J) by
            rw [← hs]; simp))
    · constructor
      · intro hq
        obtain ⟨p, hp, rfl⟩ := List.mem_map.mp hq
        exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hasc' p hp, by rw [hset]; exact hD p hp⟩
      · intro hq
        have hq' := (Finset.mem_filter.mp hq).2
        obtain ⟨p, hp, hxp⟩ := List.mem_flatMap.mp (hc.2 q.1)
        refine List.mem_map.mpr ⟨p, hp, heq _ _ (hasc' p hp) hq'.1 ?_⟩
        obtain ⟨s, _, hu⟩ := D.property.2 q.1
        rw [hset]
        exact (hu _ ⟨hD p hp, by simpa using hxp⟩).trans
          (hu _ ⟨hq'.2, by simp⟩).symm
  have hfin : orientedMatchingPairs D = (l.map asc).toFinset := by
    ext q
    rw [List.mem_toFinset]
    exact (hen.2 q).symm
  calc
    (∏ p ∈ orientedMatchingPairs D \ t, ℓ p) * (∏ p ∈ t, 𝔰 p) =
        (∏ q ∈ (orientedMatchingPairs D).filter (· ∈ t), 𝔰 q) *
          (∏ q ∈ (orientedMatchingPairs D).filter (· ∉ t), ℓ q) := by
      rw [Finset.filter_mem_eq_inter, Finset.inter_eq_right.mpr ht, Finset.filter_notMem_eq_sdiff,
        mul_comm]
    _ = ∏ q ∈ orientedMatchingPairs D, g q := (Finset.prod_ite _ _).symm
    _ = ((l.map asc).map g).prod := by rw [hfin, List.prod_toFinset _ hen.1]
    _ = (l.map (fun p => pairOrientationIn R p * h p)).prod := by
      rw [List.map_map]
      congr 1
      exact List.map_congr_left fun p _ => hvalue p
    _ = (l.map (pairOrientationIn R)).prod * (l.map h).prod := List.prod_map_mul

end Ising2DLambda.NecSuf.KacWard
