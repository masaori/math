/-
章「同型の証明」の節「二つの準同型が互いに逆であること」の必要十分版。具体版
`Isomorphism/MutuallyInverseHomomorphisms/MutuallyInverseHomomorphisms.lean` と同じ def と同じ calc の行のまま、
係数 ℂ を型の変数 K に、-1_ℂ を K の元 n に替える（ς は `sign n`、c_i・c_i^T は `creationMatrix n`・`annihilationMatrix n`）。
K には演算の記号 +・·・0・1・- だけを与え、使う性質は仮定として渡す。
本文のラベルと宣言の対応は具体版の冒頭の表と同じである（宣言の名前も同じ）。

主張ごとに使う K の性質（どの主張も、Cl(V,q) と Mat_{P_M}(K) の K の上の代数を作るための章「クリフォード代数」の仮定
`CliffordLaws K n` を持つ。下に書くのは、行の中でその欄から使う性質と、足す仮定である）:
  Φ(ℰ_{S,T}) = E_{S,T}                 a + (-a) = 0（hneg。Φ を普遍性から得るため）、0 と 1 がどの元とも交換すること
                                       （行列単位の積の規則）、空集合の位置の行列単位の三つの主張の仮定
                                       （a · 1 = a・a · 0 = 0・0 · a = 0・乗法の交換法則・`SignLaws K n`）
  Φ(Ψ(F)) = F                          a + (-a) = 0、0 + 0 = 0（Φ が二重の和を値の和へ移す）、0 と 1 の交換（行列の分解）
  生成作用素の列の和・消滅作用素の行の和
                                       a + (-a) = 0（生成元・消滅元を掛けた局所的な等式を引くため）、0 + 0 = 0、
                                       a · 0 = 0（零の項の和）。符号 ς(N_i(T)) の計算は行に現れない
  Ψ(c_i) = a†_i、Ψ(c_i^T) = a_i        a + (-a) = 0（1 の分解）、0 + 0 = 0（左・右から掛ける写像が和を移す）
  γ((x, g)) の線型結合への分解         0 + 0 = 0 と a · 0 = 0（成分への埋め込みが線型）、0 + a = a と a · 1 = a（双対基底が W^* を張る）。
                                       a + (-a) = 0 は使わない
  Ψ(Φ(a)) = a                          a + (-a) = 0、0 + 0 = 0（Ψ ∘ Φ が線型結合を移す）
  主定理                               a + (-a) = 0（上の二つの主張を引くため）

分かったこと:
- 主定理まで、K について章「クリフォード代数」の仮定のほかに要るのは a + (-a) = 0 だけである。2 の可逆性と平方根は、
  どの主張も使わない。本文の前提 M ∈ ℤ_{≥1} も、どの主張も使わない（M = 0 でも同じ証明が通る）。
- 乗法の交換法則が行の中で要るのは、0 と 1 の交換（δ の値が 0 か 1 なので）と、Ψ が線型であることの 1 · ρ = ρ · 1 だけである
  （`HomomorphismFromMatrixAlgebra.lean`）。行列環が K の上の代数であることが交換法則を要するので、主張全体からは外せない。

導出版は `Isomorphism/MutuallyInverseHomomorphisms/MutuallyInverseHomomorphismsFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.HomomorphismFromMatrixAlgebra.HomomorphismFromMatrixAlgebra
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.CreationOperatorMatrices.VacuumMatrixUnit
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Product
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.FiniteSetSum.DoubleSum
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.TensorAlgebraStructure

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.Isomorphism
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet)
open CliffordMatrixIsomorphism.NecSuf.Isomorphism (countBelow unionSingleton emptyIndexSet)
open CliffordMatrixIsomorphism.NecSuf.Clifford (CliffordLaws.signLaws)

universe u uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-- 本文 `claim_homomorphism_to_matrix_algebra_on_matrix_unit_element` の必要十分版：Φ(ℰ_{S,T}) = E_{S,T}。 -/
theorem homomorphismToMatrix_matrixUnitElement (hneg : ∀ a : K, a + -a = 0) (S T : PowerSet D.M) :
    (D.homomorphismToMatrix C hneg) ((D.matrixUnitElement C) S T) = matrixUnit S T := by
  let A := ((D.space C).cliffordAlgebra C)
  let B := (D.matrixAlgebra C)
  let Φ := (D.homomorphismToMatrix C hneg)
  have hΦ : IsAlgebraHomomorphism A B Φ := (D.homomorphismToMatrix_isHom C hneg)
  let E0 := emptyIndexSet D.M
  let Y := selectedCreation n D.M S
  let Zr := reversedSelectedAnnihilation n D.M T
  -- （イ）Φ(y^S_t) = Y_t、Φ(z^T_t) = Z_t
  have hY : ∀ t : ℕ, 1 ≤ t → t ≤ D.M → Φ ((D.selectedCreationFactor C) S t) = Y t := by
    intro t ht1 htM
    by_cases h : t ∈ S.1
    · calc Φ ((D.selectedCreationFactor C) S t) = Φ ((D.creation C) t) := by rw [(D.selectedCreationFactor_of_mem C) h]
        _ = creationMatrix n D.M t ⟨ht1, htM⟩ := (D.homomorphismToMatrix_creation C hneg) ⟨ht1, htM⟩
        _ = Y t := (selectedCreation_of_mem n ⟨ht1, htM⟩ h).symm
    · calc Φ ((D.selectedCreationFactor C) S t) = Φ A.one := by rw [(D.selectedCreationFactor_of_not_mem C) h]
        _ = B.one := hΦ.map_one
        _ = Y t := (selectedCreation_of_not_mem n h).symm
  have hZ : ∀ t : ℕ, 1 ≤ t → t ≤ D.M →
      Φ ((D.selectedAnnihilationFactor C) T t) = selectedAnnihilation n D.M T t := by
    intro t ht1 htM
    by_cases h : t ∈ T.1
    · calc Φ ((D.selectedAnnihilationFactor C) T t) = Φ ((D.annihilation C) t) := by
            rw [(D.selectedAnnihilationFactor_of_mem C) h]
        _ = annihilationMatrix n D.M t ⟨ht1, htM⟩ := (D.homomorphismToMatrix_annihilation C hneg) ⟨ht1, htM⟩
        _ = selectedAnnihilation n D.M T t := by unfold selectedAnnihilation; rw [dif_pos h]
    · calc Φ ((D.selectedAnnihilationFactor C) T t) = Φ A.one := by rw [(D.selectedAnnihilationFactor_of_not_mem C) h]
        _ = B.one := hΦ.map_one
        _ = selectedAnnihilation n D.M T t := by unfold selectedAnnihilation; rw [dif_neg h]; rfl
  -- Φ(ž^T_k) = Ž_k
  have hZr : ∀ k : ℕ, 1 ≤ k → k ≤ D.M → Φ ((D.reversedSelectedAnnihilationFactor C) T k) = Zr k := by
    intro k hk1 hkM
    calc Φ ((D.reversedSelectedAnnihilationFactor C) T k) = Φ ((D.selectedAnnihilationFactor C) T (D.M + 1 - k)) := rfl
      _ = selectedAnnihilation n D.M T (D.M + 1 - k) := hZ (D.M + 1 - k) (by omega) (by omega)
      _ = Zr k := rfl
  -- （ロ）Φ(x_i) = c_i^T ·_B c_i
  have hx : ∀ i : ℕ, 1 ≤ i → i ≤ D.M → Φ ((D.vacuumFactor C) i) = annihilationTimesCreation C.valuedMaps n D.M i := by
    intro i hi1 hiM
    calc Φ ((D.vacuumFactor C) i) = Φ (A.mul ((D.annihilation C) i) ((D.creation C) i)) := rfl
      _ = B.mul (Φ ((D.annihilation C) i)) (Φ ((D.creation C) i)) := hΦ.map_mul _ _
      _ = B.mul (annihilationMatrix n D.M i ⟨hi1, hiM⟩) (creationMatrix n D.M i ⟨hi1, hiM⟩) := by
          rw [show Φ ((D.annihilation C) i) = _ from (D.homomorphismToMatrix_annihilation C hneg) ⟨hi1, hiM⟩,
            show Φ ((D.creation C) i) = _ from (D.homomorphismToMatrix_creation C hneg) ⟨hi1, hiM⟩]
      _ = annihilationTimesCreation C.valuedMaps n D.M i := (annihilationTimesCreation_of_mem C.valuedMaps n ⟨hi1, hiM⟩).symm
  -- （ハ）三つの番号順の積の像
  have hcre : Φ ((D.orderedCreationProduct C) S) = AlgebraOver.orderedProduct B D.M Y := calc
    Φ ((D.orderedCreationProduct C) S) = Φ (AlgebraOver.orderedProduct A D.M ((D.selectedCreationFactor C) S)) := rfl
    _ = AlgebraOver.orderedProduct B D.M (fun t => Φ ((D.selectedCreationFactor C) S t)) := hΦ.map_orderedProduct D.M _
    _ = AlgebraOver.orderedProduct B D.M Y := orderedProduct_congr B D.M _ _ hY
  have hvac : Φ (D.vacuumElement C) = matrixUnit E0 E0 := calc
    Φ (D.vacuumElement C) = Φ (AlgebraOver.orderedProduct A D.M (D.vacuumFactor C)) := rfl
    _ = AlgebraOver.orderedProduct B D.M (fun i => Φ ((D.vacuumFactor C) i)) := hΦ.map_orderedProduct D.M _
    _ = AlgebraOver.orderedProduct B D.M (annihilationTimesCreation C.valuedMaps n D.M) := orderedProduct_congr B D.M _ _ hx
    _ = matrixUnit E0 E0 := orderedProduct_annihilationTimesCreation_eq_vacuumMatrixUnit C.valuedMaps C.mul_comm
        C.uniqueness.mul_zero C.mul_one C.uniqueness.zero_mul n C.signLaws D.M
  have hann : Φ ((D.reverseOrderedAnnihilationProduct C) T) = AlgebraOver.orderedProduct B D.M Zr := calc
    Φ ((D.reverseOrderedAnnihilationProduct C) T)
        = Φ (AlgebraOver.orderedProduct A D.M ((D.reversedSelectedAnnihilationFactor C) T)) := rfl
    _ = AlgebraOver.orderedProduct B D.M (fun k => Φ ((D.reversedSelectedAnnihilationFactor C) T k)) :=
        hΦ.map_orderedProduct D.M _
    _ = AlgebraOver.orderedProduct B D.M Zr := orderedProduct_congr B D.M _ _ hZr
  -- （ニ）E_{S,∅} ·_B E_{∅,∅} = E_{S,∅}
  have hD : B.mul (matrixUnit S E0) (matrixUnit E0 E0) = matrixUnit S E0 := calc
    B.mul (matrixUnit S E0) (matrixUnit E0 E0) = B.smul (kroneckerDelta E0 E0) (matrixUnit S E0) :=
        matrixUnit_mul_matrixUnit C.valuedMaps (fun a => C.mul_comm 0 a) (fun a => C.mul_comm 1 a)
          (isFiniteSet_powerSet D.M) S E0 E0 E0
    _ = B.smul 1 (matrixUnit S E0) := by rw [kroneckerDelta, if_pos rfl]
    _ = matrixUnit S E0 := B.one_smul _
  calc Φ ((D.matrixUnitElement C) S T)
      = Φ (A.mul (A.mul ((D.orderedCreationProduct C) S) (D.vacuumElement C)) ((D.reverseOrderedAnnihilationProduct C) T)) := rfl
    _ = B.mul (Φ (A.mul ((D.orderedCreationProduct C) S) (D.vacuumElement C))) (Φ ((D.reverseOrderedAnnihilationProduct C) T)) :=
        hΦ.map_mul _ _
    _ = B.mul (B.mul (Φ ((D.orderedCreationProduct C) S)) (Φ (D.vacuumElement C)))
          (Φ ((D.reverseOrderedAnnihilationProduct C) T)) := by rw [hΦ.map_mul]
    _ = B.mul (B.mul (AlgebraOver.orderedProduct B D.M Y) (Φ (D.vacuumElement C))) (Φ ((D.reverseOrderedAnnihilationProduct C) T)) := by
        rw [hcre]
    _ = B.mul (B.mul (AlgebraOver.orderedProduct B D.M Y) (matrixUnit E0 E0)) (Φ ((D.reverseOrderedAnnihilationProduct C) T)) := by
        rw [hvac]
    _ = B.mul (B.mul (AlgebraOver.orderedProduct B D.M Y) (matrixUnit E0 E0)) (AlgebraOver.orderedProduct B D.M Zr) := by rw [hann]
    _ = B.mul (matrixUnit S E0) (AlgebraOver.orderedProduct B D.M Zr) := by
        rw [show B.mul (AlgebraOver.orderedProduct B D.M Y) (matrixUnit E0 E0) = matrixUnit S E0
          from orderedProduct_selectedCreation_mul_vacuumMatrixUnit C.valuedMaps C.mul_comm
            C.uniqueness.mul_zero C.uniqueness.zero_mul n D.M S]
    _ = B.mul (B.mul (matrixUnit S E0) (matrixUnit E0 E0)) (AlgebraOver.orderedProduct B D.M Zr) := by rw [hD]
    _ = B.mul (matrixUnit S E0) (B.mul (matrixUnit E0 E0) (AlgebraOver.orderedProduct B D.M Zr)) := B.mul_assoc _ _ _
    _ = B.mul (matrixUnit S E0) (matrixUnit E0 T) := by
        rw [show B.mul (matrixUnit E0 E0) (AlgebraOver.orderedProduct B D.M Zr) = matrixUnit E0 T
          from vacuumMatrixUnit_mul_orderedProduct_reversedSelectedAnnihilation C.valuedMaps C.mul_comm
            C.uniqueness.mul_zero n D.M T]
    _ = B.smul (kroneckerDelta E0 E0) (matrixUnit S T) :=
        matrixUnit_mul_matrixUnit C.valuedMaps (fun a => C.mul_comm 0 a) (fun a => C.mul_comm 1 a)
          (isFiniteSet_powerSet D.M) S E0 E0 T
    _ = B.smul 1 (matrixUnit S T) := by rw [kroneckerDelta, if_pos rfl]
    _ = matrixUnit S T := B.one_smul _

/-- 本文 `claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity` の必要十分版：Φ(Ψ(F)) = F。 -/
theorem homomorphismToMatrix_homomorphismFromMatrix (hneg : ∀ a : K, a + -a = 0) (F : Mat K (PowerSet D.M)) :
    (D.homomorphismToMatrix C hneg) ((D.homomorphismFromMatrix C) F) = F := by
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  let A := ((D.space C).cliffordAlgebra C)
  let Av := A.toVectorSpace
  let Bv := (D.matrixAlgebra C).toVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let Φ := (D.homomorphismToMatrix C hneg)
  have hΦ : IsLinearMap Av Bv Φ := (D.homomorphismToMatrix_isHom C hneg).isLinearMap
  calc Φ ((D.homomorphismFromMatrix C) F)
      = Φ (sumOverFiniteSet Av hX (fun _ => 1)
          (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (fun T => (D.matrixUnitElement C) S T))) := rfl
    _ = sumOverFiniteSet Bv hX (fun _ => 1)
          (fun S => sumOverFiniteSet Bv hX (fun T => Mat.entry F S T) (fun T => Φ ((D.matrixUnitElement C) S T))) :=
        hΦ.map_double_sumOverFiniteSet h00 hX hX _ _
    _ = sumOverFiniteSet Bv hX (fun _ => 1)
          (fun S => sumOverFiniteSet Bv hX (fun T => Mat.entry F S T) (fun T => matrixUnit S T)) :=
        sumOverFiniteSet_double_congr Bv hX hX _ _ _ _ fun S T =>
          congrArg (Bv.smul (Mat.entry F S T)) ((D.homomorphismToMatrix_matrixUnitElement C hneg) S T)
    _ = F := (eq_double_sum_entry_smul_matrixUnit C.valuedMaps (fun a => C.mul_comm 0 a)
      (fun a => C.mul_comm 1 a) hX F).symm

/-- 本文 `claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements` の必要十分版：
Σ_{S∈P_M} (c_i)_{S,T} ∗_A ℰ_{S,T} = a†_i ·_A ℰ_{T,T}。 -/
theorem sum_creationMatrix_entry_smul_matrixUnitElement (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (T : PowerSet D.M) :
    sumOverFiniteSet ((D.space C).cliffordAlgebra C).toVectorSpace (isFiniteSet_powerSet D.M)
        (fun S => Mat.entry (creationMatrix n D.M i hi) S T) (fun S => (D.matrixUnitElement C) S T)
      = ((D.space C).cliffordAlgebra C).mul ((D.creation C) i) ((D.matrixUnitElement C) T T) := by
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  let A := ((D.space C).cliffordAlgebra C)
  let Av := A.toVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := (D.matrixUnitElement C)
  let cT := (D.orderedCreationProduct C) T
  let aT := (D.reverseOrderedAnnihilationProduct C) T
  let P := (D.vacuumElement C)
  by_cases hiT : i ∉ T.1
  · -- i ∉ T のとき。σ := ς(N_i(T))
    let σ : K := sign n (countBelow T i)
    let Ti := unionSingleton T i hi
    -- （イ）(c_i)_{S,T} ∗ ℰ_{S,T} = δ_{T∪{i},S} ∗ (σ ∗ ℰ_{S,T})
    have hI : ∀ S : PowerSet D.M,
        Av.smul (Mat.entry (creationMatrix n D.M i hi) S T) (E S T)
          = Av.smul (kroneckerDelta Ti S) (Av.smul σ (E S T)) := by
      intro S
      by_cases hS : S = Ti
      · calc Av.smul (Mat.entry (creationMatrix n D.M i hi) S T) (E S T) = Av.smul σ (E S T) := by
              rw [creationMatrix_entry_of_cond n hi ⟨hiT, hS⟩]
          _ = Av.smul 1 (Av.smul σ (E S T)) := (Av.one_smul _).symm
          _ = Av.smul (kroneckerDelta Ti S) (Av.smul σ (E S T)) := by rw [kroneckerDelta, if_pos hS.symm]
      · calc Av.smul (Mat.entry (creationMatrix n D.M i hi) S T) (E S T) = Av.smul 0 (E S T) := by
              rw [creationMatrix_entry_of_not_cond n hi (fun h => hS h.2)]
          _ = Av.zero := VectorSpace.zero_smul_eq_zero Av h00 _
          _ = Av.smul 0 (Av.smul σ (E S T)) := (VectorSpace.zero_smul_eq_zero Av h00 _).symm
          _ = Av.smul (kroneckerDelta Ti S) (Av.smul σ (E S T)) := by
              rw [kroneckerDelta, if_neg (fun h => hS h.symm)]
    -- （ロ）a†_i ·_A ℰ_{T,T} = σ ∗_A ℰ_{T∪{i},T}
    have hII : A.mul ((D.creation C) i) (E T T) = A.smul σ (E Ti T) := calc
      A.mul ((D.creation C) i) (E T T) = A.mul ((D.creation C) i) (A.mul (A.mul cT P) aT) := rfl
      _ = A.mul (A.mul ((D.creation C) i) (A.mul cT P)) aT := (A.mul_assoc _ _ _).symm
      _ = A.mul (A.mul (A.mul ((D.creation C) i) cT) P) aT := by rw [A.mul_assoc ((D.creation C) i) cT P]
      _ = A.mul (A.mul (A.smul σ ((D.orderedCreationProduct C) Ti)) P) aT := by
          rw [(D.creation_mul_orderedCreationProduct_of_not_mem C hneg) hi T hiT]
      _ = A.mul (A.smul σ (A.mul ((D.orderedCreationProduct C) Ti) P)) aT := by rw [A.smul_mul_left]
      _ = A.smul σ (A.mul (A.mul ((D.orderedCreationProduct C) Ti) P) aT) := (A.smul_mul_left _ _ _).symm
      _ = A.smul σ (E Ti T) := rfl
    calc sumOverFiniteSet Av hX (fun S => Mat.entry (creationMatrix n D.M i hi) S T) (fun S => E S T)
        = sumOverFiniteSet Av hX (fun S => kroneckerDelta Ti S) (fun S => Av.smul σ (E S T)) :=
          sumOverFiniteSet_congr Av hX _ _ _ _ hI
      _ = Av.smul σ (E Ti T) := sumOverFiniteSet_kroneckerDelta Av h00 hX (fun S => Av.smul σ (E S T)) Ti
      _ = A.mul ((D.creation C) i) (E T T) := hII.symm
  · -- i ∈ T のとき
    have hiT' : i ∈ T.1 := not_not.mp hiT
    -- （ハ）(c_i)_{S,T} ∗ ℰ_{S,T} = 0_A
    have hIII : ∀ S : PowerSet D.M, Av.smul (Mat.entry (creationMatrix n D.M i hi) S T) (E S T) = Av.zero := by
      intro S
      calc Av.smul (Mat.entry (creationMatrix n D.M i hi) S T) (E S T) = Av.smul 0 (E S T) := by
            rw [creationMatrix_entry_of_not_cond n hi (fun h => h.1 hiT')]
        _ = Av.zero := VectorSpace.zero_smul_eq_zero Av h00 _
    calc sumOverFiniteSet Av hX (fun S => Mat.entry (creationMatrix n D.M i hi) S T) (fun S => E S T)
        = A.zero := sumOverFiniteSet_eq_zero_of_terms_eq_zero Av h00 C.uniqueness.mul_zero hX _ _ hIII
      _ = A.mul A.zero aT := (zero_mul_eq_zero h00 A aT).symm
      _ = A.mul (A.mul A.zero P) aT := by rw [zero_mul_eq_zero h00 A P]
      _ = A.mul (A.mul (A.mul ((D.creation C) i) cT) P) aT := by
          rw [(D.creation_mul_orderedCreationProduct_of_mem C hneg) hi T hiT']
      _ = A.mul (A.mul ((D.creation C) i) (A.mul cT P)) aT := by rw [A.mul_assoc ((D.creation C) i) cT P]
      _ = A.mul ((D.creation C) i) (A.mul (A.mul cT P) aT) := A.mul_assoc _ _ _
      _ = A.mul ((D.creation C) i) (E T T) := rfl

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix` の必要十分版：Ψ(c_i) = a†_i。 -/
theorem homomorphismFromMatrix_creationMatrix (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    (D.homomorphismFromMatrix C) (creationMatrix n D.M i hi) = (D.creation C) i := by
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  let A := ((D.space C).cliffordAlgebra C)
  let Av := A.toVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := (D.matrixUnitElement C)
  let c := creationMatrix n D.M i hi
  calc (D.homomorphismFromMatrix C) c
      = sumOverFiniteSet Av hX (fun _ => 1) (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry c S T) (E S)) := rfl
    _ = sumOverFiniteSet Av hX (fun _ => 1)
          (fun T => sumOverFiniteSet Av hX (fun S => Mat.entry c S T) (fun S => E S T)) :=
        sumOverFiniteSet_interchange Av hX hX (fun S T => Mat.entry c S T) E
    _ = sumOverFiniteSet Av hX (fun _ => 1) (fun T => A.mul ((D.creation C) i) (E T T)) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ fun T => by
          rw [(D.sum_creationMatrix_entry_smul_matrixUnitElement C hneg) hi T]
    _ = A.mul ((D.creation C) i) (sumOverFiniteSet Av hX (fun _ => 1) (fun T => E T T)) :=
        ((leftMul_isLinearMap A ((D.creation C) i)).map_sumOverFiniteSet h00 hX _ _).symm
    _ = A.mul ((D.creation C) i) (sumOverFiniteSet Av hX (fun _ => 1)
          (fun T => A.mul (A.mul ((D.orderedCreationProduct C) T) (D.vacuumElement C)) ((D.reverseOrderedAnnihilationProduct C) T))) :=
        rfl
    _ = A.mul ((D.creation C) i) A.one := by rw [(D.decomposition_of_unity C hneg)]
    _ = (D.creation C) i := A.mul_one _

/-- 本文 `claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements` の必要十分版：
Σ_{T∈P_M} (c_i^T)_{S,T} ∗_A ℰ_{S,T} = ℰ_{S,S} ·_A a_i。 -/
theorem sum_annihilationMatrix_entry_smul_matrixUnitElement (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (S : PowerSet D.M) :
    sumOverFiniteSet ((D.space C).cliffordAlgebra C).toVectorSpace (isFiniteSet_powerSet D.M)
        (fun T => Mat.entry (annihilationMatrix n D.M i hi) S T) (fun T => (D.matrixUnitElement C) S T)
      = ((D.space C).cliffordAlgebra C).mul ((D.matrixUnitElement C) S S) ((D.annihilation C) i) := by
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  let A := ((D.space C).cliffordAlgebra C)
  let Av := A.toVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := (D.matrixUnitElement C)
  let cS := (D.orderedCreationProduct C) S
  let aS := (D.reverseOrderedAnnihilationProduct C) S
  let P := (D.vacuumElement C)
  by_cases hiS : i ∉ S.1
  · -- i ∉ S のとき。σ := ς(N_i(S))
    let σ : K := sign n (countBelow S i)
    let Si := unionSingleton S i hi
    -- （イ）(c_i^T)_{S,T} ∗ ℰ_{S,T} = δ_{S∪{i},T} ∗ (σ ∗ ℰ_{S,T})
    have hI : ∀ T : PowerSet D.M,
        Av.smul (Mat.entry (annihilationMatrix n D.M i hi) S T) (E S T)
          = Av.smul (kroneckerDelta Si T) (Av.smul σ (E S T)) := by
      intro T
      by_cases hT : T = Si
      · calc Av.smul (Mat.entry (annihilationMatrix n D.M i hi) S T) (E S T)
            = Av.smul (Mat.entry (creationMatrix n D.M i hi) T S) (E S T) := by rw [annihilationMatrix_entry n hi S T]
          _ = Av.smul σ (E S T) := by rw [creationMatrix_entry_of_cond n hi ⟨hiS, hT⟩]
          _ = Av.smul 1 (Av.smul σ (E S T)) := (Av.one_smul _).symm
          _ = Av.smul (kroneckerDelta Si T) (Av.smul σ (E S T)) := by rw [kroneckerDelta, if_pos hT.symm]
      · calc Av.smul (Mat.entry (annihilationMatrix n D.M i hi) S T) (E S T)
            = Av.smul (Mat.entry (creationMatrix n D.M i hi) T S) (E S T) := by rw [annihilationMatrix_entry n hi S T]
          _ = Av.smul 0 (E S T) := by rw [creationMatrix_entry_of_not_cond n hi (fun h => hT h.2)]
          _ = Av.zero := VectorSpace.zero_smul_eq_zero Av h00 _
          _ = Av.smul 0 (Av.smul σ (E S T)) := (VectorSpace.zero_smul_eq_zero Av h00 _).symm
          _ = Av.smul (kroneckerDelta Si T) (Av.smul σ (E S T)) := by
              rw [kroneckerDelta, if_neg (fun h => hT h.symm)]
    -- （ロ）ℰ_{S,S} ·_A a_i = σ ∗_A ℰ_{S,S∪{i}}
    have hII : A.mul (E S S) ((D.annihilation C) i) = A.smul σ (E S Si) := calc
      A.mul (E S S) ((D.annihilation C) i) = A.mul (A.mul (A.mul cS P) aS) ((D.annihilation C) i) := rfl
      _ = A.mul (A.mul cS P) (A.mul aS ((D.annihilation C) i)) := A.mul_assoc _ _ _
      _ = A.mul (A.mul cS P) (A.smul σ ((D.reverseOrderedAnnihilationProduct C) Si)) := by
          rw [(D.reverseOrderedAnnihilationProduct_mul_annihilation_of_not_mem C hneg) hi S hiS]
      _ = A.smul σ (A.mul (A.mul cS P) ((D.reverseOrderedAnnihilationProduct C) Si)) := (A.smul_mul_right _ _ _).symm
      _ = A.smul σ (E S Si) := rfl
    calc sumOverFiniteSet Av hX (fun T => Mat.entry (annihilationMatrix n D.M i hi) S T) (fun T => E S T)
        = sumOverFiniteSet Av hX (fun T => kroneckerDelta Si T) (fun T => Av.smul σ (E S T)) :=
          sumOverFiniteSet_congr Av hX _ _ _ _ hI
      _ = Av.smul σ (E S Si) := sumOverFiniteSet_kroneckerDelta Av h00 hX (fun T => Av.smul σ (E S T)) Si
      _ = A.mul (E S S) ((D.annihilation C) i) := hII.symm
  · -- i ∈ S のとき
    have hiS' : i ∈ S.1 := not_not.mp hiS
    -- （ハ）(c_i^T)_{S,T} ∗ ℰ_{S,T} = 0_A
    have hIII : ∀ T : PowerSet D.M,
        Av.smul (Mat.entry (annihilationMatrix n D.M i hi) S T) (E S T) = Av.zero := by
      intro T
      calc Av.smul (Mat.entry (annihilationMatrix n D.M i hi) S T) (E S T)
          = Av.smul (Mat.entry (creationMatrix n D.M i hi) T S) (E S T) := by rw [annihilationMatrix_entry n hi S T]
        _ = Av.smul 0 (E S T) := by rw [creationMatrix_entry_of_not_cond n hi (fun h => h.1 hiS')]
        _ = Av.zero := VectorSpace.zero_smul_eq_zero Av h00 _
    calc sumOverFiniteSet Av hX (fun T => Mat.entry (annihilationMatrix n D.M i hi) S T) (fun T => E S T)
        = A.zero := sumOverFiniteSet_eq_zero_of_terms_eq_zero Av h00 C.uniqueness.mul_zero hX _ _ hIII
      _ = A.mul (A.mul cS P) A.zero := (mul_zero_eq_zero h00 A _).symm
      _ = A.mul (A.mul cS P) (A.mul aS ((D.annihilation C) i)) := by
          rw [(D.reverseOrderedAnnihilationProduct_mul_annihilation_of_mem C hneg) hi S hiS']
      _ = A.mul (A.mul (A.mul cS P) aS) ((D.annihilation C) i) := (A.mul_assoc _ _ _).symm
      _ = A.mul (E S S) ((D.annihilation C) i) := rfl

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix` の必要十分版：Ψ(c_i^T) = a_i。 -/
theorem homomorphismFromMatrix_annihilationMatrix (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    (D.homomorphismFromMatrix C) (annihilationMatrix n D.M i hi) = (D.annihilation C) i := by
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  let A := ((D.space C).cliffordAlgebra C)
  let Av := A.toVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := (D.matrixUnitElement C)
  let c := annihilationMatrix n D.M i hi
  calc (D.homomorphismFromMatrix C) c
      = sumOverFiniteSet Av hX (fun _ => 1) (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry c S T) (E S)) := rfl
    _ = sumOverFiniteSet Av hX (fun _ => 1) (fun S => A.mul (E S S) ((D.annihilation C) i)) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ fun S => by
          rw [(D.sum_annihilationMatrix_entry_smul_matrixUnitElement C hneg) hi S]
    _ = A.mul (sumOverFiniteSet Av hX (fun _ => 1) (fun S => E S S)) ((D.annihilation C) i) :=
        ((rightMul_isLinearMap A ((D.annihilation C) i)).map_sumOverFiniteSet h00 hX _ _).symm
    _ = A.mul (sumOverFiniteSet Av hX (fun _ => 1)
          (fun S => A.mul (A.mul ((D.orderedCreationProduct C) S) (D.vacuumElement C)) ((D.reverseOrderedAnnihilationProduct C) S)))
          ((D.annihilation C) i) := rfl
    _ = A.mul A.one ((D.annihilation C) i) := by rw [(D.decomposition_of_unity C hneg)]
    _ = (D.annihilation C) i := A.one_mul _

/-- 本文 `claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators` の必要十分版：
γ((x, g)) = (Σ_{k=1}^{M} β^w_k(x) ∗_A a†_k) +_A (Σ_{k=1}^{M} g(w_k) ∗_A a_k)。 -/
theorem γ_pair_eq_creation_add_annihilation (x : W) (g : DualSpace D.spaceW) :
    ((D.space C).γ C) (x, g)
      = ((D.space C).cliffordAlgebra C).add
          (linearCombination ((D.space C).cliffordAlgebra C).toVectorSpace D.M
            (fun k => coordinate D.spaceW D.M D.w D.isBasis k x) (D.creation C))
          (linearCombination ((D.space C).cliffordAlgebra C).toVectorSpace D.M (fun k => g.1 (D.w k)) (D.annihilation C)) := by
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  let A := ((D.space C).cliffordAlgebra C)
  let Av := A.toVectorSpace
  let SW := D.spaceW
  let SWd := dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW
  -- 準備：γ ∘ in_1 と γ ∘ in_2 は線型写像
  have h1 : IsLinearMap SW Av (fun y => ((D.space C).γ C) (embedFirst SWd y)) :=
    IsLinearMap.comp (embedFirst_isLinearMap SW SWd h00 C.uniqueness.mul_zero) ((D.space C).γ_isLinearMap C)
  have h2 : IsLinearMap SWd Av (fun h => ((D.space C).γ C) (embedSecond SW h)) :=
    IsLinearMap.comp (embedSecond_isLinearMap SW SWd h00 C.uniqueness.mul_zero) ((D.space C).γ_isLinearMap C)
  have hfirst : ((D.space C).γ C) (embedFirst SWd x)
      = linearCombination Av D.M (fun k => coordinate SW D.M D.w D.isBasis k x) (D.creation C) := calc
    ((D.space C).γ C) (embedFirst SWd x) = (fun y => ((D.space C).γ C) (embedFirst SWd y)) x := rfl
    _ = (fun y => ((D.space C).γ C) (embedFirst SWd y))
          (linearCombination SW D.M (fun k => coordinate SW D.M D.w D.isBasis k x) D.w) :=
        congrArg (fun y => ((D.space C).γ C) (embedFirst SWd y)) (linearCombination_coordinate SW D.M D.w D.isBasis x).symm
    _ = linearCombination Av D.M (fun k => coordinate SW D.M D.w D.isBasis k x)
          (fun k => ((D.space C).γ C) (embedFirst SWd (D.w k))) := h1.map_linearCombination h00 _ _ _
    _ = linearCombination Av D.M (fun k => coordinate SW D.M D.w D.isBasis k x) (D.creation C) := rfl
  have hsecond : ((D.space C).γ C) (embedSecond SW g)
      = linearCombination Av D.M (fun k => g.1 (D.w k)) (D.annihilation C) := calc
    ((D.space C).γ C) (embedSecond SW g) = (fun h => ((D.space C).γ C) (embedSecond SW h)) g := rfl
    _ = (fun h => ((D.space C).γ C) (embedSecond SW h)) (linearCombination SWd D.M (fun k => g.1 (D.w k)) D.f) :=
        congrArg (fun h => ((D.space C).γ C) (embedSecond SW h)) (dualBasis_spans C.dualSpaceVectorSpaceLaws C.uniqueness.zero_add C.mul_one SW D.M D.w D.isBasis D.f D.isDualBasis g)
    _ = linearCombination Av D.M (fun k => g.1 (D.w k)) (fun k => ((D.space C).γ C) (embedSecond SW (D.f k))) :=
        h2.map_linearCombination h00 _ _ _
    _ = linearCombination Av D.M (fun k => g.1 (D.w k)) (D.annihilation C) := rfl
  calc ((D.space C).γ C) (x, g)
      = ((D.space C).γ C) (DirectSum.add SW SWd (embedFirst SWd x) (embedSecond SW g)) :=
        congrArg ((D.space C).γ C) (pair_eq_add_embed SW SWd x g)
    _ = A.add (((D.space C).γ C) (embedFirst SWd x)) (((D.space C).γ C) (embedSecond SW g)) := ((D.space C).γ_add C) _ _
    _ = A.add (linearCombination Av D.M (fun k => coordinate SW D.M D.w D.isBasis k x) (D.creation C))
          (((D.space C).γ C) (embedSecond SW g)) := by rw [hfirst]
    _ = A.add (linearCombination Av D.M (fun k => coordinate SW D.M D.w D.isBasis k x) (D.creation C))
          (linearCombination Av D.M (fun k => g.1 (D.w k)) (D.annihilation C)) := by rw [hsecond]

/-- 本文 `claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity` の必要十分版：Ψ(Φ(a)) = a。 -/
theorem homomorphismFromMatrix_homomorphismToMatrix (hneg : ∀ a : K, a + -a = 0) (a : ((D.space C).Cl C)) :
    (D.homomorphismFromMatrix C) ((D.homomorphismToMatrix C hneg) a) = a := by
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  let A := ((D.space C).cliffordAlgebra C)
  let Av := A.toVectorSpace
  let Φ := (D.homomorphismToMatrix C hneg)
  let Ψ := (D.homomorphismFromMatrix C)
  -- Ψ ∘ Φ は ℂ-代数の準同型、id_A も ℂ-代数の準同型
  have hcomp : IsAlgebraHomomorphism A A (fun x => Ψ (Φ x)) :=
    IsAlgebraHomomorphism.comp (D.homomorphismToMatrix_isHom C hneg) (D.homomorphismFromMatrix_isHom C hneg)
  have hid : IsAlgebraHomomorphism A A (fun x => x) := isAlgebraHomomorphism_id A
  -- 準備：(Ψ ∘ Φ)(a†_k) = a†_k、(Ψ ∘ Φ)(a_k) = a_k
  have hcre : ∀ k : ℕ, 1 ≤ k → k ≤ D.M → Ψ (Φ ((D.creation C) k)) = (D.creation C) k := by
    intro k hk1 hkM
    calc Ψ (Φ ((D.creation C) k)) = Ψ (creationMatrix n D.M k ⟨hk1, hkM⟩) := by
          rw [show Φ ((D.creation C) k) = _ from (D.homomorphismToMatrix_creation C hneg) ⟨hk1, hkM⟩]
      _ = (D.creation C) k := (D.homomorphismFromMatrix_creationMatrix C hneg) ⟨hk1, hkM⟩
  have hann : ∀ k : ℕ, 1 ≤ k → k ≤ D.M → Ψ (Φ ((D.annihilation C) k)) = (D.annihilation C) k := by
    intro k hk1 hkM
    calc Ψ (Φ ((D.annihilation C) k)) = Ψ (annihilationMatrix n D.M k ⟨hk1, hkM⟩) := by
          rw [show Φ ((D.annihilation C) k) = _ from (D.homomorphismToMatrix_annihilation C hneg) ⟨hk1, hkM⟩]
      _ = (D.annihilation C) k := (D.homomorphismFromMatrix_annihilationMatrix C hneg) ⟨hk1, hkM⟩
  have hagree : ∀ y ∈ Set.range ((D.space C).γ C), Ψ (Φ y) = y := by
    rintro _ ⟨⟨x, g⟩, rfl⟩
    let cx : ℕ → K := fun k => coordinate D.spaceW D.M D.w D.isBasis k x
    let cg : ℕ → K := fun k => g.1 (D.w k)
    calc Ψ (Φ (((D.space C).γ C) (x, g)))
        = Ψ (Φ (A.add (linearCombination Av D.M cx (D.creation C)) (linearCombination Av D.M cg (D.annihilation C)))) := by
          rw [D.γ_pair_eq_creation_add_annihilation C x g]
      _ = A.add (Ψ (Φ (linearCombination Av D.M cx (D.creation C)))) (Ψ (Φ (linearCombination Av D.M cg (D.annihilation C)))) :=
          hcomp.map_add _ _
      _ = A.add (linearCombination Av D.M cx (fun k => Ψ (Φ ((D.creation C) k))))
            (linearCombination Av D.M cg (fun k => Ψ (Φ ((D.annihilation C) k)))) := by
          rw [hcomp.isLinearMap.map_linearCombination h00, hcomp.isLinearMap.map_linearCombination h00]
      _ = A.add (linearCombination Av D.M cx (D.creation C)) (linearCombination Av D.M cg (D.annihilation C)) := by
          rw [linearCombination_eq_of_terms_eq Av D.M _ (D.creation C) cx cx fun k hk1 hkM => by rw [hcre k hk1 hkM],
            linearCombination_eq_of_terms_eq Av D.M _ (D.annihilation C) cg cg fun k hk1 hkM => by rw [hann k hk1 hkM]]
      _ = ((D.space C).γ C) (x, g) := (D.γ_pair_eq_creation_add_annihilation C x g).symm
  -- 生成元で一致する準同型は等しい（γ(V) は A を生成する）
  exact eq_of_agree_on_generators hcomp hid (Set.range ((D.space C).γ C)) ((D.space C).γ_generates C) hagree a

/-- 本文 `theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra` の必要十分版：
Φ と Ψ は ℂ-代数の準同型で、Ψ(Φ(a)) = a、Φ(Ψ(F)) = F。Φ は全単射で、Φ(a) = F を満たす a は Ψ(F) である。 -/
theorem cliffordAlgebra_isomorphic_matrixAlgebra (hneg : ∀ a : K, a + -a = 0) :
    IsAlgebraHomomorphism ((D.space C).cliffordAlgebra C) (D.matrixAlgebra C) (D.homomorphismToMatrix C hneg) ∧
      IsAlgebraHomomorphism (D.matrixAlgebra C) ((D.space C).cliffordAlgebra C) (D.homomorphismFromMatrix C) ∧
      (∀ a : ((D.space C).Cl C), (D.homomorphismFromMatrix C) ((D.homomorphismToMatrix C hneg) a) = a) ∧
      (∀ F : Mat K (PowerSet D.M), (D.homomorphismToMatrix C hneg) ((D.homomorphismFromMatrix C) F) = F) ∧
      Function.Bijective (D.homomorphismToMatrix C hneg) ∧
      (∀ (F : Mat K (PowerSet D.M)) (a : ((D.space C).Cl C)), (D.homomorphismToMatrix C hneg) a = F → a = (D.homomorphismFromMatrix C) F) := by
  let Φ := (D.homomorphismToMatrix C hneg)
  let Ψ := (D.homomorphismFromMatrix C)
  -- 単射であること
  have hinj : Function.Injective Φ := by
    intro a b hab
    calc a = Ψ (Φ a) := ((D.homomorphismFromMatrix_homomorphismToMatrix C hneg) a).symm
      _ = Ψ (Φ b) := by rw [hab]
      _ = b := (D.homomorphismFromMatrix_homomorphismToMatrix C hneg) b
  -- 全射であること
  have hsurj : Function.Surjective Φ := fun F => ⟨Ψ F, (D.homomorphismToMatrix_homomorphismFromMatrix C hneg) F⟩
  -- Φ^{-1}(F) = Ψ(F)：Φ(a) = F を満たすただ一つの a は Ψ(F)
  have hinv : ∀ (F : Mat K (PowerSet D.M)) (a : ((D.space C).Cl C)), Φ a = F → a = Ψ F := by
    intro F a ha
    apply hinj
    calc Φ a = F := ha
      _ = Φ (Ψ F) := ((D.homomorphismToMatrix_homomorphismFromMatrix C hneg) F).symm
  exact ⟨(D.homomorphismToMatrix_isHom C hneg), (D.homomorphismFromMatrix_isHom C hneg),
    (D.homomorphismFromMatrix_homomorphismToMatrix C hneg), (D.homomorphismToMatrix_homomorphismFromMatrix C hneg),
    ⟨hinj, hsurj⟩, hinv⟩

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
