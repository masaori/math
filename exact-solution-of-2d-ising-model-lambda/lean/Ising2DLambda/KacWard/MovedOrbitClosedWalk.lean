/-
章「トーラス上の Kac--Ward 行列式」の
「動く辺の軌道列は向き付き辺が相異なる閉じた非後退辺列である」の具体版。
人手証明と 1 対 1 に対応する:
- claim_permutation_power_return（鳩の巣による回帰の存在）= permutation_power_return
- def_permutation_minimal_return（最小回帰時刻）= minimalReturnTime とその三性質
- claim_moved_orbit_closed_nonbacktracking の第一（各項は動く辺）・第二（隣接接続と閉性）・
  第三（相異性）= movedOrbit_closed_nonbacktracking の三成分
-/
import Mathlib.Data.Fintype.Card
import Mathlib.Tactic
import Ising2DLambda.NecSuf.KacWard.MovedOrbitClosedWalk

namespace Ising2DLambda.KacWard

variable {E : Type} [Fintype E] [DecidableEq E]

omit [DecidableEq E] in
/-- 回帰の存在（claim_permutation_power_return）。鳩の巣原理と単射性による。 -/
theorem permutation_power_return (σ : Equiv.Perm E) (e : E) :
    ∃ k, 1 ≤ k ∧ (⇑σ)^[k] e = e := by
  classical
  obtain ⟨j, l, hne, h⟩ :=
    Finite.exists_ne_map_eq_of_infinite (fun n : ℕ => (⇑σ)^[n] e)
  have h' : (⇑σ)^[j] e = (⇑σ)^[l] e := h
  have key : ∀ j l : ℕ, j < l → (⇑σ)^[j] e = (⇑σ)^[l] e →
      ∃ k, 1 ≤ k ∧ (⇑σ)^[k] e = e := by
    intro j l hjl hjle
    refine ⟨l - j, by omega, ?_⟩
    have hsplit : (⇑σ)^[j] ((⇑σ)^[l - j] e) = (⇑σ)^[l] e := by
      rw [← Function.iterate_add_apply]
      congr 1
      omega
    exact (σ.injective.iterate j) (by rw [hsplit, ← hjle])
  rcases lt_or_gt_of_ne hne with hjl | hjl
  · exact key j l hjl h'
  · exact key l j hjl h'.symm

/-- 最小回帰時刻（def_permutation_minimal_return）。回帰の存在から最小元を取る。 -/
noncomputable def minimalReturnTime (σ : Equiv.Perm E) (e : E) : ℕ :=
  Nat.find (permutation_power_return σ e)

theorem minimalReturnTime_pos (σ : Equiv.Perm E) (e : E) :
    1 ≤ minimalReturnTime σ e :=
  (Nat.find_spec (permutation_power_return σ e)).1

theorem minimalReturnTime_return (σ : Equiv.Perm E) (e : E) :
    (⇑σ)^[minimalReturnTime σ e] e = e :=
  (Nat.find_spec (permutation_power_return σ e)).2

theorem minimalReturnTime_min (σ : Equiv.Perm E) (e : E) :
    ∀ k, 1 ≤ k → k < minimalReturnTime σ e → (⇑σ)^[k] e ≠ e := by
  intro k hk1 hk hret
  exact Nat.find_min (permutation_power_return σ e) hk ⟨hk1, hret⟩

/-- 動く辺の軌道列は向き付き辺が相異なる閉じた非後退辺列である
（claim_moved_orbit_closed_nonbacktracking）。
第一成分: 各項は動く辺。第二成分: 隣接接続。第三成分: 閉じる接続。第四成分: 相異性。 -/
theorem movedOrbit_closed_nonbacktracking (σ : Equiv.Perm E)
    (Next : E → E → Prop) (hyp : ∀ f, σ f ≠ f → Next f (σ f))
    (e : E) (he : σ e ≠ e) :
    (∀ k, σ ((⇑σ)^[k] e) ≠ (⇑σ)^[k] e) ∧
    (∀ k, Next ((⇑σ)^[k] e) ((⇑σ)^[k + 1] e)) ∧
    Next ((⇑σ)^[minimalReturnTime σ e - 1] e) e ∧
    (∀ j l, j < l → l < minimalReturnTime σ e → (⇑σ)^[j] e ≠ (⇑σ)^[l] e) := by
  -- 第一の主張: 単射性の移送。
  have moved : ∀ k, σ ((⇑σ)^[k] e) ≠ (⇑σ)^[k] e := by
    intro k
    induction k with
    | zero => simpa using he
    | succ k ih =>
      intro h
      rw [Function.iterate_succ_apply'] at h
      exact ih (σ.injective h)
  -- 第二の主張の隣接接続: 仮定の適用。
  have chain : ∀ k, Next ((⇑σ)^[k] e) ((⇑σ)^[k + 1] e) := by
    intro k
    have h := hyp ((⇑σ)^[k] e) (moved k)
    simpa [Function.iterate_succ_apply'] using h
  -- 第二の主張の閉性: 最小回帰時刻での回帰。
  have closing : Next ((⇑σ)^[minimalReturnTime σ e - 1] e) e := by
    have h := chain (minimalReturnTime σ e - 1)
    have hr : minimalReturnTime σ e - 1 + 1 = minimalReturnTime σ e := by
      have := minimalReturnTime_pos σ e
      omega
    rw [hr, minimalReturnTime_return σ e] at h
    exact h
  -- 第三の主張: 最小性による相異性。
  have distinct : ∀ j l, j < l → l < minimalReturnTime σ e →
      (⇑σ)^[j] e ≠ (⇑σ)^[l] e := by
    intro j l hjl hlr h
    have hsplit : (⇑σ)^[j] ((⇑σ)^[l - j] e) = (⇑σ)^[l] e := by
      rw [← Function.iterate_add_apply]
      congr 1
      omega
    have hx0 : (⇑σ)^[l - j] e = e := (σ.injective.iterate j) (by rw [hsplit, ← h])
    exact minimalReturnTime_min σ e (l - j) (by omega) (by omega) hx0
  exact ⟨moved, chain, closing, distinct⟩

/-- 導出版: 同じ主張を必要十分版の三定理から得る。 -/
theorem movedOrbit_closed_nonbacktracking_from_necSuf (σ : Equiv.Perm E)
    (Next : E → E → Prop) (hyp : ∀ f, σ f ≠ f → Next f (σ f))
    (e : E) (he : σ e ≠ e) :
    (∀ k, σ ((⇑σ)^[k] e) ≠ (⇑σ)^[k] e) ∧
    (∀ k, Next ((⇑σ)^[k] e) ((⇑σ)^[k + 1] e)) ∧
    Next ((⇑σ)^[minimalReturnTime σ e - 1] e) e ∧
    (∀ j l, j < l → l < minimalReturnTime σ e → (⇑σ)^[j] e ≠ (⇑σ)^[l] e) := by
  refine ⟨Ising2DLambda.NecSuf.KacWard.moved_iterate_ne σ.injective he,
    Ising2DLambda.NecSuf.KacWard.orbit_relation_chain σ.injective hyp he, ?_,
    Ising2DLambda.NecSuf.KacWard.orbit_iterates_distinct σ.injective
      (minimalReturnTime_min σ e)⟩
  have h := Ising2DLambda.NecSuf.KacWard.orbit_relation_chain σ.injective hyp he
    (minimalReturnTime σ e - 1)
  have hr : minimalReturnTime σ e - 1 + 1 = minimalReturnTime σ e := by
    have := minimalReturnTime_pos σ e
    omega
  rw [hr, minimalReturnTime_return σ e] at h
  exact h

end Ising2DLambda.KacWard
