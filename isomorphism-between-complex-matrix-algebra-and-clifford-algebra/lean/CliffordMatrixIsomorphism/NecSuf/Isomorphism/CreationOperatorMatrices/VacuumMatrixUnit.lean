/-
章「同型の証明」の、空集合の位置の行列単位についての三つの主張の必要十分版。具体版
`Isomorphism/CreationOperatorMatrices/VacuumMatrixUnit.lean` と同じ def と同じ calc の行のまま、係数 ℂ を型の変数 K に、
-1_ℂ を K の元 n に替える（ς は `sign n`、c_i・c_i^T は `creationMatrix n`・`annihilationMatrix n`）。
K には演算の記号 +・·・0・1 だけを与え、使う性質は仮定として渡す。集合と条件（∅・C_m(S,U)・R^{⟨m⟩}・T^{⟨m⟩}）は ℂ を含まないので、
具体版と同じ `VacuumIndexSets.lean` を引く。

  本文のラベル                                                                           このファイル
  claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit    annihilationTimesCreation・notMemIndicator・
                                                                                         vacuumIndicator・entry_annihilationTimesCreation・
                                                                                         vacuumIndicator_mul_notMemIndicator・
                                                                                         entry_partialOrderedProduct_annihilationTimesCreation・
                                                                                         orderedProduct_annihilationTimesCreation_eq_vacuumMatrixUnit
  claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit           selectedCreation・creationMatrix_mul_matrixUnit・
                                                                                         partialOrderedProduct_selectedCreation_mul_matrixUnit・
                                                                                         orderedProduct_selectedCreation_mul_vacuumMatrixUnit
  claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices
                                                                                         selectedAnnihilation・reversedSelectedAnnihilation・
                                                                                         matrixUnit_mul_annihilationMatrix・
                                                                                         vacuumMatrixUnit_mul_partialOrderedProduct・
                                                                                         vacuumMatrixUnit_mul_orderedProduct_reversedSelectedAnnihilation

主張ごとに使う K の性質（L : `ValuedMapsLaws K` は積 `Mat.mul L hX` を定めるのに要る八つ。行の中で L から使うのは、
乗法の結合法則、1 · a = a、和の主張に渡す 0 + 0 = 0（`L.add_zero 0`）だけである）:
  （⋆_1）(x_i)_{T,U}                    L・a · 1 = a・a · 0 = 0・0 · a = 0・`SignLaws K n`（ς(k) · ς(k) = 1）
  （⋆_2）χ_{m-1} · η_m = χ_m            1 · 1 = 1（L）・a · 0 = 0・0 · a = 0
  第一の主張（x_i の番号順の積）        （⋆_1）の性質。行列の集合を代数にするための乗法の交換法則
  （⋆）c_m · E_{R,∅}                    L・a · 0 = 0・0 · a = 0（n についての性質は使わない）
  第二の主張（y_t の番号順の積）        （⋆）の性質・乗法の交換法則
  （⋆）E_{∅,R} · c_s^T                  L・乗法の交換法則（n についての性質も、a · 0 = 0 も使わない）
  第三の主張（ž_k の番号順の積）        （⋆）の性質・a · 0 = 0

分かったこと:
- 三つの主張の番号順の積は、行列の集合を代数にした `matricesAlgebra L hcomm hmul0 hX` の中の積なので、どの主張も
  その代数を作るのに要る乗法の交換法則と a · 0 = 0 を仮定に持つ。第一の主張の証明の行は、乗法の交換法則を使わない。
  具体版が ℂ の乗法の交換法則を当てる (Π_{m-1})_{S,T} · δ_{U,T} = δ_{U,T} · (Π_{m-1})_{S,T} の行は、δ の値が 1 か 0 なので
  a · 1 = a・1 · a = a・a · 0 = 0・0 · a = 0 から得る（`mul_kroneckerDelta_comm`、`CreationMatrices.lean`）。
- 第二・第三の主張が乗法の交換法則と a · 0 = 0 を行の中で使うのは、行列の積の結合法則（`mat_mul_assoc`）と、
  右から単位行列を掛けても変わらないこと（`mat_mul_one`、第三の主張。これ自体は 0 と 1 の交換だけを要る）を引く行である。第三の主張の (⋆) は、
  δ_{∅,X} · δ_{R,Y} を入れ替える行でも乗法の交換法則を使う（δ どうしなので 0 と 1 の交換だけで足りるが、主張全体が
  行列の積の結合法則のために交換法則を仮定に持つので、具体版と同じ形で当てる）。
- 第二・第三の主張は n について何も仮定しない。使う符号は ς(N_m(R)) で、N_m(R) = 0 から ς(0) = 1 は定義による。
  第一の主張だけが ς(k) · ς(k) = 1（本文 claim_sign_of_nonnegative_integer_squares_to_one）を使うので `SignLaws K n` を要る。

削れなかった仮定:
- 乗法の交換法則（三つの主張）: 番号順の積を、本文どおり ℂ-代数 Mat_{P_M} の中の番号順の積（def_ordered_product_in_algebra）として
  述べるため。`matricesAlgebra` の乗法の結合法則・右の単位元・右の因子のスカラー倍との両立の三つの欄が使う
  （`NecSuf/ComplexMatrixAlgebra/MatrixAlgebra/Algebra.lean`）。第二・第三の主張は、証明の行でも行列の積の結合法則のために使う。
- a · 0 = 0（三つの主張）: 同じく `matricesAlgebra` の欄（結合法則と、スカラー倍と積の両立）と、0 との積の行。
- a · 1 = a（第一の主張）: 右から c_i を掛けた行列の成分の主張と、δ の値との交換の行。
- 0 · a = 0（第一・第二の主張）: 0 との積の行と、生成作用素の行列を掛けた行列の成分の主張。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.CreationOperatorMatrices.CreationMatrices
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixUnits.MatrixUnits
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Algebra
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.VacuumIndexSets

namespace CliffordMatrixIsomorphism.NecSuf.Isomorphism

open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet)
open CliffordMatrixIsomorphism.Isomorphism
  (countBelow unionSingleton removeIndex unionSingleton_cond_iff_eq_removeIndex self_mem_unionSingleton
    mem_unionSingleton_iff countBelow_eq_zero_of_forall_ge emptyIndexSet notMem_emptyIndexSet
    unionSingleton_eq_cond_iff vacuumCond vacuumCond_succ_iff vacuumCond_zero_iff vacuumCond_last_iff
    addSelectedUpTo addSelectedUpTo_zero addSelectedUpTo_succ_of_mem addSelectedUpTo_succ_of_not_mem
    addSelectedUpTo_last_empty selectedFrom selectedFrom_zero selectedFrom_ge selectedFrom_succ_of_mem
    selectedFrom_succ_of_not_mem selectedFrom_last)

universe uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K]

/-! ### 消滅作用素の行列と生成作用素の行列の積を番号順に掛けた積 -/

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit` の必要十分版の
x_i := c_i^T ·_{Mat_{P_M}} c_i（i ∈ {1,…,M}。{1,…,M} の外の値 1_{Mat} は使わない）。 -/
noncomputable def annihilationTimesCreation (L : ValuedMapsLaws K) (n : K) (M : ℕ) (i : ℕ) : Mat K (PowerSet M) :=
  if hi : 1 ≤ i ∧ i ≤ M then
    Mat.mul L (isFiniteSet_powerSet M) (annihilationMatrix n M i hi) (creationMatrix n M i hi)
  else Mat.one

/-- x_i の置き方：i ∈ {1,…,M} なら x_i = c_i^T ·_{Mat_{P_M}} c_i。 -/
theorem annihilationTimesCreation_of_mem (L : ValuedMapsLaws K) (n : K) {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) :
    annihilationTimesCreation L n M i
      = Mat.mul L (isFiniteSet_powerSet M) (annihilationMatrix n M i hi) (creationMatrix n M i hi) :=
  dif_pos hi

open Classical in
/-- 本文の η_i(U)：i ∉ U なら 1、i ∈ U なら 0。 -/
noncomputable def notMemIndicator {M : ℕ} (i : ℕ) (U : PowerSet M) : K :=
  if i ∉ U.1 then 1 else 0

open Classical in
/-- 本文の χ_m(S,U)：C_m(S,U) が成り立つなら 1、成り立たないなら 0。 -/
noncomputable def vacuumIndicator {M : ℕ} (m : ℕ) (S U : PowerSet M) : K :=
  if vacuumCond m S U then 1 else 0

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit` の必要十分版の準備の一つ目（⋆_1）：
(x_i)_{T,U} = δ_{U,T} · η_i(U)。 -/
theorem entry_annihilationTimesCreation (L : ValuedMapsLaws K) (hmul1 : ∀ a : K, a * 1 = a) (hmul0 : ∀ a : K, a * 0 = 0)
    (hzero_mul : ∀ a : K, 0 * a = 0) (n : K) (hsign : SignLaws K n) {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (T U : PowerSet M) :
    Mat.entry (annihilationTimesCreation L n M i) T U = kroneckerDelta U T * notMemIndicator i U := by
  let hX := isFiniteSet_powerSet M
  by_cases hiU : i ∈ U.1
  · -- i ∈ U のとき。
    calc Mat.entry (annihilationTimesCreation L n M i) T U
        = Mat.entry (Mat.mul L hX (annihilationMatrix n M i hi) (creationMatrix n M i hi)) T U := by
          rw [annihilationTimesCreation_of_mem L n hi]
      _ = 0 := (entry_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi (annihilationMatrix n M i hi) T U).2 hiU
      _ = kroneckerDelta U T * 0 := (hmul0 (kroneckerDelta U T)).symm
      _ = kroneckerDelta U T * notMemIndicator i U := by
          rw [show notMemIndicator i U = (0 : K) from if_neg (fun h => h hiU)]
  · -- i ∉ U のとき。c_i の (U ∪ {i}, T) 成分の条件は T = U と同値（`unionSingleton_eq_cond_iff`）。
    by_cases hTU : T = U
    · calc Mat.entry (annihilationTimesCreation L n M i) T U
          = Mat.entry (Mat.mul L hX (annihilationMatrix n M i hi) (creationMatrix n M i hi)) T U := by
            rw [annihilationTimesCreation_of_mem L n hi]
        _ = Mat.entry (annihilationMatrix n M i hi) T (unionSingleton U i hi) * sign n (countBelow U i) :=
            (entry_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi (annihilationMatrix n M i hi) T U).1 hiU
        _ = Mat.entry (creationMatrix n M i hi) (unionSingleton U i hi) T * sign n (countBelow U i) := rfl
        _ = sign n (countBelow T i) * sign n (countBelow U i) := by
            rw [creationMatrix_entry_of_cond n hi ((unionSingleton_eq_cond_iff hi hiU T).2 hTU)]
        _ = sign n (countBelow U i) * sign n (countBelow U i) := by rw [hTU]
        _ = 1 := sign_mul_self hsign (countBelow U i)
        _ = 1 * 1 := (L.one_mul (1 : K)).symm
        _ = kroneckerDelta U T * 1 := by rw [show kroneckerDelta U T = (1 : K) from if_pos hTU.symm]
        _ = kroneckerDelta U T * notMemIndicator i U := by
            rw [show notMemIndicator i U = (1 : K) from if_pos hiU]
    · calc Mat.entry (annihilationTimesCreation L n M i) T U
          = Mat.entry (Mat.mul L hX (annihilationMatrix n M i hi) (creationMatrix n M i hi)) T U := by
            rw [annihilationTimesCreation_of_mem L n hi]
        _ = Mat.entry (annihilationMatrix n M i hi) T (unionSingleton U i hi) * sign n (countBelow U i) :=
            (entry_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi (annihilationMatrix n M i hi) T U).1 hiU
        _ = Mat.entry (creationMatrix n M i hi) (unionSingleton U i hi) T * sign n (countBelow U i) := rfl
        _ = 0 * sign n (countBelow U i) := by
            rw [creationMatrix_entry_of_not_cond n hi
              (fun h => hTU ((unionSingleton_eq_cond_iff hi hiU T).1 h))]
        _ = 0 := hzero_mul (sign n (countBelow U i))
        _ = 0 * notMemIndicator i U := (hzero_mul (notMemIndicator i U)).symm
        _ = kroneckerDelta U T * notMemIndicator i U := by
            rw [show kroneckerDelta U T = (0 : K) from if_neg (fun h => hTU h.symm)]

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit` の必要十分版の準備の二つ目（⋆_2）：
χ_{m-1}(S,U) · η_m(U) = χ_m(S,U)（m を m + 1 と書く）。 -/
theorem vacuumIndicator_mul_notMemIndicator (L : ValuedMapsLaws K) (hmul0 : ∀ a : K, a * 0 = 0)
    (hzero_mul : ∀ a : K, 0 * a = 0) {M : ℕ} (m : ℕ) (S U : PowerSet M) :
    (vacuumIndicator m S U : K) * notMemIndicator (m + 1) U = vacuumIndicator (m + 1) S U := by
  by_cases hC : vacuumCond (m + 1) S U
  · -- C_m(S,U) が成り立つとき。
    have h := (vacuumCond_succ_iff m S U).1 hC
    calc (vacuumIndicator m S U : K) * notMemIndicator (m + 1) U
        = 1 * notMemIndicator (m + 1) U := by
          rw [show vacuumIndicator m S U = (1 : K) from if_pos h.1]
      _ = 1 * 1 := by rw [show notMemIndicator (m + 1) U = (1 : K) from if_pos h.2]
      _ = 1 := L.one_mul (1 : K)
      _ = vacuumIndicator (m + 1) S U := (if_pos hC).symm
  · by_cases hC' : vacuumCond m S U
    · -- C_m(S,U) が成り立たず、C_{m-1}(S,U) が成り立つとき。上の同値から m ∈ U。
      have hmU : m + 1 ∈ U.1 := by
        by_contra hmU
        exact hC ((vacuumCond_succ_iff m S U).2 ⟨hC', hmU⟩)
      calc (vacuumIndicator m S U : K) * notMemIndicator (m + 1) U
          = vacuumIndicator m S U * 0 := by
            rw [show notMemIndicator (m + 1) U = (0 : K) from if_neg (fun h => h hmU)]
        _ = 0 := hmul0 (vacuumIndicator m S U)
        _ = vacuumIndicator (m + 1) S U := (if_neg hC).symm
    · -- C_m(S,U) も C_{m-1}(S,U) も成り立たないとき。
      calc (vacuumIndicator m S U : K) * notMemIndicator (m + 1) U
          = 0 * notMemIndicator (m + 1) U := by
            rw [show vacuumIndicator m S U = (0 : K) from if_neg hC']
        _ = 0 := hzero_mul (notMemIndicator (m + 1) U)
        _ = vacuumIndicator (m + 1) S U := (if_neg hC).symm

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit` の必要十分版の本題の前半：
すべての m ∈ {0,1,…,M} と S, U ∈ P_M について (Π_m)_{S,U} = χ_m(S,U)。 -/
theorem entry_partialOrderedProduct_annihilationTimesCreation (L : ValuedMapsLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (hmul1 : ∀ a : K, a * 1 = a)
    (hzero_mul : ∀ a : K, 0 * a = 0) (n : K) (hsign : SignLaws K n) (M : ℕ) :
    ∀ m : ℕ, m ≤ M → ∀ S U : PowerSet M,
      Mat.entry (AlgebraOver.partialOrderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M))
          (annihilationTimesCreation L n M) m) S U
        = vacuumIndicator m S U := by
  let hX := isFiniteSet_powerSet M
  let SA := matricesAlgebra L hcomm hmul0 hX
  let V := coefficientsVec L
  intro m
  induction m with
  | zero =>
    intro _ S U
    by_cases hSU : S = U
    · calc Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) 0) S U
          = Mat.entry (Mat.one : Mat K (PowerSet M)) S U := rfl
        _ = kroneckerDelta S U := rfl
        _ = 1 := if_pos hSU
        _ = vacuumIndicator 0 S U := (if_pos ((vacuumCond_zero_iff S U).2 hSU)).symm
    · calc Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) 0) S U
          = Mat.entry (Mat.one : Mat K (PowerSet M)) S U := rfl
        _ = kroneckerDelta S U := rfl
        _ = 0 := if_neg hSU
        _ = vacuumIndicator 0 S U := (if_neg (fun h => hSU ((vacuumCond_zero_iff S U).1 h))).symm
  | succ m ih =>
    intro hmM S U
    have hm : 1 ≤ m + 1 ∧ m + 1 ≤ M := ⟨Nat.succ_pos m, hmM⟩
    -- r_T := (Π_{m-1})_{S,T} · η_m(U)
    let r : PowerSet M → K := fun T =>
      Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T * notMemIndicator (m + 1) U
    -- 和の項のデルタを係数の位置へ移した等式
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T)
            (Mat.entry (annihilationTimesCreation L n M (m + 1)) T U)
          = V.smul (kroneckerDelta U T) (r T) := fun T => calc
      V.smul (Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T)
            (Mat.entry (annihilationTimesCreation L n M (m + 1)) T U)
          = Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T
              * Mat.entry (annihilationTimesCreation L n M (m + 1)) T U := rfl
      _ = Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T
              * (kroneckerDelta U T * notMemIndicator (m + 1) U) := by
          rw [entry_annihilationTimesCreation L hmul1 hmul0 hzero_mul n hsign hm T U]
      _ = (Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T * kroneckerDelta U T)
              * notMemIndicator (m + 1) U :=
          (L.mul_assoc (Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T)
            (kroneckerDelta U T) (notMemIndicator (m + 1) U)).symm
      _ = (kroneckerDelta U T * Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T)
              * notMemIndicator (m + 1) U := by
          rw [mul_kroneckerDelta_comm L hmul1 hmul0 hzero_mul
            (Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T) U T]
      _ = kroneckerDelta U T
              * (Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T
                * notMemIndicator (m + 1) U) :=
          L.mul_assoc (kroneckerDelta U T)
            (Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T)
            (notMemIndicator (m + 1) U)
      _ = kroneckerDelta U T * r T := rfl
      _ = V.smul (kroneckerDelta U T) (r T) := rfl
    calc Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) (m + 1)) S U
        = Mat.entry (Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m)
            (annihilationTimesCreation L n M (m + 1))) S U := rfl
      _ = sumOverFiniteSet V hX
            (fun T => Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S T)
            (fun T => Mat.entry (annihilationTimesCreation L n M (m + 1)) T U) := rfl
      _ = sumOverFiniteSet V hX (fun T => kroneckerDelta U T) r :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = r U := sumOverFiniteSet_kroneckerDelta V (L.add_zero 0) hX r U
      _ = Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) m) S U
            * notMemIndicator (m + 1) U := rfl
      _ = vacuumIndicator m S U * notMemIndicator (m + 1) U := by rw [ih (by omega) S U]
      _ = vacuumIndicator (m + 1) S U := vacuumIndicator_mul_notMemIndicator L hmul0 hzero_mul m S U

/-- 本文 `claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit` の必要十分版：
∏_{Mat_{P_M}, i=1}^{M} x_i = E_{∅,∅}。 -/
theorem orderedProduct_annihilationTimesCreation_eq_vacuumMatrixUnit (L : ValuedMapsLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (hmul1 : ∀ a : K, a * 1 = a)
    (hzero_mul : ∀ a : K, 0 * a = 0) (n : K) (hsign : SignLaws K n) (M : ℕ) :
    AlgebraOver.orderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M)) M (annihilationTimesCreation L n M)
      = matrixUnit (emptyIndexSet M) (emptyIndexSet M) := Mat.ext fun S U => by
  let SA := matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M)
  have hPi := entry_partialOrderedProduct_annihilationTimesCreation L hcomm hmul0 hmul1 hzero_mul n hsign M M (le_refl M) S U
  by_cases hS : S = emptyIndexSet M
  · by_cases hU : U = emptyIndexSet M
    · -- S = ∅ かつ U = ∅ のとき。
      calc Mat.entry (AlgebraOver.orderedProduct SA M (annihilationTimesCreation L n M)) S U
          = Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) M) S U := rfl
        _ = vacuumIndicator M S U := hPi
        _ = 1 := if_pos ((vacuumCond_last_iff S U).2 ⟨hS, hU⟩)
        _ = 1 * 1 := (L.one_mul (1 : K)).symm
        _ = kroneckerDelta (emptyIndexSet M) S * kroneckerDelta (emptyIndexSet M) U := by
            rw [show kroneckerDelta (emptyIndexSet M) S = (1 : K) from if_pos hS.symm,
              show kroneckerDelta (emptyIndexSet M) U = (1 : K) from if_pos hU.symm]
        _ = Mat.entry (matrixUnit (emptyIndexSet M) (emptyIndexSet M)) S U := rfl
    · -- S = ∅ かつ U ≠ ∅ のとき。
      calc Mat.entry (AlgebraOver.orderedProduct SA M (annihilationTimesCreation L n M)) S U
          = Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) M) S U := rfl
        _ = vacuumIndicator M S U := hPi
        _ = 0 := if_neg (fun h => hU ((vacuumCond_last_iff S U).1 h).2)
        _ = kroneckerDelta (emptyIndexSet M) S * 0 := (hmul0 _).symm
        _ = kroneckerDelta (emptyIndexSet M) S * kroneckerDelta (emptyIndexSet M) U := by
            rw [show kroneckerDelta (emptyIndexSet M) U = (0 : K) from if_neg (fun h => hU h.symm)]
        _ = Mat.entry (matrixUnit (emptyIndexSet M) (emptyIndexSet M)) S U := rfl
  · -- S ≠ ∅ のとき。
    calc Mat.entry (AlgebraOver.orderedProduct SA M (annihilationTimesCreation L n M)) S U
        = Mat.entry (AlgebraOver.partialOrderedProduct SA (annihilationTimesCreation L n M) M) S U := rfl
      _ = vacuumIndicator M S U := hPi
      _ = 0 := if_neg (fun h => hS ((vacuumCond_last_iff S U).1 h).1)
      _ = 0 * kroneckerDelta (emptyIndexSet M) U := (hzero_mul _).symm
      _ = kroneckerDelta (emptyIndexSet M) S * kroneckerDelta (emptyIndexSet M) U := by
          rw [show kroneckerDelta (emptyIndexSet M) S = (0 : K) from if_neg (fun h => hS h.symm)]
      _ = Mat.entry (matrixUnit (emptyIndexSet M) (emptyIndexSet M)) S U := rfl

/-! ### 部分集合の元の番号の生成作用素の行列を番号順に掛けた積 -/

open Classical in
/-- 本文 `claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit` の必要十分版の
y_t := c_t（t ∈ S）、1_{Mat}（t ∉ S）。 -/
noncomputable def selectedCreation (n : K) (M : ℕ) (S : PowerSet M) (t : ℕ) : Mat K (PowerSet M) :=
  if h : t ∈ S.1 then creationMatrix n M t (S.2 t h) else Mat.one

omit [Add K] in
/-- y_t の定め方：t ∈ S なら y_t = c_t。 -/
theorem selectedCreation_of_mem (n : K) {M t : ℕ} (ht : 1 ≤ t ∧ t ≤ M) {S : PowerSet M} (h : t ∈ S.1) :
    selectedCreation n M S t = creationMatrix n M t ht :=
  dif_pos h

omit [Add K] in
/-- y_t の定め方：t ∉ S なら y_t = 1_{Mat}。 -/
theorem selectedCreation_of_not_mem (n : K) {M t : ℕ} {S : PowerSet M} (h : t ∉ S.1) :
    selectedCreation n M S t = Mat.one :=
  dif_neg h

/-- 本文 `claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit` の必要十分版の準備（⋆）：
R のすべての元 t が t ≥ m + 1 を満たすなら c_m ·_{Mat_{P_M}} E_{R,∅} = E_{R∪{m},∅}。 -/
theorem creationMatrix_mul_matrixUnit (L : ValuedMapsLaws K) (hmul0 : ∀ a : K, a * 0 = 0)
    (hzero_mul : ∀ a : K, 0 * a = 0) (n : K) {M m : ℕ} (hm : 1 ≤ m ∧ m ≤ M) (R : PowerSet M)
    (hR : ∀ t : ℕ, t ∈ R.1 → m + 1 ≤ t) :
    Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M m hm) (matrixUnit R (emptyIndexSet M))
      = matrixUnit (unionSingleton R m hm) (emptyIndexSet M) := Mat.ext fun X U => by
  let hX := isFiniteSet_powerSet M
  let E : Mat K (PowerSet M) := matrixUnit R (emptyIndexSet M)
  -- m ∉ R
  have hmR : m ∉ R.1 := fun h => by have := hR m h; omega
  by_cases hmX : m ∈ X.1
  · by_cases hX' : removeIndex X m = R
    · -- m ∈ X かつ X' = R のとき。X = R ∪ {m}、N_m(R) = 0。
      have hXeq : X = unionSingleton R m hm :=
        ((unionSingleton_cond_iff_eq_removeIndex hm hmX R).2 hX'.symm).2
      have hN : countBelow R m = 0 :=
        countBelow_eq_zero_of_forall_ge R m hm.1 hm.2 (fun t ht => by have := hR t ht; omega)
      calc Mat.entry (Mat.mul L hX (creationMatrix n M m hm) E) X U
          = sign n (countBelow (removeIndex X m) m) * Mat.entry E (removeIndex X m) U :=
            (entry_creationMatrix_mul L hmul0 hzero_mul n hm E X U).1 hmX
        _ = sign n (countBelow R m) * Mat.entry E R U := by rw [hX']
        _ = sign n 0 * Mat.entry E R U := by rw [hN]
        _ = 1 * Mat.entry E R U := rfl
        _ = Mat.entry E R U := L.one_mul (Mat.entry E R U)
        _ = kroneckerDelta R R * kroneckerDelta (emptyIndexSet M) U := rfl
        _ = 1 * kroneckerDelta (emptyIndexSet M) U := by
            rw [show kroneckerDelta R R = (1 : K) from if_pos rfl]
        _ = kroneckerDelta (unionSingleton R m hm) X * kroneckerDelta (emptyIndexSet M) U := by
            rw [show kroneckerDelta (unionSingleton R m hm) X = (1 : K) from if_pos hXeq.symm]
        _ = Mat.entry (matrixUnit (unionSingleton R m hm) (emptyIndexSet M)) X U := rfl
    · -- m ∈ X かつ X' ≠ R のとき。X ≠ R ∪ {m}。
      have hXne : X ≠ unionSingleton R m hm := fun h =>
        hX' ((unionSingleton_cond_iff_eq_removeIndex hm hmX R).1 ⟨hmR, h⟩).symm
      calc Mat.entry (Mat.mul L hX (creationMatrix n M m hm) E) X U
          = sign n (countBelow (removeIndex X m) m) * Mat.entry E (removeIndex X m) U :=
            (entry_creationMatrix_mul L hmul0 hzero_mul n hm E X U).1 hmX
        _ = sign n (countBelow (removeIndex X m) m)
              * (kroneckerDelta R (removeIndex X m) * kroneckerDelta (emptyIndexSet M) U) := rfl
        _ = sign n (countBelow (removeIndex X m) m) * (0 * kroneckerDelta (emptyIndexSet M) U) := by
            rw [show kroneckerDelta R (removeIndex X m) = (0 : K) from if_neg (fun h => hX' h.symm)]
        _ = sign n (countBelow (removeIndex X m) m) * 0 := by
            rw [hzero_mul (kroneckerDelta (emptyIndexSet M) U)]
        _ = 0 := hmul0 (sign n (countBelow (removeIndex X m) m))
        _ = 0 * kroneckerDelta (emptyIndexSet M) U := (hzero_mul _).symm
        _ = kroneckerDelta (unionSingleton R m hm) X * kroneckerDelta (emptyIndexSet M) U := by
            rw [show kroneckerDelta (unionSingleton R m hm) X = (0 : K) from if_neg (fun h => hXne h.symm)]
        _ = Mat.entry (matrixUnit (unionSingleton R m hm) (emptyIndexSet M)) X U := rfl
  · -- m ∉ X のとき。m ∈ R ∪ {m} から R ∪ {m} ≠ X。
    have hne : unionSingleton R m hm ≠ X := fun h => hmX (h ▸ self_mem_unionSingleton R m hm)
    calc Mat.entry (Mat.mul L hX (creationMatrix n M m hm) E) X U
        = 0 := (entry_creationMatrix_mul L hmul0 hzero_mul n hm E X U).2 hmX
      _ = 0 * kroneckerDelta (emptyIndexSet M) U := (hzero_mul _).symm
      _ = kroneckerDelta (unionSingleton R m hm) X * kroneckerDelta (emptyIndexSet M) U := by
          rw [show kroneckerDelta (unionSingleton R m hm) X = (0 : K) from if_neg hne]
      _ = Mat.entry (matrixUnit (unionSingleton R m hm) (emptyIndexSet M)) X U := rfl

/-- 本文 `claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit` の必要十分版の本題の前半：
m ∈ {0,1,…,M} で、R のすべての元 t が t ≥ m + 1 を満たすなら Π_m ·_{Mat_{P_M}} E_{R,∅} = E_{R^{⟨m⟩},∅}。 -/
theorem partialOrderedProduct_selectedCreation_mul_matrixUnit (L : ValuedMapsLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0)
    (hzero_mul : ∀ a : K, 0 * a = 0) (n : K) (M : ℕ) (S : PowerSet M) :
    ∀ m : ℕ, m ≤ M → ∀ R : PowerSet M, (∀ t : ℕ, t ∈ R.1 → m + 1 ≤ t) →
      Mat.mul L (isFiniteSet_powerSet M)
          (AlgebraOver.partialOrderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M)) (selectedCreation n M S) m)
          (matrixUnit R (emptyIndexSet M))
        = matrixUnit (addSelectedUpTo S m R) (emptyIndexSet M) := by
  let hX := isFiniteSet_powerSet M
  let SA := matricesAlgebra L hcomm hmul0 hX
  intro m
  induction m with
  | zero =>
    intro _ R _
    calc Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) 0) (matrixUnit R (emptyIndexSet M))
        = Mat.mul L hX Mat.one (matrixUnit R (emptyIndexSet M)) := rfl
      _ = matrixUnit R (emptyIndexSet M) := mat_one_mul L hX (matrixUnit R (emptyIndexSet M))
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
      calc Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) (m + 1))
            (matrixUnit R (emptyIndexSet M))
          = Mat.mul L hX (Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) m)
              (selectedCreation n M S (m + 1))) (matrixUnit R (emptyIndexSet M)) := rfl
        _ = Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) m)
              (Mat.mul L hX (selectedCreation n M S (m + 1)) (matrixUnit R (emptyIndexSet M))) :=
            mat_mul_assoc L hcomm hmul0 hX _ _ _
        _ = Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) m)
              (Mat.mul L hX (creationMatrix n M (m + 1) hm) (matrixUnit R (emptyIndexSet M))) := by
            rw [selectedCreation_of_mem n hm hmS]
        _ = Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) m)
              (matrixUnit (unionSingleton R (m + 1) hm) (emptyIndexSet M)) := by
            rw [creationMatrix_mul_matrixUnit L hmul0 hzero_mul n hm R hR]
        _ = matrixUnit (addSelectedUpTo S m (unionSingleton R (m + 1) hm)) (emptyIndexSet M) :=
            ih (by omega) (unionSingleton R (m + 1) hm) hR'
        _ = matrixUnit (addSelectedUpTo S (m + 1) R) (emptyIndexSet M) := by
            rw [addSelectedUpTo_succ_of_mem hm S R hmS]
    · -- m ∉ S のとき。R のすべての元 t は t ≥ m + 1 > m = (m - 1) + 1 を満たす。
      have hR' : ∀ t : ℕ, t ∈ R.1 → m + 1 ≤ t := fun t ht => by have := hR t ht; omega
      calc Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) (m + 1))
            (matrixUnit R (emptyIndexSet M))
          = Mat.mul L hX (Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) m)
              (selectedCreation n M S (m + 1))) (matrixUnit R (emptyIndexSet M)) := rfl
        _ = Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) m)
              (Mat.mul L hX (selectedCreation n M S (m + 1)) (matrixUnit R (emptyIndexSet M))) :=
            mat_mul_assoc L hcomm hmul0 hX _ _ _
        _ = Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) m)
              (Mat.mul L hX Mat.one (matrixUnit R (emptyIndexSet M))) := by
            rw [selectedCreation_of_not_mem n hmS]
        _ = Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) m)
              (matrixUnit R (emptyIndexSet M)) := by
            rw [mat_one_mul L hX (matrixUnit R (emptyIndexSet M))]
        _ = matrixUnit (addSelectedUpTo S m R) (emptyIndexSet M) := ih (by omega) R hR'
        _ = matrixUnit (addSelectedUpTo S (m + 1) R) (emptyIndexSet M) := by
            rw [addSelectedUpTo_succ_of_not_mem m S R hmS]

/-- 本文 `claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit` の必要十分版：
(∏_{Mat_{P_M}, t=1}^{M} y_t) ·_{Mat_{P_M}} E_{∅,∅} = E_{S,∅}。 -/
theorem orderedProduct_selectedCreation_mul_vacuumMatrixUnit (L : ValuedMapsLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0)
    (hzero_mul : ∀ a : K, 0 * a = 0) (n : K) (M : ℕ) (S : PowerSet M) :
    Mat.mul L (isFiniteSet_powerSet M)
        (AlgebraOver.orderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M)) M (selectedCreation n M S))
        (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
      = matrixUnit S (emptyIndexSet M) :=
  let hX := isFiniteSet_powerSet M
  let SA := matricesAlgebra L hcomm hmul0 hX
  calc Mat.mul L hX (AlgebraOver.orderedProduct SA M (selectedCreation n M S)) (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
      = Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (selectedCreation n M S) M)
          (matrixUnit (emptyIndexSet M) (emptyIndexSet M)) := rfl
    _ = matrixUnit (addSelectedUpTo S M (emptyIndexSet M)) (emptyIndexSet M) :=
        -- ∅ は元を持たないので、m := M、R := ∅ に前半の命題を当てられる
        partialOrderedProduct_selectedCreation_mul_matrixUnit L hcomm hmul0 hzero_mul n M S M (le_refl M) (emptyIndexSet M)
          (fun t ht => absurd ht (notMem_emptyIndexSet M t))
    _ = matrixUnit S (emptyIndexSet M) := by rw [addSelectedUpTo_last_empty S]

/-! ### 部分集合の元の番号の消滅作用素の行列を番号の逆順に掛けた積 -/

open Classical in
/-- 本文 `claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices` の必要十分版の
z_t := c_t^T（t ∈ T）、1_{Mat}（t ∉ T）。 -/
noncomputable def selectedAnnihilation (n : K) (M : ℕ) (T : PowerSet M) (t : ℕ) : Mat K (PowerSet M) :=
  if h : t ∈ T.1 then annihilationMatrix n M t (T.2 t h) else Mat.one

/-- 本文の番号を逆順に並べ直した族 ž_k := z_{M+1-k}。 -/
noncomputable def reversedSelectedAnnihilation (n : K) (M : ℕ) (T : PowerSet M) (k : ℕ) : Mat K (PowerSet M) :=
  selectedAnnihilation n M T (M + 1 - k)

omit [Add K] in
/-- ž_k = z_{M+1-k} で、M + 1 - k ∈ T なので z の定め方から ž_k = c_{M+1-k}^T。 -/
theorem reversedSelectedAnnihilation_of_mem (n : K) {M k : ℕ} (hs : 1 ≤ M + 1 - k ∧ M + 1 - k ≤ M)
    {T : PowerSet M} (h : M + 1 - k ∈ T.1) :
    reversedSelectedAnnihilation n M T k = annihilationMatrix n M (M + 1 - k) hs :=
  dif_pos h

omit [Add K] in
/-- ž_k = z_{M+1-k} で、M + 1 - k ∉ T なので z の定め方から ž_k = 1_{Mat}。 -/
theorem reversedSelectedAnnihilation_of_not_mem (n : K) {M k : ℕ} {T : PowerSet M} (h : M + 1 - k ∉ T.1) :
    reversedSelectedAnnihilation n M T k = Mat.one :=
  dif_neg h

/-- 本文 `claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices` の必要十分版の準備（⋆）：
R のすべての元 t が t ≥ s + 1 を満たすなら E_{∅,R} ·_{Mat_{P_M}} c_s^T = E_{∅,R∪{s}}。 -/
theorem matrixUnit_mul_annihilationMatrix (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (n : K) {M s : ℕ} (hs : 1 ≤ s ∧ s ≤ M) (R : PowerSet M)
    (hR : ∀ t : ℕ, t ∈ R.1 → s + 1 ≤ t) :
    Mat.mul L (isFiniteSet_powerSet M) (matrixUnit (emptyIndexSet M) R) (annihilationMatrix n M s hs)
      = matrixUnit (emptyIndexSet M) (unionSingleton R s hs) := Mat.ext fun X U => by
  let hX := isFiniteSet_powerSet M
  let V := coefficientsVec L
  let E : Mat K (PowerSet M) := matrixUnit (emptyIndexSet M) R
  -- s ∉ R、N_s(R) = 0
  have hsR : s ∉ R.1 := fun h => by have := hR s h; omega
  have hN : countBelow R s = 0 :=
    countBelow_eq_zero_of_forall_ge R s hs.1 hs.2 (fun t ht => by have := hR t ht; omega)
  -- r_Y := δ_{∅,X} · (c_s)_{U,Y}
  let r : PowerSet M → K := fun Y =>
    kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix n M s hs) U Y
  -- 和の項の書き直し
  have hterm : ∀ Y : PowerSet M,
      V.smul (Mat.entry E X Y) (Mat.entry (annihilationMatrix n M s hs) Y U)
        = V.smul (kroneckerDelta R Y) (r Y) := fun Y => calc
    V.smul (Mat.entry E X Y) (Mat.entry (annihilationMatrix n M s hs) Y U)
        = Mat.entry E X Y * Mat.entry (annihilationMatrix n M s hs) Y U := rfl
    _ = (kroneckerDelta (emptyIndexSet M) X * kroneckerDelta R Y)
          * Mat.entry (annihilationMatrix n M s hs) Y U := rfl
    _ = (kroneckerDelta (emptyIndexSet M) X * kroneckerDelta R Y)
          * Mat.entry (creationMatrix n M s hs) U Y := rfl
    _ = (kroneckerDelta R Y * kroneckerDelta (emptyIndexSet M) X)
          * Mat.entry (creationMatrix n M s hs) U Y := by
        rw [hcomm (kroneckerDelta (emptyIndexSet M) X) (kroneckerDelta R Y)]
    _ = kroneckerDelta R Y
          * (kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix n M s hs) U Y) :=
        L.mul_assoc (kroneckerDelta R Y) (kroneckerDelta (emptyIndexSet M) X)
          (Mat.entry (creationMatrix n M s hs) U Y)
    _ = kroneckerDelta R Y * r Y := rfl
    _ = V.smul (kroneckerDelta R Y) (r Y) := rfl
  -- （†）
  have hdagger : Mat.entry (Mat.mul L hX E (annihilationMatrix n M s hs)) X U
      = kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix n M s hs) U R := calc
    Mat.entry (Mat.mul L hX E (annihilationMatrix n M s hs)) X U
        = sumOverFiniteSet V hX (fun Y => Mat.entry E X Y)
            (fun Y => Mat.entry (annihilationMatrix n M s hs) Y U) := rfl
    _ = sumOverFiniteSet V hX (fun Y => kroneckerDelta R Y) r :=
        sumOverFiniteSet_congr V hX _ _ _ _ hterm
    _ = r R := sumOverFiniteSet_kroneckerDelta V (L.add_zero 0) hX r R
    _ = kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix n M s hs) U R := rfl
  by_cases hU : U = unionSingleton R s hs
  · -- U = R ∪ {s} のとき。c_s の条件「s ∉ R かつ U = R ∪ {s}」が成り立つ。
    calc Mat.entry (Mat.mul L hX E (annihilationMatrix n M s hs)) X U
        = kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix n M s hs) U R := hdagger
      _ = kroneckerDelta (emptyIndexSet M) X * sign n (countBelow R s) := by
          rw [creationMatrix_entry_of_cond n hs ⟨hsR, hU⟩]
      _ = kroneckerDelta (emptyIndexSet M) X * sign n 0 := by rw [hN]
      _ = kroneckerDelta (emptyIndexSet M) X * 1 := rfl
      _ = kroneckerDelta (emptyIndexSet M) X * kroneckerDelta (unionSingleton R s hs) U := by
          rw [show kroneckerDelta (unionSingleton R s hs) U = (1 : K) from if_pos hU.symm]
      _ = Mat.entry (matrixUnit (emptyIndexSet M) (unionSingleton R s hs)) X U := rfl
  · -- U ≠ R ∪ {s} のとき。c_s の条件は成り立たない。
    calc Mat.entry (Mat.mul L hX E (annihilationMatrix n M s hs)) X U
        = kroneckerDelta (emptyIndexSet M) X * Mat.entry (creationMatrix n M s hs) U R := hdagger
      _ = kroneckerDelta (emptyIndexSet M) X * 0 := by
          rw [creationMatrix_entry_of_not_cond n hs (fun h => hU h.2)]
      _ = kroneckerDelta (emptyIndexSet M) X * kroneckerDelta (unionSingleton R s hs) U := by
          rw [show kroneckerDelta (unionSingleton R s hs) U = (0 : K) from if_neg (fun h => hU h.symm)]
      _ = Mat.entry (matrixUnit (emptyIndexSet M) (unionSingleton R s hs)) X U := rfl

/-- 本文 `claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices` の必要十分版の本題の前半：
すべての m ∈ {0,1,…,M} で E_{∅,∅} ·_{Mat_{P_M}} Π_m = E_{∅,T^{⟨m⟩}}。 -/
theorem vacuumMatrixUnit_mul_partialOrderedProduct (L : ValuedMapsLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (n : K) (M : ℕ) (T : PowerSet M) :
    ∀ m : ℕ, m ≤ M →
      Mat.mul L (isFiniteSet_powerSet M) (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
          (AlgebraOver.partialOrderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M))
            (reversedSelectedAnnihilation n M T) m)
        = matrixUnit (emptyIndexSet M) (selectedFrom T m) := by
  let hX := isFiniteSet_powerSet M
  let SA := matricesAlgebra L hcomm hmul0 hX
  let E : Mat K (PowerSet M) := matrixUnit (emptyIndexSet M) (emptyIndexSet M)
  intro m
  induction m with
  | zero =>
    intro _
    calc Mat.mul L hX E (AlgebraOver.partialOrderedProduct SA (reversedSelectedAnnihilation n M T) 0)
        = Mat.mul L hX E Mat.one := rfl
      _ = E := mat_mul_one L (fun a => hcomm 0 a) (fun a => hcomm 1 a) hX E
      _ = matrixUnit (emptyIndexSet M) (selectedFrom T 0) := by rw [selectedFrom_zero T]
  | succ m ih =>
    intro hmM
    -- s := M + 1 - m ∈ {1,…,M}（m を m + 1 と書く）
    have hs : 1 ≤ M + 1 - (m + 1) ∧ M + 1 - (m + 1) ≤ M := ⟨by omega, by omega⟩
    by_cases hsT : M + 1 - (m + 1) ∈ T.1
    · -- s ∈ T のとき。
      calc Mat.mul L hX E (AlgebraOver.partialOrderedProduct SA (reversedSelectedAnnihilation n M T) (m + 1))
          = Mat.mul L hX E (Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (reversedSelectedAnnihilation n M T) m)
              (reversedSelectedAnnihilation n M T (m + 1))) := rfl
        _ = Mat.mul L hX (Mat.mul L hX E (AlgebraOver.partialOrderedProduct SA (reversedSelectedAnnihilation n M T) m))
              (reversedSelectedAnnihilation n M T (m + 1)) := (mat_mul_assoc L hcomm hmul0 hX _ _ _).symm
        _ = Mat.mul L hX (matrixUnit (emptyIndexSet M) (selectedFrom T m))
              (reversedSelectedAnnihilation n M T (m + 1)) := by rw [ih (by omega)]
        _ = Mat.mul L hX (matrixUnit (emptyIndexSet M) (selectedFrom T m))
              (annihilationMatrix n M (M + 1 - (m + 1)) hs) := by
            rw [reversedSelectedAnnihilation_of_mem n hs hsT]
        _ = matrixUnit (emptyIndexSet M) (unionSingleton (selectedFrom T m) (M + 1 - (m + 1)) hs) :=
            matrixUnit_mul_annihilationMatrix L hcomm n hs (selectedFrom T m) (selectedFrom_ge hmM T)
        _ = matrixUnit (emptyIndexSet M) (selectedFrom T (m + 1)) := by
            rw [selectedFrom_succ_of_mem hmM hs T hsT]
    · -- s ∉ T のとき。
      calc Mat.mul L hX E (AlgebraOver.partialOrderedProduct SA (reversedSelectedAnnihilation n M T) (m + 1))
          = Mat.mul L hX E (Mat.mul L hX (AlgebraOver.partialOrderedProduct SA (reversedSelectedAnnihilation n M T) m)
              (reversedSelectedAnnihilation n M T (m + 1))) := rfl
        _ = Mat.mul L hX (Mat.mul L hX E (AlgebraOver.partialOrderedProduct SA (reversedSelectedAnnihilation n M T) m))
              (reversedSelectedAnnihilation n M T (m + 1)) := (mat_mul_assoc L hcomm hmul0 hX _ _ _).symm
        _ = Mat.mul L hX (matrixUnit (emptyIndexSet M) (selectedFrom T m))
              (reversedSelectedAnnihilation n M T (m + 1)) := by rw [ih (by omega)]
        _ = Mat.mul L hX (matrixUnit (emptyIndexSet M) (selectedFrom T m)) Mat.one := by
            rw [reversedSelectedAnnihilation_of_not_mem n hsT]
        _ = matrixUnit (emptyIndexSet M) (selectedFrom T m) :=
            mat_mul_one L (fun a => hcomm 0 a) (fun a => hcomm 1 a) hX (matrixUnit (emptyIndexSet M) (selectedFrom T m))
        _ = matrixUnit (emptyIndexSet M) (selectedFrom T (m + 1)) := by
            rw [selectedFrom_succ_of_not_mem hmM T hsT]

/-- 本文 `claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices` の必要十分版：
E_{∅,∅} ·_{Mat_{P_M}} (∏_{Mat_{P_M}, k=1}^{M} ž_k) = E_{∅,T}。 -/
theorem vacuumMatrixUnit_mul_orderedProduct_reversedSelectedAnnihilation (L : ValuedMapsLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (n : K) (M : ℕ) (T : PowerSet M) :
    Mat.mul L (isFiniteSet_powerSet M) (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
        (AlgebraOver.orderedProduct (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M)) M (reversedSelectedAnnihilation n M T))
      = matrixUnit (emptyIndexSet M) T :=
  let hX := isFiniteSet_powerSet M
  let SA := matricesAlgebra L hcomm hmul0 hX
  calc Mat.mul L hX (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
        (AlgebraOver.orderedProduct SA M (reversedSelectedAnnihilation n M T))
      = Mat.mul L hX (matrixUnit (emptyIndexSet M) (emptyIndexSet M))
          (AlgebraOver.partialOrderedProduct SA (reversedSelectedAnnihilation n M T) M) := rfl
    _ = matrixUnit (emptyIndexSet M) (selectedFrom T M) :=
        vacuumMatrixUnit_mul_partialOrderedProduct L hcomm hmul0 n M T M (le_refl M)
    _ = matrixUnit (emptyIndexSet M) T := by rw [selectedFrom_last T]

end CliffordMatrixIsomorphism.NecSuf.Isomorphism
