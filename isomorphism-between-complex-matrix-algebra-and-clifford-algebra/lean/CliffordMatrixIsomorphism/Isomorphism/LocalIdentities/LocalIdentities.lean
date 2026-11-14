/-
章「同型の証明」の節「クリフォード代数の中の局所的な等式」の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                              このファイル
  def_selected_creation_factor                                                              selectedCreationFactor（y^S_t）
  def_ordered_product_of_selected_creation_generators                                       orderedCreationProduct（a†_S）
  def_selected_annihilation_factor                                                          selectedAnnihilationFactor（z^T_t）
  def_reverse_numbered_selected_annihilation_factor                                         reversedSelectedAnnihilationFactor（ž^T_k）
  def_reverse_ordered_product_of_selected_annihilation_generators                           reverseOrderedAnnihilationProduct（a_T）
  def_vacuum_factor_of_split_clifford_algebra                                               vacuumFactor（x_i）
  def_vacuum_element_of_split_clifford_algebra                                              vacuumElement（P）
  claim_annihilation_generator_commutes_with_other_number_pair                              annihilation_commute_vacuumFactor
  claim_creation_generator_commutes_with_other_number_pair                                  creation_commute_vacuumFactor
  claim_annihilation_generator_times_vacuum_element_is_zero                                 annihilation_mul_vacuumElement
  claim_vacuum_element_times_creation_generator_is_zero                                     vacuumElement_mul_creation
  claim_creation_generator_passes_initial_creation_factors_with_sign                        creation_mul_initialCreationProduct
  claim_creation_generator_times_ordered_creation_product_without_index                     creation_mul_orderedCreationProduct_of_not_mem
  claim_creation_generator_times_ordered_creation_product_with_index_is_zero                creation_mul_orderedCreationProduct_of_mem
  def_initial_reverse_ordered_product_of_selected_annihilation_generators                   initialReverseAnnihilationProduct（a_{T,≤m}）
  claim_initial_reverse_ordered_annihilation_product_splits_off_last_number                 initialReverseAnnihilationProduct_succ
  claim_initial_reverse_ordered_annihilation_product_up_to_last_number_is_whole_product     initialReverseAnnihilationProduct_last
  claim_initial_annihilation_factors_pass_annihilation_generator_with_sign                  initialReverseAnnihilationProduct_mul_annihilation
  （二つの主張の証明が共通に置く p・L・α と a_T の分解）                                    reverseOrderedAnnihilationProduct_singleOut
  claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index     reverseOrderedAnnihilationProduct_mul_annihilation_of_not_mem
  claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero
                                                                                            reverseOrderedAnnihilationProduct_mul_annihilation_of_mem

表し方:
- 宣言は名前空間 `Clifford.SplitData` に置き、前提の組 D から `D.vacuumElement` のように引く。
- Cl(V,q) の ℂ-代数は `D.space.cliffordAlgebra`（証明の中では A）、番号順の積は `ComplexAlgebra.orderedProduct A n x`
  （本文 def_ordered_product_in_algebra）。部分集合 S ∈ P_M は `PowerSet D.M`、t ∈ S の真偽による場合分けは Classical を使う
  （本文の「t ∈ S の真偽は一つに決まる」）。
- 番号付けた族 y^S・z^T・ž^T・x は `ℕ → Cl` で表し、{1,…,M} の外の値は使わない。
- 本文の「族を {1,…,m} に制限した番号順の積」は、Lean では同じ族の `ComplexAlgebra.orderedProduct A m` である
  （本文 claim_partial_product_is_ordered_product_of_restricted_family が Π_m との一致を与える。`ComplexAlgebra.orderedProduct A m y` は Π_m の定義そのもの）。
- 本文の帰納法の段 m ∈ {1,…,i-1}（m - 1 からの段）は、Lean では m + 1（m + 1 ≤ i - 1）と書く。
  a_{T,≤m} の分解は本文の m ∈ {1,…,M} を Lean では m + 1 と書き、M による上限を使わない。
- 本文が番号の上限を書き換える行（i - 1 + 1 = i、p - 1 = M - i、M - p = i - 1、(m - 1) + 1 - r = m - r など）は、整数の計算として `omega` で書く。
- 符号 ς は `sign`、N_i(T) は `countBelow T i`（`Isomorphism/CreationOperatorMatrices/`）。
  本文の「ℂ の計算 (-1_ℂ)·(-1_ℂ) = 1_ℂ」は `neg_one_mul_neg_one`（`Sign.lean`）を引く。

必要十分版は `NecSuf/Isomorphism/LocalIdentities/LocalIdentities.lean`、導出版は `LocalIdentitiesFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.CliffordAlgebra.SplitQuadraticSpace.Generators
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebra
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CountAndSign
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.Sign

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### 定義 -/

open Classical in
/-- 本文 `def_selected_creation_factor`：y^S_t := a†_t（t ∈ S）、1_{Cl}（t ∉ S）。 -/
def selectedCreationFactor (S : PowerSet D.M) (t : ℕ) : D.space.Cl :=
  if t ∈ S.1 then D.creation t else D.space.cliffordAlgebra.one

theorem selectedCreationFactor_of_mem {S : PowerSet D.M} {t : ℕ} (h : t ∈ S.1) :
    D.selectedCreationFactor S t = D.creation t := if_pos h

theorem selectedCreationFactor_of_not_mem {S : PowerSet D.M} {t : ℕ} (h : t ∉ S.1) :
    D.selectedCreationFactor S t = D.space.cliffordAlgebra.one := if_neg h

/-- 本文 `def_ordered_product_of_selected_creation_generators`：a†_S := ∏_{Cl,t=1}^{M} y^S_t。 -/
def orderedCreationProduct (S : PowerSet D.M) : D.space.Cl :=
  ComplexAlgebra.orderedProduct D.space.cliffordAlgebra D.M (D.selectedCreationFactor S)

open Classical in
/-- 本文 `def_selected_annihilation_factor`：z^T_t := a_t（t ∈ T）、1_{Cl}（t ∉ T）。 -/
def selectedAnnihilationFactor (T : PowerSet D.M) (t : ℕ) : D.space.Cl :=
  if t ∈ T.1 then D.annihilation t else D.space.cliffordAlgebra.one

theorem selectedAnnihilationFactor_of_mem {T : PowerSet D.M} {t : ℕ} (h : t ∈ T.1) :
    D.selectedAnnihilationFactor T t = D.annihilation t := if_pos h

theorem selectedAnnihilationFactor_of_not_mem {T : PowerSet D.M} {t : ℕ} (h : t ∉ T.1) :
    D.selectedAnnihilationFactor T t = D.space.cliffordAlgebra.one := if_neg h

/-- 本文 `def_reverse_numbered_selected_annihilation_factor`：ž^T_k := z^T_{M+1-k}。 -/
def reversedSelectedAnnihilationFactor (T : PowerSet D.M) (k : ℕ) : D.space.Cl :=
  D.selectedAnnihilationFactor T (D.M + 1 - k)

/-- 本文 `def_reverse_ordered_product_of_selected_annihilation_generators`：a_T := ∏_{Cl,k=1}^{M} ž^T_k。 -/
def reverseOrderedAnnihilationProduct (T : PowerSet D.M) : D.space.Cl :=
  ComplexAlgebra.orderedProduct D.space.cliffordAlgebra D.M (D.reversedSelectedAnnihilationFactor T)

/-- 本文 `def_vacuum_factor_of_split_clifford_algebra`：x_i := a_i ·_{Cl} a†_i。 -/
def vacuumFactor (i : ℕ) : D.space.Cl :=
  D.space.cliffordAlgebra.mul (D.annihilation i) (D.creation i)

/-- 本文 `def_vacuum_element_of_split_clifford_algebra`：P := ∏_{Cl,i=1}^{M} x_i。 -/
def vacuumElement : D.space.Cl :=
  ComplexAlgebra.orderedProduct D.space.cliffordAlgebra D.M D.vacuumFactor

/-- 本文 `def_initial_reverse_ordered_product_of_selected_annihilation_generators`：
a_{T,≤m} := ∏_{A,k=1}^{m} z^T_{m+1-k}。 -/
def initialReverseAnnihilationProduct (T : PowerSet D.M) (m : ℕ) : D.space.Cl :=
  ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m (fun k => D.selectedAnnihilationFactor T (m + 1 - k))

/-! ### 消滅と生成の積と交換する元 -/

/-- 本文 `claim_annihilation_generator_commutes_with_other_number_pair`：i ≠ j なら a_i (a_j a†_j) = (a_j a†_j) a_i。 -/
theorem annihilation_commute_vacuumFactor {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hj : 1 ≤ j ∧ j ≤ D.M) (hij : i ≠ j) :
    D.space.cliffordAlgebra.mul (D.annihilation i) (D.vacuumFactor j)
      = D.space.cliffordAlgebra.mul (D.vacuumFactor j) (D.annihilation i) := by
  let A := D.space.cliffordAlgebra
  -- 準備：a_i a†_j + a†_j a_i = 0_A
  have hprep : A.add (A.mul (D.annihilation i) (D.creation j)) (A.mul (D.creation j) (D.annihilation i))
      = A.zero := calc
    A.add (A.mul (D.annihilation i) (D.creation j)) (A.mul (D.creation j) (D.annihilation i))
        = A.smul (kroneckerDelta i j) A.one := D.annihilation_creation_anticommute i j hi.1 hi.2 hj.1 hj.2
    _ = A.smul 0 A.one := by rw [kroneckerDelta, if_neg hij]
    _ = A.zero := zero_smul_eq_zero A A.one
  calc A.mul (D.annihilation i) (D.vacuumFactor j)
      = A.mul (D.annihilation i) (A.mul (D.annihilation j) (D.creation j)) := rfl
    _ = A.mul (A.mul (D.annihilation i) (D.annihilation j)) (D.creation j) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.smul (-1) (A.mul (D.annihilation j) (D.annihilation i))) (D.creation j) := by
        rw [mul_eq_neg_one_smul_swap A (D.annihilation i) (D.annihilation j) (D.annihilation_anticommute i j)]
    _ = A.smul (-1) (A.mul (A.mul (D.annihilation j) (D.annihilation i)) (D.creation j)) :=
        (A.smul_mul_left _ _ _).symm
    _ = A.smul (-1) (A.mul (D.annihilation j) (A.mul (D.annihilation i) (D.creation j))) := by
        rw [A.mul_assoc (D.annihilation j) (D.annihilation i) (D.creation j)]
    _ = A.smul (-1) (A.mul (D.annihilation j) (A.smul (-1) (A.mul (D.creation j) (D.annihilation i)))) := by
        rw [mul_eq_neg_one_smul_swap A (D.annihilation i) (D.creation j) hprep]
    _ = A.smul (-1) (A.smul (-1) (A.mul (D.annihilation j) (A.mul (D.creation j) (D.annihilation i)))) := by
        rw [← A.smul_mul_right (-1) (D.annihilation j) (A.mul (D.creation j) (D.annihilation i))]
    _ = A.smul ((-1) * (-1)) (A.mul (D.annihilation j) (A.mul (D.creation j) (D.annihilation i))) :=
        (A.smul_assoc _ _ _).symm
    _ = A.smul 1 (A.mul (D.annihilation j) (A.mul (D.creation j) (D.annihilation i))) := by
        rw [neg_one_mul_neg_one]
    _ = A.mul (D.annihilation j) (A.mul (D.creation j) (D.annihilation i)) := A.one_smul _
    _ = A.mul (A.mul (D.annihilation j) (D.creation j)) (D.annihilation i) := (A.mul_assoc _ _ _).symm
    _ = A.mul (D.vacuumFactor j) (D.annihilation i) := rfl

/-- 本文 `claim_creation_generator_commutes_with_other_number_pair`：i ≠ j なら a†_i (a_j a†_j) = (a_j a†_j) a†_i。 -/
theorem creation_commute_vacuumFactor {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hj : 1 ≤ j ∧ j ≤ D.M) (hij : i ≠ j) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.vacuumFactor j)
      = D.space.cliffordAlgebra.mul (D.vacuumFactor j) (D.creation i) := by
  let A := D.space.cliffordAlgebra
  -- 準備：a†_i a_j + a_j a†_i = 0_A
  have hprep : A.add (A.mul (D.creation i) (D.annihilation j)) (A.mul (D.annihilation j) (D.creation i))
      = A.zero := calc
    A.add (A.mul (D.creation i) (D.annihilation j)) (A.mul (D.annihilation j) (D.creation i))
        = A.add (A.mul (D.annihilation j) (D.creation i)) (A.mul (D.creation i) (D.annihilation j)) :=
          A.add_comm _ _
    _ = A.smul (kroneckerDelta j i) A.one := D.annihilation_creation_anticommute j i hj.1 hj.2 hi.1 hi.2
    _ = A.smul 0 A.one := by rw [kroneckerDelta, if_neg (Ne.symm hij)]
    _ = A.zero := zero_smul_eq_zero A A.one
  calc A.mul (D.creation i) (D.vacuumFactor j)
      = A.mul (D.creation i) (A.mul (D.annihilation j) (D.creation j)) := rfl
    _ = A.mul (A.mul (D.creation i) (D.annihilation j)) (D.creation j) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.smul (-1) (A.mul (D.annihilation j) (D.creation i))) (D.creation j) := by
        rw [mul_eq_neg_one_smul_swap A (D.creation i) (D.annihilation j) hprep]
    _ = A.smul (-1) (A.mul (A.mul (D.annihilation j) (D.creation i)) (D.creation j)) :=
        (A.smul_mul_left _ _ _).symm
    _ = A.smul (-1) (A.mul (D.annihilation j) (A.mul (D.creation i) (D.creation j))) := by
        rw [A.mul_assoc (D.annihilation j) (D.creation i) (D.creation j)]
    _ = A.smul (-1) (A.mul (D.annihilation j) (A.smul (-1) (A.mul (D.creation j) (D.creation i)))) := by
        rw [mul_eq_neg_one_smul_swap A (D.creation i) (D.creation j) (D.creation_anticommute i j)]
    _ = A.smul (-1) (A.smul (-1) (A.mul (D.annihilation j) (A.mul (D.creation j) (D.creation i)))) := by
        rw [← A.smul_mul_right (-1) (D.annihilation j) (A.mul (D.creation j) (D.creation i))]
    _ = A.smul ((-1) * (-1)) (A.mul (D.annihilation j) (A.mul (D.creation j) (D.creation i))) :=
        (A.smul_assoc _ _ _).symm
    _ = A.smul 1 (A.mul (D.annihilation j) (A.mul (D.creation j) (D.creation i))) := by
        rw [neg_one_mul_neg_one]
    _ = A.mul (D.annihilation j) (A.mul (D.creation j) (D.creation i)) := A.one_smul _
    _ = A.mul (A.mul (D.annihilation j) (D.creation j)) (D.creation i) := (A.mul_assoc _ _ _).symm
    _ = A.mul (D.vacuumFactor j) (D.creation i) := rfl

/-! ### 真空への射影にあたる元と生成元の積 -/

/-- 本文 `claim_annihilation_generator_times_vacuum_element_is_zero`：a_i ·_{Cl} P = 0_{Cl}。 -/
theorem annihilation_mul_vacuumElement {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.annihilation i) D.vacuumElement = D.space.cliffordAlgebra.zero := by
  let A := D.space.cliffordAlgebra
  let x := D.vacuumFactor
  let L := ComplexAlgebra.orderedProduct A (i - 1) x
  let R := ComplexAlgebra.orderedProduct A (D.M - i) (fun r => x (i + r))
  -- 準備：a_i ·_A L = L ·_A a_i
  have hprep : A.mul (D.annihilation i) L = A.mul L (D.annihilation i) :=
    commute_orderedProduct A (D.annihilation i) (i - 1) x fun k hk1 hk =>
      D.annihilation_commute_vacuumFactor hi ⟨hk1, by omega⟩ (by omega)
  calc A.mul (D.annihilation i) D.vacuumElement
      = A.mul (D.annihilation i) (A.mul L (A.mul (x i) R)) := by
        rw [vacuumElement, orderedProduct_singleOut A D.M i hi.1 hi.2 x]
    _ = A.mul (A.mul (D.annihilation i) L) (A.mul (x i) R) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.mul L (D.annihilation i)) (A.mul (x i) R) := by rw [hprep]
    _ = A.mul L (A.mul (D.annihilation i) (A.mul (x i) R)) := A.mul_assoc _ _ _
    _ = A.mul L (A.mul (A.mul (D.annihilation i) (x i)) R) := by
        rw [A.mul_assoc (D.annihilation i) (x i) R]
    _ = A.mul L (A.mul (A.mul (D.annihilation i) (A.mul (D.annihilation i) (D.creation i))) R) := rfl
    _ = A.mul L (A.mul (A.mul (A.mul (D.annihilation i) (D.annihilation i)) (D.creation i)) R) := by
        rw [A.mul_assoc (D.annihilation i) (D.annihilation i) (D.creation i)]
    _ = A.mul L (A.mul (A.mul A.zero (D.creation i)) R) := by rw [D.annihilation_mul_self i]
    _ = A.mul L (A.mul A.zero R) := by rw [zero_mul_eq_zero A (D.creation i)]
    _ = A.mul L A.zero := by rw [zero_mul_eq_zero A R]
    _ = A.zero := mul_zero_eq_zero A L

/-- 本文 `claim_vacuum_element_times_creation_generator_is_zero`：P ·_{Cl} a†_i = 0_{Cl}。 -/
theorem vacuumElement_mul_creation {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul D.vacuumElement (D.creation i) = D.space.cliffordAlgebra.zero := by
  let A := D.space.cliffordAlgebra
  let x := D.vacuumFactor
  let L := ComplexAlgebra.orderedProduct A (i - 1) x
  let R := ComplexAlgebra.orderedProduct A (D.M - i) (fun r => x (i + r))
  -- 準備：a†_i ·_A R = R ·_A a†_i
  have hprep : A.mul (D.creation i) R = A.mul R (D.creation i) :=
    commute_orderedProduct A (D.creation i) (D.M - i) (fun r => x (i + r)) fun r hr1 hr =>
      D.creation_commute_vacuumFactor hi ⟨by omega, by omega⟩ (by omega)
  calc A.mul D.vacuumElement (D.creation i)
      = A.mul (A.mul L (A.mul (x i) R)) (D.creation i) := by
        rw [vacuumElement, orderedProduct_singleOut A D.M i hi.1 hi.2 x]
    _ = A.mul L (A.mul (A.mul (x i) R) (D.creation i)) := A.mul_assoc _ _ _
    _ = A.mul L (A.mul (x i) (A.mul R (D.creation i))) := by rw [A.mul_assoc (x i) R (D.creation i)]
    _ = A.mul L (A.mul (x i) (A.mul (D.creation i) R)) := by rw [hprep]
    _ = A.mul L (A.mul (A.mul (x i) (D.creation i)) R) := by rw [A.mul_assoc (x i) (D.creation i) R]
    _ = A.mul L (A.mul (A.mul (A.mul (D.annihilation i) (D.creation i)) (D.creation i)) R) := rfl
    _ = A.mul L (A.mul (A.mul (D.annihilation i) (A.mul (D.creation i) (D.creation i))) R) := by
        rw [A.mul_assoc (D.annihilation i) (D.creation i) (D.creation i)]
    _ = A.mul L (A.mul (A.mul (D.annihilation i) A.zero) R) := by rw [D.creation_mul_self i]
    _ = A.mul L (A.mul A.zero R) := by rw [mul_zero_eq_zero A (D.annihilation i)]
    _ = A.mul L A.zero := by rw [zero_mul_eq_zero A R]
    _ = A.zero := mul_zero_eq_zero A L

/-! ### 生成の積に生成元を左から掛ける -/

/-- 本文 `claim_creation_generator_passes_initial_creation_factors_with_sign`：m ∈ {0,…,i-1} について
a†_i ·_{Cl} ∏_{t=1}^{m} y^T_t = ς(N_{m+1}(T)) ∗_{Cl} ((∏_{t=1}^{m} y^T_t) ·_{Cl} a†_i)。m についての帰納法。 -/
theorem creation_mul_initialCreationProduct {i : ℕ} (T : PowerSet D.M) :
    ∀ m : ℕ, m ≤ i - 1 →
      D.space.cliffordAlgebra.mul (D.creation i)
          (ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m (D.selectedCreationFactor T))
        = D.space.cliffordAlgebra.smul (sign (countBelow T (m + 1)))
            (D.space.cliffordAlgebra.mul (ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m (D.selectedCreationFactor T))
              (D.creation i)) := by
  let A := D.space.cliffordAlgebra
  let y := D.selectedCreationFactor T
  intro m
  induction m with
  | zero =>
    intro _
    calc A.mul (D.creation i) (ComplexAlgebra.orderedProduct A 0 y)
        = A.mul (D.creation i) A.one := rfl
      _ = D.creation i := A.mul_one _
      _ = A.smul 1 (D.creation i) := (A.one_smul _).symm
      _ = A.smul 1 (A.mul A.one (D.creation i)) := by rw [A.one_mul (D.creation i)]
      _ = A.smul (sign 0) (A.mul A.one (D.creation i)) := by rw [sign_zero]
      _ = A.smul (sign (countBelow T 1)) (A.mul A.one (D.creation i)) := by rw [countBelow_one]
      _ = A.smul (sign (countBelow T (0 + 1))) (A.mul (ComplexAlgebra.orderedProduct A 0 y) (D.creation i)) := rfl
  | succ m ih =>
    intro hm
    have ih' := ih (by omega)
    by_cases hmT : m + 1 ∈ T.1
    · -- m + 1 ∈ T のとき y_{m+1} = a†_{m+1}
      have hy : y (m + 1) = D.creation (m + 1) := D.selectedCreationFactor_of_mem hmT
      calc A.mul (D.creation i) (ComplexAlgebra.orderedProduct A (m + 1) y)
          = A.mul (D.creation i) (A.mul (ComplexAlgebra.orderedProduct A m y) (D.creation (m + 1))) := by
            rw [show ComplexAlgebra.orderedProduct A (m + 1) y = A.mul (ComplexAlgebra.orderedProduct A m y) (y (m + 1)) from rfl, hy]
        _ = A.mul (A.mul (D.creation i) (ComplexAlgebra.orderedProduct A m y)) (D.creation (m + 1)) :=
            (A.mul_assoc _ _ _).symm
        _ = A.mul (A.smul (sign (countBelow T (m + 1))) (A.mul (ComplexAlgebra.orderedProduct A m y) (D.creation i)))
              (D.creation (m + 1)) := by rw [ih']
        _ = A.smul (sign (countBelow T (m + 1)))
              (A.mul (A.mul (ComplexAlgebra.orderedProduct A m y) (D.creation i)) (D.creation (m + 1))) :=
            (A.smul_mul_left _ _ _).symm
        _ = A.smul (sign (countBelow T (m + 1)))
              (A.mul (ComplexAlgebra.orderedProduct A m y) (A.mul (D.creation i) (D.creation (m + 1)))) := by
            rw [A.mul_assoc (ComplexAlgebra.orderedProduct A m y) (D.creation i) (D.creation (m + 1))]
        _ = A.smul (sign (countBelow T (m + 1)))
              (A.mul (ComplexAlgebra.orderedProduct A m y) (A.smul (-1) (A.mul (D.creation (m + 1)) (D.creation i)))) := by
            rw [mul_eq_neg_one_smul_swap A (D.creation i) (D.creation (m + 1)) (D.creation_anticommute i (m + 1))]
        _ = A.smul (sign (countBelow T (m + 1)))
              (A.smul (-1) (A.mul (ComplexAlgebra.orderedProduct A m y) (A.mul (D.creation (m + 1)) (D.creation i)))) := by
            rw [← A.smul_mul_right (-1) (ComplexAlgebra.orderedProduct A m y) (A.mul (D.creation (m + 1)) (D.creation i))]
        _ = A.smul (sign (countBelow T (m + 1)) * (-1))
              (A.mul (ComplexAlgebra.orderedProduct A m y) (A.mul (D.creation (m + 1)) (D.creation i))) :=
            (A.smul_assoc _ _ _).symm
        _ = A.smul ((-1) * sign (countBelow T (m + 1)))
              (A.mul (ComplexAlgebra.orderedProduct A m y) (A.mul (D.creation (m + 1)) (D.creation i))) := by
            rw [mul_comm (sign (countBelow T (m + 1))) (-1)]
        _ = A.smul (sign (countBelow T (m + 1) + 1))
              (A.mul (ComplexAlgebra.orderedProduct A m y) (A.mul (D.creation (m + 1)) (D.creation i))) := by
            rw [sign_succ]
        _ = A.smul (sign (countBelow T (m + 2)))
              (A.mul (ComplexAlgebra.orderedProduct A m y) (A.mul (D.creation (m + 1)) (D.creation i))) := by
            rw [countBelow_succ_succ_of_mem T m hmT]
        _ = A.smul (sign (countBelow T (m + 2)))
              (A.mul (A.mul (ComplexAlgebra.orderedProduct A m y) (D.creation (m + 1))) (D.creation i)) := by
            rw [A.mul_assoc (ComplexAlgebra.orderedProduct A m y) (D.creation (m + 1)) (D.creation i)]
        _ = A.smul (sign (countBelow T (m + 1 + 1))) (A.mul (ComplexAlgebra.orderedProduct A (m + 1) y) (D.creation i)) := by
            rw [show ComplexAlgebra.orderedProduct A (m + 1) y = A.mul (ComplexAlgebra.orderedProduct A m y) (y (m + 1)) from rfl, hy]
    · -- m + 1 ∉ T のとき y_{m+1} = 1_A
      have hy : y (m + 1) = A.one := D.selectedCreationFactor_of_not_mem hmT
      calc A.mul (D.creation i) (ComplexAlgebra.orderedProduct A (m + 1) y)
          = A.mul (D.creation i) (A.mul (ComplexAlgebra.orderedProduct A m y) A.one) := by
            rw [show ComplexAlgebra.orderedProduct A (m + 1) y = A.mul (ComplexAlgebra.orderedProduct A m y) (y (m + 1)) from rfl, hy]
        _ = A.mul (D.creation i) (ComplexAlgebra.orderedProduct A m y) := by rw [A.mul_one (ComplexAlgebra.orderedProduct A m y)]
        _ = A.smul (sign (countBelow T (m + 1))) (A.mul (ComplexAlgebra.orderedProduct A m y) (D.creation i)) := ih'
        _ = A.smul (sign (countBelow T (m + 2))) (A.mul (ComplexAlgebra.orderedProduct A m y) (D.creation i)) := by
            rw [countBelow_succ_succ_of_not_mem T m hmT]
        _ = A.smul (sign (countBelow T (m + 2))) (A.mul (A.mul (ComplexAlgebra.orderedProduct A m y) A.one) (D.creation i)) := by
            rw [A.mul_one (ComplexAlgebra.orderedProduct A m y)]
        _ = A.smul (sign (countBelow T (m + 1 + 1))) (A.mul (ComplexAlgebra.orderedProduct A (m + 1) y) (D.creation i)) := by
            rw [show ComplexAlgebra.orderedProduct A (m + 1) y = A.mul (ComplexAlgebra.orderedProduct A m y) (y (m + 1)) from rfl, hy]

/-- 本文 `claim_creation_generator_times_ordered_creation_product_without_index`：
i ∉ T なら a†_i ·_{Cl} a†_T = ς(N_i(T)) ∗_{Cl} a†_{T∪{i}}。 -/
theorem creation_mul_orderedCreationProduct_of_not_mem {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (T : PowerSet D.M)
    (hiT : i ∉ T.1) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.orderedCreationProduct T)
      = D.space.cliffordAlgebra.smul (sign (countBelow T i))
          (D.orderedCreationProduct (unionSingleton T i hi)) := by
  let A := D.space.cliffordAlgebra
  let S := unionSingleton T i hi
  let yT := D.selectedCreationFactor T
  let yS := D.selectedCreationFactor S
  -- t ≠ i なら y^S_t = y^T_t
  have hyS : ∀ t : ℕ, t ≠ i → yS t = yT t := by
    intro t hti
    by_cases htT : t ∈ T.1
    · rw [show yS t = D.creation t from
          D.selectedCreationFactor_of_mem ((mem_unionSingleton_iff_of_ne T i hi t hti).2 htT),
        show yT t = D.creation t from D.selectedCreationFactor_of_mem htT]
    · rw [show yS t = A.one from
          D.selectedCreationFactor_of_not_mem (fun h => htT ((mem_unionSingleton_iff_of_ne T i hi t hti).1 h)),
        show yT t = A.one from D.selectedCreationFactor_of_not_mem htT]
  have hyTi : yT i = A.one := D.selectedCreationFactor_of_not_mem hiT
  have hySi : yS i = D.creation i := D.selectedCreationFactor_of_mem (self_mem_unionSingleton T i hi)
  let L := ComplexAlgebra.orderedProduct A (i - 1) yT
  let R := ComplexAlgebra.orderedProduct A (D.M - i) (fun r => yT (i + r))
  have hL : L = ComplexAlgebra.orderedProduct A (i - 1) yS :=
    orderedProduct_congr A (i - 1) _ _ fun k _ hk => (hyS k (by omega)).symm
  have hR : R = ComplexAlgebra.orderedProduct A (D.M - i) (fun r => yS (i + r)) :=
    orderedProduct_congr A (D.M - i) _ _ fun r hr1 _ => (hyS (i + r) (by omega)).symm
  have hpass := D.creation_mul_initialCreationProduct (i := i) T (i - 1) le_rfl
  rw [Nat.sub_add_cancel hi.1] at hpass
  calc A.mul (D.creation i) (D.orderedCreationProduct T)
      = A.mul (D.creation i) (A.mul L (A.mul (yT i) R)) := by
        rw [orderedCreationProduct, orderedProduct_singleOut A D.M i hi.1 hi.2 yT]
    _ = A.mul (D.creation i) (A.mul L (A.mul A.one R)) := by rw [hyTi]
    _ = A.mul (D.creation i) (A.mul L R) := by rw [A.one_mul R]
    _ = A.mul (A.mul (D.creation i) L) R := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.smul (sign (countBelow T i)) (A.mul L (D.creation i))) R := by rw [hpass]
    _ = A.smul (sign (countBelow T i)) (A.mul (A.mul L (D.creation i)) R) := (A.smul_mul_left _ _ _).symm
    _ = A.smul (sign (countBelow T i)) (A.mul L (A.mul (D.creation i) R)) := by
        rw [A.mul_assoc L (D.creation i) R]
    _ = A.smul (sign (countBelow T i)) (A.mul L (A.mul (yS i) R)) := by rw [hySi]
    _ = A.smul (sign (countBelow T i)) (ComplexAlgebra.orderedProduct A D.M yS) := by
        rw [hL, hR, ← orderedProduct_singleOut A D.M i hi.1 hi.2 yS]
    _ = A.smul (sign (countBelow T i)) (D.orderedCreationProduct (unionSingleton T i hi)) := rfl

/-- 本文 `claim_creation_generator_times_ordered_creation_product_with_index_is_zero`：
i ∈ T なら a†_i ·_{Cl} a†_T = 0_{Cl}。 -/
theorem creation_mul_orderedCreationProduct_of_mem {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (T : PowerSet D.M)
    (hiT : i ∈ T.1) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.orderedCreationProduct T) = D.space.cliffordAlgebra.zero := by
  let A := D.space.cliffordAlgebra
  let yT := D.selectedCreationFactor T
  have hyTi : yT i = D.creation i := D.selectedCreationFactor_of_mem hiT
  let L := ComplexAlgebra.orderedProduct A (i - 1) yT
  let R := ComplexAlgebra.orderedProduct A (D.M - i) (fun r => yT (i + r))
  have hpass := D.creation_mul_initialCreationProduct (i := i) T (i - 1) le_rfl
  rw [Nat.sub_add_cancel hi.1] at hpass
  calc A.mul (D.creation i) (D.orderedCreationProduct T)
      = A.mul (D.creation i) (A.mul L (A.mul (D.creation i) R)) := by
        rw [orderedCreationProduct, orderedProduct_singleOut A D.M i hi.1 hi.2 yT, hyTi]
    _ = A.mul (A.mul (D.creation i) L) (A.mul (D.creation i) R) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.smul (sign (countBelow T i)) (A.mul L (D.creation i))) (A.mul (D.creation i) R) := by
        rw [hpass]
    _ = A.smul (sign (countBelow T i)) (A.mul (A.mul L (D.creation i)) (A.mul (D.creation i) R)) :=
        (A.smul_mul_left _ _ _).symm
    _ = A.smul (sign (countBelow T i)) (A.mul L (A.mul (D.creation i) (A.mul (D.creation i) R))) := by
        rw [A.mul_assoc L (D.creation i) (A.mul (D.creation i) R)]
    _ = A.smul (sign (countBelow T i)) (A.mul L (A.mul (A.mul (D.creation i) (D.creation i)) R)) := by
        rw [A.mul_assoc (D.creation i) (D.creation i) R]
    _ = A.smul (sign (countBelow T i)) (A.mul L (A.mul A.zero R)) := by rw [D.creation_mul_self i]
    _ = A.smul (sign (countBelow T i)) (A.mul L A.zero) := by rw [zero_mul_eq_zero A R]
    _ = A.smul (sign (countBelow T i)) A.zero := by rw [mul_zero_eq_zero A L]
    _ = A.zero := smul_zero_eq_zero A _

/-! ### 消滅の逆順の積に消滅元を右から掛ける -/

/-- 本文 `claim_initial_reverse_ordered_annihilation_product_splits_off_last_number`：
a_{T,≤m} = z^T_m ·_A a_{T,≤m-1}（本文の m を Lean では m + 1 と書く）。 -/
theorem initialReverseAnnihilationProduct_succ (T : PowerSet D.M) (m : ℕ) :
    D.initialReverseAnnihilationProduct T (m + 1)
      = D.space.cliffordAlgebra.mul (D.selectedAnnihilationFactor T (m + 1))
          (D.initialReverseAnnihilationProduct T m) := by
  let A := D.space.cliffordAlgebra
  let z := D.selectedAnnihilationFactor T
  let η : ℕ → D.space.Cl := fun s => z (m + 1 + 1 - s)
  calc D.initialReverseAnnihilationProduct T (m + 1)
      = ComplexAlgebra.orderedProduct A (m + 1) η := rfl
    _ = ComplexAlgebra.orderedProduct A (1 + m) η := by rw [Nat.add_comm m 1]
    _ = A.mul (ComplexAlgebra.orderedProduct A 1 η) (ComplexAlgebra.orderedProduct A m (fun r => η (1 + r))) := orderedProduct_split A 1 m η
    _ = A.mul (A.mul A.one (η 1)) (ComplexAlgebra.orderedProduct A m (fun r => η (1 + r))) := rfl
    _ = A.mul (η 1) (ComplexAlgebra.orderedProduct A m (fun r => η (1 + r))) := by rw [A.one_mul (η 1)]
    _ = A.mul (z (m + 1)) (ComplexAlgebra.orderedProduct A m (fun r => z (m + 1 - r))) := by
        rw [orderedProduct_congr A m (fun r => η (1 + r)) (fun r => z (m + 1 - r))
          fun r _ _ => congrArg z (by omega)]
        rfl
    _ = A.mul (z (m + 1)) (D.initialReverseAnnihilationProduct T m) := rfl

/-- 本文 `claim_initial_reverse_ordered_annihilation_product_up_to_last_number_is_whole_product`：a_{T,≤M} = a_T。 -/
theorem initialReverseAnnihilationProduct_last (T : PowerSet D.M) :
    D.initialReverseAnnihilationProduct T D.M = D.reverseOrderedAnnihilationProduct T :=
  calc D.initialReverseAnnihilationProduct T D.M
      = ComplexAlgebra.orderedProduct D.space.cliffordAlgebra D.M (fun k => D.selectedAnnihilationFactor T (D.M + 1 - k)) := rfl
    _ = ComplexAlgebra.orderedProduct D.space.cliffordAlgebra D.M (D.reversedSelectedAnnihilationFactor T) :=
        orderedProduct_congr _ D.M _ _ fun _ _ _ => rfl
    _ = D.reverseOrderedAnnihilationProduct T := rfl

/-- 本文 `claim_initial_annihilation_factors_pass_annihilation_generator_with_sign`：m ∈ {0,…,i-1} について
a_{T,≤m} ·_{Cl} a_i = ς(N_{m+1}(T)) ∗_{Cl} (a_i ·_{Cl} a_{T,≤m})。m についての帰納法。 -/
theorem initialReverseAnnihilationProduct_mul_annihilation {i : ℕ} (T : PowerSet D.M) :
    ∀ m : ℕ, m ≤ i - 1 →
      D.space.cliffordAlgebra.mul (D.initialReverseAnnihilationProduct T m) (D.annihilation i)
        = D.space.cliffordAlgebra.smul (sign (countBelow T (m + 1)))
            (D.space.cliffordAlgebra.mul (D.annihilation i) (D.initialReverseAnnihilationProduct T m)) := by
  let A := D.space.cliffordAlgebra
  let α := D.initialReverseAnnihilationProduct T
  intro m
  induction m with
  | zero =>
    intro _
    calc A.mul (α 0) (D.annihilation i)
        = A.mul A.one (D.annihilation i) := rfl
      _ = D.annihilation i := A.one_mul _
      _ = A.smul 1 (D.annihilation i) := (A.one_smul _).symm
      _ = A.smul 1 (A.mul (D.annihilation i) A.one) := by rw [A.mul_one (D.annihilation i)]
      _ = A.smul (sign 0) (A.mul (D.annihilation i) A.one) := by rw [sign_zero]
      _ = A.smul (sign (countBelow T 1)) (A.mul (D.annihilation i) A.one) := by rw [countBelow_one]
      _ = A.smul (sign (countBelow T (0 + 1))) (A.mul (D.annihilation i) (α 0)) := rfl
  | succ m ih =>
    intro hm
    have ih' := ih (by omega)
    by_cases hmT : m + 1 ∈ T.1
    · -- m + 1 ∈ T のとき z_{m+1} = a_{m+1}
      have hsplit : α (m + 1) = A.mul (D.annihilation (m + 1)) (α m) := by
        rw [show α (m + 1) = D.initialReverseAnnihilationProduct T (m + 1) from rfl,
          D.initialReverseAnnihilationProduct_succ T m, D.selectedAnnihilationFactor_of_mem hmT]
      calc A.mul (α (m + 1)) (D.annihilation i)
          = A.mul (A.mul (D.annihilation (m + 1)) (α m)) (D.annihilation i) := by rw [hsplit]
        _ = A.mul (D.annihilation (m + 1)) (A.mul (α m) (D.annihilation i)) := A.mul_assoc _ _ _
        _ = A.mul (D.annihilation (m + 1))
              (A.smul (sign (countBelow T (m + 1))) (A.mul (D.annihilation i) (α m))) := by rw [ih']
        _ = A.smul (sign (countBelow T (m + 1)))
              (A.mul (D.annihilation (m + 1)) (A.mul (D.annihilation i) (α m))) :=
            (A.smul_mul_right _ _ _).symm
        _ = A.smul (sign (countBelow T (m + 1)))
              (A.mul (A.mul (D.annihilation (m + 1)) (D.annihilation i)) (α m)) := by
            rw [A.mul_assoc (D.annihilation (m + 1)) (D.annihilation i) (α m)]
        _ = A.smul (sign (countBelow T (m + 1)))
              (A.mul (A.smul (-1) (A.mul (D.annihilation i) (D.annihilation (m + 1)))) (α m)) := by
            rw [mul_eq_neg_one_smul_swap A (D.annihilation (m + 1)) (D.annihilation i)
              (D.annihilation_anticommute (m + 1) i)]
        _ = A.smul (sign (countBelow T (m + 1)))
              (A.smul (-1) (A.mul (A.mul (D.annihilation i) (D.annihilation (m + 1))) (α m))) := by
            rw [← A.smul_mul_left (-1) (A.mul (D.annihilation i) (D.annihilation (m + 1))) (α m)]
        _ = A.smul (sign (countBelow T (m + 1)) * (-1))
              (A.mul (A.mul (D.annihilation i) (D.annihilation (m + 1))) (α m)) :=
            (A.smul_assoc _ _ _).symm
        _ = A.smul ((-1) * sign (countBelow T (m + 1)))
              (A.mul (A.mul (D.annihilation i) (D.annihilation (m + 1))) (α m)) := by
            rw [mul_comm (sign (countBelow T (m + 1))) (-1)]
        _ = A.smul (sign (countBelow T (m + 1) + 1))
              (A.mul (A.mul (D.annihilation i) (D.annihilation (m + 1))) (α m)) := by
            rw [sign_succ]
        _ = A.smul (sign (countBelow T (m + 2)))
              (A.mul (A.mul (D.annihilation i) (D.annihilation (m + 1))) (α m)) := by
            rw [countBelow_succ_succ_of_mem T m hmT]
        _ = A.smul (sign (countBelow T (m + 2)))
              (A.mul (D.annihilation i) (A.mul (D.annihilation (m + 1)) (α m))) := by
            rw [A.mul_assoc (D.annihilation i) (D.annihilation (m + 1)) (α m)]
        _ = A.smul (sign (countBelow T (m + 1 + 1))) (A.mul (D.annihilation i) (α (m + 1))) := by
            rw [hsplit]
    · -- m + 1 ∉ T のとき z_{m+1} = 1_A
      have hsplit : α (m + 1) = A.mul A.one (α m) := by
        rw [show α (m + 1) = D.initialReverseAnnihilationProduct T (m + 1) from rfl,
          D.initialReverseAnnihilationProduct_succ T m, D.selectedAnnihilationFactor_of_not_mem hmT]
      calc A.mul (α (m + 1)) (D.annihilation i)
          = A.mul (A.mul A.one (α m)) (D.annihilation i) := by rw [hsplit]
        _ = A.mul (α m) (D.annihilation i) := by rw [A.one_mul (α m)]
        _ = A.smul (sign (countBelow T (m + 1))) (A.mul (D.annihilation i) (α m)) := ih'
        _ = A.smul (sign (countBelow T (m + 2))) (A.mul (D.annihilation i) (α m)) := by
            rw [countBelow_succ_succ_of_not_mem T m hmT]
        _ = A.smul (sign (countBelow T (m + 2))) (A.mul (D.annihilation i) (A.mul A.one (α m))) := by
            rw [A.one_mul (α m)]
        _ = A.smul (sign (countBelow T (m + 1 + 1))) (A.mul (D.annihilation i) (α (m + 1))) := by
            rw [hsplit]

/-- 本文 `claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index` と
`claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero` の証明が共通に置く記号：
p := M + 1 - i、L := ∏_{k=1}^{M-i} ž^T_k、α := a_{T,≤i-1} で、a_T = L ·_A (ž^T_p ·_A α)。 -/
theorem reverseOrderedAnnihilationProduct_singleOut {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (T : PowerSet D.M) :
    D.reverseOrderedAnnihilationProduct T
      = D.space.cliffordAlgebra.mul
          (ComplexAlgebra.orderedProduct D.space.cliffordAlgebra (D.M - i) (D.reversedSelectedAnnihilationFactor T))
          (D.space.cliffordAlgebra.mul (D.selectedAnnihilationFactor T i)
            (D.initialReverseAnnihilationProduct T (i - 1))) := by
  let A := D.space.cliffordAlgebra
  let ž := D.reversedSelectedAnnihilationFactor T
  let p := D.M + 1 - i
  have hp1 : 1 ≤ p := by omega
  have hpM : p ≤ D.M := by omega
  -- ž^T_p = z^T_i（M + 1 - p = i）
  have hžp : ž p = D.selectedAnnihilationFactor T i := congrArg (D.selectedAnnihilationFactor T) (by omega)
  -- α を定める族と r ↦ ž^T_{p+r} は {1,…,i-1} で等しい（M + 1 - (p + r) = (i - 1) + 1 - r）
  have hα : ComplexAlgebra.orderedProduct A (D.M - p) (fun r => ž (p + r)) = D.initialReverseAnnihilationProduct T (i - 1) := by
    rw [show D.M - p = i - 1 by omega]
    exact orderedProduct_congr A (i - 1) _ _ fun r _ _ => congrArg (D.selectedAnnihilationFactor T) (by omega)
  calc D.reverseOrderedAnnihilationProduct T
      = A.mul (ComplexAlgebra.orderedProduct A (p - 1) ž) (A.mul (ž p) (ComplexAlgebra.orderedProduct A (D.M - p) (fun r => ž (p + r)))) :=
        orderedProduct_singleOut A D.M p hp1 hpM ž
    _ = A.mul (ComplexAlgebra.orderedProduct A (D.M - i) ž)
          (A.mul (D.selectedAnnihilationFactor T i) (D.initialReverseAnnihilationProduct T (i - 1))) := by
        rw [show p - 1 = D.M - i by omega, hžp, hα]

/-- 本文 `claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index`：
i ∉ T なら a_T ·_{Cl} a_i = ς(N_i(T)) ∗_{Cl} a_{T∪{i}}。 -/
theorem reverseOrderedAnnihilationProduct_mul_annihilation_of_not_mem {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (T : PowerSet D.M) (hiT : i ∉ T.1) :
    D.space.cliffordAlgebra.mul (D.reverseOrderedAnnihilationProduct T) (D.annihilation i)
      = D.space.cliffordAlgebra.smul (sign (countBelow T i))
          (D.reverseOrderedAnnihilationProduct (unionSingleton T i hi)) := by
  let A := D.space.cliffordAlgebra
  let S := unionSingleton T i hi
  -- t ≠ i なら z^S_t = z^T_t
  have hzS : ∀ t : ℕ, t ≠ i → D.selectedAnnihilationFactor S t = D.selectedAnnihilationFactor T t := by
    intro t hti
    by_cases htT : t ∈ T.1
    · rw [D.selectedAnnihilationFactor_of_mem ((mem_unionSingleton_iff_of_ne T i hi t hti).2 htT),
        D.selectedAnnihilationFactor_of_mem htT]
    · rw [D.selectedAnnihilationFactor_of_not_mem (fun h => htT ((mem_unionSingleton_iff_of_ne T i hi t hti).1 h)),
        D.selectedAnnihilationFactor_of_not_mem htT]
  have hzTi : D.selectedAnnihilationFactor T i = A.one := D.selectedAnnihilationFactor_of_not_mem hiT
  have hzSi : D.selectedAnnihilationFactor S i = D.annihilation i :=
    D.selectedAnnihilationFactor_of_mem (self_mem_unionSingleton T i hi)
  let L := ComplexAlgebra.orderedProduct A (D.M - i) (D.reversedSelectedAnnihilationFactor T)
  let α := D.initialReverseAnnihilationProduct T (i - 1)
  -- k ≤ M - i なら M + 1 - k ≥ i + 1 なので ž^S_k = ž^T_k
  have hL : L = ComplexAlgebra.orderedProduct A (D.M - i) (D.reversedSelectedAnnihilationFactor S) :=
    orderedProduct_congr A (D.M - i) _ _ fun k hk1 hk => (hzS (D.M + 1 - k) (by omega)).symm
  -- r ≤ i - 1 なら i - r ≤ i - 1 なので α は S でも同じ
  have hα : α = D.initialReverseAnnihilationProduct S (i - 1) :=
    orderedProduct_congr A (i - 1) _ _ fun r hr1 hr => (hzS (i - 1 + 1 - r) (by omega)).symm
  have hpass := D.initialReverseAnnihilationProduct_mul_annihilation (i := i) T (i - 1) le_rfl
  rw [Nat.sub_add_cancel hi.1] at hpass
  calc A.mul (D.reverseOrderedAnnihilationProduct T) (D.annihilation i)
      = A.mul (A.mul L (A.mul (D.selectedAnnihilationFactor T i) α)) (D.annihilation i) := by
        rw [D.reverseOrderedAnnihilationProduct_singleOut hi T]
    _ = A.mul (A.mul L (A.mul A.one α)) (D.annihilation i) := by rw [hzTi]
    _ = A.mul (A.mul L α) (D.annihilation i) := by rw [A.one_mul α]
    _ = A.mul L (A.mul α (D.annihilation i)) := A.mul_assoc _ _ _
    _ = A.mul L (A.smul (sign (countBelow T i)) (A.mul (D.annihilation i) α)) := by rw [hpass]
    _ = A.smul (sign (countBelow T i)) (A.mul L (A.mul (D.annihilation i) α)) := (A.smul_mul_right _ _ _).symm
    _ = A.smul (sign (countBelow T i)) (A.mul L (A.mul (D.selectedAnnihilationFactor S i) α)) := by rw [hzSi]
    _ = A.smul (sign (countBelow T i)) (D.reverseOrderedAnnihilationProduct S) := by
        rw [D.reverseOrderedAnnihilationProduct_singleOut hi S, hL, hα]
    _ = A.smul (sign (countBelow T i)) (D.reverseOrderedAnnihilationProduct (unionSingleton T i hi)) := rfl

/-- 本文 `claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero`：
i ∈ T なら a_T ·_{Cl} a_i = 0_{Cl}。 -/
theorem reverseOrderedAnnihilationProduct_mul_annihilation_of_mem {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (T : PowerSet D.M) (hiT : i ∈ T.1) :
    D.space.cliffordAlgebra.mul (D.reverseOrderedAnnihilationProduct T) (D.annihilation i)
      = D.space.cliffordAlgebra.zero := by
  let A := D.space.cliffordAlgebra
  let L := ComplexAlgebra.orderedProduct A (D.M - i) (D.reversedSelectedAnnihilationFactor T)
  let α := D.initialReverseAnnihilationProduct T (i - 1)
  have hpass := D.initialReverseAnnihilationProduct_mul_annihilation (i := i) T (i - 1) le_rfl
  rw [Nat.sub_add_cancel hi.1] at hpass
  calc A.mul (D.reverseOrderedAnnihilationProduct T) (D.annihilation i)
      = A.mul (A.mul L (A.mul (D.annihilation i) α)) (D.annihilation i) := by
        rw [D.reverseOrderedAnnihilationProduct_singleOut hi T, D.selectedAnnihilationFactor_of_mem hiT]
    _ = A.mul L (A.mul (A.mul (D.annihilation i) α) (D.annihilation i)) := A.mul_assoc _ _ _
    _ = A.mul L (A.mul (D.annihilation i) (A.mul α (D.annihilation i))) := by
        rw [A.mul_assoc (D.annihilation i) α (D.annihilation i)]
    _ = A.mul L (A.mul (D.annihilation i) (A.smul (sign (countBelow T i)) (A.mul (D.annihilation i) α))) := by
        rw [hpass]
    _ = A.mul L (A.smul (sign (countBelow T i)) (A.mul (D.annihilation i) (A.mul (D.annihilation i) α))) := by
        rw [← A.smul_mul_right (sign (countBelow T i)) (D.annihilation i) (A.mul (D.annihilation i) α)]
    _ = A.smul (sign (countBelow T i)) (A.mul L (A.mul (D.annihilation i) (A.mul (D.annihilation i) α))) :=
        (A.smul_mul_right _ _ _).symm
    _ = A.smul (sign (countBelow T i)) (A.mul L (A.mul (A.mul (D.annihilation i) (D.annihilation i)) α)) := by
        rw [A.mul_assoc (D.annihilation i) (D.annihilation i) α]
    _ = A.smul (sign (countBelow T i)) (A.mul L (A.mul A.zero α)) := by rw [D.annihilation_mul_self i]
    _ = A.smul (sign (countBelow T i)) (A.mul L A.zero) := by rw [zero_mul_eq_zero A α]
    _ = A.smul (sign (countBelow T i)) A.zero := by rw [mul_zero_eq_zero A L]
    _ = A.zero := smul_zero_eq_zero A _

end

end CliffordMatrixIsomorphism.Clifford.SplitData
