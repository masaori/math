/-
章「同型の証明」の、空集合の位置の行列単位についての三つの主張の証明が置く P_M の元・条件と、その所属の同値。
ℂ を含まないので、具体版 `VacuumMatrixUnit.lean` と必要十分版 `NecSuf/Isomorphism/CreationOperatorMatrices/VacuumMatrixUnit.lean`
が同じこのファイルを引く（必要十分版・導出版は置かない）。

  本文のラベル                                                                           このファイル
  claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit    emptyIndexSet（主張の ∅ ∈ P_M）・
                                                                                         unionSingleton_eq_cond_iff（i ∉ U のときの
                                                                                         c_i の (U∪{i},T) 成分の条件と T = U の同値）・
                                                                                         vacuumCond（C_m(S,U)）・vacuumCond_succ_iff・
                                                                                         vacuumCond_zero_iff・vacuumCond_last_iff
  claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit           addSelectedUpTo（R^{⟨m⟩}）・
                                                                                         addSelectedUpTo_zero・addSelectedUpTo_succ_of_mem・
                                                                                         addSelectedUpTo_succ_of_not_mem・
                                                                                         addSelectedUpTo_last_empty
  claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices
                                                                                         selectedFrom（T^{⟨m⟩}）・selectedFrom_zero・
                                                                                         selectedFrom_ge・selectedFrom_succ_of_mem・
                                                                                         selectedFrom_succ_of_not_mem・selectedFrom_last

表し方:
- 本文の帰納法の段 m ∈ {1,…,M}（m - 1 からの段）は、Lean では m + 1（m + 1 ≤ M）と書く。
- 本文が「P_M の元の等しさ」（def_power_set_of_first_m_positive_integers）で示す集合の等号は `PowerSet.ext` で、
  所属の同値を {1,…,M} の各 t について示す。
- 主張の後半の (⋆) の場合分けで使う「m ∈ X かつ X' = R なら X = R ∪ {m}」「m ∉ R、X' ≠ R なら X ≠ R ∪ {m}」は、
  既存の `unionSingleton_cond_iff_eq_removeIndex`（`IndexSetOperations.lean`）で引く。
-/
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.IndexSetOperations

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-! ### 空集合 -/

/-- 本文の ∅ ∈ P_M：∅ ⊆ {1,…,M}。 -/
def emptyIndexSet (M : ℕ) : PowerSet M := ⟨∅, fun t ht => absurd ht (Set.notMem_empty t)⟩

/-- ∅ は元を持たない。 -/
theorem notMem_emptyIndexSet (M t : ℕ) : t ∉ (emptyIndexSet M).1 := Set.notMem_empty t

/-! ### 消滅作用素の行列と生成作用素の行列の積 -/

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit` の準備の一つ目：
i ∉ U なら、c_i の (U ∪ {i}, T) 成分の条件「i ∉ T かつ U ∪ {i} = T ∪ {i}」は T = U と同値。 -/
theorem unionSingleton_eq_cond_iff {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) {U : PowerSet M} (hiU : i ∉ U.1)
    (T : PowerSet M) :
    (i ∉ T.1 ∧ unionSingleton U i hi = unionSingleton T i hi) ↔ T = U := by
  constructor
  · rintro ⟨hiT, hUT⟩
    apply PowerSet.ext
    intro t _ _
    by_cases hti : t = i
    · -- t = i なら、i ∉ T と i ∉ U から、t ∈ T と t ∈ U はどちらも成り立たない
      rw [hti]
      exact ⟨fun h => absurd h hiT, fun h => absurd h hiU⟩
    · -- t ≠ i なら、t ∈ T と t ∈ T ∪ {i} と t ∈ U ∪ {i} と t ∈ U は同値
      rw [← mem_unionSingleton_iff_of_ne T i hi t hti, ← hUT, mem_unionSingleton_iff_of_ne U i hi t hti]
  · intro hTU
    rw [hTU]
    exact ⟨hiU, rfl⟩

/-- 本文の条件 C_m(S,U)：S = U かつ、t ∈ S を満たす t ∈ {1,…,m} が無い。 -/
def vacuumCond {M : ℕ} (m : ℕ) (S U : PowerSet M) : Prop :=
  S = U ∧ ∀ t : ℕ, 1 ≤ t → t ≤ m → t ∉ S.1

/-- 本文の準備の二つ目の前半：C_m(S,U) は「C_{m-1}(S,U) かつ m ∉ U」と同値（m を m + 1 と書く）。 -/
theorem vacuumCond_succ_iff {M : ℕ} (m : ℕ) (S U : PowerSet M) :
    vacuumCond (m + 1) S U ↔ vacuumCond m S U ∧ m + 1 ∉ U.1 := by
  constructor
  · rintro ⟨hSU, h⟩
    -- {1,…,m-1} ⊆ {1,…,m} なので C_{m-1}(S,U)。m ∈ {1,…,m} なので m ∉ S、S = U から m ∉ U
    refine ⟨⟨hSU, fun t ht1 htm => h t ht1 (by omega)⟩, ?_⟩
    rw [← hSU]
    exact h (m + 1) (by omega) (le_refl _)
  · rintro ⟨⟨hSU, h⟩, hmU⟩
    refine ⟨hSU, fun t ht1 htm => ?_⟩
    by_cases htm' : t ≤ m
    · exact h t ht1 htm'
    · -- t = m なら m ∉ U = S
      have htm'' : t = m + 1 := by omega
      rw [htm'', hSU]
      exact hmU

/-- 本文の帰納法の m = 0 の段：{1,…,0} は空集合なので、C_0(S,U) は S = U と同値。 -/
theorem vacuumCond_zero_iff {M : ℕ} (S U : PowerSet M) : vacuumCond 0 S U ↔ S = U := by
  constructor
  · rintro ⟨hSU, _⟩
    exact hSU
  · intro hSU
    exact ⟨hSU, fun t ht1 ht0 => absurd ht1 (by omega)⟩

/-- 本文の後半：C_M(S,U) は「S = ∅ かつ U = ∅」と同値。 -/
theorem vacuumCond_last_iff {M : ℕ} (S U : PowerSet M) :
    vacuumCond M S U ↔ S = emptyIndexSet M ∧ U = emptyIndexSet M := by
  constructor
  · rintro ⟨hSU, h⟩
    -- すべての t ∈ {1,…,M} で t ∉ S かつ t ∉ ∅ なので S = ∅
    have hS : S = emptyIndexSet M := PowerSet.ext fun t ht1 htM =>
      ⟨fun ht => absurd ht (h t ht1 htM), fun ht => absurd ht (notMem_emptyIndexSet M t)⟩
    exact ⟨hS, hSU.symm.trans hS⟩
  · rintro ⟨hS, hU⟩
    -- S = U であり、t ∈ S を満たす t は無い
    refine ⟨hS.trans hU.symm, fun t _ _ ht => ?_⟩
    rw [hS] at ht
    exact notMem_emptyIndexSet M t ht

/-! ### 部分集合の元の番号の生成作用素の行列の積 -/

/-- 本文の R^{⟨m⟩} := {t ∈ {1,…,M} : t ∈ R であるか、または t ∈ S かつ t ≤ m}。R^{⟨m⟩} ⊆ {1,…,M} なので R^{⟨m⟩} ∈ P_M。 -/
def addSelectedUpTo {M : ℕ} (S : PowerSet M) (m : ℕ) (R : PowerSet M) : PowerSet M :=
  ⟨{t : ℕ | (1 ≤ t ∧ t ≤ M) ∧ (t ∈ R.1 ∨ (t ∈ S.1 ∧ t ≤ m))}, fun _ ht => ht.1⟩

/-- t ∈ R^{⟨m⟩} は「t ∈ {1,…,M} かつ（t ∈ R、または t ∈ S かつ t ≤ m）」（R^{⟨m⟩} の置き方）。 -/
theorem mem_addSelectedUpTo_iff {M : ℕ} (S : PowerSet M) (m : ℕ) (R : PowerSet M) (t : ℕ) :
    t ∈ (addSelectedUpTo S m R).1 ↔ (1 ≤ t ∧ t ≤ M) ∧ (t ∈ R.1 ∨ (t ∈ S.1 ∧ t ≤ m)) :=
  Iff.rfl

/-- 本文の帰納法の m = 0 の段：t ≤ 0 を満たす t ∈ {1,…,M} は無いので R^{⟨0⟩} = R。 -/
theorem addSelectedUpTo_zero {M : ℕ} (S R : PowerSet M) : addSelectedUpTo S 0 R = R := by
  apply PowerSet.ext
  intro t ht1 htM
  rw [mem_addSelectedUpTo_iff]
  constructor
  · rintro ⟨_, h | h⟩
    · exact h
    · exact absurd h.2 (by omega)
  · intro h
    exact ⟨⟨ht1, htM⟩, Or.inl h⟩

/-- 本文の帰納法の段の m ∈ S の場合：(R ∪ {m})^{⟨m-1⟩} = R^{⟨m⟩}（m を m + 1 と書く）。 -/
theorem addSelectedUpTo_succ_of_mem {M m : ℕ} (hm : 1 ≤ m + 1 ∧ m + 1 ≤ M) (S R : PowerSet M)
    (hmS : m + 1 ∈ S.1) :
    addSelectedUpTo S m (unionSingleton R (m + 1) hm) = addSelectedUpTo S (m + 1) R := by
  apply PowerSet.ext
  intro t ht1 htM
  rw [mem_addSelectedUpTo_iff, mem_addSelectedUpTo_iff, mem_unionSingleton_iff]
  -- 「t ∈ R、または t = m、または t ∈ S かつ t ≤ m-1」は、m ∈ S なので「t ∈ R、または t ∈ S かつ t ≤ m」と同値
  constructor
  · rintro ⟨_, (h | h) | h⟩
    · exact ⟨⟨ht1, htM⟩, Or.inl h⟩
    · rw [h]
      exact ⟨hm, Or.inr ⟨hmS, le_refl _⟩⟩
    · exact ⟨⟨ht1, htM⟩, Or.inr ⟨h.1, by omega⟩⟩
  · rintro ⟨_, h | h⟩
    · exact ⟨⟨ht1, htM⟩, Or.inl (Or.inl h)⟩
    · by_cases htm : t = m + 1
      · exact ⟨⟨ht1, htM⟩, Or.inl (Or.inr htm)⟩
      · exact ⟨⟨ht1, htM⟩, Or.inr ⟨h.1, by omega⟩⟩

/-- 本文の帰納法の段の m ∉ S の場合：R^{⟨m-1⟩} = R^{⟨m⟩}（m を m + 1 と書く）。 -/
theorem addSelectedUpTo_succ_of_not_mem {M : ℕ} (m : ℕ) (S R : PowerSet M) (hmS : m + 1 ∉ S.1) :
    addSelectedUpTo S m R = addSelectedUpTo S (m + 1) R := by
  apply PowerSet.ext
  intro t ht1 htM
  rw [mem_addSelectedUpTo_iff, mem_addSelectedUpTo_iff]
  -- m ∉ S なので「t ∈ S かつ t ≤ m」は「t ∈ S かつ t ≤ m-1」と同値
  constructor
  · rintro ⟨_, h | h⟩
    · exact ⟨⟨ht1, htM⟩, Or.inl h⟩
    · exact ⟨⟨ht1, htM⟩, Or.inr ⟨h.1, by omega⟩⟩
  · rintro ⟨_, h | h⟩
    · exact ⟨⟨ht1, htM⟩, Or.inl h⟩
    · have htm : t ≠ m + 1 := fun h' => hmS (h' ▸ h.1)
      exact ⟨⟨ht1, htM⟩, Or.inr ⟨h.1, by omega⟩⟩

/-- 本文の後半：t ∈ ∅ は成り立たず t ≤ M は成り立つので、∅^{⟨M⟩} = S。 -/
theorem addSelectedUpTo_last_empty {M : ℕ} (S : PowerSet M) :
    addSelectedUpTo S M (emptyIndexSet M) = S := by
  apply PowerSet.ext
  intro t ht1 htM
  rw [mem_addSelectedUpTo_iff]
  constructor
  · rintro ⟨_, h | h⟩
    · exact absurd h (notMem_emptyIndexSet M t)
    · exact h.1
  · intro h
    exact ⟨⟨ht1, htM⟩, Or.inr ⟨h, htM⟩⟩

/-! ### 部分集合の元の番号の消滅作用素の行列の逆順の積 -/

/-- 本文の T^{⟨m⟩} := {t ∈ {1,…,M} : t ∈ T かつ t ≥ M + 1 - m}。T^{⟨m⟩} ⊆ {1,…,M} なので T^{⟨m⟩} ∈ P_M。 -/
def selectedFrom {M : ℕ} (T : PowerSet M) (m : ℕ) : PowerSet M :=
  ⟨{t : ℕ | (1 ≤ t ∧ t ≤ M) ∧ (t ∈ T.1 ∧ M + 1 - m ≤ t)}, fun _ ht => ht.1⟩

/-- t ∈ T^{⟨m⟩} は「t ∈ {1,…,M} かつ t ∈ T かつ t ≥ M + 1 - m」（T^{⟨m⟩} の置き方）。 -/
theorem mem_selectedFrom_iff {M : ℕ} (T : PowerSet M) (m t : ℕ) :
    t ∈ (selectedFrom T m).1 ↔ (1 ≤ t ∧ t ≤ M) ∧ (t ∈ T.1 ∧ M + 1 - m ≤ t) :=
  Iff.rfl

/-- 本文の帰納法の m = 0 の段：t ≥ M + 1 を満たす t ∈ {1,…,M} は無いので T^{⟨0⟩} = ∅。 -/
theorem selectedFrom_zero {M : ℕ} (T : PowerSet M) : selectedFrom T 0 = emptyIndexSet M := by
  apply PowerSet.ext
  intro t _ htM
  rw [mem_selectedFrom_iff]
  constructor
  · rintro ⟨_, _, h⟩
    exact absurd h (by omega)
  · intro h
    exact absurd h (notMem_emptyIndexSet M t)

/-- 本文の帰納法の段：s := M + 1 - m として、T^{⟨m-1⟩} のすべての元 t は t ≥ M + 1 - (m - 1) = s + 1 を満たす
（m を m + 1 と書く）。 -/
theorem selectedFrom_ge {M m : ℕ} (hmM : m + 1 ≤ M) (T : PowerSet M) :
    ∀ t : ℕ, t ∈ (selectedFrom T m).1 → (M + 1 - (m + 1)) + 1 ≤ t := by
  intro t ht
  have h := ((mem_selectedFrom_iff T m t).1 ht).2.2
  omega

/-- 本文の帰納法の段の s ∈ T の場合：T^{⟨m-1⟩} ∪ {s} = T^{⟨m⟩}（m を m + 1、s := M + 1 - (m + 1) と書く）。 -/
theorem selectedFrom_succ_of_mem {M m : ℕ} (hmM : m + 1 ≤ M)
    (hs : 1 ≤ M + 1 - (m + 1) ∧ M + 1 - (m + 1) ≤ M) (T : PowerSet M) (hsT : M + 1 - (m + 1) ∈ T.1) :
    unionSingleton (selectedFrom T m) (M + 1 - (m + 1)) hs = selectedFrom T (m + 1) := by
  apply PowerSet.ext
  intro t ht1 htM
  rw [mem_unionSingleton_iff, mem_selectedFrom_iff, mem_selectedFrom_iff]
  -- 「t ∈ T かつ t ≥ s」は「t ∈ T かつ t ≥ s + 1、または t ∈ T かつ t = s」と同値で、
  -- s ∈ T なのでそれは「t ∈ T^{⟨m-1⟩}、または t = s」と同値
  constructor
  · rintro (⟨_, h⟩ | h)
    · exact ⟨⟨ht1, htM⟩, h.1, by omega⟩
    · rw [h]
      exact ⟨hs, hsT, le_refl _⟩
  · rintro ⟨_, h⟩
    by_cases hts : t = M + 1 - (m + 1)
    · exact Or.inr hts
    · exact Or.inl ⟨⟨ht1, htM⟩, h.1, by omega⟩

/-- 本文の帰納法の段の s ∉ T の場合：T^{⟨m-1⟩} = T^{⟨m⟩}（m を m + 1、s := M + 1 - (m + 1) と書く）。 -/
theorem selectedFrom_succ_of_not_mem {M m : ℕ} (hmM : m + 1 ≤ M) (T : PowerSet M)
    (hsT : M + 1 - (m + 1) ∉ T.1) :
    selectedFrom T m = selectedFrom T (m + 1) := by
  apply PowerSet.ext
  intro t ht1 htM
  rw [mem_selectedFrom_iff, mem_selectedFrom_iff]
  -- s ∉ T なので「t ∈ T かつ t ≥ s」は「t ∈ T かつ t ≥ s + 1」と同値
  constructor
  · rintro ⟨_, h⟩
    exact ⟨⟨ht1, htM⟩, h.1, by omega⟩
  · rintro ⟨_, h⟩
    have hts : t ≠ M + 1 - (m + 1) := fun h' => hsT (h' ▸ h.1)
    exact ⟨⟨ht1, htM⟩, h.1, by omega⟩

/-- 本文の後半：t ∈ {1,…,M} について t ≥ 1 = M + 1 - M は成り立つので、T^{⟨M⟩} = T。 -/
theorem selectedFrom_last {M : ℕ} (T : PowerSet M) : selectedFrom T M = T := by
  apply PowerSet.ext
  intro t ht1 htM
  rw [mem_selectedFrom_iff]
  constructor
  · rintro ⟨_, h⟩
    exact h.1
  · intro h
    exact ⟨⟨ht1, htM⟩, h, by omega⟩

end CliffordMatrixIsomorphism.Isomorphism
