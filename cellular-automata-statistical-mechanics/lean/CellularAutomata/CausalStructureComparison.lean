/-
章「既存因果構造との比較」の具体版。
人手証明の正本は structured-latex/content/causal-structure-comparison.ts。

区間、被覆関係、一段依存と被覆関係の一致、および時刻写像が順序だけからは
復元できない具体的反例を、人手証明と同じ有限舞台・自然数時刻について形式化する。
物理的因果、グラフ、多様体、R / C は使わない。
-/
import CellularAutomata.DependencyOrderSubstructures
import CellularAutomata.NecSuf.CausalStructureComparison

namespace CellularAutomata.CausalStructureComparison

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.TransitiveClosureAntisymmetry

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 有限半順序の区間（`def_finite_poset_interval`）を依存順序へ特殊化した
    順序区間 I_τ(a,b)（`def_order_interval`）。 -/
def orderInterval (τ : ℕ) (a b : ℕ × V) : Set (ℕ × V) :=
  {c | c ∈ eventSet τ ∧ (a, c) ∈ ReflReachable N f τ ∧
    (c, b) ∈ ReflReachable N f τ}

/-- `claim_order_interval_finite` の有限性。 -/
theorem orderInterval_finite (τ : ℕ) (a b : ℕ × V) :
    (orderInterval N f τ a b).Finite := by
  apply (Finset.finite_toSet (eventSet (V := V) τ)).subset
  intro c hc
  exact hc.1

/-- `claim_order_interval_finite` の個数上界。 -/
theorem orderInterval_ncard_le (τ : ℕ) (a b : ℕ × V) :
    (orderInterval N f τ a b).ncard ≤ (τ + 1) * Fintype.card V := by
  calc
    (orderInterval N f τ a b).ncard
        ≤ (↑(eventSet (V := V) τ) : Set (ℕ × V)).ncard :=
      Set.ncard_le_ncard (fun _ h => h.1) (Finset.finite_toSet _)
    _ = (eventSet (V := V) τ).card := Set.ncard_coe_finset _
    _ = (τ + 1) * Fintype.card V := card_eventSet τ

/-- 有限関係の被覆関係（`def_finite_relation_covering`）を C_τ へ特殊化した
    被覆関係（`def_covering_relation`）。 -/
def Covering (τ : ℕ) : Set ((ℕ × V) × (ℕ × V)) :=
  {ab | ab ∈ Reachable N f τ ∧
    ¬ ∃ c, c ∈ eventSet τ ∧ (ab.1, c) ∈ Reachable N f τ ∧
      (c, ab.2) ∈ Reachable N f τ}

/-- `claim_one_step_subset_covering` の具体版。 -/
theorem oneStep_subset_covering (τ : ℕ) (a b : ℕ × V)
    (hab : (a, b) ∈ oneStepDep N f τ) : (a, b) ∈ Covering N f τ := by
  refine ⟨oneStep_subset_reachable N f τ a b hab, ?_⟩
  rintro ⟨c, -, hac, hcb⟩
  have hacTime : a.1 < c.1 := by
    obtain ⟨n, p, hpath, hp0, hpn⟩ := hac
    have h := path_time_strictly_increases N f τ n p hpath
    simpa [hp0, hpn] using h
  have hcbTime : c.1 < b.1 := by
    obtain ⟨n, p, hpath, hp0, hpn⟩ := hcb
    have h := path_time_strictly_increases N f τ n p hpath
    simpa [hp0, hpn] using h
  have hsucc : b.1 = a.1 + 1 := by
    exact (mem_oneStepDep N f τ a.1 b.1 a.2 b.2).mp hab |>.2.1
  omega

/-- `claim_covering_subset_one_step` の具体版。人手証明と同じく、
    被覆する経路の長さが 2 以上なら p(1) が中間点になることから示す。 -/
theorem covering_subset_oneStep (τ : ℕ) (a b : ℕ × V)
    (hab : (a, b) ∈ Covering N f τ) : (a, b) ∈ oneStepDep N f τ := by
  obtain ⟨⟨n, p, hpath, hp0, hpn⟩, hcover⟩ := hab
  rcases hpath with ⟨hn, hmem, hstep⟩
  by_cases hn1 : n = 1
  · subst n
    simpa [hp0, hpn] using hstep 0 Nat.one_pos
  · have hn2 : 2 ≤ n := by omega
    exfalso
    apply hcover
    refine ⟨p 1, hmem 1 (by omega), ?_, ?_⟩
    · have h01 : (p 0, p 1) ∈ oneStepDep N f τ := hstep 0 (by omega)
      simpa [hp0] using oneStep_subset_reachable N f τ (p 0) (p 1) h01
    · let q : ℕ → ℕ × V := fun i => p (i + 1)
      refine ⟨n - 1, q, ⟨by omega, ?_, ?_⟩, rfl, ?_⟩
      · intro i hi
        exact hmem (i + 1) (by omega)
      · intro i hi
        simpa [q, Nat.add_assoc] using hstep (i + 1) (by omega)
      · change p (n - 1 + 1) = b
        have hindex : n - 1 + 1 = n := by omega
        rw [hindex, hpn]

/-- `claim_one_step_equals_covering` の具体版。 -/
theorem oneStep_eq_covering (τ : ℕ) :
    (↑(oneStepDep N f τ) : Set ((ℕ × V) × (ℕ × V))) = Covering N f τ := by
  ext ab
  constructor
  · intro h
    exact oneStep_subset_covering N f τ ab.1 ab.2 h
  · intro h
    exact covering_subset_oneStep N f τ ab.1 ab.2 h

/-- `claim_order_iso_not_time_preserving` の具体版。
    一元舞台、自己近傍、定値局所規則、τ=1 を用いる。 -/
theorem exists_order_equiv_not_time_preserving :
    let N : Unit → Finset Unit := fun _ => {()}
    let f : (v : Unit) → (↥(N v) → State) → State := fun _ _ => State.zero
    ∃ σ : Equiv.Perm (ℕ × Unit),
      (∀ a b, a ∈ eventSet (V := Unit) 1 → b ∈ eventSet (V := Unit) 1 →
        ((a, b) ∈ ReflReachable N f 1 ↔
          (σ a, σ b) ∈ ReflReachable N f 1)) ∧
      (∃ a, a ∈ eventSet (V := Unit) 1 ∧ (σ a).1 ≠ a.1) := by
  dsimp
  let N : Unit → Finset Unit := fun _ => {()}
  let f : (v : Unit) → (↥(N v) → State) → State := fun _ _ => State.zero
  let e₀ : ℕ × Unit := (0, ())
  let e₁ : ℕ × Unit := (1, ())
  let σ : Equiv.Perm (ℕ × Unit) := Equiv.swap e₀ e₁
  have hD : oneStepDep N f 1 = ∅ := by
    ext ab
    simp [oneStepDep, N, f, EssentialDependency.supp,
      EssentialDependency.EssentialDep]
  have hC : Reachable N f 1 = ∅ := by
    ext ab
    constructor
    · rintro ⟨n, p, ⟨hn, -, hstep⟩, -, -⟩
      have h01 := hstep 0 hn
      rw [hD] at h01
      simp at h01
    · simp
  have hRefl : ∀ a b : ℕ × Unit,
      (a, b) ∈ ReflReachable N f 1 ↔
        a ∈ eventSet (V := Unit) 1 ∧ b ∈ eventSet (V := Unit) 1 ∧ a = b := by
    intro a b
    constructor
    · rintro ⟨ha, hb, hab | hab⟩
      · exact ⟨ha, hb, hab⟩
      · rw [hC] at hab
        simp at hab
    · rintro ⟨ha, hb, hab⟩
      exact ⟨ha, hb, Or.inl hab⟩
  refine ⟨σ, ?_, ?_⟩
  · intro a b ha hb
    have hσa : σ a ∈ eventSet (V := Unit) 1 := by
      rcases a with ⟨t, ⟨⟩⟩
      simp [eventSet, timeInterval] at ha ⊢
      interval_cases t <;> simp [σ, e₀, e₁]
    have hσb : σ b ∈ eventSet (V := Unit) 1 := by
      rcases b with ⟨t, ⟨⟩⟩
      simp [eventSet, timeInterval] at hb ⊢
      interval_cases t <;> simp [σ, e₀, e₁]
    rw [hRefl a b, hRefl (σ a) (σ b)]
    constructor
    · rintro ⟨-, -, hab⟩
      exact ⟨hσa, hσb, congrArg σ hab⟩
    · rintro ⟨-, -, hab⟩
      exact ⟨ha, hb, σ.injective hab⟩
  · refine ⟨e₀, ?_, ?_⟩
    · simp [e₀, eventSet, timeInterval]
    · simp [σ, e₀, e₁]

/-! ## 必要十分版からの導出

以下は、上の具体版の定義・定理が必要十分版（`NecSuf.CausalStructureComparison`）を
イベント集合・一段依存関係・到達可能関係・時刻射影・自然数の大小へ特殊化したものであることの導出。 -/

/-- 具体版の順序区間は、必要十分版をイベント集合と反射的到達可能関係へ特殊化したものである。 -/
theorem orderInterval_eq_necessary_sufficient (τ : ℕ) (a b : ℕ × V) :
    orderInterval N f τ a b =
      CellularAutomata.NecSuf.CausalStructureComparison.orderInterval
        (↑(eventSet (V := V) τ)) (ReflReachable N f τ) a b := rfl

/-- 区間の有限性が、必要十分版へ有限なイベント集合を渡して得られること。 -/
theorem orderInterval_finite_from_necessary_sufficient (τ : ℕ) (a b : ℕ × V) :
    (orderInterval N f τ a b).Finite := by
  rw [orderInterval_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.CausalStructureComparison.orderInterval_finite _ _
    (Finset.finite_toSet _) a b

/-- 区間の個数上界が、必要十分版の |X| による上界と |E_τ| = (τ+1)|V| から得られること。 -/
theorem orderInterval_ncard_le_from_necessary_sufficient (τ : ℕ) (a b : ℕ × V) :
    (orderInterval N f τ a b).ncard ≤ (τ + 1) * Fintype.card V := by
  rw [orderInterval_eq_necessary_sufficient]
  calc
    (CellularAutomata.NecSuf.CausalStructureComparison.orderInterval
        (↑(eventSet (V := V) τ)) (ReflReachable N f τ) a b).ncard
        ≤ (↑(eventSet (V := V) τ) : Set (ℕ × V)).ncard :=
      CellularAutomata.NecSuf.CausalStructureComparison.orderInterval_ncard_le _ _
        (Finset.finite_toSet _) a b
    _ = (eventSet (V := V) τ).card := Set.ncard_coe_finset _
    _ = (τ + 1) * Fintype.card V := card_eventSet τ

/-- 具体版の被覆関係は、必要十分版をイベント集合と到達可能関係へ特殊化したものである。 -/
theorem covering_eq_necessary_sufficient (τ : ℕ) :
    Covering N f τ =
      CellularAutomata.NecSuf.CausalStructureComparison.Covering
        (↑(eventSet (V := V) τ)) (Reachable N f τ) := rfl

/-- 具体版の到達可能関係（集合として）は必要十分版の到達可能関係に等しい。 -/
theorem reachable_eq_necessary_sufficient (τ : ℕ) :
    Reachable N f τ =
      CellularAutomata.NecSuf.TransitiveClosureAntisymmetry.Reachable
        (↑(eventSet (V := V) τ)) (↑(oneStepDep N f τ)) := by
  ext ⟨a, b⟩
  exact reachable_iff_necessary_sufficient N f τ a b

/-- 一段依存 ⊆ 被覆が、必要十分版へ時刻射影・自然数の大小・時刻差 1 の隣接性を渡して
    得られること。 -/
theorem oneStep_subset_covering_from_necessary_sufficient (τ : ℕ) (a b : ℕ × V)
    (hab : (a, b) ∈ oneStepDep N f τ) : (a, b) ∈ Covering N f τ := by
  rw [covering_eq_necessary_sufficient]
  refine CellularAutomata.NecSuf.CausalStructureComparison.oneStep_subset_covering
    (↑(eventSet (V := V) τ)) (↑(oneStepDep N f τ)) (Reachable N f τ) Prod.fst (· < ·)
    (fun _ h => oneStep_subset_reachable N f τ _ _ h) ?_ ?_ a b hab
  · rintro x y ⟨n, p, hpath, hp0, hpn⟩
    have h := path_time_strictly_increases N f τ n p hpath
    simpa [hp0, hpn] using h
  · intro x y hxy t hxt hty
    have hsucc : y.1 = x.1 + 1 :=
      (mem_oneStepDep N f τ x.1 y.1 x.2 y.2).mp hxy |>.2.1
    omega

/-- 被覆 ⊆ 一段依存が、必要十分版の特殊化として得られること。 -/
theorem covering_subset_oneStep_from_necessary_sufficient (τ : ℕ) (a b : ℕ × V)
    (hab : (a, b) ∈ Covering N f τ) : (a, b) ∈ oneStepDep N f τ := by
  rw [covering_eq_necessary_sufficient, reachable_eq_necessary_sufficient] at hab
  exact CellularAutomata.NecSuf.CausalStructureComparison.covering_subset_oneStep
    (↑(eventSet (V := V) τ)) (↑(oneStepDep N f τ)) a b hab

/-- 時刻を保存しない順序同型の反例が、必要十分版へ「一段依存が空」と
    「時刻の異なる二イベント (0,()) と (1,())」を渡して得られること。 -/
theorem exists_order_equiv_not_time_preserving_from_necessary_sufficient :
    let N : Unit → Finset Unit := fun _ => {()}
    let f : (v : Unit) → (↥(N v) → State) → State := fun _ _ => State.zero
    ∃ σ : Equiv.Perm (ℕ × Unit),
      (∀ a b, a ∈ eventSet (V := Unit) 1 → b ∈ eventSet (V := Unit) 1 →
        ((a, b) ∈ ReflReachable N f 1 ↔
          (σ a, σ b) ∈ ReflReachable N f 1)) ∧
      (∃ a, a ∈ eventSet (V := Unit) 1 ∧ (σ a).1 ≠ a.1) := by
  dsimp
  let N : Unit → Finset Unit := fun _ => {()}
  let f : (v : Unit) → (↥(N v) → State) → State := fun _ _ => State.zero
  have hD : (↑(oneStepDep N f 1) : Set ((ℕ × Unit) × (ℕ × Unit))) = ∅ := by
    ext ab
    simp [oneStepDep, N, f, EssentialDependency.supp,
      EssentialDependency.EssentialDep]
  obtain ⟨σ, hσ, a, ha, hta⟩ :=
    CellularAutomata.NecSuf.CausalStructureComparison.exists_order_equiv_not_time_preserving
      (↑(eventSet (V := Unit) 1)) (↑(oneStepDep N f 1)) Prod.fst hD (0, ()) (1, ())
      (by simp [eventSet, timeInterval]) (by simp [eventSet, timeInterval]) (by simp)
  refine ⟨σ, ?_, a, ha, hta⟩
  intro x y hx hy
  rw [reflReachable_iff_necessary_sufficient, reflReachable_iff_necessary_sufficient]
  exact hσ x y hx hy

end CellularAutomata.CausalStructureComparison
