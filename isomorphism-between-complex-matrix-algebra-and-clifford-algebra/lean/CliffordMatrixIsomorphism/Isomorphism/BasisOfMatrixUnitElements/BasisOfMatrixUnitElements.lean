/-
章「同型の証明」の節「系：行列単位にあたる元はクリフォード代数の基底をなす」の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                          このファイル
  def_family_of_matrix_unit_elements_numbered_by_pairs                 matrixUnitElementFamily（b）
  claim_entry_of_image_of_linear_combination_of_matrix_unit_elements    homomorphismToMatrix_linearCombination_entry
  claim_family_of_matrix_unit_elements_is_linearly_independent          matrixUnitElementFamily_linearlyIndependent
  claim_family_of_matrix_unit_elements_spans_clifford_algebra           linearCombination_matrixUnitElementFamily_eq・
                                                                        matrixUnitElementFamily_spans
  theorem_matrix_unit_elements_form_basis_of_clifford_algebra           matrixUnitElementFamily_isBasis

表し方:
- 宣言は名前空間 `Clifford.SplitData` に置く（`MutuallyInverseHomomorphisms.lean` と同じ）。
- 番号付けた族 b:{1,…,N_M}→A は `ℕ → A` で、{1,…,N_M} の外は 0_A（`numberedFamily`）。本文の S_m・T_m は
  `(pairNumbering D.M ⟨m, _⟩).1`・`.2` である。
- 本文の「（ロ）」の δ_{m,j} は {1,…,N_M} の二元のデルタで、`ℕ` の二元のデルタ `kroneckerDelta m j` と同じ値である
  （1 ≤ m, j ≤ N_M のときだけ使う）。

必要十分版は `NecSuf/Isomorphism/BasisOfMatrixUnitElements/BasisOfMatrixUnitElements.lean`、
導出版は `BasisOfMatrixUnitElementsFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphisms
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.PairNumbering
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixUnits.MatrixUnits

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- 本文 `def_family_of_matrix_unit_elements_numbered_by_pairs`：b_m := ℰ_{S_m,T_m}、p_M(m) = (S_m, T_m)。 -/
def matrixUnitElementFamily : ℕ → D.space.Cl :=
  numberedFamily (pairNumbering D.M) (fun p => D.matrixUnitElement p.1 p.2) D.space.cliffordAlgebra.zero

/-- 本文 `claim_entry_of_image_of_linear_combination_of_matrix_unit_elements`：
Φ(Σ_{m=1}^{N_M} λ_m ∗_A b_m)_{S_j,T_j} = λ_j。 -/
theorem homomorphismToMatrix_linearCombination_entry (c : ℕ → ℂ) (j : Idx (pairCount D.M)) :
    Mat.entry (D.homomorphismToMatrix
        (linearCombination D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M) c D.matrixUnitElementFamily))
      (pairNumbering D.M j).1 (pairNumbering D.M j).2 = c j.1 := by
  let A := D.space.cliffordAlgebra
  let B := D.matrixAlgebra
  let Φ := D.homomorphismToMatrix
  let N := pairCount D.M
  let Sj := (pairNumbering D.M j).1
  let Tj := (pairNumbering D.M j).2
  -- Φ は U_vec(A) から U_vec(B) への線型写像（def_homomorphism_from_clifford_algebra_to_matrix_algebra）
  have hΦ : IsComplexLinearMap A.toComplexVectorSpace B.toComplexVectorSpace Φ := D.homomorphismToMatrix_isHom.isLinearMap
  -- ent_{S_j,T_j} は線型写像（claim_matrix_entry_map_is_linear_map）
  have hent : IsComplexLinearMap B.toComplexVectorSpace complexNumbersVectorSpace (entryMap Sj Tj) :=
    entryMap_isComplexLinearMap (PowerSet D.M) Sj Tj
  -- B の側の族 m ↦ E_{S_m,T_m}
  let E : ℕ → Mat (PowerSet D.M) := numberedFamily (pairNumbering D.M) (fun p => matrixUnit p.1 p.2) B.zero
  -- （イ）Φ(b_m) = E_{S_m,T_m}
  have hi : ∀ m : ℕ, (hm1 : 1 ≤ m) → (hmN : m ≤ N) → Φ (D.matrixUnitElementFamily m) = E m := by
    intro m hm1 hmN
    calc Φ (D.matrixUnitElementFamily m)
        = Φ (D.matrixUnitElement (pairNumbering D.M ⟨m, hm1, hmN⟩).1 (pairNumbering D.M ⟨m, hm1, hmN⟩).2) := by
          rw [matrixUnitElementFamily, numberedFamily_of_le _ _ _ m hm1 hmN]
      _ = matrixUnit (pairNumbering D.M ⟨m, hm1, hmN⟩).1 (pairNumbering D.M ⟨m, hm1, hmN⟩).2 :=
          D.homomorphismToMatrix_matrixUnitElement _ _
      _ = E m := (numberedFamily_of_le (pairNumbering D.M) (fun p => matrixUnit p.1 p.2) B.zero m hm1 hmN).symm
  -- （ロ）(E_{S_m,T_m})_{S_j,T_j} = δ_{m,j}
  have hro : ∀ m : ℕ, (hm1 : 1 ≤ m) → (hmN : m ≤ N) → entryMap Sj Tj (E m) = kroneckerDelta m j.1 := by
    intro m hm1 hmN
    let Sm := (pairNumbering D.M ⟨m, hm1, hmN⟩).1
    let Tm := (pairNumbering D.M ⟨m, hm1, hmN⟩).2
    have hE : entryMap Sj Tj (E m) = kroneckerDelta Sm Sj * kroneckerDelta Tm Tj := by
      show entryMap Sj Tj (numberedFamily (pairNumbering D.M) (fun p => matrixUnit p.1 p.2) B.zero m) = _
      rw [numberedFamily_of_le _ _ _ m hm1 hmN]
      rfl
    by_cases hmj : m = j.1
    · -- m = j のとき S_m = S_j、T_m = T_j
      have hidx : (⟨m, hm1, hmN⟩ : Idx N) = j := Subtype.ext hmj
      have hS : Sm = Sj := by show (pairNumbering D.M ⟨m, hm1, hmN⟩).1 = _; rw [hidx]
      have hT : Tm = Tj := by show (pairNumbering D.M ⟨m, hm1, hmN⟩).2 = _; rw [hidx]
      calc entryMap Sj Tj (E m) = kroneckerDelta Sm Sj * kroneckerDelta Tm Tj := hE
        _ = 1 * 1 := by rw [kroneckerDelta, if_pos hS, kroneckerDelta, if_pos hT]
        _ = 1 := by rw [one_mul]
        _ = kroneckerDelta m j.1 := by rw [kroneckerDelta, if_pos hmj]
    · -- m ≠ j のとき、p_M は単射なので p_M(m) ≠ p_M(j)
      have hne : pairNumbering D.M ⟨m, hm1, hmN⟩ ≠ pairNumbering D.M j := by
        intro h
        exact hmj (congrArg Subtype.val ((pairNumbering_isNumbering D.M).injective _ _ h))
      by_cases hS : Sm = Sj
      · have hT : Tm ≠ Tj := fun hT => hne (Prod.ext hS hT)
        calc entryMap Sj Tj (E m) = kroneckerDelta Sm Sj * kroneckerDelta Tm Tj := hE
          _ = kroneckerDelta Sm Sj * 0 := by rw [show (kroneckerDelta Tm Tj : ℂ) = 0 from if_neg hT]
          _ = 0 := by rw [mul_zero]
          _ = kroneckerDelta m j.1 := by rw [kroneckerDelta, if_neg hmj]
      · calc entryMap Sj Tj (E m) = kroneckerDelta Sm Sj * kroneckerDelta Tm Tj := hE
          _ = 0 * kroneckerDelta Tm Tj := by rw [show (kroneckerDelta Sm Sj : ℂ) = 0 from if_neg hS]
          _ = 0 := by rw [zero_mul]
          _ = kroneckerDelta m j.1 := by rw [kroneckerDelta, if_neg hmj]
  calc Mat.entry (Φ (linearCombination A.toComplexVectorSpace N c D.matrixUnitElementFamily)) Sj Tj
      = entryMap Sj Tj (Φ (linearCombination A.toComplexVectorSpace N c D.matrixUnitElementFamily)) := rfl
    _ = entryMap Sj Tj (linearCombination B.toComplexVectorSpace N c (fun m => Φ (D.matrixUnitElementFamily m))) := by
        rw [hΦ.map_linearCombination]
    _ = entryMap Sj Tj (linearCombination B.toComplexVectorSpace N c E) := by
        rw [linearCombination_eq_of_terms_eq B.toComplexVectorSpace N _ E c c
          fun m hm1 hmN => by rw [hi m hm1 hmN]]
    _ = linearCombination complexNumbersVectorSpace N c (fun m => entryMap Sj Tj (E m)) :=
        hent.map_linearCombination N c E
    _ = linearCombination complexNumbersVectorSpace N c (fun m => kroneckerDelta m j.1) :=
        linearCombination_eq_of_terms_eq complexNumbersVectorSpace N _ _ c c
          fun m hm1 hmN => by rw [hro m hm1 hmN]
    _ = linearCombination complexNumbersVectorSpace N (fun m => kroneckerDelta m j.1) c :=
        linearCombination_eq_of_terms_eq complexNumbersVectorSpace N _ _ _ _
          fun m _ _ => show c m * kroneckerDelta m j.1 = kroneckerDelta m j.1 * c m from mul_comm _ _
    _ = c j.1 := linearCombination_kroneckerDelta complexNumbersVectorSpace N c j.1 j.2.1 j.2.2

/-- 本文 `claim_family_of_matrix_unit_elements_is_linearly_independent`：b は U_vec(Cl(V,q)) の中で一次独立。 -/
theorem matrixUnitElementFamily_linearlyIndependent :
    IsLinearlyIndependentFamily D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M)
      D.matrixUnitElementFamily := by
  let A := D.space.cliffordAlgebra
  let B := D.matrixAlgebra
  let Φ := D.homomorphismToMatrix
  have hΦ : IsComplexLinearMap A.toComplexVectorSpace B.toComplexVectorSpace Φ := D.homomorphismToMatrix_isHom.isLinearMap
  intro c hc j hj1 hjN
  let jj : Idx (pairCount D.M) := ⟨j, hj1, hjN⟩
  calc c j
      = Mat.entry (Φ (linearCombination A.toComplexVectorSpace (pairCount D.M) c D.matrixUnitElementFamily))
          (pairNumbering D.M jj).1 (pairNumbering D.M jj).2 :=
        (D.homomorphismToMatrix_linearCombination_entry c jj).symm
    _ = Mat.entry (Φ A.zero) (pairNumbering D.M jj).1 (pairNumbering D.M jj).2 := by rw [hc]; rfl
    _ = Mat.entry B.zero (pairNumbering D.M jj).1 (pairNumbering D.M jj).2 := by
        rw [show Φ A.zero = B.zero from hΦ.map_zero]
    _ = 0 := rfl

/-- 本文 `claim_family_of_matrix_unit_elements_spans_clifford_algebra` の式：λ_m := Φ(x)_{S_m,T_m} と置くと
Σ_{m=1}^{N_M} λ_m ∗_A b_m = x。 -/
theorem linearCombination_matrixUnitElementFamily_eq (x : D.space.Cl) :
    linearCombination D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M)
        (extendFamily (fun m : Idx (pairCount D.M) =>
          Mat.entry (D.homomorphismToMatrix x) (pairNumbering D.M m).1 (pairNumbering D.M m).2) 0)
        D.matrixUnitElementFamily = x := by
  let A := D.space.cliffordAlgebra
  let Φ := D.homomorphismToMatrix
  let Ψ := D.homomorphismFromMatrix
  let lam : ℕ → ℂ := extendFamily (fun m : Idx (pairCount D.M) =>
    Mat.entry (Φ x) (pairNumbering D.M m).1 (pairNumbering D.M m).2) 0
  let y := linearCombination A.toComplexVectorSpace (pairCount D.M) lam D.matrixUnitElementFamily
  -- Φ(y) = Φ(x)
  have hΦ : Φ y = Φ x := by
    apply Mat.ext
    intro S T
    -- j := p_M^{-1}((S,T))、p_M(j) = (S,T)
    let j := (pairNumbering_isNumbering D.M).inv (S, T)
    have hj : pairNumbering D.M j = (S, T) := (pairNumbering_isNumbering D.M).apply_inv (S, T)
    have hS : (pairNumbering D.M j).1 = S := by rw [hj]
    have hT : (pairNumbering D.M j).2 = T := by rw [hj]
    calc Mat.entry (Φ y) S T
        = Mat.entry (Φ y) (pairNumbering D.M j).1 (pairNumbering D.M j).2 := by rw [hS, hT]
      _ = lam j.1 := D.homomorphismToMatrix_linearCombination_entry lam j
      _ = Mat.entry (Φ x) (pairNumbering D.M j).1 (pairNumbering D.M j).2 := extendFamily_of_le _ _ j.1 j.2.1 j.2.2
      _ = Mat.entry (Φ x) S T := by rw [hS, hT]
  calc linearCombination A.toComplexVectorSpace (pairCount D.M) lam D.matrixUnitElementFamily
      = y := rfl
    _ = Ψ (Φ y) := (D.homomorphismFromMatrix_homomorphismToMatrix y).symm
    _ = Ψ (Φ x) := by rw [hΦ]
    _ = x := D.homomorphismFromMatrix_homomorphismToMatrix x

/-- 本文 `claim_family_of_matrix_unit_elements_spans_clifford_algebra`：b は U_vec(A) を線型結合で張る。 -/
theorem matrixUnitElementFamily_spans :
    SpansByLinearCombination D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M)
      D.matrixUnitElementFamily :=
  fun x => ⟨_, D.linearCombination_matrixUnitElementFamily_eq x⟩

/-- 本文 `theorem_matrix_unit_elements_form_basis_of_clifford_algebra`：b は U_vec(Cl(V,q)) の基底。 -/
theorem matrixUnitElementFamily_isBasis :
    IsBasisFamily D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M) D.matrixUnitElementFamily :=
  ⟨D.matrixUnitElementFamily_linearlyIndependent, D.matrixUnitElementFamily_spans⟩

end

end CliffordMatrixIsomorphism.Clifford.SplitData
