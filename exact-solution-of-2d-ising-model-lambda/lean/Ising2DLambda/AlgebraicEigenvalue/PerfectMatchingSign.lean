/-
完全マッチングの符号（`def_perfect_matching_sign`）と列挙順序独立性
（`claim_perfect_matching_sign_enumeration_independent`）の具体版。
昇順対の列挙から実際の置換を作り、既証明の転倒符号の乗法性と互換符号を用いる。
四つの隣接交換および先頭を合わせる帰納法を本文どおりに記す。住処は有限集合と ℤ。
-/
import Ising2DLambda.AlgebraicEigenvalue.PerfectMatching
import Ising2DLambda.NecSuf.KacWard.PermutationSignOrbitProduct
import Mathlib.Data.List.NodupEquivFin
import Mathlib.Data.Finset.Sort

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign sign_comp sign_eq_one_or_neg_one inversionCount orderedPairs)
open Ising2DLambda.NecSuf.KacWard (transpositionPerm transpositionPerm_apply_left
  transpositionPerm_apply_right transpositionPerm_apply_of_ne sign_transposition
  trichotomous_of_linearOrder)

/-- 全元をちょうど一度ずつ記す有限列。 -/
def IsCompleteWord {J : Type*} (w : List J) : Prop :=
  w.Nodup ∧ ∀ x : J, x ∈ w

/-- 並べ替えは完全列挙を保つ。 -/
theorem IsCompleteWord.perm {J : Type*} {w v : List J}
    (h : IsCompleteWord w) (hp : w.Perm v) : IsCompleteWord v :=
  ⟨hp.nodup_iff.mp h.1, fun x => hp.mem_iff.mp (h.2 x)⟩

/-- 隣接交換による完全列挙の保存。 -/
theorem completeWord_swap {J : Type*} (u : List J) (a b : J) (v : List J)
    (h : IsCompleteWord (u ++ a :: b :: v)) :
    IsCompleteWord (u ++ b :: a :: v) :=
  h.perm ((List.Perm.swap b a v).append_left u)

/-- 先頭へ移す操作を隣接交換で作る。 -/
theorem matchingList_move_front {J : Type*} (u : List J) (a : J) (v : List J) :
    (u ++ a :: v).Perm (a :: (u ++ v)) := by
  induction u with
  | nil => exact List.Perm.refl _
  | cons b u ih =>
      exact (ih.cons b).trans (List.Perm.swap a b (u ++ v))

/-- 同じ元を重複なしに記した二列は、先頭を合わせる帰納法で並べ替えられる。 -/
theorem matchingList_perm_of_same_mem {J : Type*} {l r : List J}
    (hl : l.Nodup) (hr : r.Nodup) (hm : ∀ x, x ∈ l ↔ x ∈ r) : l.Perm r := by
  induction l generalizing r with
  | nil =>
      have : r = [] := by
        apply List.eq_nil_iff_forall_not_mem.mpr
        intro x hx
        simpa using (hm x).mpr hx
      subst r
      exact List.Perm.nil
  | cons a l ih =>
      obtain ⟨u, v, rfl⟩ := List.mem_iff_append.mp ((hm a).mp (by simp))
      have hp := matchingList_move_front u a v
      have hn : (a :: (u ++ v)).Nodup := hp.nodup_iff.mp hr
      have ht : l.Perm (u ++ v) := ih hl.tail hn.tail (by
        intro x
        have ha : a ∉ l := hl.notMem
        have hb : a ∉ u ++ v := hn.notMem
        by_cases hx : x = a
        · subst x; simp [ha, hb]
        · have hc := (hm x).trans hp.mem_iff
          simpa [hx] using hc)
      exact (ht.cons a).trans hp.symm

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 基準となる昇順の全列挙。 -/
def matchingBaseWord (J : Type*) [Fintype J] [LinearOrder J] : List J :=
  Finset.univ.sort (· ≤ ·)

theorem matchingBaseWord_complete : IsCompleteWord (matchingBaseWord J) := by
  exact ⟨Finset.sort_nodup _ _, fun x => by simp [matchingBaseWord]⟩

/-- 全列挙の長さは基準列の長さに等しい。 -/
theorem completeWord_length (w : List J) (h : IsCompleteWord w) :
    (matchingBaseWord J).length = w.length :=
  (matchingList_perm_of_same_mem matchingBaseWord_complete.1 h.1
    (fun x => iff_of_true (matchingBaseWord_complete.2 x) (h.2 x))).length_eq

/-- 昇順列の第 k 要素を与えられた列の第 k 要素へ送る、実際の置換。 -/
noncomputable def matchingWordPermutation (w : List J) (h : IsCompleteWord w) :
    Equiv.Perm J :=
  (List.Nodup.getEquivOfForallMemList (matchingBaseWord J)
    matchingBaseWord_complete.1 matchingBaseWord_complete.2).symm |>.trans
    ((finCongr (completeWord_length w h)).trans
      (List.Nodup.getEquivOfForallMemList w h.1 h.2))

/-- 置換の第 k 成分は、本文の定義どおりの第 k 要素である。 -/
theorem matchingWordPermutation_apply_get (w : List J) (h : IsCompleteWord w)
    (k : Fin (matchingBaseWord J).length) :
    matchingWordPermutation w h ((matchingBaseWord J).get k) =
      w.get (finCongr (completeWord_length w h) k) := by
  simp [matchingWordPermutation, List.Nodup.getEquivOfForallMemList, finCongr,
    matchingBaseWord_complete.1]

/-- 有効な列の符号。無効な列での零は Lean の全域化だけに用いる。 -/
noncomputable def matchingWordSign (w : List J) : ℤ := by
  classical
  exact if h : IsCompleteWord w then sign (fun x y : J => x < y) (matchingWordPermutation w h)
  else 0

theorem matchingWordSign_eq (w : List J) (h : IsCompleteWord w) :
    matchingWordSign w = sign (fun x y : J => x < y) (matchingWordPermutation w h) := by
  classical
  simp only [matchingWordSign, dif_pos h]

omit [Fintype J] [LinearOrder J] in
/-- 置換を各要素へ適用しても完全列挙である。 -/
theorem completeWord_map (w : List J) (h : IsCompleteWord w) (p : Equiv.Perm J) :
    IsCompleteWord (w.map p) := by
  refine ⟨h.1.map p.injective, ?_⟩
  intro x
  exact List.mem_map.mpr ⟨p.symm x, h.2 _, p.apply_symm_apply x⟩

/-- 要素への置換の適用は、列が定める置換との左合成そのものである。 -/
theorem matchingWordPermutation_map (w : List J) (h : IsCompleteWord w)
    (p : Equiv.Perm J) :
    matchingWordPermutation (w.map p) (completeWord_map w h p) =
      p * matchingWordPermutation w h := by
  ext x
  obtain ⟨k, hk⟩ := List.mem_iff_get.mp (matchingBaseWord_complete.2 x)
  rw [← hk]
  change matchingWordPermutation (w.map p) (completeWord_map w h p)
      ((matchingBaseWord J).get k) = p (matchingWordPermutation w h ((matchingBaseWord J).get k))
  calc
    matchingWordPermutation (w.map p) (completeWord_map w h p) ((matchingBaseWord J).get k)
        = (w.map p).get (finCongr (completeWord_length _ (completeWord_map w h p)) k) :=
          matchingWordPermutation_apply_get _ _ k
    _ = p (w.get (finCongr (completeWord_length w h) k)) := by
      simp [List.get_eq_getElem, finCongr]
    _ = p (matchingWordPermutation w h ((matchingBaseWord J).get k)) := by
      rw [matchingWordPermutation_apply_get]

/-- 既存の転倒符号の乗法性を、上の実際の置換の等号へ適用する。 -/
theorem matchingWordSign_map (w : List J) (h : IsCompleteWord w) (p : Equiv.Perm J) :
    matchingWordSign (w.map p) =
      sign (fun x y : J => x < y) p * matchingWordSign w := by
  rw [matchingWordSign_eq _ (completeWord_map w h p), matchingWordPermutation_map,
    sign_comp _ trichotomous_of_linearOrder, matchingWordSign_eq _ h]

omit [Fintype J] in
/-- 隣接二要素の交換を、値の互換の作用として同定する。 -/
theorem matchingWord_swap_eq_map (u : List J) (a b : J) (v : List J)
    (h : IsCompleteWord (u ++ a :: b :: v)) :
    (u ++ a :: b :: v).map (transpositionPerm a b) = u ++ b :: a :: v := by
  have hnd := List.nodup_append.mp h.1
  have htail := List.nodup_cons.mp hnd.2.1
  have hau : a ∉ u := by
    intro ha
    exact hnd.2.2 a ha a (by simp) rfl
  have hbu : b ∉ u := by
    intro hb
    exact hnd.2.2 b hb b (by simp) rfl
  have hav : a ∉ v := fun hx => htail.1 (List.mem_cons_of_mem b hx)
  have hbv : b ∉ v := (List.nodup_cons.mp htail.2).1
  have fix (l : List J) (ha : a ∉ l) (hb : b ∉ l) :
      l.map (transpositionPerm a b) = l := by
    have hf : ∀ x ∈ l, transpositionPerm a b x = id x := by
      intro x hx
      exact transpositionPerm_apply_of_ne a b
        (fun he => ha (he ▸ hx)) (fun he => hb (he ▸ hx))
    simpa only [List.map_id] using List.map_congr_left hf
  simp only [List.map_append, List.map_cons, fix u hau hbu, fix v hav hbv,
    transpositionPerm_apply_left, transpositionPerm_apply_right]

/-- 語の交換によって定まる置換は、値の互換との左合成に等しい。 -/
theorem matchingWordPermutation_swap (u : List J) (a b : J) (v : List J)
    (h : IsCompleteWord (u ++ a :: b :: v)) :
    matchingWordPermutation (u ++ b :: a :: v) (completeWord_swap u a b v h) =
      transpositionPerm a b * matchingWordPermutation (u ++ a :: b :: v) h := by
  simpa only [matchingWord_swap_eq_map u a b v h] using
    matchingWordPermutation_map (u ++ a :: b :: v) h (transpositionPerm a b)

/-- 隣接交換の符号反転。本文の六等号を同順に記す。 -/
theorem matchingWordSign_swap (u : List J) (a b : J) (v : List J)
    (h : IsCompleteWord (u ++ a :: b :: v)) :
    matchingWordSign (u ++ b :: a :: v) = - matchingWordSign (u ++ a :: b :: v) := by
  have hab : a ≠ b := by
    have hn := (List.nodup_append.mp h.1).2.1
    exact fun he => (List.nodup_cons.mp hn).1 (List.mem_cons.mpr (Or.inl he))
  calc
    matchingWordSign (u ++ b :: a :: v)
        = sign (fun x y : J => x < y)
            (matchingWordPermutation (u ++ b :: a :: v) (completeWord_swap u a b v h)) :=
          matchingWordSign_eq _ _
    _ = sign (fun x y : J => x < y)
          (transpositionPerm a b * matchingWordPermutation (u ++ a :: b :: v) h) := by
            rw [matchingWordPermutation_swap]
    _ = sign (fun x y : J => x < y) (transpositionPerm a b) *
          sign (fun x y : J => x < y) (matchingWordPermutation (u ++ a :: b :: v) h) :=
            sign_comp _ trichotomous_of_linearOrder _ _
    _ = (-1) * sign (fun x y : J => x < y)
          (matchingWordPermutation (u ++ a :: b :: v) h) := by rw [sign_transposition a b hab]
    _ = - sign (fun x y : J => x < y)
          (matchingWordPermutation (u ++ a :: b :: v) h) := neg_one_mul _
    _ = - matchingWordSign (u ++ a :: b :: v) := by rw [matchingWordSign_eq _ h]

/-- 対の列を端点の列へ連結する。 -/
def matchingPairWord {J : Type*} (l : List (J × J)) : List J :=
  l.flatMap (fun p => [p.1, p.2])

/-- 四回の隣接交換による二対の交換。各中間列の完全列挙条件も渡す。 -/
theorem matchingWordSign_swap_pairs (u : List J) (a b c d : J) (v : List J)
    (h : IsCompleteWord (u ++ a :: b :: c :: d :: v)) :
    matchingWordSign (u ++ c :: d :: a :: b :: v) =
      matchingWordSign (u ++ a :: b :: c :: d :: v) := by
  have h₁ : IsCompleteWord ((u ++ [a]) ++ b :: c :: d :: v) := by simpa using h
  have h₂ := completeWord_swap (u ++ [a]) b c (d :: v) h₁
  have h₂' : IsCompleteWord (u ++ a :: c :: b :: d :: v) := by simpa using h₂
  have h₃ := completeWord_swap u a c (b :: d :: v) h₂'
  have h₃' : IsCompleteWord ((u ++ [c, a]) ++ b :: d :: v) := by simpa using h₃
  have h₄ := completeWord_swap (u ++ [c, a]) b d v h₃'
  have h₄' : IsCompleteWord ((u ++ [c]) ++ a :: d :: b :: v) := by simpa using h₄
  have e₁ := matchingWordSign_swap (u ++ [a]) b c (d :: v) h₁
  have e₂ := matchingWordSign_swap u a c (b :: d :: v) h₂'
  have e₃ := matchingWordSign_swap (u ++ [c, a]) b d v h₃'
  have e₄ := matchingWordSign_swap (u ++ [c]) a d (b :: v) h₄'
  simp only [List.append_assoc, List.cons_append, List.nil_append] at e₁ e₃ e₄
  calc
    matchingWordSign (u ++ c :: d :: a :: b :: v)
        = - matchingWordSign (u ++ c :: a :: d :: b :: v) := e₄
    _ = - (- matchingWordSign (u ++ c :: a :: b :: d :: v)) := congrArg Neg.neg e₃
    _ = matchingWordSign (u ++ c :: a :: b :: d :: v) := neg_neg _
    _ = - matchingWordSign (u ++ a :: c :: b :: d :: v) := e₂
    _ = - (- matchingWordSign (u ++ a :: b :: c :: d :: v)) := congrArg Neg.neg e₁
    _ = matchingWordSign (u ++ a :: b :: c :: d :: v) := neg_neg _

/-- 前置列を残した帰納法なので、尾だけを完全列挙と誤認しない。 -/
theorem matchingWordSign_pair_perm {l r : List (J × J)} (hp : l.Perm r) :
    ∀ u : List J, IsCompleteWord (u ++ matchingPairWord l) →
      matchingWordSign (u ++ matchingPairWord r) =
        matchingWordSign (u ++ matchingPairWord l) := by
  induction hp with
  | nil => intro u h; rfl
  | @cons p l r hp ih =>
      intro u h
      simpa [matchingPairWord, List.append_assoc] using
        ih (u ++ [p.1, p.2]) (by simpa [matchingPairWord, List.append_assoc] using h)
  | swap p q l =>
      intro u h
      simpa [matchingPairWord] using
        matchingWordSign_swap_pairs u q.1 q.2 p.1 p.2 (matchingPairWord l)
          (by simpa [matchingPairWord] using h)
  | @trans l r s hlr hrs ih₁ ih₂ =>
      intro u h
      have hr : IsCompleteWord (u ++ matchingPairWord r) :=
        h.perm ((hlr.flatMap (fun _ _ => List.Perm.refl _)).append_left u)
      exact (ih₂ u hr).trans (ih₁ u h)

/-- マッチングの各二元集合を一意な昇順対へ向ける。 -/
noncomputable def matchingOrientedPairs (D : PerfectMatching J) : Finset (J × J) := by
  classical
  exact Finset.univ.filter (fun p => p.1 < p.2 ∧ ({p.1, p.2} : Set J) ∈ D.val)

/-- 各昇順対をちょうど一度含む列挙。 -/
def IsMatchingEnumeration (D : PerfectMatching J) (l : List (J × J)) : Prop :=
  l.Nodup ∧ ∀ p, p ∈ l ↔ p ∈ matchingOrientedPairs D

/-- 有限集合のリスト化により、実際の列挙を取れる。 -/
noncomputable def matchingCanonicalEnumeration (D : PerfectMatching J) : List (J × J) :=
  (matchingOrientedPairs D).toList

theorem matchingCanonicalEnumeration_spec (D : PerfectMatching J) :
    IsMatchingEnumeration D (matchingCanonicalEnumeration D) := by
  classical
  exact ⟨Finset.nodup_toList _, fun _ => Finset.mem_toList⟩

omit [Fintype J] in
private theorem matching_oriented_pair_eq {p q : J × J}
    (hp : p.1 < p.2) (hq : q.1 < q.2)
    (he : ({p.1, p.2} : Set J) = {q.1, q.2}) : p = q := by
  rcases Set.pair_eq_pair_iff.mp he with h | h
  · exact Prod.ext h.1 h.2
  · have : p.2 < p.1 := by simpa [h.1, h.2] using hq
    exact (hp.asymm this).elim

/-- 対の列挙は条件付きの仮定でなく、すべてのマッチングについて存在する。 -/
theorem matchingEnumeration_exists (D : PerfectMatching J) :
    ∃ l : List (J × J), IsMatchingEnumeration D l :=
  ⟨matchingCanonicalEnumeration D, matchingCanonicalEnumeration_spec D⟩

/-- 一つの点を共有する二つの昇順対は等しい。 -/
theorem matchingOrientedPairs_disjoint (D : PerfectMatching J) {p q : J × J}
    (hp : p ∈ matchingOrientedPairs D) (hq : q ∈ matchingOrientedPairs D)
    {x : J} (hxp : x ∈ [p.1, p.2]) (hxq : x ∈ [q.1, q.2]) : p = q := by
  classical
  have hp' := (Finset.mem_filter.mp hp).2
  have hq' := (Finset.mem_filter.mp hq).2
  obtain ⟨s, hs, hu⟩ := D.property.2 x
  have ep : ({p.1, p.2} : Set J) = s := hu _ ⟨hp'.2, by simpa using hxp⟩
  have eq : ({q.1, q.2} : Set J) = s := hu _ ⟨hq'.2, by simpa using hxq⟩
  exact matching_oriented_pair_eq hp'.1 hq'.1 (ep.trans eq.symm)

/-- マッチングからの列挙を連結すると、全元が重複なしに現れる。 -/
theorem matchingEnumeration_complete (D : PerfectMatching J) (l : List (J × J))
    (hl : IsMatchingEnumeration D l) : IsCompleteWord (matchingPairWord l) := by
  classical
  refine ⟨List.nodup_flatMap.mpr ⟨?_, ?_⟩, ?_⟩
  · intro p hp
    have hlt := (Finset.mem_filter.mp ((hl.2 p).mp hp)).2.1
    simpa using hlt.ne
  · apply hl.1.imp_of_mem
    intro p q hp hq hpq
    apply List.disjoint_left.mpr
    intro x hxp hxq
    exact hpq (matchingOrientedPairs_disjoint D ((hl.2 p).mp hp)
      ((hl.2 q).mp hq) hxp hxq)
  · intro x
    obtain ⟨p, hp, _⟩ := D.property.2 x
    obtain ⟨a, b, hab, rfl⟩ := D.property.1 p hp.1
    rcases lt_or_gt_of_ne hab with hlt | hlt
    · apply List.mem_flatMap.mpr
      refine ⟨(a, b), (hl.2 _).mpr ?_, ?_⟩
      · exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hlt, hp.1⟩
      · simpa using hp.2
    · apply List.mem_flatMap.mpr
      refine ⟨(b, a), (hl.2 _).mpr ?_, ?_⟩
      · exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, hlt, by simpa [Set.pair_comm] using hp.1⟩
      · simpa [or_comm] using hp.2

/-- 二つのマッチング列挙を結ぶ、隣接交換からできた並べ替え。 -/
theorem matchingEnumerations_perm (D : PerfectMatching J) {l r : List (J × J)}
    (hl : IsMatchingEnumeration D l) (hr : IsMatchingEnumeration D r) : l.Perm r :=
  matchingList_perm_of_same_mem hl.1 hr.1 (fun p => (hl.2 p).trans (hr.2 p).symm)

/-- 完全マッチングの符号。 -/
noncomputable def perfectMatchingSign (D : PerfectMatching J) : ℤ :=
  matchingWordSign (matchingPairWord (matchingCanonicalEnumeration D))

/-- 完全マッチングの符号は整数の ±1 に属する。 -/
theorem perfectMatchingSign_eq_one_or_neg_one (D : PerfectMatching J) :
    perfectMatchingSign D = 1 ∨ perfectMatchingSign D = -1 := by
  rw [perfectMatchingSign, matchingWordSign_eq _
    (matchingEnumeration_complete D _ (matchingCanonicalEnumeration_spec D))]
  exact sign_eq_one_or_neg_one _ _

/-- 符号は昇順対の列挙順序に依存しない。 -/
theorem perfectMatchingSign_enumeration_independent (D : PerfectMatching J)
    (l : List (J × J)) (hl : IsMatchingEnumeration D l) :
    matchingWordSign (matchingPairWord l) = perfectMatchingSign D := by
  have hp := matchingEnumerations_perm D (matchingCanonicalEnumeration_spec D) hl
  exact matchingWordSign_pair_perm hp []
    (matchingEnumeration_complete D _ (matchingCanonicalEnumeration_spec D))

/-- 空集合では唯一の置換が恒等置換であり、符号は 1。 -/
theorem perfectMatchingSign_empty [IsEmpty J] (D : PerfectMatching J) :
    perfectMatchingSign D = 1 := by
  have hp : matchingWordPermutation _
      (matchingEnumeration_complete D _ (matchingCanonicalEnumeration_spec D)) =
        (1 : Equiv.Perm J) := Subsingleton.elim _ _
  calc
    perfectMatchingSign D = sign (fun x y : J => x < y) (1 : Equiv.Perm J) := by
      rw [perfectMatchingSign, matchingWordSign_eq _
        (matchingEnumeration_complete D _ (matchingCanonicalEnumeration_spec D)), hp]
    _ = (-1 : ℤ) ^ 0 := by
      apply congrArg (fun k : ℕ => (-1 : ℤ) ^ k)
      simp [inversionCount, orderedPairs]
    _ = 1 := pow_zero _

end Ising2DLambda.AlgebraicEigenvalue
