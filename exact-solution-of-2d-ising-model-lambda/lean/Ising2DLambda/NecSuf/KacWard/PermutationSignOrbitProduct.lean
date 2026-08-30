/-
主張「置換符号は動く軌道の符号因子の積である」（`claim_permutation_sign_moved_orbit_product`）の
Lean 配線の部品（必要十分版の側）。

一つめは人手証明の段「各互換の符号は `-1`」に対応する（`sign_transposition`）。
二つめは「符号の乗法性を軌道の有限族へ繰り返し適用すると」に対応する（`sign_noncommProd`）。
互いに可換な置換の有限族の合成の符号は、各置換の符号の積である。
証明は有限集合についての帰納法で、`sign_one`（恒等置換の符号は 1）と
`sign_comp`（符号の乗法性）だけを繰り返し適用する。人手証明が「繰り返し適用」と
書いた繰り返しを、そのまま帰納法として書いたものである。

三つめは人手証明の段「`φ_C` は `(e_C φ^{m_C-1}(e_C)) ∘ ⋯ ∘ (e_C φ(e_C))` という
`m_C - 1` 個の互換の合成に等しい。…この巡回置換の符号は `(-1)^{m_C-1}` である」に対応する
（`transpositionChain` と、その作用を確定する三つの定理、符号 `sign_transpositionChain`）。
相異なる元の列 `a, l[0], …, l[k-1]` について、互換の鎖
`(a l[k-1]) ∘ ⋯ ∘ (a l[0])` が `a → l[0] → ⋯ → l[k-1] → a` と巡回し、
列の外を動かさないことを、リストについての帰納法で示す。
符号は `sign_comp` と `sign_transposition` を鎖の長さだけ繰り返して `(-1)^k` になる。

  使っている性質                     なぜ削れないか
  `Fintype α`・`DecidableRel lt`     符号（転倒数）の定義に要る（`PermutationSign.lean` と同じ）。
  三分律 `htri`                      `sign_one` と `sign_comp` が要求する。
  族の可換性 `comm`                  合成を `Finset.noncommProd` として書き下すのに要る。
                                     族の並べ順を選んで合成する書き方では、どの順序を
                                     選んだかが人手証明に無い情報として入るので、
                                     可換性を仮定して順序へ依存しない合成を使う。
  列の相異性（`Nodup`・`a ∉ l`）      人手証明の「右辺の向き付き辺は相異なり」に対応する。
                                     重複があると互換の鎖は巡回しない（`(a a)` は定義できず、
                                     同じ点を二度通る鎖は途中で巡回が壊れる）。

台が軌道であること・置換どうしの台が互いに素であることは使っていない（可換性だけ使う）。
互いに素な台を持つ置換が可換であることは、この先の具体版の側で示す。

住処: ここに ℝ / ℂ は現れない（符号は ℤ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitTranspositionSign
import Mathlib.Data.Finset.NoncommProd

namespace Ising2DLambda.NecSuf.KacWard

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {α : Type*} [Fintype α] (lt : α → α → Prop) [DecidableRel lt]

omit [Fintype α] in
/-- 人手証明の全体集合上の互換。二回適用すると恒等写像へ戻る。 -/
def transpositionPerm [DecidableEq α] (a b : α) : Equiv.Perm α where
  toFun := transpositionOn a b
  invFun := transpositionOn a b
  left_inv := transpositionOn_involutive a b
  right_inv := transpositionOn_involutive a b

/-- 有限線型順序集合の相異なる二点の互換の符号は `-1` である。
人手証明の転倒対の分割を一般の有限台で行った `signOn_transposition` を、全体集合へ適用する。 -/
theorem sign_transposition [LinearOrder α] (a b : α) (hab : a ≠ b) :
    sign (fun x y : α => x < y) (transpositionPerm a b) = -1 := by
  classical
  have sign_eq_signOn (x y : α) :
      sign (fun u v : α => u < v) (transpositionPerm x y) =
        signOn (fun u v : α => u < v)
          (orderedPairsOn (fun u v : α => u < v) Finset.univ) (transpositionOn x y) := by
    rfl
  rcases lt_or_gt_of_ne hab with hablt | hbalt
  · rw [sign_eq_signOn]
    exact signOn_transposition (fun x y : α => x < y) (fun _ _ => LT.lt.asymm)
      (fun _ _ _ => LT.lt.trans) (Finset.mem_univ a) (Finset.mem_univ b) hablt
  · have hswap : transpositionPerm a b = transpositionPerm b a := by
      ext x
      simp only [transpositionPerm, transpositionOn, Equiv.coe_fn_mk]
      by_cases hxa : x = a <;> by_cases hxb : x = b <;> simp [hxa, hxb, hab]
    rw [hswap, sign_eq_signOn]
    exact signOn_transposition (fun x y : α => x < y) (fun _ _ => LT.lt.asymm)
      (fun _ _ _ => LT.lt.trans) (Finset.mem_univ b) (Finset.mem_univ a) hbalt

/-- 互いに可換な置換の有限族の合成の符号は、各置換の符号の積である。
人手証明の「符号の乗法性を軌道の有限族へ繰り返し適用する」に対応する。 -/
theorem sign_noncommProd (htri : Trichotomous lt) {β : Type*}
    (s : Finset β) (f : β → Equiv.Perm α)
    (comm : (s : Set β).Pairwise fun b c => Commute (f b) (f c)) :
    sign lt (s.noncommProd f comm) = ∏ b ∈ s, sign lt (f b) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    -- 空の族の合成は恒等置換で、符号は 1（`sign_one`）。空の積も 1。
    simp [Finset.noncommProd_empty, sign_one lt htri]
  | insert a t ha ih =>
    -- 1 元ずつ族へ足す。足した元との合成へ `sign_comp` を 1 回適用する。
    rw [Finset.noncommProd_insert_of_notMem t a f _ ha, sign_comp lt htri,
      Finset.prod_insert ha, ih (comm.mono (Finset.subset_insert a t))]

omit [Fintype α] in
/-- 互換の左の点の行き先。`t_{a,b}(a) = b`。 -/
theorem transpositionPerm_apply_left [DecidableEq α] (a b : α) :
    transpositionPerm a b a = b := by
  simp [transpositionPerm, transpositionOn]

omit [Fintype α] in
/-- 互換の右の点の行き先。`t_{a,b}(b) = a`。 -/
theorem transpositionPerm_apply_right [DecidableEq α] (a b : α) :
    transpositionPerm a b b = a := by
  by_cases hba : b = a
  · simp [transpositionPerm, transpositionOn, hba]
  · simp [transpositionPerm, transpositionOn, hba]

omit [Fintype α] in
/-- 互換は二点以外を動かさない。 -/
theorem transpositionPerm_apply_of_ne [DecidableEq α] (a b : α) {x : α}
    (hxa : x ≠ a) (hxb : x ≠ b) : transpositionPerm a b x = x := by
  simp [transpositionPerm, transpositionOn, hxa, hxb]

omit [Fintype α] in
/-- 人手証明の互換の鎖。リスト `l = [c₁, …, c_k]` に対して
`(a c_k) ∘ ⋯ ∘ (a c₂) ∘ (a c₁)` を返す（空リストでは恒等置換）。
人手証明の「`φ_C` は `m_C - 1` 個の互換の合成に等しい」の右辺である。 -/
def transpositionChain [DecidableEq α] (a : α) : List α → Equiv.Perm α
  | [] => 1
  | b :: l => transpositionChain a l * transpositionPerm a b

omit [Fintype α] in
/-- 互換の鎖は `a` にもリストにも属さない点を動かさない。
人手証明の「軌道外では恒等写像」に対応する。 -/
theorem transpositionChain_apply_of_notMem [DecidableEq α] (a : α) (l : List α) {x : α}
    (hxa : x ≠ a) (hxl : x ∉ l) : transpositionChain a l x = x := by
  induction l with
  | nil => rfl
  | cons b t ih =>
    rw [List.mem_cons, not_or] at hxl
    obtain ⟨hxb, hxt⟩ := hxl
    show (transpositionChain a t * transpositionPerm a b) x = x
    rw [Equiv.Perm.mul_apply, transpositionPerm_apply_of_ne a b hxa hxb]
    exact ih hxt

omit [Fintype α] in
/-- 互換の鎖は先頭の点 `a` をリストの最初の元へ送る（リストが空なら `a` のまま）。
人手証明の巡回 `e_C → φ(e_C)` に対応する。 -/
theorem transpositionChain_apply_head [DecidableEq α] (a : α) (l : List α)
    (hnd : (a :: l).Nodup) : transpositionChain a l a = l.headD a := by
  cases l with
  | nil => rfl
  | cons b t =>
    rw [List.nodup_cons, List.mem_cons, not_or] at hnd
    obtain ⟨⟨hab, hat⟩, hnd'⟩ := hnd
    have hbt : b ∉ t := (List.nodup_cons.mp hnd').1
    show (transpositionChain a t * transpositionPerm a b) a = b
    rw [Equiv.Perm.mul_apply, transpositionPerm_apply_left]
    exact transpositionChain_apply_of_notMem a t (fun h => hab h.symm) hbt

omit [Fintype α] in
/-- 互換の鎖はリストの各元をその次の元へ送る。
人手証明の巡回 `φ^{∘i}(e_C) → φ^{∘(i+1)}(e_C)` に対応する。 -/
theorem transpositionChain_apply_getElem [DecidableEq α] (a : α) (l : List α)
    (hnd : (a :: l).Nodup) {i : ℕ} (hi : i + 1 < l.length) :
    transpositionChain a l (l[i]'(Nat.lt_of_succ_lt hi)) = l[i + 1]'hi := by
  induction l generalizing i with
  | nil => simp at hi
  | cons b t ih =>
    rw [List.nodup_cons, List.mem_cons, not_or] at hnd
    obtain ⟨⟨hab, hat⟩, hnd'⟩ := hnd
    have hbt : b ∉ t := (List.nodup_cons.mp hnd').1
    have hndat : (a :: t).Nodup := List.nodup_cons.mpr ⟨hat, (List.nodup_cons.mp hnd').2⟩
    cases i with
    | zero =>
      have ht : 0 < t.length := by simpa using hi
      simp only [List.getElem_cons_zero, List.getElem_cons_succ]
      show (transpositionChain a t * transpositionPerm a b) b = t[0]'ht
      rw [Equiv.Perm.mul_apply, transpositionPerm_apply_right,
        transpositionChain_apply_head a t hndat]
      cases t with
      | nil => simp at ht
      | cons c u => rfl
    | succ j =>
      have hj : j + 1 < t.length := by simpa using hi
      simp only [List.getElem_cons_succ]
      show (transpositionChain a t * transpositionPerm a b)
        (t[j]'(Nat.lt_of_succ_lt hj)) = t[j + 1]'hj
      have htja : t[j]'(Nat.lt_of_succ_lt hj) ≠ a := fun h => hat (h ▸ List.getElem_mem _)
      have htjb : t[j]'(Nat.lt_of_succ_lt hj) ≠ b := fun h => hbt (h ▸ List.getElem_mem _)
      rw [Equiv.Perm.mul_apply, transpositionPerm_apply_of_ne a b htja htjb]
      exact ih hndat hj

omit [Fintype α] in
/-- 互換の鎖はリストの最後の元を先頭の点 `a` へ送る。
人手証明の巡回 `φ^{∘(m_C-1)}(e_C) → e_C` に対応する。 -/
theorem transpositionChain_apply_getLast [DecidableEq α] (a : α) (l : List α)
    (hnd : (a :: l).Nodup) (hne : l ≠ []) :
    transpositionChain a l (l.getLast hne) = a := by
  induction l with
  | nil => exact absurd rfl hne
  | cons b t ih =>
    rw [List.nodup_cons, List.mem_cons, not_or] at hnd
    obtain ⟨⟨hab, hat⟩, hnd'⟩ := hnd
    have hbt : b ∉ t := (List.nodup_cons.mp hnd').1
    have hndat : (a :: t).Nodup := List.nodup_cons.mpr ⟨hat, (List.nodup_cons.mp hnd').2⟩
    cases t with
    | nil =>
      show (transpositionChain a [] * transpositionPerm a b) b = a
      rw [Equiv.Perm.mul_apply, transpositionPerm_apply_right]
      rfl
    | cons c u =>
      have htne : (c :: u : List α) ≠ [] := by simp
      rw [List.getLast_cons htne]
      have hlast_mem : (c :: u).getLast htne ∈ c :: u := List.getLast_mem htne
      have hxa : (c :: u).getLast htne ≠ a := fun h => hat (h ▸ hlast_mem)
      have hxb : (c :: u).getLast htne ≠ b := fun h => hbt (h ▸ hlast_mem)
      show (transpositionChain a (c :: u) * transpositionPerm a b) ((c :: u).getLast htne) = a
      rw [Equiv.Perm.mul_apply, transpositionPerm_apply_of_ne a b hxa hxb]
      exact ih hndat htne

omit [Fintype α] in
/-- 線型順序の狭義順序は三分律を満たす。`sign_one` と `sign_comp` へ渡すための橋である。 -/
theorem trichotomous_of_linearOrder [LinearOrder α] :
    Trichotomous (fun x y : α => x < y) := by
  intro a b
  rcases lt_trichotomy a b with h | h | h
  · exact Or.inl ⟨h, ne_of_lt h, h.asymm⟩
  · subst h
    exact Or.inr (Or.inl ⟨lt_irrefl a, rfl, lt_irrefl a⟩)
  · exact Or.inr (Or.inr ⟨h.asymm, (ne_of_lt h).symm, h⟩)

/-- 互換の鎖の符号は `(-1)` のリストの長さ乗である。
人手証明の「各互換の符号は `-1` であり、符号は合成を積へ送るから、
この巡回置換の符号は `(-1)^{m_C-1}` である」に対応する。
`sign_comp` と `sign_transposition` を鎖の長さだけ繰り返し適用する。 -/
theorem sign_transpositionChain [LinearOrder α] (a : α) (l : List α) (hal : a ∉ l) :
    sign (fun x y : α => x < y) (transpositionChain a l) = (-1) ^ l.length := by
  induction l with
  | nil =>
    show sign (fun x y : α => x < y) (1 : Equiv.Perm α) = (-1) ^ (0 : ℕ)
    rw [sign_one (fun x y : α => x < y) trichotomous_of_linearOrder, pow_zero]
  | cons b t ih =>
    rw [List.mem_cons, not_or] at hal
    obtain ⟨hab, hat⟩ := hal
    show sign (fun x y : α => x < y) (transpositionChain a t * transpositionPerm a b)
      = (-1) ^ (b :: t).length
    rw [sign_comp (fun x y : α => x < y) trichotomous_of_linearOrder,
      sign_transposition a b hab, ih hat, List.length_cons, pow_succ]

end Ising2DLambda.NecSuf.KacWard
