/-
章「依存の推移閉包の反対称性」の具体版。
人手証明の正本は structured-latex/content/transitive-closure-antisymmetry.ts。

人手証明のブロックとこのファイルの対応:

  依存経路（`def_dependency_path`）              `IsDepPath`（n ≥ 1、各 i ≤ n で p i ∈ E_τ、
                                                各 i < n で隣接対が D_τ に入る）
  claim_path_time_strictly_increases             `path_time_strictly_increases`
                                                （経路長 n についての帰納法。基底は前章
                                                `time_strictly_increases`、帰納段は制限と ℕ の推移性）
  到達可能関係 C_τ（`def_reachability`）         `Reachable`（依存経路の存在）と
                                                `reachable_subset_event_product`・`reachable_finite`
                                                （E_τ × E_τ の部分集合ゆえ有限、という定義中の注記）
  claim_one_step_subset_reachability             `oneStep_subset_reachable`（長さ 1 の経路）
  claim_reachability_transitive                  `reachable_transitive`（経路の連結。継ぎ目 i = m は
                                                p(m) = b = q(0) で well-defined）
  claim_reachability_minimal                     `reachable_minimal`（経路長についての帰納法で
                                                (p(0), p(n)) ∈ R を示す）
  claim_no_mutual_reachability                   `no_mutual_reachability`（時刻増加を両向きに使い、
                                                ℕ の推移性と非反射性で矛盾）
  claim_reachability_irreflexive                 `reachable_irreflexive`（b := a の特例）
  反射的到達可能関係 ⪯_τ（`def_reflexive_reachability`）  `ReflReachable`（E_τ × E_τ の元で
                                                a = b または (a,b) ∈ C_τ）
  部分順序（`def_partial_order`）                `IsPartialOrderOn`（反射・反対称・推移の 3 条件）
  claim_reachability_partial_order               `reflReachable_partial_order`
                                                （反射は a = a、反対称は相互到達の不存在、
                                                推移は人手証明と同じ 4 つの場合分け）

住処: 有限型・自然数のみ。ℝ / ℂ は現れない（人手証明と同じ）。時間に使う ℕ の構造は
大小比較と後者（+1）だけである（人手証明と同じ）。

抽象度は人手証明に固定する。使う mathlib の補題は、人手証明が根拠に挙げる初等的事実
（ℕ の大小比較の推移性・非反射性、有限集合の直積と部分集合の有限性）に限る。
-/
import CellularAutomata.TimeExpansionDependency

namespace CellularAutomata.TransitiveClosureAntisymmetry

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency

/-
有限舞台 (V, N) と有限舞台上の 2 値セルオートマトン (f_v)（前章と同じ設定）。
-/
variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 依存経路（`def_dependency_path`）。n ≥ 1 と写像 p:[0,n] → E_τ であって、
    すべての i ∈ [0,n-1] で (p(i), p(i+1)) ∈ D_τ を満たすもの。
    写像は ℕ 上の写像で表し、使う範囲 [0,n] の所属条件を `mem_eventSet` が持つ
    （定義域 [0,n] と E_τ はいずれも有限集合である）。 -/
structure IsDepPath (τ n : ℕ) (p : ℕ → ℕ × V) : Prop where
  one_le : 1 ≤ n
  mem_eventSet : ∀ i ≤ n, p i ∈ eventSet τ
  step : ∀ i < n, (p i, p (i + 1)) ∈ oneStepDep N f τ

/-- `claim_path_time_strictly_increases` の具体版。依存経路の始点の時刻は終点の時刻より
    小さい。人手証明と同じく経路長 n についての帰納法で示す。基底（n = 1）は前章
    `time_strictly_increases`、帰納段は [0,n-1] への制限（p 自身と長さ n-1）に帰納法の
    仮定を使い、最後の一段に `time_strictly_increases`、そして ℕ の大小比較の推移性。 -/
theorem path_time_strictly_increases (τ n : ℕ) (p : ℕ → ℕ × V)
    (hpath : IsDepPath N f τ n p) : (p 0).1 < (p n).1 := by
  obtain ⟨hn, -, hstep⟩ := hpath
  induction n with
  | zero => omega
  | succ m ih =>
    by_cases hm : m = 0
    · -- 基底（n = 1）: (p(0), p(1)) ∈ D_τ と前章の時刻増加
      subst hm
      exact time_strictly_increases N f τ (p 0).1 (p 1).1 (p 0).2 (p 1).2
        (hstep 0 Nat.one_pos)
    · -- 帰納段（n ≥ 2）: [0,m] への制限は長さ m の依存経路
      have h1 : 1 ≤ m := Nat.one_le_iff_ne_zero.mpr hm
      have h0m : (p 0).1 < (p m).1 :=
        ih h1 (fun i hi => hstep i (Nat.lt_succ_of_lt hi))
      have hlast : (p m).1 < (p (m + 1)).1 :=
        time_strictly_increases N f τ (p m).1 (p (m + 1)).1 (p m).2 (p (m + 1)).2
          (hstep m (Nat.lt_succ_self m))
      -- ℕ の大小比較の推移性
      exact Nat.lt_trans h0m hlast

/-- 到達可能関係 C_τ（`def_reachability`）。始点から終点への依存経路が存在する組の集合。 -/
def Reachable (τ : ℕ) : Set ((ℕ × V) × (ℕ × V)) :=
  { ab | ∃ (n : ℕ) (p : ℕ → ℕ × V),
      IsDepPath N f τ n p ∧ p 0 = ab.1 ∧ p n = ab.2 }

/-- `def_reachability` の注記の前半: C_τ ⊆ E_τ × E_τ（経路の値は E_τ に属するので、
    始点・終点も E_τ に属する）。 -/
theorem reachable_subset_event_product (τ : ℕ) :
    Reachable N f τ ⊆ ↑(eventSet (V := V) τ ×ˢ eventSet (V := V) τ) := by
  rintro ⟨a, b⟩ ⟨n, p, ⟨hn, hmem, -⟩, hp0, hpn⟩
  exact Finset.mem_coe.mpr (Finset.mem_product.mpr
    ⟨hp0 ▸ hmem 0 (Nat.zero_le n), hpn ▸ hmem n (le_refl n)⟩)

/-- `def_reachability` の注記の後半: C_τ は有限集合 E_τ × E_τ の部分集合なので有限である。 -/
theorem reachable_finite (τ : ℕ) : (Reachable N f τ).Finite :=
  Set.Finite.subset (Finset.finite_toSet _) (reachable_subset_event_product N f τ)

/-- `claim_one_step_subset_reachability` の具体版。D_τ ⊆ C_τ。
    (a,b) ∈ D_τ に対し n := 1、p(0) := a、p(1) := b と置くと長さ 1 の依存経路になる。 -/
theorem oneStep_subset_reachable (τ : ℕ) (a b : ℕ × V)
    (h : (a, b) ∈ oneStepDep N f τ) : (a, b) ∈ Reachable N f τ := by
  -- 両イベントが E_τ に属することは D_τ ⊆ E_τ × E_τ（前章 `oneStepDep_subset`）による。
  have hE := Finset.mem_product.mp (oneStepDep_subset N f τ h)
  refine ⟨1, fun i => if i = 0 then a else b, ⟨le_refl 1, ?_, ?_⟩, by simp, by simp⟩
  · intro i hi
    rcases Nat.le_one_iff_eq_zero_or_eq_one.mp hi with rfl | rfl
    · simpa using hE.1
    · simpa using hE.2
  · intro i hi
    have hi0 : i = 0 := by omega
    subst hi0
    simpa using h

/-- `claim_reachability_transitive` の具体版。経路の連結。
    a から b への長さ m の経路 p と b から c への長さ n の経路 q に対し、
    r(i) := p(i)（i ≤ m）、q(i−m)（i > m）と定める。i = m では p(m) = b = q(0) なので
    二つの場合は一致する（well-defined 性の対応物は継ぎ目の等式 `hjoin` である）。 -/
theorem reachable_transitive (τ : ℕ) (a b c : ℕ × V)
    (hab : (a, b) ∈ Reachable N f τ) (hbc : (b, c) ∈ Reachable N f τ) :
    (a, c) ∈ Reachable N f τ := by
  obtain ⟨m, p, ⟨hm, hpmem, hpstep⟩, hp0, hpm⟩ := hab
  obtain ⟨n, q, ⟨hn, hqmem, hqstep⟩, hq0, hqn⟩ := hbc
  -- 継ぎ目: p(m) = b = q(0)
  have hjoin : p m = q 0 := by rw [hpm, hq0]
  -- 連結写像 r
  set r : ℕ → ℕ × V := fun i => if i ≤ m then p i else q (i - m) with hr
  have hr_le : ∀ i, i ≤ m → r i = p i := fun i hi => by simp [hr, hi]
  have hr_gt : ∀ i, m < i → r i = q (i - m) := fun i hi => by
    simp [hr, Nat.not_le.mpr hi]
  refine ⟨m + n, r, ⟨by omega, ?_, ?_⟩, ?_, ?_⟩
  · -- 各 i ≤ m+n で r(i) ∈ E_τ
    intro i hi
    by_cases him : i ≤ m
    · rw [hr_le i him]; exact hpmem i him
    · rw [hr_gt i (Nat.not_le.mp him)]
      exact hqmem (i - m) (by omega)
  · -- 各 i < m+n で (r(i), r(i+1)) ∈ D_τ
    intro i hi
    by_cases him : i < m
    · -- i ≤ m−1 の場合: p の隣接対（(m,p) が依存経路であることによる）
      rw [hr_le i (Nat.le_of_lt him), hr_le (i + 1) him]
      exact hpstep i him
    · -- i ≥ m の場合: q の隣接対（(n,q) が依存経路であることによる）
      have him' : m ≤ i := Nat.not_lt.mp him
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
  · -- r(0) = p(0) = a
    rw [hr_le 0 (Nat.zero_le m)]; exact hp0
  · -- r(m+n) = q(n) = c（n ≥ 1 より m+n > m）
    rw [hr_gt (m + n) (by omega), Nat.add_sub_cancel_left]; exact hqn

/-- `claim_reachability_minimal` の具体版。D_τ を含む推移的な R ⊆ E_τ × E_τ は C_τ を含む。
    人手証明と同じく「長さ n の任意の依存経路について (p(0), p(n)) ∈ R」を n についての
    帰納法で示す。R ⊆ E_τ × E_τ は人手証明の主張どおり仮定に置く（帰納法の中では使わない）。 -/
theorem reachable_minimal (τ : ℕ) (R : Set ((ℕ × V) × (ℕ × V)))
    (_hRE : R ⊆ ↑(eventSet (V := V) τ ×ˢ eventSet (V := V) τ))
    (hRtrans : ∀ x y z : ℕ × V, (x, y) ∈ R → (y, z) ∈ R → (x, z) ∈ R)
    (hDR : ∀ ab ∈ oneStepDep N f τ, ab ∈ R) :
    Reachable N f τ ⊆ R := by
  -- 長さ n の任意の依存経路について (p(0), p(n)) ∈ R
  have key : ∀ (n : ℕ), 1 ≤ n → ∀ p : ℕ → ℕ × V,
      (∀ i < n, (p i, p (i + 1)) ∈ oneStepDep N f τ) → (p 0, p n) ∈ R := by
    intro n
    induction n with
    | zero => omega
    | succ m ih =>
      intro _ p hstep
      by_cases hm : m = 0
      · -- 基底（n = 1）: (p(0), p(1)) ∈ D_τ ⊆ R
        subst hm
        exact hDR _ (hstep 0 Nat.one_pos)
      · -- 帰納段（n ≥ 2）: 制限に帰納法の仮定、最後の一段に D_τ ⊆ R、R の推移性
        have h1 : 1 ≤ m := Nat.one_le_iff_ne_zero.mpr hm
        have hR0 : (p 0, p m) ∈ R :=
          ih h1 p (fun i hi => hstep i (Nat.lt_succ_of_lt hi))
        have hRm : (p m, p (m + 1)) ∈ R := hDR _ (hstep m (Nat.lt_succ_self m))
        exact hRtrans _ _ _ hR0 hRm
  rintro ⟨a, b⟩ ⟨n, p, ⟨hn, -, hstep⟩, hp0, hpn⟩
  have h := key n hn p hstep
  rw [hp0, hpn] at h
  exact h

/-- `claim_no_mutual_reachability` の具体版。(a,b) ∈ C_τ かつ (b,a) ∈ C_τ は起きない。
    時刻増加（`path_time_strictly_increases`）を両向きに使い、ℕ の大小比較の推移性で
    s < s を得て、非反射性で矛盾する。 -/
theorem no_mutual_reachability (τ : ℕ) (a b : ℕ × V)
    (hab : (a, b) ∈ Reachable N f τ) (hba : (b, a) ∈ Reachable N f τ) : False := by
  have h1 : a.1 < b.1 := by
    obtain ⟨n, p, hpath, hp0, hpn⟩ := hab
    have h := path_time_strictly_increases N f τ n p hpath
    rw [hp0, hpn] at h
    exact h
  have h2 : b.1 < a.1 := by
    obtain ⟨n, p, hpath, hp0, hpn⟩ := hba
    have h := path_time_strictly_increases N f τ n p hpath
    rw [hp0, hpn] at h
    exact h
  -- ℕ の大小比較の推移性より a.1 < a.1、非反射性に矛盾
  exact Nat.lt_irrefl a.1 (Nat.lt_trans h1 h2)

/-- `claim_reachability_irreflexive` の具体版。(a,a) ∈ C_τ は起きない
    （b := a と置いた `no_mutual_reachability` の特例）。 -/
theorem reachable_irreflexive (τ : ℕ) (a : ℕ × V)
    (h : (a, a) ∈ Reachable N f τ) : False :=
  no_mutual_reachability N f τ a a h h

/-- 反射的到達可能関係 ⪯_τ（`def_reflexive_reachability`）。E_τ × E_τ の元 (a,b) のうち
    a = b（直積の元の等号）または (a,b) ∈ C_τ を満たすもの。 -/
def ReflReachable (τ : ℕ) : Set ((ℕ × V) × (ℕ × V)) :=
  { ab | ab.1 ∈ eventSet τ ∧ ab.2 ∈ eventSet τ ∧
      (ab.1 = ab.2 ∨ ab ∈ Reachable N f τ) }

/-- 部分順序（`def_partial_order`）。有限集合 X ⊆ ℕ × V と関係 R に対する
    反射性・反対称性・推移性の 3 条件の連言。 -/
def IsPartialOrderOn (X : Finset (ℕ × V)) (R : Set ((ℕ × V) × (ℕ × V))) : Prop :=
  (∀ x ∈ X, (x, x) ∈ R) ∧
    (∀ x y : ℕ × V, (x, y) ∈ R → (y, x) ∈ R → x = y) ∧
    (∀ x y z : ℕ × V, (x, y) ∈ R → (y, z) ∈ R → (x, z) ∈ R)

/-- `claim_reachability_partial_order` の具体版。⪯_τ は E_τ 上の部分順序である。
    反射性は a = a、反対称性は相互到達の不存在（`no_mutual_reachability`）、
    推移性は人手証明と同じ 4 つの場合分け（等しい元の置き換え 3 通りと
    `reachable_transitive`）。 -/
theorem reflReachable_partial_order (τ : ℕ) :
    IsPartialOrderOn (eventSet (V := V) τ) (ReflReachable N f τ) := by
  refine ⟨?_, ?_, ?_⟩
  · -- 反射性: a = a
    intro a ha
    exact ⟨ha, ha, Or.inl rfl⟩
  · -- 反対称性: a ≠ b と仮定すると相互到達となり矛盾
    rintro a b ⟨-, -, hab⟩ ⟨-, -, hba⟩
    rcases hab with heq | hab
    · exact heq
    rcases hba with heq | hba
    · exact heq.symm
    exact (no_mutual_reachability N f τ a b hab hba).elim
  · -- 推移性: 4 つの場合分け
    rintro a b c ⟨ha, -, hab⟩ ⟨-, hc, hbc⟩
    have hab' : a = b ∨ (a, b) ∈ Reachable N f τ := hab
    have hbc' : b = c ∨ (b, c) ∈ Reachable N f τ := hbc
    refine ⟨ha, hc, ?_⟩
    show a = c ∨ (a, c) ∈ Reachable N f τ
    rcases hab' with rfl | hab'
    · rcases hbc' with rfl | hbc'
      · -- a = b かつ b = c
        exact Or.inl rfl
      · -- a = b かつ (b,c) ∈ C_τ（等しい元の置き換え）
        exact Or.inr hbc'
    · rcases hbc' with rfl | hbc'
      · -- (a,b) ∈ C_τ かつ b = c（等しい元の置き換え）
        exact Or.inr hab'
      · -- (a,b) ∈ C_τ かつ (b,c) ∈ C_τ: `claim_reachability_transitive`
        exact Or.inr (reachable_transitive N f τ a b c hab' hbc')

end CellularAutomata.TransitiveClosureAntisymmetry
