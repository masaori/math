/-
節「テンソル代数」のうち、テンソル代数の台の線型空間・積・単位元と、それが ℂ-代数であることの具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                          このファイル
  def_vector_space_of_tensor_algebra                                    coordinateTensorPowers（T_j := V^{⊗_b j}、τ_j := τ_{b,j}）・
                                                                        DirectSumOfFamily P.space（D）・directSumOfFamilyVectorSpace P.space
  claim_sum_over_finite_set_of_zero_terms_is_zero                       sumOverFiniteSet_eq_zero_of_terms_eq_zero
  claim_convolution_of_tensor_algebra_elements_lies_in_direct_sum       TensorPowers.convolutionTerm（castT で T_p へ運んだ m_{i,p-i}(x_i, y_{p-i})）・
                                                                        TensorPowers.convolution（c_p）・TensorPowers.convolution_isZeroBound
  def_product_of_tensor_algebra                                         TensorPowers.tensorAlgebraMul（⋆_D）
  def_unit_of_tensor_algebra                                            TensorPowers.tensorAlgebraOne（1_D）
  claim_projection_onto_component_of_direct_sum_of_family_is_linear_map projectComponent_isLinearMap
  claim_tensor_algebra_product_is_linear_in_second_factor               TensorPowers.tensorAlgebraMul_add_right・…_smul_right・
                                                                        …_right_isLinearMap
  claim_tensor_algebra_product_is_linear_in_first_factor                TensorPowers.tensorAlgebraMul_add_left・…_smul_left・
                                                                        …_left_isLinearMap
  claim_tensor_algebra_product_of_embedded_tensors                      TensorPowers.tensorAlgebraMul_embed
  claim_element_of_direct_sum_of_family_is_sum_of_embedded_components   eq_sum_embedComponent
  claim_tensor_algebra_product_is_associative                           TensorPowers.tensorAlgebraMul_assoc（と三つの段）
  claim_unit_of_tensor_algebra_is_left_unit                             TensorPowers.tensorAlgebraOne_mul
  claim_unit_of_tensor_algebra_is_right_unit                            TensorPowers.tensorAlgebraMul_one
  def_tensor_algebra                                                    TensorPowers.tensorAlgebra（組 (D, +_D, ⋆_D, ∗_D, 0_D, 1_D)）・
                                                                        coordinateTensorAlgebra（本文の T(V)）
  claim_tensor_algebra_is_complex_algebra                               TensorPowers.tensorAlgebra（ComplexAlgebra の欄を埋めること）

本文はテンソル代数を、基底 b の座標による j 重テンソル積の族（`coordinateTensorPowers`）の上で定める。
積・単位元・結合法則・単位元の性質・ℂ-代数であることの証明は、族が j 重テンソル積の族であることしか使わないので、
Lean では任意の族 `P : TensorPowers SV` の上で書き、本文の T(V) は P := coordinateTensorPowers SV n b hb の場合である。
座標による構成を使うのは、埋め込みの像が生成すること（`EmbeddingAndGeneration.lean`）だけである。

本文の「i + (p - i) = p なので m_{i,p-i}(x_i, y_{p-i}) ∈ T_p」は、`AssociativityOfTensorProduct.lean` の castT で T_p へ運んだ元として書く
（`convolutionTerm`）。同じく emb_{(i+j)+k} と emb_{i+(j+k)} の行き来は `embedComponent_castT`、T_{k+(l+p)} での
テンソルの積の結合法則は `tensorMul_assoc` の castT を通す。

必要十分版は `NecSuf/MathematicalToolkit/TensorAlgebra/TensorAlgebraStructure.lean`、導出版は `TensorAlgebraStructureFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.AssociativityOfTensorProduct
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.DirectSumOfFamily
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.InitialSegmentFromZero
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorProduct.CoordinateConstruction
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.Definitions

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v w

variable {V : Type u}

/-- 本文 `claim_sum_over_finite_set_of_zero_terms_is_zero`：すべての x で λ_x ·_V v_x = 0_V なら Σ_{x∈X} λ_x ·_V v_x = 0_V。 -/
theorem sumOverFiniteSet_eq_zero_of_terms_eq_zero {W : Type v} (S : ComplexVectorSpace W) {X : Type w}
    (hX : IsFiniteSet X) (c : X → ℂ) (v : X → W) (h : ∀ x : X, S.smul (c x) (v x) = S.zero) :
    sumOverFiniteSet S hX c v = S.zero := calc
  sumOverFiniteSet S hX c v = sumOverFiniteSet S hX (fun _ => 0) v :=
      sumOverFiniteSet_congr S hX _ _ _ _ (fun x => by rw [h x, zero_smul_eq_zero S (v x)])
  _ = sumOverFiniteSet S hX (fun _ => 0 * 0) v := by rw [mul_zero]
  _ = S.smul 0 (sumOverFiniteSet S hX (fun _ => 0) v) := (smul_sumOverFiniteSet S hX v (fun _ => 0) 0).symm
  _ = S.zero := zero_smul_eq_zero S _

section DirectSum

variable {E : ℕ → Type v} (S : ∀ j : ℕ, ComplexVectorSpace (E j))

/-- 本文 `claim_projection_onto_component_of_direct_sum_of_family_is_linear_map`：pr_k(x) := x_k は D から E_k への線型写像である。 -/
theorem projectComponent_isLinearMap (k : ℕ) :
    IsComplexLinearMap (directSumOfFamilyVectorSpace S) (S k) (fun x => x.1 k) where
  map_add _ _ := rfl
  map_smul _ _ := rfl

/-- emb_k(y) の第 j 成分（j = k のとき）：y を型の等式で E_k から E_j へ運んだもの。 -/
theorem embedComponent_of_eq (k : ℕ) (y : E k) (j : ℕ) (h : j = k) :
    (embedComponent S k y).1 j = cast (congrArg E h).symm y := by
  show (if h : j = k then cast (congrArg E h).symm y else (S j).zero) = cast (congrArg E h).symm y
  rw [dif_pos h]

/-- 本文 `claim_element_of_direct_sum_of_family_is_sum_of_embedded_components`：
x の零の境 N について x = Σ_{i∈{0,…,N}} 1_ℂ ∗_D emb_i(x_i)。第 j 成分を pr_j の線型性で開き、j ≤ N と j > N に分ける。 -/
theorem eq_sum_embedComponent (x : DirectSumOfFamily S) (N : ℕ) (hN : IsZeroBound S x.1 N) :
    x = sumOverFiniteSet (directSumOfFamilyVectorSpace S) (isFiniteSet_upTo N) (fun _ => 1)
      (fun i => embedComponent S i.1 (x.1 i.1)) := by
  apply DirectSumOfFamily.ext
  intro j
  -- s_j = pr_j(s) = Σ_{i} 1_ℂ ·_{E_j} v_i（v_i := pr_j(emb_i(x_i))）
  have hs : (sumOverFiniteSet (directSumOfFamilyVectorSpace S) (isFiniteSet_upTo N) (fun _ => 1)
        (fun i => embedComponent S i.1 (x.1 i.1))).1 j
      = sumOverFiniteSet (S j) (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => (embedComponent S i.1 (x.1 i.1)).1 j) :=
    (projectComponent_isLinearMap S j).map_sumOverFiniteSet (isFiniteSet_upTo N) _ _
  rw [hs]
  by_cases hj : j ≤ N
  · -- j ≤ N のとき：1_ℂ ·_{E_j} v_i = δ_{j,i} ·_{E_j} v_i
    have hterm : ∀ i : UpTo N, (S j).smul 1 ((embedComponent S i.1 (x.1 i.1)).1 j)
        = (S j).smul (kroneckerDelta (⟨j, hj⟩ : UpTo N) i) ((embedComponent S i.1 (x.1 i.1)).1 j) := by
      intro i
      by_cases hi : (⟨j, hj⟩ : UpTo N) = i
      · rw [kroneckerDelta, if_pos hi]
      · have hij : j ≠ i.1 := fun h => hi (Subtype.ext h)
        rw [kroneckerDelta, if_neg hi, embedComponent_of_ne S i.1 _ j hij, smul_zero_eq_zero,
          smul_zero_eq_zero]
    calc x.1 j
        = (embedComponent S j (x.1 j)).1 j := (embedComponent_self S j (x.1 j)).symm
      _ = sumOverFiniteSet (S j) (isFiniteSet_upTo N) (fun i => kroneckerDelta (⟨j, hj⟩ : UpTo N) i)
            (fun i => (embedComponent S i.1 (x.1 i.1)).1 j) :=
          (sumOverFiniteSet_kroneckerDelta (S j) (isFiniteSet_upTo N)
            (fun i => (embedComponent S i.1 (x.1 i.1)).1 j) ⟨j, hj⟩).symm
      _ = sumOverFiniteSet (S j) (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => (embedComponent S i.1 (x.1 i.1)).1 j) :=
          (sumOverFiniteSet_congr (S j) (isFiniteSet_upTo N) _ _ _ _ hterm).symm
  · -- j > N のとき：どの i でも i ≠ j なので 1_ℂ ·_{E_j} v_i = 0_{E_j}
    have hterm : ∀ i : UpTo N, (S j).smul 1 ((embedComponent S i.1 (x.1 i.1)).1 j) = (S j).zero := by
      intro i
      have hij : j ≠ i.1 := by have := i.2; omega
      rw [embedComponent_of_ne S i.1 _ j hij, smul_zero_eq_zero]
    calc x.1 j
        = (S j).zero := hN j (by omega)
      _ = sumOverFiniteSet (S j) (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => (embedComponent S i.1 (x.1 i.1)).1 j) :=
          (sumOverFiniteSet_eq_zero_of_terms_eq_zero (S j) (isFiniteSet_upTo N) _ _ hterm).symm

end DirectSum

/-- 本文 `def_vector_space_of_tensor_algebra` の族：T_j := V^{⊗_b j}（座標による構成）、τ_j := τ_{b,j}。
(T_j, τ_j) は j 重テンソル積である（`claim_construction_is_k_fold_tensor_product`）。 -/
noncomputable def coordinateTensorPowers (SV : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) : TensorPowers.{u, 0} SV where
  T j := MapsBetweenInitialSegments n j → ℂ
  space j := coordinateTensorSpace n j
  τ j := coordinateTensor SV n b hb j
  isTensorProduct j := coordinateTensor_isTensorProduct.{u, 0} SV n b hb j

namespace TensorPowers

variable {SV : ComplexVectorSpace V} (P : TensorPowers.{u, v} SV)

/-- emb_a(X) = emb_b(X を T_b へ運んだ元)（a = b）。 -/
theorem embedComponent_castT {a b : ℕ} (h : a = b) (X : P.T a) :
    embedComponent P.space a X = embedComponent P.space b (P.castT h X) := by
  subst h
  rfl

/-- テンソルの積の後ろの因子を等しい番号の T へ運んでから掛けた元は、掛けてから運んだ元である。 -/
theorem tensorMul_castT_right (a : ℕ) {c c' : ℕ} (h : c = c') (X : P.T a) (Y : P.T c) :
    P.tensorMul a c' X (P.castT h Y) = P.castT (congrArg (a + ·) h) (P.tensorMul a c X Y) := by
  subst h
  rfl

/-- 本文 `claim_convolution_of_tensor_algebra_elements_lies_in_direct_sum` の項：i ∈ {0,…,p} について、
m_{i,p-i}(x_i, y_{p-i}) ∈ T_{i+(p-i)} を i + (p - i) = p で T_p へ運んだ元。 -/
noncomputable def convolutionTerm (x y : DirectSumOfFamily P.space) (p : ℕ) (i : UpTo p) : P.T p :=
  P.castT (Nat.add_sub_of_le i.2) (P.tensorMul i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))

/-- 本文 `claim_convolution_of_tensor_algebra_elements_lies_in_direct_sum` の c_p := Σ_{i∈{0,…,p}} 1_ℂ ·_{T_p} m_{i,p-i}(x_i, y_{p-i})。 -/
noncomputable def convolution (x y : DirectSumOfFamily P.space) (p : ℕ) : P.T p :=
  sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm x y p)

/-- 本文 `claim_convolution_of_tensor_algebra_elements_lies_in_direct_sum`：族 c は D の元である（零の境 N_x + N_y）。 -/
theorem convolution_isZeroBound (x y : DirectSumOfFamily P.space) :
    ∃ N : ℕ, IsZeroBound P.space (P.convolution x y) N := by
  obtain ⟨Nx, hx⟩ := x.2
  obtain ⟨Ny, hy⟩ := y.2
  refine ⟨Nx + Ny, fun p hp => ?_⟩
  apply sumOverFiniteSet_eq_zero_of_terms_eq_zero
  intro i
  have hw : P.convolutionTerm x y p i = (P.space p).zero := by
    by_cases hi : Nx < i.1
    · -- i > N_x なら x_i = 0_{T_i}
      calc P.convolutionTerm x y p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2)
              (P.tensorMul i.1 (p - i.1) (P.space i.1).zero (y.1 (p - i.1))) := by rw [hx i.1 hi]
        _ = P.castT (Nat.add_sub_of_le i.2)
              (P.multiplyRight i.1 (p - i.1) (y.1 (p - i.1)) (P.space i.1).zero) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2) (P.space (i.1 + (p - i.1))).zero :=
            -- θ^R_{y_{p-i}} は線型写像（m_{i,p-i}(•, y_{p-i}) の線型性）
            congrArg (P.castT (Nat.add_sub_of_le i.2))
              ((P.tensorMul_left_isLinearMap i.1 (p - i.1) (y.1 (p - i.1))).map_zero)
        _ = (P.space p).zero := P.castT_zero _
    · -- i ≤ N_x なら p - i ≥ p - N_x > N_y なので y_{p-i} = 0_{T_{p-i}}
      have hpi : Ny < p - i.1 := by omega
      calc P.convolutionTerm x y p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2)
              (P.tensorMul i.1 (p - i.1) (x.1 i.1) (P.space (p - i.1)).zero) := by rw [hy (p - i.1) hpi]
        _ = P.castT (Nat.add_sub_of_le i.2)
              (P.multiplyLeft i.1 (p - i.1) (x.1 i.1) (P.space (p - i.1)).zero) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2) (P.space (i.1 + (p - i.1))).zero :=
            congrArg (P.castT (Nat.add_sub_of_le i.2))
              ((P.multiplyLeft_isLinearMap i.1 (p - i.1) (x.1 i.1)).map_zero)
        _ = (P.space p).zero := P.castT_zero _
  calc (P.space p).smul 1 (P.convolutionTerm x y p i) = (P.space p).smul 1 (P.space p).zero := by rw [hw]
    _ = (P.space p).zero := smul_zero_eq_zero (P.space p) 1

/-- 本文 `def_product_of_tensor_algebra`：(x ⋆_D y)_p := Σ_{i∈{0,…,p}} 1_ℂ ·_{T_p} m_{i,p-i}(x_i, y_{p-i})。 -/
noncomputable def tensorAlgebraMul (x y : DirectSumOfFamily P.space) : DirectSumOfFamily P.space :=
  ⟨P.convolution x y, P.convolution_isZeroBound x y⟩

/-- 本文 `def_unit_of_tensor_algebra`：1_D := emb_0(τ_0(ε_V))。 -/
def tensorAlgebraOne : DirectSumOfFamily P.space :=
  embedComponent P.space 0 (P.τ 0 (emptyTuple V))

/-- 本文 `claim_tensor_algebra_product_is_linear_in_second_factor` の一つ目の式 x ⋆_D (y +_D y') = x ⋆_D y +_D x ⋆_D y'。 -/
theorem tensorAlgebraMul_add_right (x y y' : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul x (DirectSumOfFamily.add P.space y y')
      = DirectSumOfFamily.add P.space (P.tensorAlgebraMul x y) (P.tensorAlgebraMul x y') := by
  apply DirectSumOfFamily.ext
  intro p
  -- 各 i で m_{i,p-i}(x_i, y_{p-i} +_{T_{p-i}} y'_{p-i}) = a_i +_{T_p} a'_i（castT で運んだ元）
  have hterm : ∀ i : UpTo p, (P.space p).smul 1 (P.convolutionTerm x (DirectSumOfFamily.add P.space y y') p i)
      = (P.space p).smul 1 ((P.space p).add (P.convolutionTerm x y p i) (P.convolutionTerm x y' p i)) := by
    intro i
    have hai : P.convolutionTerm x (DirectSumOfFamily.add P.space y y') p i
        = (P.space p).add (P.convolutionTerm x y p i) (P.convolutionTerm x y' p i) := calc
        P.convolutionTerm x (DirectSumOfFamily.add P.space y y') p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul i.1 (p - i.1) (x.1 i.1)
              ((P.space (p - i.1)).add (y.1 (p - i.1)) (y'.1 (p - i.1)))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2) ((P.space (i.1 + (p - i.1))).add
              (P.tensorMul i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))
              (P.tensorMul i.1 (p - i.1) (x.1 i.1) (y'.1 (p - i.1)))) := by rw [P.tensorMul_add_right]
        _ = (P.space p).add (P.convolutionTerm x y p i) (P.convolutionTerm x y' p i) := P.castT_add _ _ _
    rw [hai]
  calc (P.tensorAlgebraMul x (DirectSumOfFamily.add P.space y y')).1 p
      = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (P.convolutionTerm x (DirectSumOfFamily.add P.space y y') p) := rfl
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (fun i => (P.space p).add (P.convolutionTerm x y p i) (P.convolutionTerm x y' p i)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ hterm
    _ = (P.space p).add (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm x y p))
          (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm x y' p)) :=
        (sumOverFiniteSet_add_of_same_coefficients _ _ _ _ _).symm
    _ = (DirectSumOfFamily.add P.space (P.tensorAlgebraMul x y) (P.tensorAlgebraMul x y')).1 p := rfl

/-- 本文 `claim_tensor_algebra_product_is_linear_in_second_factor` の二つ目の式 x ⋆_D (λ ∗_D y) = λ ∗_D (x ⋆_D y)。 -/
theorem tensorAlgebraMul_smul_right (x : DirectSumOfFamily P.space) (l : ℂ) (y : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul x (DirectSumOfFamily.smul P.space l y)
      = DirectSumOfFamily.smul P.space l (P.tensorAlgebraMul x y) := by
  apply DirectSumOfFamily.ext
  intro p
  have hterm : ∀ i : UpTo p, (P.space p).smul 1 (P.convolutionTerm x (DirectSumOfFamily.smul P.space l y) p i)
      = (P.space p).smul 1 ((P.space p).smul l (P.convolutionTerm x y p i)) := by
    intro i
    have hai : P.convolutionTerm x (DirectSumOfFamily.smul P.space l y) p i
        = (P.space p).smul l (P.convolutionTerm x y p i) := calc
        P.convolutionTerm x (DirectSumOfFamily.smul P.space l y) p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul i.1 (p - i.1) (x.1 i.1)
              ((P.space (p - i.1)).smul l (y.1 (p - i.1)))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2) ((P.space (i.1 + (p - i.1))).smul l
              (P.tensorMul i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))) := by rw [P.tensorMul_smul_right]
        _ = (P.space p).smul l (P.convolutionTerm x y p i) := P.castT_smul _ _ _
    rw [hai]
  calc (P.tensorAlgebraMul x (DirectSumOfFamily.smul P.space l y)).1 p
      = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (P.convolutionTerm x (DirectSumOfFamily.smul P.space l y) p) := rfl
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (fun i => (P.space p).smul l (P.convolutionTerm x y p i)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ hterm
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1 * l) (P.convolutionTerm x y p) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => ((P.space p).smul_assoc 1 l _).symm)
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => l * 1) (P.convolutionTerm x y p) := by
        rw [mul_comm 1 l]
    _ = (P.space p).smul l (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm x y p)) :=
        (smul_sumOverFiniteSet _ _ _ _ l).symm
    _ = (DirectSumOfFamily.smul P.space l (P.tensorAlgebraMul x y)).1 p := rfl

/-- 本文 `claim_tensor_algebra_product_is_linear_in_first_factor` の一つ目の式 (x +_D x') ⋆_D y = x ⋆_D y +_D x' ⋆_D y。 -/
theorem tensorAlgebraMul_add_left (x x' y : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul (DirectSumOfFamily.add P.space x x') y
      = DirectSumOfFamily.add P.space (P.tensorAlgebraMul x y) (P.tensorAlgebraMul x' y) := by
  apply DirectSumOfFamily.ext
  intro p
  have hterm : ∀ i : UpTo p, (P.space p).smul 1 (P.convolutionTerm (DirectSumOfFamily.add P.space x x') y p i)
      = (P.space p).smul 1 ((P.space p).add (P.convolutionTerm x y p i) (P.convolutionTerm x' y p i)) := by
    intro i
    have hai : P.convolutionTerm (DirectSumOfFamily.add P.space x x') y p i
        = (P.space p).add (P.convolutionTerm x y p i) (P.convolutionTerm x' y p i) := calc
        P.convolutionTerm (DirectSumOfFamily.add P.space x x') y p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul i.1 (p - i.1)
              ((P.space i.1).add (x.1 i.1) (x'.1 i.1)) (y.1 (p - i.1))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2) ((P.space (i.1 + (p - i.1))).add
              (P.tensorMul i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))
              (P.tensorMul i.1 (p - i.1) (x'.1 i.1) (y.1 (p - i.1)))) := by rw [P.tensorMul_add_left]
        _ = (P.space p).add (P.convolutionTerm x y p i) (P.convolutionTerm x' y p i) := P.castT_add _ _ _
    rw [hai]
  calc (P.tensorAlgebraMul (DirectSumOfFamily.add P.space x x') y).1 p
      = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (P.convolutionTerm (DirectSumOfFamily.add P.space x x') y p) := rfl
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (fun i => (P.space p).add (P.convolutionTerm x y p i) (P.convolutionTerm x' y p i)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ hterm
    _ = (P.space p).add (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm x y p))
          (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm x' y p)) :=
        (sumOverFiniteSet_add_of_same_coefficients _ _ _ _ _).symm
    _ = (DirectSumOfFamily.add P.space (P.tensorAlgebraMul x y) (P.tensorAlgebraMul x' y)).1 p := rfl

/-- 本文 `claim_tensor_algebra_product_is_linear_in_first_factor` の二つ目の式 (λ ∗_D x) ⋆_D y = λ ∗_D (x ⋆_D y)。 -/
theorem tensorAlgebraMul_smul_left (l : ℂ) (x y : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul (DirectSumOfFamily.smul P.space l x) y
      = DirectSumOfFamily.smul P.space l (P.tensorAlgebraMul x y) := by
  apply DirectSumOfFamily.ext
  intro p
  have hterm : ∀ i : UpTo p, (P.space p).smul 1 (P.convolutionTerm (DirectSumOfFamily.smul P.space l x) y p i)
      = (P.space p).smul 1 ((P.space p).smul l (P.convolutionTerm x y p i)) := by
    intro i
    have hai : P.convolutionTerm (DirectSumOfFamily.smul P.space l x) y p i
        = (P.space p).smul l (P.convolutionTerm x y p i) := calc
        P.convolutionTerm (DirectSumOfFamily.smul P.space l x) y p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul i.1 (p - i.1)
              ((P.space i.1).smul l (x.1 i.1)) (y.1 (p - i.1))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2) ((P.space (i.1 + (p - i.1))).smul l
              (P.tensorMul i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))) := by rw [P.tensorMul_smul_left]
        _ = (P.space p).smul l (P.convolutionTerm x y p i) := P.castT_smul _ _ _
    rw [hai]
  calc (P.tensorAlgebraMul (DirectSumOfFamily.smul P.space l x) y).1 p
      = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (P.convolutionTerm (DirectSumOfFamily.smul P.space l x) y p) := rfl
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (fun i => (P.space p).smul l (P.convolutionTerm x y p i)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ hterm
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1 * l) (P.convolutionTerm x y p) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => ((P.space p).smul_assoc 1 l _).symm)
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => l * 1) (P.convolutionTerm x y p) := by
        rw [mul_comm 1 l]
    _ = (P.space p).smul l (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm x y p)) :=
        (smul_sumOverFiniteSet _ _ _ _ l).symm
    _ = (DirectSumOfFamily.smul P.space l (P.tensorAlgebraMul x y)).1 p := rfl

/-- 本文 `claim_tensor_algebra_product_is_linear_in_second_factor`：x ⋆_D • は D から D への線型写像である。 -/
theorem tensorAlgebraMul_right_isLinearMap (x : DirectSumOfFamily P.space) :
    IsComplexLinearMap (directSumOfFamilyVectorSpace P.space) (directSumOfFamilyVectorSpace P.space)
      (fun z => P.tensorAlgebraMul x z) where
  map_add y y' := P.tensorAlgebraMul_add_right x y y'
  map_smul l y := P.tensorAlgebraMul_smul_right x l y

/-- 本文 `claim_tensor_algebra_product_is_linear_in_first_factor`：• ⋆_D y は D から D への線型写像である。 -/
theorem tensorAlgebraMul_left_isLinearMap (y : DirectSumOfFamily P.space) :
    IsComplexLinearMap (directSumOfFamilyVectorSpace P.space) (directSumOfFamilyVectorSpace P.space)
      (fun z => P.tensorAlgebraMul z y) where
  map_add x x' := P.tensorAlgebraMul_add_left x x' y
  map_smul l x := P.tensorAlgebraMul_smul_left l x y

/-- 本文 `claim_tensor_algebra_product_of_embedded_tensors`：emb_k(F) ⋆_D emb_l(G) = emb_{k+l}(m_{k,l}(F, G))。
第 p 成分を p = k + l と p ≠ k + l に分けて比べる。 -/
theorem tensorAlgebraMul_embed (k l : ℕ) (F : P.T k) (G : P.T l) :
    P.tensorAlgebraMul (embedComponent P.space k F) (embedComponent P.space l G)
      = embedComponent P.space (k + l) (P.tensorMul k l F G) := by
  apply DirectSumOfFamily.ext
  intro p
  -- i ≠ k なら x_i = 0_{T_i} なので w_i = 0_{T_p}
  have hw_ne : ∀ i : UpTo p, i.1 ≠ k →
      P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) p i = (P.space p).zero := by
    intro i hik
    calc P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) p i
        = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul i.1 (p - i.1) ((embedComponent P.space k F).1 i.1)
            ((embedComponent P.space l G).1 (p - i.1))) := rfl
      _ = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul i.1 (p - i.1) (P.space i.1).zero
            ((embedComponent P.space l G).1 (p - i.1))) := by
          rw [embedComponent_of_ne P.space k F i.1 hik]
      _ = P.castT (Nat.add_sub_of_le i.2) (P.space (i.1 + (p - i.1))).zero := by
          rw [(P.tensorMul_left_isLinearMap i.1 (p - i.1) _).map_zero]
      _ = (P.space p).zero := P.castT_zero _
  by_cases hp : p = k + l
  · -- p = k + l のとき
    subst hp
    have hk : k ≤ k + l := Nat.le_add_right k l
    -- w_k = m_{k,l}(F, G)
    have hwk : P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) (k + l) ⟨k, hk⟩
        = P.tensorMul k l F G := by
      have hl : k + l - k = l := by omega
      calc P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) (k + l) ⟨k, hk⟩
          = P.castT (Nat.add_sub_of_le hk) (P.tensorMul k (k + l - k) ((embedComponent P.space k F).1 k)
              ((embedComponent P.space l G).1 (k + l - k))) := rfl
        _ = P.castT (Nat.add_sub_of_le hk) (P.tensorMul k (k + l - k) F
              (P.castT hl.symm G)) := by
            rw [embedComponent_self P.space k F, embedComponent_of_eq P.space l G (k + l - k) hl]
            rfl
        _ = P.castT (Nat.add_sub_of_le hk) (P.castT (congrArg (k + ·) hl.symm) (P.tensorMul k l F G)) := by
            rw [P.tensorMul_castT_right k hl.symm F G]
        _ = P.castT ((congrArg (k + ·) hl.symm).trans (Nat.add_sub_of_le hk)) (P.tensorMul k l F G) :=
            P.castT_castT _ _ _
        _ = P.tensorMul k l F G := P.castT_self _ _
    -- 1_ℂ ·_{T_p} w_i = δ_{k,i} ·_{T_p} w_i
    have hterm : ∀ i : UpTo (k + l), (P.space (k + l)).smul 1
          (P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) (k + l) i)
        = (P.space (k + l)).smul (kroneckerDelta (⟨k, hk⟩ : UpTo (k + l)) i)
          (P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) (k + l) i) := by
      intro i
      by_cases hi : (⟨k, hk⟩ : UpTo (k + l)) = i
      · rw [kroneckerDelta, if_pos hi]
      · have hik : i.1 ≠ k := fun h => hi (Subtype.ext h.symm)
        rw [kroneckerDelta, if_neg hi, hw_ne i hik, smul_zero_eq_zero, smul_zero_eq_zero]
    calc (P.tensorAlgebraMul (embedComponent P.space k F) (embedComponent P.space l G)).1 (k + l)
        = sumOverFiniteSet (P.space (k + l)) (isFiniteSet_upTo (k + l)) (fun _ => 1)
            (P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) (k + l)) := rfl
      _ = sumOverFiniteSet (P.space (k + l)) (isFiniteSet_upTo (k + l))
            (fun i => kroneckerDelta (⟨k, hk⟩ : UpTo (k + l)) i)
            (P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) (k + l)) :=
          sumOverFiniteSet_congr _ _ _ _ _ _ hterm
      _ = P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) (k + l) ⟨k, hk⟩ :=
          sumOverFiniteSet_kroneckerDelta _ _ _ _
      _ = P.tensorMul k l F G := hwk
      _ = (embedComponent P.space (k + l) (P.tensorMul k l F G)).1 (k + l) :=
          (embedComponent_self P.space (k + l) _).symm
  · -- p ≠ k + l のとき：すべての i で w_i = 0_{T_p}
    have hw : ∀ i : UpTo p,
        P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) p i = (P.space p).zero := by
      intro i
      by_cases hik : i.1 = k
      · -- i = k なら p - k ≠ l なので y_{p-k} = 0_{T_{p-k}}
        have hpl : p - i.1 ≠ l := by have := i.2; omega
        calc P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) p i
            = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul i.1 (p - i.1) ((embedComponent P.space k F).1 i.1)
                ((embedComponent P.space l G).1 (p - i.1))) := rfl
          _ = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul i.1 (p - i.1) ((embedComponent P.space k F).1 i.1)
                (P.space (p - i.1)).zero) := by rw [embedComponent_of_ne P.space l G (p - i.1) hpl]
          _ = P.castT (Nat.add_sub_of_le i.2) (P.space (i.1 + (p - i.1))).zero := by
              rw [(P.tensorMul_right_isLinearMap i.1 (p - i.1) _).map_zero]
          _ = (P.space p).zero := P.castT_zero _
      · exact hw_ne i hik
    calc (P.tensorAlgebraMul (embedComponent P.space k F) (embedComponent P.space l G)).1 p
        = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
            (P.convolutionTerm (embedComponent P.space k F) (embedComponent P.space l G) p) := rfl
      _ = (P.space p).zero :=
          sumOverFiniteSet_eq_zero_of_terms_eq_zero _ _ _ _
            (fun i => by rw [hw i, smul_zero_eq_zero])
      _ = (embedComponent P.space (k + l) (P.tensorMul k l F G)).1 p :=
          (embedComponent_of_ne P.space (k + l) _ p hp).symm

/-- 本文 `claim_tensor_algebra_product_is_associative` の（埋め込んだテンソルが三つのとき）。 -/
theorem tensorAlgebraMul_assoc_embed (i j k : ℕ) (X : P.T i) (Y : P.T j) (Z : P.T k) :
    P.tensorAlgebraMul (P.tensorAlgebraMul (embedComponent P.space i X) (embedComponent P.space j Y))
        (embedComponent P.space k Z)
      = P.tensorAlgebraMul (embedComponent P.space i X)
          (P.tensorAlgebraMul (embedComponent P.space j Y) (embedComponent P.space k Z)) := calc
  P.tensorAlgebraMul (P.tensorAlgebraMul (embedComponent P.space i X) (embedComponent P.space j Y))
      (embedComponent P.space k Z)
      = P.tensorAlgebraMul (embedComponent P.space (i + j) (P.tensorMul i j X Y)) (embedComponent P.space k Z) := by
        rw [P.tensorAlgebraMul_embed i j X Y]
    _ = embedComponent P.space (i + j + k) (P.tensorMul (i + j) k (P.tensorMul i j X Y) Z) :=
        P.tensorAlgebraMul_embed (i + j) k _ Z
    _ = embedComponent P.space (i + (j + k))
          (P.castT (Nat.add_assoc i j k) (P.tensorMul (i + j) k (P.tensorMul i j X Y) Z)) :=
        P.embedComponent_castT (Nat.add_assoc i j k) _
    _ = embedComponent P.space (i + (j + k)) (P.tensorMul i (j + k) X (P.tensorMul j k Y Z)) := by
        rw [P.tensorMul_assoc i j k X Y Z]
    _ = P.tensorAlgebraMul (embedComponent P.space i X) (embedComponent P.space (j + k) (P.tensorMul j k Y Z)) :=
        (P.tensorAlgebraMul_embed i (j + k) X _).symm
    _ = P.tensorAlgebraMul (embedComponent P.space i X)
          (P.tensorAlgebraMul (embedComponent P.space j Y) (embedComponent P.space k Z)) := by
        rw [P.tensorAlgebraMul_embed j k Y Z]

/-- 本文 `claim_tensor_algebra_product_is_associative` の（埋め込んだテンソルが前の二つのとき）。 -/
theorem tensorAlgebraMul_assoc_embed_embed (i j : ℕ) (X : P.T i) (Y : P.T j) (z : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul (P.tensorAlgebraMul (embedComponent P.space i X) (embedComponent P.space j Y)) z
      = P.tensorAlgebraMul (embedComponent P.space i X) (P.tensorAlgebraMul (embedComponent P.space j Y) z) := by
  obtain ⟨Nz, hNz⟩ := z.2
  have hz := eq_sum_embedComponent P.space z Nz hNz
  set c : UpTo Nz → DirectSumOfFamily P.space := fun k => embedComponent P.space k.1 (z.1 k.1) with hc
  calc P.tensorAlgebraMul (P.tensorAlgebraMul (embedComponent P.space i X) (embedComponent P.space j Y)) z
      = P.tensorAlgebraMul (P.tensorAlgebraMul (embedComponent P.space i X) (embedComponent P.space j Y))
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nz) (fun _ => 1) c) :=
        congrArg _ hz
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nz) (fun _ => 1)
          (fun k => P.tensorAlgebraMul (P.tensorAlgebraMul (embedComponent P.space i X) (embedComponent P.space j Y)) (c k)) :=
        (P.tensorAlgebraMul_right_isLinearMap _).map_sumOverFiniteSet _ _ _
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nz) (fun _ => 1)
          (fun k => P.tensorAlgebraMul (embedComponent P.space i X)
            (P.tensorAlgebraMul (embedComponent P.space j Y) (c k))) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun k => by rw [P.tensorAlgebraMul_assoc_embed i j k.1 X Y (z.1 k.1)])
    _ = P.tensorAlgebraMul (embedComponent P.space i X)
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nz) (fun _ => 1)
            (fun k => P.tensorAlgebraMul (embedComponent P.space j Y) (c k))) :=
        ((P.tensorAlgebraMul_right_isLinearMap _).map_sumOverFiniteSet _ _ _).symm
    _ = P.tensorAlgebraMul (embedComponent P.space i X) (P.tensorAlgebraMul (embedComponent P.space j Y)
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nz) (fun _ => 1) c)) := by
        rw [(P.tensorAlgebraMul_right_isLinearMap (embedComponent P.space j Y)).map_sumOverFiniteSet]
    _ = P.tensorAlgebraMul (embedComponent P.space i X) (P.tensorAlgebraMul (embedComponent P.space j Y) z) := by
        rw [← hz]

/-- 本文 `claim_tensor_algebra_product_is_associative` の（埋め込んだテンソルが前の一つのとき）。 -/
theorem tensorAlgebraMul_assoc_embed_left (i : ℕ) (X : P.T i) (y z : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul (P.tensorAlgebraMul (embedComponent P.space i X) y) z
      = P.tensorAlgebraMul (embedComponent P.space i X) (P.tensorAlgebraMul y z) := by
  obtain ⟨Ny, hNy⟩ := y.2
  have hy := eq_sum_embedComponent P.space y Ny hNy
  set b : UpTo Ny → DirectSumOfFamily P.space := fun j => embedComponent P.space j.1 (y.1 j.1) with hb
  calc P.tensorAlgebraMul (P.tensorAlgebraMul (embedComponent P.space i X) y) z
      = P.tensorAlgebraMul (P.tensorAlgebraMul (embedComponent P.space i X)
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Ny) (fun _ => 1) b)) z := by
        rw [← hy]
    _ = P.tensorAlgebraMul (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => P.tensorAlgebraMul (embedComponent P.space i X) (b j))) z := by
        rw [(P.tensorAlgebraMul_right_isLinearMap (embedComponent P.space i X)).map_sumOverFiniteSet]
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => P.tensorAlgebraMul (P.tensorAlgebraMul (embedComponent P.space i X) (b j)) z) :=
        (P.tensorAlgebraMul_left_isLinearMap z).map_sumOverFiniteSet _ _ _
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => P.tensorAlgebraMul (embedComponent P.space i X) (P.tensorAlgebraMul (b j) z)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun j => by rw [P.tensorAlgebraMul_assoc_embed_embed i j.1 X (y.1 j.1) z])
    _ = P.tensorAlgebraMul (embedComponent P.space i X)
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Ny) (fun _ => 1)
            (fun j => P.tensorAlgebraMul (b j) z)) :=
        ((P.tensorAlgebraMul_right_isLinearMap _).map_sumOverFiniteSet _ _ _).symm
    _ = P.tensorAlgebraMul (embedComponent P.space i X) (P.tensorAlgebraMul
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Ny) (fun _ => 1) b) z) := by
        rw [(P.tensorAlgebraMul_left_isLinearMap z).map_sumOverFiniteSet]
    _ = P.tensorAlgebraMul (embedComponent P.space i X) (P.tensorAlgebraMul y z) := by rw [← hy]

/-- 本文 `claim_tensor_algebra_product_is_associative`：(x ⋆_D y) ⋆_D z = x ⋆_D (y ⋆_D z)。（一般のとき） -/
theorem tensorAlgebraMul_assoc (x y z : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul (P.tensorAlgebraMul x y) z = P.tensorAlgebraMul x (P.tensorAlgebraMul y z) := by
  obtain ⟨Nx, hNx⟩ := x.2
  have hx := eq_sum_embedComponent P.space x Nx hNx
  set a : UpTo Nx → DirectSumOfFamily P.space := fun i => embedComponent P.space i.1 (x.1 i.1) with ha
  calc P.tensorAlgebraMul (P.tensorAlgebraMul x y) z
      = P.tensorAlgebraMul (P.tensorAlgebraMul
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nx) (fun _ => 1) a) y) z := by
        rw [← hx]
    _ = P.tensorAlgebraMul (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => P.tensorAlgebraMul (a i) y)) z := by
        rw [(P.tensorAlgebraMul_left_isLinearMap y).map_sumOverFiniteSet]
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => P.tensorAlgebraMul (P.tensorAlgebraMul (a i) y) z) :=
        (P.tensorAlgebraMul_left_isLinearMap z).map_sumOverFiniteSet _ _ _
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => P.tensorAlgebraMul (a i) (P.tensorAlgebraMul y z)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => by rw [P.tensorAlgebraMul_assoc_embed_left i.1 (x.1 i.1) y z])
    _ = P.tensorAlgebraMul (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo Nx) (fun _ => 1) a)
          (P.tensorAlgebraMul y z) :=
        ((P.tensorAlgebraMul_left_isLinearMap _).map_sumOverFiniteSet _ _ _).symm
    _ = P.tensorAlgebraMul x (P.tensorAlgebraMul y z) := by rw [← hx]

/-- 本文 `claim_unit_of_tensor_algebra_is_left_unit`：1_D ⋆_D x = x。 -/
theorem tensorAlgebraOne_mul (x : DirectSumOfFamily P.space) : P.tensorAlgebraMul P.tensorAlgebraOne x = x := by
  obtain ⟨N, hN⟩ := x.2
  have hx := eq_sum_embedComponent P.space x N hN
  -- 各 i で 1_D ⋆_D emb_i(x_i) = emb_i(x_i)（0 + i = i）
  have hi : ∀ i : UpTo N, P.tensorAlgebraMul P.tensorAlgebraOne (embedComponent P.space i.1 (x.1 i.1))
      = embedComponent P.space i.1 (x.1 i.1) := fun i => calc
      P.tensorAlgebraMul P.tensorAlgebraOne (embedComponent P.space i.1 (x.1 i.1))
        = P.tensorAlgebraMul (embedComponent P.space 0 (P.τ 0 (emptyTuple V)))
            (embedComponent P.space i.1 (x.1 i.1)) := rfl
      _ = embedComponent P.space (0 + i.1) (P.tensorMul 0 i.1 (P.τ 0 (emptyTuple V)) (x.1 i.1)) :=
          P.tensorAlgebraMul_embed 0 i.1 _ _
      _ = embedComponent P.space i.1
            (P.castT (Nat.zero_add i.1) (P.tensorMul 0 i.1 (P.τ 0 (emptyTuple V)) (x.1 i.1))) :=
          P.embedComponent_castT (Nat.zero_add i.1) _
      _ = embedComponent P.space i.1 (x.1 i.1) := by rw [P.tensorMul_tau_emptyTuple_left i.1 (x.1 i.1)]
  calc P.tensorAlgebraMul P.tensorAlgebraOne x
      = P.tensorAlgebraMul P.tensorAlgebraOne
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => embedComponent P.space i.1 (x.1 i.1))) := congrArg _ hx
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => P.tensorAlgebraMul P.tensorAlgebraOne (embedComponent P.space i.1 (x.1 i.1))) :=
        (P.tensorAlgebraMul_right_isLinearMap _).map_sumOverFiniteSet _ _ _
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => embedComponent P.space i.1 (x.1 i.1)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => by rw [hi i])
    _ = x := hx.symm

/-- 本文 `claim_unit_of_tensor_algebra_is_right_unit`：x ⋆_D 1_D = x。 -/
theorem tensorAlgebraMul_one (x : DirectSumOfFamily P.space) : P.tensorAlgebraMul x P.tensorAlgebraOne = x := by
  obtain ⟨N, hN⟩ := x.2
  have hx := eq_sum_embedComponent P.space x N hN
  -- 各 i で emb_i(x_i) ⋆_D 1_D = emb_i(x_i)（i + 0 = i）
  have hi : ∀ i : UpTo N, P.tensorAlgebraMul (embedComponent P.space i.1 (x.1 i.1)) P.tensorAlgebraOne
      = embedComponent P.space i.1 (x.1 i.1) := fun i => calc
      P.tensorAlgebraMul (embedComponent P.space i.1 (x.1 i.1)) P.tensorAlgebraOne
        = P.tensorAlgebraMul (embedComponent P.space i.1 (x.1 i.1))
            (embedComponent P.space 0 (P.τ 0 (emptyTuple V))) := rfl
      _ = embedComponent P.space (i.1 + 0) (P.tensorMul i.1 0 (x.1 i.1) (P.τ 0 (emptyTuple V))) :=
          P.tensorAlgebraMul_embed i.1 0 _ _
      _ = embedComponent P.space i.1
            (P.castT (Nat.add_zero i.1) (P.tensorMul i.1 0 (x.1 i.1) (P.τ 0 (emptyTuple V)))) :=
          P.embedComponent_castT (Nat.add_zero i.1) _
      _ = embedComponent P.space i.1 (x.1 i.1) := by rw [P.tensorMul_tau_emptyTuple_right i.1 (x.1 i.1)]
  calc P.tensorAlgebraMul x P.tensorAlgebraOne
      = P.tensorAlgebraMul
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => embedComponent P.space i.1 (x.1 i.1))) P.tensorAlgebraOne := by rw [← hx]
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => P.tensorAlgebraMul (embedComponent P.space i.1 (x.1 i.1)) P.tensorAlgebraOne) :=
        (P.tensorAlgebraMul_left_isLinearMap _).map_sumOverFiniteSet _ _ _
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space) (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => embedComponent P.space i.1 (x.1 i.1)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => by rw [hi i])
    _ = x := hx.symm

/-- 本文 `def_tensor_algebra` と `claim_tensor_algebra_is_complex_algebra`：T(V) := (D, +_D, ⋆_D, ∗_D, 0_D, 1_D) は ℂ-代数である。
加法の四つの条件と線型空間の条件は `directSumOfFamilyVectorSpace` の欄、乗法の結合法則・単位元・分配法則・
スカラー倍と乗法の両立は、このファイルの主張を当てる。 -/
noncomputable def tensorAlgebra : ComplexAlgebra.{v} (DirectSumOfFamily P.space) where
  add := DirectSumOfFamily.add P.space
  mul := P.tensorAlgebraMul
  zero := DirectSumOfFamily.zero P.space
  one := P.tensorAlgebraOne
  add_assoc := (directSumOfFamilyVectorSpace P.space).add_assoc
  add_comm := (directSumOfFamilyVectorSpace P.space).add_comm
  add_zero := (directSumOfFamilyVectorSpace P.space).add_zero
  exists_add_inverse := (directSumOfFamilyVectorSpace P.space).exists_add_inverse
  mul_assoc := P.tensorAlgebraMul_assoc
  mul_one := P.tensorAlgebraMul_one
  one_mul := P.tensorAlgebraOne_mul
  left_distrib := P.tensorAlgebraMul_add_right
  right_distrib := P.tensorAlgebraMul_add_left
  smul := DirectSumOfFamily.smul P.space
  smul_assoc := (directSumOfFamilyVectorSpace P.space).smul_assoc
  one_smul := (directSumOfFamilyVectorSpace P.space).one_smul
  smul_add := (directSumOfFamilyVectorSpace P.space).smul_add
  add_smul := (directSumOfFamilyVectorSpace P.space).add_smul
  smul_mul_left l x y := (P.tensorAlgebraMul_smul_left l x y).symm
  smul_mul_right l x y := (P.tensorAlgebraMul_smul_right x l y).symm

/-- 本文 `def_tensor_algebra`：U_vec(T(V)) = (D, +_D, ∗_D, 0_D)。 -/
theorem tensorAlgebra_toComplexVectorSpace :
    P.tensorAlgebra.toComplexVectorSpace = directSumOfFamilyVectorSpace P.space := rfl

end TensorPowers

/-- 本文 `def_tensor_algebra` の T(V)：基底 b の座標による族（`coordinateTensorPowers`）の上のテンソル代数。 -/
noncomputable abbrev coordinateTensorAlgebra (SV : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) : ComplexAlgebra (DirectSumOfFamily (coordinateTensorPowers SV n b hb).space) :=
  (coordinateTensorPowers SV n b hb).tensorAlgebra

end CliffordMatrixIsomorphism.ComplexVectorSpace
