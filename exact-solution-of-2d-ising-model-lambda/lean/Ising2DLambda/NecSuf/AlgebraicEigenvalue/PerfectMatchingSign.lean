/-
完全マッチングの列挙順序独立性の必要十分版。
本文の四交換と前置列を残す帰納法をそのまま残す。各交換の入力は完全列挙であり、
同一要素の交換へ反転則を適用しない。順序・有限型・マッチング・整数の演算は使わず、
列の値を反転する写像が対合であることと、完全列挙での隣接交換則だけを使う。
hswap は四つの交換の等号、hflip は二重反転の除去に必要である。
完全列挙条件は要素の相異性と交換則の適用条件を各段で保つ。
これらの仮定は具体的な転倒符号から FromNecSuf で満たす。
-/
import Mathlib.Data.List.Nodup
import Mathlib.Data.List.Perm.Basic
import Mathlib.Data.List.NodupEquivFin
import Mathlib.GroupTheory.Perm.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 全元をちょうど一度ずつ記す有限列。 -/
def IsCompleteWord {J : Type*} (w : List J) : Prop :=
  w.Nodup ∧ ∀ x : J, x ∈ w

private theorem completeWord_move_front {J : Type*} (u : List J) (a : J) (v : List J) :
    (u ++ a :: v).Perm (a :: (u ++ v)) := by
  induction u with
  | nil => exact List.Perm.refl _
  | cons b u ih => exact (ih.cons b).trans (List.Perm.swap a b (u ++ v))

/-- 同じ元を重複なく記した二列を、先頭を合わせて並べ替える。 -/
private theorem completeWord_perm {J : Type*} {l r : List J}
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
      have hp := completeWord_move_front u a v
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

/-- 基準列と完全列の長さは等しい。 -/
theorem completeWord_length {J : Type*} (base w : List J)
    (hb : IsCompleteWord base) (hw : IsCompleteWord w) : base.length = w.length :=
  (completeWord_perm hb.1 hw.1 (fun x => iff_of_true (hb.2 x) (hw.2 x))).length_eq

/-- 基準列の各元を完全列の対応する元へ送る置換。 -/
noncomputable def completeWordPermutation {J : Type*} (base w : List J)
    (hb : IsCompleteWord base) (hw : IsCompleteWord w) : Equiv.Perm J := by
  classical
  exact
    (List.Nodup.getEquivOfForallMemList base hb.1 hb.2).symm |>.trans
      ((finCongr (completeWord_length base w hb hw)).trans
        (List.Nodup.getEquivOfForallMemList w hw.1 hw.2))

/-- 完全列を元ごとに置換しても完全列である。 -/
theorem completeWord_map {J : Type*} (w : List J)
    (hw : IsCompleteWord w) (p : Equiv.Perm J) : IsCompleteWord (w.map p) := by
  refine ⟨hw.1.map p.injective, ?_⟩
  intro x
  exact List.mem_map.mpr ⟨p.symm x, hw.2 _, p.apply_symm_apply x⟩

/-- 元ごとの置換は、完全列が定める置換との左合成である。
必要なのは基準列と対象列の完全性、および作用する写像の全単射性だけである。 -/
theorem completeWordPermutation_map {J : Type*} (base w : List J)
    (hb : IsCompleteWord base) (hw : IsCompleteWord w) (p : Equiv.Perm J) :
    completeWordPermutation base (w.map p) hb (completeWord_map w hw p) =
      p * completeWordPermutation base w hb hw := by
  classical
  ext x
  obtain ⟨k, hk⟩ := List.mem_iff_get.mp (hb.2 x)
  rw [← hk]
  change completeWordPermutation base (w.map p) hb (completeWord_map w hw p)
      (base.get k) = p (completeWordPermutation base w hb hw (base.get k))
  have happly (v : List J) (hv : IsCompleteWord v) :
      completeWordPermutation base v hb hv (base.get k) =
        v.get (finCongr (completeWord_length base v hb hv) k) := by
    simp [completeWordPermutation, List.Nodup.getEquivOfForallMemList, finCongr, hb.1]
  calc
    completeWordPermutation base (w.map p) hb (completeWord_map w hw p) (base.get k)
        = (w.map p).get
            (finCongr (completeWord_length base _ hb (completeWord_map w hw p)) k) :=
          happly _ _
    _ = p (w.get (finCongr (completeWord_length base w hb hw) k)) := by
      simp [List.get_eq_getElem, finCongr]
    _ = p (completeWordPermutation base w hb hw (base.get k)) := by
      rw [happly]

/-- 並べ替えは完全列挙を保つ。 -/
theorem IsCompleteWord.perm {J : Type*} {w v : List J}
    (h : IsCompleteWord w) (hp : w.Perm v) : IsCompleteWord v :=
  ⟨hp.nodup_iff.mp h.1, fun x => hp.mem_iff.mp (h.2 x)⟩

/-- 隣接交換による完全列挙の保存。 -/
theorem completeWord_swap {J : Type*} (u : List J) (a b : J) (v : List J)
    (h : IsCompleteWord (u ++ a :: b :: v)) :
    IsCompleteWord (u ++ b :: a :: v) :=
  h.perm ((List.Perm.swap b a v).append_left u)


variable {J B : Type*}

/-- 対の列を端点の列へ連結する。 -/
def matchingPairWord {J : Type*} (l : List (J × J)) : List J :=
  l.flatMap (fun p => [p.1, p.2])

/-- 四回の隣接交換による二対の交換。各中間列の完全列挙条件も渡す。 -/
theorem matchingWord_value_swap_pairs (F : List J → B) (flip : B → B)
    (hflip : Function.Involutive flip)
    (hswap : ∀ (u : List J) (a b : J) (v : List J),
      IsCompleteWord (u ++ a :: b :: v) →
      F (u ++ b :: a :: v) = flip (F (u ++ a :: b :: v)))
    (u : List J) (a b c d : J) (v : List J)
    (h : IsCompleteWord (u ++ a :: b :: c :: d :: v)) :
    F (u ++ c :: d :: a :: b :: v) =
      F (u ++ a :: b :: c :: d :: v) := by
  have h₁ : IsCompleteWord ((u ++ [a]) ++ b :: c :: d :: v) := by simpa using h
  have h₂ := completeWord_swap (u ++ [a]) b c (d :: v) h₁
  have h₂' : IsCompleteWord (u ++ a :: c :: b :: d :: v) := by simpa using h₂
  have h₃ := completeWord_swap u a c (b :: d :: v) h₂'
  have h₃' : IsCompleteWord ((u ++ [c, a]) ++ b :: d :: v) := by simpa using h₃
  have h₄ := completeWord_swap (u ++ [c, a]) b d v h₃'
  have h₄' : IsCompleteWord ((u ++ [c]) ++ a :: d :: b :: v) := by simpa using h₄
  have e₁ := hswap (u ++ [a]) b c (d :: v) h₁
  have e₂ := hswap u a c (b :: d :: v) h₂'
  have e₃ := hswap (u ++ [c, a]) b d v h₃'
  have e₄ := hswap (u ++ [c]) a d (b :: v) h₄'
  simp only [List.append_assoc, List.cons_append, List.nil_append] at e₁ e₃ e₄
  calc
    F (u ++ c :: d :: a :: b :: v)
        = flip (F (u ++ c :: a :: d :: b :: v)) := e₄
    _ = flip (flip (F (u ++ c :: a :: b :: d :: v))) := congrArg flip e₃
    _ = F (u ++ c :: a :: b :: d :: v) := hflip _
    _ = flip (F (u ++ a :: c :: b :: d :: v)) := e₂
    _ = flip (flip (F (u ++ a :: b :: c :: d :: v))) := congrArg flip e₁
    _ = F (u ++ a :: b :: c :: d :: v) := hflip _

/-- 前置列を残した帰納法なので、尾だけを完全列挙と誤認しない。 -/
theorem matchingWord_value_pair_perm (F : List J → B) (flip : B → B)
    (hflip : Function.Involutive flip)
    (hswap : ∀ (u : List J) (a b : J) (v : List J),
      IsCompleteWord (u ++ a :: b :: v) →
      F (u ++ b :: a :: v) = flip (F (u ++ a :: b :: v)))
    {l r : List (J × J)} (hp : l.Perm r) :
    ∀ u : List J, IsCompleteWord (u ++ matchingPairWord l) →
      F (u ++ matchingPairWord r) =
        F (u ++ matchingPairWord l) := by
  induction hp with
  | nil => intro u h; rfl
  | @cons p l r hp ih =>
      intro u h
      simpa [matchingPairWord, List.append_assoc] using
        ih (u ++ [p.1, p.2]) (by simpa [matchingPairWord, List.append_assoc] using h)
  | swap p q l =>
      intro u h
      simpa [matchingPairWord] using
        matchingWord_value_swap_pairs F flip hflip hswap u q.1 q.2 p.1 p.2 (matchingPairWord l)
          (by simpa [matchingPairWord] using h)
  | @trans l r s hlr hrs ih₁ ih₂ =>
      intro u h
      have hr : IsCompleteWord (u ++ matchingPairWord r) :=
        h.perm ((hlr.flatMap (fun _ _ => List.Perm.refl _)).append_left u)
      exact (ih₂ u hr).trans (ih₁ u h)


end Ising2DLambda.NecSuf.AlgebraicEigenvalue
