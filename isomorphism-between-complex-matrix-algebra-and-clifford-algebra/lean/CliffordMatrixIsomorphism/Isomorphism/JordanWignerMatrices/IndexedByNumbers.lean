/-
章「同型の証明」の節「系：複素行列版イジングの Jordan–Wigner 行列への接続」の後半のうち、番号で添字づけたサイトごとの Pauli 行列、
番号で添字づけた Jordan–Wigner 行列 Z^{(2^M)}_m・Y^{(2^M)}_m と、Z_m・Y_m を ν_{r_M} で付け替えるとそれになることの具体版。
人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。mathlib の `Matrix`・`Matrix.kronecker`・`Finset.prod` は使わない。

  本文のラベル                                                                       このファイル
  def_site_pauli_matrices_indexed_by_numbers                                         pauliOf・sitePauliFamily・sitePauli（σ^{a}_{k}）
  def_factors_of_jordan_wigner_matrices_indexed_by_numbers                           numberedJordanWignerFactor（F^{(b)}_{m,j}）
  def_jordan_wigner_z_matrix_indexed_by_numbers                                      numberedMatrixAlgebra（B̂）・
                                                                                     numberedJordanWignerZ（Z^{(2^M)}_m）
  def_jordan_wigner_y_matrix_indexed_by_numbers                                      numberedJordanWignerY（Y^{(2^M)}_m）
  claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers
                                                                                     firstSiteHighestReindexMatrix_jordanWignerZ
  claim_reindexing_of_jordan_wigner_y_matrix_is_jordan_wigner_y_matrix_indexed_by_numbers
                                                                                     firstSiteHighestReindexMatrix_jordanWignerY

表し方:
- a ∈ {x, y, z} と b ∈ {y, z} は `PauliLabels.lean`（ℂ を含まず両版が引く）の `PauliLabel`・`JordanWignerLabel` で、
  σ^{a} は `pauliOf a`、σ^{b}_{m} は `sitePauli M b.toPauliLabel m` である。
- σ^{a}_{k} の右辺の場合分けの族（t = k で σ^{a}、t ≠ k で I_2）は `sitePauliFamily a k`。
- F^{(b)}_{m,j} は j ∈ {1,…,m} でだけ定まる。Lean では j < m で σ^{x}_{j}、それ以外で σ^{b}_{m} とし、j > m の値は使わない
  （番号順の積 Π_m は j ≤ m の因子しか見ない）。
- B̂ := Mat_{1,…,2^M}(ℂ) は ℂ-代数 `matricesComplexAlgebra (isFiniteSet_idx (twoPower M))`（`numberedMatrixAlgebra M`）、
  B := Mat_{P_M}(ℂ) は `matricesComplexAlgebra (isFiniteSet_powerSet M)`。B と B̂ の中の番号順の積は `ComplexAlgebra.orderedProduct`。
- 証明の 𝔷・𝔶 は前半の `jordanWignerZFactor m`・`jordanWignerYFactor m`（本文の 𝔷_t・𝔶_t と同じ場合分け）、ϑ_j・ϖ_j は
  `singleSiteKroneckerProduct M 𝔷 j`・`singleSiteKroneckerProduct M 𝔶 j`。「Z_m = ⊠ 𝔷_t（def_jordan_wigner_z_matrix）」は定義による（`rfl`）。
- 本文の「（一）」「（二）」は証明の中の `have` に置く。（一）の j = m の場合は、j を m に置いた主張として先に示す。
- 本文の前提 M ∈ ℤ_{≥1} と m ∈ {1,…,M} は、二つの主張の証明が使わない（M = 0 でも、m = 0 でも、m > M でも同じ式で成り立つ）ので、
  仮定に置かない。定義も任意の M・m で書く。

本文が引くほかのブロックは、次の宣言を引く。
  def_kronecker_product_indexed_by_numbers                                       numberedKroneckerProduct
  def_reindexing_of_matrices_by_numbering_with_first_site_as_highest_digit       firstSiteHighestReindexMatrix（ν_{r_M}）
  claim_numbering_with_first_site_as_highest_digit_is_numbering_of_power_set     firstSiteHighestNumbering_isNumbering
  claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism              reindexMatrix_isComplexAlgebraHomomorphism
  def_single_site_family_of_matrices                                             singleSiteFamily
  def_initial_part_family_of_matrices                                            initialPartFamily
  claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit
                                                                                 firstSiteHighestReindexMatrix_kroneckerProduct
  claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal
                                                                                 numberedKroneckerProduct_congr
  claim_kronecker_products_of_factorwise_equal_families_are_equal                kroneckerProduct_congr
  claim_ordered_product_of_single_site_kronecker_products                        orderedProduct_singleSiteKroneckerProducts
  claim_algebra_homomorphism_maps_ordered_product_to_ordered_product             IsComplexAlgebraHomomorphism.map_orderedProduct
  claim_ordered_products_with_equal_factors_are_equal                            ComplexAlgebra.orderedProduct_congr

必要十分版は `NecSuf/Isomorphism/JordanWignerMatrices/IndexedByNumbers.lean`、導出版は `IndexedByNumbersFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.JordanWignerConjugation
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.PauliLabels
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.NumberedKroneckerProduct
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.SingleSiteKroneckerProducts
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebra

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra (IsComplexAlgebraHomomorphism)

/-! ### 番号で添字づけたサイトごとの Pauli 行列と Jordan–Wigner 行列 -/

/-- 本文 `def_site_pauli_matrices_indexed_by_numbers` の σ^{a}（a ∈ {x, y, z}）：def_pauli_matrix_x・…_y・…_z の行列。 -/
noncomputable def pauliOf : PauliLabel → Mat (Idx 2)
  | .x => pauliX
  | .y => pauliY
  | .z => pauliZ

/-- 本文 `def_site_pauli_matrices_indexed_by_numbers` の右辺の族：t = k で σ^{a}、t ≠ k で I_2。 -/
noncomputable def sitePauliFamily (a : PauliLabel) (k t : ℕ) : Mat (Idx 2) :=
  if t = k then pauliOf a else Mat.one

/-- 本文 `def_site_pauli_matrices_indexed_by_numbers`：σ^{a}_{k} := ⊠̂_{t=1}^{M} (σ^{a}（t = k）、I_2（t ≠ k）)。 -/
noncomputable def sitePauli (M : ℕ) (a : PauliLabel) (k : ℕ) : Mat (Idx (twoPower M)) :=
  numberedKroneckerProduct M (sitePauliFamily a k)

/-- 本文 `def_factors_of_jordan_wigner_matrices_indexed_by_numbers`：F^{(b)}_{m,j} := σ^{x}_{j}（j < m）、σ^{b}_{m}（j = m）。
j > m の値は使わない。 -/
noncomputable def numberedJordanWignerFactor (M : ℕ) (b : JordanWignerLabel) (m j : ℕ) : Mat (Idx (twoPower M)) :=
  if j < m then sitePauli M .x j else sitePauli M b.toPauliLabel m

/-- 本文 `def_jordan_wigner_z_matrix_indexed_by_numbers` の B̂ := Mat_{1,…,2^M}(ℂ)（ℂ-代数）。 -/
noncomputable abbrev numberedMatrixAlgebra (M : ℕ) : CliffordMatrixIsomorphism.ComplexAlgebra (Mat (Idx (twoPower M))) :=
  matricesComplexAlgebra (isFiniteSet_idx (twoPower M))

/-- 本文 `def_jordan_wigner_z_matrix_indexed_by_numbers`：Z^{(2^M)}_m := ∏_{B̂,j=1}^{m} F^{(z)}_{m,j}。 -/
noncomputable def numberedJordanWignerZ (M m : ℕ) : Mat (Idx (twoPower M)) :=
  ComplexAlgebra.orderedProduct (numberedMatrixAlgebra M) m (numberedJordanWignerFactor M .z m)

/-- 本文 `def_jordan_wigner_y_matrix_indexed_by_numbers`：Y^{(2^M)}_m := ∏_{B̂,j=1}^{m} F^{(y)}_{m,j}。 -/
noncomputable def numberedJordanWignerY (M m : ℕ) : Mat (Idx (twoPower M)) :=
  ComplexAlgebra.orderedProduct (numberedMatrixAlgebra M) m (numberedJordanWignerFactor M .y m)

/-! ### Z_m・Y_m を ν_{r_M} で付け替える -/

/-- 本文 `claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers`：ν_{r_M}(Z_m) = Z^{(2^M)}_m。 -/
theorem firstSiteHighestReindexMatrix_jordanWignerZ (M m : ℕ) :
    firstSiteHighestReindexMatrix M (jordanWignerZ M m) = numberedJordanWignerZ M m := by
  -- B := Mat_{P_M}(ℂ)、B̂ := Mat_{1,…,2^M}(ℂ)、𝔷 と ϑ_j の置き方
  let B := matricesComplexAlgebra (isFiniteSet_powerSet M)
  let B' := numberedMatrixAlgebra M
  let 𝔷 := jordanWignerZFactor m
  let ϑ := singleSiteKroneckerProduct M 𝔷
  -- (2^M, r_M) は P_M の番号付け（claim_numbering_with_first_site_as_highest_digit_is_numbering_of_power_set）なので、
  -- ν_{r_M} は ℂ-代数の準同型（claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism）
  have hν : IsComplexAlgebraHomomorphism B B' (firstSiteHighestReindexMatrix M) :=
    reindexMatrix_isComplexAlgebraHomomorphism (isFiniteSet_powerSet M) (firstSiteHighestNumbering_isNumbering M)
  -- （一）の j = m の場合：ν_{r_M}(ϑ_m) = F^{(z)}_{m,m}
  have h1m : firstSiteHighestReindexMatrix M (ϑ m) = numberedJordanWignerFactor M .z m m := by
    -- 𝔷^{[m]}_m = σz と、t ≠ m で 𝔷^{[m]}_t = I_2
    have hmm : singleSiteFamily 𝔷 m m = pauliZ := calc
      singleSiteFamily 𝔷 m m
          -- def_single_site_family_of_matrices の t = m の場合
          = 𝔷 m := if_pos rfl
      -- 𝔷 の置き方（j = m）
      _ = pauliZ := (if_neg (Nat.lt_irrefl m)).trans (if_pos rfl)
    have hmt : ∀ t : ℕ, t ≠ m → singleSiteFamily 𝔷 m t = Mat.one := fun t ht =>
      -- def_single_site_family_of_matrices の t ≠ m の場合
      if_neg ht
    calc firstSiteHighestReindexMatrix M (ϑ m)
        -- claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit
        = numberedKroneckerProduct M (singleSiteFamily 𝔷 m) := firstSiteHighestReindexMatrix_kroneckerProduct M _
      -- claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal。因子が等しいことは直前の式
      _ = numberedKroneckerProduct M (sitePauliFamily .z m) :=
          numberedKroneckerProduct_congr M _ _ fun t _ _ => by
            by_cases htm : t = m
            · rw [htm, hmm]; exact (if_pos rfl).symm
            · rw [hmt t htm]; exact (if_neg htm).symm
      -- def_site_pauli_matrices_indexed_by_numbers で a := z、k := m
      _ = sitePauli M .z m := rfl
      -- def_factors_of_jordan_wigner_matrices_indexed_by_numbers の j = m の場合
      _ = numberedJordanWignerFactor M .z m m := (if_neg (Nat.lt_irrefl m)).symm
  -- （一）j ∈ {1,…,m} について ν_{r_M}(ϑ_j) = F^{(z)}_{m,j}
  have h1 : ∀ j : ℕ, 1 ≤ j → j ≤ m →
      firstSiteHighestReindexMatrix M (ϑ j) = numberedJordanWignerFactor M .z m j := by
    intro j _ hjm
    rcases Nat.lt_or_eq_of_le hjm with hjm | hjm
    · -- j < m の場合：𝔷^{[j]}_j = σx と、t ≠ j で 𝔷^{[j]}_t = I_2
      have hjj : singleSiteFamily 𝔷 j j = pauliX := calc
        singleSiteFamily 𝔷 j j
            -- def_single_site_family_of_matrices の t = j の場合
            = 𝔷 j := if_pos rfl
        -- 𝔷 の置き方（j < m）
        _ = pauliX := if_pos hjm
      have hjt : ∀ t : ℕ, t ≠ j → singleSiteFamily 𝔷 j t = Mat.one := fun t ht =>
        -- def_single_site_family_of_matrices の t ≠ j の場合
        if_neg ht
      calc firstSiteHighestReindexMatrix M (ϑ j)
          -- claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit
          = numberedKroneckerProduct M (singleSiteFamily 𝔷 j) := firstSiteHighestReindexMatrix_kroneckerProduct M _
        -- claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal。因子が等しいことは直前の式
        _ = numberedKroneckerProduct M (sitePauliFamily .x j) :=
            numberedKroneckerProduct_congr M _ _ fun t _ _ => by
              by_cases htj : t = j
              · rw [htj, hjj]; exact (if_pos rfl).symm
              · rw [hjt t htj]; exact (if_neg htj).symm
        -- def_site_pauli_matrices_indexed_by_numbers で a := x、k := j
        _ = sitePauli M .x j := rfl
        -- def_factors_of_jordan_wigner_matrices_indexed_by_numbers の j < m の場合
        _ = numberedJordanWignerFactor M .z m j := (if_pos hjm).symm
    · -- j = m の場合
      rw [hjm]
      exact h1m
  -- （二）すべての t ∈ {1,…,M} について 𝔷^{[≤m]}_t = 𝔷_t
  have h2 : ∀ t : ℕ, 1 ≤ t → t ≤ M → initialPartFamily 𝔷 m t = 𝔷 t := by
    intro t _ _
    by_cases htm : t ≤ m
    · -- t ≤ m の場合：def_initial_part_family_of_matrices の t ≤ m の場合
      exact if_pos htm
    · -- t > m の場合
      calc initialPartFamily 𝔷 m t
          -- def_initial_part_family_of_matrices の t > m の場合
          = Mat.one := if_neg htm
        -- 𝔷 の置き方（t > m）
        _ = 𝔷 t := ((if_neg (by omega)).trans (if_neg (by omega))).symm
  calc firstSiteHighestReindexMatrix M (jordanWignerZ M m)
      -- def_jordan_wigner_z_matrix
      = firstSiteHighestReindexMatrix M (kroneckerProduct M 𝔷) := rfl
    -- claim_kronecker_products_of_factorwise_equal_families_are_equal。因子が等しいことは（二）
    _ = firstSiteHighestReindexMatrix M (kroneckerProduct M (initialPartFamily 𝔷 m)) := by
        rw [kroneckerProduct_congr M 𝔷 (initialPartFamily 𝔷 m) fun t ht1 htM => (h2 t ht1 htM).symm]
    -- claim_ordered_product_of_single_site_kronecker_products で f → 𝔷、p := m
    _ = firstSiteHighestReindexMatrix M (ComplexAlgebra.orderedProduct B m ϑ) :=
        (congrArg (firstSiteHighestReindexMatrix M) (orderedProduct_singleSiteKroneckerProducts M 𝔷 m)).symm
    -- claim_algebra_homomorphism_maps_ordered_product_to_ordered_product
    _ = ComplexAlgebra.orderedProduct B' m (fun j => firstSiteHighestReindexMatrix M (ϑ j)) :=
        hν.map_orderedProduct m ϑ
    -- claim_ordered_products_with_equal_factors_are_equal。因子が等しいことは（一）
    _ = ComplexAlgebra.orderedProduct B' m (numberedJordanWignerFactor M .z m) :=
        ComplexAlgebra.orderedProduct_congr B' m _ _ h1
    -- def_jordan_wigner_z_matrix_indexed_by_numbers
    _ = numberedJordanWignerZ M m := rfl

/-- 本文 `claim_reindexing_of_jordan_wigner_y_matrix_is_jordan_wigner_y_matrix_indexed_by_numbers`：ν_{r_M}(Y_m) = Y^{(2^M)}_m。 -/
theorem firstSiteHighestReindexMatrix_jordanWignerY (M m : ℕ) :
    firstSiteHighestReindexMatrix M (jordanWignerY M m) = numberedJordanWignerY M m := by
  -- B、B̂ は claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers の証明のもの。𝔶 と ϖ_j の置き方
  let B := matricesComplexAlgebra (isFiniteSet_powerSet M)
  let B' := numberedMatrixAlgebra M
  let 𝔶 := jordanWignerYFactor m
  let ϖ := singleSiteKroneckerProduct M 𝔶
  -- (2^M, r_M) は P_M の番号付け（claim_numbering_with_first_site_as_highest_digit_is_numbering_of_power_set）なので、
  -- ν_{r_M} は ℂ-代数の準同型（claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism）
  have hν : IsComplexAlgebraHomomorphism B B' (firstSiteHighestReindexMatrix M) :=
    reindexMatrix_isComplexAlgebraHomomorphism (isFiniteSet_powerSet M) (firstSiteHighestNumbering_isNumbering M)
  -- （一）の j = m の場合：ν_{r_M}(ϖ_m) = F^{(y)}_{m,m}
  have h1m : firstSiteHighestReindexMatrix M (ϖ m) = numberedJordanWignerFactor M .y m m := by
    -- 𝔶^{[m]}_m = σy と、t ≠ m で 𝔶^{[m]}_t = I_2
    have hmm : singleSiteFamily 𝔶 m m = pauliY := calc
      singleSiteFamily 𝔶 m m
          -- def_single_site_family_of_matrices の t = m の場合
          = 𝔶 m := if_pos rfl
      -- 𝔶 の置き方（j = m）
      _ = pauliY := (if_neg (Nat.lt_irrefl m)).trans (if_pos rfl)
    have hmt : ∀ t : ℕ, t ≠ m → singleSiteFamily 𝔶 m t = Mat.one := fun t ht =>
      -- def_single_site_family_of_matrices の t ≠ m の場合
      if_neg ht
    calc firstSiteHighestReindexMatrix M (ϖ m)
        -- claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit
        = numberedKroneckerProduct M (singleSiteFamily 𝔶 m) := firstSiteHighestReindexMatrix_kroneckerProduct M _
      -- claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal。因子が等しいことは直前の式
      _ = numberedKroneckerProduct M (sitePauliFamily .y m) :=
          numberedKroneckerProduct_congr M _ _ fun t _ _ => by
            by_cases htm : t = m
            · rw [htm, hmm]; exact (if_pos rfl).symm
            · rw [hmt t htm]; exact (if_neg htm).symm
      -- def_site_pauli_matrices_indexed_by_numbers で a := y、k := m
      _ = sitePauli M .y m := rfl
      -- def_factors_of_jordan_wigner_matrices_indexed_by_numbers の j = m の場合
      _ = numberedJordanWignerFactor M .y m m := (if_neg (Nat.lt_irrefl m)).symm
  -- （一）j ∈ {1,…,m} について ν_{r_M}(ϖ_j) = F^{(y)}_{m,j}
  have h1 : ∀ j : ℕ, 1 ≤ j → j ≤ m →
      firstSiteHighestReindexMatrix M (ϖ j) = numberedJordanWignerFactor M .y m j := by
    intro j _ hjm
    rcases Nat.lt_or_eq_of_le hjm with hjm | hjm
    · -- j < m の場合：𝔶^{[j]}_j = σx と、t ≠ j で 𝔶^{[j]}_t = I_2
      have hjj : singleSiteFamily 𝔶 j j = pauliX := calc
        singleSiteFamily 𝔶 j j
            -- def_single_site_family_of_matrices の t = j の場合
            = 𝔶 j := if_pos rfl
        -- 𝔶 の置き方（j < m）
        _ = pauliX := if_pos hjm
      have hjt : ∀ t : ℕ, t ≠ j → singleSiteFamily 𝔶 j t = Mat.one := fun t ht =>
        -- def_single_site_family_of_matrices の t ≠ j の場合
        if_neg ht
      calc firstSiteHighestReindexMatrix M (ϖ j)
          -- claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit
          = numberedKroneckerProduct M (singleSiteFamily 𝔶 j) := firstSiteHighestReindexMatrix_kroneckerProduct M _
        -- claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal。因子が等しいことは直前の式
        _ = numberedKroneckerProduct M (sitePauliFamily .x j) :=
            numberedKroneckerProduct_congr M _ _ fun t _ _ => by
              by_cases htj : t = j
              · rw [htj, hjj]; exact (if_pos rfl).symm
              · rw [hjt t htj]; exact (if_neg htj).symm
        -- def_site_pauli_matrices_indexed_by_numbers で a := x、k := j
        _ = sitePauli M .x j := rfl
        -- def_factors_of_jordan_wigner_matrices_indexed_by_numbers の j < m の場合
        _ = numberedJordanWignerFactor M .y m j := (if_pos hjm).symm
    · -- j = m の場合
      rw [hjm]
      exact h1m
  -- （二）すべての t ∈ {1,…,M} について 𝔶^{[≤m]}_t = 𝔶_t
  have h2 : ∀ t : ℕ, 1 ≤ t → t ≤ M → initialPartFamily 𝔶 m t = 𝔶 t := by
    intro t _ _
    by_cases htm : t ≤ m
    · -- t ≤ m の場合：def_initial_part_family_of_matrices の t ≤ m の場合
      exact if_pos htm
    · -- t > m の場合
      calc initialPartFamily 𝔶 m t
          -- def_initial_part_family_of_matrices の t > m の場合
          = Mat.one := if_neg htm
        -- 𝔶 の置き方（t > m）
        _ = 𝔶 t := ((if_neg (by omega)).trans (if_neg (by omega))).symm
  calc firstSiteHighestReindexMatrix M (jordanWignerY M m)
      -- def_jordan_wigner_y_matrix
      = firstSiteHighestReindexMatrix M (kroneckerProduct M 𝔶) := rfl
    -- claim_kronecker_products_of_factorwise_equal_families_are_equal。因子が等しいことは（二）
    _ = firstSiteHighestReindexMatrix M (kroneckerProduct M (initialPartFamily 𝔶 m)) := by
        rw [kroneckerProduct_congr M 𝔶 (initialPartFamily 𝔶 m) fun t ht1 htM => (h2 t ht1 htM).symm]
    -- claim_ordered_product_of_single_site_kronecker_products で f → 𝔶、p := m
    _ = firstSiteHighestReindexMatrix M (ComplexAlgebra.orderedProduct B m ϖ) :=
        (congrArg (firstSiteHighestReindexMatrix M) (orderedProduct_singleSiteKroneckerProducts M 𝔶 m)).symm
    -- claim_algebra_homomorphism_maps_ordered_product_to_ordered_product
    _ = ComplexAlgebra.orderedProduct B' m (fun j => firstSiteHighestReindexMatrix M (ϖ j)) :=
        hν.map_orderedProduct m ϖ
    -- claim_ordered_products_with_equal_factors_are_equal。因子が等しいことは（一）
    _ = ComplexAlgebra.orderedProduct B' m (numberedJordanWignerFactor M .y m) :=
        ComplexAlgebra.orderedProduct_congr B' m _ _ h1
    -- def_jordan_wigner_y_matrix_indexed_by_numbers
    _ = numberedJordanWignerY M m := rfl

end CliffordMatrixIsomorphism.Isomorphism
