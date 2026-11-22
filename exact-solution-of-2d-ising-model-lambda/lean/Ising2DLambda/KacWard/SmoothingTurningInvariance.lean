/-
「横断の平滑化は循環総回転数を保つ」の具体版。
人手証明と同じく、横断の直進性（旧二項は 0）、接続の組み替えの回転差
（新二項の和は 4 の整除域 {-4,0,4} に入る）、一歩の回転数の値域 {0,1,-1}
から新二項の和が 0 になることを出し、二点更新の有限和保存で閉じる。
組み替えの回転差は方向番号のデータを持たない通過モデルでは導けないので、
`claim_reconnection_turning_difference` の帰結を仮定 `hrec` として受け取る。
-/
import Ising2DLambda.KacWard.TransverseCrossing
import Ising2DLambda.KacWard.Turn
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Abel

namespace Ising2DLambda.KacWard

open scoped BigOperators

/-- 本文の最後の式変形: 添字 `a`・`b` 以外の項が一致し、二項の和が一致するなら、
`Fin m` 上の整数値の有限和は一致する（有限和から二項を分け、残りの項を一つずつ置き換える）。 -/
theorem two_point_preserved_sum {m : ℕ} (f g : Fin m → ℤ) (a b : Fin m) (hab : a ≠ b)
    (hpair : g a + g b = f a + f b)
    (hother : ∀ r, r ≠ a → r ≠ b → g r = f r) :
    ∑ r : Fin m, g r = ∑ r : Fin m, f r := by
  have hbmem : b ∈ Finset.univ.erase a :=
    Finset.mem_erase.mpr ⟨Ne.symm hab, Finset.mem_univ b⟩
  -- 和を「二点以外」「b の項」「a の項」へ分ける
  have h1f : ((Finset.univ.erase a).erase b).sum f + f b = (Finset.univ.erase a).sum f :=
    Finset.sum_erase_add _ f hbmem
  have h2f : (Finset.univ.erase a).sum f + f a = Finset.univ.sum f :=
    Finset.sum_erase_add _ f (Finset.mem_univ a)
  have h1g : ((Finset.univ.erase a).erase b).sum g + g b = (Finset.univ.erase a).sum g :=
    Finset.sum_erase_add _ g hbmem
  have h2g : (Finset.univ.erase a).sum g + g a = Finset.univ.sum g :=
    Finset.sum_erase_add _ g (Finset.mem_univ a)
  -- 二点以外の項は一致する
  have hrest : ((Finset.univ.erase a).erase b).sum g =
      ((Finset.univ.erase a).erase b).sum f := by
    apply Finset.sum_congr rfl
    intro r hr
    exact hother r (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hr))
      (Finset.ne_of_mem_erase hr)
  have hg : ∑ r : Fin m, g r = ((Finset.univ.erase a).erase b).sum g + (g a + g b) := by
    rw [← h2g, ← h1g]; abel
  have hf : ∑ r : Fin m, f r = ((Finset.univ.erase a).erase b).sum f + (f a + f b) := by
    rw [← h2f, ← h1f]; abel
  rw [hg, hf, hrest, hpair]

/-- 横断の平滑化は一歩の回転数の総和（循環総回転数）を変えない。
`visit` が平滑化前、`visit'` が平滑化後の通過族、`a`・`b` が横断する二添字。 -/
theorem smoothing_cyclic_turning_invariance {m : ℕ}
    (visit visit' : Fin m → LocalVisit) (a b : Fin m) (hab : a ≠ b)
    (ha0 : (visit a).turn = .straight) (hb0 : (visit b).turn = .straight)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (hrec : (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = -4
        ∨ (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = 0
        ∨ (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = 4) :
    ∑ r : Fin m, turnValue (visit' r).turn = ∑ r : Fin m, turnValue (visit r).turn := by
  -- 第一の準備: 横断の直進性により旧二項は 0
  have hva : turnValue (visit a).turn = 0 := by rw [ha0]; rfl
  have hvb : turnValue (visit b).turn = 0 := by rw [hb0]; rfl
  -- 一歩の回転数の値域は {0, 1, -1}
  have hra : turnValue (visit' a).turn = 0 ∨ turnValue (visit' a).turn = 1 ∨
      turnValue (visit' a).turn = -1 := by
    cases h : (visit' a).turn <;> simp [turnValue]
  have hrb : turnValue (visit' b).turn = 0 ∨ turnValue (visit' b).turn = 1 ∨
      turnValue (visit' b).turn = -1 := by
    cases h : (visit' b).turn <;> simp [turnValue]
  -- 第二の準備: 新二項の和は 0（4 の整除域と値域の交わり）
  have hpair : turnValue (visit' a).turn + turnValue (visit' b).turn
      = turnValue (visit a).turn + turnValue (visit b).turn := by
    omega
  -- 二点更新の有限和保存
  exact two_point_preserved_sum
    (fun r => turnValue (visit r).turn) (fun r => turnValue (visit' r).turn)
    a b hab hpair (fun r hra' hrb' => by rw [hother r hra' hrb'])

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_cyclic_turning_invariance_from_necSuf {m : ℕ}
    (visit visit' : Fin m → LocalVisit) (a b : Fin m) (hab : a ≠ b)
    (ha0 : (visit a).turn = .straight) (hb0 : (visit b).turn = .straight)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (hrec : (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = -4
        ∨ (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = 0
        ∨ (turnValue (visit a).turn + turnValue (visit b).turn)
          - (turnValue (visit' a).turn + turnValue (visit' b).turn) = 4) :
    ∑ r : Fin m, turnValue (visit' r).turn = ∑ r : Fin m, turnValue (visit r).turn :=
  smoothing_cyclic_turning_invariance visit visit' a b hab ha0 hb0 hother hrec

end Ising2DLambda.KacWard
