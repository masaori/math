/-
章「同型の証明」の、生成作用素の行列の成分の条件に現れる P_M の元の操作（T ∪ {j}・S' の所属、S' の定義）と、
条件どうしの同値。ℂ を含まないので、具体版と必要十分版が同じこのファイルを引く（必要十分版は置かない）。

  本文のラベル                                                        このファイル
  （和集合と {j} の定義・S' の置き方による所属の書き換え）              mem_unionSingleton_iff・mem_removeIndex_iff
  claim_entry_of_creation_operator_matrix_times_matrix                removeIndex（本文の S'）・
                                                                      unionSingleton_cond_iff_eq_removeIndex（準備の同値）
  claim_creation_operator_matrices_anticommute                        creationCond（条件 C_{k,l}(S,U)）・
                                                                      unionSingleton_comm・creationCond_comm（準備の同値）
  claim_creation_and_annihilation_operator_matrices_anticommute       notMem_removeIndex・unionSingleton_removeIndex（（♯））・
                                                                      cond1_iff_of_eq・cond2_iff_of_eq（i = j の場合の同値）・
                                                                      cond1_iff_of_ne・cond2_iff_of_ne（i ≠ j の場合の同値）

表し方:
- 本文の S' := {t ∈ {1,…,M} : t ∈ S かつ t ≠ i} は `removeIndex S i`（台は本文の式どおりの ℕ の部分集合）。
- 本文が「和集合と {j} の定義」「S' の置き方」「P_M の元の等しさ」で示す集合の同値は、所属の書き換え
  `mem_unionSingleton_iff`・`mem_removeIndex_iff`（どちらも定義による Iff.rfl）と `PowerSet.ext` で書く。
-/
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CountAndSign

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-- t ∈ T ∪ {j} は「t ∈ T または t = j」（和集合と {j} の定義）。 -/
theorem mem_unionSingleton_iff {M : ℕ} (T : PowerSet M) (j : ℕ) (hj : 1 ≤ j ∧ j ≤ M) (t : ℕ) :
    t ∈ (unionSingleton T j hj).1 ↔ t ∈ T.1 ∨ t = j :=
  Iff.rfl

/-- 本文 `claim_entry_of_creation_operator_matrix_times_matrix` の S' := {t ∈ {1,…,M} : t ∈ S かつ t ≠ i}。
S' ⊆ {1,…,M} なので S' ∈ P_M。 -/
def removeIndex {M : ℕ} (S : PowerSet M) (i : ℕ) : PowerSet M :=
  ⟨{t : ℕ | (1 ≤ t ∧ t ≤ M) ∧ (t ∈ S.1 ∧ t ≠ i)}, fun _ ht => ht.1⟩

/-- t ∈ S' は「t ∈ {1,…,M} かつ t ∈ S かつ t ≠ i」（S' の置き方）。 -/
theorem mem_removeIndex_iff {M : ℕ} (S : PowerSet M) (i t : ℕ) :
    t ∈ (removeIndex S i).1 ↔ (1 ≤ t ∧ t ≤ M) ∧ (t ∈ S.1 ∧ t ≠ i) :=
  Iff.rfl

/-- 本文 `claim_entry_of_creation_operator_matrix_times_matrix` の準備：i ∈ S なら、
c_i の条件「i ∉ T かつ S = T ∪ {i}」は T = S' と同値。 -/
theorem unionSingleton_cond_iff_eq_removeIndex {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) {S : PowerSet M}
    (hiS : i ∈ S.1) (T : PowerSet M) :
    (i ∉ T.1 ∧ S = unionSingleton T i hi) ↔ T = removeIndex S i := by
  constructor
  · rintro ⟨hiT, hS⟩
    apply PowerSet.ext
    intro t ht1 htM
    -- t ∈ S は「t ∈ T または t = i」と同値（S = T ∪ {i}）
    have hmemS : t ∈ S.1 ↔ t ∈ T.1 ∨ t = i := by rw [hS]; exact mem_unionSingleton_iff T i hi t
    rw [mem_removeIndex_iff]
    constructor
    · intro htT
      -- i ∉ T なので t ∈ T なら t ≠ i
      have hne : t ≠ i := fun h => hiT (h ▸ htT)
      exact ⟨⟨ht1, htM⟩, hmemS.2 (Or.inl htT), hne⟩
    · rintro ⟨_, htS, hne⟩
      rcases hmemS.1 htS with h | h
      · exact h
      · exact absurd h hne
  · intro hT
    constructor
    · -- S' の置き方で i ∉ S'
      rw [hT, mem_removeIndex_iff]
      exact fun h => h.2.2 rfl
    · apply PowerSet.ext
      intro t ht1 htM
      rw [mem_unionSingleton_iff, hT, mem_removeIndex_iff]
      constructor
      · intro htS
        by_cases hti : t = i
        · exact Or.inr hti
        · exact Or.inl ⟨⟨ht1, htM⟩, htS, hti⟩
      · rintro (h | h)
        · exact h.2.1
        · -- t = i なら i ∈ S から t ∈ S
          rw [h]
          exact hiS


/-- 本文 `claim_creation_operator_matrices_anticommute` の条件 C_{k,l}(S,U)：
k ∉ U かつ l ∉ U かつ k ≠ l かつ S = (U ∪ {l}) ∪ {k}。 -/
def creationCond {M k l : ℕ} (hk : 1 ≤ k ∧ k ≤ M) (hl : 1 ≤ l ∧ l ≤ M) (S U : PowerSet M) : Prop :=
  k ∉ U.1 ∧ l ∉ U.1 ∧ k ≠ l ∧ S = unionSingleton (unionSingleton U l hl) k hk

/-- 本文 `claim_creation_operator_matrices_anticommute` の準備：(U ∪ {j}) ∪ {i} = (U ∪ {i}) ∪ {j}。 -/
theorem unionSingleton_comm {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (hj : 1 ≤ j ∧ j ≤ M) (U : PowerSet M) :
    unionSingleton (unionSingleton U j hj) i hi = unionSingleton (unionSingleton U i hi) j hj := by
  apply PowerSet.ext
  intro t _ _
  rw [mem_unionSingleton_iff, mem_unionSingleton_iff, mem_unionSingleton_iff, mem_unionSingleton_iff]
  -- どちらも「t ∈ U または t = i または t = j」と同値
  constructor
  · rintro ((h | h) | h)
    · exact Or.inl (Or.inl h)
    · exact Or.inr h
    · exact Or.inl (Or.inr h)
  · rintro ((h | h) | h)
    · exact Or.inl (Or.inl h)
    · exact Or.inr h
    · exact Or.inl (Or.inr h)

/-- 本文 `claim_creation_operator_matrices_anticommute` の準備：C_{i,j}(S,U) と C_{j,i}(S,U) は同値。 -/
theorem creationCond_comm {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (hj : 1 ≤ j ∧ j ≤ M) (S U : PowerSet M) :
    creationCond hi hj S U ↔ creationCond hj hi S U := by
  constructor
  · rintro ⟨hiU, hjU, hij, hS⟩
    exact ⟨hjU, hiU, fun h => hij h.symm, hS.trans (unionSingleton_comm hi hj U)⟩
  · rintro ⟨hjU, hiU, hji, hS⟩
    exact ⟨hiU, hjU, fun h => hji h.symm, hS.trans (unionSingleton_comm hj hi U)⟩

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の準備：i ∉ S'（S' の置き方）。 -/
theorem notMem_removeIndex {M : ℕ} (S : PowerSet M) (i : ℕ) : i ∉ (removeIndex S i).1 :=
  fun h => ((mem_removeIndex_iff S i i).1 h).2.2 rfl

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の（♯）：i ∈ S なら S' ∪ {i} = S。 -/
theorem unionSingleton_removeIndex {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) {S : PowerSet M} (hiS : i ∈ S.1) :
    unionSingleton (removeIndex S i) i hi = S := by
  apply PowerSet.ext
  intro t ht1 htM
  rw [mem_unionSingleton_iff, mem_removeIndex_iff]
  -- 「（t ∈ S かつ t ≠ i）または t = i」は、i ∈ S なので t ∈ S と同値
  constructor
  · rintro (h | h)
    · exact h.2.1
    · rw [h]
      exact hiS
  · intro htS
    by_cases hti : t = i
    · exact Or.inr hti
    · exact Or.inl ⟨⟨ht1, htM⟩, htS, hti⟩

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の i = j の場合の準備：
D_1 は「i ∈ S かつ U = S」と同値。 -/
theorem cond1_iff_of_eq {M i : ℕ} (hj : 1 ≤ i ∧ i ≤ M) (S U : PowerSet M) :
    (i ∈ S.1 ∧ i ∉ (removeIndex S i).1 ∧ U = unionSingleton (removeIndex S i) i hj)
      ↔ (i ∈ S.1 ∧ U = S) := by
  constructor
  · rintro ⟨hiS, _, hU⟩
    exact ⟨hiS, hU.trans (unionSingleton_removeIndex hj hiS)⟩
  · rintro ⟨hiS, hU⟩
    exact ⟨hiS, notMem_removeIndex S i, hU.trans (unionSingleton_removeIndex hj hiS).symm⟩

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の i = j の場合の準備：
D_2 は「i ∉ S かつ U = S」と同値。 -/
theorem cond2_iff_of_eq {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (hj : 1 ≤ i ∧ i ≤ M) (S U : PowerSet M) :
    (i ∉ U.1 ∧ i ∉ S.1 ∧ unionSingleton U i hi = unionSingleton S i hj) ↔ (i ∉ S.1 ∧ U = S) := by
  constructor
  · rintro ⟨hiU, hiS, hUS⟩
    refine ⟨hiS, PowerSet.ext fun t _ _ => ?_⟩
    by_cases hti : t = i
    · -- t = i なら t ∉ U かつ t ∉ S
      rw [hti]
      exact ⟨fun h => absurd h hiU, fun h => absurd h hiS⟩
    · -- t ≠ i なら t ∈ U・t ∈ U ∪ {i}・t ∈ S ∪ {i}・t ∈ S は順に同値
      have hmem : t ∈ (unionSingleton U i hi).1 ↔ t ∈ (unionSingleton S i hj).1 := by rw [hUS]
      rw [mem_unionSingleton_iff, mem_unionSingleton_iff] at hmem
      constructor
      · intro htU
        rcases hmem.1 (Or.inl htU) with h | h
        · exact h
        · exact absurd h hti
      · intro htS
        rcases hmem.2 (Or.inl htS) with h | h
        · exact h
        · exact absurd h hti
  · rintro ⟨hiS, hU⟩
    refine ⟨?_, hiS, ?_⟩
    · rw [hU]
      exact hiS
    · rw [hU]

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の i ≠ j の場合の準備：
j ≠ i なら D_1 は D :=「i ∈ S かつ j ∉ S かつ U = S' ∪ {j}」と同値。 -/
theorem cond1_iff_of_ne {M i j : ℕ} (hj : 1 ≤ j ∧ j ≤ M) (hij : i ≠ j) (S U : PowerSet M) :
    (i ∈ S.1 ∧ j ∉ (removeIndex S i).1 ∧ U = unionSingleton (removeIndex S i) j hj)
      ↔ (i ∈ S.1 ∧ j ∉ S.1 ∧ U = unionSingleton (removeIndex S i) j hj) := by
  -- j ≠ i なので、j ∉ S' と j ∉ S は同値（S' の置き方）
  have hjS : j ∉ (removeIndex S i).1 ↔ j ∉ S.1 := by
    rw [mem_removeIndex_iff]
    constructor
    · intro h hjS
      exact h ⟨hj, hjS, fun h' => hij h'.symm⟩
    · intro h h'
      exact h h'.2.1
  rw [hjS]

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の i ≠ j の場合の準備：
D_2 は D :=「i ∈ S かつ j ∉ S かつ U = S' ∪ {j}」と同値。 -/
theorem cond2_iff_of_ne {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (hj : 1 ≤ j ∧ j ≤ M) (hij : i ≠ j)
    (S U : PowerSet M) :
    (i ∉ U.1 ∧ j ∉ S.1 ∧ unionSingleton U i hi = unionSingleton S j hj)
      ↔ (i ∈ S.1 ∧ j ∉ S.1 ∧ U = unionSingleton (removeIndex S i) j hj) := by
  constructor
  · rintro ⟨hiU, hjS, hUS⟩
    -- i ∈ U ∪ {i} = S ∪ {j} と i ≠ j から i ∈ S
    have hiS : i ∈ S.1 := by
      have h : i ∈ (unionSingleton S j hj).1 := by
        rw [← hUS]
        exact self_mem_unionSingleton U i hi
      rcases (mem_unionSingleton_iff S j hj i).1 h with h' | h'
      · exact h'
      · exact absurd h' hij
    refine ⟨hiS, hjS, PowerSet.ext fun t ht1 htM => ?_⟩
    have hmem : t ∈ (unionSingleton U i hi).1 ↔ t ∈ (unionSingleton S j hj).1 := by rw [hUS]
    rw [mem_unionSingleton_iff, mem_unionSingleton_iff] at hmem
    rw [mem_unionSingleton_iff, mem_removeIndex_iff]
    by_cases hti : t = i
    · -- t = i なら t ∉ U かつ t ∉ S' ∪ {j}（i ∉ S' と i ≠ j）
      rw [hti]
      constructor
      · intro h
        exact absurd h hiU
      · rintro (h | h)
        · exact absurd rfl h.2.2
        · exact absurd h hij
    · -- t ≠ i なら t ∈ U・t ∈ U ∪ {i}・t ∈ S ∪ {j}・「（t ∈ S かつ t ≠ i）または t = j」・t ∈ S' ∪ {j} は順に同値
      constructor
      · intro htU
        rcases hmem.1 (Or.inl htU) with h | h
        · exact Or.inl ⟨⟨ht1, htM⟩, h, hti⟩
        · exact Or.inr h
      · rintro (h | h)
        · rcases hmem.2 (Or.inl h.2.1) with h' | h'
          · exact h'
          · exact absurd h' hti
        · rcases hmem.2 (Or.inr h) with h' | h'
          · exact h'
          · exact absurd h' hti
  · rintro ⟨hiS, hjS, hU⟩
    refine ⟨?_, hjS, PowerSet.ext fun t _ _ => ?_⟩
    · -- i ∉ S' と i ≠ j から i ∉ S' ∪ {j} = U
      rw [hU, mem_unionSingleton_iff]
      rintro (h | h)
      · exact notMem_removeIndex S i h
      · exact hij h
    · -- t ∈ U ∪ {i} は「t ∈ S' ∪ {i} または t = j」と同値で、（♯）により t ∈ S ∪ {j} と同値
      have hsharp : t ∈ (unionSingleton (removeIndex S i) i hi).1 ↔ t ∈ S.1 := by
        rw [unionSingleton_removeIndex hi hiS]
      rw [mem_unionSingleton_iff] at hsharp
      rw [mem_unionSingleton_iff, mem_unionSingleton_iff, hU, mem_unionSingleton_iff]
      constructor
      · rintro ((h | h) | h)
        · exact Or.inl (hsharp.1 (Or.inl h))
        · exact Or.inr h
        · exact Or.inl (hsharp.1 (Or.inr h))
      · intro h
        rcases h with h | h
        · rcases hsharp.2 h with h' | h'
          · exact Or.inl (Or.inl h')
          · exact Or.inr h'
        · exact Or.inl (Or.inr h)

end CliffordMatrixIsomorphism.Isomorphism
