/-
「横断の平滑化は二本の閉じた非後退辺列に分ける」（`claim_smoothing_splits_closed_walk`）と、
「平滑化後の出辺は非後退接続である」（`def_smoothed_cyclic_total_turning` の冒頭の確認）の
必要十分版。具体版 `Ising2DLambda.KacWard.SmoothedSplitClosedWalks` と同じ手順で、格子・向き付き辺を
取り去る。

- 付け替えた接続の非後退性（`swappedExit_next_necSuf`）に要る仮定:
  後続の条件が「始点が入辺の終点に等しく、入辺の反転でない」であること、反転が方向を `shift` で
  動かすこと（`hrev`）、`shift` が軸を保つこと（`haxis`）、直進の後続は方向を保つこと（`hstraight`）。
  `haxis` か `hstraight` を削ると、付け替えた出辺が入辺の反転である場合を軸の不一致で除けない。
- 区間の閉性（`cyclicSegment_closed_necSuf`）に要る仮定: 元の歩道の各通過が接続であること（`hpass`）と、
  区間の終辺から始辺への接続（`hclose`）だけ。接続の関係 `Next` に何の性質も要らない。
-/
import Ising2DLambda.NecSuf.KacWard.ClosedWalkPasses

namespace Ising2DLambda.NecSuf.KacWard

/-- 剰余で読んだ添字の巡回後続は、一つ先の剰余である。 -/
theorem cyclicSuccessor_mod_necSuf {m : ℕ} (x : ℕ) :
    cyclicSuccessor (⟨x % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) =
      ⟨(x + 1) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ := by
  have hlt : x % (m + 1) < m + 1 := Nat.mod_lt _ (Nat.succ_pos m)
  have hadd : (x + 1) % (m + 1) = (x % (m + 1) + 1) % (m + 1) := by
    rw [Nat.add_comm (x % (m + 1)) 1, Nat.add_mod_mod, Nat.add_comm]
  unfold cyclicSuccessor
  split_ifs with h
  · have h' : x % (m + 1) < m := h
    apply Fin.ext
    change x % (m + 1) + 1 = (x + 1) % (m + 1)
    rw [hadd, Nat.mod_eq_of_lt (show x % (m + 1) + 1 < m + 1 by omega)]
  · have h' : ¬ x % (m + 1) < m := h
    have hm : x % (m + 1) = m := by omega
    apply Fin.ext
    change 0 = (x + 1) % (m + 1)
    rw [hadd, hm, Nat.mod_self]

/-- 巡回列の区間 `(γ_s, γ_{s+1}, …, γ_{s+n})`（添字は剰余で読む）。 -/
def cyclicSegment {E : Type*} {m : ℕ} (γ : Fin (m + 1) → E) (s n : ℕ) : Fin (n + 1) → E :=
  fun j => γ ⟨(s + j.val) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩

/-- 巡回列の区間は、終辺から始辺への接続があれば閉じた接続列である。
内部の接続は元の歩道の通過である。 -/
theorem cyclicSegment_closed_necSuf {E : Type*} {m : ℕ} (Next : E → E → Prop)
    (γ : Fin (m + 1) → E) (hpass : ∀ r, Next (γ r) (γ (cyclicSuccessor r)))
    (s n : ℕ)
    (hclose : Next (γ ⟨(s + n) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩)
      (γ ⟨s % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩)) :
    (∀ j : Fin n, Next (cyclicSegment γ s n j.castSucc) (cyclicSegment γ s n j.succ)) ∧
      Next (cyclicSegment γ s n (Fin.last n)) (cyclicSegment γ s n 0) := by
  refine ⟨fun j => ?_, ?_⟩
  · have h := hpass ⟨(s + j.val) % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩
    rw [cyclicSuccessor_mod_necSuf] at h
    simpa [cyclicSegment, Nat.add_assoc] using h
  · simpa [cyclicSegment] using hclose

/-- 横断する二つの通過で、一方の出辺を他方の入辺に付け替えた接続も後続の条件を満たす。 -/
theorem swappedExit_next_necSuf {E V D A : Type*}
    (src tgt : E → V) (rev : E → E) (dir : E → D) (shift : D → D) (axis : D → A)
    (straight : E → E → Prop)
    (hrev : ∀ e, dir (rev e) = shift (dir e))
    (haxis : ∀ d, axis (shift d) = axis d)
    (hstraight : ∀ e f, src f = tgt e → f ≠ rev e → straight e f → dir f = dir e)
    {e e' f' : E}
    (htgt : tgt e = tgt e') (hsrc' : src f' = tgt e') (hrev' : f' ≠ rev e')
    (hst' : straight e' f') (hax : axis (dir e) ≠ axis (dir e')) :
    src f' = tgt e ∧ f' ≠ rev e := by
  refine ⟨hsrc'.trans htgt.symm, fun hf => hax ?_⟩
  calc axis (dir e) = axis (shift (dir e)) := (haxis _).symm
    _ = axis (dir (rev e)) := by rw [hrev]
    _ = axis (dir f') := by rw [hf]
    _ = axis (dir e') := by rw [hstraight e' f' hsrc' hrev' hst']

/-- 平滑化で分かれる二つの区間 `(k+1, …, l)` と `(l+1, …, m, 0, …, k)` は、付け替えた二つの接続
`γ_k → γ_{σ(l)}`・`γ_l → γ_{σ(k)}` があれば、どちらも閉じた接続列である。 -/
theorem smoothedSplitSegments_closed_necSuf {E : Type*} {m : ℕ} (Next : E → E → Prop)
    (γ : Fin (m + 1) → E) (hpass : ∀ r, Next (γ r) (γ (cyclicSuccessor r)))
    {k l : Fin (m + 1)} (hkl : k < l)
    (hk : Next (γ k) (γ (cyclicSuccessor l))) (hl : Next (γ l) (γ (cyclicSuccessor k))) :
    ((∀ j : Fin (l.val - k.val - 1),
        Next (cyclicSegment γ (k.val + 1) (l.val - k.val - 1) j.castSucc)
          (cyclicSegment γ (k.val + 1) (l.val - k.val - 1) j.succ)) ∧
      Next (cyclicSegment γ (k.val + 1) (l.val - k.val - 1) (Fin.last _))
        (cyclicSegment γ (k.val + 1) (l.val - k.val - 1) 0)) ∧
    ((∀ j : Fin (m - l.val + k.val),
        Next (cyclicSegment γ (l.val + 1) (m - l.val + k.val) j.castSucc)
          (cyclicSegment γ (l.val + 1) (m - l.val + k.val) j.succ)) ∧
      Next (cyclicSegment γ (l.val + 1) (m - l.val + k.val) (Fin.last _))
        (cyclicSegment γ (l.val + 1) (m - l.val + k.val) 0)) := by
  have hk' : k.val < l.val := hkl
  have hl' := l.isLt
  have hkfix : (⟨k.val % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = k :=
    Fin.ext (Nat.mod_eq_of_lt k.isLt)
  have hlfix : (⟨l.val % (m + 1), Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = l :=
    Fin.ext (Nat.mod_eq_of_lt l.isLt)
  have hsk := cyclicSuccessor_mod_necSuf (m := m) k.val
  have hsl := cyclicSuccessor_mod_necSuf (m := m) l.val
  rw [hkfix] at hsk
  rw [hlfix] at hsl
  constructor
  · apply cyclicSegment_closed_necSuf Next γ hpass
    have hlast : (⟨(k.val + 1 + (l.val - k.val - 1)) % (m + 1),
        Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = l := by
      apply Fin.ext
      change (k.val + 1 + (l.val - k.val - 1)) % (m + 1) = l.val
      rw [show k.val + 1 + (l.val - k.val - 1) = l.val by omega]
      exact Nat.mod_eq_of_lt l.isLt
    rw [hlast, ← hsk]
    exact hl
  · apply cyclicSegment_closed_necSuf Next γ hpass
    have hlast : (⟨(l.val + 1 + (m - l.val + k.val)) % (m + 1),
        Nat.mod_lt _ (Nat.succ_pos m)⟩ : Fin (m + 1)) = k := by
      apply Fin.ext
      change (l.val + 1 + (m - l.val + k.val)) % (m + 1) = k.val
      rw [show l.val + 1 + (m - l.val + k.val) = (m + 1) + k.val by omega, Nat.add_mod_left]
      exact Nat.mod_eq_of_lt k.isLt
    rw [hlast, ← hsl]
    exact hk

end Ising2DLambda.NecSuf.KacWard
