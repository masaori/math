import Ising2DLambda.KacWard.PlaneDualRayHeight
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

set_option maxHeartbeats 2000000

/-- 本文の一行目: 列座標が全ての辺より小さい上界 `M` を取れば、高さは列 `c<j≤M` の縦辺の指示値の有限和である。 -/
private theorem planeDualRayHeight_eq_columnSum (edges : Finset GridEdge) (r c M : ℤ)
    (hM : ∀ x ∈ edges, x.2.2 < M) :
    planeDualRayHeight edges r c =
      ∑ j ∈ Finset.Ioc c M, if (true, (r, j)) ∈ edges then (1 : ZMod 2) else 0 := by
  have hindicator (j : ℤ) :
      (if (true, (r, j)) ∈ edges then (1 : ZMod 2) else 0) =
        ∑ e ∈ edges, if e = (true, (r, j)) then (1 : ZMod 2) else 0 := by
    rw [Finset.sum_ite_eq']
  simp_rw [hindicator]
  rw [Finset.sum_comm]
  unfold planeDualRayHeight
  apply Finset.sum_congr rfl
  intro e he
  have hlt := hM e he
  rcases e with ⟨b, ⟨s, d⟩⟩
  have hcongr : ∀ j ∈ Finset.Ioc c M,
      (if ((b, (s, d)) : GridEdge) = (true, (r, j)) then (1 : ZMod 2) else 0) =
        if d = j then (if b = true ∧ s = r then 1 else 0) else 0 := by
    intro j _
    by_cases hd : d = j
    · subst hd
      by_cases hbs : b = true ∧ s = r
      · obtain ⟨rfl, rfl⟩ := hbs
        simp
      · simp only [if_true, if_neg hbs]
        rw [if_neg]
        rintro h
        exact hbs ⟨(Prod.mk.inj h).1, (Prod.mk.inj (Prod.mk.inj h).2).1⟩
    · rw [if_neg hd, if_neg]
      rintro h
      exact hd (Prod.mk.inj (Prod.mk.inj h).2).2
  rw [Finset.sum_congr rfl hcongr, Finset.sum_ite_eq]
  simp only [Finset.mem_Ioc]
  by_cases hcd : c < d
  · simp [hcd, le_of_lt hlt]
  · simp [hcd]

/-- 本文の三行目: 隣り合う二項の和を足すと、中間の項は二度現れて二を法として消える。 -/
private theorem adjacent_pair_sum_telescope (f : ℤ → ZMod 2) (c : ℤ) :
    ∀ n : ℕ, ∑ j ∈ Finset.Ioc c (c + n), (f j + f (j - 1)) = f c + f (c + n) := by
  have htwo : ∀ x : ZMod 2, x + x = 0 := by decide
  intro n
  induction n with
  | zero => simp [htwo]
  | succ n ih =>
      have hset : Finset.Ioc c (c + ((n + 1 : ℕ) : ℤ)) =
          insert (c + n + 1) (Finset.Ioc c (c + n)) := by
        ext x
        simp only [Finset.mem_Ioc, Finset.mem_insert]
        push_cast
        omega
      have hnot : c + n + 1 ∉ Finset.Ioc c (c + n) := by
        simp only [Finset.mem_Ioc]
        omega
      rw [hset, Finset.sum_insert hnot, ih]
      have hprev : c + (n : ℤ) + 1 - 1 = c + n := by ring
      have hlast : c + ((n + 1 : ℕ) : ℤ) = c + n + 1 := by push_cast; ring
      rw [hprev, hlast]
      calc
        f (c + n + 1) + f (c + n) + (f c + f (c + n))
            = f c + f (c + n + 1) + (f (c + n) + f (c + n)) := by ring
        _ = f c + f (c + n + 1) := by rw [htwo, add_zero]

/-- 上下に隣り合う二セルの高さの和は、共有横辺の所属指示値に二を法として等しい
（本文 `claim_plane_dual_ray_height_vertical_difference`）。 -/
theorem planeDualRayHeight_vertical (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0)
    (r c : ℤ) :
    planeDualRayHeight edges r c + planeDualRayHeight edges (r - 1) c =
      if (false, (r, c)) ∈ edges then 1 else 0 := by
  have hneg : ∀ x : ZMod 2, -x = x := by decide
  -- 証明の準備: 全ての辺の列座標と c より大きい整数 M = c + n を取る（辺の集合の有限性から存在する）。
  obtain ⟨n, hM⟩ : ∃ n : ℕ, ∀ x ∈ edges, x.2.2 < c + n := by
    have hS : ∀ x ∈ edges, x.2.2 - c ≤ ∑ y ∈ edges, |y.2.2 - c| := fun x hx =>
      (le_abs_self _).trans
        (Finset.single_le_sum (f := fun y : GridEdge => |y.2.2 - c|)
          (fun _ _ => abs_nonneg _) hx)
    refine ⟨(∑ y ∈ edges, |y.2.2 - c|).toNat + 1, fun x hx => ?_⟩
    have h1 := hS x hx
    have h2 := Int.self_le_toNat (∑ y ∈ edges, |y.2.2 - c|)
    push_cast
    omega
  have hpair : ∀ j : ℤ,
      (if (true, (r, j)) ∈ edges then (1 : ZMod 2) else 0) +
          (if (true, (r - 1, j)) ∈ edges then (1 : ZMod 2) else 0) =
        (if (false, (r, j)) ∈ edges then (1 : ZMod 2) else 0) +
          (if (false, (r, j - 1)) ∈ edges then (1 : ZMod 2) else 0) := by
    intro j
    have h' : ((if (true, (r, j)) ∈ edges then (1 : ZMod 2) else 0) +
          (if (true, (r - 1, j)) ∈ edges then (1 : ZMod 2) else 0)) +
        ((if (false, (r, j)) ∈ edges then (1 : ZMod 2) else 0) +
          (if (false, (r, j - 1)) ∈ edges then (1 : ZMod 2) else 0)) = 0 := by
      linear_combination heven r j
    rw [eq_neg_of_add_eq_zero_left h', hneg]
  have hend : (false, (r, c + (n : ℤ))) ∉ edges := by
    intro hx
    exact lt_irrefl _ (hM _ hx)
  calc
    planeDualRayHeight edges r c + planeDualRayHeight edges (r - 1) c
        = (∑ j ∈ Finset.Ioc c (c + n), if (true, (r, j)) ∈ edges then (1 : ZMod 2) else 0) +
            ∑ j ∈ Finset.Ioc c (c + n),
              if (true, (r - 1, j)) ∈ edges then (1 : ZMod 2) else 0 := by
          -- 本文: 高さの定義と M の選び方
          rw [planeDualRayHeight_eq_columnSum edges r c (c + n) hM,
            planeDualRayHeight_eq_columnSum edges (r - 1) c (c + n) hM]
    _ = ∑ j ∈ Finset.Ioc c (c + n),
          ((if (true, (r, j)) ∈ edges then (1 : ZMod 2) else 0) +
            if (true, (r - 1, j)) ∈ edges then (1 : ZMod 2) else 0) :=
          (Finset.sum_add_distrib).symm
    _ = ∑ j ∈ Finset.Ioc c (c + n),
          ((if (false, (r, j)) ∈ edges then (1 : ZMod 2) else 0) +
            if (false, (r, j - 1)) ∈ edges then (1 : ZMod 2) else 0) := by
          -- 本文: 各頂点の偶数次数
          exact Finset.sum_congr rfl (fun j _ => hpair j)
    _ = (if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
          if (false, (r, c + (n : ℤ))) ∈ edges then (1 : ZMod 2) else 0 := by
          -- 本文: 中間の横辺は二度現れて偶奇が零
          exact adjacent_pair_sum_telescope
            (fun j => if (false, (r, j)) ∈ edges then (1 : ZMod 2) else 0) c n
    _ = if (false, (r, c)) ∈ edges then 1 else 0 := by
          -- 本文: M は全ての辺の列座標より大きい
          rw [if_neg hend, add_zero]

end Ising2DLambda.KacWard
