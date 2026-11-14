/-
章「同型の証明」の節「クリフォード代数から行列環への準同型」の必要十分版。具体版
`Isomorphism/HomomorphismToMatrixAlgebra/HomomorphismToMatrixAlgebra.lean` と同じ def と同じ calc の行のまま、
係数 ℂ を型の変数 K に、-1_ℂ を K の元 n に替える（ς は `sign n`、c_i・c_i^T は `creationMatrix n`・`annihilationMatrix n`）。
K には演算の記号 +・·・0・1・- だけを与え、使う性質は仮定として渡す。

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

主張ごとに使う K の性質（L : `ValuedMapsLaws K` は積 `Mat.mul L hX` を定めるのに要る八つ）:
  c_i · c_i = 0                       L・a · 1 = a・a · 0 = 0・0 · a = 0（右から生成作用素の行列を掛けた成分の主張と、0 · ς = 0 の行）
  c_i^T · c_i^T = 0                   上の性質・乗法の結合法則と 1 · a = a（L。成分 (c_i)_{T,S}・(c_i)_{U,T} の入れ替え）
  φ（定義）と φ が線型                章「クリフォード代数」の仮定 `CliffordLaws K n`（V := W ⊕ W^* と行列環を作るため）。
                                      行の中で使うのは、座標 β^w_k が線型形式であること（係数の一意性 `UniquenessLaws`）と、
                                      和のスカラー倍に要る 0 + 0 = 0・a · 0 = 0 だけ
  φ(v)² = q(v) ∗ 1                    `CliffordLaws K n` だけ（n についての性質も、その欄から出る `CliffordLaws.signLaws`）
  Φ の存在と一意性・Φ の定義          `CliffordLaws K n` と a + (-a) = 0（hneg。クリフォード代数の普遍性の必要十分版の仮定）
  Φ(a†_i) = c_i、Φ(a_i) = c_i^T       Φ の定義の仮定のほかに足さない

分かったこと:
- 行列環の n（ς を定める元）と、クリフォード代数の合同に使う n（1 + n = 0）は同じ K の元でよく、ς についての性質
  `SignLaws K n` は、どの欄も `CliffordLaws K n` の欄から出る（`CliffordLaws.signLaws`）。したがって φ(v)² = q(v) ∗ 1 は
  章「クリフォード代数」の仮定のほかに K の性質を足さない。
- 行列の集合を K の上の代数にするには乗法の交換法則が要る（行列の積の結合法則）。`CliffordLaws` の欄 mul_comm をそのまま渡す。
  反交換関係の主張の中の行（ς の値どうしの交換、δ との交換）は乗法の交換法則を使わないが、主張が代数の中の積と和で
  書かれているので、代数を作る段階で交換法則が入る。φ(v)² の計算の μ_l · δ = δ · μ_l の行も、δ の値が 0 か 1 なので
  0 と 1 の交換だけで足りるが、代数がすでに交換法則を持つので同じ行で mul_comm を当てる。
- a + (-a) = 0 が要るのは、Φ を普遍性から得る段だけである。c_i · c_i = 0・c_i^T · c_i^T = 0・φ が線型・φ(v)² = q(v) ∗ 1 は使わない。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない（M = 0 でも同じ証明が通る）。

`SplitData.space` が作る V := W ⊕ W^* の組は q が二次形式であることを持たない（`NecSuf/CliffordAlgebra/SplitQuadraticSpace/Generators.lean`）。
導出版は `Isomorphism/HomomorphismToMatrixAlgebra/HomomorphismToMatrixAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.CreationOperatorMatrices.Anticommutation
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Algebra
import CliffordMatrixIsomorphism.NecSuf.CliffordAlgebra.SplitQuadraticSpace.Generators
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebra

namespace CliffordMatrixIsomorphism.NecSuf.Isomorphism

open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet)
open CliffordMatrixIsomorphism.Isomorphism (countBelow unionSingleton self_mem_unionSingleton)

universe uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K]

noncomputable section

/-! ### 生成作用素の行列・消滅作用素の行列の自分自身との積 -/

/-- 本文 `claim_square_of_creation_operator_matrix_is_zero` の必要十分版：c_i ·_{Mat_{P_M}} c_i = 0_{Mat_{P_M}}。 -/
theorem creationMatrix_mul_self (L : ValuedMapsLaws K) (hmul1 : ∀ a : K, a * 1 = a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0) (n : K) {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) :
    Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M i hi) (creationMatrix n M i hi) = Mat.zero :=
  Mat.ext fun S U => by
    by_cases hiU : i ∈ U.1
    · calc Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M i hi) (creationMatrix n M i hi)) S U
          = 0 := (entry_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi (creationMatrix n M i hi) S U).2 hiU
        _ = Mat.entry (Mat.zero : Mat K (PowerSet M)) S U := rfl
    · -- i ∈ U ∪ {i} なので、c_i の定義で列の添字を U ∪ {i} としたときの条件は成り立たない
      have hcond : ¬(i ∉ (unionSingleton U i hi).1 ∧ S = unionSingleton (unionSingleton U i hi) i hi) :=
        fun h => h.1 (self_mem_unionSingleton U i hi)
      calc Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M i hi) (creationMatrix n M i hi)) S U
          = Mat.entry (creationMatrix n M i hi) S (unionSingleton U i hi) * sign n (countBelow U i) :=
            (entry_mul_creationMatrix L hmul1 hmul0 hzero_mul n hi (creationMatrix n M i hi) S U).1 hiU
        _ = 0 * sign n (countBelow U i) := by rw [creationMatrix_entry_of_not_cond n hi hcond]
        _ = 0 := hzero_mul (sign n (countBelow U i))
        _ = Mat.entry (Mat.zero : Mat K (PowerSet M)) S U := rfl

/-- 本文 `claim_square_of_annihilation_operator_matrix_is_zero` の必要十分版：c_i^T ·_{Mat_{P_M}} c_i^T = 0_{Mat_{P_M}}。
具体版の ℂ の乗法の交換法則の行は、成分の値が ς の値か 0 なので `creationMatrix_entries_comm`（乗法の結合法則・1 · a = a・
a · 0 = 0・0 · a = 0）で書く。 -/
theorem annihilationMatrix_mul_self (L : ValuedMapsLaws K) (hmul1 : ∀ a : K, a * 1 = a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0) (n : K) {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) :
    Mat.mul L (isFiniteSet_powerSet M) (annihilationMatrix n M i hi) (annihilationMatrix n M i hi) = Mat.zero :=
  Mat.ext fun S U => by
    let V := coefficientsVec L
    let hX := isFiniteSet_powerSet M
    -- 準備：各 T で (c_i^T)_{S,T} ·_{K^vec} (c_i^T)_{T,U} = (c_i)_{U,T} ·_{K^vec} (c_i)_{T,S}
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry (annihilationMatrix n M i hi) S T) (Mat.entry (annihilationMatrix n M i hi) T U)
          = V.smul (Mat.entry (creationMatrix n M i hi) U T) (Mat.entry (creationMatrix n M i hi) T S) := fun T =>
      calc V.smul (Mat.entry (annihilationMatrix n M i hi) S T) (Mat.entry (annihilationMatrix n M i hi) T U)
          = Mat.entry (annihilationMatrix n M i hi) S T * Mat.entry (annihilationMatrix n M i hi) T U := rfl
        _ = Mat.entry (creationMatrix n M i hi) T S * Mat.entry (creationMatrix n M i hi) U T := by
            rw [annihilationMatrix_entry n hi S T, annihilationMatrix_entry n hi T U]
        _ = Mat.entry (creationMatrix n M i hi) U T * Mat.entry (creationMatrix n M i hi) T S :=
            creationMatrix_entries_comm hmul0 hzero_mul L.mul_assoc L.one_mul n hi hi T S U
        _ = V.smul (Mat.entry (creationMatrix n M i hi) U T) (Mat.entry (creationMatrix n M i hi) T S) := rfl
    calc Mat.entry (Mat.mul L hX (annihilationMatrix n M i hi) (annihilationMatrix n M i hi)) S U
        = sumOverFiniteSet V hX (fun T => Mat.entry (annihilationMatrix n M i hi) S T)
            (fun T => Mat.entry (annihilationMatrix n M i hi) T U) := rfl
      _ = sumOverFiniteSet V hX (fun T => Mat.entry (creationMatrix n M i hi) U T)
            (fun T => Mat.entry (creationMatrix n M i hi) T S) :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = Mat.entry (Mat.mul L hX (creationMatrix n M i hi) (creationMatrix n M i hi)) U S := rfl
      _ = Mat.entry (Mat.zero : Mat K (PowerSet M)) U S := by
          rw [creationMatrix_mul_self L hmul1 hmul0 hzero_mul n hi]
      _ = 0 := rfl
      _ = Mat.entry (Mat.zero : Mat K (PowerSet M)) S U := rfl

/-! ### 分裂した二次空間から行列環への写像 -/

/-- 本文 `def_matrix_valued_map_on_split_quadratic_space` の族 k ↦ c_k の必要十分版（{1,…,M} の外の値 0 は使わない）。 -/
def creationFamily (n : K) (M : ℕ) (k : ℕ) : Mat K (PowerSet M) :=
  if hk : 1 ≤ k ∧ k ≤ M then creationMatrix n M k hk else Mat.zero

/-- 本文 `def_matrix_valued_map_on_split_quadratic_space` の族 k ↦ c_k^T の必要十分版（{1,…,M} の外の値 0 は使わない）。 -/
def annihilationFamily (n : K) (M : ℕ) (k : ℕ) : Mat K (PowerSet M) :=
  if hk : 1 ≤ k ∧ k ≤ M then annihilationMatrix n M k hk else Mat.zero

omit [Add K] in
theorem creationFamily_of_mem (n : K) {M k : ℕ} (hk : 1 ≤ k ∧ k ≤ M) :
    creationFamily n M k = creationMatrix n M k hk :=
  dif_pos hk

omit [Add K] in
theorem annihilationFamily_of_mem (n : K) {M k : ℕ} (hk : 1 ≤ k ∧ k ≤ M) :
    annihilationFamily n M k = annihilationMatrix n M k hk :=
  dif_pos hk

omit [Add K] [Mul K] in
/-- 本文の「k = l と l = k は同値なので δ の定義」の必要十分版：{1,…,M} の二元 k, l のデルタ δ_{k,l} は、
ℕ の二元のデルタ δ_{l,k} に等しい。 -/
theorem kroneckerDelta_idx_eq_swap {M k l : ℕ} (hk : 1 ≤ k ∧ k ≤ M) (hl : 1 ≤ l ∧ l ≤ M) :
    (kroneckerDelta (⟨k, hk⟩ : Idx M) (⟨l, hl⟩ : Idx M) : K) = kroneckerDelta l k := by
  by_cases h : k = l
  · subst h
    rw [kroneckerDelta, kroneckerDelta, if_pos rfl, if_pos rfl]
  · have h' : (⟨k, hk⟩ : Idx M) ≠ ⟨l, hl⟩ := fun e => h (congrArg Subtype.val e)
    rw [kroneckerDelta, kroneckerDelta, if_neg h', if_neg (Ne.symm h)]

end

end CliffordMatrixIsomorphism.NecSuf.Isomorphism

namespace CliffordMatrixIsomorphism.NecSuf.Clifford

open CliffordMatrixIsomorphism.NecSuf.Isomorphism

universe uK

/-- ς についての性質 `SignLaws K n` は、どの欄も章「クリフォード代数」の仮定 `CliffordLaws K n` の欄から出る。 -/
theorem CliffordLaws.signLaws {K : Type uK} [Add K] [Mul K] [One K] [Zero K] {n : K} (C : CliffordLaws K n) :
    SignLaws K n where
  one_add_n := C.congruence.one_add_n
  n_mul_one := C.mul_one n
  mul_add_n := C.valuedMaps.left_distrib n n 1
  n_add_one := C.congruence.n_add_one
  n_mul_zero := C.uniqueness.mul_zero n
  add_zero_nn := C.uniqueness.add_zero (n * n)
  add_assoc_nn := (C.uniqueness.add_assoc (n * n) n 1).symm
  zero_add_one := C.uniqueness.zero_add 1
  one_mul_one := C.uniqueness.one_mul 1
  mul_assoc := C.valuedMaps.mul_assoc
  mul_n_comm := fun x => C.mul_comm x n

end CliffordMatrixIsomorphism.NecSuf.Clifford

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.Isomorphism
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet)

universe u uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-- Mat_{P_M}(K) の K の上の代数（本文 claim_matrices_indexed_by_finite_set_form_complex_algebra の必要十分版）。
代数にするのに要る K の性質は、章「クリフォード代数」の仮定の欄から渡す。 -/
abbrev matrixAlgebra : AlgebraOver K (Mat K (PowerSet D.M)) :=
  matricesAlgebra C.valuedMaps C.mul_comm C.uniqueness.mul_zero (isFiniteSet_powerSet D.M)

/-- 本文 `claim_matrix_valued_map_on_split_quadratic_space_is_linear_map` の証明の C(y) := Σ_{k=1}^{M} β^w_k(y) ∗_B c_k の必要十分版。 -/
def creationPart (y : W) : Mat K (PowerSet D.M) :=
  linearCombination (D.matrixAlgebra C).toVectorSpace D.M (fun k => coordinate D.spaceW D.M D.w D.isBasis k y)
    (creationFamily n D.M)

/-- 本文 `claim_matrix_valued_map_on_split_quadratic_space_is_linear_map` の証明の D(h) := Σ_{k=1}^{M} h(w_k) ∗_B c_k^T の必要十分版。 -/
def annihilationPart (h : DualSpace D.spaceW) : Mat K (PowerSet D.M) :=
  linearCombination (D.matrixAlgebra C).toVectorSpace D.M (fun k => h.1 (D.w k)) (annihilationFamily n D.M)

/-- 本文 `def_matrix_valued_map_on_split_quadratic_space` の必要十分版：
φ((x, g)) := (Σ_{k=1}^{M} β^w_k(x) ∗ c_k) + (Σ_{k=1}^{M} g(w_k) ∗ c_k^T)。 -/
def matrixValuedMap (p : W × DualSpace D.spaceW) : Mat K (PowerSet D.M) :=
  (D.matrixAlgebra C).add (D.creationPart C p.1) (D.annihilationPart C p.2)

omit [Neg K] in
/-- 本文 `claim_matrix_valued_map_on_split_quadratic_space_is_linear_map` の必要十分版：φ は V から U_vec(Mat_{P_M}(K)) への線型写像。 -/
theorem matrixValuedMap_isLinearMap :
    IsLinearMap (D.space C).space (D.matrixAlgebra C).toVectorSpace (D.matrixValuedMap C) := by
  let B := D.matrixAlgebra C
  let Bv := B.toVectorSpace
  let β := fun k => coordinate D.spaceW D.M D.w D.isBasis k
  let SWd := dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW
  -- 準備の四つの等式
  have hC_add : ∀ x x' : W, D.creationPart C (D.spaceW.add x x')
      = B.add (D.creationPart C x) (D.creationPart C x') := fun x x' => calc
    D.creationPart C (D.spaceW.add x x')
        = linearCombination Bv D.M (fun k => β k x + β k x') (creationFamily n D.M) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun k hk1 hkM => by
            rw [(coordinate_isLinearForm D.spaceW C.uniqueness D.M D.w D.isBasis k hk1 hkM).map_add x x']
    _ = B.add (D.creationPart C x) (D.creationPart C x') :=
          (linearCombination_add_of_same_family Bv D.M (creationFamily n D.M) (fun k => β k x)
            (fun k => β k x')).symm
  have hD_add : ∀ g g' : DualSpace D.spaceW, D.annihilationPart C (SWd.add g g')
      = B.add (D.annihilationPart C g) (D.annihilationPart C g') := fun g g' => calc
    D.annihilationPart C (SWd.add g g')
        = linearCombination Bv D.M (fun k => g.1 (D.w k) + g'.1 (D.w k)) (annihilationFamily n D.M) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun _ _ _ => rfl
    _ = B.add (D.annihilationPart C g) (D.annihilationPart C g') :=
          (linearCombination_add_of_same_family Bv D.M (annihilationFamily n D.M) (fun k => g.1 (D.w k))
            (fun k => g'.1 (D.w k))).symm
  have hC_smul : ∀ (l : K) (x : W), D.creationPart C (D.spaceW.smul l x) = B.smul l (D.creationPart C x) :=
    fun l x => calc
    D.creationPart C (D.spaceW.smul l x)
        = linearCombination Bv D.M (fun k => l * β k x) (creationFamily n D.M) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun k hk1 hkM => by
            rw [(coordinate_isLinearForm D.spaceW C.uniqueness D.M D.w D.isBasis k hk1 hkM).map_smul l x]
    _ = B.smul l (D.creationPart C x) :=
          (smul_linearCombination Bv C.congruence.zero_add_zero C.uniqueness.mul_zero D.M (creationFamily n D.M)
            (fun k => β k x) l).symm
  have hD_smul : ∀ (l : K) (g : DualSpace D.spaceW),
      D.annihilationPart C (SWd.smul l g) = B.smul l (D.annihilationPart C g) :=
    fun l g => calc
    D.annihilationPart C (SWd.smul l g)
        = linearCombination Bv D.M (fun k => l * g.1 (D.w k)) (annihilationFamily n D.M) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun _ _ _ => rfl
    _ = B.smul l (D.annihilationPart C g) :=
          (smul_linearCombination Bv C.congruence.zero_add_zero C.uniqueness.mul_zero D.M (annihilationFamily n D.M)
            (fun k => g.1 (D.w k)) l).symm
  refine ⟨fun p p' => ?_, fun l p => ?_⟩
  · -- 加法を保つこと
    calc D.matrixValuedMap C ((D.space C).space.add p p')
        = D.matrixValuedMap C (D.spaceW.add p.1 p'.1, SWd.add p.2 p'.2) := rfl
      _ = B.add (D.creationPart C (D.spaceW.add p.1 p'.1)) (D.annihilationPart C (SWd.add p.2 p'.2)) := rfl
      _ = B.add (B.add (D.creationPart C p.1) (D.creationPart C p'.1))
            (D.annihilationPart C (SWd.add p.2 p'.2)) := by rw [hC_add]
      _ = B.add (B.add (D.creationPart C p.1) (D.creationPart C p'.1))
            (B.add (D.annihilationPart C p.2) (D.annihilationPart C p'.2)) := by rw [hD_add]
      _ = B.add (D.creationPart C p.1) (B.add (D.creationPart C p'.1)
            (B.add (D.annihilationPart C p.2) (D.annihilationPart C p'.2))) := by
          rw [B.add_assoc (D.creationPart C p.1) (D.creationPart C p'.1)]
      _ = B.add (D.creationPart C p.1) (B.add (B.add (D.creationPart C p'.1) (D.annihilationPart C p.2))
            (D.annihilationPart C p'.2)) := by
          rw [B.add_assoc (D.creationPart C p'.1) (D.annihilationPart C p.2) (D.annihilationPart C p'.2)]
      _ = B.add (D.creationPart C p.1) (B.add (B.add (D.annihilationPart C p.2) (D.creationPart C p'.1))
            (D.annihilationPart C p'.2)) := by
          rw [B.add_comm (D.creationPart C p'.1) (D.annihilationPart C p.2)]
      _ = B.add (D.creationPart C p.1) (B.add (D.annihilationPart C p.2)
            (B.add (D.creationPart C p'.1) (D.annihilationPart C p'.2))) := by
          rw [B.add_assoc (D.annihilationPart C p.2) (D.creationPart C p'.1) (D.annihilationPart C p'.2)]
      _ = B.add (B.add (D.creationPart C p.1) (D.annihilationPart C p.2))
            (B.add (D.creationPart C p'.1) (D.annihilationPart C p'.2)) := by
          rw [← B.add_assoc (D.creationPart C p.1) (D.annihilationPart C p.2)]
      _ = B.add (D.matrixValuedMap C p) (D.matrixValuedMap C p') := rfl
  · -- スカラー倍を保つこと
    calc D.matrixValuedMap C ((D.space C).space.smul l p)
        = D.matrixValuedMap C (D.spaceW.smul l p.1, SWd.smul l p.2) := rfl
      _ = B.add (D.creationPart C (D.spaceW.smul l p.1)) (D.annihilationPart C (SWd.smul l p.2)) := rfl
      _ = B.add (B.smul l (D.creationPart C p.1)) (D.annihilationPart C (SWd.smul l p.2)) := by rw [hC_smul]
      _ = B.add (B.smul l (D.creationPart C p.1)) (B.smul l (D.annihilationPart C p.2)) := by rw [hD_smul]
      _ = B.smul l (B.add (D.creationPart C p.1) (D.annihilationPart C p.2)) :=
          (B.smul_add l (D.creationPart C p.1) (D.annihilationPart C p.2)).symm
      _ = B.smul l (D.matrixValuedMap C p) := rfl

omit [Neg K] in
/-- 本文 `claim_square_of_matrix_valued_map_on_split_quadratic_space` の必要十分版：φ(v) ·_{Mat} φ(v) = q(v) ∗_{Mat} 1_{Mat}。 -/
theorem matrixValuedMap_mul_self (p : W × DualSpace D.spaceW) :
    (D.matrixAlgebra C).mul (D.matrixValuedMap C p) (D.matrixValuedMap C p)
      = (D.matrixAlgebra C).smul ((D.space C).form p) (D.matrixAlgebra C).one := by
  let B := D.matrixAlgebra C
  let Bv := B.toVectorSpace
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  let x := p.1
  let g := p.2
  let lam : ℕ → K := fun k => coordinate D.spaceW D.M D.w D.isBasis k x
  let mu : ℕ → K := fun k => g.1 (D.w k)
  let Cc := linearCombination Bv D.M lam (creationFamily n D.M)
  let E := linearCombination Bv D.M mu (annihilationFamily n D.M)
  -- 準備の一つ目：C ·_B C = 0_B
  have h1 : B.mul Cc Cc = B.zero :=
    square_linearCombination_eq_zero h00 C.uniqueness.mul_zero B D.M lam (creationFamily n D.M)
      (fun k hk1 hkM => by
        rw [creationFamily_of_mem n ⟨hk1, hkM⟩]
        exact creationMatrix_mul_self C.valuedMaps C.mul_one C.uniqueness.mul_zero C.uniqueness.zero_mul n
          ⟨hk1, hkM⟩)
      (fun k l hk1 hkM hl1 hlM _ => by
        rw [creationFamily_of_mem n ⟨hk1, hkM⟩, creationFamily_of_mem n ⟨hl1, hlM⟩]
        exact creationMatrices_anticommute C.valuedMaps C.mul_one C.uniqueness.mul_zero C.uniqueness.zero_mul n
          C.congruence.one_add_n C.congruence.n_add_one ⟨hk1, hkM⟩ ⟨hl1, hlM⟩)
  -- 準備の二つ目：D ·_B D = 0_B
  have h2 : B.mul E E = B.zero :=
    square_linearCombination_eq_zero h00 C.uniqueness.mul_zero B D.M mu (annihilationFamily n D.M)
      (fun k hk1 hkM => by
        rw [annihilationFamily_of_mem n ⟨hk1, hkM⟩]
        exact annihilationMatrix_mul_self C.valuedMaps C.mul_one C.uniqueness.mul_zero C.uniqueness.zero_mul n
          ⟨hk1, hkM⟩)
      (fun k l hk1 hkM hl1 hlM _ => by
        rw [annihilationFamily_of_mem n ⟨hk1, hkM⟩, annihilationFamily_of_mem n ⟨hl1, hlM⟩]
        exact annihilationMatrices_anticommute C.valuedMaps C.mul_one C.uniqueness.mul_zero C.uniqueness.zero_mul n
          C.congruence.one_add_n C.congruence.n_add_one ⟨hk1, hkM⟩ ⟨hl1, hlM⟩)
  -- 準備の三つ目：各 k で c_k ·_B D +_B D ·_B c_k = μ_k ∗_B 1_B
  have h3 : ∀ k : ℕ, 1 ≤ k → k ≤ D.M →
      B.add (B.mul (creationFamily n D.M k) E) (B.mul E (creationFamily n D.M k)) = B.smul (mu k) B.one := by
    intro k hk1 hkM
    have hk : 1 ≤ k ∧ k ≤ D.M := ⟨hk1, hkM⟩
    -- 項の二つの等式
    have hterm1 : ∀ l : ℕ, (hl : 1 ≤ l ∧ l ≤ D.M) →
        B.add (B.mul (annihilationFamily n D.M l) (creationFamily n D.M k))
            (B.mul (creationFamily n D.M k) (annihilationFamily n D.M l))
          = B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) B.one := by
      intro l ⟨hl1, hlM⟩
      rw [annihilationFamily_of_mem n ⟨hl1, hlM⟩, creationFamily_of_mem n hk]
      calc B.add (B.mul (annihilationMatrix n D.M l ⟨hl1, hlM⟩) (creationMatrix n D.M k hk))
            (B.mul (creationMatrix n D.M k hk) (annihilationMatrix n D.M l ⟨hl1, hlM⟩))
          = B.add (B.mul (creationMatrix n D.M k hk) (annihilationMatrix n D.M l ⟨hl1, hlM⟩))
              (B.mul (annihilationMatrix n D.M l ⟨hl1, hlM⟩) (creationMatrix n D.M k hk)) :=
            B.add_comm _ _
        _ = B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, ⟨hl1, hlM⟩⟩ : Idx D.M)) B.one :=
            creationMatrix_annihilationMatrix_anticommute C.valuedMaps C.mul_one C.uniqueness.mul_zero
              C.uniqueness.zero_mul n C.signLaws hk ⟨hl1, hlM⟩
    have hterm2 : ∀ l : ℕ, (hl : 1 ≤ l ∧ l ≤ D.M) →
        B.smul (mu l) (B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) B.one)
          = B.smul (kroneckerDelta l k) (B.smul (mu l) B.one) := by
      intro l hl
      calc B.smul (mu l) (B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) B.one)
          = B.smul (mu l * kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) B.one :=
            (B.smul_assoc _ _ _).symm
        _ = B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M) * mu l) B.one := by
            rw [C.mul_comm (mu l)]
        _ = B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) (B.smul (mu l) B.one) :=
            B.smul_assoc _ _ _
        _ = B.smul (kroneckerDelta l k) (B.smul (mu l) B.one) := by rw [kroneckerDelta_idx_eq_swap hk hl]
    calc B.add (B.mul (creationFamily n D.M k) E) (B.mul E (creationFamily n D.M k))
        = B.add (B.mul E (creationFamily n D.M k)) (B.mul (creationFamily n D.M k) E) := B.add_comm _ _
      _ = linearCombination Bv D.M mu (fun l => B.add (B.mul (annihilationFamily n D.M l) (creationFamily n D.M k))
            (B.mul (creationFamily n D.M k) (annihilationFamily n D.M l))) :=
          anticommutator_linearCombination h00 B (creationFamily n D.M k) D.M mu (annihilationFamily n D.M)
      _ = linearCombination Bv D.M mu (fun l => if hl : 1 ≤ l ∧ l ≤ D.M then
            B.smul (kroneckerDelta (⟨k, hk⟩ : Idx D.M) (⟨l, hl⟩ : Idx D.M)) B.one else B.zero) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun l hl1 hlM => by
            rw [dif_pos ⟨hl1, hlM⟩, hterm1 l ⟨hl1, hlM⟩]
      _ = linearCombination Bv D.M (fun l => kroneckerDelta l k) (fun l => B.smul (mu l) B.one) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun l hl1 hlM => by
            show B.smul (mu l) _ = B.smul _ _
            rw [dif_pos ⟨hl1, hlM⟩]
            exact hterm2 l ⟨hl1, hlM⟩
      _ = B.smul (mu k) B.one := linearCombination_kroneckerDelta Bv h00 D.M _ k hk1 hkM
  -- 準備の四つ目：C ·_B D +_B D ·_B C = Σ λ_k ∗_B (μ_k ∗_B 1_B)
  have h4 : B.add (B.mul Cc E) (B.mul E Cc)
      = linearCombination Bv D.M lam (fun k => B.smul (mu k) B.one) := calc
    B.add (B.mul Cc E) (B.mul E Cc)
        = linearCombination Bv D.M lam (fun k => B.add (B.mul (creationFamily n D.M k) E)
            (B.mul E (creationFamily n D.M k))) :=
          anticommutator_linearCombination h00 B E D.M lam (creationFamily n D.M)
    _ = linearCombination Bv D.M lam (fun k => B.smul (mu k) B.one) :=
          linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ fun k hk1 hkM => by rw [h3 k hk1 hkM]
  -- 準備の五つ目：g(x) ∗_B 1_B = Σ λ_k ∗_B (μ_k ∗_B 1_B)
  let h : W → Mat K (PowerSet D.M) := fun y => B.smul (g.1 y) B.one
  have hh : IsLinearMap D.spaceW Bv h :=
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
        hh.map_linearCombination h00 D.M _ D.w
    _ = linearCombination Bv D.M lam (fun k => B.smul (mu k) B.one) := rfl
  -- 本題
  calc B.mul (D.matrixValuedMap C p) (D.matrixValuedMap C p)
      = B.mul (B.add Cc E) (B.add Cc E) := rfl
    _ = B.add (B.mul Cc (B.add Cc E)) (B.mul E (B.add Cc E)) := B.right_distrib Cc E (B.add Cc E)
    _ = B.add (B.add (B.mul Cc Cc) (B.mul Cc E)) (B.add (B.mul E Cc) (B.mul E E)) := by
        rw [B.left_distrib Cc Cc E, B.left_distrib E Cc E]
    _ = B.add (B.add B.zero (B.mul Cc E)) (B.add (B.mul E Cc) (B.mul E E)) := by rw [h1]
    _ = B.add (B.add B.zero (B.mul Cc E)) (B.add (B.mul E Cc) B.zero) := by rw [h2]
    _ = B.add (B.add (B.mul Cc E) B.zero) (B.add (B.mul E Cc) B.zero) := by rw [B.add_comm B.zero (B.mul Cc E)]
    _ = B.add (B.mul Cc E) (B.mul E Cc) := by rw [B.add_zero (B.mul Cc E), B.add_zero (B.mul E Cc)]
    _ = linearCombination Bv D.M lam (fun k => B.smul (mu k) B.one) := h4
    _ = B.smul (g.1 x) B.one := h5.symm
    _ = B.smul (splitQuadraticForm D.spaceW (x, g)) B.one := rfl
    _ = B.smul ((D.space C).form p) B.one := rfl

/-! ### クリフォード代数から行列環への準同型 -/

/-- 本文 `claim_existence_and_uniqueness_of_homomorphism_from_clifford_algebra_to_matrix_algebra` の必要十分版：
Φ ∘ γ = φ を満たす代数の準同型 Φ : Cl(V,q) → Mat_{P_M}(K) がただ一つ存在する。
クリフォード代数の普遍性の必要十分版を A := Mat_{P_M}(K)、線型写像 φ に当てる（a + (-a) = 0 はその仮定）。 -/
theorem existsUnique_homomorphismToMatrix (hneg : ∀ a : K, a + -a = 0) :
    ∃ Φ : (D.space C).Cl C → Mat K (PowerSet D.M),
      (IsAlgebraHomomorphism ((D.space C).cliffordAlgebra C) (D.matrixAlgebra C) Φ ∧
        ∀ v, Φ ((D.space C).γ C v) = D.matrixValuedMap C v) ∧
      ∀ Φ' : (D.space C).Cl C → Mat K (PowerSet D.M),
        (IsAlgebraHomomorphism ((D.space C).cliffordAlgebra C) (D.matrixAlgebra C) Φ' ∧
          ∀ v, Φ' ((D.space C).γ C v) = D.matrixValuedMap C v) → Φ' = Φ :=
  (D.space C).universalProperty C hneg (D.matrixAlgebra C) (D.matrixValuedMap C) (D.matrixValuedMap_isLinearMap C)
    (D.matrixValuedMap_mul_self C)

/-- 本文 `def_homomorphism_from_clifford_algebra_to_matrix_algebra` の必要十分版：存在と一意性の主張のただ一つの準同型 Φ。 -/
def homomorphismToMatrix (hneg : ∀ a : K, a + -a = 0) : (D.space C).Cl C → Mat K (PowerSet D.M) :=
  Classical.choose (D.existsUnique_homomorphismToMatrix C hneg)

/-- 本文 `def_homomorphism_from_clifford_algebra_to_matrix_algebra` の必要十分版：Φ は代数の準同型である。 -/
theorem homomorphismToMatrix_isHom (hneg : ∀ a : K, a + -a = 0) :
    IsAlgebraHomomorphism ((D.space C).cliffordAlgebra C) (D.matrixAlgebra C) (D.homomorphismToMatrix C hneg) :=
  (Classical.choose_spec (D.existsUnique_homomorphismToMatrix C hneg)).1.1

/-- 本文 `def_homomorphism_from_clifford_algebra_to_matrix_algebra` の必要十分版：Φ ∘ γ = φ。 -/
theorem homomorphismToMatrix_γ (hneg : ∀ a : K, a + -a = 0) (v : W × DualSpace D.spaceW) :
    D.homomorphismToMatrix C hneg ((D.space C).γ C v) = D.matrixValuedMap C v :=
  (Classical.choose_spec (D.existsUnique_homomorphismToMatrix C hneg)).1.2 v

/-- 本文 `claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix` の必要十分版：Φ(a†_i) = c_i。 -/
theorem homomorphismToMatrix_creation (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.homomorphismToMatrix C hneg (D.creation C i) = creationMatrix n D.M i hi := by
  let B := D.matrixAlgebra C
  let Bv := B.toVectorSpace
  let Z := DualSpace.zero C.dualSpaceVectorSpaceLaws.toDualSpaceOperationLaws D.spaceW
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  -- 準備の一つ目：β^w_k(w_i) ∗_B c_k = δ_{k,i} ∗_B c_k
  have hprep1 : ∀ k : ℕ, 1 ≤ k → k ≤ D.M →
      Bv.smul (coordinate D.spaceW D.M D.w D.isBasis k (D.w i)) (creationFamily n D.M k)
        = Bv.smul (kroneckerDelta k i) (creationFamily n D.M k) := fun k hk1 hkM => by
    have hdual := coordinateFamily_isDualBasis C.uniqueness D.spaceW D.M D.w D.isBasis k i hk1 hkM hi.1 hi.2
    rw [coordinateFamily, dif_pos ⟨hk1, hkM⟩] at hdual
    exact congrArg (fun c => Bv.smul c (creationFamily n D.M k)) hdual
  -- 準備の二つ目：0_{W^*}(w_k) ∗_B c_k^T = 0_B
  have hprep2 : ∀ k : ℕ, 1 ≤ k → k ≤ D.M →
      Bv.smul (Z.1 (D.w k)) (annihilationFamily n D.M k) = Bv.zero := fun k _ _ => calc
    Bv.smul (Z.1 (D.w k)) (annihilationFamily n D.M k)
        = Bv.smul (zeroMap (D.w k)) (annihilationFamily n D.M k) := rfl
    _ = Bv.smul 0 (annihilationFamily n D.M k) := rfl
    _ = Bv.zero := VectorSpace.zero_smul_eq_zero Bv h00 (annihilationFamily n D.M k)
  calc D.homomorphismToMatrix C hneg (D.creation C i)
      = D.homomorphismToMatrix C hneg
          ((D.space C).γ C (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w i))) := rfl
    _ = D.matrixValuedMap C (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w i)) :=
        D.homomorphismToMatrix_γ C hneg _
    _ = D.matrixValuedMap C (D.w i, Z) := rfl
    _ = B.add (linearCombination Bv D.M (fun k => coordinate D.spaceW D.M D.w D.isBasis k (D.w i))
            (creationFamily n D.M))
          (linearCombination Bv D.M (fun k => Z.1 (D.w k)) (annihilationFamily n D.M)) := rfl
    _ = B.add (linearCombination Bv D.M (fun k => kroneckerDelta k i) (creationFamily n D.M))
          (linearCombination Bv D.M (fun k => Z.1 (D.w k)) (annihilationFamily n D.M)) := by
        rw [linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ hprep1]
    _ = B.add (creationFamily n D.M i)
          (linearCombination Bv D.M (fun k => Z.1 (D.w k)) (annihilationFamily n D.M)) := by
        rw [linearCombination_kroneckerDelta Bv h00 D.M (creationFamily n D.M) i hi.1 hi.2]
    _ = B.add (creationFamily n D.M i) B.zero := by
        rw [linearCombination_eq_zero_of_terms_eq_zero Bv D.M _ _ hprep2]; rfl
    _ = creationFamily n D.M i := B.add_zero _
    _ = creationMatrix n D.M i hi := creationFamily_of_mem n hi

/-- 本文 `claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix` の必要十分版：
Φ(a_i) = c_i^T。 -/
theorem homomorphismToMatrix_annihilation (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.homomorphismToMatrix C hneg (D.annihilation C i) = annihilationMatrix n D.M i hi := by
  let B := D.matrixAlgebra C
  let Bv := B.toVectorSpace
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  -- 準備の一つ目：β^w_k(0_W) ∗_B c_k = 0_B
  have hprep1 : ∀ k : ℕ, 1 ≤ k → k ≤ D.M →
      Bv.smul (coordinate D.spaceW D.M D.w D.isBasis k D.spaceW.zero) (creationFamily n D.M k) = Bv.zero :=
    fun k hk1 hkM => calc
    Bv.smul (coordinate D.spaceW D.M D.w D.isBasis k D.spaceW.zero) (creationFamily n D.M k)
        = Bv.smul 0 (creationFamily n D.M k) := by
          rw [(coordinate_isLinearForm D.spaceW C.uniqueness D.M D.w D.isBasis k hk1 hkM).map_zero h00
            C.uniqueness.zero_mul]
    _ = Bv.zero := VectorSpace.zero_smul_eq_zero Bv h00 (creationFamily n D.M k)
  -- 準備の二つ目：f_i(w_k) ∗_B c_k^T = δ_{k,i} ∗_B c_k^T
  have hprep2 : ∀ k : ℕ, 1 ≤ k → k ≤ D.M →
      Bv.smul ((D.f i).1 (D.w k)) (annihilationFamily n D.M k)
        = Bv.smul (kroneckerDelta k i) (annihilationFamily n D.M k) := fun k hk1 hkM => calc
    Bv.smul ((D.f i).1 (D.w k)) (annihilationFamily n D.M k)
        = Bv.smul (kroneckerDelta i k) (annihilationFamily n D.M k) := by
          rw [D.isDualBasis i k hi.1 hi.2 hk1 hkM]
    _ = Bv.smul (kroneckerDelta k i) (annihilationFamily n D.M k) := by
          by_cases hik : i = k
          · rw [kroneckerDelta, kroneckerDelta, if_pos hik, if_pos hik.symm]
          · rw [kroneckerDelta, kroneckerDelta, if_neg hik, if_neg (Ne.symm hik)]
  calc D.homomorphismToMatrix C hneg (D.annihilation C i)
      = D.homomorphismToMatrix C hneg ((D.space C).γ C (embedSecond D.spaceW (D.f i))) := rfl
    _ = D.matrixValuedMap C (embedSecond D.spaceW (D.f i)) := D.homomorphismToMatrix_γ C hneg _
    _ = D.matrixValuedMap C (D.spaceW.zero, D.f i) := rfl
    _ = B.add (linearCombination Bv D.M (fun k => coordinate D.spaceW D.M D.w D.isBasis k D.spaceW.zero)
            (creationFamily n D.M))
          (linearCombination Bv D.M (fun k => (D.f i).1 (D.w k)) (annihilationFamily n D.M)) := rfl
    _ = B.add B.zero (linearCombination Bv D.M (fun k => (D.f i).1 (D.w k)) (annihilationFamily n D.M)) := by
        rw [linearCombination_eq_zero_of_terms_eq_zero Bv D.M _ _ hprep1]; rfl
    _ = B.add B.zero (linearCombination Bv D.M (fun k => kroneckerDelta k i) (annihilationFamily n D.M)) := by
        rw [linearCombination_eq_of_terms_eq Bv D.M _ _ _ _ hprep2]
    _ = B.add B.zero (annihilationFamily n D.M i) := by
        rw [linearCombination_kroneckerDelta Bv h00 D.M (annihilationFamily n D.M) i hi.1 hi.2]
    _ = B.add (annihilationFamily n D.M i) B.zero := B.add_comm _ _
    _ = annihilationFamily n D.M i := B.add_zero _
    _ = annihilationMatrix n D.M i hi := annihilationFamily_of_mem n hi

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
