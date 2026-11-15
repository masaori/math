/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」の後半のうち、番号で添字づけたサイトごとの Pauli 行列、
番号で添字づけた Jordan–Wigner 行列 Z^{(2^M)}_m・Y^{(2^M)}_m と、Z_m・Y_m を ν_{r_M} で付け替えるとそれになることの必要十分版。
具体版 `Isomorphism/JordanWignerMatrices/IndexedByNumbers.lean` と同じ def と calc の行で、係数 ℂ を型の変数 K に、
虚数単位 i を K の元の変数 i に替えて書く。a ∈ {x, y, z}・b ∈ {y, z} は具体版と同じ `PauliLabels.lean` のものを引く。

  本文のラベル                                                                       このファイル                         使う K の性質
  def_site_pauli_matrices_indexed_by_numbers                                         pauliOf・sitePauliFamily・sitePauli  なし（σy は i を一つ与えるだけ）
  def_factors_of_jordan_wigner_matrices_indexed_by_numbers                           numberedJordanWignerFactor           なし
  def_jordan_wigner_z_matrix_indexed_by_numbers                                      numberedMatrixAlgebra・              L・乗法の交換法則・a · 0 = 0
                                                                                     numberedJordanWignerZ                （B̂ を K-代数にするため）
  def_jordan_wigner_y_matrix_indexed_by_numbers                                      numberedJordanWignerY                同上
  claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers
                                                                                     firstSiteHighestReindexMatrix_jordanWignerZ
                                                                                                                          L・乗法の交換法則・a · 0 = 0
  claim_reindexing_of_jordan_wigner_y_matrix_is_jordan_wigner_y_matrix_indexed_by_numbers
                                                                                     firstSiteHighestReindexMatrix_jordanWignerY
                                                                                                                          L・乗法の交換法則・a · 0 = 0

L : `ValuedMapsLaws K` は行列の積 `Mat.mul L hX` を定めるのに要る。

削れなかった仮定:
- 乗法の交換法則と a · 0 = 0: Z^{(2^M)}_m・Y^{(2^M)}_m は K-代数 B̂ の中の番号順の積（def_ordered_product_in_algebra）なので、
  行列の集合を K-代数にする `matricesAlgebra` が要する二つを定義の段から持つ。主張の行では、同じ二つを
  一つの因子だけを残したクロネッカー積の番号順の積の主張（`orderedProduct_singleSiteKroneckerProducts`。クロネッカー積の積の主張を経由する）と、
  ν_{r_M} が K-代数の準同型であること（`reindexMatrix_isAlgebraHomomorphism`。行列の積を保つことを経由する）に渡す。

分かったこと:
- 主張の行のうち、因子の族の場合分け（（一）と（二））、番号で添字づけたクロネッカー積とその付け替え、番号順の積の因子ごとの等号は、
  K の性質を一つも使わない。K の性質は、B と B̂ の中の積を経由する二つの行（一つの因子だけを残したクロネッカー積の番号順の積、
  準同型が番号順の積を保つこと）からだけ来る。
- Y_m の主張は i が K のどの元でも成り立つ（i · i = -1 を使わない）。Z^{(2^M)}_m の定義と主張に i は現れないが、
  σ^{a}_{k} を a ∈ {x, y, z} の全体で一度に定めるので、F^{(b)}_{m,j} と Z^{(2^M)}_m も i を引数にとる（値は i によらない）。
- 本文の前提 M ∈ ℤ_{≥1} と m ∈ {1,…,M} は、どの主張も使わない（具体版と同じ）。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.JordanWignerConjugation
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.PauliLabels
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.NumberedKroneckerProduct
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.SingleSiteKroneckerProducts
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebra

namespace CliffordMatrixIsomorphism.NecSuf.Isomorphism

open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver (IsAlgebraHomomorphism)
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet twoPower
  firstSiteHighestNumbering_isNumbering)
open CliffordMatrixIsomorphism.Isomorphism (PauliLabel JordanWignerLabel JordanWignerLabel.toPauliLabel)

universe uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K]

/-! ### 番号で添字づけたサイトごとの Pauli 行列と Jordan–Wigner 行列 -/

/-- 本文 `def_site_pauli_matrices_indexed_by_numbers` の σ^{a}（a ∈ {x, y, z}）の必要十分版：def_pauli_matrix_x・…_y・…_z の行列（σy は i を一つ与える）。 -/
def pauliOf (i : K) : PauliLabel → Mat K (Idx 2)
  | .x => pauliX
  | .y => pauliY i
  | .z => pauliZ

/-- 本文 `def_site_pauli_matrices_indexed_by_numbers` の右辺の族の必要十分版：t = k で σ^{a}、t ≠ k で I_2。 -/
noncomputable def sitePauliFamily (i : K) (a : PauliLabel) (k t : ℕ) : Mat K (Idx 2) :=
  if t = k then pauliOf i a else Mat.one

/-- 本文 `def_site_pauli_matrices_indexed_by_numbers` の必要十分版：σ^{a}_{k} := ⊠̂_{t=1}^{M} (σ^{a}（t = k）、I_2（t ≠ k）)。 -/
noncomputable def sitePauli (i : K) (M : ℕ) (a : PauliLabel) (k : ℕ) : Mat K (Idx (twoPower M)) :=
  numberedKroneckerProduct M (sitePauliFamily i a k)

/-- 本文 `def_factors_of_jordan_wigner_matrices_indexed_by_numbers` の必要十分版：F^{(b)}_{m,j} := σ^{x}_{j}（j < m）、σ^{b}_{m}（j = m）。
j > m の値は使わない。 -/
noncomputable def numberedJordanWignerFactor (i : K) (M : ℕ) (b : JordanWignerLabel) (m j : ℕ) : Mat K (Idx (twoPower M)) :=
  if j < m then sitePauli i M .x j else sitePauli i M b.toPauliLabel m

/-- 本文 `def_jordan_wigner_z_matrix_indexed_by_numbers` の B̂ := Mat_{1,…,2^M}(K)（K-代数）。 -/
noncomputable abbrev numberedMatrixAlgebra (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0)
    (M : ℕ) : AlgebraOver K (Mat K (Idx (twoPower M))) :=
  matricesAlgebra L hcomm hmul0 (isFiniteSet_idx (twoPower M))

/-- 本文 `def_jordan_wigner_z_matrix_indexed_by_numbers` の必要十分版：Z^{(2^M)}_m := ∏_{B̂,j=1}^{m} F^{(z)}_{m,j}。 -/
noncomputable def numberedJordanWignerZ (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (i : K) (M m : ℕ) : Mat K (Idx (twoPower M)) :=
  AlgebraOver.orderedProduct (numberedMatrixAlgebra L hcomm hmul0 M) m (numberedJordanWignerFactor i M .z m)

/-- 本文 `def_jordan_wigner_y_matrix_indexed_by_numbers` の必要十分版：Y^{(2^M)}_m := ∏_{B̂,j=1}^{m} F^{(y)}_{m,j}。 -/
noncomputable def numberedJordanWignerY (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (i : K) (M m : ℕ) : Mat K (Idx (twoPower M)) :=
  AlgebraOver.orderedProduct (numberedMatrixAlgebra L hcomm hmul0 M) m (numberedJordanWignerFactor i M .y m)

/-! ### Z_m・Y_m を ν_{r_M} で付け替える -/

/-- 本文 `claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers` の必要十分版：ν_{r_M}(Z_m) = Z^{(2^M)}_m。 -/
theorem firstSiteHighestReindexMatrix_jordanWignerZ (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (i : K) (M m : ℕ) :
    firstSiteHighestReindexMatrix M (jordanWignerZ M m) = numberedJordanWignerZ L hcomm hmul0 i M m := by
  -- B := Mat_{P_M}(K)、B̂ := Mat_{1,…,2^M}(K)、𝔷 と ϑ_j の置き方
  let B := matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M)
  let B' := numberedMatrixAlgebra L hcomm hmul0 M
  let 𝔷 : ℕ → Mat K (Idx 2) := jordanWignerZFactor m
  let ϑ := singleSiteKroneckerProduct M 𝔷
  -- (2^M, r_M) は P_M の番号付け（claim_numbering_with_first_site_as_highest_digit_is_numbering_of_power_set）なので、
  -- ν_{r_M} は K-代数の準同型（claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism）
  have hν : IsAlgebraHomomorphism B B' (firstSiteHighestReindexMatrix M) :=
    reindexMatrix_isAlgebraHomomorphism L hcomm hmul0 (isFiniteSet_powerSet M) (firstSiteHighestNumbering_isNumbering M)
  -- （一）の j = m の場合：ν_{r_M}(ϑ_m) = F^{(z)}_{m,m}
  have h1m : firstSiteHighestReindexMatrix M (ϑ m) = numberedJordanWignerFactor i M .z m m := by
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
      _ = numberedKroneckerProduct M (sitePauliFamily i .z m) :=
          numberedKroneckerProduct_congr M _ _ fun t _ _ => by
            by_cases htm : t = m
            · rw [htm, hmm]; exact (if_pos rfl).symm
            · rw [hmt t htm]; exact (if_neg htm).symm
      -- def_site_pauli_matrices_indexed_by_numbers で a := z、k := m
      _ = sitePauli i M .z m := rfl
      -- def_factors_of_jordan_wigner_matrices_indexed_by_numbers の j = m の場合
      _ = numberedJordanWignerFactor i M .z m m := (if_neg (Nat.lt_irrefl m)).symm
  -- （一）j ∈ {1,…,m} について ν_{r_M}(ϑ_j) = F^{(z)}_{m,j}
  have h1 : ∀ j : ℕ, 1 ≤ j → j ≤ m →
      firstSiteHighestReindexMatrix M (ϑ j) = numberedJordanWignerFactor i M .z m j := by
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
        _ = numberedKroneckerProduct M (sitePauliFamily i .x j) :=
            numberedKroneckerProduct_congr M _ _ fun t _ _ => by
              by_cases htj : t = j
              · rw [htj, hjj]; exact (if_pos rfl).symm
              · rw [hjt t htj]; exact (if_neg htj).symm
        -- def_site_pauli_matrices_indexed_by_numbers で a := x、k := j
        _ = sitePauli i M .x j := rfl
        -- def_factors_of_jordan_wigner_matrices_indexed_by_numbers の j < m の場合
        _ = numberedJordanWignerFactor i M .z m j := (if_pos hjm).symm
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
    _ = firstSiteHighestReindexMatrix M (AlgebraOver.orderedProduct B m ϑ) :=
        (congrArg (firstSiteHighestReindexMatrix M) (orderedProduct_singleSiteKroneckerProducts L hcomm hmul0 M 𝔷 m)).symm
    -- claim_algebra_homomorphism_maps_ordered_product_to_ordered_product
    _ = AlgebraOver.orderedProduct B' m (fun j => firstSiteHighestReindexMatrix M (ϑ j)) :=
        hν.map_orderedProduct m ϑ
    -- claim_ordered_products_with_equal_factors_are_equal。因子が等しいことは（一）
    _ = AlgebraOver.orderedProduct B' m (numberedJordanWignerFactor i M .z m) :=
        AlgebraOver.orderedProduct_congr B' m _ _ h1
    -- def_jordan_wigner_z_matrix_indexed_by_numbers
    _ = numberedJordanWignerZ L hcomm hmul0 i M m := rfl

/-- 本文 `claim_reindexing_of_jordan_wigner_y_matrix_is_jordan_wigner_y_matrix_indexed_by_numbers` の必要十分版：ν_{r_M}(Y_m) = Y^{(2^M)}_m。 -/
theorem firstSiteHighestReindexMatrix_jordanWignerY (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (i : K) (M m : ℕ) :
    firstSiteHighestReindexMatrix M (jordanWignerY i M m) = numberedJordanWignerY L hcomm hmul0 i M m := by
  -- B、B̂ は claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers の証明のもの。𝔶 と ϖ_j の置き方
  let B := matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M)
  let B' := numberedMatrixAlgebra L hcomm hmul0 M
  let 𝔶 : ℕ → Mat K (Idx 2) := jordanWignerYFactor i m
  let ϖ := singleSiteKroneckerProduct M 𝔶
  -- (2^M, r_M) は P_M の番号付け（claim_numbering_with_first_site_as_highest_digit_is_numbering_of_power_set）なので、
  -- ν_{r_M} は K-代数の準同型（claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism）
  have hν : IsAlgebraHomomorphism B B' (firstSiteHighestReindexMatrix M) :=
    reindexMatrix_isAlgebraHomomorphism L hcomm hmul0 (isFiniteSet_powerSet M) (firstSiteHighestNumbering_isNumbering M)
  -- （一）の j = m の場合：ν_{r_M}(ϖ_m) = F^{(y)}_{m,m}
  have h1m : firstSiteHighestReindexMatrix M (ϖ m) = numberedJordanWignerFactor i M .y m m := by
    -- 𝔶^{[m]}_m = σy と、t ≠ m で 𝔶^{[m]}_t = I_2
    have hmm : singleSiteFamily 𝔶 m m = pauliY i := calc
      singleSiteFamily 𝔶 m m
          -- def_single_site_family_of_matrices の t = m の場合
          = 𝔶 m := if_pos rfl
      -- 𝔶 の置き方（j = m）
      _ = pauliY i := (if_neg (Nat.lt_irrefl m)).trans (if_pos rfl)
    have hmt : ∀ t : ℕ, t ≠ m → singleSiteFamily 𝔶 m t = Mat.one := fun t ht =>
      -- def_single_site_family_of_matrices の t ≠ m の場合
      if_neg ht
    calc firstSiteHighestReindexMatrix M (ϖ m)
        -- claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit
        = numberedKroneckerProduct M (singleSiteFamily 𝔶 m) := firstSiteHighestReindexMatrix_kroneckerProduct M _
      -- claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal。因子が等しいことは直前の式
      _ = numberedKroneckerProduct M (sitePauliFamily i .y m) :=
          numberedKroneckerProduct_congr M _ _ fun t _ _ => by
            by_cases htm : t = m
            · rw [htm, hmm]; exact (if_pos rfl).symm
            · rw [hmt t htm]; exact (if_neg htm).symm
      -- def_site_pauli_matrices_indexed_by_numbers で a := y、k := m
      _ = sitePauli i M .y m := rfl
      -- def_factors_of_jordan_wigner_matrices_indexed_by_numbers の j = m の場合
      _ = numberedJordanWignerFactor i M .y m m := (if_neg (Nat.lt_irrefl m)).symm
  -- （一）j ∈ {1,…,m} について ν_{r_M}(ϖ_j) = F^{(y)}_{m,j}
  have h1 : ∀ j : ℕ, 1 ≤ j → j ≤ m →
      firstSiteHighestReindexMatrix M (ϖ j) = numberedJordanWignerFactor i M .y m j := by
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
        _ = numberedKroneckerProduct M (sitePauliFamily i .x j) :=
            numberedKroneckerProduct_congr M _ _ fun t _ _ => by
              by_cases htj : t = j
              · rw [htj, hjj]; exact (if_pos rfl).symm
              · rw [hjt t htj]; exact (if_neg htj).symm
        -- def_site_pauli_matrices_indexed_by_numbers で a := x、k := j
        _ = sitePauli i M .x j := rfl
        -- def_factors_of_jordan_wigner_matrices_indexed_by_numbers の j < m の場合
        _ = numberedJordanWignerFactor i M .y m j := (if_pos hjm).symm
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
  calc firstSiteHighestReindexMatrix M (jordanWignerY i M m)
      -- def_jordan_wigner_y_matrix
      = firstSiteHighestReindexMatrix M (kroneckerProduct M 𝔶) := rfl
    -- claim_kronecker_products_of_factorwise_equal_families_are_equal。因子が等しいことは（二）
    _ = firstSiteHighestReindexMatrix M (kroneckerProduct M (initialPartFamily 𝔶 m)) := by
        rw [kroneckerProduct_congr M 𝔶 (initialPartFamily 𝔶 m) fun t ht1 htM => (h2 t ht1 htM).symm]
    -- claim_ordered_product_of_single_site_kronecker_products で f → 𝔶、p := m
    _ = firstSiteHighestReindexMatrix M (AlgebraOver.orderedProduct B m ϖ) :=
        (congrArg (firstSiteHighestReindexMatrix M) (orderedProduct_singleSiteKroneckerProducts L hcomm hmul0 M 𝔶 m)).symm
    -- claim_algebra_homomorphism_maps_ordered_product_to_ordered_product
    _ = AlgebraOver.orderedProduct B' m (fun j => firstSiteHighestReindexMatrix M (ϖ j)) :=
        hν.map_orderedProduct m ϖ
    -- claim_ordered_products_with_equal_factors_are_equal。因子が等しいことは（一）
    _ = AlgebraOver.orderedProduct B' m (numberedJordanWignerFactor i M .y m) :=
        AlgebraOver.orderedProduct_congr B' m _ _ h1
    -- def_jordan_wigner_y_matrix_indexed_by_numbers
    _ = numberedJordanWignerY L hcomm hmul0 i M m := rfl

end CliffordMatrixIsomorphism.NecSuf.Isomorphism
