/-
章「同型の証明」の節「系：行列単位にあたる元はクリフォード代数の基底をなす」の必要十分版。具体版
`Isomorphism/BasisOfMatrixUnitElements/BasisOfMatrixUnitElements.lean` と同じ def と同じ calc の行のまま、
係数 ℂ を型の変数 K に、-1_ℂ を K の元 n に替える。K には演算の記号 +・·・0・1・- だけを与え、使う性質は仮定として渡す。
本文のラベルと宣言の対応は具体版の冒頭の表と同じである（宣言の名前も同じ）。

主張ごとに使う K の性質（どの主張も、Cl(V,q) と Mat_{P_M}(K) の K の上の代数を作るための章「クリフォード代数」の仮定
`CliffordLaws K n` と、Φ を普遍性から得るための a + (-a) = 0（hneg）を持つ。下に書くのは、行の中で使う性質である）:
  Φ(Σ λ_m ∗ b_m)_{S_j,T_j} = λ_j       0 + 0 = 0（Φ と ent が線型結合を移す・デルタで一項を取り出す）、1 · 1 = 1、
                                       a · 0 = 0、0 · a = 0（（ロ）の三つの場合）、0 と 1 がどの元とも交換すること
                                       （λ_m · δ_{m,j} = δ_{m,j} · λ_m の行）
  b は一次独立                          0 + 0 = 0（Φ(0_A) = 0_B）
  b は張る・b は基底                    上の主張と Ψ ∘ Φ = 恒等写像の仮定だけ

分かったこと:
- 具体版が ℂ の乗法の交換法則を当てる行 λ_m · δ_{m,j} = δ_{m,j} · λ_m は、δ の値が 0 か 1 なので、0 と 1 の交換だけで足りる。
- 2 の可逆性と平方根は、どの主張も使わない。本文の前提 M ∈ ℤ_{≥1} も、どの主張も使わない（N_M ≥ 1 は本文の最後の文で
  K^vec の線型結合の長さを確かめるために挙げているが、デルタで一項を取り出す主張は 1 ≤ j ≤ N_M しか使わない）。

導出版は `Isomorphism/BasisOfMatrixUnitElements/BasisOfMatrixUnitElementsFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphisms
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.PairNumbering

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.Isomorphism
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet pairCount pairNumbering
  pairNumbering_isNumbering)

universe u uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-- 本文 `def_family_of_matrix_unit_elements_numbered_by_pairs` の必要十分版：b_m := ℰ_{S_m,T_m}、p_M(m) = (S_m, T_m)。 -/
def matrixUnitElementFamily : ℕ → (D.space C).Cl C :=
  numberedFamily (pairNumbering D.M) (fun p => D.matrixUnitElement C p.1 p.2) ((D.space C).cliffordAlgebra C).zero

/-- 本文 `claim_entry_of_image_of_linear_combination_of_matrix_unit_elements` の必要十分版：
Φ(Σ_{m=1}^{N_M} λ_m ∗_A b_m)_{S_j,T_j} = λ_j。 -/
theorem homomorphismToMatrix_linearCombination_entry (hneg : ∀ a : K, a + -a = 0)
    (h0 : ∀ a : K, 0 * a = a * 0) (h1 : ∀ a : K, 1 * a = a * 1) (c : ℕ → K) (j : Idx (pairCount D.M)) :
    Mat.entry (D.homomorphismToMatrix C hneg
        (linearCombination ((D.space C).cliffordAlgebra C).toVectorSpace (pairCount D.M) c (D.matrixUnitElementFamily C)))
      (pairNumbering D.M j).1 (pairNumbering D.M j).2 = c j.1 := by
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  let L := C.valuedMaps
  let A := (D.space C).cliffordAlgebra C
  let B := D.matrixAlgebra C
  let Φ := D.homomorphismToMatrix C hneg
  let N := pairCount D.M
  let Sj := (pairNumbering D.M j).1
  let Tj := (pairNumbering D.M j).2
  have hΦ : IsLinearMap A.toVectorSpace B.toVectorSpace Φ := (D.homomorphismToMatrix_isHom C hneg).isLinearMap
  have hent : IsLinearMap B.toVectorSpace (coefficientsVec L) (entryMap Sj Tj) :=
    entryMap_isLinearMap L (PowerSet D.M) Sj Tj
  let E : ℕ → Mat K (PowerSet D.M) := numberedFamily (pairNumbering D.M) (fun p => matrixUnit p.1 p.2) B.zero
  -- （イ）Φ(b_m) = E_{S_m,T_m}
  have hi : ∀ m : ℕ, (hm1 : 1 ≤ m) → (hmN : m ≤ N) → Φ (D.matrixUnitElementFamily C m) = E m := by
    intro m hm1 hmN
    calc Φ (D.matrixUnitElementFamily C m)
        = Φ (D.matrixUnitElement C (pairNumbering D.M ⟨m, hm1, hmN⟩).1 (pairNumbering D.M ⟨m, hm1, hmN⟩).2) := by
          rw [matrixUnitElementFamily, numberedFamily_of_le _ _ _ m hm1 hmN]
      _ = matrixUnit (pairNumbering D.M ⟨m, hm1, hmN⟩).1 (pairNumbering D.M ⟨m, hm1, hmN⟩).2 :=
          D.homomorphismToMatrix_matrixUnitElement C hneg _ _
      _ = E m := (numberedFamily_of_le (pairNumbering D.M) (fun p => matrixUnit p.1 p.2) B.zero m hm1 hmN).symm
  -- （ロ）(E_{S_m,T_m})_{S_j,T_j} = δ_{m,j}
  have hro : ∀ m : ℕ, (hm1 : 1 ≤ m) → (hmN : m ≤ N) → entryMap Sj Tj (E m) = (kroneckerDelta m j.1 : K) := by
    intro m hm1 hmN
    let Sm := (pairNumbering D.M ⟨m, hm1, hmN⟩).1
    let Tm := (pairNumbering D.M ⟨m, hm1, hmN⟩).2
    have hE : entryMap Sj Tj (E m) = (kroneckerDelta Sm Sj : K) * kroneckerDelta Tm Tj := by
      show entryMap Sj Tj (numberedFamily (pairNumbering D.M) (fun p => matrixUnit p.1 p.2) B.zero m) = _
      rw [numberedFamily_of_le _ _ _ m hm1 hmN]
      rfl
    by_cases hmj : m = j.1
    · have hidx : (⟨m, hm1, hmN⟩ : Idx N) = j := Subtype.ext hmj
      have hS : Sm = Sj := by show (pairNumbering D.M ⟨m, hm1, hmN⟩).1 = _; rw [hidx]
      have hT : Tm = Tj := by show (pairNumbering D.M ⟨m, hm1, hmN⟩).2 = _; rw [hidx]
      calc entryMap Sj Tj (E m) = (kroneckerDelta Sm Sj : K) * kroneckerDelta Tm Tj := hE
        _ = 1 * 1 := by rw [kroneckerDelta, if_pos hS, kroneckerDelta, if_pos hT]
        _ = 1 := C.uniqueness.one_mul 1
        _ = kroneckerDelta m j.1 := by rw [kroneckerDelta, if_pos hmj]
    · have hne : pairNumbering D.M ⟨m, hm1, hmN⟩ ≠ pairNumbering D.M j := by
        intro h
        exact hmj (congrArg Subtype.val ((pairNumbering_isNumbering D.M).injective _ _ h))
      by_cases hS : Sm = Sj
      · have hT : Tm ≠ Tj := fun hT => hne (Prod.ext hS hT)
        calc entryMap Sj Tj (E m) = (kroneckerDelta Sm Sj : K) * kroneckerDelta Tm Tj := hE
          _ = kroneckerDelta Sm Sj * 0 := by rw [show (kroneckerDelta Tm Tj : K) = 0 from if_neg hT]
          _ = 0 := C.uniqueness.mul_zero _
          _ = kroneckerDelta m j.1 := by rw [kroneckerDelta, if_neg hmj]
      · calc entryMap Sj Tj (E m) = (kroneckerDelta Sm Sj : K) * kroneckerDelta Tm Tj := hE
          _ = 0 * kroneckerDelta Tm Tj := by rw [show (kroneckerDelta Sm Sj : K) = 0 from if_neg hS]
          _ = 0 := C.uniqueness.zero_mul _
          _ = kroneckerDelta m j.1 := by rw [kroneckerDelta, if_neg hmj]
  -- δ_{m,j} は 0 か 1 なので、どの元とも交換する
  have hδ : ∀ m : ℕ, c m * (kroneckerDelta m j.1 : K) = kroneckerDelta m j.1 * c m := by
    intro m
    by_cases hmj : m = j.1
    · rw [kroneckerDelta, if_pos hmj]; exact (h1 (c m)).symm
    · rw [kroneckerDelta, if_neg hmj]; exact (h0 (c m)).symm
  calc Mat.entry (Φ (linearCombination A.toVectorSpace N c (D.matrixUnitElementFamily C))) Sj Tj
      = entryMap Sj Tj (Φ (linearCombination A.toVectorSpace N c (D.matrixUnitElementFamily C))) := rfl
    _ = entryMap Sj Tj (linearCombination B.toVectorSpace N c (fun m => Φ (D.matrixUnitElementFamily C m))) := by
        rw [hΦ.map_linearCombination h00]
    _ = entryMap Sj Tj (linearCombination B.toVectorSpace N c E) := by
        rw [linearCombination_eq_of_terms_eq B.toVectorSpace N _ E c c
          fun m hm1 hmN => by rw [hi m hm1 hmN]]
    _ = linearCombination (coefficientsVec L) N c (fun m => entryMap Sj Tj (E m)) :=
        hent.map_linearCombination h00 N c E
    _ = linearCombination (coefficientsVec L) N c (fun m => (kroneckerDelta m j.1 : K)) :=
        linearCombination_eq_of_terms_eq (coefficientsVec L) N _ _ c c
          fun m hm1 hmN => by rw [hro m hm1 hmN]
    _ = linearCombination (coefficientsVec L) N (fun m => (kroneckerDelta m j.1 : K)) c :=
        linearCombination_eq_of_terms_eq (coefficientsVec L) N _ _ _ _ fun m _ _ => hδ m
    _ = c j.1 := linearCombination_kroneckerDelta (coefficientsVec L) h00 N c j.1 j.2.1 j.2.2

/-- 本文 `claim_family_of_matrix_unit_elements_is_linearly_independent` の必要十分版。 -/
theorem matrixUnitElementFamily_linearlyIndependent (hneg : ∀ a : K, a + -a = 0)
    (h0 : ∀ a : K, 0 * a = a * 0) (h1 : ∀ a : K, 1 * a = a * 1) :
    IsLinearlyIndependentFamily ((D.space C).cliffordAlgebra C).toVectorSpace (pairCount D.M)
      (D.matrixUnitElementFamily C) := by
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  let A := (D.space C).cliffordAlgebra C
  let B := D.matrixAlgebra C
  let Φ := D.homomorphismToMatrix C hneg
  have hΦ : IsLinearMap A.toVectorSpace B.toVectorSpace Φ := (D.homomorphismToMatrix_isHom C hneg).isLinearMap
  intro c hc j hj1 hjN
  let jj : Idx (pairCount D.M) := ⟨j, hj1, hjN⟩
  calc c j
      = Mat.entry (Φ (linearCombination A.toVectorSpace (pairCount D.M) c (D.matrixUnitElementFamily C)))
          (pairNumbering D.M jj).1 (pairNumbering D.M jj).2 :=
        (D.homomorphismToMatrix_linearCombination_entry C hneg h0 h1 c jj).symm
    _ = Mat.entry (Φ A.zero) (pairNumbering D.M jj).1 (pairNumbering D.M jj).2 := by rw [hc]; rfl
    _ = Mat.entry B.zero (pairNumbering D.M jj).1 (pairNumbering D.M jj).2 := by
        rw [show Φ A.zero = B.zero from hΦ.map_zero h00]
    _ = 0 := rfl

/-- 本文 `claim_family_of_matrix_unit_elements_spans_clifford_algebra` の式の必要十分版。 -/
theorem linearCombination_matrixUnitElementFamily_eq (hneg : ∀ a : K, a + -a = 0)
    (h0 : ∀ a : K, 0 * a = a * 0) (h1 : ∀ a : K, 1 * a = a * 1) (x : (D.space C).Cl C) :
    linearCombination ((D.space C).cliffordAlgebra C).toVectorSpace (pairCount D.M)
        (extendFamily (fun m : Idx (pairCount D.M) =>
          Mat.entry (D.homomorphismToMatrix C hneg x) (pairNumbering D.M m).1 (pairNumbering D.M m).2) 0)
        (D.matrixUnitElementFamily C) = x := by
  let A := (D.space C).cliffordAlgebra C
  let Φ := D.homomorphismToMatrix C hneg
  let Ψ := D.homomorphismFromMatrix C
  let lam : ℕ → K := extendFamily (fun m : Idx (pairCount D.M) =>
    Mat.entry (Φ x) (pairNumbering D.M m).1 (pairNumbering D.M m).2) 0
  let y := linearCombination A.toVectorSpace (pairCount D.M) lam (D.matrixUnitElementFamily C)
  have hΦ : Φ y = Φ x := by
    apply Mat.ext
    intro S T
    let j := (pairNumbering_isNumbering D.M).inv (S, T)
    have hj : pairNumbering D.M j = (S, T) := (pairNumbering_isNumbering D.M).apply_inv (S, T)
    have hS : (pairNumbering D.M j).1 = S := by rw [hj]
    have hT : (pairNumbering D.M j).2 = T := by rw [hj]
    calc Mat.entry (Φ y) S T
        = Mat.entry (Φ y) (pairNumbering D.M j).1 (pairNumbering D.M j).2 := by rw [hS, hT]
      _ = lam j.1 := D.homomorphismToMatrix_linearCombination_entry C hneg h0 h1 lam j
      _ = Mat.entry (Φ x) (pairNumbering D.M j).1 (pairNumbering D.M j).2 := extendFamily_of_le _ _ j.1 j.2.1 j.2.2
      _ = Mat.entry (Φ x) S T := by rw [hS, hT]
  calc linearCombination A.toVectorSpace (pairCount D.M) lam (D.matrixUnitElementFamily C)
      = y := rfl
    _ = Ψ (Φ y) := (D.homomorphismFromMatrix_homomorphismToMatrix C hneg y).symm
    _ = Ψ (Φ x) := by rw [hΦ]
    _ = x := D.homomorphismFromMatrix_homomorphismToMatrix C hneg x

/-- 本文 `claim_family_of_matrix_unit_elements_spans_clifford_algebra` の必要十分版。 -/
theorem matrixUnitElementFamily_spans (hneg : ∀ a : K, a + -a = 0)
    (h0 : ∀ a : K, 0 * a = a * 0) (h1 : ∀ a : K, 1 * a = a * 1) :
    SpansByLinearCombination ((D.space C).cliffordAlgebra C).toVectorSpace (pairCount D.M)
      (D.matrixUnitElementFamily C) :=
  fun x => ⟨_, D.linearCombination_matrixUnitElementFamily_eq C hneg h0 h1 x⟩

/-- 本文 `theorem_matrix_unit_elements_form_basis_of_clifford_algebra` の必要十分版。 -/
theorem matrixUnitElementFamily_isBasis (hneg : ∀ a : K, a + -a = 0)
    (h0 : ∀ a : K, 0 * a = a * 0) (h1 : ∀ a : K, 1 * a = a * 1) :
    IsBasisFamily ((D.space C).cliffordAlgebra C).toVectorSpace (pairCount D.M) (D.matrixUnitElementFamily C) :=
  ⟨D.matrixUnitElementFamily_linearlyIndependent C hneg h0 h1, D.matrixUnitElementFamily_spans C hneg h0 h1⟩

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
