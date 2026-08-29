/-
章「依存の推移閉包の反対称性」の必要十分版。

具体版と同じ経路長の帰納法・経路連結・相互到達からの矛盾・反射閉包の
場合分けを保ち、実際に使う構造だけを残す。

* 経路・到達可能性・推移閉包には、イベントの集合 X と一段関係 D だけを使う。
* 反対称性には、時刻写像、時刻上の推移的かつ非反射的な関係、および
  D の各一段で時刻が増えることだけを使う。
* X の有限性は到達可能関係の有限性にだけ使う。

構造化本文の `def_dependency_path`、`def_reachability`、
`claim_one_step_subset_reachability`、`claim_reachability_transitive`、
`claim_reachability_minimal`、`claim_reachability_finite`、
`def_reflexive_reachability` に対応する一般形をこのファイルに置く。

舞台、状態、近傍、局所規則、自然数、グラフ、物理的因果、ℝ / ℂ は使わない。
-/
import Mathlib

namespace CellularAutomata.NecSuf.TransitiveClosureAntisymmetry

variable {Event Time : Type}

/-- 集合 X 内で一段関係 D をたどる、長さ 1 以上の経路。 -/
structure IsDepPath (X : Set Event) (D : Set (Event × Event))
    (n : ℕ) (p : ℕ → Event) : Prop where
  one_le : 1 ≤ n
  mem_set : ∀ i ≤ n, p i ∈ X
  step : ∀ i < n, (p i, p (i + 1)) ∈ D

/-- 一段関係の各辺で時刻が増えるなら、経路の始点から終点へ時刻が増える。
    具体版と同じく経路長について帰納し、最後に推移性を一度使う。 -/
theorem path_time_strictly_increases
    (X : Set Event) (D : Set (Event × Event))
    (time : Event → Time) (lt : Time → Time → Prop)
    (lt_transitive : ∀ a b c, lt a b → lt b c → lt a c)
    (step_time_increases : ∀ a b, (a, b) ∈ D → lt (time a) (time b))
    (n : ℕ) (p : ℕ → Event) (hpath : IsDepPath X D n p) :
    lt (time (p 0)) (time (p n)) := by
  obtain ⟨hn, -, hstep⟩ := hpath
  induction n with
  | zero => omega
  | succ m ih =>
    by_cases hm : m = 0
    · subst hm
      exact step_time_increases (p 0) (p 1) (hstep 0 Nat.one_pos)
    · have h1 : 1 ≤ m := Nat.one_le_iff_ne_zero.mpr hm
      have h0m := ih h1 (fun i hi => hstep i (Nat.lt_succ_of_lt hi))
      have hlast := step_time_increases (p m) (p (m + 1))
        (hstep m (Nat.lt_succ_self m))
      exact lt_transitive _ _ _ h0m hlast

/-- 集合 X 内での一段関係 D の到達可能関係。 -/
def Reachable (X : Set Event) (D : Set (Event × Event)) : Set (Event × Event) :=
  { ab | ∃ (n : ℕ) (p : ℕ → Event),
      IsDepPath X D n p ∧ p 0 = ab.1 ∧ p n = ab.2 }

/-- 到達可能関係の両端は X に属する。 -/
theorem reachable_subset_product (X : Set Event) (D : Set (Event × Event)) :
    Reachable X D ⊆ X ×ˢ X := by
  rintro ⟨a, b⟩ ⟨n, p, ⟨-, hmem, -⟩, hp0, hpn⟩
  exact ⟨hp0 ▸ hmem 0 (Nat.zero_le n), hpn ▸ hmem n (le_refl n)⟩

/-- X が有限なら、その直積の部分集合である到達可能関係も有限である。 -/
theorem reachable_finite (X : Set Event) (D : Set (Event × Event))
    (hX : X.Finite) : (Reachable X D).Finite :=
  (hX.prod hX).subset (reachable_subset_product X D)

/-- 一段関係は到達可能関係に含まれる。 -/
theorem oneStep_subset_reachable (X : Set Event) (D : Set (Event × Event))
    (hD : D ⊆ X ×ˢ X) : D ⊆ Reachable X D := by
  rintro ⟨a, b⟩ hab
  have hX := hD hab
  refine ⟨1, fun i => if i = 0 then a else b, ⟨le_refl 1, ?_, ?_⟩, by simp, by simp⟩
  · intro i hi
    rcases Nat.le_one_iff_eq_zero_or_eq_one.mp hi with rfl | rfl
    · simpa using hX.1
    · simpa using hX.2
  · intro i hi
    have hi0 : i = 0 := by omega
    subst hi0
    simpa using hab

/-- 到達可能関係は経路の連結によって推移的である。 -/
theorem reachable_transitive (X : Set Event) (D : Set (Event × Event))
    (a b c : Event) (hab : (a, b) ∈ Reachable X D)
    (hbc : (b, c) ∈ Reachable X D) : (a, c) ∈ Reachable X D := by
  obtain ⟨m, p, ⟨hm, hpmem, hpstep⟩, hp0, hpm⟩ := hab
  obtain ⟨n, q, ⟨hn, hqmem, hqstep⟩, hq0, hqn⟩ := hbc
  have hjoin : p m = q 0 := by rw [hpm, hq0]
  set r : ℕ → Event := fun i => if i ≤ m then p i else q (i - m) with hr
  have hr_le : ∀ i, i ≤ m → r i = p i := fun i hi => by simp [hr, hi]
  have hr_gt : ∀ i, m < i → r i = q (i - m) := fun i hi => by
    simp [hr, Nat.not_le.mpr hi]
  refine ⟨m + n, r, ⟨by omega, ?_, ?_⟩, ?_, ?_⟩
  · intro i hi
    by_cases him : i ≤ m
    · rw [hr_le i him]
      exact hpmem i him
    · rw [hr_gt i (Nat.not_le.mp him)]
      exact hqmem (i - m) (by omega)
  · intro i hi
    by_cases him : i < m
    · rw [hr_le i (Nat.le_of_lt him), hr_le (i + 1) him]
      exact hpstep i him
    · have him' : m ≤ i := Nat.not_lt.mp him
      have hri : r i = q (i - m) := by
        rcases Nat.eq_or_lt_of_le him' with heq | hlt
        · rw [hr_le i heq.ge, ← heq, Nat.sub_self, hjoin]
        · exact hr_gt i hlt
      have hri1 : r (i + 1) = q (i - m + 1) := by
        rw [hr_gt (i + 1) (by omega)]
        congr 1
        omega
      rw [hri, hri1]
      exact hqstep (i - m) (by omega)
  · rw [hr_le 0 (Nat.zero_le m)]
    exact hp0
  · rw [hr_gt (m + n) (by omega), Nat.add_sub_cancel_left]
    exact hqn

/-- Reachable X D は D を含む最小の推移的関係である。 -/
theorem reachable_minimal (X : Set Event) (D R : Set (Event × Event))
    (hRtrans : ∀ x y z, (x, y) ∈ R → (y, z) ∈ R → (x, z) ∈ R)
    (hDR : D ⊆ R) : Reachable X D ⊆ R := by
  have key : ∀ (n : ℕ), 1 ≤ n → ∀ p : ℕ → Event,
      (∀ i < n, (p i, p (i + 1)) ∈ D) → (p 0, p n) ∈ R := by
    intro n
    induction n with
    | zero => omega
    | succ m ih =>
      intro _ p hstep
      by_cases hm : m = 0
      · subst hm
        exact hDR (hstep 0 Nat.one_pos)
      · have h1 : 1 ≤ m := Nat.one_le_iff_ne_zero.mpr hm
        have hR0 := ih h1 p (fun i hi => hstep i (Nat.lt_succ_of_lt hi))
        have hRm := hDR (hstep m (Nat.lt_succ_self m))
        exact hRtrans _ _ _ hR0 hRm
  rintro ⟨a, b⟩ ⟨n, p, ⟨hn, -, hstep⟩, hp0, hpn⟩
  have h := key n hn p hstep
  rw [hp0, hpn] at h
  exact h

/-- 推移的・非反射的な時刻関係が各一段で増えるなら、相互到達はない。 -/
theorem no_mutual_reachability
    (X : Set Event) (D : Set (Event × Event))
    (time : Event → Time) (lt : Time → Time → Prop)
    (lt_transitive : ∀ a b c, lt a b → lt b c → lt a c)
    (lt_irreflexive : ∀ a, ¬ lt a a)
    (step_time_increases : ∀ a b, (a, b) ∈ D → lt (time a) (time b))
    (a b : Event) (hab : (a, b) ∈ Reachable X D)
    (hba : (b, a) ∈ Reachable X D) : False := by
  obtain ⟨n, p, hpath, hp0, hpn⟩ := hab
  have h1 := path_time_strictly_increases X D time lt lt_transitive
    step_time_increases n p hpath
  rw [hp0, hpn] at h1
  obtain ⟨m, q, hpath', hq0, hqm⟩ := hba
  have h2 := path_time_strictly_increases X D time lt lt_transitive
    step_time_increases m q hpath'
  rw [hq0, hqm] at h2
  exact lt_irreflexive (time a) (lt_transitive _ _ _ h1 h2)

/-- 自己到達は相互到達の特例として起こらない。 -/
theorem reachable_irreflexive
    (X : Set Event) (D : Set (Event × Event))
    (time : Event → Time) (lt : Time → Time → Prop)
    (lt_transitive : ∀ a b c, lt a b → lt b c → lt a c)
    (lt_irreflexive : ∀ a, ¬ lt a a)
    (step_time_increases : ∀ a b, (a, b) ∈ D → lt (time a) (time b))
    (a : Event) (h : (a, a) ∈ Reachable X D) : False :=
  no_mutual_reachability X D time lt lt_transitive lt_irreflexive
    step_time_increases a a h h

/-- X 上の反射的到達可能関係。 -/
def ReflReachable (X : Set Event) (D : Set (Event × Event)) : Set (Event × Event) :=
  { ab | ab.1 ∈ X ∧ ab.2 ∈ X ∧ (ab.1 = ab.2 ∨ ab ∈ Reachable X D) }

/-- 集合 X 上の部分順序に必要な三条件。 -/
def IsPartialOrderOn (X : Set Event) (R : Set (Event × Event)) : Prop :=
  (∀ x ∈ X, (x, x) ∈ R) ∧
    (∀ x y, (x, y) ∈ R → (y, x) ∈ R → x = y) ∧
    (∀ x y z, (x, y) ∈ R → (y, z) ∈ R → (x, z) ∈ R)

/-- 時刻増加から、反射的到達可能関係は X 上の部分順序になる。 -/
theorem reflReachable_partial_order
    (X : Set Event) (D : Set (Event × Event))
    (time : Event → Time) (lt : Time → Time → Prop)
    (lt_transitive : ∀ a b c, lt a b → lt b c → lt a c)
    (lt_irreflexive : ∀ a, ¬ lt a a)
    (step_time_increases : ∀ a b, (a, b) ∈ D → lt (time a) (time b)) :
    IsPartialOrderOn X (ReflReachable X D) := by
  refine ⟨?_, ?_, ?_⟩
  · intro a ha
    exact ⟨ha, ha, Or.inl rfl⟩
  · rintro a b ⟨-, -, hab⟩ ⟨-, -, hba⟩
    rcases hab with heq | hab
    · exact heq
    rcases hba with heq | hba
    · exact heq.symm
    exact (no_mutual_reachability X D time lt lt_transitive lt_irreflexive
      step_time_increases a b hab hba).elim
  · rintro a b c ⟨ha, -, hab⟩ ⟨-, hc, hbc⟩
    change a = b ∨ (a, b) ∈ Reachable X D at hab
    change b = c ∨ (b, c) ∈ Reachable X D at hbc
    refine ⟨ha, hc, ?_⟩
    rcases hab with rfl | hab
    · rcases hbc with rfl | hbc
      · exact Or.inl rfl
      · exact Or.inr hbc
    · rcases hbc with rfl | hbc
      · exact Or.inr hab
      · exact Or.inr (reachable_transitive X D a b c hab hbc)

end CellularAutomata.NecSuf.TransitiveClosureAntisymmetry
