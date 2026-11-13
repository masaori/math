/-
節「テンソル代数」のうち、線型空間からテンソル代数への埋め込み ι と、その像がテンソル代数を生成することの具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                        このファイル
  def_one_element_tuple                                                               oneElementTuple（⟨v⟩）・eq_oneElementTuple・
                                                                                      replaceComponent_oneElementTuple
  def_embedding_of_vector_space_into_tensor_algebra                                   TensorPowers.embedVector（ι）
  claim_embedding_of_vector_space_into_tensor_algebra_is_linear_map                   TensorPowers.tauOneElementTuple_isLinearMap（ω）・
                                                                                      TensorPowers.embedVector_isLinearMap
  claim_tuple_is_concatenation_of_initial_part_and_last_component                     initialPart（u⁻）・eq_concatTuple_initialPart
  claim_embedded_image_of_tuple_lies_in_subalgebra_containing_image_of_embedding      TensorPowers.embedComponent_tau_mem
  claim_image_of_embedding_generates_tensor_algebra                                   coordinateTensorPowers_generates

{1} の元 1 は `oneIdx : Idx 1` と書く。本文の主張「組は最後の成分を除いた組と最後の成分だけの組をつなげたもの」は
k ≥ 1 の組について述べ、u⁻ ∈ V^{1,…,k-1} を置く。Lean では組の長さを k + 1 と書き、u⁻ ∈ V^{1,…,k} とする
（(k-1)+1 = k の書き直しが要らない）。帰納法の段も k から k + 1 へ進む形で書く。

埋め込みの像が生成することは、本文どおり座標による構成（`coordinateTensorPowers`）の上で示す。
各成分 x_i を基底の元の組の像の和に書く行（`claim_coordinate_tensor_space_element_is_sum_of_basis_tensors`）が、座標による構成を使う。

必要十分版は `NecSuf/MathematicalToolkit/TensorAlgebra/EmbeddingAndGeneration.lean`、導出版は `TensorAlgebraStructureFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.TensorAlgebraStructure
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebra

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v

variable {V : Type u}

/-- {1} のただ一つの元 1。 -/
def oneIdx : Idx 1 := ⟨1, le_refl 1, le_refl 1⟩

/-- {1} の元は 1 だけである。 -/
theorem eq_oneIdx (s : Idx 1) : s = oneIdx := Subtype.ext (by have := s.2; show s.1 = 1; omega)

/-- 本文 `def_one_element_tuple`：v だけからなる組 ⟨v⟩ ∈ V^{1}、⟨v⟩(1) := v。 -/
def oneElementTuple (v : V) : Tuple V 1 := fun _ => v

/-- 本文 `def_one_element_tuple`：u ∈ V^{1} について u = ⟨u(1)⟩。 -/
theorem eq_oneElementTuple (u : Tuple V 1) : u = oneElementTuple (u oneIdx) :=
  funext fun s => by rw [eq_oneIdx s]; rfl

/-- 本文 `def_one_element_tuple`：⟨x⟩[1 ↦ y] = ⟨y⟩。 -/
theorem replaceComponent_oneElementTuple (x y : V) :
    replaceComponent (oneElementTuple x) oneIdx y = oneElementTuple y :=
  funext fun s => by rw [eq_oneIdx s, replaceComponent_self]; rfl

/-- 本文 `claim_tuple_is_concatenation_of_initial_part_and_last_component` の u⁻：u⁻(s) := u(s)（s ∈ {1,…,k}）。 -/
def initialPart {k : ℕ} (u : Tuple V (k + 1)) : Tuple V k := fun s => u (Idx.inFirst 1 s)

/-- 組 u ∈ V^{1,…,k+1} の最後の番号 k + 1。 -/
def lastIdx (k : ℕ) : Idx (k + 1) := ⟨k + 1, by omega, le_refl (k + 1)⟩

/-- 本文 `claim_tuple_is_concatenation_of_initial_part_and_last_component`：u = cat_{k,1}(u⁻, ⟨u(k+1)⟩)。
s ≤ k と s = k + 1 に分けて値を比べる。 -/
theorem eq_concatTuple_initialPart {k : ℕ} (u : Tuple V (k + 1)) :
    u = concatTuple (initialPart u) (oneElementTuple (u (lastIdx k))) := by
  funext s
  by_cases hs : s.1 ≤ k
  · -- s ≤ k のとき
    calc u s = initialPart u ⟨s.1, s.2.1, hs⟩ := rfl
      _ = concatTuple (initialPart u) (oneElementTuple (u (lastIdx k))) s :=
          (concatTuple_of_le (initialPart u) _ s hs).symm
  · -- s = k + 1 のとき
    have hsk : s = lastIdx k := Subtype.ext (by have := s.2.2; show s.1 = k + 1; omega)
    calc u s = u (lastIdx k) := by rw [hsk]
      _ = oneElementTuple (u (lastIdx k)) ⟨s.1 - k, by omega, by have := s.2.2; omega⟩ := rfl
      _ = concatTuple (initialPart u) (oneElementTuple (u (lastIdx k))) s :=
          (concatTuple_of_gt (initialPart u) _ s (by omega)).symm

namespace TensorPowers

variable {SV : ComplexVectorSpace V} (P : TensorPowers.{u, v} SV)

/-- 本文 `def_embedding_of_vector_space_into_tensor_algebra`：ι(v) := emb_1(τ_1(⟨v⟩))。 -/
def embedVector (v : V) : DirectSumOfFamily P.space :=
  embedComponent P.space 1 (P.τ 1 (oneElementTuple v))

/-- 本文 `claim_embedding_of_vector_space_into_tensor_algebra_is_linear_map` の ω(v) := τ_1(⟨v⟩) は V から T_1 への線型写像である。 -/
theorem tauOneElementTuple_isLinearMap :
    IsComplexLinearMap SV (P.space 1) (fun v => P.τ 1 (oneElementTuple v)) where
  map_add x y := calc
    P.τ 1 (oneElementTuple (SV.add x y))
        = P.τ 1 (replaceComponent (oneElementTuple x) oneIdx (SV.add x y)) := by
          rw [replaceComponent_oneElementTuple]
    _ = (P.space 1).add (P.τ 1 (replaceComponent (oneElementTuple x) oneIdx x))
          (P.τ 1 (replaceComponent (oneElementTuple x) oneIdx y)) :=
        (P.isTensorProduct 1).multilinear.map_add (oneElementTuple x) oneIdx x y
    _ = (P.space 1).add (P.τ 1 (oneElementTuple x)) (P.τ 1 (oneElementTuple y)) := by
        rw [replaceComponent_oneElementTuple, replaceComponent_oneElementTuple]
  map_smul l x := calc
    P.τ 1 (oneElementTuple (SV.smul l x))
        = P.τ 1 (replaceComponent (oneElementTuple x) oneIdx (SV.smul l x)) := by
          rw [replaceComponent_oneElementTuple]
    _ = (P.space 1).smul l (P.τ 1 (replaceComponent (oneElementTuple x) oneIdx x)) :=
        (P.isTensorProduct 1).multilinear.map_smul (oneElementTuple x) oneIdx l x
    _ = (P.space 1).smul l (P.τ 1 (oneElementTuple x)) := by rw [replaceComponent_oneElementTuple]

/-- 本文 `claim_embedding_of_vector_space_into_tensor_algebra_is_linear_map`：ι は V から U_vec(T(V)) への線型写像である
（ι = emb_1 ∘ ω、線型写像の合成）。 -/
theorem embedVector_isLinearMap :
    IsComplexLinearMap SV (ComplexAlgebra.underlyingVectorSpace P.tensorAlgebra) P.embedVector :=
  P.tauOneElementTuple_isLinearMap.comp (embedComponent_isLinearMap P.space 1)

/-- 本文 `claim_embedded_image_of_tuple_lies_in_subalgebra_containing_image_of_embedding`：ι(V) ⊆ B を満たす T(V) の部分代数 B は、
すべての k と u ∈ V^{1,…,k} について emb_k(τ_k(u)) を含む。k の帰納法で示す。 -/
theorem embedComponent_tau_mem {B : Set (DirectSumOfFamily P.space)}
    (hB : ComplexAlgebra.IsSubalgebra P.tensorAlgebra B) (hsub : Set.range P.embedVector ⊆ B) :
    ∀ (k : ℕ) (u : Tuple V k), embedComponent P.space k (P.τ k u) ∈ B := by
  intro k
  induction k with
  | zero =>
    intro u
    -- emb_0(τ_0(u)) = emb_0(τ_0(ε_V)) = 1_D = 1_{T(V)}
    have h1 : embedComponent P.space 0 (P.τ 0 u) = P.tensorAlgebra.one := calc
      embedComponent P.space 0 (P.τ 0 u) = embedComponent P.space 0 (P.τ 0 (emptyTuple V)) := by
          rw [eq_emptyTuple u]
      _ = P.tensorAlgebraOne := rfl
      _ = P.tensorAlgebra.one := rfl
    rw [h1]
    exact hB.one_mem
  | succ k ih =>
    intro u
    have h1 : embedComponent P.space (k + 1) (P.τ (k + 1) u)
        = P.tensorAlgebra.mul (embedComponent P.space k (P.τ k (initialPart u)))
            (P.embedVector (u (lastIdx k))) := calc
      embedComponent P.space (k + 1) (P.τ (k + 1) u)
          = embedComponent P.space (k + 1)
              (P.τ (k + 1) (concatTuple (initialPart u) (oneElementTuple (u (lastIdx k))))) := by
            rw [← eq_concatTuple_initialPart u]
      _ = embedComponent P.space (k + 1)
            (P.tensorMul k 1 (P.τ k (initialPart u)) (P.τ 1 (oneElementTuple (u (lastIdx k))))) := by
            rw [P.tensorMul_tau_tau k 1]
      _ = P.tensorAlgebraMul (embedComponent P.space k (P.τ k (initialPart u)))
            (embedComponent P.space 1 (P.τ 1 (oneElementTuple (u (lastIdx k))))) :=
          (P.tensorAlgebraMul_embed k 1 _ _).symm
      _ = P.tensorAlgebra.mul (embedComponent P.space k (P.τ k (initialPart u)))
            (P.embedVector (u (lastIdx k))) := rfl
    rw [h1]
    exact hB.mul_mem _ _ (ih (initialPart u)) (hsub ⟨u (lastIdx k), rfl⟩)

end TensorPowers

/-- 本文 `claim_image_of_embedding_generates_tensor_algebra`：座標による構成の族の上のテンソル代数 T(V) で、ι(V) は T(V) を生成する。
x を emb_i(x_i) の和に分け、各 x_i を基底の元の組の像の和に分ける。 -/
theorem coordinateTensorPowers_generates (SV : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) :
    ComplexAlgebra.GeneratesAlgebra (coordinateTensorPowers SV n b hb).tensorAlgebra
      (Set.range (coordinateTensorPowers SV n b hb).embedVector) := by
  set P := coordinateTensorPowers SV n b hb with hP
  intro B hB hsub
  apply Set.eq_univ_of_forall
  intro x
  obtain ⟨N, hN⟩ := x.2
  -- 各 i で emb_i(x_i) ∈ B
  have hi : ∀ i : UpTo N, embedComponent P.space i.1 (x.1 i.1) ∈ B := by
    intro i
    have hxi : embedComponent P.space i.1 (x.1 i.1)
        = sumOverFiniteSet (ComplexAlgebra.underlyingVectorSpace P.tensorAlgebra) (isFiniteSet_maps n i.1) (x.1 i.1)
            (fun ξ => embedComponent P.space i.1 (P.τ i.1 (basisTuple b ξ))) := calc
      embedComponent P.space i.1 (x.1 i.1)
          = embedComponent P.space i.1 (sumOverFiniteSet (P.space i.1) (isFiniteSet_maps n i.1) (x.1 i.1)
              (fun ξ => P.τ i.1 (basisTuple b ξ))) :=
            congrArg (embedComponent P.space i.1) (eq_sum_coordinateTensor_basisTuple SV n b hb i.1 (x.1 i.1))
      _ = sumOverFiniteSet (ComplexAlgebra.underlyingVectorSpace P.tensorAlgebra) (isFiniteSet_maps n i.1) (x.1 i.1)
            (fun ξ => embedComponent P.space i.1 (P.τ i.1 (basisTuple b ξ))) :=
          (embedComponent_isLinearMap P.space i.1).map_sumOverFiniteSet _ _ _
    rw [hxi]
    exact ComplexAlgebra.IsSubalgebra.sumOverFiniteSet_mem hB _ _ _
      (fun ξ => P.embedComponent_tau_mem hB hsub i.1 (basisTuple b ξ))
  rw [eq_sum_embedComponent P.space x N hN]
  exact ComplexAlgebra.IsSubalgebra.sumOverFiniteSet_mem hB _ _ _ hi

end CliffordMatrixIsomorphism.ComplexVectorSpace
