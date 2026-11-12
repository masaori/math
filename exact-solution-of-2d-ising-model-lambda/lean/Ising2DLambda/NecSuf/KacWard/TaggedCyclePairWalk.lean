/-
「非零項は閉歩道ごとのねじれ・回転位相の積に分かれる」の、実際の交互閉路の対を閉歩道の辺で読む段の
必要十分版。具体版と同じ二つの手順（閉路の対を閉歩道の辺で読む、向き直しの列を閉路の対と共通対の
連結に取って寄与を短い・長い標識へ読み分ける）を、次の一般の対象で行う。

* 閉歩道の辺による読み: 任意の型 K 上の写像 ι と点列 c : ℕ → K。仮定は ι が対合であること（hι）と、
  奇数番目の点の次の点がその ι であること（hstep。r < k の範囲だけ）である。hι を外すと
  第一成分 c(2r) = ι(ι(c(2r))) が言えない。hstep を外すと第二成分 c(2r+1) = ι(c(2r+2)) が言えない。
  K が向き付き辺であること、ι が反転であること、c が交互閉路の反復であることは使わない。
* 寄与の読み分け: 有限線型順序 J の対から可換環 R への、向きを変えると負になる二つの写像 ℓ・𝔰、
  任意の完全マッチング D と昇順対の部分集合 t、偶数長の点列の列 cs と対の列 P。仮定は、
  連結した端点列が完全列挙であること（hc）、各閉路の対と各共通対が D の対であること（hD・hP）、
  閉路の対の昇順が t に在ること（hshort）、共通対の昇順が t に無いこと（hlong）だけである。
  hshort・hlong のどちらかを外すと、その対の寄与が 𝔰 と ℓ のどちらかに決まらない。
  偶数長（hev）を外すと、二つずつ区切った対の端点列が閉路の点列に戻らず、hc から列の完全性が出ない。
  活動点・非零項・射影した閉歩道であることは使わない（具体版ではそれらから hshort・hlong を得る）。
-/
import Ising2DLambda.KacWard.TaggedAlternatingCycleMatchingSign
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingTermOrientation

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.KacWard (consecutivePairs consecutivePairs_map_range ascendingPair
  pairWord_consecutivePairs matchingPairWord_append matchingPairWord_flatten)
open scoped Classical

/-- 閉歩道の辺による読みの必要十分版。w_r = ι(c(2r)) と置くと、(c(2r), c(2r+1)) = (ι(w_r), w_{r+1})。 -/
theorem cycle_pairs_walk_necSuf {K : Type*} (ι : K → K) (hι : ∀ e, ι (ι e) = e)
    (c : ℕ → K) (k : ℕ) (hstep : ∀ r < k, c (2 * r + 2) = ι (c (2 * r + 1))) :
    consecutivePairs ((List.range (2 * k)).map c) =
      (List.range k).map (fun r => (ι (ι (c (2 * r))), ι (c (2 * (r + 1))))) := by
  rw [consecutivePairs_map_range]
  apply List.map_congr_left
  intro r hr
  have hr' : r < k := List.mem_range.mp hr
  rw [hι, show 2 * (r + 1) = 2 * r + 2 by ring, hstep r hr', hι]

variable {J R : Type*} [Fintype J] [LinearOrder J] [CommRing R]

/-- 寄与の読み分けの必要十分版。 -/
theorem tagged_cycle_term_split_necSuf (ℓ 𝔰 : J × J → R)
    (hℓ : ∀ p : J × J, ℓ (p.2, p.1) = -ℓ p) (h𝔰 : ∀ p : J × J, 𝔰 (p.2, p.1) = -𝔰 p)
    (D : PerfectMatching J) (t : Finset (J × J)) (ht : t ⊆ matchingOrientedPairs D)
    (cs : List (List J)) (P : List (J × J))
    (hev : ∀ c ∈ cs, Even c.length)
    (hc : IsCompleteWord (cs.flatten ++ matchingPairWord P))
    (hD : ∀ c ∈ cs, ∀ p ∈ consecutivePairs c, ({p.1, p.2} : Set J) ∈ D.val)
    (hP : ∀ p ∈ P, ({p.1, p.2} : Set J) ∈ D.val)
    (hshort : ∀ c ∈ cs, ∀ p ∈ consecutivePairs c, ascendingPair p ∈ t)
    (hlong : ∀ p ∈ P, ascendingPair p ∉ t) :
    (∏ p ∈ matchingOrientedPairs D \ t, ℓ p) * (∏ p ∈ t, 𝔰 p) =
      (((cs.map consecutivePairs).flatten ++ P).map (pairOrientationIn R)).prod *
        ((cs.map (fun c => ((consecutivePairs c).map 𝔰).prod)).prod * (P.map ℓ).prod) := by
  have hcycles : (cs.map consecutivePairs).map matchingPairWord = cs := by
    rw [List.map_map]
    conv_rhs => rw [← List.map_id cs]
    exact List.map_congr_left fun c hc' => pairWord_consecutivePairs c (hev c hc')
  have hcw : IsCompleteWord (matchingPairWord ((cs.map consecutivePairs).flatten ++ P)) := by
    rw [matchingPairWord_append, matchingPairWord_flatten, hcycles]
    exact hc
  have hDl : ∀ p ∈ (cs.map consecutivePairs).flatten ++ P, ({p.1, p.2} : Set J) ∈ D.val := by
    intro p hp
    rcases List.mem_append.mp hp with hcyc | hcom
    · obtain ⟨l, hl, hpl⟩ := List.mem_flatten.mp hcyc
      obtain ⟨c, hc', rfl⟩ := List.mem_map.mp hl
      exact hD c hc' p hpl
    · exact hP p hcom
  rw [tagged_matching_term_oriented_necSuf ℓ 𝔰 hℓ h𝔰 D t ht _ hcw hDl]
  congr 1
  have hcyc : ∀ c ∈ cs,
      ((consecutivePairs c).map (fun p => if ascendingPair p ∈ t then 𝔰 p else ℓ p)).prod =
        ((consecutivePairs c).map 𝔰).prod := by
    intro c hc'
    congr 1
    exact List.map_congr_left fun p hp => if_pos (hshort c hc' p hp)
  have hcom : P.map (fun p => if ascendingPair p ∈ t then 𝔰 p else ℓ p) = P.map ℓ :=
    List.map_congr_left fun p hp => if_neg (hlong p hp)
  rw [List.map_append, List.prod_append, List.map_flatten, List.prod_flatten, List.map_map,
    List.map_map, hcom]
  congr 1
  exact congrArg List.prod (List.map_congr_left hcyc)

end Ising2DLambda.NecSuf.KacWard
