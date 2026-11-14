/-
章「同型の証明」の、部分集合のうち番号より小さい元を数える個数 N_i(T) と、その二つの主張。
ℂ を含まないので、具体版と必要十分版が同じこのファイルを引く（必要十分版は置かない）。
非負整数の偶奇による符号 ς(n) ∈ ℂ は `Sign.lean` に置く。

  本文のラベル                                                 このファイル
  def_count_of_subset_elements_below_index                     countBelow・countBelow_one・
                                                               countBelow_succ_succ_of_mem・countBelow_succ_succ_of_not_mem
  claim_count_below_index_after_adding_one_element             unionSingleton・mem_unionSingleton_iff_of_ne・
                                                               self_mem_unionSingleton・countBelow_unionSingleton
  claim_count_below_index_vanishes_without_smaller_elements    countBelow_eq_zero_of_forall_ge

表し方:
- 番号 i ∈ {1,…,M} は ℕ の元 i で表し、主張には 1 ≤ i と i ≤ M を仮定に置く（README の「番号付けた族は ℕ → V」と同じ約束）。
  `countBelow T` は ℕ → ℕ で、本文が定めない i = 0 と i > M での値は使わない（i = 0 では 0 とおく）。
- 本文の帰納法の段 i ∈ {2,…,M} は、Lean では i = k + 2（i - 1 = k + 1）と書く。
- 本文の i - 1 ∈ T の真偽による場合分けは、`Set ℕ` の所属の判定に Classical を使う（本文の「どちらか一方だけが成り立つ」）。
- T ∪ {j} は本文では二つの集合の和集合で、P_M の上の演算としては定めない。Lean では P_M の元を作るのに
  1 ≤ j ≤ M の証明が要るので、その証明を引数に取る写像 `unionSingleton T j hj`（台は T.1 ∪ {j}）に名前を付けて置く。
  生成作用素の行列の成分 (c_i)_{T∪{i},T} の行の添字もこれで作る。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.PowerSet

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open Classical in
/-- 本文 `def_count_of_subset_elements_below_index`：N_1(T) := 0、i ∈ {2,…,M} で
i - 1 ∈ T なら N_i(T) := N_{i-1}(T) + 1、i - 1 ∉ T なら N_i(T) := N_{i-1}(T)。
i = 0 の値は本文が定めず、使わない。 -/
noncomputable def countBelow {M : ℕ} (T : PowerSet M) : ℕ → ℕ
  | 0 => 0
  | 1 => 0
  | k + 2 => if k + 1 ∈ T.1 then countBelow T (k + 1) + 1 else countBelow T (k + 1)

/-- 本文 `def_count_of_subset_elements_below_index`：N_1(T) = 0。 -/
theorem countBelow_one {M : ℕ} (T : PowerSet M) : countBelow T 1 = 0 := rfl

/-- 本文 `def_count_of_subset_elements_below_index`：i = k + 2 で i - 1 = k + 1 ∈ T なら N_i(T) = N_{i-1}(T) + 1。 -/
theorem countBelow_succ_succ_of_mem {M : ℕ} (T : PowerSet M) (k : ℕ) (h : k + 1 ∈ T.1) :
    countBelow T (k + 2) = countBelow T (k + 1) + 1 := by
  rw [countBelow, if_pos h]

/-- 本文 `def_count_of_subset_elements_below_index`：i = k + 2 で i - 1 = k + 1 ∉ T なら N_i(T) = N_{i-1}(T)。 -/
theorem countBelow_succ_succ_of_not_mem {M : ℕ} (T : PowerSet M) (k : ℕ) (h : k + 1 ∉ T.1) :
    countBelow T (k + 2) = countBelow T (k + 1) := by
  rw [countBelow, if_neg h]

/-- 本文 `claim_count_below_index_after_adding_one_element` の準備：T ⊆ {1,…,M} と j ∈ {1,…,M} から
T ∪ {j} ⊆ {1,…,M} なので、T ∪ {j} ∈ P_M。 -/
def unionSingleton {M : ℕ} (T : PowerSet M) (j : ℕ) (hj : 1 ≤ j ∧ j ≤ M) : PowerSet M :=
  ⟨T.1 ∪ {j}, fun t ht => by
    rcases ht with ht | ht
    · exact T.2 t ht
    · -- t ∈ {j} は t = j（{j} の定義）
      have htj : t = j := ht
      rw [htj]
      exact hj⟩

/-- 本文 `claim_count_below_index_after_adding_one_element` の準備（⋆）：t ≠ j なら t ∈ T ∪ {j} と t ∈ T は同値
（和集合と {j} の定義）。 -/
theorem mem_unionSingleton_iff_of_ne {M : ℕ} (T : PowerSet M) (j : ℕ) (hj : 1 ≤ j ∧ j ≤ M) (t : ℕ)
    (htj : t ≠ j) : t ∈ (unionSingleton T j hj).1 ↔ t ∈ T.1 := by
  constructor
  · intro ht
    rcases ht with ht | ht
    · exact ht
    · -- t ∈ {j} は t = j（{j} の定義）
      exact absurd ht htj
  · intro ht
    exact Or.inl ht

/-- 本文 `claim_count_below_index_after_adding_one_element` の準備：j ∈ T ∪ {j}。 -/
theorem self_mem_unionSingleton {M : ℕ} (T : PowerSet M) (j : ℕ) (hj : 1 ≤ j ∧ j ≤ M) :
    j ∈ (unionSingleton T j hj).1 :=
  -- j ∈ {j} は j = j（{j} の定義）
  Or.inr rfl

/-- 本文 `claim_count_below_index_after_adding_one_element`：j ∈ {1,…,M}、j ∉ T なら、すべての i ∈ {1,…,M} で
N_i(T ∪ {j}) = N_i(T) + 1（j < i）、N_i(T ∪ {j}) = N_i(T)（j ≥ i）。
本文の場合分けの式を、二つの場合の組（∧）で書く。 -/
theorem countBelow_unionSingleton {M : ℕ} (T : PowerSet M) (j : ℕ) (hj : 1 ≤ j ∧ j ≤ M)
    (hjT : j ∉ T.1) :
    ∀ i : ℕ, 1 ≤ i → i ≤ M →
      (j < i → countBelow (unionSingleton T j hj) i = countBelow T i + 1)
        ∧ (i ≤ j → countBelow (unionSingleton T j hj) i = countBelow T i) := by
  intro i
  induction i with
  | zero => intro h1 _; omega
  | succ k ih =>
    intro _ hiM
    cases k with
    | zero =>
      -- i = 1 のとき。j ≥ 1 = i なので、示す等式は N_1(T ∪ {j}) = N_1(T)。
      refine ⟨fun hji => absurd hji (by omega), fun _ => ?_⟩
      calc countBelow (unionSingleton T j hj) 1
          = 0 := countBelow_one (unionSingleton T j hj)
        _ = countBelow T 1 := (countBelow_one T).symm
    | succ k =>
      -- i = k + 2 ∈ {2,…,M}。帰納法の仮定は i - 1 = k + 1 について。
      have ih' := ih (by omega) (by omega)
      rcases lt_trichotomy j (k + 1) with hlt | heq | hgt
      · -- j < i - 1 のとき。
        refine ⟨fun _ => ?_, fun hij => absurd hij (by omega)⟩
        have hIH : countBelow (unionSingleton T j hj) (k + 1) = countBelow T (k + 1) + 1 := ih'.1 hlt
        have hstar := mem_unionSingleton_iff_of_ne T j hj (k + 1) (by omega)
        by_cases hmem : k + 1 ∈ T.1
        · calc countBelow (unionSingleton T j hj) (k + 2)
              = countBelow (unionSingleton T j hj) (k + 1) + 1 :=
                countBelow_succ_succ_of_mem (unionSingleton T j hj) k (hstar.2 hmem)
            _ = (countBelow T (k + 1) + 1) + 1 := by rw [hIH]
            _ = countBelow T (k + 2) + 1 := by rw [countBelow_succ_succ_of_mem T k hmem]
        · calc countBelow (unionSingleton T j hj) (k + 2)
              = countBelow (unionSingleton T j hj) (k + 1) :=
                countBelow_succ_succ_of_not_mem (unionSingleton T j hj) k (fun h => hmem (hstar.1 h))
            _ = countBelow T (k + 1) + 1 := hIH
            _ = countBelow T (k + 2) + 1 := by rw [countBelow_succ_succ_of_not_mem T k hmem]
      · -- j = i - 1 のとき。
        refine ⟨fun _ => ?_, fun hij => absurd hij (by omega)⟩
        have hIH : countBelow (unionSingleton T j hj) (k + 1) = countBelow T (k + 1) := ih'.2 (by omega)
        have hmemU : k + 1 ∈ (unionSingleton T j hj).1 := by
          rw [← heq]
          exact self_mem_unionSingleton T j hj
        have hmem : k + 1 ∉ T.1 := by
          rw [← heq]
          exact hjT
        calc countBelow (unionSingleton T j hj) (k + 2)
            = countBelow (unionSingleton T j hj) (k + 1) + 1 :=
              countBelow_succ_succ_of_mem (unionSingleton T j hj) k hmemU
          _ = countBelow T (k + 1) + 1 := by rw [hIH]
          _ = countBelow T (k + 2) + 1 := by rw [countBelow_succ_succ_of_not_mem T k hmem]
      · -- j > i - 1、すなわち j ≥ i のとき。
        refine ⟨fun hji => absurd hji (by omega), fun _ => ?_⟩
        have hIH : countBelow (unionSingleton T j hj) (k + 1) = countBelow T (k + 1) := ih'.2 (by omega)
        have hstar := mem_unionSingleton_iff_of_ne T j hj (k + 1) (by omega)
        by_cases hmem : k + 1 ∈ T.1
        · calc countBelow (unionSingleton T j hj) (k + 2)
              = countBelow (unionSingleton T j hj) (k + 1) + 1 :=
                countBelow_succ_succ_of_mem (unionSingleton T j hj) k (hstar.2 hmem)
            _ = countBelow T (k + 1) + 1 := by rw [hIH]
            _ = countBelow T (k + 2) := (countBelow_succ_succ_of_mem T k hmem).symm
        · calc countBelow (unionSingleton T j hj) (k + 2)
              = countBelow (unionSingleton T j hj) (k + 1) :=
                countBelow_succ_succ_of_not_mem (unionSingleton T j hj) k (fun h => hmem (hstar.1 h))
            _ = countBelow T (k + 1) := hIH
            _ = countBelow T (k + 2) := (countBelow_succ_succ_of_not_mem T k hmem).symm

/-- 本文 `claim_count_below_index_vanishes_without_smaller_elements`：i ∈ {1,…,M} で、T のすべての元 t が
t ≥ i を満たすなら N_i(T) = 0。 -/
theorem countBelow_eq_zero_of_forall_ge {M : ℕ} (T : PowerSet M) :
    ∀ i : ℕ, 1 ≤ i → i ≤ M → (∀ t : ℕ, t ∈ T.1 → i ≤ t) → countBelow T i = 0 := by
  intro i
  induction i with
  | zero => intro h1 _ _; omega
  | succ k ih =>
    intro _ hiM hT
    cases k with
    | zero =>
      -- i = 1 のとき。T の元についての仮定を使わない。
      calc countBelow T 1
          = 0 := countBelow_one T
    | succ k =>
      -- i = k + 2 ∈ {2,…,M}。
      -- 準備（⋆）：T の各元 t は t ≥ i > i - 1 なので、帰納法の仮定から N_{i-1}(T) = 0。
      have hstar : countBelow T (k + 1) = 0 :=
        ih (by omega) (by omega) (fun t ht => by have := hT t ht; omega)
      -- 準備：i - 1 ∈ T なら i - 1 ≥ i となり矛盾するので、i - 1 ∉ T。
      have hmem : k + 1 ∉ T.1 := fun h => by have := hT (k + 1) h; omega
      calc countBelow T (k + 2)
          = countBelow T (k + 1) := countBelow_succ_succ_of_not_mem T k hmem
        _ = 0 := hstar

end CliffordMatrixIsomorphism.Isomorphism
