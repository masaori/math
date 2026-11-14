/-
章「同型の証明」の、空集合の位置の行列単位 E_{∅,∅} を消滅作用素の行列と生成作用素の行列の積で作ること、
それに生成作用素の行列の積を左から・消滅作用素の行列の逆順の積を右から掛けると E_{S,∅}・E_{∅,T} になることの具体版。
人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                           このファイル
  claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit    annihilationTimesCreation（x_i）・
                                                                                         notMemIndicator（η_i(U)）・
                                                                                         vacuumIndicator（χ_m(S,U)）・
                                                                                         entry_annihilationTimesCreation（（⋆_1））・
                                                                                         vacuumIndicator_mul_notMemIndicator（（⋆_2））・
                                                                                         entry_partialOrderedProduct_annihilationTimesCreation
                                                                                         （本題の前半）・
                                                                                         orderedProduct_annihilationTimesCreation_eq_vacuumMatrixUnit
  claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit           selectedCreation（y_t）・
                                                                                         creationMatrix_mul_matrixUnit（（⋆））・
                                                                                         partialOrderedProduct_selectedCreation_mul_matrixUnit
                                                                                         （本題の前半）・
                                                                                         orderedProduct_selectedCreation_mul_vacuumMatrixUnit
  claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices
                                                                                         selectedAnnihilation（z_t）・
                                                                                         reversedSelectedAnnihilation（ž_k）・
                                                                                         matrixUnit_mul_annihilationMatrix（（⋆）と（†））・
                                                                                         vacuumMatrixUnit_mul_partialOrderedProduct
                                                                                         （本題の前半）・
                                                                                         vacuumMatrixUnit_mul_orderedProduct_reversedSelectedAnnihilation

表し方:
- 行列の添字集合は P_M（`PowerSet M`）、有限であることは `isFiniteSet_powerSet M`（証明の中では hX）、Mat_{P_M}(ℂ) の ℂ-代数は
  `matricesComplexAlgebra hX`（本文 claim_matrices_indexed_by_finite_set_form_complex_algebra。証明の中では SA）、番号順の積は
  `orderedProduct SA M x`、その Π_m は `partialOrderedProduct SA x m`（本文 def_ordered_product_in_algebra）。
  SA の積は `Mat.mul hX` そのものなので、本文の「Π_m の定義」の行は rfl である。
- ∅ ∈ P_M は `emptyIndexSet M`、本文の証明が置く集合と条件（C_m(S,U)・R^{⟨m⟩}・T^{⟨m⟩}）とその所属の同値は ℂ を含まないので
  `VacuumIndexSets.lean` に置く。
- 番号付けた族 x・y・z・ž は `ℕ → Mat (PowerSet M)` で表し、{1,…,M} の外の値（1_{Mat}）は使わない。
  y_t・z_t は本文どおり t ∈ S（t ∈ T）で場合を分け、t ∈ S なら S ⊆ {1,…,M} から 1 ≤ t ≤ M なので c_t が定まる。
- 本文の帰納法の段 m ∈ {1,…,M}（m - 1 からの段）は、Lean では m + 1（m + 1 ≤ M）と書く。第三の主張の s := M + 1 - m は
  `M + 1 - (m + 1)` と書く。
- 本文の前提 M ∈ ℤ_{≥1} は、三つの主張のどの行も使わないので、仮定に置かない（M = 0 でも主張は同じ証明で成り立つ）。
- 本文の δ・η_i・χ_m の値を開く行（定義・置き方）は、if を `if_pos`・`if_neg` で開く。

和はどれも ℂ^vec（`complexNumbersVectorSpace`、証明の中では V と書く）の中の有限集合 P_M の上の和で、本文が引く主張は次の宣言を引く。
  claim_sum_over_finite_set_depends_only_on_terms              sumOverFiniteSet_congr
  claim_sum_over_finite_set_with_kronecker_delta_picks_term    sumOverFiniteSet_kroneckerDelta
行列の積の主張は次の宣言を引く。
  claim_matrix_product_is_associative                          mat_mul_assoc
  claim_identity_matrix_is_left_unit_of_matrix_product         mat_one_mul
  claim_identity_matrix_is_right_unit_of_matrix_product        mat_mul_one

必要十分版は `NecSuf/Isomorphism/CreationOperatorMatrices/VacuumMatrixUnit.lean`、導出版は `VacuumMatrixUnitFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CreationMatrices
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.VacuumIndexSets
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixUnits.MatrixUnits
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Algebra

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

/-! ### 消滅作用素の行列と生成作用素の行列の積を番号順に掛けた積 -/

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit` の
x_i := c_i^T ·_{Mat_{P_M}} c_i（i ∈ {1,…,M}。{1,…,M} の外の値 1_{Mat} は使わない）。 -/
noncomputable def annihilationTimesCreation (M : ℕ) (i : ℕ) : Mat (PowerSet M) :=
  if hi : 1 ≤ i ∧ i ≤ M then
    Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M i hi) (creationMatrix M i hi)
  else Mat.one

/-- x_i の置き方：i ∈ {1,…,M} なら x_i = c_i^T ·_{Mat_{P_M}} c_i。 -/
theorem annihilationTimesCreation_of_mem {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) :
    annihilationTimesCreation M i
      = Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M i hi) (creationMatrix M i hi) :=
  dif_pos hi

open Classical in
/-- 本文の η_i(U)：i ∉ U なら 1_ℂ、i ∈ U なら 0_ℂ。 -/
noncomputable def notMemIndicator {M : ℕ} (i : ℕ) (U : PowerSet M) : ℂ :=
  if i ∉ U.1 then 1 else 0

open Classical in
/-- 本文の χ_m(S,U)：C_m(S,U) が成り立つなら 1_ℂ、成り立たないなら 0_ℂ。 -/
noncomputable def vacuumIndicator {M : ℕ} (m : ℕ) (S U : PowerSet M) : ℂ :=
  if vacuumCond m S U then 1 else 0

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit` の準備の一つ目（⋆_1）：
(x_i)_{T,U} = δ_{U,T} ·_ℂ η_i(U)。 -/
theorem entry_annihilationTimesCreation {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (T U : PowerSet M) :
    Mat.entry (annihilationTimesCreation M i) T U = kroneckerDelta U T * notMemIndicator i U := by
  let hX := isFiniteSet_powerSet M
  by_cases hiU : i ∈ U.1
  · -- i ∈ U のとき。
    calc Mat.entry (annihilationTimesCreation M i) T U
        = Mat.entry (Mat.mul hX (annihilationMatrix M i hi) (creationMatrix M i hi)) T U := by
          rw [annihilationTimesCreation_of_mem hi]
      _ = 0 := (entry_mul_creationMatrix hi (annihilationMatrix M i hi) T U).2 hiU
      _ = kroneckerDelta U T * 0 := (mul_zero (kroneckerDelta U T)).symm
      _ = kroneckerDelta U T * notMemIndicator i U := by
          rw [show notMemIndicator i U = (0 : ℂ) from if_neg (fun h => h hiU)]
  · -- i ∉ U のとき。c_i の (U ∪ {i}, T) 成分の条件は T = U と同値（`unionSingleton_eq_cond_iff`）。
    by_cases hTU : T = U
    · calc Mat.entry (annihilationTimesCreation M i) T U
          = Mat.entry (Mat.mul hX (annihilationMatrix M i hi) (creationMatrix M i hi)) T U := by
            rw [annihilationTimesCreation_of_mem hi]
        _ = Mat.entry (annihilationMatrix M i hi) T (unionSingleton U i hi) * sign (countBelow U i) :=
            (entry_mul_creationMatrix hi (annihilationMatrix M i hi) T U).1 hiU
        _ = Mat.entry (creationMatrix M i hi) (unionSingleton U i hi) T * sign (countBelow U i) := rfl
        _ = sign (countBelow T i) * sign (countBelow U i) := by
            rw [creationMatrix_entry_of_cond hi ((unionSingleton_eq_cond_iff hi hiU T).2 hTU)]
        _ = sign (countBelow U i) * sign (countBelow U i) := by rw [hTU]
        _ = 1 := sign_mul_self (countBelow U i)
        _ = 1 * 1 := (mul_one (1 : ℂ)).symm
        _ = kroneckerDelta U T * 1 := by rw [show kroneckerDelta U T = (1 : ℂ) from if_pos hTU.symm]
        _ = kroneckerDelta U T * notMemIndicator i U := by
            rw [show notMemIndicator i U = (1 : ℂ) from if_pos hiU]
    · calc Mat.entry (annihilationTimesCreation M i) T U
          = Mat.entry (Mat.mul hX (annihilationMatrix M i hi) (creationMatrix M i hi)) T U := by
            rw [annihilationTimesCreation_of_mem hi]
        _ = Mat.entry (annihilationMatrix M i hi) T (unionSingleton U i hi) * sign (countBelow U i) :=
            (entry_mul_creationMatrix hi (annihilationMatrix M i hi) T U).1 hiU
        _ = Mat.entry (creationMatrix M i hi) (unionSingleton U i hi) T * sign (countBelow U i) := rfl
        _ = 0 * sign (countBelow U i) := by
            rw [creationMatrix_entry_of_not_cond hi
              (fun h => hTU ((unionSingleton_eq_cond_iff hi hiU T).1 h))]
        _ = 0 := zero_mul (sign (countBelow U i))
        _ = 0 * notMemIndicator i U := (zero_mul (notMemIndicator i U)).symm
        _ = kroneckerDelta U T * notMemIndicator i U := by
            rw [show kroneckerDelta U T = (0 : ℂ) from if_neg (fun h => hTU h.symm)]

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit` の準備の二つ目（⋆_2）：
χ_{m-1}(S,U) ·_ℂ η_m(U) = χ_m(S,U)（m を m + 1 と書く）。 -/
theorem vacuumIndicator_mul_notMemIndicator {M : ℕ} (m : ℕ) (S U : PowerSet M) :
    vacuumIndicator m S U * notMemIndicator (m + 1) U = vacuumIndicator (m + 1) S U := by
  by_cases hC : vacuumCond (m + 1) S U
  · -- C_m(S,U) が成り立つとき。
    have h := (vacuumCond_succ_iff m S U).1 hC
    calc vacuumIndicator m S U * notMemIndicator (m + 1) U
        = 1 * notMemIndicator (m + 1) U := by
          rw [show vacuumIndicator m S U = (1 : ℂ) from if_pos h.1]
      _ = 1 * 1 := by rw [show notMemIndicator (m + 1) U = (1 : ℂ) from if_pos h.2]
      _ = 1 := mul_one (1 : ℂ)
      _ = vacuumIndicator (m + 1) S U := (if_pos hC).symm
  · by_cases hC' : vacuumCond m S U
    · -- C_m(S,U) が成り立たず、C_{m-1}(S,U) が成り立つとき。上の同値から m ∈ U。
      have hmU : m + 1 ∈ U.1 := by
        by_contra hmU
        exact hC ((vacuumCond_succ_iff m S U).2 ⟨hC', hmU⟩)
      calc vacuumIndicator m S U * notMemIndicator (m + 1) U
          = vacuumIndicator m S U * 0 := by
            rw [show notMemIndicator (m + 1) U = (0 : ℂ) from if_neg (fun h => h hmU)]
        _ = 0 := mul_zero (vacuumIndicator m S U)
        _ = vacuumIndicator (m + 1) S U := (if_neg hC).symm
    · -- C_m(S,U) も C_{m-1}(S,U) も成り立たないとき。
      calc vacuumIndicator m S U * notMemIndicator (m + 1) U
          = 0 * notMemIndicator (m + 1) U := by
            rw [show vacuumIndicator m S U = (0 : ℂ) from if_neg hC']
        _ = 0 := zero_mul (notMemIndicator (m + 1) U)
        _ = vacuumIndicator (m + 1) S U := (if_neg hC).symm

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit` の本題の前半：
すべての m ∈ {0,1,…,M} と S, U ∈ P_M について (Π_m)_{S,U} = χ_m(S,U)。 -/
theorem entry_partialOrderedProduct_annihilationTimesCreation (M : ℕ) :
    ∀ m : ℕ, m ≤ M → ∀ S U : PowerSet M,
      Mat.entry (partialOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M))
          (annihilationTimesCreation M) m) S U
        = vacuumIndicator m S U := by
  let hX := isFiniteSet_powerSet M
  let SA := matricesComplexAlgebra hX
  let V := complexNumbersVectorSpace
  intro m
  induction m with
  | zero =>
    intro _ S U
    by_cases hSU : S = U
    · calc Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) 0) S U
          = Mat.entry (Mat.one : Mat (PowerSet M)) S U := rfl
        _ = kroneckerDelta S U := rfl
        _ = 1 := if_pos hSU
        _ = vacuumIndicator 0 S U := (if_pos ((vacuumCond_zero_iff S U).2 hSU)).symm
    · calc Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) 0) S U
          = Mat.entry (Mat.one : Mat (PowerSet M)) S U := rfl
        _ = kroneckerDelta S U := rfl
        _ = 0 := if_neg hSU
        _ = vacuumIndicator 0 S U := (if_neg (fun h => hSU ((vacuumCond_zero_iff S U).1 h))).symm
  | succ m ih =>
    intro hmM S U
    have hm : 1 ≤ m + 1 ∧ m + 1 ≤ M := ⟨Nat.succ_pos m, hmM⟩
    -- r_T := (Π_{m-1})_{S,T} ·_ℂ η_m(U)
    let r : PowerSet M → ℂ := fun T =>
      Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T * notMemIndicator (m + 1) U
    -- 和の項のデルタを係数の位置へ移した等式
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T)
            (Mat.entry (annihilationTimesCreation M (m + 1)) T U)
          = V.smul (kroneckerDelta U T) (r T) := fun T => calc
      V.smul (Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T)
            (Mat.entry (annihilationTimesCreation M (m + 1)) T U)
          = Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T
              * Mat.entry (annihilationTimesCreation M (m + 1)) T U := rfl
      _ = Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T
              * (kroneckerDelta U T * notMemIndicator (m + 1) U) := by
          rw [entry_annihilationTimesCreation hm T U]
      _ = (Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T * kroneckerDelta U T)
              * notMemIndicator (m + 1) U :=
          (mul_assoc (Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T)
            (kroneckerDelta U T) (notMemIndicator (m + 1) U)).symm
      _ = (kroneckerDelta U T * Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T)
              * notMemIndicator (m + 1) U := by
          rw [mul_comm (Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T)
            (kroneckerDelta U T)]
      _ = kroneckerDelta U T
              * (Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T
                * notMemIndicator (m + 1) U) :=
          mul_assoc (kroneckerDelta U T)
            (Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T)
            (notMemIndicator (m + 1) U)
      _ = kroneckerDelta U T * r T := rfl
      _ = V.smul (kroneckerDelta U T) (r T) := rfl
    calc Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) (m + 1)) S U
        = Mat.entry (Mat.mul hX (partialOrderedProduct SA (annihilationTimesCreation M) m)
            (annihilationTimesCreation M (m + 1))) S U := rfl
      _ = sumOverFiniteSet V hX
            (fun T => Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S T)
            (fun T => Mat.entry (annihilationTimesCreation M (m + 1)) T U) := rfl
      _ = sumOverFiniteSet V hX (fun T => kroneckerDelta U T) r :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = r U := sumOverFiniteSet_kroneckerDelta V hX r U
      _ = Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) m) S U
            * notMemIndicator (m + 1) U := rfl
      _ = vacuumIndicator m S U * notMemIndicator (m + 1) U := by rw [ih (by omega) S U]
      _ = vacuumIndicator (m + 1) S U := vacuumIndicator_mul_notMemIndicator m S U

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit`：
∏_{Mat_{P_M}, i=1}^{M} x_i = E_{∅,∅}。 -/
theorem orderedProduct_annihilationTimesCreation_eq_vacuumMatrixUnit (M : ℕ) :
    orderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M)) M (annihilationTimesCreation M)
      = matrixUnit (emptyIndexSet M) (emptyIndexSet M) := Mat.ext fun S U => by
  let SA := matricesComplexAlgebra (isFiniteSet_powerSet M)
  have hPi := entry_partialOrderedProduct_annihilationTimesCreation M M (le_refl M) S U
  by_cases hS : S = emptyIndexSet M
  · by_cases hU : U = emptyIndexSet M
    · -- S = ∅ かつ U = ∅ のとき。
      calc Mat.entry (orderedProduct SA M (annihilationTimesCreation M)) S U
          = Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) M) S U := rfl
        _ = vacuumIndicator M S U := hPi
        _ = 1 := if_pos ((vacuumCond_last_iff S U).2 ⟨hS, hU⟩)
        _ = 1 * 1 := (mul_one (1 : ℂ)).symm
        _ = kroneckerDelta (emptyIndexSet M) S * kroneckerDelta (emptyIndexSet M) U := by
            rw [show kroneckerDelta (emptyIndexSet M) S = (1 : ℂ) from if_pos hS.symm,
              show kroneckerDelta (emptyIndexSet M) U = (1 : ℂ) from if_pos hU.symm]
        _ = Mat.entry (matrixUnit (emptyIndexSet M) (emptyIndexSet M)) S U := rfl
    · -- S = ∅ かつ U ≠ ∅ のとき。
      calc Mat.entry (orderedProduct SA M (annihilationTimesCreation M)) S U
          = Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) M) S U := rfl
        _ = vacuumIndicator M S U := hPi
        _ = 0 := if_neg (fun h => hU ((vacuumCond_last_iff S U).1 h).2)
        _ = kroneckerDelta (emptyIndexSet M) S * 0 := (mul_zero _).symm
        _ = kroneckerDelta (emptyIndexSet M) S * kroneckerDelta (emptyIndexSet M) U := by
            rw [show kroneckerDelta (emptyIndexSet M) U = (0 : ℂ) from if_neg (fun h => hU h.symm)]
        _ = Mat.entry (matrixUnit (emptyIndexSet M) (emptyIndexSet M)) S U := rfl
  · -- S ≠ ∅ のとき。
    calc Mat.entry (orderedProduct SA M (annihilationTimesCreation M)) S U
        = Mat.entry (partialOrderedProduct SA (annihilationTimesCreation M) M) S U := rfl
      _ = vacuumIndicator M S U := hPi
      _ = 0 := if_neg (fun h => hS ((vacuumCond_last_iff S U).1 h).1)
      _ = 0 * kroneckerDelta (emptyIndexSet M) U := (zero_mul _).symm
      _ = kroneckerDelta (emptyIndexSet M) S * kroneckerDelta (emptyIndexSet M) U := by
          rw [show kroneckerDelta (emptyIndexSet M) S = (0 : ℂ) from if_neg (fun h => hS h.symm)]
      _ = Mat.entry (matrixUnit (emptyIndexSet M) (emptyIndexSet M)) S U := rfl

/-! ### 部分集合の元の番号の生成作用素の行列を番号順に掛けた積 -/

open Classical in
/-- 本文 `claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit` の
y_t := c_t（t ∈ S）、1_{Mat}（t ∉ S）。 -/
noncomputable def selectedCreation (M : ℕ) (S : PowerSet M) (t : ℕ) : Mat (PowerSet M) :=
  if h : t ∈ S.1 then creationMatrix M t (S.2 t h) else Mat.one

/-- y_t の定め方：t ∈ S なら y_t = c_t。 -/
theorem selectedCreation_of_mem {M t : ℕ} (ht : 1 ≤ t ∧ t ≤ M) {S : PowerSet M} (h : t ∈ S.1) :
    selectedCreation M S t = creationMatrix M t ht :=
  dif_pos h

/-- y_t の定め方：t ∉ S なら y_t = 1_{Mat}。 -/
theorem selectedCreation_of_not_mem {M t : ℕ} {S : PowerSet M} (h : t ∉ S.1) :
    selectedCreation M S t = Mat.one :=
  dif_neg h

/-- 本文 `claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit` の準備（⋆）：
R のすべての元 t が t ≥ m + 1 を満たすなら c_m ·_{Mat_{P_M}} E_{R,∅} = E_{R∪{m},∅}。 -/
theorem creationMatrix_mul_matrixUnit {M m : ℕ} (hm : 1 ≤ m ∧ m ≤ M) (R : PowerSet M)
    (hR : ∀ t : ℕ, t ∈ R.1 → m + 1 ≤ t) :
    Mat.mul (isFiniteSet_powerSet M) (creationMatrix M m hm) (matrixUnit R (emptyIndexSet M))
      = matrixUnit (unionSingleton R m hm) (emptyIndexSet M) := Mat.ext fun X U => by
  let hX := isFiniteSet_powerSet M
  let E := matrixUnit R (emptyIndexSet M)
  -- m ∉ R
  have hmR : m ∉ R.1 := fun h => by have := hR m h; omega
  by_cases hmX : m ∈ X.1
  · by_cases hX' : removeIndex X m = R
    · -- m ∈ X かつ X' = R のとき。X = R ∪ {m}、N_m(R) = 0。
      have hXeq : X = unionSingleton R m hm :=
        ((unionSingleton_cond_iff_eq_removeIndex hm hmX R).2 hX'.symm).2
      have hN : countBelow R m = 0 :=
        countBelow_eq_zero_of_forall_ge R m hm.1 hm.2 (fun t ht => by have := hR t ht; omega)
      calc Mat.entry (Mat.mul hX (creationMatrix M m hm) E) X U
          = sign (countBelow (removeIndex X m) m) * Mat.entry E (removeIndex X m) U :=
            (entry_creationMatrix_mul hm E X U).1 hmX
        _ = sign (countBelow R m) * Mat.entry E R U := by rw [hX']
        _ = sign 0 * Mat.entry E R U := by rw [hN]
        _ = 1 * Mat.entry E R U := rfl
        _ = Mat.entry E R U := one_mul (Mat.entry E R U)
        _ = kroneckerDelta R R * kroneckerDelta (emptyIndexSet M) U := rfl
        _ = 1 * kroneckerDelta (emptyIndexSet M) U := by
            rw [show kroneckerDelta R R = (1 : ℂ) from if_pos rfl]
        _ = kroneckerDelta (unionSingleton R m hm) X * kroneckerDelta (emptyIndexSet M) U := by
            rw [show kroneckerDelta (unionSingleton R m hm) X = (1 : ℂ) from if_pos hXeq.symm]
        _ = Mat.entry (matrixUnit (unionSingleton R m hm) (emptyIndexSet M)) X U := rfl
    · -- m ∈ X かつ X' ≠ R のとき。X ≠ R ∪ {m}。
      have hXne : X ≠ unionSingleton R m hm := fun h =>
        hX' ((unionSingleton_cond_iff_eq_removeIndex hm hmX R).1 ⟨hmR, h⟩).symm
      calc Mat.entry (Mat.mul hX (creationMatrix M m hm) E) X U
          = sign (countBelow (removeIndex X m) m) * Mat.entry E (removeIndex X m) U :=
            (entry_creationMatrix_mul hm E X U).1 hmX
        _ = sign (countBelow (removeIndex X m) m)
              * (kroneckerDelta R (removeIndex X m) * kroneckerDelta (emptyIndexSet M) U) := rfl
        _ = sign (countBelow (removeIndex X m) m) * (0 * kroneckerDelta (emptyIndexSet M) U) := by
            rw [show kroneckerDelta R (removeIndex X m) = (0 : ℂ) from if_neg (fun h => hX' h.symm)]
        _ = sign (countBelow (removeIndex X m) m) * 0 := by
            rw [zero_mul (kroneckerDelta (emptyIndexSet M) U)]
        _ = 0 := mul_zero (sign (countBelow (removeIndex X m) m))
        _ = 0 * kroneckerDelta (emptyIndexSet M) U := (zero_mul _).symm
        _ = kroneckerDelta (unionSingleton R m hm) X * kroneckerDelta (emptyIndexSet M) U := by
            rw [show kroneckerDelta (unionSingleton R m hm) X = (0 : ℂ) from if_neg (fun h => hXne h.symm)]
        _ = Mat.entry (matrixUnit (unionSingleton R m hm) (emptyIndexSet M)) X U := rfl
  · -- m ∉ X のとき。m ∈ R ∪ {m} から R ∪ {m} ≠ X。
    have hne : unionSingleton R m hm ≠ X := fun h => hmX (h ▸ self_mem_unionSingleton R m hm)
    calc Mat.entry (Mat.mul hX (creationMatrix M m hm) E) X U
        = 0 := (entry_creationMatrix_mul hm E X U).2 hmX
      _ = 0 * kroneckerDelta (emptyIndexSet M) U := (zero_mul _).symm
      _ = kroneckerDelta (unionSingleton R m hm) X * kroneckerDelta (emptyIndexSet M) U := by
          rw [show kroneckerDelta (unionSingleton R m hm) X = (0 : ℂ) from if_neg hne]
      _ = Mat.entry (matrixUnit (unionSingleton R m hm) (emptyIndexSet M)) X U := rfl

/-- 本文 `claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit` の本題の前半：
m ∈ {0,1,…,M} で、R のすべての元 t が t ≥ m + 1 を満たすなら Π_m ·_{Mat_{P_M}} E_{R,∅} = E_{R^{⟨m⟩},∅}。 -/
theorem partialOrderedProduct_selectedCreation_mul_matrixUnit (M : ℕ) (S : PowerSet M) :
    ∀ m : ℕ, m ≤ M → ∀ R : PowerSet M, (∀ t : ℕ, t ∈ R.1 → m + 1 ≤ t) →
      Mat.mul (isFiniteSet_powerSet M)
          (partialOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M)) (selectedCreation M S) m)
          (matrixUnit R (emptyIndexSet M))
        = matrixUnit (addSelectedUpTo S m R) (emptyIndexSet M) := by
  let hX := isFiniteSet_powerSet M
  let SA := matricesComplexAlgebra hX
  intro m
  induction m with
  | zero =>
    intro _ R _
    calc Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) 0) (matrixUnit R (emptyIndexSet M))
        = Mat.mul hX Mat.one (matrixUnit R (emptyIndexSet M)) := rfl
      _ = matrixUnit R (emptyIndexSet M) := mat_one_mul hX (matrixUnit R (emptyIndexSet M))
      _ = matrixUnit (addSelectedUpTo S 0 R) (emptyIndexSet M) := by rw [addSelectedUpTo_zero S R]
  | succ m ih =>
    intro hmM R hR
    have hm : 1 ≤ m + 1 ∧ m + 1 ≤ M := ⟨Nat.succ_pos m, hmM⟩
    by_cases hmS : m + 1 ∈ S.1
    · -- m ∈ S のとき。R ∪ {m} のすべての元 t は t ≥ m = (m - 1) + 1 を満たす。
      have hR' : ∀ t : ℕ, t ∈ (unionSingleton R (m + 1) hm).1 → m + 1 ≤ t := by
        intro t ht
        rcases (mem_unionSingleton_iff R (m + 1) hm t).1 ht with h | h
        · have := hR t h
          omega
        · omega
      calc Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) (m + 1))
            (matrixUnit R (emptyIndexSet M))
          = Mat.mul hX (Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) m)
              (selectedCreation M S (m + 1))) (matrixUnit R (emptyIndexSet M)) := rfl
        _ = Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) m)
              (Mat.mul hX (selectedCreation M S (m + 1)) (matrixUnit R (emptyIndexSet M))) :=
            mat_mul_assoc hX _ _ _
        _ = Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) m)
              (Mat.mul hX (creationMatrix M (m + 1) hm) (matrixUnit R (emptyIndexSet M))) := by
            rw [selectedCreation_of_mem hm hmS]
        _ = Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) m)
              (matrixUnit (unionSingleton R (m + 1) hm) (emptyIndexSet M)) := by
            rw [creationMatrix_mul_matrixUnit hm R hR]
        _ = matrixUnit (addSelectedUpTo S m (unionSingleton R (m + 1) hm)) (emptyIndexSet M) :=
            ih (by omega) (unionSingleton R (m + 1) hm) hR'
        _ = matrixUnit (addSelectedUpTo S (m + 1) R) (emptyIndexSet M) := by
            rw [addSelectedUpTo_succ_of_mem hm S R hmS]
    · -- m ∉ S のとき。R のすべての元 t は t ≥ m + 1 > m = (m - 1) + 1 を満たす。
      have hR' : ∀ t : ℕ, t ∈ R.1 → m + 1 ≤ t := fun t ht => by have := hR t ht; omega
      calc Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) (m + 1))
            (matrixUnit R (emptyIndexSet M))
          = Mat.mul hX (Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) m)
              (selectedCreation M S (m + 1))) (matrixUnit R (emptyIndexSet M)) := rfl
        _ = Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) m)
              (Mat.mul hX (selectedCreation M S (m + 1)) (matrixUnit R (emptyIndexSet M))) :=
            mat_mul_assoc hX _ _ _
        _ = Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) m)
              (Mat.mul hX Mat.one (matrixUnit R (emptyIndexSet M))) := by
            rw [selectedCreation_of_not_mem hmS]
        _ = Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) m)
              (matrixUnit R (emptyIndexSet M)) := by
            rw [mat_one_mul hX (matrixUnit R (emptyIndexSet M))]
        _ = matrixUnit (addSelectedUpTo S m R) (emptyIndexSet M) := ih (by omega) R hR'
        _ = matrixUnit (addSelectedUpTo S (m + 1) R) (emptyIndexSet M) := by
            rw [addSelectedUpTo_succ_of_not_mem m S R hmS]

/-- 本文 `claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit`：
(∏_{Mat_{P_M}, t=1}^{M} y_t) ·_{Mat_{P_M}} E_{∅,∅} = E_{S,∅}。 -/
theorem orderedProduct_selectedCreation_mul_vacuumMatrixUnit (M : ℕ) (S : PowerSet M) :
    Mat.mul (isFiniteSet_powerSet M)
        (orderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M)) M (selectedCreation M S))
        (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
      = matrixUnit S (emptyIndexSet M) :=
  let hX := isFiniteSet_powerSet M
  let SA := matricesComplexAlgebra hX
  calc Mat.mul hX (orderedProduct SA M (selectedCreation M S)) (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
      = Mat.mul hX (partialOrderedProduct SA (selectedCreation M S) M)
          (matrixUnit (emptyIndexSet M) (emptyIndexSet M)) := rfl
    _ = matrixUnit (addSelectedUpTo S M (emptyIndexSet M)) (emptyIndexSet M) :=
        -- ∅ は元を持たないので、m := M、R := ∅ に前半の命題を当てられる
        partialOrderedProduct_selectedCreation_mul_matrixUnit M S M (le_refl M) (emptyIndexSet M)
          (fun t ht => absurd ht (notMem_emptyIndexSet M t))
    _ = matrixUnit S (emptyIndexSet M) := by rw [addSelectedUpTo_last_empty S]

/-! ### 部分集合の元の番号の消滅作用素の行列を番号の逆順に掛けた積 -/

open Classical in
/-- 本文 `claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices` の
z_t := c_t^T（t ∈ T）、1_{Mat}（t ∉ T）。 -/
noncomputable def selectedAnnihilation (M : ℕ) (T : PowerSet M) (t : ℕ) : Mat (PowerSet M) :=
  if h : t ∈ T.1 then annihilationMatrix M t (T.2 t h) else Mat.one

/-- 本文の番号を逆順に並べ直した族 ž_k := z_{M+1-k}。 -/
noncomputable def reversedSelectedAnnihilation (M : ℕ) (T : PowerSet M) (k : ℕ) : Mat (PowerSet M) :=
  selectedAnnihilation M T (M + 1 - k)

/-- ž_k = z_{M+1-k} で、M + 1 - k ∈ T なので z の定め方から ž_k = c_{M+1-k}^T。 -/
theorem reversedSelectedAnnihilation_of_mem {M k : ℕ} (hs : 1 ≤ M + 1 - k ∧ M + 1 - k ≤ M)
    {T : PowerSet M} (h : M + 1 - k ∈ T.1) :
    reversedSelectedAnnihilation M T k = annihilationMatrix M (M + 1 - k) hs :=
  dif_pos h

/-- ž_k = z_{M+1-k} で、M + 1 - k ∉ T なので z の定め方から ž_k = 1_{Mat}。 -/
theorem reversedSelectedAnnihilation_of_not_mem {M k : ℕ} {T : PowerSet M} (h : M + 1 - k ∉ T.1) :
    reversedSelectedAnnihilation M T k = Mat.one :=
  dif_neg h

/-- 本文 `claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices` の準備（⋆）：
R のすべての元 t が t ≥ s + 1 を満たすなら E_{∅,R} ·_{Mat_{P_M}} c_s^T = E_{∅,R∪{s}}。 -/
theorem matrixUnit_mul_annihilationMatrix {M s : ℕ} (hs : 1 ≤ s ∧ s ≤ M) (R : PowerSet M)
    (hR : ∀ t : ℕ, t ∈ R.1 → s + 1 ≤ t) :
    Mat.mul (isFiniteSet_powerSet M) (matrixUnit (emptyIndexSet M) R) (annihilationMatrix M s hs)
      = matrixUnit (emptyIndexSet M) (unionSingleton R s hs) := Mat.ext fun X U => by
  let hX := isFiniteSet_powerSet M
  let V := complexNumbersVectorSpace
  let E := matrixUnit (emptyIndexSet M) R
  -- s ∉ R、N_s(R) = 0
  have hsR : s ∉ R.1 := fun h => by have := hR s h; omega
  have hN : countBelow R s = 0 :=
    countBelow_eq_zero_of_forall_ge R s hs.1 hs.2 (fun t ht => by have := hR t ht; omega)
  -- r_Y := δ_{∅,X} ·_ℂ (c_s)_{U,Y}
  let r : PowerSet M → ℂ := fun Y =>
    kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix M s hs) U Y
  -- 和の項の書き直し
  have hterm : ∀ Y : PowerSet M,
      V.smul (Mat.entry E X Y) (Mat.entry (annihilationMatrix M s hs) Y U)
        = V.smul (kroneckerDelta R Y) (r Y) := fun Y => calc
    V.smul (Mat.entry E X Y) (Mat.entry (annihilationMatrix M s hs) Y U)
        = Mat.entry E X Y * Mat.entry (annihilationMatrix M s hs) Y U := rfl
    _ = (kroneckerDelta (emptyIndexSet M) X * kroneckerDelta R Y)
          * Mat.entry (annihilationMatrix M s hs) Y U := rfl
    _ = (kroneckerDelta (emptyIndexSet M) X * kroneckerDelta R Y)
          * Mat.entry (creationMatrix M s hs) U Y := rfl
    _ = (kroneckerDelta R Y * kroneckerDelta (emptyIndexSet M) X)
          * Mat.entry (creationMatrix M s hs) U Y := by
        rw [mul_comm (kroneckerDelta (emptyIndexSet M) X) (kroneckerDelta R Y)]
    _ = kroneckerDelta R Y
          * (kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix M s hs) U Y) :=
        mul_assoc (kroneckerDelta R Y) (kroneckerDelta (emptyIndexSet M) X)
          (Mat.entry (creationMatrix M s hs) U Y)
    _ = kroneckerDelta R Y * r Y := rfl
    _ = V.smul (kroneckerDelta R Y) (r Y) := rfl
  -- （†）
  have hdagger : Mat.entry (Mat.mul hX E (annihilationMatrix M s hs)) X U
      = kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix M s hs) U R := calc
    Mat.entry (Mat.mul hX E (annihilationMatrix M s hs)) X U
        = sumOverFiniteSet V hX (fun Y => Mat.entry E X Y)
            (fun Y => Mat.entry (annihilationMatrix M s hs) Y U) := rfl
    _ = sumOverFiniteSet V hX (fun Y => kroneckerDelta R Y) r :=
        sumOverFiniteSet_congr V hX _ _ _ _ hterm
    _ = r R := sumOverFiniteSet_kroneckerDelta V hX r R
    _ = kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix M s hs) U R := rfl
  by_cases hU : U = unionSingleton R s hs
  · -- U = R ∪ {s} のとき。c_s の条件「s ∉ R かつ U = R ∪ {s}」が成り立つ。
    calc Mat.entry (Mat.mul hX E (annihilationMatrix M s hs)) X U
        = kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix M s hs) U R := hdagger
      _ = kroneckerDelta (emptyIndexSet M) X * sign (countBelow R s) := by
          rw [creationMatrix_entry_of_cond hs ⟨hsR, hU⟩]
      _ = kroneckerDelta (emptyIndexSet M) X * sign 0 := by rw [hN]
      _ = kroneckerDelta (emptyIndexSet M) X * 1 := rfl
      _ = kroneckerDelta (emptyIndexSet M) X * kroneckerDelta (unionSingleton R s hs) U := by
          rw [show kroneckerDelta (unionSingleton R s hs) U = (1 : ℂ) from if_pos hU.symm]
      _ = Mat.entry (matrixUnit (emptyIndexSet M) (unionSingleton R s hs)) X U := rfl
  · -- U ≠ R ∪ {s} のとき。c_s の条件は成り立たない。
    calc Mat.entry (Mat.mul hX E (annihilationMatrix M s hs)) X U
        = kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix M s hs) U R := hdagger
      _ = kroneckerDelta (emptyIndexSet M) X * 0 := by
          rw [creationMatrix_entry_of_not_cond hs (fun h => hU h.2)]
      _ = kroneckerDelta (emptyIndexSet M) X * kroneckerDelta (unionSingleton R s hs) U := by
          rw [show kroneckerDelta (unionSingleton R s hs) U = (0 : ℂ) from if_neg (fun h => hU h.symm)]
      _ = Mat.entry (matrixUnit (emptyIndexSet M) (unionSingleton R s hs)) X U := rfl

/-- 本文 `claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices` の本題の前半：
すべての m ∈ {0,1,…,M} で E_{∅,∅} ·_{Mat_{P_M}} Π_m = E_{∅,T^{⟨m⟩}}。 -/
theorem vacuumMatrixUnit_mul_partialOrderedProduct (M : ℕ) (T : PowerSet M) :
    ∀ m : ℕ, m ≤ M →
      Mat.mul (isFiniteSet_powerSet M) (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
          (partialOrderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M))
            (reversedSelectedAnnihilation M T) m)
        = matrixUnit (emptyIndexSet M) (selectedFrom T m) := by
  let hX := isFiniteSet_powerSet M
  let SA := matricesComplexAlgebra hX
  let E := matrixUnit (emptyIndexSet M) (emptyIndexSet M)
  intro m
  induction m with
  | zero =>
    intro _
    calc Mat.mul hX E (partialOrderedProduct SA (reversedSelectedAnnihilation M T) 0)
        = Mat.mul hX E Mat.one := rfl
      _ = E := mat_mul_one hX E
      _ = matrixUnit (emptyIndexSet M) (selectedFrom T 0) := by rw [selectedFrom_zero T]
  | succ m ih =>
    intro hmM
    -- s := M + 1 - m ∈ {1,…,M}（m を m + 1 と書く）
    have hs : 1 ≤ M + 1 - (m + 1) ∧ M + 1 - (m + 1) ≤ M := ⟨by omega, by omega⟩
    by_cases hsT : M + 1 - (m + 1) ∈ T.1
    · -- s ∈ T のとき。
      calc Mat.mul hX E (partialOrderedProduct SA (reversedSelectedAnnihilation M T) (m + 1))
          = Mat.mul hX E (Mat.mul hX (partialOrderedProduct SA (reversedSelectedAnnihilation M T) m)
              (reversedSelectedAnnihilation M T (m + 1))) := rfl
        _ = Mat.mul hX (Mat.mul hX E (partialOrderedProduct SA (reversedSelectedAnnihilation M T) m))
              (reversedSelectedAnnihilation M T (m + 1)) := (mat_mul_assoc hX _ _ _).symm
        _ = Mat.mul hX (matrixUnit (emptyIndexSet M) (selectedFrom T m))
              (reversedSelectedAnnihilation M T (m + 1)) := by rw [ih (by omega)]
        _ = Mat.mul hX (matrixUnit (emptyIndexSet M) (selectedFrom T m))
              (annihilationMatrix M (M + 1 - (m + 1)) hs) := by
            rw [reversedSelectedAnnihilation_of_mem hs hsT]
        _ = matrixUnit (emptyIndexSet M) (unionSingleton (selectedFrom T m) (M + 1 - (m + 1)) hs) :=
            matrixUnit_mul_annihilationMatrix hs (selectedFrom T m) (selectedFrom_ge hmM T)
        _ = matrixUnit (emptyIndexSet M) (selectedFrom T (m + 1)) := by
            rw [selectedFrom_succ_of_mem hmM hs T hsT]
    · -- s ∉ T のとき。
      calc Mat.mul hX E (partialOrderedProduct SA (reversedSelectedAnnihilation M T) (m + 1))
          = Mat.mul hX E (Mat.mul hX (partialOrderedProduct SA (reversedSelectedAnnihilation M T) m)
              (reversedSelectedAnnihilation M T (m + 1))) := rfl
        _ = Mat.mul hX (Mat.mul hX E (partialOrderedProduct SA (reversedSelectedAnnihilation M T) m))
              (reversedSelectedAnnihilation M T (m + 1)) := (mat_mul_assoc hX _ _ _).symm
        _ = Mat.mul hX (matrixUnit (emptyIndexSet M) (selectedFrom T m))
              (reversedSelectedAnnihilation M T (m + 1)) := by rw [ih (by omega)]
        _ = Mat.mul hX (matrixUnit (emptyIndexSet M) (selectedFrom T m)) Mat.one := by
            rw [reversedSelectedAnnihilation_of_not_mem hsT]
        _ = matrixUnit (emptyIndexSet M) (selectedFrom T m) :=
            mat_mul_one hX (matrixUnit (emptyIndexSet M) (selectedFrom T m))
        _ = matrixUnit (emptyIndexSet M) (selectedFrom T (m + 1)) := by
            rw [selectedFrom_succ_of_not_mem hmM T hsT]

/-- 本文 `claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices`：
E_{∅,∅} ·_{Mat_{P_M}} (∏_{Mat_{P_M}, k=1}^{M} ž_k) = E_{∅,T}。 -/
theorem vacuumMatrixUnit_mul_orderedProduct_reversedSelectedAnnihilation (M : ℕ) (T : PowerSet M) :
    Mat.mul (isFiniteSet_powerSet M) (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
        (orderedProduct (matricesComplexAlgebra (isFiniteSet_powerSet M)) M (reversedSelectedAnnihilation M T))
      = matrixUnit (emptyIndexSet M) T :=
  let hX := isFiniteSet_powerSet M
  let SA := matricesComplexAlgebra hX
  calc Mat.mul hX (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
        (orderedProduct SA M (reversedSelectedAnnihilation M T))
      = Mat.mul hX (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
          (partialOrderedProduct SA (reversedSelectedAnnihilation M T) M) := rfl
    _ = matrixUnit (emptyIndexSet M) (selectedFrom T M) :=
        vacuumMatrixUnit_mul_partialOrderedProduct M T M (le_refl M)
    _ = matrixUnit (emptyIndexSet M) T := by rw [selectedFrom_last T]

end CliffordMatrixIsomorphism.Isomorphism
