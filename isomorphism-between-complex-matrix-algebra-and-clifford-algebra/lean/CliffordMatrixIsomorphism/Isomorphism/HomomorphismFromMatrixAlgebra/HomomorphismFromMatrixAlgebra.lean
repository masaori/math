/-
章「同型の証明」の節「行列環からクリフォード代数への準同型」の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                                       このファイル
  def_matrix_unit_element_of_split_clifford_algebra                                                  matrixUnitElement（ℰ_{S,T}）
  claim_product_of_matrix_unit_elements_of_split_clifford_algebra                                    matrixUnitElement_mul
  def_homomorphism_from_matrix_algebra_to_clifford_algebra                                           homomorphismFromMatrix（Ψ）
  claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map                           homomorphismFromMatrix_isLinearMap
  claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit                          homomorphismFromMatrix_matrixUnit
  claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units       homomorphismFromMatrix_mul_matrixUnit
  claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism                 homomorphismFromMatrix_isHom

表し方:
- 宣言は `GlobalIdentities.lean` と同じく名前空間 `Clifford.SplitData` に置く。A := Cl(V,q) は `D.space.cliffordAlgebra`、
  B := Mat_{P_M}(ℂ) は `D.matrixAlgebra`、P_M が有限集合であることは `isFiniteSet_powerSet D.M`（証明の中では hX）。
- B の線型空間 U_vec(B) は `D.matrixAlgebra.toComplexVectorSpace` で、本文 claim_matrices_indexed_by_finite_set_form_complex_vector_space の
  `matricesVectorSpace` と定義どおりに一致する（`matricesComplexAlgebra_toComplexVectorSpace`、rfl）。
- 本文が「行列の和・スカラー倍・単位行列の定義」と項ごとの比較を引く行は、項ごとの等式が `rfl` の
  `sumOverFiniteSet_double_congr` の行である。

必要十分版は `NecSuf/Isomorphism/HomomorphismFromMatrixAlgebra/HomomorphismFromMatrixAlgebra.lean`、
導出版は `HomomorphismFromMatrixAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.GlobalIdentities.GlobalIdentities
import CliffordMatrixIsomorphism.Isomorphism.HomomorphismToMatrixAlgebra.HomomorphismToMatrixAlgebra
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixUnits.MatrixUnits
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Product

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- 本文 `def_matrix_unit_element_of_split_clifford_algebra`：ℰ_{S,T} := (a†_S ·_A P) ·_A a_T。 -/
def matrixUnitElement (S T : PowerSet D.M) : D.space.Cl :=
  D.space.cliffordAlgebra.mul (D.space.cliffordAlgebra.mul (D.orderedCreationProduct S) D.vacuumElement)
    (D.reverseOrderedAnnihilationProduct T)

/-- 本文 `claim_product_of_matrix_unit_elements_of_split_clifford_algebra`：ℰ_{S,T} ·_A ℰ_{U,R} = δ_{T,U} ∗_A ℰ_{S,R}。 -/
theorem matrixUnitElement_mul (S T U R : PowerSet D.M) :
    D.space.cliffordAlgebra.mul (D.matrixUnitElement S T) (D.matrixUnitElement U R)
      = D.space.cliffordAlgebra.smul (kroneckerDelta T U) (D.matrixUnitElement S R) := by
  let A := D.space.cliffordAlgebra
  let cS := D.orderedCreationProduct S
  let cU := D.orderedCreationProduct U
  let aT := D.reverseOrderedAnnihilationProduct T
  let aR := D.reverseOrderedAnnihilationProduct R
  let P := D.vacuumElement
  calc A.mul (D.matrixUnitElement S T) (D.matrixUnitElement U R)
      = A.mul (A.mul (A.mul cS P) aT) (A.mul (A.mul cU P) aR) := rfl
    _ = A.mul (A.mul cS P) (A.mul aT (A.mul (A.mul cU P) aR)) := A.mul_assoc _ _ _
    _ = A.mul (A.mul cS P) (A.mul (A.mul aT (A.mul cU P)) aR) := by rw [A.mul_assoc aT (A.mul cU P) aR]
    _ = A.mul (A.mul cS P) (A.mul (A.mul (A.mul aT cU) P) aR) := by rw [A.mul_assoc aT cU P]
    _ = A.mul (A.mul (A.mul cS P) (A.mul (A.mul aT cU) P)) aR := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.mul cS (A.mul P (A.mul (A.mul aT cU) P))) aR := by rw [A.mul_assoc cS P]
    _ = A.mul (A.mul cS (A.mul (A.mul P (A.mul aT cU)) P)) aR := by rw [A.mul_assoc P (A.mul aT cU) P]
    _ = A.mul (A.mul cS (A.smul (kroneckerDelta T U) P)) aR := by rw [D.vacuumElement_sandwich T U]
    _ = A.mul (A.smul (kroneckerDelta T U) (A.mul cS P)) aR := by rw [A.smul_mul_right]
    _ = A.smul (kroneckerDelta T U) (A.mul (A.mul cS P) aR) := (A.smul_mul_left _ _ _).symm
    _ = A.smul (kroneckerDelta T U) (D.matrixUnitElement S R) := rfl

/-- 本文 `def_homomorphism_from_matrix_algebra_to_clifford_algebra`：
Ψ(F) := Σ_{S∈P_M} 1_ℂ ∗_A (Σ_{T∈P_M} F_{S,T} ∗_A ℰ_{S,T})（U_vec(A) の中の有限集合の上の和）。 -/
def homomorphismFromMatrix (F : Mat (PowerSet D.M)) : D.space.Cl :=
  sumOverFiniteSet D.space.cliffordAlgebra.toComplexVectorSpace (isFiniteSet_powerSet D.M) (fun _ => 1)
    (fun S => sumOverFiniteSet D.space.cliffordAlgebra.toComplexVectorSpace (isFiniteSet_powerSet D.M)
      (fun T => Mat.entry F S T) (fun T => D.matrixUnitElement S T))

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map`：
Ψ は (B, +_B, ∗_B, 0_B) から U_vec(A) への線型写像。 -/
theorem homomorphismFromMatrix_isLinearMap :
    IsComplexLinearMap (matricesVectorSpace (PowerSet D.M)) D.space.cliffordAlgebra.toComplexVectorSpace
      D.homomorphismFromMatrix := by
  let A := D.space.cliffordAlgebra
  let Av := A.toComplexVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := D.matrixUnitElement
  constructor
  · intro F G
    -- （イ）Σ_T (F_{S,T} + G_{S,T}) ∗ ℰ_{S,T} = (Σ_T F_{S,T} ∗ ℰ_{S,T}) + (Σ_T G_{S,T} ∗ ℰ_{S,T})
    have hI : ∀ S : PowerSet D.M,
        sumOverFiniteSet Av hX (fun T => Mat.entry F S T + Mat.entry G S T) (E S)
          = Av.add (sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S))
              (sumOverFiniteSet Av hX (fun T => Mat.entry G S T) (E S)) := fun S =>
      (sumOverFiniteSet_add_of_same_family Av hX (E S) _ _).symm
    calc D.homomorphismFromMatrix ((matricesVectorSpace (PowerSet D.M)).add F G)
        = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry (Mat.add F G) S T) (E S)) := rfl
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T + Mat.entry G S T) (E S)) :=
          sumOverFiniteSet_double_congr Av hX hX _ _ _ _ fun _ _ => rfl
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => Av.add (sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S))
              (sumOverFiniteSet Av hX (fun T => Mat.entry G S T) (E S))) :=
          sumOverFiniteSet_congr Av hX _ _ _ _ fun S => by rw [hI S]
      _ = Av.add (sumOverFiniteSet Av hX (fun _ => 1)
              (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S)))
            (sumOverFiniteSet Av hX (fun _ => 1)
              (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry G S T) (E S))) :=
          (sumOverFiniteSet_add_of_same_coefficients Av hX _ _ _).symm
      _ = Av.add (D.homomorphismFromMatrix F) (D.homomorphismFromMatrix G) := rfl
  · intro ρ F
    -- （ロ）Σ_T (ρ · F_{S,T}) ∗ ℰ_{S,T} = ρ ∗ (Σ_T F_{S,T} ∗ ℰ_{S,T})
    have hII : ∀ S : PowerSet D.M,
        sumOverFiniteSet Av hX (fun T => ρ * Mat.entry F S T) (E S)
          = Av.smul ρ (sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S)) := fun S =>
      (smul_sumOverFiniteSet Av hX (E S) _ ρ).symm
    -- （ハ）1 ∗ (ρ ∗ a) = (ρ · 1) ∗ a
    have hIII : ∀ a : D.space.Cl, Av.smul 1 (Av.smul ρ a) = Av.smul (ρ * 1) a := fun a => calc
      Av.smul 1 (Av.smul ρ a) = Av.smul (1 * ρ) a := (Av.smul_assoc 1 ρ a).symm
      _ = Av.smul (ρ * 1) a := by rw [mul_comm 1 ρ]
    calc D.homomorphismFromMatrix ((matricesVectorSpace (PowerSet D.M)).smul ρ F)
        = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry (Mat.smul ρ F) S T) (E S)) := rfl
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => ρ * Mat.entry F S T) (E S)) :=
          sumOverFiniteSet_double_congr Av hX hX _ _ _ _ fun _ _ => rfl
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => Av.smul ρ (sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S))) :=
          sumOverFiniteSet_congr Av hX _ _ _ _ fun S => by rw [hII S]
      _ = sumOverFiniteSet Av hX (fun _ => ρ * 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S)) :=
          sumOverFiniteSet_congr Av hX _ _ _ _ fun S => hIII _
      _ = Av.smul ρ (sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S))) :=
          (smul_sumOverFiniteSet Av hX _ _ ρ).symm
      _ = Av.smul ρ (D.homomorphismFromMatrix F) := rfl

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit`：Ψ(E_{S,T}) = ℰ_{S,T}。 -/
theorem homomorphismFromMatrix_matrixUnit (S T : PowerSet D.M) :
    D.homomorphismFromMatrix (matrixUnit S T) = D.matrixUnitElement S T := by
  let A := D.space.cliffordAlgebra
  let Av := A.toComplexVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := D.matrixUnitElement
  -- （イ）(E_{S,T})_{S',T'} ∗ ℰ_{S',T'} = δ_{T,T'} ∗ (δ_{S,S'} ∗ ℰ_{S',T'})
  have hI : ∀ S' T' : PowerSet D.M,
      Av.smul (Mat.entry (matrixUnit S T) S' T') (E S' T')
        = Av.smul (kroneckerDelta T T') (Av.smul (kroneckerDelta S S') (E S' T')) := fun S' T' => calc
    Av.smul (Mat.entry (matrixUnit S T) S' T') (E S' T')
        = Av.smul (kroneckerDelta S S' * kroneckerDelta T T') (E S' T') := rfl
    _ = Av.smul (kroneckerDelta T T' * kroneckerDelta S S') (E S' T') := by
        rw [mul_comm (kroneckerDelta S S') (kroneckerDelta T T')]
    _ = Av.smul (kroneckerDelta T T') (Av.smul (kroneckerDelta S S') (E S' T')) := Av.smul_assoc _ _ _
  -- （ロ）Σ_{T'} δ_{T,T'} ∗ (δ_{S,S'} ∗ ℰ_{S',T'}) = δ_{S,S'} ∗ ℰ_{S',T}
  have hII : ∀ S' : PowerSet D.M,
      sumOverFiniteSet Av hX (fun T' => kroneckerDelta T T') (fun T' => Av.smul (kroneckerDelta S S') (E S' T'))
        = Av.smul (kroneckerDelta S S') (E S' T) := fun S' =>
    sumOverFiniteSet_kroneckerDelta Av hX (fun T' => Av.smul (kroneckerDelta S S') (E S' T')) T
  -- （ハ）1 ∗ (δ_{S,S'} ∗ ℰ_{S',T}) = δ_{S,S'} ∗ ℰ_{S',T}
  have hIII : ∀ S' : PowerSet D.M,
      Av.smul 1 (Av.smul (kroneckerDelta S S') (E S' T)) = Av.smul (kroneckerDelta S S') (E S' T) :=
    fun S' => calc
    Av.smul 1 (Av.smul (kroneckerDelta S S') (E S' T)) = Av.smul (1 * kroneckerDelta S S') (E S' T) :=
        (Av.smul_assoc _ _ _).symm
    _ = Av.smul (kroneckerDelta S S') (E S' T) := by rw [one_mul]
  calc D.homomorphismFromMatrix (matrixUnit S T)
      = sumOverFiniteSet Av hX (fun _ => 1)
          (fun S' => sumOverFiniteSet Av hX (fun T' => Mat.entry (matrixUnit S T) S' T') (E S')) := rfl
    _ = sumOverFiniteSet Av hX (fun _ => 1)
          (fun S' => sumOverFiniteSet Av hX (fun T' => kroneckerDelta T T')
            (fun T' => Av.smul (kroneckerDelta S S') (E S' T'))) :=
        sumOverFiniteSet_double_congr Av hX hX _ _ _ _ hI
    _ = sumOverFiniteSet Av hX (fun _ => 1) (fun S' => Av.smul (kroneckerDelta S S') (E S' T)) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ fun S' => by rw [hII S']
    _ = sumOverFiniteSet Av hX (fun S' => kroneckerDelta S S') (fun S' => E S' T) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ hIII
    _ = E S T := sumOverFiniteSet_kroneckerDelta Av hX (fun S' => E S' T) S

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units`：
Ψ(E_{S,T} ·_B E_{U,R}) = Ψ(E_{S,T}) ·_A Ψ(E_{U,R})。 -/
theorem homomorphismFromMatrix_mul_matrixUnit (S T U R : PowerSet D.M) :
    D.homomorphismFromMatrix (D.matrixAlgebra.mul (matrixUnit S T) (matrixUnit U R))
      = D.space.cliffordAlgebra.mul (D.homomorphismFromMatrix (matrixUnit S T))
          (D.homomorphismFromMatrix (matrixUnit U R)) := by
  let A := D.space.cliffordAlgebra
  calc D.homomorphismFromMatrix (D.matrixAlgebra.mul (matrixUnit S T) (matrixUnit U R))
      = D.homomorphismFromMatrix (Mat.smul (kroneckerDelta T U) (matrixUnit S R)) := by
        rw [show D.matrixAlgebra.mul (matrixUnit S T) (matrixUnit U R)
          = Mat.smul (kroneckerDelta T U) (matrixUnit S R)
          from matrixUnit_mul_matrixUnit (isFiniteSet_powerSet D.M) S T U R]
    _ = A.smul (kroneckerDelta T U) (D.homomorphismFromMatrix (matrixUnit S R)) :=
        D.homomorphismFromMatrix_isLinearMap.map_smul _ _
    _ = A.smul (kroneckerDelta T U) (D.matrixUnitElement S R) := by rw [D.homomorphismFromMatrix_matrixUnit S R]
    _ = A.mul (D.matrixUnitElement S T) (D.matrixUnitElement U R) := (D.matrixUnitElement_mul S T U R).symm
    _ = A.mul (D.homomorphismFromMatrix (matrixUnit S T)) (D.homomorphismFromMatrix (matrixUnit U R)) := by
        rw [D.homomorphismFromMatrix_matrixUnit S T, D.homomorphismFromMatrix_matrixUnit U R]

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism`：
Ψ は ℂ-代数 B から ℂ-代数 A への ℂ-代数の準同型。 -/
theorem homomorphismFromMatrix_isHom :
    IsComplexAlgebraHomomorphism D.matrixAlgebra D.space.cliffordAlgebra D.homomorphismFromMatrix := by
  let A := D.space.cliffordAlgebra
  let Av := A.toComplexVectorSpace
  let B := D.matrixAlgebra
  let Bv := B.toComplexVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := D.matrixUnitElement
  let Ψ := D.homomorphismFromMatrix
  have hΨ : IsComplexLinearMap Bv Av Ψ := D.homomorphismFromMatrix_isLinearMap
  -- （イ）乗法の単位元
  have hdelta : ∀ S : PowerSet D.M, sumOverFiniteSet Av hX (fun T => kroneckerDelta S T) (E S) = E S S :=
    fun S => sumOverFiniteSet_kroneckerDelta Av hX (E S) S
  have hone : Ψ B.one = A.one := calc
    Ψ B.one = sumOverFiniteSet Av hX (fun _ => 1)
          (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry (Mat.one : Mat (PowerSet D.M)) S T) (E S)) := rfl
    _ = sumOverFiniteSet Av hX (fun _ => 1)
          (fun S => sumOverFiniteSet Av hX (fun T => kroneckerDelta S T) (E S)) :=
        sumOverFiniteSet_double_congr Av hX hX _ _ _ _ fun _ _ => rfl
    _ = sumOverFiniteSet Av hX (fun _ => 1) (fun S => E S S) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ fun S => by rw [hdelta S]
    _ = sumOverFiniteSet Av hX (fun _ => 1)
          (fun S => A.mul (A.mul (D.orderedCreationProduct S) D.vacuumElement) (D.reverseOrderedAnnihilationProduct S)) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ fun _ => rfl
    _ = A.one := D.decomposition_of_unity
  -- 行列の行列単位による分解（claim_matrix_is_double_sum_of_entries_times_matrix_units）
  have hdecomp : ∀ G : Mat (PowerSet D.M), G = sumOverFiniteSet Bv hX (fun _ => 1)
      (fun S' => sumOverFiniteSet Bv hX (fun T' => Mat.entry G S' T') (fun T' => matrixUnit S' T')) :=
    fun G => eq_double_sum_entry_smul_matrixUnit hX G
  -- （ロ）行列単位を左に置いた積
  have hleft : ∀ (S T : PowerSet D.M) (G : Mat (PowerSet D.M)),
      Ψ (B.mul (matrixUnit S T) G) = A.mul (Ψ (matrixUnit S T)) (Ψ G) := by
    intro S T G
    have hL := leftMul_isLinearMap B (matrixUnit S T)
    have hL' := leftMul_isLinearMap A (Ψ (matrixUnit S T))
    calc Ψ (B.mul (matrixUnit S T) G)
        = Ψ (B.mul (matrixUnit S T) (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Bv hX (fun T' => Mat.entry G S' T') (fun T' => matrixUnit S' T')))) := by
          rw [← hdecomp G]
      _ = Ψ (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Bv hX (fun T' => Mat.entry G S' T')
              (fun T' => B.mul (matrixUnit S T) (matrixUnit S' T')))) := by
          rw [hL.map_double_sumOverFiniteSet hX hX]
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Av hX (fun T' => Mat.entry G S' T')
              (fun T' => Ψ (B.mul (matrixUnit S T) (matrixUnit S' T')))) :=
          hΨ.map_double_sumOverFiniteSet hX hX _ _
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Av hX (fun T' => Mat.entry G S' T')
              (fun T' => A.mul (Ψ (matrixUnit S T)) (Ψ (matrixUnit S' T')))) :=
          sumOverFiniteSet_double_congr Av hX hX _ _ _ _ fun S' T' =>
            congrArg (Av.smul (Mat.entry G S' T')) (D.homomorphismFromMatrix_mul_matrixUnit S T S' T')
      _ = A.mul (Ψ (matrixUnit S T)) (sumOverFiniteSet Av hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Av hX (fun T' => Mat.entry G S' T') (fun T' => Ψ (matrixUnit S' T')))) :=
          (hL'.map_double_sumOverFiniteSet hX hX _ _).symm
      _ = A.mul (Ψ (matrixUnit S T)) (Ψ (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Bv hX (fun T' => Mat.entry G S' T') (fun T' => matrixUnit S' T')))) := by
          rw [hΨ.map_double_sumOverFiniteSet hX hX]
      _ = A.mul (Ψ (matrixUnit S T)) (Ψ G) := by rw [← hdecomp G]
  -- （ハ）乗法
  have hmul : ∀ F G : Mat (PowerSet D.M), Ψ (B.mul F G) = A.mul (Ψ F) (Ψ G) := by
    intro F G
    have hR := rightMul_isLinearMap B G
    have hR' := rightMul_isLinearMap A (Ψ G)
    calc Ψ (B.mul F G)
        = Ψ (B.mul (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S => sumOverFiniteSet Bv hX (fun T => Mat.entry F S T) (fun T => matrixUnit S T))) G) := by
          rw [← hdecomp F]
      _ = Ψ (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S => sumOverFiniteSet Bv hX (fun T => Mat.entry F S T) (fun T => B.mul (matrixUnit S T) G))) := by
          rw [hR.map_double_sumOverFiniteSet hX hX]
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (fun T => Ψ (B.mul (matrixUnit S T) G))) :=
          hΨ.map_double_sumOverFiniteSet hX hX _ _
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T)
              (fun T => A.mul (Ψ (matrixUnit S T)) (Ψ G))) :=
          sumOverFiniteSet_double_congr Av hX hX _ _ _ _ fun S T => by rw [hleft S T G]
      _ = A.mul (sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (fun T => Ψ (matrixUnit S T)))) (Ψ G) :=
          (hR'.map_double_sumOverFiniteSet hX hX _ _).symm
      _ = A.mul (Ψ (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S => sumOverFiniteSet Bv hX (fun T => Mat.entry F S T) (fun T => matrixUnit S T)))) (Ψ G) := by
          rw [hΨ.map_double_sumOverFiniteSet hX hX]
      _ = A.mul (Ψ F) (Ψ G) := by rw [← hdecomp F]
  exact ⟨⟨hΨ.map_add, hmul, hone⟩, hΨ⟩

end

end CliffordMatrixIsomorphism.Clifford.SplitData
