/-
章「既存因果構造との比較」の必要十分版。

具体版と同じ定義と証明順序を保ち、実際に使う構造だけを残す。

* 順序区間には集合 X と関係 R だけを使う。有限性・個数上界には X の有限性だけが要る。
  個数上界は |X| で述べ、イベント集合の積の形（(τ+1)|V|）は具体版へ特殊化して初めて現れる。
* 被覆関係には集合 X と関係 C だけを使う。
* 一段関係が被覆関係に含まれることには、D ⊆ C、C に沿った時刻増加、
  D の対の時刻の間に時刻がないこと（隣接性）だけを使う。自然数時刻・後者関数は要らない。
* 被覆関係が一段関係に含まれることには、C が X 内の D 経路による到達可能関係であることだけを使う。
  時刻は要らない。
* 両者の等号には、D の両端が X に属すること、時刻関係の推移性、一段の時刻増加、隣接性が要る。
* 時刻を保存しない順序同型の反例には、一段関係が空であること、X の中に時刻の異なる二点があること、
  イベントの等号判定（入れ替え写像の定義に要る）だけを使う。舞台・近傍・局所規則は要らない。

舞台、状態、近傍、局所規則、グラフ、物理的因果、R / C は使わない。
構造化本文の `def_finite_relation_covering` は下の `Covering` に対応し、
CA 固有の `def_covering_relation` はその X := E_τ、C := C_τ への特殊化である。
-/
import CellularAutomata.NecSuf.TransitiveClosureAntisymmetry

namespace CellularAutomata.NecSuf.CausalStructureComparison

open CellularAutomata.NecSuf.TransitiveClosureAntisymmetry

variable {Event Time : Type}

/-- 順序区間。X と関係 R だけで定義する。 -/
def orderInterval (X : Set Event) (R : Set (Event × Event)) (a b : Event) : Set Event :=
  {c | c ∈ X ∧ (a, c) ∈ R ∧ (c, b) ∈ R}

theorem orderInterval_subset (X : Set Event) (R : Set (Event × Event)) (a b : Event) :
    orderInterval X R a b ⊆ X := fun _ h => h.1

/-- 区間の有限性には X の有限性だけが要る。 -/
theorem orderInterval_finite (X : Set Event) (R : Set (Event × Event)) (hX : X.Finite)
    (a b : Event) : (orderInterval X R a b).Finite :=
  hX.subset (orderInterval_subset X R a b)

/-- 区間の個数上界も X の有限性だけから |X| で得られる。 -/
theorem orderInterval_ncard_le (X : Set Event) (R : Set (Event × Event)) (hX : X.Finite)
    (a b : Event) : (orderInterval X R a b).ncard ≤ X.ncard :=
  Set.ncard_le_ncard (orderInterval_subset X R a b) hX

/-- 関係 C の X 上の被覆関係。 -/
def Covering (X : Set Event) (C : Set (Event × Event)) : Set (Event × Event) :=
  {ab | ab ∈ C ∧ ¬ ∃ c, c ∈ X ∧ (ab.1, c) ∈ C ∧ (c, ab.2) ∈ C}

/-- 一段関係 D は被覆関係に含まれる。要るのは D ⊆ C、C に沿った時刻増加、
    D の対の時刻の間に時刻がないことだけである。 -/
theorem oneStep_subset_covering (X : Set Event) (D C : Set (Event × Event))
    (time : Event → Time) (lt : Time → Time → Prop)
    (hDC : D ⊆ C)
    (C_time_increases : ∀ a b, (a, b) ∈ C → lt (time a) (time b))
    (D_adjacent : ∀ a b, (a, b) ∈ D → ∀ t, lt (time a) t → lt t (time b) → False)
    (a b : Event) (hab : (a, b) ∈ D) : (a, b) ∈ Covering X C := by
  refine ⟨hDC hab, ?_⟩
  rintro ⟨c, -, hac, hcb⟩
  exact D_adjacent a b hab (time c) (C_time_increases a c hac) (C_time_increases c b hcb)

/-- 到達可能関係の被覆関係は一段関係に含まれる。時刻は要らない。
    具体版と同じく、経路長が 2 以上なら p 1 が中間点になる。 -/
theorem covering_subset_oneStep (X : Set Event) (D : Set (Event × Event))
    (a b : Event) (hab : (a, b) ∈ Covering X (Reachable X D)) : (a, b) ∈ D := by
  obtain ⟨⟨n, p, hpath, hp0, hpn⟩, hcover⟩ := hab
  rcases hpath with ⟨hn, hmem, hstep⟩
  by_cases hn1 : n = 1
  · subst n
    simpa [hp0, hpn] using hstep 0 Nat.one_pos
  · have hn2 : 2 ≤ n := by omega
    exfalso
    apply hcover
    refine ⟨p 1, hmem 1 (by omega), ?_, ?_⟩
    · refine ⟨1, p, ⟨le_refl 1, ?_, ?_⟩, hp0, rfl⟩
      · intro i hi
        exact hmem i (by omega)
      · intro i hi
        exact hstep i (by omega)
    · let q : ℕ → Event := fun i => p (i + 1)
      refine ⟨n - 1, q, ⟨by omega, ?_, ?_⟩, rfl, ?_⟩
      · intro i hi
        exact hmem (i + 1) (by omega)
      · intro i hi
        simpa [q, Nat.add_assoc] using hstep (i + 1) (by omega)
      · change p (n - 1 + 1) = b
        have hindex : n - 1 + 1 = n := by omega
        rw [hindex, hpn]

/-- 一段関係と到達可能関係の被覆関係の等号。 -/
theorem oneStep_eq_covering (X : Set Event) (D : Set (Event × Event))
    (time : Event → Time) (lt : Time → Time → Prop)
    (hDX : D ⊆ X ×ˢ X)
    (lt_transitive : ∀ a b c, lt a b → lt b c → lt a c)
    (step_time_increases : ∀ a b, (a, b) ∈ D → lt (time a) (time b))
    (D_adjacent : ∀ a b, (a, b) ∈ D → ∀ t, lt (time a) t → lt t (time b) → False) :
    D = Covering X (Reachable X D) := by
  ext ⟨a, b⟩
  constructor
  · intro h
    refine oneStep_subset_covering X D (Reachable X D) time lt
      (oneStep_subset_reachable X D hDX) ?_ D_adjacent a b h
    rintro x y ⟨n, p, hpath, hp0, hpn⟩
    have := path_time_strictly_increases X D time lt lt_transitive step_time_increases n p hpath
    simpa [hp0, hpn] using this
  · intro h
    exact covering_subset_oneStep X D a b h

/-- 一段関係が空なら、反射的到達可能関係は X 上の等号に一致する。 -/
theorem reflReachable_of_empty (X : Set Event) (D : Set (Event × Event)) (hD : D = ∅)
    (a b : Event) : (a, b) ∈ ReflReachable X D ↔ a ∈ X ∧ b ∈ X ∧ a = b := by
  constructor
  · rintro ⟨ha, hb, hab | ⟨n, p, ⟨hn, -, hstep⟩, -, -⟩⟩
    · exact ⟨ha, hb, hab⟩
    · have h01 := hstep 0 hn
      rw [hD] at h01
      simp at h01
  · rintro ⟨ha, hb, hab⟩
    exact ⟨ha, hb, Or.inl hab⟩

/-- 時刻を保存しない順序同型の反例。一段関係が空で、X に時刻の異なる二点があればよい。
    入れ替え写像の定義にイベントの等号判定だけを使う。 -/
theorem exists_order_equiv_not_time_preserving [DecidableEq Event]
    (X : Set Event) (D : Set (Event × Event)) (time : Event → Time) (hD : D = ∅)
    (a₀ a₁ : Event) (ha₀ : a₀ ∈ X) (ha₁ : a₁ ∈ X) (hne : time a₀ ≠ time a₁) :
    ∃ σ : Equiv.Perm Event,
      (∀ a b, a ∈ X → b ∈ X →
        ((a, b) ∈ ReflReachable X D ↔ (σ a, σ b) ∈ ReflReachable X D)) ∧
      (∃ a, a ∈ X ∧ time (σ a) ≠ time a) := by
  let σ : Equiv.Perm Event := Equiv.swap a₀ a₁
  have hσX : ∀ a, a ∈ X → σ a ∈ X := by
    intro a ha
    by_cases h0 : a = a₀
    · subst h0; simpa [σ] using ha₁
    by_cases h1 : a = a₁
    · subst h1; simpa [σ] using ha₀
    · simpa [σ, Equiv.swap_apply_of_ne_of_ne h0 h1] using ha
  refine ⟨σ, ?_, ?_⟩
  · intro a b ha hb
    rw [reflReachable_of_empty X D hD a b, reflReachable_of_empty X D hD (σ a) (σ b)]
    constructor
    · rintro ⟨-, -, hab⟩
      exact ⟨hσX a ha, hσX b hb, congrArg σ hab⟩
    · rintro ⟨-, -, hab⟩
      exact ⟨ha, hb, σ.injective hab⟩
  · refine ⟨a₀, ha₀, ?_⟩
    simpa [σ] using hne.symm

end CellularAutomata.NecSuf.CausalStructureComparison
