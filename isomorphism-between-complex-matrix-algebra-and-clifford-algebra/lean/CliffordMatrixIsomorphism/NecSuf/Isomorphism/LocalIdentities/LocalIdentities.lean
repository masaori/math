/-
章「同型の証明」の節「クリフォード代数の中の局所的な等式」の必要十分版。具体版
`Isomorphism/LocalIdentities/LocalIdentities.lean` と同じ def と同じ calc の行のまま、係数 ℂ を型の変数 K に、
-1_ℂ を K の元 n に替える（ς は `sign n`）。K には演算の記号 +・·・0・1・- だけを与え、使う性質は仮定として渡す。

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

主張ごとに使う K の性質（どの主張も、クリフォード代数 Cl(V,q) を作るための章「クリフォード代数」の仮定 `CliffordLaws K n` を持つ）:
  定義の七つと a_{T,≤m} の分解・a_{T,≤M} = a_T・a_T の分解
                                   `CliffordLaws K n` のほかに足さない（行が使うのは代数の公理と番号の計算だけ）
  a_i・a†_i と a_j a†_j の交換     a + (-a) = 0（生成元の反交換関係を引くため）。行の中で使う K の性質は、
                                   n · n = 1・1 + n = 0（本文の (-1_ℂ)·(-1_ℂ) = 1_ℂ と反交換する二元の入れ替え）・0 + 0 = 0
  a_i P = 0・P a†_i = 0             a + (-a) = 0（上の交換と a_i a_i = 0・a†_i a†_i = 0）・0 + 0 = 0
  生成元を左から掛ける三つ         a + (-a) = 0・1 + n = 0・ς(N) · n = n · ς(N)（乗法の交換法則を n に当てる）・a · 0 = 0（i ∈ T の場合）
  消滅元を右から掛ける三つ         生成元を左から掛ける三つと同じ

分かったこと:
- a + (-a) = 0 が要るのは、生成元の反交換関係と平方が零であること（`NecSuf/CliffordAlgebra/SplitQuadraticSpace/Generators.lean`）を
  引く主張だけである。積の定義と、番号順の積の分解（a_{T,≤m} = z^T_m · a_{T,≤m-1}、a_{T,≤M} = a_T、a_T = L · (z^T_i · α)）は使わない。
- 本文の -1_ℂ は、クリフォード代数の合同を定める n（1 + n = 0・n · n = 1 は `CliffordLaws` の欄 congruence）と同じ元でよい。
- 具体版が ℂ の乗法の交換法則を当てる行は ς(N) · (-1) = (-1) · ς(N) だけで、使うのは n と ς の値の交換である。
  `CliffordLaws` が乗法の交換法則を持つのでその欄を当てる（ς の値は n の累乗なので、n と交換することは乗法の結合法則からも出る）。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない（i ∈ {1,…,M} を仮定する主張は i から 1 ≤ M が従う）。

導出版は `Isomorphism/LocalIdentities/LocalIdentitiesFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.NecSuf.CliffordAlgebra.SplitQuadraticSpace.Generators
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebra
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CountAndSign
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.CreationOperatorMatrices.Sign

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.Isomorphism (sign sign_zero sign_succ)
open CliffordMatrixIsomorphism.Isomorphism
  (countBelow countBelow_one countBelow_succ_succ_of_mem countBelow_succ_succ_of_not_mem unionSingleton
    self_mem_unionSingleton mem_unionSingleton_iff_of_ne)
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet)
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver

universe u uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-! ### 定義 -/

open Classical in
/-- 本文 `def_selected_creation_factor` の必要十分版：y^S_t := a†_t（t ∈ S）、1_{Cl}（t ∉ S）。 -/
def selectedCreationFactor (S : PowerSet D.M) (t : ℕ) : (D.space C).Cl C :=
  if t ∈ S.1 then D.creation C t else ((D.space C).cliffordAlgebra C).one

theorem selectedCreationFactor_of_mem {S : PowerSet D.M} {t : ℕ} (h : t ∈ S.1) :
    D.selectedCreationFactor C S t = D.creation C t := if_pos h

theorem selectedCreationFactor_of_not_mem {S : PowerSet D.M} {t : ℕ} (h : t ∉ S.1) :
    D.selectedCreationFactor C S t = ((D.space C).cliffordAlgebra C).one := if_neg h

/-- 本文 `def_ordered_product_of_selected_creation_generators` の必要十分版：a†_S := ∏_{Cl,t=1}^{M} y^S_t。 -/
def orderedCreationProduct (S : PowerSet D.M) : (D.space C).Cl C :=
  AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) D.M (D.selectedCreationFactor C S)

open Classical in
/-- 本文 `def_selected_annihilation_factor` の必要十分版：z^T_t := a_t（t ∈ T）、1_{Cl}（t ∉ T）。 -/
def selectedAnnihilationFactor (T : PowerSet D.M) (t : ℕ) : (D.space C).Cl C :=
  if t ∈ T.1 then D.annihilation C t else ((D.space C).cliffordAlgebra C).one

theorem selectedAnnihilationFactor_of_mem {T : PowerSet D.M} {t : ℕ} (h : t ∈ T.1) :
    D.selectedAnnihilationFactor C T t = D.annihilation C t := if_pos h

theorem selectedAnnihilationFactor_of_not_mem {T : PowerSet D.M} {t : ℕ} (h : t ∉ T.1) :
    D.selectedAnnihilationFactor C T t = ((D.space C).cliffordAlgebra C).one := if_neg h

/-- 本文 `def_reverse_numbered_selected_annihilation_factor` の必要十分版：ž^T_k := z^T_{M+1-k}。 -/
def reversedSelectedAnnihilationFactor (T : PowerSet D.M) (k : ℕ) : (D.space C).Cl C :=
  D.selectedAnnihilationFactor C T (D.M + 1 - k)

/-- 本文 `def_reverse_ordered_product_of_selected_annihilation_generators` の必要十分版：a_T := ∏_{Cl,k=1}^{M} ž^T_k。 -/
def reverseOrderedAnnihilationProduct (T : PowerSet D.M) : (D.space C).Cl C :=
  AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) D.M (D.reversedSelectedAnnihilationFactor C T)

/-- 本文 `def_vacuum_factor_of_split_clifford_algebra` の必要十分版：x_i := a_i ·_{Cl} a†_i。 -/
def vacuumFactor (i : ℕ) : (D.space C).Cl C :=
  ((D.space C).cliffordAlgebra C).mul (D.annihilation C i) (D.creation C i)

/-- 本文 `def_vacuum_element_of_split_clifford_algebra` の必要十分版：P := ∏_{Cl,i=1}^{M} x_i。 -/
def vacuumElement : (D.space C).Cl C :=
  AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) D.M (D.vacuumFactor C)

/-- 本文 `def_initial_reverse_ordered_product_of_selected_annihilation_generators` の必要十分版：
a_{T,≤m} := ∏_{A,k=1}^{m} z^T_{m+1-k}。 -/
def initialReverseAnnihilationProduct (T : PowerSet D.M) (m : ℕ) : (D.space C).Cl C :=
  AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) m (fun k => D.selectedAnnihilationFactor C T (m + 1 - k))

/-! ### 消滅と生成の積と交換する元 -/

/-- 本文 `claim_annihilation_generator_commutes_with_other_number_pair` の必要十分版：
i ≠ j なら a_i (a_j a†_j) = (a_j a†_j) a_i。 -/
theorem annihilation_commute_vacuumFactor (hneg : ∀ a : K, a + -a = 0) {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (hj : 1 ≤ j ∧ j ≤ D.M) (hij : i ≠ j) :
    ((D.space C).cliffordAlgebra C).mul (D.annihilation C i) (D.vacuumFactor C j)
      = ((D.space C).cliffordAlgebra C).mul (D.vacuumFactor C j) (D.annihilation C i) := by
  let A := (D.space C).cliffordAlgebra C
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  -- 準備：a_i a†_j + a†_j a_i = 0_A
  have hprep : A.add (A.mul (D.annihilation C i) (D.creation C j)) (A.mul (D.creation C j) (D.annihilation C i))
      = A.zero := calc
    A.add (A.mul (D.annihilation C i) (D.creation C j)) (A.mul (D.creation C j) (D.annihilation C i))
        = A.smul (kroneckerDelta i j) A.one := D.annihilation_creation_anticommute C hneg i j hi.1 hi.2 hj.1 hj.2
    _ = A.smul 0 A.one := by rw [kroneckerDelta, if_neg hij]
    _ = A.zero := AlgebraOver.zero_smul_eq_zero A h00 A.one
  calc A.mul (D.annihilation C i) (D.vacuumFactor C j)
      = A.mul (D.annihilation C i) (A.mul (D.annihilation C j) (D.creation C j)) := rfl
    _ = A.mul (A.mul (D.annihilation C i) (D.annihilation C j)) (D.creation C j) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.smul n (A.mul (D.annihilation C j) (D.annihilation C i))) (D.creation C j) := by
        rw [mul_eq_neg_one_smul_swap h00 n C.congruence.one_add_n A (D.annihilation C i) (D.annihilation C j)
          (D.annihilation_anticommute C hneg i j)]
    _ = A.smul n (A.mul (A.mul (D.annihilation C j) (D.annihilation C i)) (D.creation C j)) :=
        (A.smul_mul_left _ _ _).symm
    _ = A.smul n (A.mul (D.annihilation C j) (A.mul (D.annihilation C i) (D.creation C j))) := by
        rw [A.mul_assoc (D.annihilation C j) (D.annihilation C i) (D.creation C j)]
    _ = A.smul n (A.mul (D.annihilation C j) (A.smul n (A.mul (D.creation C j) (D.annihilation C i)))) := by
        rw [mul_eq_neg_one_smul_swap h00 n C.congruence.one_add_n A (D.annihilation C i) (D.creation C j) hprep]
    _ = A.smul n (A.smul n (A.mul (D.annihilation C j) (A.mul (D.creation C j) (D.annihilation C i)))) := by
        rw [← A.smul_mul_right n (D.annihilation C j) (A.mul (D.creation C j) (D.annihilation C i))]
    _ = A.smul (n * n) (A.mul (D.annihilation C j) (A.mul (D.creation C j) (D.annihilation C i))) :=
        (A.smul_assoc _ _ _).symm
    _ = A.smul 1 (A.mul (D.annihilation C j) (A.mul (D.creation C j) (D.annihilation C i))) := by
        rw [C.congruence.n_mul_n]
    _ = A.mul (D.annihilation C j) (A.mul (D.creation C j) (D.annihilation C i)) := A.one_smul _
    _ = A.mul (A.mul (D.annihilation C j) (D.creation C j)) (D.annihilation C i) := (A.mul_assoc _ _ _).symm
    _ = A.mul (D.vacuumFactor C j) (D.annihilation C i) := rfl

/-- 本文 `claim_creation_generator_commutes_with_other_number_pair` の必要十分版：
i ≠ j なら a†_i (a_j a†_j) = (a_j a†_j) a†_i。 -/
theorem creation_commute_vacuumFactor (hneg : ∀ a : K, a + -a = 0) {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (hj : 1 ≤ j ∧ j ≤ D.M) (hij : i ≠ j) :
    ((D.space C).cliffordAlgebra C).mul (D.creation C i) (D.vacuumFactor C j)
      = ((D.space C).cliffordAlgebra C).mul (D.vacuumFactor C j) (D.creation C i) := by
  let A := (D.space C).cliffordAlgebra C
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  -- 準備：a†_i a_j + a_j a†_i = 0_A
  have hprep : A.add (A.mul (D.creation C i) (D.annihilation C j)) (A.mul (D.annihilation C j) (D.creation C i))
      = A.zero := calc
    A.add (A.mul (D.creation C i) (D.annihilation C j)) (A.mul (D.annihilation C j) (D.creation C i))
        = A.add (A.mul (D.annihilation C j) (D.creation C i)) (A.mul (D.creation C i) (D.annihilation C j)) :=
          A.add_comm _ _
    _ = A.smul (kroneckerDelta j i) A.one := D.annihilation_creation_anticommute C hneg j i hj.1 hj.2 hi.1 hi.2
    _ = A.smul 0 A.one := by rw [kroneckerDelta, if_neg (Ne.symm hij)]
    _ = A.zero := AlgebraOver.zero_smul_eq_zero A h00 A.one
  calc A.mul (D.creation C i) (D.vacuumFactor C j)
      = A.mul (D.creation C i) (A.mul (D.annihilation C j) (D.creation C j)) := rfl
    _ = A.mul (A.mul (D.creation C i) (D.annihilation C j)) (D.creation C j) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.smul n (A.mul (D.annihilation C j) (D.creation C i))) (D.creation C j) := by
        rw [mul_eq_neg_one_smul_swap h00 n C.congruence.one_add_n A (D.creation C i) (D.annihilation C j) hprep]
    _ = A.smul n (A.mul (A.mul (D.annihilation C j) (D.creation C i)) (D.creation C j)) :=
        (A.smul_mul_left _ _ _).symm
    _ = A.smul n (A.mul (D.annihilation C j) (A.mul (D.creation C i) (D.creation C j))) := by
        rw [A.mul_assoc (D.annihilation C j) (D.creation C i) (D.creation C j)]
    _ = A.smul n (A.mul (D.annihilation C j) (A.smul n (A.mul (D.creation C j) (D.creation C i)))) := by
        rw [mul_eq_neg_one_smul_swap h00 n C.congruence.one_add_n A (D.creation C i) (D.creation C j)
          (D.creation_anticommute C hneg i j)]
    _ = A.smul n (A.smul n (A.mul (D.annihilation C j) (A.mul (D.creation C j) (D.creation C i)))) := by
        rw [← A.smul_mul_right n (D.annihilation C j) (A.mul (D.creation C j) (D.creation C i))]
    _ = A.smul (n * n) (A.mul (D.annihilation C j) (A.mul (D.creation C j) (D.creation C i))) :=
        (A.smul_assoc _ _ _).symm
    _ = A.smul 1 (A.mul (D.annihilation C j) (A.mul (D.creation C j) (D.creation C i))) := by
        rw [C.congruence.n_mul_n]
    _ = A.mul (D.annihilation C j) (A.mul (D.creation C j) (D.creation C i)) := A.one_smul _
    _ = A.mul (A.mul (D.annihilation C j) (D.creation C j)) (D.creation C i) := (A.mul_assoc _ _ _).symm
    _ = A.mul (D.vacuumFactor C j) (D.creation C i) := rfl

/-! ### 真空への射影にあたる元と生成元の積 -/

/-- 本文 `claim_annihilation_generator_times_vacuum_element_is_zero` の必要十分版：a_i ·_{Cl} P = 0_{Cl}。 -/
theorem annihilation_mul_vacuumElement (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul (D.annihilation C i) (D.vacuumElement C)
      = ((D.space C).cliffordAlgebra C).zero := by
  let A := (D.space C).cliffordAlgebra C
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  let x := D.vacuumFactor C
  let L := AlgebraOver.orderedProduct A (i - 1) x
  let R := AlgebraOver.orderedProduct A (D.M - i) (fun r => x (i + r))
  -- 準備：a_i ·_A L = L ·_A a_i
  have hprep : A.mul (D.annihilation C i) L = A.mul L (D.annihilation C i) :=
    commute_orderedProduct A (D.annihilation C i) (i - 1) x fun k hk1 hk =>
      D.annihilation_commute_vacuumFactor C hneg hi ⟨hk1, by omega⟩ (by omega)
  calc A.mul (D.annihilation C i) (D.vacuumElement C)
      = A.mul (D.annihilation C i) (A.mul L (A.mul (x i) R)) := by
        rw [vacuumElement, orderedProduct_singleOut A D.M i hi.1 hi.2 x]
    _ = A.mul (A.mul (D.annihilation C i) L) (A.mul (x i) R) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.mul L (D.annihilation C i)) (A.mul (x i) R) := by rw [hprep]
    _ = A.mul L (A.mul (D.annihilation C i) (A.mul (x i) R)) := A.mul_assoc _ _ _
    _ = A.mul L (A.mul (A.mul (D.annihilation C i) (x i)) R) := by
        rw [A.mul_assoc (D.annihilation C i) (x i) R]
    _ = A.mul L (A.mul (A.mul (D.annihilation C i) (A.mul (D.annihilation C i) (D.creation C i))) R) := rfl
    _ = A.mul L (A.mul (A.mul (A.mul (D.annihilation C i) (D.annihilation C i)) (D.creation C i)) R) := by
        rw [A.mul_assoc (D.annihilation C i) (D.annihilation C i) (D.creation C i)]
    _ = A.mul L (A.mul (A.mul A.zero (D.creation C i)) R) := by rw [D.annihilation_mul_self C hneg i]
    _ = A.mul L (A.mul A.zero R) := by rw [zero_mul_eq_zero h00 A (D.creation C i)]
    _ = A.mul L A.zero := by rw [zero_mul_eq_zero h00 A R]
    _ = A.zero := mul_zero_eq_zero h00 A L

/-- 本文 `claim_vacuum_element_times_creation_generator_is_zero` の必要十分版：P ·_{Cl} a†_i = 0_{Cl}。 -/
theorem vacuumElement_mul_creation (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul (D.vacuumElement C) (D.creation C i)
      = ((D.space C).cliffordAlgebra C).zero := by
  let A := (D.space C).cliffordAlgebra C
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  let x := D.vacuumFactor C
  let L := AlgebraOver.orderedProduct A (i - 1) x
  let R := AlgebraOver.orderedProduct A (D.M - i) (fun r => x (i + r))
  -- 準備：a†_i ·_A R = R ·_A a†_i
  have hprep : A.mul (D.creation C i) R = A.mul R (D.creation C i) :=
    commute_orderedProduct A (D.creation C i) (D.M - i) (fun r => x (i + r)) fun r hr1 hr =>
      D.creation_commute_vacuumFactor C hneg hi ⟨by omega, by omega⟩ (by omega)
  calc A.mul (D.vacuumElement C) (D.creation C i)
      = A.mul (A.mul L (A.mul (x i) R)) (D.creation C i) := by
        rw [vacuumElement, orderedProduct_singleOut A D.M i hi.1 hi.2 x]
    _ = A.mul L (A.mul (A.mul (x i) R) (D.creation C i)) := A.mul_assoc _ _ _
    _ = A.mul L (A.mul (x i) (A.mul R (D.creation C i))) := by rw [A.mul_assoc (x i) R (D.creation C i)]
    _ = A.mul L (A.mul (x i) (A.mul (D.creation C i) R)) := by rw [hprep]
    _ = A.mul L (A.mul (A.mul (x i) (D.creation C i)) R) := by rw [A.mul_assoc (x i) (D.creation C i) R]
    _ = A.mul L (A.mul (A.mul (A.mul (D.annihilation C i) (D.creation C i)) (D.creation C i)) R) := rfl
    _ = A.mul L (A.mul (A.mul (D.annihilation C i) (A.mul (D.creation C i) (D.creation C i))) R) := by
        rw [A.mul_assoc (D.annihilation C i) (D.creation C i) (D.creation C i)]
    _ = A.mul L (A.mul (A.mul (D.annihilation C i) A.zero) R) := by rw [D.creation_mul_self C hneg i]
    _ = A.mul L (A.mul A.zero R) := by rw [mul_zero_eq_zero h00 A (D.annihilation C i)]
    _ = A.mul L A.zero := by rw [zero_mul_eq_zero h00 A R]
    _ = A.zero := mul_zero_eq_zero h00 A L

/-! ### 生成の積に生成元を左から掛ける -/

/-- 本文 `claim_creation_generator_passes_initial_creation_factors_with_sign` の必要十分版：m ∈ {0,…,i-1} について
a†_i ·_{Cl} ∏_{t=1}^{m} y^T_t = ς(N_{m+1}(T)) ∗_{Cl} ((∏_{t=1}^{m} y^T_t) ·_{Cl} a†_i)。m についての帰納法。 -/
theorem creation_mul_initialCreationProduct (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (T : PowerSet D.M) :
    ∀ m : ℕ, m ≤ i - 1 →
      ((D.space C).cliffordAlgebra C).mul (D.creation C i)
          (AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) m (D.selectedCreationFactor C T))
        = ((D.space C).cliffordAlgebra C).smul (sign n (countBelow T (m + 1)))
            (((D.space C).cliffordAlgebra C).mul
              (AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) m (D.selectedCreationFactor C T))
              (D.creation C i)) := by
  let A := (D.space C).cliffordAlgebra C
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  let y := D.selectedCreationFactor C T
  intro m
  induction m with
  | zero =>
    intro _
    calc A.mul (D.creation C i) (AlgebraOver.orderedProduct A 0 y)
        = A.mul (D.creation C i) A.one := rfl
      _ = D.creation C i := A.mul_one _
      _ = A.smul 1 (D.creation C i) := (A.one_smul _).symm
      _ = A.smul 1 (A.mul A.one (D.creation C i)) := by rw [A.one_mul (D.creation C i)]
      _ = A.smul (sign n 0) (A.mul A.one (D.creation C i)) := by rw [sign_zero]
      _ = A.smul (sign n (countBelow T 1)) (A.mul A.one (D.creation C i)) := by rw [countBelow_one]
      _ = A.smul (sign n (countBelow T (0 + 1))) (A.mul (AlgebraOver.orderedProduct A 0 y) (D.creation C i)) := rfl
  | succ m ih =>
    intro hm
    have ih' := ih (by omega)
    by_cases hmT : m + 1 ∈ T.1
    · -- m + 1 ∈ T のとき y_{m+1} = a†_{m+1}
      have hy : y (m + 1) = D.creation C (m + 1) := D.selectedCreationFactor_of_mem C hmT
      calc A.mul (D.creation C i) (AlgebraOver.orderedProduct A (m + 1) y)
          = A.mul (D.creation C i) (A.mul (AlgebraOver.orderedProduct A m y) (D.creation C (m + 1))) := by
            rw [show AlgebraOver.orderedProduct A (m + 1) y = A.mul (AlgebraOver.orderedProduct A m y) (y (m + 1))
              from rfl, hy]
        _ = A.mul (A.mul (D.creation C i) (AlgebraOver.orderedProduct A m y)) (D.creation C (m + 1)) :=
            (A.mul_assoc _ _ _).symm
        _ = A.mul (A.smul (sign n (countBelow T (m + 1))) (A.mul (AlgebraOver.orderedProduct A m y) (D.creation C i)))
              (D.creation C (m + 1)) := by rw [ih']
        _ = A.smul (sign n (countBelow T (m + 1)))
              (A.mul (A.mul (AlgebraOver.orderedProduct A m y) (D.creation C i)) (D.creation C (m + 1))) :=
            (A.smul_mul_left _ _ _).symm
        _ = A.smul (sign n (countBelow T (m + 1)))
              (A.mul (AlgebraOver.orderedProduct A m y) (A.mul (D.creation C i) (D.creation C (m + 1)))) := by
            rw [A.mul_assoc (AlgebraOver.orderedProduct A m y) (D.creation C i) (D.creation C (m + 1))]
        _ = A.smul (sign n (countBelow T (m + 1)))
              (A.mul (AlgebraOver.orderedProduct A m y)
                (A.smul n (A.mul (D.creation C (m + 1)) (D.creation C i)))) := by
            rw [mul_eq_neg_one_smul_swap h00 n C.congruence.one_add_n A (D.creation C i) (D.creation C (m + 1))
              (D.creation_anticommute C hneg i (m + 1))]
        _ = A.smul (sign n (countBelow T (m + 1)))
              (A.smul n (A.mul (AlgebraOver.orderedProduct A m y) (A.mul (D.creation C (m + 1)) (D.creation C i)))) := by
            rw [← A.smul_mul_right n (AlgebraOver.orderedProduct A m y)
              (A.mul (D.creation C (m + 1)) (D.creation C i))]
        _ = A.smul (sign n (countBelow T (m + 1)) * n)
              (A.mul (AlgebraOver.orderedProduct A m y) (A.mul (D.creation C (m + 1)) (D.creation C i))) :=
            (A.smul_assoc _ _ _).symm
        _ = A.smul (n * sign n (countBelow T (m + 1)))
              (A.mul (AlgebraOver.orderedProduct A m y) (A.mul (D.creation C (m + 1)) (D.creation C i))) := by
            rw [C.mul_comm (sign n (countBelow T (m + 1))) n]
        _ = A.smul (sign n (countBelow T (m + 1) + 1))
              (A.mul (AlgebraOver.orderedProduct A m y) (A.mul (D.creation C (m + 1)) (D.creation C i))) := by
            rw [sign_succ]
        _ = A.smul (sign n (countBelow T (m + 2)))
              (A.mul (AlgebraOver.orderedProduct A m y) (A.mul (D.creation C (m + 1)) (D.creation C i))) := by
            rw [countBelow_succ_succ_of_mem T m hmT]
        _ = A.smul (sign n (countBelow T (m + 2)))
              (A.mul (A.mul (AlgebraOver.orderedProduct A m y) (D.creation C (m + 1))) (D.creation C i)) := by
            rw [A.mul_assoc (AlgebraOver.orderedProduct A m y) (D.creation C (m + 1)) (D.creation C i)]
        _ = A.smul (sign n (countBelow T (m + 1 + 1)))
              (A.mul (AlgebraOver.orderedProduct A (m + 1) y) (D.creation C i)) := by
            rw [show AlgebraOver.orderedProduct A (m + 1) y = A.mul (AlgebraOver.orderedProduct A m y) (y (m + 1))
              from rfl, hy]
    · -- m + 1 ∉ T のとき y_{m+1} = 1_A
      have hy : y (m + 1) = A.one := D.selectedCreationFactor_of_not_mem C hmT
      calc A.mul (D.creation C i) (AlgebraOver.orderedProduct A (m + 1) y)
          = A.mul (D.creation C i) (A.mul (AlgebraOver.orderedProduct A m y) A.one) := by
            rw [show AlgebraOver.orderedProduct A (m + 1) y = A.mul (AlgebraOver.orderedProduct A m y) (y (m + 1))
              from rfl, hy]
        _ = A.mul (D.creation C i) (AlgebraOver.orderedProduct A m y) := by
            rw [A.mul_one (AlgebraOver.orderedProduct A m y)]
        _ = A.smul (sign n (countBelow T (m + 1))) (A.mul (AlgebraOver.orderedProduct A m y) (D.creation C i)) := ih'
        _ = A.smul (sign n (countBelow T (m + 2))) (A.mul (AlgebraOver.orderedProduct A m y) (D.creation C i)) := by
            rw [countBelow_succ_succ_of_not_mem T m hmT]
        _ = A.smul (sign n (countBelow T (m + 2)))
              (A.mul (A.mul (AlgebraOver.orderedProduct A m y) A.one) (D.creation C i)) := by
            rw [A.mul_one (AlgebraOver.orderedProduct A m y)]
        _ = A.smul (sign n (countBelow T (m + 1 + 1)))
              (A.mul (AlgebraOver.orderedProduct A (m + 1) y) (D.creation C i)) := by
            rw [show AlgebraOver.orderedProduct A (m + 1) y = A.mul (AlgebraOver.orderedProduct A m y) (y (m + 1))
              from rfl, hy]

/-- 本文 `claim_creation_generator_times_ordered_creation_product_without_index` の必要十分版：
i ∉ T なら a†_i ·_{Cl} a†_T = ς(N_i(T)) ∗_{Cl} a†_{T∪{i}}。 -/
theorem creation_mul_orderedCreationProduct_of_not_mem (hneg : ∀ a : K, a + -a = 0) {i : ℕ}
    (hi : 1 ≤ i ∧ i ≤ D.M) (T : PowerSet D.M) (hiT : i ∉ T.1) :
    ((D.space C).cliffordAlgebra C).mul (D.creation C i) (D.orderedCreationProduct C T)
      = ((D.space C).cliffordAlgebra C).smul (sign n (countBelow T i))
          (D.orderedCreationProduct C (unionSingleton T i hi)) := by
  let A := (D.space C).cliffordAlgebra C
  let S := unionSingleton T i hi
  let yT := D.selectedCreationFactor C T
  let yS := D.selectedCreationFactor C S
  -- t ≠ i なら y^S_t = y^T_t
  have hyS : ∀ t : ℕ, t ≠ i → yS t = yT t := by
    intro t hti
    by_cases htT : t ∈ T.1
    · rw [show yS t = D.creation C t from
          D.selectedCreationFactor_of_mem C ((mem_unionSingleton_iff_of_ne T i hi t hti).2 htT),
        show yT t = D.creation C t from D.selectedCreationFactor_of_mem C htT]
    · rw [show yS t = A.one from
          D.selectedCreationFactor_of_not_mem C (fun h => htT ((mem_unionSingleton_iff_of_ne T i hi t hti).1 h)),
        show yT t = A.one from D.selectedCreationFactor_of_not_mem C htT]
  have hyTi : yT i = A.one := D.selectedCreationFactor_of_not_mem C hiT
  have hySi : yS i = D.creation C i := D.selectedCreationFactor_of_mem C (self_mem_unionSingleton T i hi)
  let L := AlgebraOver.orderedProduct A (i - 1) yT
  let R := AlgebraOver.orderedProduct A (D.M - i) (fun r => yT (i + r))
  have hL : L = AlgebraOver.orderedProduct A (i - 1) yS :=
    orderedProduct_congr A (i - 1) _ _ fun k _ hk => (hyS k (by omega)).symm
  have hR : R = AlgebraOver.orderedProduct A (D.M - i) (fun r => yS (i + r)) :=
    orderedProduct_congr A (D.M - i) _ _ fun r hr1 _ => (hyS (i + r) (by omega)).symm
  have hpass := D.creation_mul_initialCreationProduct C hneg (i := i) T (i - 1) le_rfl
  rw [Nat.sub_add_cancel hi.1] at hpass
  calc A.mul (D.creation C i) (D.orderedCreationProduct C T)
      = A.mul (D.creation C i) (A.mul L (A.mul (yT i) R)) := by
        rw [orderedCreationProduct, orderedProduct_singleOut A D.M i hi.1 hi.2 yT]
    _ = A.mul (D.creation C i) (A.mul L (A.mul A.one R)) := by rw [hyTi]
    _ = A.mul (D.creation C i) (A.mul L R) := by rw [A.one_mul R]
    _ = A.mul (A.mul (D.creation C i) L) R := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.smul (sign n (countBelow T i)) (A.mul L (D.creation C i))) R := by rw [hpass]
    _ = A.smul (sign n (countBelow T i)) (A.mul (A.mul L (D.creation C i)) R) := (A.smul_mul_left _ _ _).symm
    _ = A.smul (sign n (countBelow T i)) (A.mul L (A.mul (D.creation C i) R)) := by
        rw [A.mul_assoc L (D.creation C i) R]
    _ = A.smul (sign n (countBelow T i)) (A.mul L (A.mul (yS i) R)) := by rw [hySi]
    _ = A.smul (sign n (countBelow T i)) (AlgebraOver.orderedProduct A D.M yS) := by
        rw [hL, hR, ← orderedProduct_singleOut A D.M i hi.1 hi.2 yS]
    _ = A.smul (sign n (countBelow T i)) (D.orderedCreationProduct C (unionSingleton T i hi)) := rfl

/-- 本文 `claim_creation_generator_times_ordered_creation_product_with_index_is_zero` の必要十分版：
i ∈ T なら a†_i ·_{Cl} a†_T = 0_{Cl}。 -/
theorem creation_mul_orderedCreationProduct_of_mem (hneg : ∀ a : K, a + -a = 0) {i : ℕ}
    (hi : 1 ≤ i ∧ i ≤ D.M) (T : PowerSet D.M) (hiT : i ∈ T.1) :
    ((D.space C).cliffordAlgebra C).mul (D.creation C i) (D.orderedCreationProduct C T)
      = ((D.space C).cliffordAlgebra C).zero := by
  let A := (D.space C).cliffordAlgebra C
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  let yT := D.selectedCreationFactor C T
  have hyTi : yT i = D.creation C i := D.selectedCreationFactor_of_mem C hiT
  let L := AlgebraOver.orderedProduct A (i - 1) yT
  let R := AlgebraOver.orderedProduct A (D.M - i) (fun r => yT (i + r))
  have hpass := D.creation_mul_initialCreationProduct C hneg (i := i) T (i - 1) le_rfl
  rw [Nat.sub_add_cancel hi.1] at hpass
  calc A.mul (D.creation C i) (D.orderedCreationProduct C T)
      = A.mul (D.creation C i) (A.mul L (A.mul (D.creation C i) R)) := by
        rw [orderedCreationProduct, orderedProduct_singleOut A D.M i hi.1 hi.2 yT, hyTi]
    _ = A.mul (A.mul (D.creation C i) L) (A.mul (D.creation C i) R) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.smul (sign n (countBelow T i)) (A.mul L (D.creation C i))) (A.mul (D.creation C i) R) := by
        rw [hpass]
    _ = A.smul (sign n (countBelow T i)) (A.mul (A.mul L (D.creation C i)) (A.mul (D.creation C i) R)) :=
        (A.smul_mul_left _ _ _).symm
    _ = A.smul (sign n (countBelow T i)) (A.mul L (A.mul (D.creation C i) (A.mul (D.creation C i) R))) := by
        rw [A.mul_assoc L (D.creation C i) (A.mul (D.creation C i) R)]
    _ = A.smul (sign n (countBelow T i)) (A.mul L (A.mul (A.mul (D.creation C i) (D.creation C i)) R)) := by
        rw [A.mul_assoc (D.creation C i) (D.creation C i) R]
    _ = A.smul (sign n (countBelow T i)) (A.mul L (A.mul A.zero R)) := by rw [D.creation_mul_self C hneg i]
    _ = A.smul (sign n (countBelow T i)) (A.mul L A.zero) := by rw [zero_mul_eq_zero h00 A R]
    _ = A.smul (sign n (countBelow T i)) A.zero := by rw [mul_zero_eq_zero h00 A L]
    _ = A.zero := VectorSpace.smul_zero_eq_zero A.toVectorSpace h00 C.uniqueness.mul_zero _

/-! ### 消滅の逆順の積に消滅元を右から掛ける -/

/-- 本文 `claim_initial_reverse_ordered_annihilation_product_splits_off_last_number` の必要十分版：
a_{T,≤m} = z^T_m ·_A a_{T,≤m-1}（本文の m を Lean では m + 1 と書く）。 -/
theorem initialReverseAnnihilationProduct_succ (T : PowerSet D.M) (m : ℕ) :
    D.initialReverseAnnihilationProduct C T (m + 1)
      = ((D.space C).cliffordAlgebra C).mul (D.selectedAnnihilationFactor C T (m + 1))
          (D.initialReverseAnnihilationProduct C T m) := by
  let A := (D.space C).cliffordAlgebra C
  let z := D.selectedAnnihilationFactor C T
  let η : ℕ → (D.space C).Cl C := fun s => z (m + 1 + 1 - s)
  calc D.initialReverseAnnihilationProduct C T (m + 1)
      = AlgebraOver.orderedProduct A (m + 1) η := rfl
    _ = AlgebraOver.orderedProduct A (1 + m) η := by rw [Nat.add_comm m 1]
    _ = A.mul (AlgebraOver.orderedProduct A 1 η) (AlgebraOver.orderedProduct A m (fun r => η (1 + r))) :=
        orderedProduct_split A 1 m η
    _ = A.mul (A.mul A.one (η 1)) (AlgebraOver.orderedProduct A m (fun r => η (1 + r))) := rfl
    _ = A.mul (η 1) (AlgebraOver.orderedProduct A m (fun r => η (1 + r))) := by rw [A.one_mul (η 1)]
    _ = A.mul (z (m + 1)) (AlgebraOver.orderedProduct A m (fun r => z (m + 1 - r))) := by
        rw [orderedProduct_congr A m (fun r => η (1 + r)) (fun r => z (m + 1 - r))
          fun r _ _ => congrArg z (by omega)]
        rfl
    _ = A.mul (z (m + 1)) (D.initialReverseAnnihilationProduct C T m) := rfl

/-- 本文 `claim_initial_reverse_ordered_annihilation_product_up_to_last_number_is_whole_product` の必要十分版：
a_{T,≤M} = a_T。 -/
theorem initialReverseAnnihilationProduct_last (T : PowerSet D.M) :
    D.initialReverseAnnihilationProduct C T D.M = D.reverseOrderedAnnihilationProduct C T :=
  calc D.initialReverseAnnihilationProduct C T D.M
      = AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) D.M
          (fun k => D.selectedAnnihilationFactor C T (D.M + 1 - k)) := rfl
    _ = AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) D.M (D.reversedSelectedAnnihilationFactor C T) :=
        orderedProduct_congr _ D.M _ _ fun _ _ _ => rfl
    _ = D.reverseOrderedAnnihilationProduct C T := rfl

/-- 本文 `claim_initial_annihilation_factors_pass_annihilation_generator_with_sign` の必要十分版：m ∈ {0,…,i-1} について
a_{T,≤m} ·_{Cl} a_i = ς(N_{m+1}(T)) ∗_{Cl} (a_i ·_{Cl} a_{T,≤m})。m についての帰納法。 -/
theorem initialReverseAnnihilationProduct_mul_annihilation (hneg : ∀ a : K, a + -a = 0) {i : ℕ}
    (T : PowerSet D.M) :
    ∀ m : ℕ, m ≤ i - 1 →
      ((D.space C).cliffordAlgebra C).mul (D.initialReverseAnnihilationProduct C T m) (D.annihilation C i)
        = ((D.space C).cliffordAlgebra C).smul (sign n (countBelow T (m + 1)))
            (((D.space C).cliffordAlgebra C).mul (D.annihilation C i) (D.initialReverseAnnihilationProduct C T m)) := by
  let A := (D.space C).cliffordAlgebra C
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  let α := D.initialReverseAnnihilationProduct C T
  intro m
  induction m with
  | zero =>
    intro _
    calc A.mul (α 0) (D.annihilation C i)
        = A.mul A.one (D.annihilation C i) := rfl
      _ = D.annihilation C i := A.one_mul _
      _ = A.smul 1 (D.annihilation C i) := (A.one_smul _).symm
      _ = A.smul 1 (A.mul (D.annihilation C i) A.one) := by rw [A.mul_one (D.annihilation C i)]
      _ = A.smul (sign n 0) (A.mul (D.annihilation C i) A.one) := by rw [sign_zero]
      _ = A.smul (sign n (countBelow T 1)) (A.mul (D.annihilation C i) A.one) := by rw [countBelow_one]
      _ = A.smul (sign n (countBelow T (0 + 1))) (A.mul (D.annihilation C i) (α 0)) := rfl
  | succ m ih =>
    intro hm
    have ih' := ih (by omega)
    by_cases hmT : m + 1 ∈ T.1
    · -- m + 1 ∈ T のとき z_{m+1} = a_{m+1}
      have hsplit : α (m + 1) = A.mul (D.annihilation C (m + 1)) (α m) := by
        rw [show α (m + 1) = D.initialReverseAnnihilationProduct C T (m + 1) from rfl,
          D.initialReverseAnnihilationProduct_succ C T m, D.selectedAnnihilationFactor_of_mem C hmT]
      calc A.mul (α (m + 1)) (D.annihilation C i)
          = A.mul (A.mul (D.annihilation C (m + 1)) (α m)) (D.annihilation C i) := by rw [hsplit]
        _ = A.mul (D.annihilation C (m + 1)) (A.mul (α m) (D.annihilation C i)) := A.mul_assoc _ _ _
        _ = A.mul (D.annihilation C (m + 1))
              (A.smul (sign n (countBelow T (m + 1))) (A.mul (D.annihilation C i) (α m))) := by rw [ih']
        _ = A.smul (sign n (countBelow T (m + 1)))
              (A.mul (D.annihilation C (m + 1)) (A.mul (D.annihilation C i) (α m))) :=
            (A.smul_mul_right _ _ _).symm
        _ = A.smul (sign n (countBelow T (m + 1)))
              (A.mul (A.mul (D.annihilation C (m + 1)) (D.annihilation C i)) (α m)) := by
            rw [A.mul_assoc (D.annihilation C (m + 1)) (D.annihilation C i) (α m)]
        _ = A.smul (sign n (countBelow T (m + 1)))
              (A.mul (A.smul n (A.mul (D.annihilation C i) (D.annihilation C (m + 1)))) (α m)) := by
            rw [mul_eq_neg_one_smul_swap h00 n C.congruence.one_add_n A (D.annihilation C (m + 1))
              (D.annihilation C i) (D.annihilation_anticommute C hneg (m + 1) i)]
        _ = A.smul (sign n (countBelow T (m + 1)))
              (A.smul n (A.mul (A.mul (D.annihilation C i) (D.annihilation C (m + 1))) (α m))) := by
            rw [← A.smul_mul_left n (A.mul (D.annihilation C i) (D.annihilation C (m + 1))) (α m)]
        _ = A.smul (sign n (countBelow T (m + 1)) * n)
              (A.mul (A.mul (D.annihilation C i) (D.annihilation C (m + 1))) (α m)) :=
            (A.smul_assoc _ _ _).symm
        _ = A.smul (n * sign n (countBelow T (m + 1)))
              (A.mul (A.mul (D.annihilation C i) (D.annihilation C (m + 1))) (α m)) := by
            rw [C.mul_comm (sign n (countBelow T (m + 1))) n]
        _ = A.smul (sign n (countBelow T (m + 1) + 1))
              (A.mul (A.mul (D.annihilation C i) (D.annihilation C (m + 1))) (α m)) := by
            rw [sign_succ]
        _ = A.smul (sign n (countBelow T (m + 2)))
              (A.mul (A.mul (D.annihilation C i) (D.annihilation C (m + 1))) (α m)) := by
            rw [countBelow_succ_succ_of_mem T m hmT]
        _ = A.smul (sign n (countBelow T (m + 2)))
              (A.mul (D.annihilation C i) (A.mul (D.annihilation C (m + 1)) (α m))) := by
            rw [A.mul_assoc (D.annihilation C i) (D.annihilation C (m + 1)) (α m)]
        _ = A.smul (sign n (countBelow T (m + 1 + 1))) (A.mul (D.annihilation C i) (α (m + 1))) := by
            rw [hsplit]
    · -- m + 1 ∉ T のとき z_{m+1} = 1_A
      have hsplit : α (m + 1) = A.mul A.one (α m) := by
        rw [show α (m + 1) = D.initialReverseAnnihilationProduct C T (m + 1) from rfl,
          D.initialReverseAnnihilationProduct_succ C T m, D.selectedAnnihilationFactor_of_not_mem C hmT]
      calc A.mul (α (m + 1)) (D.annihilation C i)
          = A.mul (A.mul A.one (α m)) (D.annihilation C i) := by rw [hsplit]
        _ = A.mul (α m) (D.annihilation C i) := by rw [A.one_mul (α m)]
        _ = A.smul (sign n (countBelow T (m + 1))) (A.mul (D.annihilation C i) (α m)) := ih'
        _ = A.smul (sign n (countBelow T (m + 2))) (A.mul (D.annihilation C i) (α m)) := by
            rw [countBelow_succ_succ_of_not_mem T m hmT]
        _ = A.smul (sign n (countBelow T (m + 2))) (A.mul (D.annihilation C i) (A.mul A.one (α m))) := by
            rw [A.one_mul (α m)]
        _ = A.smul (sign n (countBelow T (m + 1 + 1))) (A.mul (D.annihilation C i) (α (m + 1))) := by
            rw [hsplit]

/-- 本文 `claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index` と
`claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero` の証明が共通に置く記号の必要十分版：
p := M + 1 - i、L := ∏_{k=1}^{M-i} ž^T_k、α := a_{T,≤i-1} で、a_T = L ·_A (ž^T_p ·_A α)。 -/
theorem reverseOrderedAnnihilationProduct_singleOut {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (T : PowerSet D.M) :
    D.reverseOrderedAnnihilationProduct C T
      = ((D.space C).cliffordAlgebra C).mul
          (AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) (D.M - i)
            (D.reversedSelectedAnnihilationFactor C T))
          (((D.space C).cliffordAlgebra C).mul (D.selectedAnnihilationFactor C T i)
            (D.initialReverseAnnihilationProduct C T (i - 1))) := by
  let A := (D.space C).cliffordAlgebra C
  let ž := D.reversedSelectedAnnihilationFactor C T
  let p := D.M + 1 - i
  have hp1 : 1 ≤ p := by omega
  have hpM : p ≤ D.M := by omega
  -- ž^T_p = z^T_i（M + 1 - p = i）
  have hžp : ž p = D.selectedAnnihilationFactor C T i := congrArg (D.selectedAnnihilationFactor C T) (by omega)
  -- α を定める族と r ↦ ž^T_{p+r} は {1,…,i-1} で等しい（M + 1 - (p + r) = (i - 1) + 1 - r）
  have hα : AlgebraOver.orderedProduct A (D.M - p) (fun r => ž (p + r))
      = D.initialReverseAnnihilationProduct C T (i - 1) := by
    rw [show D.M - p = i - 1 by omega]
    exact orderedProduct_congr A (i - 1) _ _ fun r _ _ => congrArg (D.selectedAnnihilationFactor C T) (by omega)
  calc D.reverseOrderedAnnihilationProduct C T
      = A.mul (AlgebraOver.orderedProduct A (p - 1) ž)
          (A.mul (ž p) (AlgebraOver.orderedProduct A (D.M - p) (fun r => ž (p + r)))) :=
        orderedProduct_singleOut A D.M p hp1 hpM ž
    _ = A.mul (AlgebraOver.orderedProduct A (D.M - i) ž)
          (A.mul (D.selectedAnnihilationFactor C T i) (D.initialReverseAnnihilationProduct C T (i - 1))) := by
        rw [show p - 1 = D.M - i by omega, hžp, hα]

/-- 本文 `claim_reverse_ordered_annihilation_product_times_annihilation_generator_without_index` の必要十分版：
i ∉ T なら a_T ·_{Cl} a_i = ς(N_i(T)) ∗_{Cl} a_{T∪{i}}。 -/
theorem reverseOrderedAnnihilationProduct_mul_annihilation_of_not_mem (hneg : ∀ a : K, a + -a = 0) {i : ℕ}
    (hi : 1 ≤ i ∧ i ≤ D.M) (T : PowerSet D.M) (hiT : i ∉ T.1) :
    ((D.space C).cliffordAlgebra C).mul (D.reverseOrderedAnnihilationProduct C T) (D.annihilation C i)
      = ((D.space C).cliffordAlgebra C).smul (sign n (countBelow T i))
          (D.reverseOrderedAnnihilationProduct C (unionSingleton T i hi)) := by
  let A := (D.space C).cliffordAlgebra C
  let S := unionSingleton T i hi
  -- t ≠ i なら z^S_t = z^T_t
  have hzS : ∀ t : ℕ, t ≠ i → D.selectedAnnihilationFactor C S t = D.selectedAnnihilationFactor C T t := by
    intro t hti
    by_cases htT : t ∈ T.1
    · rw [D.selectedAnnihilationFactor_of_mem C ((mem_unionSingleton_iff_of_ne T i hi t hti).2 htT),
        D.selectedAnnihilationFactor_of_mem C htT]
    · rw [D.selectedAnnihilationFactor_of_not_mem C
          (fun h => htT ((mem_unionSingleton_iff_of_ne T i hi t hti).1 h)),
        D.selectedAnnihilationFactor_of_not_mem C htT]
  have hzTi : D.selectedAnnihilationFactor C T i = A.one := D.selectedAnnihilationFactor_of_not_mem C hiT
  have hzSi : D.selectedAnnihilationFactor C S i = D.annihilation C i :=
    D.selectedAnnihilationFactor_of_mem C (self_mem_unionSingleton T i hi)
  let L := AlgebraOver.orderedProduct A (D.M - i) (D.reversedSelectedAnnihilationFactor C T)
  let α := D.initialReverseAnnihilationProduct C T (i - 1)
  -- k ≤ M - i なら M + 1 - k ≥ i + 1 なので ž^S_k = ž^T_k
  have hL : L = AlgebraOver.orderedProduct A (D.M - i) (D.reversedSelectedAnnihilationFactor C S) :=
    orderedProduct_congr A (D.M - i) _ _ fun k hk1 hk => (hzS (D.M + 1 - k) (by omega)).symm
  -- r ≤ i - 1 なら i - r ≤ i - 1 なので α は S でも同じ
  have hα : α = D.initialReverseAnnihilationProduct C S (i - 1) :=
    orderedProduct_congr A (i - 1) _ _ fun r hr1 hr => (hzS (i - 1 + 1 - r) (by omega)).symm
  have hpass := D.initialReverseAnnihilationProduct_mul_annihilation C hneg (i := i) T (i - 1) le_rfl
  rw [Nat.sub_add_cancel hi.1] at hpass
  calc A.mul (D.reverseOrderedAnnihilationProduct C T) (D.annihilation C i)
      = A.mul (A.mul L (A.mul (D.selectedAnnihilationFactor C T i) α)) (D.annihilation C i) := by
        rw [D.reverseOrderedAnnihilationProduct_singleOut C hi T]
    _ = A.mul (A.mul L (A.mul A.one α)) (D.annihilation C i) := by rw [hzTi]
    _ = A.mul (A.mul L α) (D.annihilation C i) := by rw [A.one_mul α]
    _ = A.mul L (A.mul α (D.annihilation C i)) := A.mul_assoc _ _ _
    _ = A.mul L (A.smul (sign n (countBelow T i)) (A.mul (D.annihilation C i) α)) := by rw [hpass]
    _ = A.smul (sign n (countBelow T i)) (A.mul L (A.mul (D.annihilation C i) α)) :=
        (A.smul_mul_right _ _ _).symm
    _ = A.smul (sign n (countBelow T i)) (A.mul L (A.mul (D.selectedAnnihilationFactor C S i) α)) := by
        rw [hzSi]
    _ = A.smul (sign n (countBelow T i)) (D.reverseOrderedAnnihilationProduct C S) := by
        rw [D.reverseOrderedAnnihilationProduct_singleOut C hi S, hL, hα]
    _ = A.smul (sign n (countBelow T i)) (D.reverseOrderedAnnihilationProduct C (unionSingleton T i hi)) := rfl

/-- 本文 `claim_reverse_ordered_annihilation_product_times_annihilation_generator_with_index_is_zero` の必要十分版：
i ∈ T なら a_T ·_{Cl} a_i = 0_{Cl}。 -/
theorem reverseOrderedAnnihilationProduct_mul_annihilation_of_mem (hneg : ∀ a : K, a + -a = 0) {i : ℕ}
    (hi : 1 ≤ i ∧ i ≤ D.M) (T : PowerSet D.M) (hiT : i ∈ T.1) :
    ((D.space C).cliffordAlgebra C).mul (D.reverseOrderedAnnihilationProduct C T) (D.annihilation C i)
      = ((D.space C).cliffordAlgebra C).zero := by
  let A := (D.space C).cliffordAlgebra C
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  let L := AlgebraOver.orderedProduct A (D.M - i) (D.reversedSelectedAnnihilationFactor C T)
  let α := D.initialReverseAnnihilationProduct C T (i - 1)
  have hpass := D.initialReverseAnnihilationProduct_mul_annihilation C hneg (i := i) T (i - 1) le_rfl
  rw [Nat.sub_add_cancel hi.1] at hpass
  calc A.mul (D.reverseOrderedAnnihilationProduct C T) (D.annihilation C i)
      = A.mul (A.mul L (A.mul (D.selectedAnnihilationFactor C T i) α)) (D.annihilation C i) := by
        -- 本文の一行目（ž^T_p を取り出す）と二行目（ž^T_p = z^T_i）は共通の分解の補題が持つ
        rw [D.reverseOrderedAnnihilationProduct_singleOut C hi T]
    _ = A.mul (A.mul L (A.mul (D.annihilation C i) α)) (D.annihilation C i) := by
        rw [D.selectedAnnihilationFactor_of_mem C hiT]
    _ = A.mul L (A.mul (A.mul (D.annihilation C i) α) (D.annihilation C i)) := A.mul_assoc _ _ _
    _ = A.mul L (A.mul (D.annihilation C i) (A.mul α (D.annihilation C i))) := by
        rw [A.mul_assoc (D.annihilation C i) α (D.annihilation C i)]
    _ = A.mul L (A.mul (D.annihilation C i) (A.smul (sign n (countBelow T i)) (A.mul (D.annihilation C i) α))) := by
        rw [hpass]
    _ = A.mul L (A.smul (sign n (countBelow T i)) (A.mul (D.annihilation C i) (A.mul (D.annihilation C i) α))) := by
        rw [← A.smul_mul_right (sign n (countBelow T i)) (D.annihilation C i) (A.mul (D.annihilation C i) α)]
    _ = A.smul (sign n (countBelow T i)) (A.mul L (A.mul (D.annihilation C i) (A.mul (D.annihilation C i) α))) :=
        (A.smul_mul_right _ _ _).symm
    _ = A.smul (sign n (countBelow T i)) (A.mul L (A.mul (A.mul (D.annihilation C i) (D.annihilation C i)) α)) := by
        rw [A.mul_assoc (D.annihilation C i) (D.annihilation C i) α]
    _ = A.smul (sign n (countBelow T i)) (A.mul L (A.mul A.zero α)) := by rw [D.annihilation_mul_self C hneg i]
    _ = A.smul (sign n (countBelow T i)) (A.mul L A.zero) := by rw [zero_mul_eq_zero h00 A α]
    _ = A.smul (sign n (countBelow T i)) A.zero := by rw [mul_zero_eq_zero h00 A L]
    _ = A.zero := VectorSpace.smul_zero_eq_zero A.toVectorSpace h00 C.uniqueness.mul_zero _

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
