/-
節「テンソル代数」のうち、テンソル代数の台の線型空間・積・単位元と、それが K-代数であることの必要十分版。具体版
`MathematicalToolkit/TensorAlgebra/TensorAlgebraStructure.lean` と同じ def と calc の行で、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                          このファイル                                 K に要るもの
  def_vector_space_of_tensor_algebra                                    coordinateTensorPowers                       座標の構成の性質（ValuedMapsLaws・UniquenessLaws）と乗法の交換法則
  claim_sum_over_finite_set_of_zero_terms_is_zero                       sumOverFiniteSet_eq_zero_of_terms_eq_zero    0 + 0 = 0、a · 0 = 0
  claim_convolution_of_tensor_algebra_elements_lies_in_direct_sum       convolution_isZeroBound                      乗法の交換法則、0 + 0 = 0、a · 0 = 0
  def_product_of_tensor_algebra                                         tensorAlgebraMul                             同上
  def_unit_of_tensor_algebra                                            tensorAlgebraOne                             なし
  claim_projection_onto_component_of_direct_sum_of_family_is_linear_map projectComponent_isLinearMap                 なし（D を線型空間として書くために L・n を持つ）
  claim_tensor_algebra_product_is_linear_in_second_factor               tensorAlgebraMul_add_right・…_smul_right     乗法の交換法則、0 + 0 = 0、a · 0 = 0
  claim_tensor_algebra_product_is_linear_in_first_factor                tensorAlgebraMul_add_left・…_smul_left       同上
  claim_tensor_algebra_product_of_embedded_tensors                      tensorAlgebraMul_embed                       同上
  claim_element_of_direct_sum_of_family_is_sum_of_embedded_components   eq_sum_embedComponent                        0 + 0 = 0、a · 0 = 0（と D を線型空間にする 1 + n = 0）
  claim_tensor_algebra_product_is_associative                           tensorAlgebraMul_assoc                       乗法の交換法則、0 + 0 = 0、a · 0 = 0、1 + n = 0
  claim_unit_of_tensor_algebra_is_left_unit                             tensorAlgebraOne_mul                         同上
  claim_unit_of_tensor_algebra_is_right_unit                            tensorAlgebraMul_one                         同上
  def_tensor_algebra・claim_tensor_algebra_is_complex_algebra           tensorAlgebra                                同上

乗法の交換法則は二か所で要る。テンソルの積 m_{k,l} を定めるところ（`ProductOfTensors.lean`）と、
(x ⋆_D (λ ∗_D y))_p の和の係数 1 · λ を λ · 1 へ替える行（スカラー倍を和の外へ出すため）である。後者に要るのは 1 と λ の交換だけだが、
前者で交換法則全体を仮定しているので同じ仮定を使う。
0 + 0 = 0 と a · 0 = 0（`ScalarMultipleOfZeroLaws`）は、零ベクトルのスカラー倍が零であること（零の境の主張・デルタで一項を取り出す行）と、
和のスカラー倍（`smul_sumOverFiniteSet`）に要る。1 + n = 0 は、D の加法の逆元 n ∗_D x を作るためだけに要り、
D を線型空間として書く主張（和への分解と、それを使う結合法則・単位元）に現れる。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.AssociativityOfTensorProduct
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.DirectSumOfFamily
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.InitialSegmentFromZero
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorProduct.CoordinateConstruction
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexAlgebra.Definitions

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v w uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] {V : Type u}

/-- 本文 `claim_sum_over_finite_set_of_zero_terms_is_zero`：すべての x で λ_x ·_V v_x = 0_V なら Σ_{x∈X} λ_x ·_V v_x = 0_V。 -/
theorem sumOverFiniteSet_eq_zero_of_terms_eq_zero {W : Type v} (S : VectorSpace K W) (h00 : (0 : K) + 0 = 0)
    (hmul0 : ∀ a : K, a * 0 = 0) {X : Type w}
    (hX : IsFiniteSet X) (c : X → K) (v : X → W) (h : ∀ x : X, S.smul (c x) (v x) = S.zero) :
    sumOverFiniteSet S hX c v = S.zero := calc
  sumOverFiniteSet S hX c v = sumOverFiniteSet S hX (fun _ => 0) v :=
      sumOverFiniteSet_congr S hX _ _ _ _ (fun x => by rw [h x, zero_smul_eq_zero S h00 (v x)])
  _ = sumOverFiniteSet S hX (fun _ => 0 * 0) v := by rw [hmul0 0]
  _ = S.smul 0 (sumOverFiniteSet S hX (fun _ => 0) v) := (smul_sumOverFiniteSet S h00 hmul0 hX v (fun _ => 0) 0).symm
  _ = S.zero := zero_smul_eq_zero S h00 _

section DirectSum

variable {E : ℕ → Type v} (S : ∀ j : ℕ, VectorSpace K (E j))

/-- 本文 `claim_projection_onto_component_of_direct_sum_of_family_is_linear_map`：pr_k(x) := x_k は D から E_k への線型写像である。 -/
theorem projectComponent_isLinearMap (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (k : ℕ) :
    IsLinearMap (directSumOfFamilyVectorSpace S L n h1n) (S k) (fun x => x.1 k) where
  map_add _ _ := rfl
  map_smul _ _ := rfl

omit [Zero K] in
/-- emb_k(y) の第 j 成分（j = k のとき）：y を型の等式で E_k から E_j へ運んだもの。 -/
theorem embedComponent_of_eq (k : ℕ) (y : E k) (j : ℕ) (h : j = k) :
    (embedComponent S k y).1 j = cast (congrArg E h).symm y := by
  show (if h : j = k then cast (congrArg E h).symm y else (S j).zero) = cast (congrArg E h).symm y
  rw [dif_pos h]

/-- 本文 `claim_element_of_direct_sum_of_family_is_sum_of_embedded_components`：
x の零の境 N について x = Σ_{i∈{0,…,N}} 1_K ∗_D emb_i(x_i)。第 j 成分を pr_j の線型性で開き、j ≤ N と j > N に分ける。 -/
theorem eq_sum_embedComponent (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (x : DirectSumOfFamily S) (N : ℕ) (hN : IsZeroBound S x.1 N) :
    x = sumOverFiniteSet (directSumOfFamilyVectorSpace S L n h1n) (isFiniteSet_upTo N) (fun _ => 1)
      (fun i => embedComponent S i.1 (x.1 i.1)) := by
  apply DirectSumOfFamily.ext
  intro j
  -- s_j = pr_j(s) = Σ_{i} 1_K ·_{E_j} v_i（v_i := pr_j(emb_i(x_i))）
  have hs : (sumOverFiniteSet (directSumOfFamilyVectorSpace S L n h1n) (isFiniteSet_upTo N) (fun _ => 1)
        (fun i => embedComponent S i.1 (x.1 i.1))).1 j
      = sumOverFiniteSet (S j) (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => (embedComponent S i.1 (x.1 i.1)).1 j) :=
    (projectComponent_isLinearMap S L n h1n j).map_sumOverFiniteSet L.zero_add_zero (isFiniteSet_upTo N) _ _
  rw [hs]
  by_cases hj : j ≤ N
  · -- j ≤ N のとき：1_K ·_{E_j} v_i = δ_{j,i} ·_{E_j} v_i
    have hterm : ∀ i : UpTo N, (S j).smul 1 ((embedComponent S i.1 (x.1 i.1)).1 j)
        = (S j).smul (kroneckerDelta (⟨j, hj⟩ : UpTo N) i) ((embedComponent S i.1 (x.1 i.1)).1 j) := by
      intro i
      by_cases hi : (⟨j, hj⟩ : UpTo N) = i
      · rw [kroneckerDelta, if_pos hi]
      · have hij : j ≠ i.1 := fun h => hi (Subtype.ext h)
        rw [kroneckerDelta, if_neg hi, embedComponent_of_ne S i.1 _ j hij, smul_zero_eq_zero _ L.zero_add_zero L.mul_zero,
          smul_zero_eq_zero _ L.zero_add_zero L.mul_zero]
    calc x.1 j
        = (embedComponent S j (x.1 j)).1 j := (embedComponent_self S j (x.1 j)).symm
      _ = sumOverFiniteSet (S j) (isFiniteSet_upTo N) (fun i => kroneckerDelta (⟨j, hj⟩ : UpTo N) i)
            (fun i => (embedComponent S i.1 (x.1 i.1)).1 j) :=
          (sumOverFiniteSet_kroneckerDelta (S j) L.zero_add_zero (isFiniteSet_upTo N)
            (fun i => (embedComponent S i.1 (x.1 i.1)).1 j) ⟨j, hj⟩).symm
      _ = sumOverFiniteSet (S j) (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => (embedComponent S i.1 (x.1 i.1)).1 j) :=
          (sumOverFiniteSet_congr (S j) (isFiniteSet_upTo N) _ _ _ _ hterm).symm
  · -- j > N のとき：どの i でも i ≠ j なので 1_K ·_{E_j} v_i = 0_{E_j}
    have hterm : ∀ i : UpTo N, (S j).smul 1 ((embedComponent S i.1 (x.1 i.1)).1 j) = (S j).zero := by
      intro i
      have hij : j ≠ i.1 := by have := i.2; omega
      rw [embedComponent_of_ne S i.1 _ j hij, smul_zero_eq_zero _ L.zero_add_zero L.mul_zero]
    calc x.1 j
        = (S j).zero := hN j (by omega)
      _ = sumOverFiniteSet (S j) (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => (embedComponent S i.1 (x.1 i.1)).1 j) :=
          (sumOverFiniteSet_eq_zero_of_terms_eq_zero (S j) L.zero_add_zero L.mul_zero (isFiniteSet_upTo N) _ _ hterm).symm

end DirectSum

/-- 本文 `def_vector_space_of_tensor_algebra` の族：T_j := V^{⊗_b j}（座標による構成）、τ_j := τ_{b,j}。
(T_j, τ_j) は j 重テンソル積である（`claim_construction_is_k_fold_tensor_product`）。 -/
noncomputable def coordinateTensorPowers (LV : ValuedMapsLaws K) (UL : UniquenessLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (SV : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) : TensorPowers.{u, uK} SV where
  T j := MapsBetweenInitialSegments n j → K
  space j := coordinateTensorSpace LV n j
  τ j := coordinateTensor SV n b hb j
  isTensorProduct j := coordinateTensor_isTensorProduct.{u, uK} LV UL hcomm SV n b hb j

namespace TensorPowers

variable {SV : VectorSpace K V} (P : TensorPowers.{u, v} SV)

omit [Zero K] in
/-- emb_a(X) = emb_b(X を T_b へ運んだ元)（a = b）。 -/
theorem embedComponent_castT {a b : ℕ} (h : a = b) (X : P.T a) :
    embedComponent P.space a X = embedComponent P.space b (P.castT h X) := by
  subst h
  rfl

omit [Zero K] in
/-- テンソルの積の後ろの因子を等しい番号の T へ運んでから掛けた元は、掛けてから運んだ元である。 -/
theorem tensorMul_castT_right (hcomm : ∀ a b : K, a * b = b * a) (a : ℕ) {c c' : ℕ} (h : c = c') (X : P.T a) (Y : P.T c) :
    P.tensorMul hcomm a c' X (P.castT h Y) = P.castT (congrArg (a + ·) h) (P.tensorMul hcomm a c X Y) := by
  subst h
  rfl

/-- 本文 `claim_convolution_of_tensor_algebra_elements_lies_in_direct_sum` の項：i ∈ {0,…,p} について、
m_{i,p-i}(x_i, y_{p-i}) ∈ T_{i+(p-i)} を i + (p - i) = p で T_p へ運んだ元。 -/
noncomputable def convolutionTerm (hcomm : ∀ a b : K, a * b = b * a) (x y : DirectSumOfFamily P.space) (p : ℕ) (i : UpTo p) : P.T p :=
  P.castT (Nat.add_sub_of_le i.2) (P.tensorMul hcomm i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))

/-- 本文 `claim_convolution_of_tensor_algebra_elements_lies_in_direct_sum` の c_p := Σ_{i∈{0,…,p}} 1_K ·_{T_p} m_{i,p-i}(x_i, y_{p-i})。 -/
noncomputable def convolution (hcomm : ∀ a b : K, a * b = b * a) (x y : DirectSumOfFamily P.space) (p : ℕ) : P.T p :=
  sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm hcomm x y p)

/-- 本文 `claim_convolution_of_tensor_algebra_elements_lies_in_direct_sum`：族 c は D の元である（零の境 N_x + N_y）。 -/
theorem convolution_isZeroBound (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (x y : DirectSumOfFamily P.space) :
    ∃ N : ℕ, IsZeroBound P.space (P.convolution hcomm x y) N := by
  obtain ⟨Nx, hx⟩ := x.2
  obtain ⟨Ny, hy⟩ := y.2
  refine ⟨Nx + Ny, fun p hp => ?_⟩
  apply sumOverFiniteSet_eq_zero_of_terms_eq_zero _ L.zero_add_zero L.mul_zero
  intro i
  have hw : P.convolutionTerm hcomm x y p i = (P.space p).zero := by
    by_cases hi : Nx < i.1
    · -- i > N_x なら x_i = 0_{T_i}
      calc P.convolutionTerm hcomm x y p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul hcomm i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2)
              (P.tensorMul hcomm i.1 (p - i.1) (P.space i.1).zero (y.1 (p - i.1))) := by rw [hx i.1 hi]
        _ = P.castT (Nat.add_sub_of_le i.2) (P.space (i.1 + (p - i.1))).zero := by
            rw [(P.tensorMul_left_isLinearMap hcomm i.1 (p - i.1) (y.1 (p - i.1))).map_zero L.zero_add_zero]
        _ = (P.space p).zero := P.castT_zero _
    · -- i ≤ N_x なら p - i ≥ p - N_x > N_y なので y_{p-i} = 0_{T_{p-i}}
      have hpi : Ny < p - i.1 := by omega
      calc P.convolutionTerm hcomm x y p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul hcomm i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2)
              (P.tensorMul hcomm i.1 (p - i.1) (x.1 i.1) (P.space (p - i.1)).zero) := by rw [hy (p - i.1) hpi]
        _ = P.castT (Nat.add_sub_of_le i.2) (P.space (i.1 + (p - i.1))).zero := by
            rw [(P.tensorMul_right_isLinearMap hcomm i.1 (p - i.1) (x.1 i.1)).map_zero L.zero_add_zero]
        _ = (P.space p).zero := P.castT_zero _
  calc (P.space p).smul 1 (P.convolutionTerm hcomm x y p i) = (P.space p).smul 1 (P.space p).zero := by rw [hw]
    _ = (P.space p).zero := smul_zero_eq_zero (P.space p) L.zero_add_zero L.mul_zero 1

/-- 本文 `def_product_of_tensor_algebra`：(x ⋆_D y)_p := Σ_{i∈{0,…,p}} 1_K ·_{T_p} m_{i,p-i}(x_i, y_{p-i})。 -/
noncomputable def tensorAlgebraMul (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (x y : DirectSumOfFamily P.space) : DirectSumOfFamily P.space :=
  ⟨P.convolution hcomm x y, P.convolution_isZeroBound hcomm L x y⟩

/-- 本文 `def_unit_of_tensor_algebra`：1_D := emb_0(τ_0(ε_V))。 -/
def tensorAlgebraOne : DirectSumOfFamily P.space :=
  embedComponent P.space 0 (P.τ 0 (emptyTuple V))

/-- 本文 `claim_tensor_algebra_product_is_linear_in_second_factor` の一つ目の式 x ⋆_D (y +_D y') = x ⋆_D y +_D x ⋆_D y'。 -/
theorem tensorAlgebraMul_add_right (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (x y y' : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul hcomm L x (DirectSumOfFamily.add P.space y y')
      = DirectSumOfFamily.add P.space (P.tensorAlgebraMul hcomm L x y) (P.tensorAlgebraMul hcomm L x y') := by
  apply DirectSumOfFamily.ext
  intro p
  -- 各 i で m_{i,p-i}(x_i, y_{p-i} +_{T_{p-i}} y'_{p-i}) = a_i +_{T_p} a'_i（castT で運んだ元）
  have hterm : ∀ i : UpTo p, (P.space p).smul 1 (P.convolutionTerm hcomm x (DirectSumOfFamily.add P.space y y') p i)
      = (P.space p).smul 1 ((P.space p).add (P.convolutionTerm hcomm x y p i) (P.convolutionTerm hcomm x y' p i)) := by
    intro i
    have hai : P.convolutionTerm hcomm x (DirectSumOfFamily.add P.space y y') p i
        = (P.space p).add (P.convolutionTerm hcomm x y p i) (P.convolutionTerm hcomm x y' p i) := calc
        P.convolutionTerm hcomm x (DirectSumOfFamily.add P.space y y') p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul hcomm i.1 (p - i.1) (x.1 i.1)
              ((P.space (p - i.1)).add (y.1 (p - i.1)) (y'.1 (p - i.1)))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2) ((P.space (i.1 + (p - i.1))).add
              (P.tensorMul hcomm i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))
              (P.tensorMul hcomm i.1 (p - i.1) (x.1 i.1) (y'.1 (p - i.1)))) := by rw [P.tensorMul_add_right hcomm]
        _ = (P.space p).add (P.convolutionTerm hcomm x y p i) (P.convolutionTerm hcomm x y' p i) := P.castT_add _ _ _
    rw [hai]
  calc (P.tensorAlgebraMul hcomm L x (DirectSumOfFamily.add P.space y y')).1 p
      = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (P.convolutionTerm hcomm x (DirectSumOfFamily.add P.space y y') p) := rfl
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (fun i => (P.space p).add (P.convolutionTerm hcomm x y p i) (P.convolutionTerm hcomm x y' p i)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ hterm
    _ = (P.space p).add (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm hcomm x y p))
          (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm hcomm x y' p)) :=
        (sumOverFiniteSet_add_of_same_coefficients _ _ _ _ _).symm
    _ = (DirectSumOfFamily.add P.space (P.tensorAlgebraMul hcomm L x y) (P.tensorAlgebraMul hcomm L x y')).1 p := rfl

/-- 本文 `claim_tensor_algebra_product_is_linear_in_second_factor` の二つ目の式 x ⋆_D (λ ∗_D y) = λ ∗_D (x ⋆_D y)。 -/
theorem tensorAlgebraMul_smul_right (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (x : DirectSumOfFamily P.space) (l : K) (y : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul hcomm L x (DirectSumOfFamily.smul P.space L l y)
      = DirectSumOfFamily.smul P.space L l (P.tensorAlgebraMul hcomm L x y) := by
  apply DirectSumOfFamily.ext
  intro p
  have hterm : ∀ i : UpTo p, (P.space p).smul 1 (P.convolutionTerm hcomm x (DirectSumOfFamily.smul P.space L l y) p i)
      = (P.space p).smul 1 ((P.space p).smul l (P.convolutionTerm hcomm x y p i)) := by
    intro i
    have hai : P.convolutionTerm hcomm x (DirectSumOfFamily.smul P.space L l y) p i
        = (P.space p).smul l (P.convolutionTerm hcomm x y p i) := calc
        P.convolutionTerm hcomm x (DirectSumOfFamily.smul P.space L l y) p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul hcomm i.1 (p - i.1) (x.1 i.1)
              ((P.space (p - i.1)).smul l (y.1 (p - i.1)))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2) ((P.space (i.1 + (p - i.1))).smul l
              (P.tensorMul hcomm i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))) := by rw [P.tensorMul_smul_right hcomm]
        _ = (P.space p).smul l (P.convolutionTerm hcomm x y p i) := P.castT_smul _ _ _
    rw [hai]
  calc (P.tensorAlgebraMul hcomm L x (DirectSumOfFamily.smul P.space L l y)).1 p
      = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (P.convolutionTerm hcomm x (DirectSumOfFamily.smul P.space L l y) p) := rfl
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (fun i => (P.space p).smul l (P.convolutionTerm hcomm x y p i)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ hterm
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1 * l) (P.convolutionTerm hcomm x y p) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => ((P.space p).smul_assoc 1 l _).symm)
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => l * 1) (P.convolutionTerm hcomm x y p) := by
        rw [hcomm 1 l]
    _ = (P.space p).smul l (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm hcomm x y p)) :=
        (smul_sumOverFiniteSet _ L.zero_add_zero L.mul_zero _ _ _ l).symm
    _ = (DirectSumOfFamily.smul P.space L l (P.tensorAlgebraMul hcomm L x y)).1 p := rfl

/-- 本文 `claim_tensor_algebra_product_is_linear_in_first_factor` の一つ目の式 (x +_D x') ⋆_D y = x ⋆_D y +_D x' ⋆_D y。 -/
theorem tensorAlgebraMul_add_left (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (x x' y : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul hcomm L (DirectSumOfFamily.add P.space x x') y
      = DirectSumOfFamily.add P.space (P.tensorAlgebraMul hcomm L x y) (P.tensorAlgebraMul hcomm L x' y) := by
  apply DirectSumOfFamily.ext
  intro p
  have hterm : ∀ i : UpTo p, (P.space p).smul 1 (P.convolutionTerm hcomm (DirectSumOfFamily.add P.space x x') y p i)
      = (P.space p).smul 1 ((P.space p).add (P.convolutionTerm hcomm x y p i) (P.convolutionTerm hcomm x' y p i)) := by
    intro i
    have hai : P.convolutionTerm hcomm (DirectSumOfFamily.add P.space x x') y p i
        = (P.space p).add (P.convolutionTerm hcomm x y p i) (P.convolutionTerm hcomm x' y p i) := calc
        P.convolutionTerm hcomm (DirectSumOfFamily.add P.space x x') y p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul hcomm i.1 (p - i.1)
              ((P.space i.1).add (x.1 i.1) (x'.1 i.1)) (y.1 (p - i.1))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2) ((P.space (i.1 + (p - i.1))).add
              (P.tensorMul hcomm i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))
              (P.tensorMul hcomm i.1 (p - i.1) (x'.1 i.1) (y.1 (p - i.1)))) := by rw [P.tensorMul_add_left hcomm]
        _ = (P.space p).add (P.convolutionTerm hcomm x y p i) (P.convolutionTerm hcomm x' y p i) := P.castT_add _ _ _
    rw [hai]
  calc (P.tensorAlgebraMul hcomm L (DirectSumOfFamily.add P.space x x') y).1 p
      = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (P.convolutionTerm hcomm (DirectSumOfFamily.add P.space x x') y p) := rfl
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (fun i => (P.space p).add (P.convolutionTerm hcomm x y p i) (P.convolutionTerm hcomm x' y p i)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ hterm
    _ = (P.space p).add (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm hcomm x y p))
          (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm hcomm x' y p)) :=
        (sumOverFiniteSet_add_of_same_coefficients _ _ _ _ _).symm
    _ = (DirectSumOfFamily.add P.space (P.tensorAlgebraMul hcomm L x y) (P.tensorAlgebraMul hcomm L x' y)).1 p := rfl

/-- 本文 `claim_tensor_algebra_product_is_linear_in_first_factor` の二つ目の式 (λ ∗_D x) ⋆_D y = λ ∗_D (x ⋆_D y)。 -/
theorem tensorAlgebraMul_smul_left (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (l : K) (x y : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul hcomm L (DirectSumOfFamily.smul P.space L l x) y
      = DirectSumOfFamily.smul P.space L l (P.tensorAlgebraMul hcomm L x y) := by
  apply DirectSumOfFamily.ext
  intro p
  have hterm : ∀ i : UpTo p, (P.space p).smul 1 (P.convolutionTerm hcomm (DirectSumOfFamily.smul P.space L l x) y p i)
      = (P.space p).smul 1 ((P.space p).smul l (P.convolutionTerm hcomm x y p i)) := by
    intro i
    have hai : P.convolutionTerm hcomm (DirectSumOfFamily.smul P.space L l x) y p i
        = (P.space p).smul l (P.convolutionTerm hcomm x y p i) := calc
        P.convolutionTerm hcomm (DirectSumOfFamily.smul P.space L l x) y p i
          = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul hcomm i.1 (p - i.1)
              ((P.space i.1).smul l (x.1 i.1)) (y.1 (p - i.1))) := rfl
        _ = P.castT (Nat.add_sub_of_le i.2) ((P.space (i.1 + (p - i.1))).smul l
              (P.tensorMul hcomm i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))) := by rw [P.tensorMul_smul_left hcomm]
        _ = (P.space p).smul l (P.convolutionTerm hcomm x y p i) := P.castT_smul _ _ _
    rw [hai]
  calc (P.tensorAlgebraMul hcomm L (DirectSumOfFamily.smul P.space L l x) y).1 p
      = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (P.convolutionTerm hcomm (DirectSumOfFamily.smul P.space L l x) y p) := rfl
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
          (fun i => (P.space p).smul l (P.convolutionTerm hcomm x y p i)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ hterm
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1 * l) (P.convolutionTerm hcomm x y p) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => ((P.space p).smul_assoc 1 l _).symm)
    _ = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => l * 1) (P.convolutionTerm hcomm x y p) := by
        rw [hcomm 1 l]
    _ = (P.space p).smul l (sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm hcomm x y p)) :=
        (smul_sumOverFiniteSet _ L.zero_add_zero L.mul_zero _ _ _ l).symm
    _ = (DirectSumOfFamily.smul P.space L l (P.tensorAlgebraMul hcomm L x y)).1 p := rfl

/-- 本文 `claim_tensor_algebra_product_is_linear_in_second_factor`：x ⋆_D • は D から D への線型写像である。 -/
theorem tensorAlgebraMul_right_isLinearMap (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (x : DirectSumOfFamily P.space) :
    IsLinearMap (directSumOfFamilyVectorSpace P.space L n h1n) (directSumOfFamilyVectorSpace P.space L n h1n)
      (fun z => P.tensorAlgebraMul hcomm L x z) where
  map_add y y' := P.tensorAlgebraMul_add_right hcomm L x y y'
  map_smul l y := P.tensorAlgebraMul_smul_right hcomm L x l y

/-- 本文 `claim_tensor_algebra_product_is_linear_in_first_factor`：• ⋆_D y は D から D への線型写像である。 -/
theorem tensorAlgebraMul_left_isLinearMap (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (y : DirectSumOfFamily P.space) :
    IsLinearMap (directSumOfFamilyVectorSpace P.space L n h1n) (directSumOfFamilyVectorSpace P.space L n h1n)
      (fun z => P.tensorAlgebraMul hcomm L z y) where
  map_add x x' := P.tensorAlgebraMul_add_left hcomm L x x' y
  map_smul l x := P.tensorAlgebraMul_smul_left hcomm L l x y

/-- 本文 `claim_tensor_algebra_product_of_embedded_tensors`：emb_k(F) ⋆_D emb_l(G) = emb_{k+l}(m_{k,l}(F, G))。
第 p 成分を p = k + l と p ≠ k + l に分けて比べる。 -/
theorem tensorAlgebraMul_embed (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (k l : ℕ) (F : P.T k) (G : P.T l) :
    P.tensorAlgebraMul hcomm L (embedComponent P.space k F) (embedComponent P.space l G)
      = embedComponent P.space (k + l) (P.tensorMul hcomm k l F G) := by
  apply DirectSumOfFamily.ext
  intro p
  -- i ≠ k なら x_i = 0_{T_i} なので w_i = 0_{T_p}
  have hw_ne : ∀ i : UpTo p, i.1 ≠ k →
      P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) p i = (P.space p).zero := by
    intro i hik
    calc P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) p i
        = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul hcomm i.1 (p - i.1) ((embedComponent P.space k F).1 i.1)
            ((embedComponent P.space l G).1 (p - i.1))) := rfl
      _ = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul hcomm i.1 (p - i.1) (P.space i.1).zero
            ((embedComponent P.space l G).1 (p - i.1))) := by
          rw [embedComponent_of_ne P.space k F i.1 hik]
      _ = P.castT (Nat.add_sub_of_le i.2) (P.space (i.1 + (p - i.1))).zero := by
          rw [(P.tensorMul_left_isLinearMap hcomm i.1 (p - i.1) _).map_zero L.zero_add_zero]
      _ = (P.space p).zero := P.castT_zero _
  by_cases hp : p = k + l
  · -- p = k + l のとき
    subst hp
    have hk : k ≤ k + l := Nat.le_add_right k l
    -- w_k = m_{k,l}(F, G)
    have hwk : P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) (k + l) ⟨k, hk⟩
        = P.tensorMul hcomm k l F G := by
      have hl : k + l - k = l := by omega
      calc P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) (k + l) ⟨k, hk⟩
          = P.castT (Nat.add_sub_of_le hk) (P.tensorMul hcomm k (k + l - k) ((embedComponent P.space k F).1 k)
              ((embedComponent P.space l G).1 (k + l - k))) := rfl
        _ = P.castT (Nat.add_sub_of_le hk) (P.tensorMul hcomm k (k + l - k) F
              (P.castT hl.symm G)) := by
            rw [embedComponent_self P.space k F, embedComponent_of_eq P.space l G (k + l - k) hl]
            rfl
        _ = P.castT (Nat.add_sub_of_le hk) (P.castT (congrArg (k + ·) hl.symm) (P.tensorMul hcomm k l F G)) := by
            rw [P.tensorMul_castT_right hcomm k hl.symm F G]
        _ = P.castT ((congrArg (k + ·) hl.symm).trans (Nat.add_sub_of_le hk)) (P.tensorMul hcomm k l F G) :=
            P.castT_castT _ _ _
        _ = P.tensorMul hcomm k l F G := P.castT_self _ _
    -- 1_K ·_{T_p} w_i = δ_{k,i} ·_{T_p} w_i
    have hterm : ∀ i : UpTo (k + l), (P.space (k + l)).smul 1
          (P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) (k + l) i)
        = (P.space (k + l)).smul (kroneckerDelta (⟨k, hk⟩ : UpTo (k + l)) i)
          (P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) (k + l) i) := by
      intro i
      by_cases hi : (⟨k, hk⟩ : UpTo (k + l)) = i
      · rw [kroneckerDelta, if_pos hi]
      · have hik : i.1 ≠ k := fun h => hi (Subtype.ext h.symm)
        rw [kroneckerDelta, if_neg hi, hw_ne i hik, smul_zero_eq_zero _ L.zero_add_zero L.mul_zero, smul_zero_eq_zero _ L.zero_add_zero L.mul_zero]
    calc (P.tensorAlgebraMul hcomm L (embedComponent P.space k F) (embedComponent P.space l G)).1 (k + l)
        = sumOverFiniteSet (P.space (k + l)) (isFiniteSet_upTo (k + l)) (fun _ => 1)
            (P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) (k + l)) := rfl
      _ = sumOverFiniteSet (P.space (k + l)) (isFiniteSet_upTo (k + l))
            (fun i => kroneckerDelta (⟨k, hk⟩ : UpTo (k + l)) i)
            (P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) (k + l)) :=
          sumOverFiniteSet_congr _ _ _ _ _ _ hterm
      _ = P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) (k + l) ⟨k, hk⟩ :=
          sumOverFiniteSet_kroneckerDelta _ L.zero_add_zero _ _ _
      _ = P.tensorMul hcomm k l F G := hwk
      _ = (embedComponent P.space (k + l) (P.tensorMul hcomm k l F G)).1 (k + l) :=
          (embedComponent_self P.space (k + l) _).symm
  · -- p ≠ k + l のとき：すべての i で w_i = 0_{T_p}
    have hw : ∀ i : UpTo p,
        P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) p i = (P.space p).zero := by
      intro i
      by_cases hik : i.1 = k
      · -- i = k なら p - k ≠ l なので y_{p-k} = 0_{T_{p-k}}
        have hpl : p - i.1 ≠ l := by have := i.2; omega
        calc P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) p i
            = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul hcomm i.1 (p - i.1) ((embedComponent P.space k F).1 i.1)
                ((embedComponent P.space l G).1 (p - i.1))) := rfl
          _ = P.castT (Nat.add_sub_of_le i.2) (P.tensorMul hcomm i.1 (p - i.1) ((embedComponent P.space k F).1 i.1)
                (P.space (p - i.1)).zero) := by rw [embedComponent_of_ne P.space l G (p - i.1) hpl]
          _ = P.castT (Nat.add_sub_of_le i.2) (P.space (i.1 + (p - i.1))).zero := by
              rw [(P.tensorMul_right_isLinearMap hcomm i.1 (p - i.1) _).map_zero L.zero_add_zero]
          _ = (P.space p).zero := P.castT_zero _
      · exact hw_ne i hik
    calc (P.tensorAlgebraMul hcomm L (embedComponent P.space k F) (embedComponent P.space l G)).1 p
        = sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1)
            (P.convolutionTerm hcomm (embedComponent P.space k F) (embedComponent P.space l G) p) := rfl
      _ = (P.space p).zero :=
          sumOverFiniteSet_eq_zero_of_terms_eq_zero _ L.zero_add_zero L.mul_zero _ _ _
            (fun i => by rw [hw i, smul_zero_eq_zero _ L.zero_add_zero L.mul_zero])
      _ = (embedComponent P.space (k + l) (P.tensorMul hcomm k l F G)).1 p :=
          (embedComponent_of_ne P.space (k + l) _ p hp).symm

/-- 本文 `claim_tensor_algebra_product_is_associative` の（埋め込んだテンソルが三つのとき）。 -/
theorem tensorAlgebraMul_assoc_embed (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (i j k : ℕ) (X : P.T i) (Y : P.T j) (Z : P.T k) :
    P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (embedComponent P.space j Y))
        (embedComponent P.space k Z)
      = P.tensorAlgebraMul hcomm L (embedComponent P.space i X)
          (P.tensorAlgebraMul hcomm L (embedComponent P.space j Y) (embedComponent P.space k Z)) := calc
  P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (embedComponent P.space j Y))
      (embedComponent P.space k Z)
      = P.tensorAlgebraMul hcomm L (embedComponent P.space (i + j) (P.tensorMul hcomm i j X Y)) (embedComponent P.space k Z) := by
        rw [P.tensorAlgebraMul_embed hcomm L i j X Y]
    _ = embedComponent P.space (i + j + k) (P.tensorMul hcomm (i + j) k (P.tensorMul hcomm i j X Y) Z) :=
        P.tensorAlgebraMul_embed hcomm L (i + j) k _ Z
    _ = embedComponent P.space (i + (j + k))
          (P.castT (Nat.add_assoc i j k) (P.tensorMul hcomm (i + j) k (P.tensorMul hcomm i j X Y) Z)) :=
        P.embedComponent_castT (Nat.add_assoc i j k) _
    _ = embedComponent P.space (i + (j + k)) (P.tensorMul hcomm i (j + k) X (P.tensorMul hcomm j k Y Z)) := by
        rw [P.tensorMul_assoc hcomm i j k X Y Z]
    _ = P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (embedComponent P.space (j + k) (P.tensorMul hcomm j k Y Z)) :=
        (P.tensorAlgebraMul_embed hcomm L i (j + k) X _).symm
    _ = P.tensorAlgebraMul hcomm L (embedComponent P.space i X)
          (P.tensorAlgebraMul hcomm L (embedComponent P.space j Y) (embedComponent P.space k Z)) := by
        rw [P.tensorAlgebraMul_embed hcomm L j k Y Z]

/-- 本文 `claim_tensor_algebra_product_is_associative` の（埋め込んだテンソルが前の二つのとき）。 -/
theorem tensorAlgebraMul_assoc_embed_embed (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (i j : ℕ) (X : P.T i) (Y : P.T j) (z : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (embedComponent P.space j Y)) z
      = P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (P.tensorAlgebraMul hcomm L (embedComponent P.space j Y) z) := by
  obtain ⟨Nz, hNz⟩ := z.2
  have hz := eq_sum_embedComponent P.space L n h1n z Nz hNz
  set c : UpTo Nz → DirectSumOfFamily P.space := fun k => embedComponent P.space k.1 (z.1 k.1) with hc
  calc P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (embedComponent P.space j Y)) z
      = P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (embedComponent P.space j Y))
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nz) (fun _ => 1) c) :=
        congrArg _ hz
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nz) (fun _ => 1)
          (fun k => P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (embedComponent P.space j Y)) (c k)) :=
        (P.tensorAlgebraMul_right_isLinearMap hcomm L n h1n _).map_sumOverFiniteSet L.zero_add_zero _ _ _
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nz) (fun _ => 1)
          (fun k => P.tensorAlgebraMul hcomm L (embedComponent P.space i X)
            (P.tensorAlgebraMul hcomm L (embedComponent P.space j Y) (c k))) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun k => by rw [P.tensorAlgebraMul_assoc_embed hcomm L i j k.1 X Y (z.1 k.1)])
    _ = P.tensorAlgebraMul hcomm L (embedComponent P.space i X)
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nz) (fun _ => 1)
            (fun k => P.tensorAlgebraMul hcomm L (embedComponent P.space j Y) (c k))) :=
        ((P.tensorAlgebraMul_right_isLinearMap hcomm L n h1n _).map_sumOverFiniteSet L.zero_add_zero _ _ _).symm
    _ = P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (P.tensorAlgebraMul hcomm L (embedComponent P.space j Y)
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nz) (fun _ => 1) c)) := by
        rw [(P.tensorAlgebraMul_right_isLinearMap hcomm L n h1n (embedComponent P.space j Y)).map_sumOverFiniteSet L.zero_add_zero]
    _ = P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (P.tensorAlgebraMul hcomm L (embedComponent P.space j Y) z) := by
        rw [← hz]

/-- 本文 `claim_tensor_algebra_product_is_associative` の（埋め込んだテンソルが前の一つのとき）。 -/
theorem tensorAlgebraMul_assoc_embed_left (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (i : ℕ) (X : P.T i) (y z : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) y) z
      = P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (P.tensorAlgebraMul hcomm L y z) := by
  obtain ⟨Ny, hNy⟩ := y.2
  have hy := eq_sum_embedComponent P.space L n h1n y Ny hNy
  set b : UpTo Ny → DirectSumOfFamily P.space := fun j => embedComponent P.space j.1 (y.1 j.1) with hb
  calc P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) y) z
      = P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L (embedComponent P.space i X)
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Ny) (fun _ => 1) b)) z := by
        rw [← hy]
    _ = P.tensorAlgebraMul hcomm L (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (b j))) z := by
        rw [(P.tensorAlgebraMul_right_isLinearMap hcomm L n h1n (embedComponent P.space i X)).map_sumOverFiniteSet L.zero_add_zero]
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (b j)) z) :=
        (P.tensorAlgebraMul_left_isLinearMap hcomm L n h1n z).map_sumOverFiniteSet L.zero_add_zero _ _ _
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Ny) (fun _ => 1)
          (fun j => P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (P.tensorAlgebraMul hcomm L (b j) z)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun j => by rw [P.tensorAlgebraMul_assoc_embed_embed hcomm L n h1n i j.1 X (y.1 j.1) z])
    _ = P.tensorAlgebraMul hcomm L (embedComponent P.space i X)
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Ny) (fun _ => 1)
            (fun j => P.tensorAlgebraMul hcomm L (b j) z)) :=
        ((P.tensorAlgebraMul_right_isLinearMap hcomm L n h1n _).map_sumOverFiniteSet L.zero_add_zero _ _ _).symm
    _ = P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (P.tensorAlgebraMul hcomm L
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Ny) (fun _ => 1) b) z) := by
        rw [(P.tensorAlgebraMul_left_isLinearMap hcomm L n h1n z).map_sumOverFiniteSet L.zero_add_zero]
    _ = P.tensorAlgebraMul hcomm L (embedComponent P.space i X) (P.tensorAlgebraMul hcomm L y z) := by rw [← hy]

/-- 本文 `claim_tensor_algebra_product_is_associative`：(x ⋆_D y) ⋆_D z = x ⋆_D (y ⋆_D z)。（一般のとき） -/
theorem tensorAlgebraMul_assoc (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (x y z : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L x y) z = P.tensorAlgebraMul hcomm L x (P.tensorAlgebraMul hcomm L y z) := by
  obtain ⟨Nx, hNx⟩ := x.2
  have hx := eq_sum_embedComponent P.space L n h1n x Nx hNx
  set a : UpTo Nx → DirectSumOfFamily P.space := fun i => embedComponent P.space i.1 (x.1 i.1) with ha
  calc P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L x y) z
      = P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nx) (fun _ => 1) a) y) z := by
        rw [← hx]
    _ = P.tensorAlgebraMul hcomm L (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => P.tensorAlgebraMul hcomm L (a i) y)) z := by
        rw [(P.tensorAlgebraMul_left_isLinearMap hcomm L n h1n y).map_sumOverFiniteSet L.zero_add_zero]
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => P.tensorAlgebraMul hcomm L (P.tensorAlgebraMul hcomm L (a i) y) z) :=
        (P.tensorAlgebraMul_left_isLinearMap hcomm L n h1n z).map_sumOverFiniteSet L.zero_add_zero _ _ _
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nx) (fun _ => 1)
          (fun i => P.tensorAlgebraMul hcomm L (a i) (P.tensorAlgebraMul hcomm L y z)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => by rw [P.tensorAlgebraMul_assoc_embed_left hcomm L n h1n i.1 (x.1 i.1) y z])
    _ = P.tensorAlgebraMul hcomm L (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo Nx) (fun _ => 1) a)
          (P.tensorAlgebraMul hcomm L y z) :=
        ((P.tensorAlgebraMul_left_isLinearMap hcomm L n h1n _).map_sumOverFiniteSet L.zero_add_zero _ _ _).symm
    _ = P.tensorAlgebraMul hcomm L x (P.tensorAlgebraMul hcomm L y z) := by rw [← hx]

/-- 本文 `claim_unit_of_tensor_algebra_is_left_unit`：1_D ⋆_D x = x。 -/
theorem tensorAlgebraOne_mul (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (x : DirectSumOfFamily P.space) : P.tensorAlgebraMul hcomm L P.tensorAlgebraOne x = x := by
  obtain ⟨N, hN⟩ := x.2
  have hx := eq_sum_embedComponent P.space L n h1n x N hN
  -- 各 i で 1_D ⋆_D emb_i(x_i) = emb_i(x_i)（0 + i = i）
  have hi : ∀ i : UpTo N, P.tensorAlgebraMul hcomm L P.tensorAlgebraOne (embedComponent P.space i.1 (x.1 i.1))
      = embedComponent P.space i.1 (x.1 i.1) := fun i => calc
      P.tensorAlgebraMul hcomm L P.tensorAlgebraOne (embedComponent P.space i.1 (x.1 i.1))
        = P.tensorAlgebraMul hcomm L (embedComponent P.space 0 (P.τ 0 (emptyTuple V)))
            (embedComponent P.space i.1 (x.1 i.1)) := rfl
      _ = embedComponent P.space (0 + i.1) (P.tensorMul hcomm 0 i.1 (P.τ 0 (emptyTuple V)) (x.1 i.1)) :=
          P.tensorAlgebraMul_embed hcomm L 0 i.1 _ _
      _ = embedComponent P.space i.1
            (P.castT (Nat.zero_add i.1) (P.tensorMul hcomm 0 i.1 (P.τ 0 (emptyTuple V)) (x.1 i.1))) :=
          P.embedComponent_castT (Nat.zero_add i.1) _
      _ = embedComponent P.space i.1 (x.1 i.1) := by rw [P.tensorMul_tau_emptyTuple_left hcomm i.1 (x.1 i.1)]
  calc P.tensorAlgebraMul hcomm L P.tensorAlgebraOne x
      = P.tensorAlgebraMul hcomm L P.tensorAlgebraOne
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => embedComponent P.space i.1 (x.1 i.1))) := congrArg _ hx
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => P.tensorAlgebraMul hcomm L P.tensorAlgebraOne (embedComponent P.space i.1 (x.1 i.1))) :=
        (P.tensorAlgebraMul_right_isLinearMap hcomm L n h1n _).map_sumOverFiniteSet L.zero_add_zero _ _ _
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => embedComponent P.space i.1 (x.1 i.1)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => by rw [hi i])
    _ = x := hx.symm

/-- 本文 `claim_unit_of_tensor_algebra_is_right_unit`：x ⋆_D 1_D = x。 -/
theorem tensorAlgebraMul_one (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (x : DirectSumOfFamily P.space) : P.tensorAlgebraMul hcomm L x P.tensorAlgebraOne = x := by
  obtain ⟨N, hN⟩ := x.2
  have hx := eq_sum_embedComponent P.space L n h1n x N hN
  -- 各 i で emb_i(x_i) ⋆_D 1_D = emb_i(x_i)（i + 0 = i）
  have hi : ∀ i : UpTo N, P.tensorAlgebraMul hcomm L (embedComponent P.space i.1 (x.1 i.1)) P.tensorAlgebraOne
      = embedComponent P.space i.1 (x.1 i.1) := fun i => calc
      P.tensorAlgebraMul hcomm L (embedComponent P.space i.1 (x.1 i.1)) P.tensorAlgebraOne
        = P.tensorAlgebraMul hcomm L (embedComponent P.space i.1 (x.1 i.1))
            (embedComponent P.space 0 (P.τ 0 (emptyTuple V))) := rfl
      _ = embedComponent P.space (i.1 + 0) (P.tensorMul hcomm i.1 0 (x.1 i.1) (P.τ 0 (emptyTuple V))) :=
          P.tensorAlgebraMul_embed hcomm L i.1 0 _ _
      _ = embedComponent P.space i.1
            (P.castT (Nat.add_zero i.1) (P.tensorMul hcomm i.1 0 (x.1 i.1) (P.τ 0 (emptyTuple V)))) :=
          P.embedComponent_castT (Nat.add_zero i.1) _
      _ = embedComponent P.space i.1 (x.1 i.1) := by rw [P.tensorMul_tau_emptyTuple_right hcomm i.1 (x.1 i.1)]
  calc P.tensorAlgebraMul hcomm L x P.tensorAlgebraOne
      = P.tensorAlgebraMul hcomm L
          (sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo N) (fun _ => 1)
            (fun i => embedComponent P.space i.1 (x.1 i.1))) P.tensorAlgebraOne := by rw [← hx]
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => P.tensorAlgebraMul hcomm L (embedComponent P.space i.1 (x.1 i.1)) P.tensorAlgebraOne) :=
        (P.tensorAlgebraMul_left_isLinearMap hcomm L n h1n _).map_sumOverFiniteSet L.zero_add_zero _ _ _
    _ = sumOverFiniteSet (directSumOfFamilyVectorSpace P.space L n h1n) (isFiniteSet_upTo N) (fun _ => 1)
          (fun i => embedComponent P.space i.1 (x.1 i.1)) :=
        sumOverFiniteSet_congr _ _ _ _ _ _ (fun i => by rw [hi i])
    _ = x := hx.symm

/-- 本文 `def_tensor_algebra` と `claim_tensor_algebra_is_complex_algebra`：T(V) := (D, +_D, ⋆_D, ∗_D, 0_D, 1_D) は K-代数である。
加法の四つの条件と線型空間の条件は `directSumOfFamilyVectorSpace` の欄、乗法の結合法則・単位元・分配法則・
スカラー倍と乗法の両立は、このファイルの主張を当てる。 -/
noncomputable def tensorAlgebra (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) :
    AlgebraOver K (DirectSumOfFamily P.space) where
  add := DirectSumOfFamily.add P.space
  mul := P.tensorAlgebraMul hcomm L
  zero := DirectSumOfFamily.zero P.space
  one := P.tensorAlgebraOne
  add_assoc := (directSumOfFamilyVectorSpace P.space L n h1n).add_assoc
  add_comm := (directSumOfFamilyVectorSpace P.space L n h1n).add_comm
  add_zero := (directSumOfFamilyVectorSpace P.space L n h1n).add_zero
  exists_add_inverse := (directSumOfFamilyVectorSpace P.space L n h1n).exists_add_inverse
  mul_assoc := P.tensorAlgebraMul_assoc hcomm L n h1n
  mul_one := P.tensorAlgebraMul_one hcomm L n h1n
  one_mul := P.tensorAlgebraOne_mul hcomm L n h1n
  left_distrib := P.tensorAlgebraMul_add_right hcomm L
  right_distrib := P.tensorAlgebraMul_add_left hcomm L
  smul := DirectSumOfFamily.smul P.space L
  smul_assoc := (directSumOfFamilyVectorSpace P.space L n h1n).smul_assoc
  one_smul := (directSumOfFamilyVectorSpace P.space L n h1n).one_smul
  smul_add := (directSumOfFamilyVectorSpace P.space L n h1n).smul_add
  add_smul := (directSumOfFamilyVectorSpace P.space L n h1n).add_smul
  smul_mul_left l x y := (P.tensorAlgebraMul_smul_left hcomm L l x y).symm
  smul_mul_right l x y := (P.tensorAlgebraMul_smul_right hcomm L x l y).symm

/-- 本文 `def_tensor_algebra`：U_vec(T(V)) = (D, +_D, ∗_D, 0_D)。 -/
theorem tensorAlgebra_toVectorSpace (hcomm : ∀ a b : K, a * b = b * a) (L : ScalarMultipleOfZeroLaws K) (n : K)
    (h1n : 1 + n = 0) :
    (P.tensorAlgebra hcomm L n h1n).toVectorSpace = directSumOfFamilyVectorSpace P.space L n h1n := rfl

end TensorPowers

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
