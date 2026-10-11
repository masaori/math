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

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

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
