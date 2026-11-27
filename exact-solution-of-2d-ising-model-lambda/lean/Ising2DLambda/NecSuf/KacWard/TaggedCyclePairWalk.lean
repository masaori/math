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
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingTermOrientation

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue
open scoped Classical

def ascendingPairOf {J : Type*} [LinearOrder J] (p : J × J) : J × J :=
  if p.1 < p.2 then p else (p.2, p.1)

private theorem pairWord_append {K : Type*} (l r : List (K × K)) :
    matchingPairWord (l ++ r) = matchingPairWord l ++ matchingPairWord r := by
  simp [matchingPairWord, List.flatMap_append]

private theorem pairWord_flatten {K : Type*} :
    ∀ ls : List (List (K × K)),
      matchingPairWord ls.flatten = (ls.map matchingPairWord).flatten
  | [] => rfl
  | l :: ls => by
      rw [List.flatten_cons, pairWord_append, pairWord_flatten ls]
      rfl

private theorem pairWord_pairChunks_of_even {K : Type*} :
    ∀ (c : List K), Even c.length →
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.matchingPairWord (pairChunks c) = c
  | [], _ => rfl
  | [_], h => by simp at h
  | a :: b :: rest, h => by
      have hr : Even rest.length := by
        obtain ⟨k, hk⟩ := h
        refine ⟨k - 1, ?_⟩
        simp only [List.length_cons] at hk
        omega
      simpa [pairChunks, matchingPairWord] using
        congrArg (fun l => a :: b :: l) (pairWord_pairChunks_of_even rest hr)

/-- 閉歩道の辺による読みの必要十分版。w_r = ι(c(2r)) と置くと、(c(2r), c(2r+1)) = (ι(w_r), w_{r+1})。 -/
theorem cycle_pairs_walk_necSuf {K : Type*} (ι : K → K) (hι : ∀ e, ι (ι e) = e)
    (c : ℕ → K) (k : ℕ) (hstep : ∀ r < k, c (2 * r + 2) = ι (c (2 * r + 1))) :
    pairChunks ((List.range (2 * k)).map c) =
      (List.range k).map (fun r => (ι (ι (c (2 * r))), ι (c (2 * (r + 1))))) := by
  rw [pairChunks_map_range]
  apply List.map_congr_left
  intro r hr
  have hr' : r < k := List.mem_range.mp hr
  rw [hι, show 2 * (r + 1) = 2 * r + 2 by ring, hstep r hr', hι]

variable {J R : Type*} [Fintype J] [LinearOrder J] [CommRing R]

/-- 寄与の読み分けの必要十分版。 -/
theorem tagged_cycle_term_split_necSuf (ℓ 𝔰 : J × J → R)
    (hℓ : ∀ p : J × J, ℓ (p.2, p.1) = -ℓ p) (h𝔰 : ∀ p : J × J, 𝔰 (p.2, p.1) = -𝔰 p)
    (D : PerfectMatching J) (t : Finset (J × J))
    (ht : t ⊆ Ising2DLambda.NecSuf.AlgebraicEigenvalue.orientedMatchingPairs D)
    (cs : List (List J)) (P : List (J × J))
    (hev : ∀ c ∈ cs, Even c.length)
    (hc : IsCompleteWord (cs.flatten ++ matchingPairWord P))
    (hD : ∀ c ∈ cs, ∀ p ∈ pairChunks c, ({p.1, p.2} : Set J) ∈ D.val)
    (hP : ∀ p ∈ P, ({p.1, p.2} : Set J) ∈ D.val)
    (hshort : ∀ c ∈ cs, ∀ p ∈ pairChunks c, ascendingPairOf p ∈ t)
    (hlong : ∀ p ∈ P, ascendingPairOf p ∉ t) :
    (∏ p ∈ Ising2DLambda.NecSuf.AlgebraicEigenvalue.orientedMatchingPairs D \ t, ℓ p) *
      (∏ p ∈ t, 𝔰 p) =
      (((cs.map pairChunks).flatten ++ P).map (pairOrientationIn R)).prod *
        ((cs.map (fun c => ((pairChunks c).map 𝔰).prod)).prod * (P.map ℓ).prod) := by
  have hcycles : (cs.map pairChunks).map matchingPairWord = cs := by
    rw [List.map_map]
    conv_rhs => rw [← List.map_id cs]
    exact List.map_congr_left fun c hc' => pairWord_pairChunks_of_even c (hev c hc')
  have hcw : IsCompleteWord (matchingPairWord ((cs.map pairChunks).flatten ++ P)) := by
    rw [pairWord_append, pairWord_flatten, hcycles]
    exact hc
  have hDl : ∀ p ∈ (cs.map pairChunks).flatten ++ P, ({p.1, p.2} : Set J) ∈ D.val := by
    intro p hp
    rcases List.mem_append.mp hp with hcyc | hcom
    · obtain ⟨l, hl, hpl⟩ := List.mem_flatten.mp hcyc
      obtain ⟨c, hc', rfl⟩ := List.mem_map.mp hl
      exact hD c hc' p hpl
    · exact hP p hcom
  rw [tagged_matching_term_oriented_necSuf ℓ 𝔰 hℓ h𝔰 D t ht
    ascendingPairOf (by intro p; rfl) _ hcw hDl]
  congr 1
  have hcyc : ∀ c ∈ cs,
      ((pairChunks c).map (fun p => if ascendingPairOf p ∈ t then 𝔰 p else ℓ p)).prod =
        ((pairChunks c).map 𝔰).prod := by
    intro c hc'
    congr 1
    exact List.map_congr_left fun p hp => if_pos (hshort c hc' p hp)
  have hcom : P.map (fun p => if ascendingPairOf p ∈ t then 𝔰 p else ℓ p) = P.map ℓ :=
    List.map_congr_left fun p hp => if_neg (hlong p hp)
  rw [List.map_append, List.prod_append, List.map_flatten, List.prod_flatten, List.map_map,
    List.map_map, hcom]
  congr 1
  exact congrArg List.prod (List.map_congr_left hcyc)

end Ising2DLambda.NecSuf.KacWard
