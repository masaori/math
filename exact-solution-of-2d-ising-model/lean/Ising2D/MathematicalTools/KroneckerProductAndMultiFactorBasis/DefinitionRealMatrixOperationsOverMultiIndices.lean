/-
# 実数の行列の全体 `Mat(m, n, ℝ)` と、実数の行列 `Mat(2^M, ℝ)` の積・実数のベクトルとの積・単位行列と、Lean の `Matrix (Conf M) (Conf M) ℝ` の演算（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`（`linear_space_general_definition_real_matrices`、ラベル **`def_real_matrices`**・
`linear_space_general_definition_real_matrix_product`、ラベル **`def_real_matrix_product`**・
`linear_space_general_definition_real_matrix_vector_product`、ラベル **`def_real_matrix_vector_product`**・
`linear_space_general_definition_real_identity_matrix`、ラベル **`def_real_identity_matrix`**）

人手の `Mat(m, n, ℝ)` は添字の集合の直積 `{1,…,m} × {1,…,n}` から `ℝ` への写像の全体（`def_real_matrices`）で、演算を成分の式で定める:
`(PQ)_{ik} := Σ_{j=1}^{n} P_{ij} Q_{jk}`、`(Px)_i := Σ_{j=1}^{n} P_{ij} x_j`、`(I_{Mat(n,ℝ)})_{st} := 1 (s = t)、0 (s ≠ t)`（添字の文字は本文どおり）。

Lean の `Matrix (Conf M) (Conf M) ℝ` は添字型が `𝓘_M`（Lean の `Conf M`）で、本文の `Mat(2^M, ℝ)` に当たる。演算は mathlib の行列の `*`・`*ᵥ`・`1` である。
人手の番号 `k ∈ {1,…,n}` と `ν^{-1}` の読み方は、係数が ℂ の場合（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）と同じで、
`ν^{-1}` は Lean の `σ : Fin n → Conf M` で、`ν(σ(k)) = finIndexToZZ n k` によって定まる（`exists_inverse_of_kronecker_numbering`）。
人手の成分 `P_{ij}` は Lean の `P (σ i) (σ j)`、実数のベクトル `x ∈ ℝ^n` の第 `j` 成分 `x_j` は Lean の `x (σ j)`（`x : Conf M → ℝ`）である。

- 行列の全体（`def_real_matrices`）: 二つの行列が等しいことと `ν^{-1}` で番号へ移した全ての成分が等しいことが同じで、番号の上の成分の割り当てが
  どれも行列になる（`realMatrix_conf_entries_by_kronecker_numbering`）。
- 積と、行列とベクトルの積は成分の式が番号の上の和なので、`ν^{-1}` で番号へ移した成分で書き、mathlib の積の成分（`𝓘_M` の上の和）を
  `def_finite_sum_of_real_numbers_over_multi_indices` で番号の上の和へ移す（`realMatrix_conf_mul_apply_eq_def_real_matrix_product`・
  `realMatrix_conf_mulVec_apply_eq_def_real_matrix_vector_product`）。証明の段が `𝓘_M` の元を添字に書くときのために、`𝓘_M` の上の和の形
  `realMatrix_conf_mul_apply`・`realMatrix_conf_mulVec_apply` もそこから導く。
- 単位行列は成分の式が番号の等号で場合を分けるので、`ν^{-1}` で番号へ移した成分が本文の二つの場合の値に等しいことを `ν^{-1}` の単射で示す
  （`realMatrix_conf_one_apply_eq_def_real_identity_matrix`）。`𝓘_M` の添字の形 `realMatrix_conf_one_apply` もそこから導く。

人手の本文は演算を定めるだけで、Lean の演算との一致の主張を持たない。補題は Lean だけの段であり、
定義の一致を述べる補題なので、必要十分版は置かない。人手の `M ∈ ℤ_{≥1}` に対し、Lean は `M = 0` も許す。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionKroneckerNumbering
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionFiniteSumOverMultiIndices

namespace Ising2D

open Matrix

/-- **`def_real_matrices`**（`Mat(2^M, ℝ)`）: Lean の `Matrix (Conf M) (Conf M) ℝ`（添字が多重添字の集合 `𝓘_M`）は、成分を `ν^{-1}` で
番号へ移すと本文の `Mat(n, ℝ)`（`n = 2^M`）と対応する（Lean だけの段の補題。冒頭の説明を見よ）。一つ目は、二つの行列が等しいことと
番号で読んだ全ての成分 `P (ν^{-1}(i)) (ν^{-1}(k))` が等しいことが同じであること、二つ目は、番号の上の成分の割り当て `C` がどれも行列の成分になることである。
`ν^{-1}` は `σ` で、`ν(σ(k)) = finIndexToZZ n k`（`exists_inverse_of_kronecker_numbering`）によって定まる。 -/
theorem realMatrix_conf_entries_by_kronecker_numbering (M : ℕ) :
    ∀ (n : ℕ), (∀ I : Conf M, ∃ k : Fin n, kroneckerNumbering I = finIndexToZZ n k) →
      ∀ (σ : Fin n → Conf M), (∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) →
        (∀ P Q : Matrix (Conf M) (Conf M) ℝ, P = Q ↔ ∀ i k : Fin n, P (σ i) (σ k) = Q (σ i) (σ k)) ∧
          ∀ C : Fin n → Fin n → ℝ, ∃ P : Matrix (Conf M) (Conf M) ℝ, ∀ i k : Fin n, P (σ i) (σ k) = C i k := by
  intro n hord σ hσ
  -- `σ` の単射は `finIndexToZZ n` の単射から（`finIndexToZZ_bijective_onto_index_set`）
  have hinj : ∀ k k' : Fin n, σ k = σ k' → k = k' := fun k k' h =>
    (finIndexToZZ_bijective_onto_index_set n).1 k k' (by rw [← hσ, ← hσ, h])
  -- `σ` の全射は `ν` の単射から（`kronecker_numbering_injective`）
  have hsurj : ∀ I : Conf M, ∃ k : Fin n, σ k = I := fun I => by
    obtain ⟨k, hk⟩ := hord I
    exact ⟨k, kronecker_numbering_injective _ _ (by rw [hσ, hk])⟩
  refine ⟨fun P Q => ⟨fun h i k => by rw [h], fun h => ?_⟩, fun C => ?_⟩
  · funext I K                                              -- 写像の等号は点ごと（`set_and_algebra_notation`）
    obtain ⟨i, rfl⟩ := hsurj I
    obtain ⟨k, rfl⟩ := hsurj K
    exact h i k
  · classical
    refine ⟨fun I K => C (Classical.choose (hsurj I)) (Classical.choose (hsurj K)), fun i k => ?_⟩
    show C (Classical.choose (hsurj (σ i))) (Classical.choose (hsurj (σ k))) = C i k
    rw [hinj _ _ (Classical.choose_spec (hsurj (σ i))), hinj _ _ (Classical.choose_spec (hsurj (σ k)))]

/-- **`def_real_matrix_product`**: Lean の `Matrix (Conf M) (Conf M) ℝ` の積の成分を `ν^{-1}` で番号へ移すと、本文の
`(PQ)_{ik} := Σ_{j=1}^{n} P_{ij} Q_{jk}`（`n = 2^M`）の右辺に等しい（Lean だけの段の補題。冒頭の説明を見よ）。mathlib の積の成分は
`𝓘_M`（Lean の `Conf M`）の上の和で、それを番号の上の和へ移すのは
`def_finite_sum_of_real_numbers_over_multi_indices`（`finset_sum_conf_real_eq_finite_sum_over_multi_indices`）である。 -/
theorem realMatrix_conf_mul_apply_eq_def_real_matrix_product (M : ℕ) :
    ∀ (n : ℕ), (∀ I : Conf M, ∃ k : Fin n, kroneckerNumbering I = finIndexToZZ n k) →
      ∀ (σ : Fin n → Conf M), (∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) →
        ∀ (P Q : Matrix (Conf M) (Conf M) ℝ) (i k : Fin n),
          (P * Q) (σ i) (σ k) = ∑ j : Fin n, P (σ i) (σ j) * Q (σ j) (σ k) := by
  intro n hord σ hσ P Q i k
  calc (P * Q) (σ i) (σ k)
      = ∑ J : Conf M, P (σ i) J * Q J (σ k) := Matrix.mul_apply  -- mathlib の行列の積の成分
    _ = ∑ j : Fin n, P (σ i) (σ j) * Q (σ j) (σ k) :=
        finset_sum_conf_real_eq_finite_sum_over_multi_indices M n hord σ hσ _
                                                            -- `def_finite_sum_of_real_numbers_over_multi_indices`

/-- **`def_real_matrix_product`**（`𝓘_M` の添字の形）: `Matrix (Conf M) (Conf M) ℝ` の積の成分は `(PQ)_{IK} = Σ_{J∈𝓘_M} P_{IJ} Q_{JK}` である。
`I = ν^{-1}(i)`・`K = ν^{-1}(k)` と書いて `realMatrix_conf_mul_apply_eq_def_real_matrix_product` で番号の上の和にし、
`def_finite_sum_of_real_numbers_over_multi_indices` で `𝓘_M` の上の和へ戻す（Lean だけの段。本文の和の添字を `𝓘_M` の元で書く証明の段が使う）。 -/
theorem realMatrix_conf_mul_apply {M : ℕ} (P Q : Matrix (Conf M) (Conf M) ℝ) (I K : Conf M) :
    (P * Q) I K = ∑ J : Conf M, P I J * Q J K := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- `ν^{-1}` の全射（`kronecker_numbering_injective`）: `I = σ(i)`・`K = σ(k)`
  obtain ⟨i, hi⟩ := hord I
  obtain ⟨k, hk⟩ := hord K
  have hI : σ i = I := kronecker_numbering_injective _ _ (by rw [hσ, hi])
  have hK : σ k = K := kronecker_numbering_injective _ _ (by rw [hσ, hk])
  subst hI hK
  calc (P * Q) (σ i) (σ k)
      = ∑ j : Fin n, P (σ i) (σ j) * Q (σ j) (σ k) :=
        realMatrix_conf_mul_apply_eq_def_real_matrix_product M n hord σ hσ P Q i k  -- `def_real_matrix_product`
    _ = ∑ J : Conf M, P (σ i) J * Q J (σ k) :=
        (finset_sum_conf_real_eq_finite_sum_over_multi_indices M n hord σ hσ
          (fun J => P (σ i) J * Q J (σ k))).symm
                                                            -- `def_finite_sum_of_real_numbers_over_multi_indices`

/-- **`def_real_matrix_vector_product`**: Lean の `Matrix (Conf M) (Conf M) ℝ` の行列と実数のベクトル `x : Conf M → ℝ` の積の成分を
`ν^{-1}` で番号へ移すと、本文の `(Px)_i := Σ_{j=1}^{n} P_{ij} x_j`（`n = 2^M`、`x ∈ ℝ^n` の第 `j` 成分 `x_j` が `x (ν^{-1}(j))`）の右辺に等しい
（Lean だけの段の補題。冒頭の説明を見よ）。mathlib の積の成分は `𝓘_M`（Lean の `Conf M`）の上の和で、それを番号の上の和へ移すのは
`def_finite_sum_of_real_numbers_over_multi_indices`（`finset_sum_conf_real_eq_finite_sum_over_multi_indices`）である。 -/
theorem realMatrix_conf_mulVec_apply_eq_def_real_matrix_vector_product (M : ℕ) :
    ∀ (n : ℕ), (∀ I : Conf M, ∃ k : Fin n, kroneckerNumbering I = finIndexToZZ n k) →
      ∀ (σ : Fin n → Conf M), (∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) →
        ∀ (P : Matrix (Conf M) (Conf M) ℝ) (x : Conf M → ℝ) (i : Fin n),
          (P *ᵥ x) (σ i) = ∑ j : Fin n, P (σ i) (σ j) * x (σ j) := by
  intro n hord σ hσ P x i
  calc (P *ᵥ x) (σ i)
      = ∑ J : Conf M, P (σ i) J * x J := rfl                -- mathlib の行列とベクトルの積の成分
    _ = ∑ j : Fin n, P (σ i) (σ j) * x (σ j) :=
        finset_sum_conf_real_eq_finite_sum_over_multi_indices M n hord σ hσ _
                                                            -- `def_finite_sum_of_real_numbers_over_multi_indices`

/-- **`def_real_matrix_vector_product`**（`𝓘_M` の添字の形）: `Matrix (Conf M) (Conf M) ℝ` の行列と実数のベクトルの積の成分は
`(Px)_I = Σ_{J∈𝓘_M} P_{IJ} x_J` である。`I = ν^{-1}(i)` と書いて `realMatrix_conf_mulVec_apply_eq_def_real_matrix_vector_product` で
番号の上の和にし、`def_finite_sum_of_real_numbers_over_multi_indices` で `𝓘_M` の上の和へ戻す（Lean だけの段。本文の和の添字を `𝓘_M` の元で書く証明の段が使う）。 -/
theorem realMatrix_conf_mulVec_apply {M : ℕ} (P : Matrix (Conf M) (Conf M) ℝ) (x : Conf M → ℝ) (I : Conf M) :
    (P *ᵥ x) I = ∑ J : Conf M, P I J * x J := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- `ν^{-1}` の全射（`kronecker_numbering_injective`）: `I = σ(i)`
  obtain ⟨i, hi⟩ := hord I
  have hI : σ i = I := kronecker_numbering_injective _ _ (by rw [hσ, hi])
  subst hI
  calc (P *ᵥ x) (σ i)
      = ∑ j : Fin n, P (σ i) (σ j) * x (σ j) :=
        realMatrix_conf_mulVec_apply_eq_def_real_matrix_vector_product M n hord σ hσ P x i
                                                            -- `def_real_matrix_vector_product`
    _ = ∑ J : Conf M, P (σ i) J * x J :=
        (finset_sum_conf_real_eq_finite_sum_over_multi_indices M n hord σ hσ
          (fun J => P (σ i) J * x J)).symm
                                                            -- `def_finite_sum_of_real_numbers_over_multi_indices`

/-- **`def_real_identity_matrix`**: Lean の `Matrix (Conf M) (Conf M) ℝ` の単位行列の成分 `1 (ν^{-1}(s)) (ν^{-1}(t))` は、本文の
`(I_{Mat(n,ℝ)})_{st}`（`n = 2^M`）の二つの場合の値に等しい: `s = t` なら `1`、`s ≠ t` なら `0`（Lean だけの段の補題。冒頭の説明を見よ）。
mathlib の単位行列の成分は `ν^{-1}(s) = ν^{-1}(t)` かどうかで決まり、`ν^{-1}` の単射によりそれは `s = t` かどうかと同じである。 -/
theorem realMatrix_conf_one_apply_eq_def_real_identity_matrix (M : ℕ) :
    ∀ (n : ℕ) (σ : Fin n → Conf M), (∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) →
      (∀ s : Fin n, (1 : Matrix (Conf M) (Conf M) ℝ) (σ s) (σ s) = 1) ∧
        ∀ s t : Fin n, s ≠ t → (1 : Matrix (Conf M) (Conf M) ℝ) (σ s) (σ t) = 0 := by
  intro n σ hσ
  refine ⟨fun s => Matrix.one_apply_eq _, fun s t hst => ?_⟩  -- `s = t`: mathlib の単位行列の対角成分
  -- `ν^{-1}` の単射: `ν(ν^{-1}(s)) = finIndexToZZ n s` と `finIndexToZZ n` の単射から
  have hσst : σ s ≠ σ t := fun h =>
    hst ((finIndexToZZ_bijective_onto_index_set n).1 s t (by rw [← hσ, ← hσ, h]))
  exact Matrix.one_apply_ne hσst                            -- `s ≠ t`: mathlib の単位行列の対角でない成分

/-- **`def_real_identity_matrix`**（`𝓘_M` の添字の形）: `Matrix (Conf M) (Conf M) ℝ` の単位行列の成分は、`I = K` なら `1`、`I ≠ K` なら `0` である。
`I = ν^{-1}(s)`・`K = ν^{-1}(t)` と書いて `realMatrix_conf_one_apply_eq_def_real_identity_matrix` を当てる（`ν^{-1}(s) ≠ ν^{-1}(t)` なら `s ≠ t`）
（Lean だけの段。本文の添字を `𝓘_M` の元で書く証明の段が使う）。 -/
theorem realMatrix_conf_one_apply {M : ℕ} :
    (∀ I : Conf M, (1 : Matrix (Conf M) (Conf M) ℝ) I I = 1) ∧
      ∀ I K : Conf M, I ≠ K → (1 : Matrix (Conf M) (Conf M) ℝ) I K = 0 := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- `ν^{-1}` の全射（`kronecker_numbering_injective`）: 多重添字はどれも `σ(s)` の形
  have hsurj : ∀ I : Conf M, ∃ s : Fin n, σ s = I := fun I => by
    obtain ⟨s, hs⟩ := hord I
    exact ⟨s, kronecker_numbering_injective _ _ (by rw [hσ, hs])⟩
  refine ⟨fun I => ?_, fun I K hIK => ?_⟩
  · obtain ⟨s, rfl⟩ := hsurj I
    exact (realMatrix_conf_one_apply_eq_def_real_identity_matrix M n σ hσ).1 s  -- `def_real_identity_matrix` の `s = t`
  · obtain ⟨s, rfl⟩ := hsurj I
    obtain ⟨t, rfl⟩ := hsurj K
    exact (realMatrix_conf_one_apply_eq_def_real_identity_matrix M n σ hσ).2 s t
      (fun h => hIK (by rw [h]))                            -- `def_real_identity_matrix` の `s ≠ t`

end Ising2D
