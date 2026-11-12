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
import Ising2DLambda.KacWard.AlternatingCycleMatchingSign
import Ising2DLambda.NecSuf.KacWard.AlternatingCycleMatchingSign

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.KacWard (ascendingPair ascendingPairs_enumeration)
open scoped Classical

variable {J R : Type*} [Fintype J] [LinearOrder J] [CommRing R]

/-- 本文の向き直しの必要十分版。 -/
theorem tagged_matching_term_oriented_necSuf (ℓ 𝔰 : J × J → R)
    (hℓ : ∀ p : J × J, ℓ (p.2, p.1) = -ℓ p) (h𝔰 : ∀ p : J × J, 𝔰 (p.2, p.1) = -𝔰 p)
    (D : PerfectMatching J) (t : Finset (J × J)) (ht : t ⊆ matchingOrientedPairs D)
    (l : List (J × J)) (hc : IsCompleteWord (matchingPairWord l))
    (hD : ∀ p ∈ l, ({p.1, p.2} : Set J) ∈ D.val) :
    (∏ p ∈ matchingOrientedPairs D \ t, ℓ p) * (∏ p ∈ t, 𝔰 p) =
      (l.map (pairOrientationIn R)).prod *
        (l.map (fun p => if ascendingPair p ∈ t then 𝔰 p else ℓ p)).prod := by
  let g : J × J → R := fun q => if q ∈ t then 𝔰 q else ℓ q
  let h : J × J → R := fun p => if ascendingPair p ∈ t then 𝔰 p else ℓ p
  have hasc : ∀ p : J × J, g (ascendingPair p) = pairOrientationIn R p * h p := by
    intro p
    by_cases hlt : p.1 < p.2
    · have ha : ascendingPair p = p := if_pos hlt
      simp only [g, h, ha, pairOrientationIn, if_pos hlt, one_mul]
    · have ha : ascendingPair p = (p.2, p.1) := if_neg hlt
      simp only [g, h, ha, pairOrientationIn, if_neg hlt, neg_one_mul]
      split_ifs
      · exact h𝔰 p
      · exact hℓ p
  have hen := ascendingPairs_enumeration D l hc hD
  have hfin : matchingOrientedPairs D = (l.map ascendingPair).toFinset := by
    ext q
    rw [List.mem_toFinset]
    exact (hen.2 q).symm
  calc
    (∏ p ∈ matchingOrientedPairs D \ t, ℓ p) * (∏ p ∈ t, 𝔰 p) =
        (∏ q ∈ (matchingOrientedPairs D).filter (· ∈ t), 𝔰 q) *
          (∏ q ∈ (matchingOrientedPairs D).filter (· ∉ t), ℓ q) := by
      rw [Finset.filter_mem_eq_inter, Finset.inter_eq_right.mpr ht, Finset.filter_notMem_eq_sdiff,
        mul_comm]
    _ = ∏ q ∈ matchingOrientedPairs D, g q := (Finset.prod_ite _ _).symm
    _ = ((l.map ascendingPair).map g).prod := by rw [hfin, List.prod_toFinset _ hen.1]
    _ = (l.map (fun p => pairOrientationIn R p * h p)).prod := by
      rw [List.map_map]
      congr 1
      exact List.map_congr_left fun p _ => hasc p
    _ = (l.map (pairOrientationIn R)).prod * (l.map h).prod := List.prod_map_mul

end Ising2DLambda.NecSuf.KacWard
