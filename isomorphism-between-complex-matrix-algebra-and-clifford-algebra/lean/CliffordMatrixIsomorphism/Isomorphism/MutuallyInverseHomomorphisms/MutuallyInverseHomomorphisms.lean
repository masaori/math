/-
章「同型の証明」の節「二つの準同型が互いに逆であること」の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                                          このファイル
  claim_homomorphism_to_matrix_algebra_on_matrix_unit_element                                           homomorphismToMatrix_matrixUnitElement
  claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity               homomorphismToMatrix_homomorphismFromMatrix
  claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements                       sum_creationMatrix_entry_smul_matrixUnitElement
  claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix                homomorphismFromMatrix_creationMatrix
  claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements                      sum_annihilationMatrix_entry_smul_matrixUnitElement
  claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix            homomorphismFromMatrix_annihilationMatrix
  claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators γ_pair_eq_creation_add_annihilation
  claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity               homomorphismFromMatrix_homomorphismToMatrix
  theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra                     cliffordAlgebra_isomorphic_matrixAlgebra

表し方:
- 宣言は名前空間 `Clifford.SplitData` に置く（`HomomorphismFromMatrixAlgebra.lean` と同じ）。
- Φ(ℰ_{S,T}) の証明の B の元 Y_t・Z_t・Ž_k は、`VacuumMatrixUnit.lean` の `selectedCreation D.M S t`・
  `selectedAnnihilation D.M T t`・`reversedSelectedAnnihilation D.M T k`（定義が本文の置き方と同じ）である。
- 本文の部分集合 T ∪ {i} は `unionSingleton T i hi`、空集合 ∅ は `emptyIndexSet D.M`。
- 本文の「因子が等しい族の番号順の積は等しい」は `orderedProduct_congr`（本文 claim_ordered_products_with_equal_factors_are_equal）。
- 主定理の「Φ は全単射」は `Function.Bijective`、「Φ の逆写像は Ψ」は「Φ(a) = F を満たす a は Ψ(F) である」と書く。

必要十分版は `NecSuf/Isomorphism/MutuallyInverseHomomorphisms/MutuallyInverseHomomorphisms.lean`、
導出版は `MutuallyInverseHomomorphismsFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.HomomorphismFromMatrixAlgebra.HomomorphismFromMatrixAlgebra
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.VacuumMatrixUnit
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Product
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.DoubleSum
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.TensorAlgebraStructure

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- 本文 `claim_homomorphism_to_matrix_algebra_on_matrix_unit_element`：Φ(ℰ_{S,T}) = E_{S,T}。 -/
theorem homomorphismToMatrix_matrixUnitElement (S T : PowerSet D.M) :
    D.homomorphismToMatrix (D.matrixUnitElement S T) = matrixUnit S T := by
  let A := D.space.cliffordAlgebra
  let B := D.matrixAlgebra
  let Φ := D.homomorphismToMatrix
  have hΦ : IsComplexAlgebraHomomorphism A B Φ := D.homomorphismToMatrix_isHom
  let E0 := emptyIndexSet D.M
  let Y := selectedCreation D.M S
  let Zr := reversedSelectedAnnihilation D.M T
  -- （イ）Φ(y^S_t) = Y_t、Φ(z^T_t) = Z_t
  have hY : ∀ t : ℕ, 1 ≤ t → t ≤ D.M → Φ (D.selectedCreationFactor S t) = Y t := by
    intro t ht1 htM
    by_cases h : t ∈ S.1
    · calc Φ (D.selectedCreationFactor S t) = Φ (D.creation t) := by rw [D.selectedCreationFactor_of_mem h]
        _ = creationMatrix D.M t ⟨ht1, htM⟩ := D.homomorphismToMatrix_creation ⟨ht1, htM⟩
        _ = Y t := (selectedCreation_of_mem ⟨ht1, htM⟩ h).symm
    · calc Φ (D.selectedCreationFactor S t) = Φ A.one := by rw [D.selectedCreationFactor_of_not_mem h]
        _ = B.one := hΦ.map_one
        _ = Y t := (selectedCreation_of_not_mem h).symm
  have hZ : ∀ t : ℕ, 1 ≤ t → t ≤ D.M →
      Φ (D.selectedAnnihilationFactor T t) = selectedAnnihilation D.M T t := by
    intro t ht1 htM
    by_cases h : t ∈ T.1
    · calc Φ (D.selectedAnnihilationFactor T t) = Φ (D.annihilation t) := by
            rw [D.selectedAnnihilationFactor_of_mem h]
        _ = annihilationMatrix D.M t ⟨ht1, htM⟩ := D.homomorphismToMatrix_annihilation ⟨ht1, htM⟩
        _ = selectedAnnihilation D.M T t := by unfold selectedAnnihilation; rw [dif_pos h]
    · calc Φ (D.selectedAnnihilationFactor T t) = Φ A.one := by rw [D.selectedAnnihilationFactor_of_not_mem h]
        _ = B.one := hΦ.map_one
        _ = selectedAnnihilation D.M T t := by unfold selectedAnnihilation; rw [dif_neg h]; rfl
  -- Φ(ž^T_k) = Ž_k
  have hZr : ∀ k : ℕ, 1 ≤ k → k ≤ D.M → Φ (D.reversedSelectedAnnihilationFactor T k) = Zr k := by
    intro k hk1 hkM
    calc Φ (D.reversedSelectedAnnihilationFactor T k) = Φ (D.selectedAnnihilationFactor T (D.M + 1 - k)) := rfl
      _ = selectedAnnihilation D.M T (D.M + 1 - k) := hZ (D.M + 1 - k) (by omega) (by omega)
      _ = Zr k := rfl
  -- （ロ）Φ(x_i) = c_i^T ·_B c_i
  have hx : ∀ i : ℕ, 1 ≤ i → i ≤ D.M → Φ (D.vacuumFactor i) = annihilationTimesCreation D.M i := by
    intro i hi1 hiM
    calc Φ (D.vacuumFactor i) = Φ (A.mul (D.annihilation i) (D.creation i)) := rfl
      _ = B.mul (Φ (D.annihilation i)) (Φ (D.creation i)) := hΦ.map_mul _ _
      _ = B.mul (annihilationMatrix D.M i ⟨hi1, hiM⟩) (creationMatrix D.M i ⟨hi1, hiM⟩) := by
          rw [show Φ (D.annihilation i) = _ from D.homomorphismToMatrix_annihilation ⟨hi1, hiM⟩,
            show Φ (D.creation i) = _ from D.homomorphismToMatrix_creation ⟨hi1, hiM⟩]
      _ = annihilationTimesCreation D.M i := (annihilationTimesCreation_of_mem ⟨hi1, hiM⟩).symm
  -- （ハ）三つの番号順の積の像
  have hcre : Φ (D.orderedCreationProduct S) = ComplexAlgebra.orderedProduct B D.M Y := calc
    Φ (D.orderedCreationProduct S) = Φ (ComplexAlgebra.orderedProduct A D.M (D.selectedCreationFactor S)) := rfl
    _ = ComplexAlgebra.orderedProduct B D.M (fun t => Φ (D.selectedCreationFactor S t)) := hΦ.map_orderedProduct D.M _
    _ = ComplexAlgebra.orderedProduct B D.M Y := orderedProduct_congr B D.M _ _ hY
  have hvac : Φ D.vacuumElement = matrixUnit E0 E0 := calc
    Φ D.vacuumElement = Φ (ComplexAlgebra.orderedProduct A D.M D.vacuumFactor) := rfl
    _ = ComplexAlgebra.orderedProduct B D.M (fun i => Φ (D.vacuumFactor i)) := hΦ.map_orderedProduct D.M _
    _ = ComplexAlgebra.orderedProduct B D.M (annihilationTimesCreation D.M) := orderedProduct_congr B D.M _ _ hx
    _ = matrixUnit E0 E0 := orderedProduct_annihilationTimesCreation_eq_vacuumMatrixUnit D.M
  have hann : Φ (D.reverseOrderedAnnihilationProduct T) = ComplexAlgebra.orderedProduct B D.M Zr := calc
    Φ (D.reverseOrderedAnnihilationProduct T)
        = Φ (ComplexAlgebra.orderedProduct A D.M (D.reversedSelectedAnnihilationFactor T)) := rfl
    _ = ComplexAlgebra.orderedProduct B D.M (fun k => Φ (D.reversedSelectedAnnihilationFactor T k)) :=
        hΦ.map_orderedProduct D.M _
    _ = ComplexAlgebra.orderedProduct B D.M Zr := orderedProduct_congr B D.M _ _ hZr
  -- （ニ）E_{S,∅} ·_B E_{∅,∅} = E_{S,∅}
  have hD : B.mul (matrixUnit S E0) (matrixUnit E0 E0) = matrixUnit S E0 := calc
    B.mul (matrixUnit S E0) (matrixUnit E0 E0) = B.smul (kroneckerDelta E0 E0) (matrixUnit S E0) :=
        matrixUnit_mul_matrixUnit (isFiniteSet_powerSet D.M) S E0 E0 E0
    _ = B.smul 1 (matrixUnit S E0) := by rw [kroneckerDelta, if_pos rfl]
    _ = matrixUnit S E0 := B.one_smul _
  calc Φ (D.matrixUnitElement S T)
      = Φ (A.mul (A.mul (D.orderedCreationProduct S) D.vacuumElement) (D.reverseOrderedAnnihilationProduct T)) := rfl
    _ = B.mul (Φ (A.mul (D.orderedCreationProduct S) D.vacuumElement)) (Φ (D.reverseOrderedAnnihilationProduct T)) :=
        hΦ.map_mul _ _
    _ = B.mul (B.mul (Φ (D.orderedCreationProduct S)) (Φ D.vacuumElement))
          (Φ (D.reverseOrderedAnnihilationProduct T)) := by rw [hΦ.map_mul]
    _ = B.mul (B.mul (ComplexAlgebra.orderedProduct B D.M Y) (Φ D.vacuumElement)) (Φ (D.reverseOrderedAnnihilationProduct T)) := by
        rw [hcre]
    _ = B.mul (B.mul (ComplexAlgebra.orderedProduct B D.M Y) (matrixUnit E0 E0)) (Φ (D.reverseOrderedAnnihilationProduct T)) := by
        rw [hvac]
    _ = B.mul (B.mul (ComplexAlgebra.orderedProduct B D.M Y) (matrixUnit E0 E0)) (ComplexAlgebra.orderedProduct B D.M Zr) := by rw [hann]
    _ = B.mul (matrixUnit S E0) (ComplexAlgebra.orderedProduct B D.M Zr) := by
        rw [show B.mul (ComplexAlgebra.orderedProduct B D.M Y) (matrixUnit E0 E0) = matrixUnit S E0
          from orderedProduct_selectedCreation_mul_vacuumMatrixUnit D.M S]
    _ = B.mul (B.mul (matrixUnit S E0) (matrixUnit E0 E0)) (ComplexAlgebra.orderedProduct B D.M Zr) := by rw [hD]
    _ = B.mul (matrixUnit S E0) (B.mul (matrixUnit E0 E0) (ComplexAlgebra.orderedProduct B D.M Zr)) := B.mul_assoc _ _ _
    _ = B.mul (matrixUnit S E0) (matrixUnit E0 T) := by
        rw [show B.mul (matrixUnit E0 E0) (ComplexAlgebra.orderedProduct B D.M Zr) = matrixUnit E0 T
          from vacuumMatrixUnit_mul_orderedProduct_reversedSelectedAnnihilation D.M T]
    _ = B.smul (kroneckerDelta E0 E0) (matrixUnit S T) :=
        matrixUnit_mul_matrixUnit (isFiniteSet_powerSet D.M) S E0 E0 T
    _ = B.smul 1 (matrixUnit S T) := by rw [kroneckerDelta, if_pos rfl]
    _ = matrixUnit S T := B.one_smul _

/-- 本文 `claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity`：Φ(Ψ(F)) = F。 -/
theorem homomorphismToMatrix_homomorphismFromMatrix (F : Mat (PowerSet D.M)) :
    D.homomorphismToMatrix (D.homomorphismFromMatrix F) = F := by
  let A := D.space.cliffordAlgebra
  let Av := A.toComplexVectorSpace
  let Bv := D.matrixAlgebra.toComplexVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let Φ := D.homomorphismToMatrix
  have hΦ : IsComplexLinearMap Av Bv Φ := D.homomorphismToMatrix_isHom.isLinearMap
  calc Φ (D.homomorphismFromMatrix F)
      = Φ (sumOverFiniteSet Av hX (fun _ => 1)
          (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (fun T => D.matrixUnitElement S T))) := rfl
    _ = sumOverFiniteSet Bv hX (fun _ => 1)
          (fun S => sumOverFiniteSet Bv hX (fun T => Mat.entry F S T) (fun T => Φ (D.matrixUnitElement S T))) :=
        hΦ.map_double_sumOverFiniteSet hX hX _ _
    _ = sumOverFiniteSet Bv hX (fun _ => 1)
          (fun S => sumOverFiniteSet Bv hX (fun T => Mat.entry F S T) (fun T => matrixUnit S T)) :=
        sumOverFiniteSet_double_congr Bv hX hX _ _ _ _ fun S T =>
          congrArg (Bv.smul (Mat.entry F S T)) (D.homomorphismToMatrix_matrixUnitElement S T)
    _ = F := (eq_double_sum_entry_smul_matrixUnit hX F).symm

/-- 本文 `claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements`：
Σ_{S∈P_M} (c_i)_{S,T} ∗_A ℰ_{S,T} = a†_i ·_A ℰ_{T,T}。 -/
theorem sum_creationMatrix_entry_smul_matrixUnitElement {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (T : PowerSet D.M) :
    sumOverFiniteSet D.space.cliffordAlgebra.toComplexVectorSpace (isFiniteSet_powerSet D.M)
        (fun S => Mat.entry (creationMatrix D.M i hi) S T) (fun S => D.matrixUnitElement S T)
      = D.space.cliffordAlgebra.mul (D.creation i) (D.matrixUnitElement T T) := by
  let A := D.space.cliffordAlgebra
  let Av := A.toComplexVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := D.matrixUnitElement
  let cT := D.orderedCreationProduct T
  let aT := D.reverseOrderedAnnihilationProduct T
  let P := D.vacuumElement
  by_cases hiT : i ∉ T.1
  · -- i ∉ T のとき。σ := ς(N_i(T))
    let σ : ℂ := sign (countBelow T i)
    let Ti := unionSingleton T i hi
    -- （イ）(c_i)_{S,T} ∗ ℰ_{S,T} = δ_{T∪{i},S} ∗ (σ ∗ ℰ_{S,T})
    have hI : ∀ S : PowerSet D.M,
        Av.smul (Mat.entry (creationMatrix D.M i hi) S T) (E S T)
          = Av.smul (kroneckerDelta Ti S) (Av.smul σ (E S T)) := by
      intro S
      by_cases hS : S = Ti
      · calc Av.smul (Mat.entry (creationMatrix D.M i hi) S T) (E S T) = Av.smul σ (E S T) := by
              rw [creationMatrix_entry_of_cond hi ⟨hiT, hS⟩]
          _ = Av.smul 1 (Av.smul σ (E S T)) := (Av.one_smul _).symm
          _ = Av.smul (kroneckerDelta Ti S) (Av.smul σ (E S T)) := by rw [kroneckerDelta, if_pos hS.symm]
      · calc Av.smul (Mat.entry (creationMatrix D.M i hi) S T) (E S T) = Av.smul 0 (E S T) := by
              rw [creationMatrix_entry_of_not_cond hi (fun h => hS h.2)]
          _ = Av.zero := zero_smul_eq_zero Av _
          _ = Av.smul 0 (Av.smul σ (E S T)) := (zero_smul_eq_zero Av _).symm
          _ = Av.smul (kroneckerDelta Ti S) (Av.smul σ (E S T)) := by
              rw [kroneckerDelta, if_neg (fun h => hS h.symm)]
    -- （ロ）a†_i ·_A ℰ_{T,T} = σ ∗_A ℰ_{T∪{i},T}
    have hII : A.mul (D.creation i) (E T T) = A.smul σ (E Ti T) := calc
      A.mul (D.creation i) (E T T) = A.mul (D.creation i) (A.mul (A.mul cT P) aT) := rfl
      _ = A.mul (A.mul (D.creation i) (A.mul cT P)) aT := (A.mul_assoc _ _ _).symm
      _ = A.mul (A.mul (A.mul (D.creation i) cT) P) aT := by rw [A.mul_assoc (D.creation i) cT P]
      _ = A.mul (A.mul (A.smul σ (D.orderedCreationProduct Ti)) P) aT := by
          rw [D.creation_mul_orderedCreationProduct_of_not_mem hi T hiT]
      _ = A.mul (A.smul σ (A.mul (D.orderedCreationProduct Ti) P)) aT := by rw [A.smul_mul_left]
      _ = A.smul σ (A.mul (A.mul (D.orderedCreationProduct Ti) P) aT) := (A.smul_mul_left _ _ _).symm
      _ = A.smul σ (E Ti T) := rfl
    calc sumOverFiniteSet Av hX (fun S => Mat.entry (creationMatrix D.M i hi) S T) (fun S => E S T)
        = sumOverFiniteSet Av hX (fun S => kroneckerDelta Ti S) (fun S => Av.smul σ (E S T)) :=
          sumOverFiniteSet_congr Av hX _ _ _ _ hI
      _ = Av.smul σ (E Ti T) := sumOverFiniteSet_kroneckerDelta Av hX (fun S => Av.smul σ (E S T)) Ti
      _ = A.mul (D.creation i) (E T T) := hII.symm
  · -- i ∈ T のとき
    have hiT' : i ∈ T.1 := not_not.mp hiT
    -- （ハ）(c_i)_{S,T} ∗ ℰ_{S,T} = 0_A
    have hIII : ∀ S : PowerSet D.M, Av.smul (Mat.entry (creationMatrix D.M i hi) S T) (E S T) = Av.zero := by
      intro S
      calc Av.smul (Mat.entry (creationMatrix D.M i hi) S T) (E S T) = Av.smul 0 (E S T) := by
            rw [creationMatrix_entry_of_not_cond hi (fun h => h.1 hiT')]
        _ = Av.zero := zero_smul_eq_zero Av _
    calc sumOverFiniteSet Av hX (fun S => Mat.entry (creationMatrix D.M i hi) S T) (fun S => E S T)
        = A.zero := sumOverFiniteSet_eq_zero_of_terms_eq_zero Av hX _ _ hIII
      _ = A.mul A.zero aT := (zero_mul_eq_zero A aT).symm
      _ = A.mul (A.mul A.zero P) aT := by rw [zero_mul_eq_zero A P]
      _ = A.mul (A.mul (A.mul (D.creation i) cT) P) aT := by
          rw [D.creation_mul_orderedCreationProduct_of_mem hi T hiT']
      _ = A.mul (A.mul (D.creation i) (A.mul cT P)) aT := by rw [A.mul_assoc (D.creation i) cT P]
      _ = A.mul (D.creation i) (A.mul (A.mul cT P) aT) := A.mul_assoc _ _ _
      _ = A.mul (D.creation i) (E T T) := rfl

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix`：Ψ(c_i) = a†_i。 -/
theorem homomorphismFromMatrix_creationMatrix {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.homomorphismFromMatrix (creationMatrix D.M i hi) = D.creation i := by
  let A := D.space.cliffordAlgebra
  let Av := A.toComplexVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := D.matrixUnitElement
  let c := creationMatrix D.M i hi
  calc D.homomorphismFromMatrix c
      = sumOverFiniteSet Av hX (fun _ => 1) (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry c S T) (E S)) := rfl
    _ = sumOverFiniteSet Av hX (fun _ => 1)
          (fun T => sumOverFiniteSet Av hX (fun S => Mat.entry c S T) (fun S => E S T)) :=
        sumOverFiniteSet_interchange Av hX hX (fun S T => Mat.entry c S T) E
    _ = sumOverFiniteSet Av hX (fun _ => 1) (fun T => A.mul (D.creation i) (E T T)) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ fun T => by
          rw [D.sum_creationMatrix_entry_smul_matrixUnitElement hi T]
    _ = A.mul (D.creation i) (sumOverFiniteSet Av hX (fun _ => 1) (fun T => E T T)) :=
        ((leftMul_isLinearMap A (D.creation i)).map_sumOverFiniteSet hX _ _).symm
    _ = A.mul (D.creation i) (sumOverFiniteSet Av hX (fun _ => 1)
          (fun T => A.mul (A.mul (D.orderedCreationProduct T) D.vacuumElement) (D.reverseOrderedAnnihilationProduct T))) :=
        rfl
    _ = A.mul (D.creation i) A.one := by rw [D.decomposition_of_unity]
    _ = D.creation i := A.mul_one _

/-- 本文 `claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements`：
Σ_{T∈P_M} (c_i^T)_{S,T} ∗_A ℰ_{S,T} = ℰ_{S,S} ·_A a_i。 -/
theorem sum_annihilationMatrix_entry_smul_matrixUnitElement {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (S : PowerSet D.M) :
    sumOverFiniteSet D.space.cliffordAlgebra.toComplexVectorSpace (isFiniteSet_powerSet D.M)
        (fun T => Mat.entry (annihilationMatrix D.M i hi) S T) (fun T => D.matrixUnitElement S T)
      = D.space.cliffordAlgebra.mul (D.matrixUnitElement S S) (D.annihilation i) := by
  let A := D.space.cliffordAlgebra
  let Av := A.toComplexVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := D.matrixUnitElement
  let cS := D.orderedCreationProduct S
  let aS := D.reverseOrderedAnnihilationProduct S
  let P := D.vacuumElement
  by_cases hiS : i ∉ S.1
  · -- i ∉ S のとき。σ := ς(N_i(S))
    let σ : ℂ := sign (countBelow S i)
    let Si := unionSingleton S i hi
    -- （イ）(c_i^T)_{S,T} ∗ ℰ_{S,T} = δ_{S∪{i},T} ∗ (σ ∗ ℰ_{S,T})
    have hI : ∀ T : PowerSet D.M,
        Av.smul (Mat.entry (annihilationMatrix D.M i hi) S T) (E S T)
          = Av.smul (kroneckerDelta Si T) (Av.smul σ (E S T)) := by
      intro T
      by_cases hT : T = Si
      · calc Av.smul (Mat.entry (annihilationMatrix D.M i hi) S T) (E S T)
            = Av.smul (Mat.entry (creationMatrix D.M i hi) T S) (E S T) := by rw [annihilationMatrix_entry hi S T]
          _ = Av.smul σ (E S T) := by rw [creationMatrix_entry_of_cond hi ⟨hiS, hT⟩]
          _ = Av.smul 1 (Av.smul σ (E S T)) := (Av.one_smul _).symm
          _ = Av.smul (kroneckerDelta Si T) (Av.smul σ (E S T)) := by rw [kroneckerDelta, if_pos hT.symm]
      · calc Av.smul (Mat.entry (annihilationMatrix D.M i hi) S T) (E S T)
            = Av.smul (Mat.entry (creationMatrix D.M i hi) T S) (E S T) := by rw [annihilationMatrix_entry hi S T]
          _ = Av.smul 0 (E S T) := by rw [creationMatrix_entry_of_not_cond hi (fun h => hT h.2)]
          _ = Av.zero := zero_smul_eq_zero Av _
          _ = Av.smul 0 (Av.smul σ (E S T)) := (zero_smul_eq_zero Av _).symm
          _ = Av.smul (kroneckerDelta Si T) (Av.smul σ (E S T)) := by
              rw [kroneckerDelta, if_neg (fun h => hT h.symm)]
    -- （ロ）ℰ_{S,S} ·_A a_i = σ ∗_A ℰ_{S,S∪{i}}
    have hII : A.mul (E S S) (D.annihilation i) = A.smul σ (E S Si) := calc
      A.mul (E S S) (D.annihilation i) = A.mul (A.mul (A.mul cS P) aS) (D.annihilation i) := rfl
      _ = A.mul (A.mul cS P) (A.mul aS (D.annihilation i)) := A.mul_assoc _ _ _
      _ = A.mul (A.mul cS P) (A.smul σ (D.reverseOrderedAnnihilationProduct Si)) := by
          rw [D.reverseOrderedAnnihilationProduct_mul_annihilation_of_not_mem hi S hiS]
      _ = A.smul σ (A.mul (A.mul cS P) (D.reverseOrderedAnnihilationProduct Si)) := (A.smul_mul_right _ _ _).symm
      _ = A.smul σ (E S Si) := rfl
    calc sumOverFiniteSet Av hX (fun T => Mat.entry (annihilationMatrix D.M i hi) S T) (fun T => E S T)
        = sumOverFiniteSet Av hX (fun T => kroneckerDelta Si T) (fun T => Av.smul σ (E S T)) :=
          sumOverFiniteSet_congr Av hX _ _ _ _ hI
      _ = Av.smul σ (E S Si) := sumOverFiniteSet_kroneckerDelta Av hX (fun T => Av.smul σ (E S T)) Si
      _ = A.mul (E S S) (D.annihilation i) := hII.symm
  · -- i ∈ S のとき
    have hiS' : i ∈ S.1 := not_not.mp hiS
    -- （ハ）(c_i^T)_{S,T} ∗ ℰ_{S,T} = 0_A
    have hIII : ∀ T : PowerSet D.M,
        Av.smul (Mat.entry (annihilationMatrix D.M i hi) S T) (E S T) = Av.zero := by
      intro T
      calc Av.smul (Mat.entry (annihilationMatrix D.M i hi) S T) (E S T)
          = Av.smul (Mat.entry (creationMatrix D.M i hi) T S) (E S T) := by rw [annihilationMatrix_entry hi S T]
        _ = Av.smul 0 (E S T) := by rw [creationMatrix_entry_of_not_cond hi (fun h => h.1 hiS')]
        _ = Av.zero := zero_smul_eq_zero Av _
    calc sumOverFiniteSet Av hX (fun T => Mat.entry (annihilationMatrix D.M i hi) S T) (fun T => E S T)
        = A.zero := sumOverFiniteSet_eq_zero_of_terms_eq_zero Av hX _ _ hIII
      _ = A.mul (A.mul cS P) A.zero := (mul_zero_eq_zero A _).symm
      _ = A.mul (A.mul cS P) (A.mul aS (D.annihilation i)) := by
          rw [D.reverseOrderedAnnihilationProduct_mul_annihilation_of_mem hi S hiS']
      _ = A.mul (A.mul (A.mul cS P) aS) (D.annihilation i) := (A.mul_assoc _ _ _).symm
      _ = A.mul (E S S) (D.annihilation i) := rfl

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix`：Ψ(c_i^T) = a_i。 -/
theorem homomorphismFromMatrix_annihilationMatrix {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.homomorphismFromMatrix (annihilationMatrix D.M i hi) = D.annihilation i := by
  let A := D.space.cliffordAlgebra
  let Av := A.toComplexVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := D.matrixUnitElement
  let c := annihilationMatrix D.M i hi
  calc D.homomorphismFromMatrix c
      = sumOverFiniteSet Av hX (fun _ => 1) (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry c S T) (E S)) := rfl
    _ = sumOverFiniteSet Av hX (fun _ => 1) (fun S => A.mul (E S S) (D.annihilation i)) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ fun S => by
          rw [D.sum_annihilationMatrix_entry_smul_matrixUnitElement hi S]
    _ = A.mul (sumOverFiniteSet Av hX (fun _ => 1) (fun S => E S S)) (D.annihilation i) :=
        ((rightMul_isLinearMap A (D.annihilation i)).map_sumOverFiniteSet hX _ _).symm
    _ = A.mul (sumOverFiniteSet Av hX (fun _ => 1)
          (fun S => A.mul (A.mul (D.orderedCreationProduct S) D.vacuumElement) (D.reverseOrderedAnnihilationProduct S)))
          (D.annihilation i) := rfl
    _ = A.mul A.one (D.annihilation i) := by rw [D.decomposition_of_unity]
    _ = D.annihilation i := A.one_mul _

/-- 本文 `claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators`：
γ((x, g)) = (Σ_{k=1}^{M} β^w_k(x) ∗_A a†_k) +_A (Σ_{k=1}^{M} g(w_k) ∗_A a_k)。 -/
theorem γ_pair_eq_creation_add_annihilation (x : W) (g : DualSpace D.spaceW) :
    D.space.γ (x, g)
      = D.space.cliffordAlgebra.add
          (linearCombination D.space.cliffordAlgebra.toComplexVectorSpace D.M
            (fun k => coordinate D.spaceW D.M D.w D.isBasis k x) D.creation)
          (linearCombination D.space.cliffordAlgebra.toComplexVectorSpace D.M (fun k => g.1 (D.w k)) D.annihilation) := by
  let A := D.space.cliffordAlgebra
  let Av := A.toComplexVectorSpace
  let SW := D.spaceW
  let SWd := dualSpaceVectorSpace D.spaceW
  -- 準備：γ ∘ in_1 と γ ∘ in_2 は線型写像
  have h1 : IsComplexLinearMap SW Av (fun y => D.space.γ (embedFirst SWd y)) :=
    IsComplexLinearMap.comp (embedFirst_isLinearMap SW SWd) D.space.γ_isLinearMap
  have h2 : IsComplexLinearMap SWd Av (fun h => D.space.γ (embedSecond SW h)) :=
    IsComplexLinearMap.comp (embedSecond_isLinearMap SW SWd) D.space.γ_isLinearMap
  have hfirst : D.space.γ (embedFirst SWd x)
      = linearCombination Av D.M (fun k => coordinate SW D.M D.w D.isBasis k x) D.creation := calc
    D.space.γ (embedFirst SWd x) = (fun y => D.space.γ (embedFirst SWd y)) x := rfl
    _ = (fun y => D.space.γ (embedFirst SWd y))
          (linearCombination SW D.M (fun k => coordinate SW D.M D.w D.isBasis k x) D.w) :=
        congrArg (fun y => D.space.γ (embedFirst SWd y)) (linearCombination_coordinate SW D.M D.w D.isBasis x).symm
    _ = linearCombination Av D.M (fun k => coordinate SW D.M D.w D.isBasis k x)
          (fun k => D.space.γ (embedFirst SWd (D.w k))) := h1.map_linearCombination _ _ _
    _ = linearCombination Av D.M (fun k => coordinate SW D.M D.w D.isBasis k x) D.creation := rfl
  have hsecond : D.space.γ (embedSecond SW g)
      = linearCombination Av D.M (fun k => g.1 (D.w k)) D.annihilation := calc
    D.space.γ (embedSecond SW g) = (fun h => D.space.γ (embedSecond SW h)) g := rfl
    _ = (fun h => D.space.γ (embedSecond SW h)) (linearCombination SWd D.M (fun k => g.1 (D.w k)) D.f) :=
        congrArg (fun h => D.space.γ (embedSecond SW h)) (dualBasis_spans SW D.M D.w D.isBasis D.f D.isDualBasis g)
    _ = linearCombination Av D.M (fun k => g.1 (D.w k)) (fun k => D.space.γ (embedSecond SW (D.f k))) :=
        h2.map_linearCombination _ _ _
    _ = linearCombination Av D.M (fun k => g.1 (D.w k)) D.annihilation := rfl
  calc D.space.γ (x, g)
      = D.space.γ (DirectSum.add SW SWd (embedFirst SWd x) (embedSecond SW g)) :=
        congrArg D.space.γ (pair_eq_add_embed SW SWd x g)
    _ = A.add (D.space.γ (embedFirst SWd x)) (D.space.γ (embedSecond SW g)) := D.space.γ_add _ _
    _ = A.add (linearCombination Av D.M (fun k => coordinate SW D.M D.w D.isBasis k x) D.creation)
          (D.space.γ (embedSecond SW g)) := by rw [hfirst]
    _ = A.add (linearCombination Av D.M (fun k => coordinate SW D.M D.w D.isBasis k x) D.creation)
          (linearCombination Av D.M (fun k => g.1 (D.w k)) D.annihilation) := by rw [hsecond]

/-- 本文 `claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity`：Ψ(Φ(a)) = a。 -/
theorem homomorphismFromMatrix_homomorphismToMatrix (a : D.space.Cl) :
    D.homomorphismFromMatrix (D.homomorphismToMatrix a) = a := by
  let A := D.space.cliffordAlgebra
  let Av := A.toComplexVectorSpace
  let Φ := D.homomorphismToMatrix
  let Ψ := D.homomorphismFromMatrix
  -- Ψ ∘ Φ は ℂ-代数の準同型、id_A も ℂ-代数の準同型
  have hcomp : IsComplexAlgebraHomomorphism A A (fun x => Ψ (Φ x)) :=
    IsComplexAlgebraHomomorphism.comp D.homomorphismToMatrix_isHom D.homomorphismFromMatrix_isHom
  have hid : IsComplexAlgebraHomomorphism A A (fun x => x) := isComplexAlgebraHomomorphism_id A
  -- 準備：(Ψ ∘ Φ)(a†_k) = a†_k、(Ψ ∘ Φ)(a_k) = a_k
  have hcre : ∀ k : ℕ, 1 ≤ k → k ≤ D.M → Ψ (Φ (D.creation k)) = D.creation k := by
    intro k hk1 hkM
    calc Ψ (Φ (D.creation k)) = Ψ (creationMatrix D.M k ⟨hk1, hkM⟩) := by
          rw [show Φ (D.creation k) = _ from D.homomorphismToMatrix_creation ⟨hk1, hkM⟩]
      _ = D.creation k := D.homomorphismFromMatrix_creationMatrix ⟨hk1, hkM⟩
  have hann : ∀ k : ℕ, 1 ≤ k → k ≤ D.M → Ψ (Φ (D.annihilation k)) = D.annihilation k := by
    intro k hk1 hkM
    calc Ψ (Φ (D.annihilation k)) = Ψ (annihilationMatrix D.M k ⟨hk1, hkM⟩) := by
          rw [show Φ (D.annihilation k) = _ from D.homomorphismToMatrix_annihilation ⟨hk1, hkM⟩]
      _ = D.annihilation k := D.homomorphismFromMatrix_annihilationMatrix ⟨hk1, hkM⟩
  have hagree : ∀ y ∈ Set.range D.space.γ, Ψ (Φ y) = y := by
    rintro _ ⟨⟨x, g⟩, rfl⟩
    let cx : ℕ → ℂ := fun k => coordinate D.spaceW D.M D.w D.isBasis k x
    let cg : ℕ → ℂ := fun k => g.1 (D.w k)
    calc Ψ (Φ (D.space.γ (x, g)))
        = Ψ (Φ (A.add (linearCombination Av D.M cx D.creation) (linearCombination Av D.M cg D.annihilation))) := by
          rw [D.γ_pair_eq_creation_add_annihilation x g]
      _ = A.add (Ψ (Φ (linearCombination Av D.M cx D.creation))) (Ψ (Φ (linearCombination Av D.M cg D.annihilation))) :=
          hcomp.map_add _ _
      _ = A.add (linearCombination Av D.M cx (fun k => Ψ (Φ (D.creation k))))
            (linearCombination Av D.M cg (fun k => Ψ (Φ (D.annihilation k)))) := by
          rw [hcomp.isLinearMap.map_linearCombination, hcomp.isLinearMap.map_linearCombination]
      _ = A.add (linearCombination Av D.M cx D.creation) (linearCombination Av D.M cg D.annihilation) := by
          rw [linearCombination_eq_of_terms_eq Av D.M _ D.creation cx cx fun k hk1 hkM => by rw [hcre k hk1 hkM],
            linearCombination_eq_of_terms_eq Av D.M _ D.annihilation cg cg fun k hk1 hkM => by rw [hann k hk1 hkM]]
      _ = D.space.γ (x, g) := (D.γ_pair_eq_creation_add_annihilation x g).symm
  -- 生成元で一致する準同型は等しい（γ(V) は A を生成する）
  exact eq_of_agree_on_generators hcomp hid (Set.range D.space.γ) D.space.γ_generates hagree a

/-- 本文 `theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra`：
Φ と Ψ は ℂ-代数の準同型で、Ψ(Φ(a)) = a、Φ(Ψ(F)) = F。Φ は全単射で、Φ(a) = F を満たす a は Ψ(F) である。 -/
theorem cliffordAlgebra_isomorphic_matrixAlgebra :
    IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.matrixAlgebra D.homomorphismToMatrix ∧
      IsComplexAlgebraHomomorphism D.matrixAlgebra D.space.cliffordAlgebra D.homomorphismFromMatrix ∧
      (∀ a : D.space.Cl, D.homomorphismFromMatrix (D.homomorphismToMatrix a) = a) ∧
      (∀ F : Mat (PowerSet D.M), D.homomorphismToMatrix (D.homomorphismFromMatrix F) = F) ∧
      Function.Bijective D.homomorphismToMatrix ∧
      (∀ (F : Mat (PowerSet D.M)) (a : D.space.Cl), D.homomorphismToMatrix a = F → a = D.homomorphismFromMatrix F) := by
  let Φ := D.homomorphismToMatrix
  let Ψ := D.homomorphismFromMatrix
  -- 単射であること
  have hinj : Function.Injective Φ := by
    intro a b hab
    calc a = Ψ (Φ a) := (D.homomorphismFromMatrix_homomorphismToMatrix a).symm
      _ = Ψ (Φ b) := by rw [hab]
      _ = b := D.homomorphismFromMatrix_homomorphismToMatrix b
  -- 全射であること
  have hsurj : Function.Surjective Φ := fun F => ⟨Ψ F, D.homomorphismToMatrix_homomorphismFromMatrix F⟩
  -- Φ^{-1}(F) = Ψ(F)：Φ(a) = F を満たすただ一つの a は Ψ(F)
  have hinv : ∀ (F : Mat (PowerSet D.M)) (a : D.space.Cl), Φ a = F → a = Ψ F := by
    intro F a ha
    apply hinj
    calc Φ a = F := ha
      _ = Φ (Ψ F) := (D.homomorphismToMatrix_homomorphismFromMatrix F).symm
  exact ⟨D.homomorphismToMatrix_isHom, D.homomorphismFromMatrix_isHom,
    D.homomorphismFromMatrix_homomorphismToMatrix, D.homomorphismToMatrix_homomorphismFromMatrix,
    ⟨hinj, hsurj⟩, hinv⟩

end

end CliffordMatrixIsomorphism.Clifford.SplitData
