/-
章「同型の証明」の節「クリフォード代数から行列環への準同型」の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                                 このファイル
  claim_square_of_creation_operator_matrix_is_zero                                             creationMatrix_mul_self
  claim_square_of_annihilation_operator_matrix_is_zero                                         annihilationMatrix_mul_self
  def_matrix_valued_map_on_split_quadratic_space                                               creationFamily・annihilationFamily（c_k・c_k^T の族）・
                                                                                               creationPart（C(y)）・annihilationPart（D(h)）・
                                                                                               matrixValuedMap（φ）
  claim_matrix_valued_map_on_split_quadratic_space_is_linear_map                               matrixValuedMap_isLinearMap
  claim_square_of_matrix_valued_map_on_split_quadratic_space                                   matrixValuedMap_mul_self
  claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra       existsUnique_homomorphismToMatrix
  def_homomorphism_from_clifford_algebra_to_matrix_algebra                                     homomorphismToMatrix（Φ）・
                                                                                               homomorphismToMatrix_isHom・
                                                                                               homomorphismToMatrix_γ
  claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix    homomorphismToMatrix_creation
  claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix
                                                                                               homomorphismToMatrix_annihilation

表し方:
- 行列の添字集合は P_M（`PowerSet M`）、有限であることは `isFiniteSet_powerSet M`（証明の中では hX）、
  Mat_{P_M}(ℂ) の ℂ-代数は `matricesComplexAlgebra hX`（本文 claim_matrices_indexed_by_finite_set_form_complex_algebra。
  証明の中では B）、U_vec(B) は `B.toComplexVectorSpace`（証明の中では Bv）。
- 分裂した二次空間の前提は `Clifford.SplitData`（`CliffordAlgebra/SplitQuadraticSpace/Generators.lean`）で、M は `D.M`。
- 番号付けた族 k ↦ c_k、k ↦ c_k^T は、線型結合に渡すために `ℕ → Mat (PowerSet M)` の族 `creationFamily`・`annihilationFamily`
  で表す（{1,…,M} の外の値 0_{Mat} は使わない）。
- 本文の V の元 (x, g) は Lean の組 p（x = p.1、g = p.2）で、φ(p) は p.1・p.2 で書く。
- 本文の {1,…,M} の二元のクロネッカーのデルタ δ_{k,l}（生成と消滅の作用素の行列の反交換関係）は `Idx M` の二元のデルタで、
  線型結合からデルタで一項を取り出す主張（`linearCombination_kroneckerDelta`）は ℕ の二元のデルタを使う。
  本文の「k = l と l = k は同値なので δ の定義」の行は、この二つの読み替えを含めて `kroneckerDelta_idx_eq_swap` で書く。

必要十分版は `NecSuf/Isomorphism/HomomorphismToMatrixAlgebra/HomomorphismToMatrixAlgebra.lean`、
導出版は `HomomorphismToMatrixAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.Anticommutation
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Algebra
import CliffordMatrixIsomorphism.CliffordAlgebra.SplitQuadraticSpace.Generators
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebra

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.Clifford

universe u

noncomputable section

/-! ### 生成作用素の行列・消滅作用素の行列の自分自身との積 -/

/-- 本文 `claim_square_of_creation_operator_matrix_is_zero`：c_i ·_{Mat_{P_M}} c_i = 0_{Mat_{P_M}}。
成分 (S, U) を i ∈ U と i ∉ U で分け、右から生成作用素の行列を掛けた行列の成分の主張を A := c_i、j := i に当てる。 -/
theorem creationMatrix_mul_self {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) :
    Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (creationMatrix M i hi) = Mat.zero :=
  Mat.ext fun S U => by
    by_cases hiU : i ∈ U.1
    · calc Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (creationMatrix M i hi)) S U
          = 0 := (entry_mul_creationMatrix hi (creationMatrix M i hi) S U).2 hiU
        _ = Mat.entry (Mat.zero : Mat (PowerSet M)) S U := rfl
    · -- i ∈ U ∪ {i} なので、c_i の定義で列の添字を U ∪ {i} としたときの条件は成り立たない
      have hcond : ¬(i ∉ (unionSingleton U i hi).1 ∧ S = unionSingleton (unionSingleton U i hi) i hi) :=
        fun h => h.1 (self_mem_unionSingleton U i hi)
      calc Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (creationMatrix M i hi)) S U
          = Mat.entry (creationMatrix M i hi) S (unionSingleton U i hi) * sign (countBelow U i) :=
            (entry_mul_creationMatrix hi (creationMatrix M i hi) S U).1 hiU
        _ = 0 * sign (countBelow U i) := by rw [creationMatrix_entry_of_not_cond hi hcond]
        _ = 0 := zero_mul (sign (countBelow U i))
        _ = Mat.entry (Mat.zero : Mat (PowerSet M)) S U := rfl

/-- 本文 `claim_square_of_annihilation_operator_matrix_is_zero`：c_i^T ·_{Mat_{P_M}} c_i^T = 0_{Mat_{P_M}}。
準備で和の項を (c_i)_{U,T} ·_{ℂ^vec} (c_i)_{T,S} に書き直し、(U, S) 成分の c_i ·_{Mat} c_i に戻す。 -/
theorem annihilationMatrix_mul_self {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) :
    Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M i hi) (annihilationMatrix M i hi) = Mat.zero :=
  Mat.ext fun S U => by
    let V := complexNumbersVectorSpace
    let hX := isFiniteSet_powerSet M
    -- 準備：各 T で (c_i^T)_{S,T} ·_{ℂ^vec} (c_i^T)_{T,U} = (c_i)_{U,T} ·_{ℂ^vec} (c_i)_{T,S}
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry (annihilationMatrix M i hi) S T) (Mat.entry (annihilationMatrix M i hi) T U)
          = V.smul (Mat.entry (creationMatrix M i hi) U T) (Mat.entry (creationMatrix M i hi) T S) := fun T =>
      calc V.smul (Mat.entry (annihilationMatrix M i hi) S T) (Mat.entry (annihilationMatrix M i hi) T U)
          = Mat.entry (annihilationMatrix M i hi) S T * Mat.entry (annihilationMatrix M i hi) T U := rfl
        _ = Mat.entry (creationMatrix M i hi) T S * Mat.entry (creationMatrix M i hi) U T := by
            rw [annihilationMatrix_entry hi S T, annihilationMatrix_entry hi T U]
        _ = Mat.entry (creationMatrix M i hi) U T * Mat.entry (creationMatrix M i hi) T S :=
            mul_comm (Mat.entry (creationMatrix M i hi) T S) (Mat.entry (creationMatrix M i hi) U T)
        _ = V.smul (Mat.entry (creationMatrix M i hi) U T) (Mat.entry (creationMatrix M i hi) T S) := rfl
    calc Mat.entry (Mat.mul hX (annihilationMatrix M i hi) (annihilationMatrix M i hi)) S U
        = sumOverFiniteSet V hX (fun T => Mat.entry (annihilationMatrix M i hi) S T)
            (fun T => Mat.entry (annihilationMatrix M i hi) T U) := rfl
      _ = sumOverFiniteSet V hX (fun T => Mat.entry (creationMatrix M i hi) U T)
            (fun T => Mat.entry (creationMatrix M i hi) T S) :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = Mat.entry (Mat.mul hX (creationMatrix M i hi) (creationMatrix M i hi)) U S := rfl
      _ = Mat.entry (Mat.zero : Mat (PowerSet M)) U S := by rw [creationMatrix_mul_self hi]
      _ = 0 := rfl
      _ = Mat.entry (Mat.zero : Mat (PowerSet M)) S U := rfl

/-! ### 分裂した二次空間から行列環への写像 -/

/-- 本文 `def_matrix_valued_map_on_split_quadratic_space` の族 k ↦ c_k（k ∈ {1,…,M}。外の値 0_{Mat} は使わない）。 -/
def creationFamily (M : ℕ) (k : ℕ) : Mat (PowerSet M) :=
  if hk : 1 ≤ k ∧ k ≤ M then creationMatrix M k hk else Mat.zero

/-- 本文 `def_matrix_valued_map_on_split_quadratic_space` の族 k ↦ c_k^T（k ∈ {1,…,M}。外の値 0_{Mat} は使わない）。 -/
def annihilationFamily (M : ℕ) (k : ℕ) : Mat (PowerSet M) :=
  if hk : 1 ≤ k ∧ k ≤ M then annihilationMatrix M k hk else Mat.zero

theorem creationFamily_of_mem {M k : ℕ} (hk : 1 ≤ k ∧ k ≤ M) : creationFamily M k = creationMatrix M k hk :=
  dif_pos hk

theorem annihilationFamily_of_mem {M k : ℕ} (hk : 1 ≤ k ∧ k ≤ M) :
    annihilationFamily M k = annihilationMatrix M k hk :=
  dif_pos hk

/-- 本文の「k = l と l = k は同値なので δ の定義」：{1,…,M} の二元 k, l のデルタ δ_{k,l} は、ℕ の二元のデルタ δ_{l,k} に等しい。 -/
theorem kroneckerDelta_idx_eq_swap {M k l : ℕ} (hk : 1 ≤ k ∧ k ≤ M) (hl : 1 ≤ l ∧ l ≤ M) :
    kroneckerDelta (⟨k, hk⟩ : Idx M) (⟨l, hl⟩ : Idx M) = kroneckerDelta l k := by
  by_cases h : k = l
  · subst h
    rw [kroneckerDelta, kroneckerDelta, if_pos rfl, if_pos rfl]
  · have h' : (⟨k, hk⟩ : Idx M) ≠ ⟨l, hl⟩ := fun e => h (congrArg Subtype.val e)
    rw [kroneckerDelta, kroneckerDelta, if_neg h', if_neg (Ne.symm h)]

end

end CliffordMatrixIsomorphism.Isomorphism

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- Mat_{P_M}(ℂ) の ℂ-代数（本文 claim_matrices_indexed_by_finite_set_form_complex_algebra）。 -/
abbrev matrixAlgebra : ComplexAlgebra (Mat (PowerSet D.M)) := matricesComplexAlgebra (isFiniteSet_powerSet D.M)

/-- 本文 `claim_matrix_valued_map_on_split_quadratic_space_is_linear_map` の証明の C(y) := Σ_{k=1}^{M} β^w_k(y) ∗_B c_k。 -/
def creationPart (y : W) : Mat (PowerSet D.M) :=
  linearCombination D.matrixAlgebra.toComplexVectorSpace D.M (fun k => coordinate D.spaceW D.M D.w D.isBasis k y)
    (creationFamily D.M)

/-- 本文 `claim_matrix_valued_map_on_split_quadratic_space_is_linear_map` の証明の D(h) := Σ_{k=1}^{M} h(w_k) ∗_B c_k^T。 -/
def annihilationPart (h : DualSpace D.spaceW) : Mat (PowerSet D.M) :=
  linearCombination D.matrixAlgebra.toComplexVectorSpace D.M (fun k => h.1 (D.w k)) (annihilationFamily D.M)

/-- 本文 `def_matrix_valued_map_on_split_quadratic_space`：
φ((x, g)) := (Σ_{k=1}^{M} β^w_k(x) ∗ c_k) + (Σ_{k=1}^{M} g(w_k) ∗ c_k^T)。 -/
def matrixValuedMap (p : W × DualSpace D.spaceW) : Mat (PowerSet D.M) :=
  D.matrixAlgebra.add (D.creationPart p.1) (D.annihilationPart p.2)

/-- 本文 `claim_matrix_valued_map_on_split_quadratic_space_is_linear_map`：φ は V から U_vec(Mat_{P_M}(ℂ)) への線型写像。 -/
theorem matrixValuedMap_isLinearMap :
    IsComplexLinearMap D.space.space D.matrixAlgebra.toComplexVectorSpace D.matrixValuedMap := by
  let B := D.matrixAlgebra
  let Bv := B.toComplexVectorSpace
  let β := fun k => coordinate D.spaceW D.M D.w D.isBasis k
  -- 準備の四つの等式
  have hC_add : ∀ x x' : W, D.creationPart (D.spaceW.add x x')
      = B.add (D.creationPart x) (D.creationPart x') := fun x x' => calc
    D.creationPart (D.spaceW.add x x')
        = linearCombination Bv D.M (fun k => β k x + β k x') (creationFamily D.M) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun k hk1 hkM => by
            rw [(coordinate_isLinearForm D.spaceW D.M D.w D.isBasis k hk1 hkM).map_add x x']
    _ = B.add (D.creationPart x) (D.creationPart x') :=
          (linearCombination_add_of_same_family Bv D.M (creationFamily D.M) (fun k => β k x) (fun k => β k x')).symm
  have hD_add : ∀ g g' : DualSpace D.spaceW, D.annihilationPart ((dualSpaceVectorSpace D.spaceW).add g g')
      = B.add (D.annihilationPart g) (D.annihilationPart g') := fun g g' => calc
    D.annihilationPart ((dualSpaceVectorSpace D.spaceW).add g g')
        = linearCombination Bv D.M (fun k => g.1 (D.w k) + g'.1 (D.w k)) (annihilationFamily D.M) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun _ _ _ => rfl
    _ = B.add (D.annihilationPart g) (D.annihilationPart g') :=
          (linearCombination_add_of_same_family Bv D.M (annihilationFamily D.M) (fun k => g.1 (D.w k))
            (fun k => g'.1 (D.w k))).symm
  have hC_smul : ∀ (l : ℂ) (x : W), D.creationPart (D.spaceW.smul l x) = B.smul l (D.creationPart x) :=
    fun l x => calc
    D.creationPart (D.spaceW.smul l x)
        = linearCombination Bv D.M (fun k => l * β k x) (creationFamily D.M) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun k hk1 hkM => by
            rw [(coordinate_isLinearForm D.spaceW D.M D.w D.isBasis k hk1 hkM).map_smul l x]
    _ = B.smul l (D.creationPart x) :=
          (smul_linearCombination Bv D.M (creationFamily D.M) (fun k => β k x) l).symm
  have hD_smul : ∀ (l : ℂ) (g : DualSpace D.spaceW),
      D.annihilationPart ((dualSpaceVectorSpace D.spaceW).smul l g) = B.smul l (D.annihilationPart g) :=
    fun l g => calc
    D.annihilationPart ((dualSpaceVectorSpace D.spaceW).smul l g)
        = linearCombination Bv D.M (fun k => l * g.1 (D.w k)) (annihilationFamily D.M) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun _ _ _ => rfl
    _ = B.smul l (D.annihilationPart g) :=
          (smul_linearCombination Bv D.M (annihilationFamily D.M) (fun k => g.1 (D.w k)) l).symm
  refine ⟨fun p p' => ?_, fun l p => ?_⟩
  · -- 加法を保つこと
    calc D.matrixValuedMap (D.space.space.add p p')
        = D.matrixValuedMap (D.spaceW.add p.1 p'.1, (dualSpaceVectorSpace D.spaceW).add p.2 p'.2) := rfl
      _ = B.add (D.creationPart (D.spaceW.add p.1 p'.1))
            (D.annihilationPart ((dualSpaceVectorSpace D.spaceW).add p.2 p'.2)) := rfl
      _ = B.add (B.add (D.creationPart p.1) (D.creationPart p'.1))
            (D.annihilationPart ((dualSpaceVectorSpace D.spaceW).add p.2 p'.2)) := by rw [hC_add]
      _ = B.add (B.add (D.creationPart p.1) (D.creationPart p'.1))
            (B.add (D.annihilationPart p.2) (D.annihilationPart p'.2)) := by rw [hD_add]
      _ = B.add (D.creationPart p.1) (B.add (D.creationPart p'.1)
            (B.add (D.annihilationPart p.2) (D.annihilationPart p'.2))) := by
          rw [B.add_assoc (D.creationPart p.1) (D.creationPart p'.1)]
      _ = B.add (D.creationPart p.1) (B.add (B.add (D.creationPart p'.1) (D.annihilationPart p.2))
            (D.annihilationPart p'.2)) := by
          rw [B.add_assoc (D.creationPart p'.1) (D.annihilationPart p.2) (D.annihilationPart p'.2)]
      _ = B.add (D.creationPart p.1) (B.add (B.add (D.annihilationPart p.2) (D.creationPart p'.1))
            (D.annihilationPart p'.2)) := by
          rw [B.add_comm (D.creationPart p'.1) (D.annihilationPart p.2)]
      _ = B.add (D.creationPart p.1) (B.add (D.annihilationPart p.2)
            (B.add (D.creationPart p'.1) (D.annihilationPart p'.2))) := by
          rw [B.add_assoc (D.annihilationPart p.2) (D.creationPart p'.1) (D.annihilationPart p'.2)]
      _ = B.add (B.add (D.creationPart p.1) (D.annihilationPart p.2))
            (B.add (D.creationPart p'.1) (D.annihilationPart p'.2)) := by
          rw [← B.add_assoc (D.creationPart p.1) (D.annihilationPart p.2)]
      _ = B.add (D.matrixValuedMap p) (D.matrixValuedMap p') := rfl
  · -- スカラー倍を保つこと
    calc D.matrixValuedMap (D.space.space.smul l p)
        = D.matrixValuedMap (D.spaceW.smul l p.1, (dualSpaceVectorSpace D.spaceW).smul l p.2) := rfl
      _ = B.add (D.creationPart (D.spaceW.smul l p.1))
            (D.annihilationPart ((dualSpaceVectorSpace D.spaceW).smul l p.2)) := rfl
      _ = B.add (B.smul l (D.creationPart p.1))
            (D.annihilationPart ((dualSpaceVectorSpace D.spaceW).smul l p.2)) := by rw [hC_smul]
      _ = B.add (B.smul l (D.creationPart p.1)) (B.smul l (D.annihilationPart p.2)) := by rw [hD_smul]
      _ = B.smul l (B.add (D.creationPart p.1) (D.annihilationPart p.2)) :=
          (B.smul_add l (D.creationPart p.1) (D.annihilationPart p.2)).symm
      _ = B.smul l (D.matrixValuedMap p) := rfl

/-- 本文 `claim_square_of_matrix_valued_map_on_split_quadratic_space`：φ(v) ·_{Mat} φ(v) = q(v) ∗_{Mat} 1_{Mat}。 -/
theorem matrixValuedMap_mul_self (p : W × DualSpace D.spaceW) :
    D.matrixAlgebra.mul (D.matrixValuedMap p) (D.matrixValuedMap p)
      = D.matrixAlgebra.smul (D.space.form p) D.matrixAlgebra.one := by
  let B := D.matrixAlgebra
  let Bv := B.toComplexVectorSpace
  let x := p.1
  let g := p.2
  let lam : ℕ → ℂ := fun k => coordinate D.spaceW D.M D.w D.isBasis k x
  let mu : ℕ → ℂ := fun k => g.1 (D.w k)
  let C := linearCombination Bv D.M lam (creationFamily D.M)
  let E := linearCombination Bv D.M mu (annihilationFamily D.M)
  -- 準備の一つ目：C ·_B C = 0_B
  have h1 : B.mul C C = B.zero :=
    square_linearCombination_eq_zero B D.M lam (creationFamily D.M)
      (fun k hk1 hkM => by
        rw [creationFamily_of_mem ⟨hk1, hkM⟩]
        exact creationMatrix_mul_self ⟨hk1, hkM⟩)
      (fun k l hk1 hkM hl1 hlM _ => by
        rw [creationFamily_of_mem ⟨hk1, hkM⟩, creationFamily_of_mem ⟨hl1, hlM⟩]
        exact creationMatrices_anticommute ⟨hk1, hkM⟩ ⟨hl1, hlM⟩)
  -- 準備の二つ目：D ·_B D = 0_B
  have h2 : B.mul E E = B.zero :=
    square_linearCombination_eq_zero B D.M mu (annihilationFamily D.M)
      (fun k hk1 hkM => by
        rw [annihilationFamily_of_mem ⟨hk1, hkM⟩]
        exact annihilationMatrix_mul_self ⟨hk1, hkM⟩)
      (fun k l hk1 hkM hl1 hlM _ => by
        rw [annihilationFamily_of_mem ⟨hk1, hkM⟩, annihilationFamily_of_mem ⟨hl1, hlM⟩]
        exact annihilationMatrices_anticommute ⟨hk1, hkM⟩ ⟨hl1, hlM⟩)
  -- 準備の三つ目：各 k で c_k ·_B D +_B D ·_B c_k = μ_k ∗_B 1_B
  have h3 : ∀ k : ℕ, 1 ≤ k → k ≤ D.M →
      B.add (B.mul (creationFamily D.M k) E) (B.mul E (creationFamily D.M k)) = B.smul (mu k) B.one := by
    intro k hk1 hkM
    have hk : 1 ≤ k ∧ k ≤ D.M := ⟨hk1, hkM⟩
    -- 項の二つの等式
    have hterm1 : ∀ l : ℕ, (hl : 1 ≤ l ∧ l ≤ D.M) →
        B.add (B.mul (annihilationFamily D.M l) (creationFamily D.M k))
            (B.mul (creationFamily D.M k) (annihilationFamily D.M l))
          = B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) B.one := by
      intro l ⟨hl1, hlM⟩
      rw [annihilationFamily_of_mem ⟨hl1, hlM⟩, creationFamily_of_mem hk]
      calc B.add (B.mul (annihilationMatrix D.M l ⟨hl1, hlM⟩) (creationMatrix D.M k hk))
            (B.mul (creationMatrix D.M k hk) (annihilationMatrix D.M l ⟨hl1, hlM⟩))
          = B.add (B.mul (creationMatrix D.M k hk) (annihilationMatrix D.M l ⟨hl1, hlM⟩))
              (B.mul (annihilationMatrix D.M l ⟨hl1, hlM⟩) (creationMatrix D.M k hk)) :=
            B.add_comm _ _
        _ = B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, ⟨hl1, hlM⟩⟩ : Idx D.M)) B.one :=
            creationMatrix_annihilationMatrix_anticommute hk ⟨hl1, hlM⟩
    have hterm2 : ∀ l : ℕ, (hl : 1 ≤ l ∧ l ≤ D.M) →
        B.smul (mu l) (B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) B.one)
          = B.smul (kroneckerDelta l k) (B.smul (mu l) B.one) := by
      intro l hl
      calc B.smul (mu l) (B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) B.one)
          = B.smul (mu l * kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) B.one :=
            (B.smul_assoc _ _ _).symm
        _ = B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M) * mu l) B.one := by
            rw [mul_comm (mu l)]
        _ = B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) (B.smul (mu l) B.one) :=
            B.smul_assoc _ _ _
        _ = B.smul (kroneckerDelta l k) (B.smul (mu l) B.one) := by rw [kroneckerDelta_idx_eq_swap hk hl]
    calc B.add (B.mul (creationFamily D.M k) E) (B.mul E (creationFamily D.M k))
        = B.add (B.mul E (creationFamily D.M k)) (B.mul (creationFamily D.M k) E) := B.add_comm _ _
      _ = linearCombination Bv D.M mu (fun l => B.add (B.mul (annihilationFamily D.M l) (creationFamily D.M k))
            (B.mul (creationFamily D.M k) (annihilationFamily D.M l))) :=
          anticommutator_linearCombination B (creationFamily D.M k) D.M mu (annihilationFamily D.M)
      _ = linearCombination Bv D.M mu (fun l => if hl : 1 ≤ l ∧ l ≤ D.M then
            B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) B.one else B.zero) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun l hl1 hlM => by
            rw [dif_pos ⟨hl1, hlM⟩, hterm1 l ⟨hl1, hlM⟩]
      _ = linearCombination Bv D.M (fun l => kroneckerDelta l k) (fun l => B.smul (mu l) B.one) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun l hl1 hlM => by
            show B.smul (mu l) _ = B.smul _ _
            rw [dif_pos ⟨hl1, hlM⟩]
            exact hterm2 l ⟨hl1, hlM⟩
      _ = B.smul (mu k) B.one := linearCombination_kroneckerDelta Bv D.M _ k hk1 hkM
  -- 準備の四つ目：C ·_B D +_B D ·_B C = Σ λ_k ∗_B (μ_k ∗_B 1_B)
  have h4 : B.add (B.mul C E) (B.mul E C)
      = linearCombination Bv D.M lam (fun k => B.smul (mu k) B.one) := calc
    B.add (B.mul C E) (B.mul E C)
        = linearCombination Bv D.M lam (fun k => B.add (B.mul (creationFamily D.M k) E)
            (B.mul E (creationFamily D.M k))) :=
          anticommutator_linearCombination B E D.M lam (creationFamily D.M)
    _ = linearCombination Bv D.M lam (fun k => B.smul (mu k) B.one) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun k hk1 hkM => by rw [h3 k hk1 hkM]
  -- 準備の五つ目：g(x) ∗_B 1_B = Σ λ_k ∗_B (μ_k ∗_B 1_B)
  let h : W → Mat (PowerSet D.M) := fun y => B.smul (g.1 y) B.one
  have hh : IsComplexLinearMap D.spaceW Bv h :=
    ⟨fun y y' => calc
        h (D.spaceW.add y y') = B.smul (g.1 (D.spaceW.add y y')) B.one := rfl
        _ = B.smul (g.1 y + g.1 y') B.one := by rw [g.2.map_add y y']
        _ = B.add (B.smul (g.1 y) B.one) (B.smul (g.1 y') B.one) := B.add_smul _ _ _
        _ = B.add (h y) (h y') := rfl,
     fun ρ y => calc
        h (D.spaceW.smul ρ y) = B.smul (g.1 (D.spaceW.smul ρ y)) B.one := rfl
        _ = B.smul (ρ * g.1 y) B.one := by rw [g.2.map_smul ρ y]
        _ = B.smul ρ (B.smul (g.1 y) B.one) := B.smul_assoc _ _ _
        _ = B.smul ρ (h y) := rfl⟩
  have h5 : B.smul (g.1 x) B.one = linearCombination Bv D.M lam (fun k => B.smul (mu k) B.one) := calc
    B.smul (g.1 x) B.one = h x := rfl
    _ = h (linearCombination D.spaceW D.M (fun k => coordinate D.spaceW D.M D.w D.isBasis k x) D.w) := by
        rw [linearCombination_coordinate D.spaceW D.M D.w D.isBasis x]
    _ = linearCombination Bv D.M (fun k => coordinate D.spaceW D.M D.w D.isBasis k x) (fun k => h (D.w k)) :=
        hh.map_linearCombination D.M _ D.w
    _ = linearCombination Bv D.M lam (fun k => B.smul (mu k) B.one) := rfl
  -- 本題
  calc B.mul (D.matrixValuedMap p) (D.matrixValuedMap p)
      = B.mul (B.add C E) (B.add C E) := rfl
    _ = B.add (B.mul C (B.add C E)) (B.mul E (B.add C E)) := B.right_distrib C E (B.add C E)
    _ = B.add (B.add (B.mul C C) (B.mul C E)) (B.add (B.mul E C) (B.mul E E)) := by
        rw [B.left_distrib C C E, B.left_distrib E C E]
    _ = B.add (B.add B.zero (B.mul C E)) (B.add (B.mul E C) (B.mul E E)) := by rw [h1]
    _ = B.add (B.add B.zero (B.mul C E)) (B.add (B.mul E C) B.zero) := by rw [h2]
    _ = B.add (B.add (B.mul C E) B.zero) (B.add (B.mul E C) B.zero) := by rw [B.add_comm B.zero (B.mul C E)]
    _ = B.add (B.mul C E) (B.mul E C) := by rw [B.add_zero (B.mul C E), B.add_zero (B.mul E C)]
    _ = linearCombination Bv D.M lam (fun k => B.smul (mu k) B.one) := h4
    _ = B.smul (g.1 x) B.one := h5.symm
    _ = B.smul (splitQuadraticForm D.spaceW (x, g)) B.one := rfl
    _ = B.smul (D.space.form p) B.one := rfl

/-! ### クリフォード代数から行列環への準同型 -/

/-- 本文 `claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra`：
Φ ∘ γ = φ を満たす ℂ-代数の準同型 Φ : Cl(V,q) → Mat_{P_M}(ℂ) がただ一つ存在する。
クリフォード代数の普遍性を A := Mat_{P_M}(ℂ)、線型写像 φ に当てる。 -/
theorem existsUnique_homomorphismToMatrix :
    ∃ Φ : D.space.Cl → Mat (PowerSet D.M),
      (IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.matrixAlgebra Φ ∧
        ∀ v, Φ (D.space.γ v) = D.matrixValuedMap v) ∧
      ∀ Φ' : D.space.Cl → Mat (PowerSet D.M),
        (IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.matrixAlgebra Φ' ∧
          ∀ v, Φ' (D.space.γ v) = D.matrixValuedMap v) → Φ' = Φ :=
  D.space.universalProperty D.matrixAlgebra D.matrixValuedMap D.matrixValuedMap_isLinearMap
    D.matrixValuedMap_mul_self

/-- 本文 `def_homomorphism_from_clifford_algebra_to_matrix_algebra`：存在と一意性の主張のただ一つの準同型 Φ。 -/
def homomorphismToMatrix : D.space.Cl → Mat (PowerSet D.M) :=
  Classical.choose D.existsUnique_homomorphismToMatrix

/-- 本文 `def_homomorphism_from_clifford_algebra_to_matrix_algebra`：Φ は ℂ-代数の準同型である。 -/
theorem homomorphismToMatrix_isHom :
    IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.matrixAlgebra D.homomorphismToMatrix :=
  (Classical.choose_spec D.existsUnique_homomorphismToMatrix).1.1

/-- 本文 `def_homomorphism_from_clifford_algebra_to_matrix_algebra`：Φ ∘ γ = φ。 -/
theorem homomorphismToMatrix_γ (v : W × DualSpace D.spaceW) :
    D.homomorphismToMatrix (D.space.γ v) = D.matrixValuedMap v :=
  (Classical.choose_spec D.existsUnique_homomorphismToMatrix).1.2 v

/-- 本文 `claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix`：Φ(a†_i) = c_i。 -/
theorem homomorphismToMatrix_creation {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.homomorphismToMatrix (D.creation i) = creationMatrix D.M i hi := by
  let B := D.matrixAlgebra
  let Bv := B.toComplexVectorSpace
  -- 準備の一つ目：β^w_k(w_i) ∗_B c_k = δ_{k,i} ∗_B c_k
  have hprep1 : ∀ k : ℕ, 1 ≤ k → k ≤ D.M →
      Bv.smul (coordinate D.spaceW D.M D.w D.isBasis k (D.w i)) (creationFamily D.M k)
        = Bv.smul (kroneckerDelta k i) (creationFamily D.M k) := fun k hk1 hkM => by
    have hdual := coordinateFamily_isDualBasis D.spaceW D.M D.w D.isBasis k i hk1 hkM hi.1 hi.2
    rw [coordinateFamily, dif_pos ⟨hk1, hkM⟩] at hdual
    exact congrArg (fun c => Bv.smul c (creationFamily D.M k)) hdual
  -- 準備の二つ目：0_{W^*}(w_k) ∗_B c_k^T = 0_B
  have hprep2 : ∀ k : ℕ, 1 ≤ k → k ≤ D.M →
      Bv.smul ((DualSpace.zero D.spaceW).1 (D.w k)) (annihilationFamily D.M k) = Bv.zero := fun k _ _ => calc
    Bv.smul ((DualSpace.zero D.spaceW).1 (D.w k)) (annihilationFamily D.M k)
        = Bv.smul (zeroMap (D.w k)) (annihilationFamily D.M k) := rfl
    _ = Bv.smul 0 (annihilationFamily D.M k) := rfl
    _ = Bv.zero := ComplexVectorSpace.zero_smul_eq_zero Bv (annihilationFamily D.M k)
  calc D.homomorphismToMatrix (D.creation i)
      = D.homomorphismToMatrix (D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i))) := rfl
    _ = D.matrixValuedMap (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i)) := D.homomorphismToMatrix_γ _
    _ = D.matrixValuedMap (D.w i, DualSpace.zero D.spaceW) := rfl
    _ = B.add (linearCombination Bv D.M (fun k => coordinate D.spaceW D.M D.w D.isBasis k (D.w i))
            (creationFamily D.M))
          (linearCombination Bv D.M (fun k => (DualSpace.zero D.spaceW).1 (D.w k)) (annihilationFamily D.M)) := rfl
    _ = B.add (linearCombination Bv D.M (fun k => kroneckerDelta k i) (creationFamily D.M))
          (linearCombination Bv D.M (fun k => (DualSpace.zero D.spaceW).1 (D.w k)) (annihilationFamily D.M)) := by
        rw [linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ hprep1]
    _ = B.add (creationFamily D.M i)
          (linearCombination Bv D.M (fun k => (DualSpace.zero D.spaceW).1 (D.w k)) (annihilationFamily D.M)) := by
        rw [linearCombination_kroneckerDelta Bv D.M (creationFamily D.M) i hi.1 hi.2]
    _ = B.add (creationFamily D.M i) B.zero := by
        rw [linearCombination_eq_zero_of_terms_eq_zero Bv D.M _ _ hprep2]; rfl
    _ = creationFamily D.M i := B.add_zero _
    _ = creationMatrix D.M i hi := creationFamily_of_mem hi

/-- 本文 `claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix`：Φ(a_i) = c_i^T。 -/
theorem homomorphismToMatrix_annihilation {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.homomorphismToMatrix (D.annihilation i) = annihilationMatrix D.M i hi := by
  let B := D.matrixAlgebra
  let Bv := B.toComplexVectorSpace
  -- 準備の一つ目：β^w_k(0_W) ∗_B c_k = 0_B
  have hprep1 : ∀ k : ℕ, 1 ≤ k → k ≤ D.M →
      Bv.smul (coordinate D.spaceW D.M D.w D.isBasis k D.spaceW.zero) (creationFamily D.M k) = Bv.zero :=
    fun k hk1 hkM => calc
    Bv.smul (coordinate D.spaceW D.M D.w D.isBasis k D.spaceW.zero) (creationFamily D.M k)
        = Bv.smul 0 (creationFamily D.M k) := by
          rw [(coordinate_isLinearForm D.spaceW D.M D.w D.isBasis k hk1 hkM).map_zero]
    _ = Bv.zero := ComplexVectorSpace.zero_smul_eq_zero Bv (creationFamily D.M k)
  -- 準備の二つ目：f_i(w_k) ∗_B c_k^T = δ_{k,i} ∗_B c_k^T
  have hprep2 : ∀ k : ℕ, 1 ≤ k → k ≤ D.M →
      Bv.smul ((D.f i).1 (D.w k)) (annihilationFamily D.M k)
        = Bv.smul (kroneckerDelta k i) (annihilationFamily D.M k) := fun k hk1 hkM => calc
    Bv.smul ((D.f i).1 (D.w k)) (annihilationFamily D.M k)
        = Bv.smul (kroneckerDelta i k) (annihilationFamily D.M k) := by
          rw [D.isDualBasis i k hi.1 hi.2 hk1 hkM]
    _ = Bv.smul (kroneckerDelta k i) (annihilationFamily D.M k) := by
          by_cases hik : i = k
          · rw [kroneckerDelta, kroneckerDelta, if_pos hik, if_pos hik.symm]
          · rw [kroneckerDelta, kroneckerDelta, if_neg hik, if_neg (Ne.symm hik)]
  calc D.homomorphismToMatrix (D.annihilation i)
      = D.homomorphismToMatrix (D.space.γ (embedSecond D.spaceW (D.f i))) := rfl
    _ = D.matrixValuedMap (embedSecond D.spaceW (D.f i)) := D.homomorphismToMatrix_γ _
    _ = D.matrixValuedMap (D.spaceW.zero, D.f i) := rfl
    _ = B.add (linearCombination Bv D.M (fun k => coordinate D.spaceW D.M D.w D.isBasis k D.spaceW.zero)
            (creationFamily D.M))
          (linearCombination Bv D.M (fun k => (D.f i).1 (D.w k)) (annihilationFamily D.M)) := rfl
    _ = B.add B.zero (linearCombination Bv D.M (fun k => (D.f i).1 (D.w k)) (annihilationFamily D.M)) := by
        rw [linearCombination_eq_zero_of_terms_eq_zero Bv D.M _ _ hprep1]; rfl
    _ = B.add B.zero (linearCombination Bv D.M (fun k => kroneckerDelta k i) (annihilationFamily D.M)) := by
        rw [linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ hprep2]
    _ = B.add B.zero (annihilationFamily D.M i) := by
        rw [linearCombination_kroneckerDelta Bv D.M (annihilationFamily D.M) i hi.1 hi.2]
    _ = B.add (annihilationFamily D.M i) B.zero := B.add_comm _ _
    _ = annihilationFamily D.M i := B.add_zero _
    _ = annihilationMatrix D.M i hi := annihilationFamily_of_mem hi

end

end CliffordMatrixIsomorphism.Clifford.SplitData
