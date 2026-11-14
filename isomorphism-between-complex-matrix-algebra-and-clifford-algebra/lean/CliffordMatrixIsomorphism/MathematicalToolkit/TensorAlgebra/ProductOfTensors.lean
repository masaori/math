/-
節「テンソル代数」のうち、k 重テンソル積の元と l 重テンソル積の元の積（テンソルの積）とその双線型性の具体版。
人手証明と 1 対 1 に対応させる。

  本文のラベル                                                  このファイル
  （各 j の j 重テンソル積 (T_j, τ_j) の族）                    TensorPowers
  def_linear_map_appending_fixed_tuple                          appendMap（ρ_{u'}）・appendMap_isLinearMap・
                                                                appendMap_tau（ρ_{u'}(τ_k(u)) = τ_{k+l}(cat_{k,l}(u, u'))）・
                                                                appendMap_unique（ただ一つであること）
  def_map_appending_tuples_to_fixed_tensor                      appendMapValue（ρ_•(F)）
  claim_appending_map_value_is_multilinear_in_appended_tuple    appendMapValue_isMultilinearMap
  def_linear_map_multiplying_fixed_tensor_on_left               multiplyLeft（θ_F）・multiplyLeft_isLinearMap・
                                                                multiplyLeft_tau・multiplyLeft_unique
  def_product_of_tensors                                        tensorMul（m_{k,l}）
  claim_product_of_pure_tensors_is_pure_tensor_of_concatenation tensorMul_tau_tau
  claim_product_of_tensors_is_linear_in_second_factor           tensorMul_add_right・tensorMul_smul_right
  claim_product_of_tensors_is_linear_in_first_factor            tensorMul_add_left・tensorMul_smul_left
  def_map_multiplying_fixed_tensor_on_right                     multiplyRight（θ^R_G）

本文の「ただ一つ存在する線型写像」は、k 重テンソル積の普遍性（`IsTensorProduct.universal`）の存在から
`Classical.choose` で選び、ただ一つであることは普遍性の一意性の欄で書く（`appendMap_unique`・`multiplyLeft_unique`）。
普遍性を U := T_{k+l} に当てるので、族のどの T_j も同じ宇宙 v に置き、`IsTensorProduct` の宇宙の引数も v にする。

必要十分版は `NecSuf/MathematicalToolkit/TensorAlgebra/ProductOfTensors.lean`、導出版は `TensorAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.Concatenation
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.PointwiseLinearMaps

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v

variable {V : Type u}

/-- 本文の「各 j ∈ ℤ_{≥0} について (T_j, τ_j) を V の j 重テンソル積とする」：j 重テンソル積の族。 -/
structure TensorPowers (SV : ComplexVectorSpace V) where
  /-- 各 j の線型空間 T_j の集合 -/
  T : ℕ → Type v
  /-- T_j の ℂ-線型空間の構造 -/
  space : ∀ j : ℕ, ComplexVectorSpace (T j)
  /-- j 重線型写像 τ_j -/
  τ : ∀ j : ℕ, Tuple V j → T j
  /-- (T_j, τ_j) は V の j 重テンソル積 -/
  isTensorProduct : ∀ j : ℕ, IsTensorProduct.{u, v, v} SV j (space j) (τ j)

namespace TensorPowers

variable {SV : ComplexVectorSpace V} (P : TensorPowers.{u, v} SV)

/-- 本文 `def_linear_map_appending_fixed_tuple` の (τ_{k+l})_{•,u'} が k 重線型写像であること
（`claim_fixing_second_tuple_of_multilinear_map_gives_multilinear_map` を U = T_{k+l}、g = τ_{k+l} で）。 -/
theorem fixSecond_tau_isMultilinearMap (k l : ℕ) (u' : Tuple V l) :
    IsMultilinearMap SV (P.space (k + l)) k (fixSecond (P.τ (k + l)) u') :=
  fixSecond_isMultilinearMap (P.isTensorProduct (k + l)).multilinear u'

/-- 本文 `def_linear_map_appending_fixed_tuple`：(T_k, τ_k) の普遍性を U = T_{k+l}、h = (τ_{k+l})_{•,u'} に当てた線型写像 ρ_{u'}。 -/
noncomputable def appendMap (k l : ℕ) (u' : Tuple V l) : P.T k → P.T (k + l) :=
  Classical.choose ((P.isTensorProduct k).universal (P.T (k + l)) (P.space (k + l))
    (fixSecond (P.τ (k + l)) u') (P.fixSecond_tau_isMultilinearMap k l u'))

theorem appendMap_spec (k l : ℕ) (u' : Tuple V l) :
    (IsComplexLinearMap (P.space k) (P.space (k + l)) (P.appendMap k l u') ∧
        ∀ u : Tuple V k, P.appendMap k l u' (P.τ k u) = fixSecond (P.τ (k + l)) u' u) ∧
      ∀ g : P.T k → P.T (k + l),
        (IsComplexLinearMap (P.space k) (P.space (k + l)) g ∧
            ∀ u : Tuple V k, g (P.τ k u) = fixSecond (P.τ (k + l)) u' u) →
          g = P.appendMap k l u' :=
  Classical.choose_spec ((P.isTensorProduct k).universal (P.T (k + l)) (P.space (k + l))
    (fixSecond (P.τ (k + l)) u') (P.fixSecond_tau_isMultilinearMap k l u'))

/-- 本文 `def_linear_map_appending_fixed_tuple`：ρ_{u'} は線型写像である。 -/
theorem appendMap_isLinearMap (k l : ℕ) (u' : Tuple V l) :
    IsComplexLinearMap (P.space k) (P.space (k + l)) (P.appendMap k l u') :=
  (P.appendMap_spec k l u').1.1

/-- 本文 `def_linear_map_appending_fixed_tuple`：ρ_{u'}(τ_k(u)) = τ_{k+l}(cat_{k,l}(u, u'))。 -/
theorem appendMap_tau (k l : ℕ) (u' : Tuple V l) (u : Tuple V k) :
    P.appendMap k l u' (P.τ k u) = P.τ (k + l) (concatTuple u u') :=
  (P.appendMap_spec k l u').1.2 u

/-- 本文 `def_linear_map_appending_fixed_tuple`：τ_k と合成して (τ_{k+l})_{•,u'} になる線型写像は ρ_{u'} だけである。 -/
theorem appendMap_unique (k l : ℕ) (u' : Tuple V l) (g : P.T k → P.T (k + l))
    (hg : IsComplexLinearMap (P.space k) (P.space (k + l)) g)
    (hgτ : ∀ u : Tuple V k, g (P.τ k u) = fixSecond (P.τ (k + l)) u' u) :
    g = P.appendMap k l u' :=
  (P.appendMap_spec k l u').2 g ⟨hg, hgτ⟩

/-- 本文 `def_map_appending_tuples_to_fixed_tensor`：写像 ρ_•(F)(u') := ρ_{u'}(F)。 -/
noncomputable def appendMapValue (k l : ℕ) (F : P.T k) : Tuple V l → P.T (k + l) :=
  fun u' => P.appendMap k l u' F

/-- 本文 `claim_appending_map_value_is_multilinear_in_appended_tuple`：ρ_•(F) は l 重線型写像である。
a := u'[r ↦ x +_V y]、b := u'[r ↦ x]、c := u'[r ↦ y]、d := u'[r ↦ λ ·_V x] と置き、
ρ_b ⊞ ρ_c = ρ_a と λ ⊡ ρ_b = ρ_d を普遍性の一意性で示してから値を比べる。 -/
theorem appendMapValue_isMultilinearMap (k l : ℕ) (F : P.T k) :
    IsMultilinearMap SV (P.space (k + l)) l (P.appendMapValue k l F) where
  map_add u' r x y := by
    have hab : pointwiseSumMap (P.space (k + l)) (P.appendMap k l (replaceComponent u' r x))
        (P.appendMap k l (replaceComponent u' r y))
          = P.appendMap k l (replaceComponent u' r (SV.add x y)) := by
      apply P.appendMap_unique k l _ _
        (pointwiseSumMap_isLinearMap (P.appendMap_isLinearMap k l _) (P.appendMap_isLinearMap k l _))
      intro u
      calc pointwiseSumMap (P.space (k + l)) (P.appendMap k l (replaceComponent u' r x))
            (P.appendMap k l (replaceComponent u' r y)) (P.τ k u)
          = (P.space (k + l)).add (P.appendMap k l (replaceComponent u' r x) (P.τ k u))
              (P.appendMap k l (replaceComponent u' r y) (P.τ k u)) := rfl
        _ = (P.space (k + l)).add (P.τ (k + l) (concatTuple u (replaceComponent u' r x)))
              (P.τ (k + l) (concatTuple u (replaceComponent u' r y))) := by
            rw [P.appendMap_tau, P.appendMap_tau]
        _ = (P.space (k + l)).add
              (P.τ (k + l) (replaceComponent (concatTuple u u') (Idx.inSecond k r) x))
              (P.τ (k + l) (replaceComponent (concatTuple u u') (Idx.inSecond k r) y)) := by
            rw [concatTuple_replaceComponent_second, concatTuple_replaceComponent_second]
        _ = P.τ (k + l) (replaceComponent (concatTuple u u') (Idx.inSecond k r) (SV.add x y)) :=
            ((P.isTensorProduct (k + l)).multilinear.map_add (concatTuple u u') (Idx.inSecond k r)
              x y).symm
        _ = P.τ (k + l) (concatTuple u (replaceComponent u' r (SV.add x y))) := by
            rw [concatTuple_replaceComponent_second]
        _ = fixSecond (P.τ (k + l)) (replaceComponent u' r (SV.add x y)) u := rfl
    calc P.appendMapValue k l F (replaceComponent u' r (SV.add x y))
        = P.appendMap k l (replaceComponent u' r (SV.add x y)) F := rfl
      _ = pointwiseSumMap (P.space (k + l)) (P.appendMap k l (replaceComponent u' r x))
            (P.appendMap k l (replaceComponent u' r y)) F := by rw [hab]
      _ = (P.space (k + l)).add (P.appendMap k l (replaceComponent u' r x) F)
            (P.appendMap k l (replaceComponent u' r y) F) := rfl
      _ = (P.space (k + l)).add (P.appendMapValue k l F (replaceComponent u' r x))
            (P.appendMapValue k l F (replaceComponent u' r y)) := rfl
  map_smul u' r c x := by
    have hdb : pointwiseSmulMap (P.space (k + l)) c (P.appendMap k l (replaceComponent u' r x))
          = P.appendMap k l (replaceComponent u' r (SV.smul c x)) := by
      apply P.appendMap_unique k l _ _ (pointwiseSmulMap_isLinearMap (P.appendMap_isLinearMap k l _) c)
      intro u
      calc pointwiseSmulMap (P.space (k + l)) c (P.appendMap k l (replaceComponent u' r x)) (P.τ k u)
          = (P.space (k + l)).smul c (P.appendMap k l (replaceComponent u' r x) (P.τ k u)) := rfl
        _ = (P.space (k + l)).smul c (P.τ (k + l) (concatTuple u (replaceComponent u' r x))) := by
            rw [P.appendMap_tau]
        _ = (P.space (k + l)).smul c
              (P.τ (k + l) (replaceComponent (concatTuple u u') (Idx.inSecond k r) x)) := by
            rw [concatTuple_replaceComponent_second]
        _ = P.τ (k + l) (replaceComponent (concatTuple u u') (Idx.inSecond k r) (SV.smul c x)) :=
            ((P.isTensorProduct (k + l)).multilinear.map_smul (concatTuple u u') (Idx.inSecond k r)
              c x).symm
        _ = P.τ (k + l) (concatTuple u (replaceComponent u' r (SV.smul c x))) := by
            rw [concatTuple_replaceComponent_second]
        _ = fixSecond (P.τ (k + l)) (replaceComponent u' r (SV.smul c x)) u := rfl
    calc P.appendMapValue k l F (replaceComponent u' r (SV.smul c x))
        = P.appendMap k l (replaceComponent u' r (SV.smul c x)) F := rfl
      _ = pointwiseSmulMap (P.space (k + l)) c (P.appendMap k l (replaceComponent u' r x)) F := by
            rw [hdb]
      _ = (P.space (k + l)).smul c (P.appendMap k l (replaceComponent u' r x) F) := rfl
      _ = (P.space (k + l)).smul c (P.appendMapValue k l F (replaceComponent u' r x)) := rfl

/-- 本文 `def_linear_map_multiplying_fixed_tensor_on_left`：(T_l, τ_l) の普遍性を U = T_{k+l}、h = ρ_•(F) に当てた線型写像 θ_F。 -/
noncomputable def multiplyLeft (k l : ℕ) (F : P.T k) : P.T l → P.T (k + l) :=
  Classical.choose ((P.isTensorProduct l).universal (P.T (k + l)) (P.space (k + l))
    (P.appendMapValue k l F) (P.appendMapValue_isMultilinearMap k l F))

theorem multiplyLeft_spec (k l : ℕ) (F : P.T k) :
    (IsComplexLinearMap (P.space l) (P.space (k + l)) (P.multiplyLeft k l F) ∧
        ∀ u' : Tuple V l, P.multiplyLeft k l F (P.τ l u') = P.appendMapValue k l F u') ∧
      ∀ g : P.T l → P.T (k + l),
        (IsComplexLinearMap (P.space l) (P.space (k + l)) g ∧
            ∀ u' : Tuple V l, g (P.τ l u') = P.appendMapValue k l F u') →
          g = P.multiplyLeft k l F :=
  Classical.choose_spec ((P.isTensorProduct l).universal (P.T (k + l)) (P.space (k + l))
    (P.appendMapValue k l F) (P.appendMapValue_isMultilinearMap k l F))

/-- 本文 `def_linear_map_multiplying_fixed_tensor_on_left`：θ_F は線型写像である。 -/
theorem multiplyLeft_isLinearMap (k l : ℕ) (F : P.T k) :
    IsComplexLinearMap (P.space l) (P.space (k + l)) (P.multiplyLeft k l F) :=
  (P.multiplyLeft_spec k l F).1.1

/-- 本文 `def_linear_map_multiplying_fixed_tensor_on_left`：θ_F(τ_l(u')) = ρ_{u'}(F)。 -/
theorem multiplyLeft_tau (k l : ℕ) (F : P.T k) (u' : Tuple V l) :
    P.multiplyLeft k l F (P.τ l u') = P.appendMap k l u' F :=
  (P.multiplyLeft_spec k l F).1.2 u'

/-- 本文 `def_linear_map_multiplying_fixed_tensor_on_left`：τ_l と合成して ρ_•(F) になる線型写像は θ_F だけである。 -/
theorem multiplyLeft_unique (k l : ℕ) (F : P.T k) (g : P.T l → P.T (k + l))
    (hg : IsComplexLinearMap (P.space l) (P.space (k + l)) g)
    (hgτ : ∀ u' : Tuple V l, g (P.τ l u') = P.appendMapValue k l F u') :
    g = P.multiplyLeft k l F :=
  (P.multiplyLeft_spec k l F).2 g ⟨hg, hgτ⟩

/-- 本文 `def_product_of_tensors`：テンソルの積 m_{k,l}(F, G) := θ_F(G)。 -/
noncomputable def tensorMul (k l : ℕ) (F : P.T k) (G : P.T l) : P.T (k + l) :=
  P.multiplyLeft k l F G

/-- 本文 `claim_product_of_pure_tensors_is_pure_tensor_of_concatenation`：
m_{k,l}(τ_k(u), τ_l(u')) = τ_{k+l}(cat_{k,l}(u, u'))。 -/
theorem tensorMul_tau_tau (k l : ℕ) (u : Tuple V k) (u' : Tuple V l) :
    P.tensorMul k l (P.τ k u) (P.τ l u') = P.τ (k + l) (concatTuple u u') := calc
  P.tensorMul k l (P.τ k u) (P.τ l u') = P.multiplyLeft k l (P.τ k u) (P.τ l u') := rfl
  _ = P.appendMap k l u' (P.τ k u) := P.multiplyLeft_tau k l (P.τ k u) u'
  _ = P.τ (k + l) (concatTuple u u') := P.appendMap_tau k l u' u

/-- 本文 `claim_product_of_tensors_is_linear_in_second_factor` の一つ目の式。 -/
theorem tensorMul_add_right (k l : ℕ) (F : P.T k) (G G' : P.T l) :
    P.tensorMul k l F ((P.space l).add G G')
      = (P.space (k + l)).add (P.tensorMul k l F G) (P.tensorMul k l F G') := calc
  P.tensorMul k l F ((P.space l).add G G') = P.multiplyLeft k l F ((P.space l).add G G') := rfl
  _ = (P.space (k + l)).add (P.multiplyLeft k l F G) (P.multiplyLeft k l F G') :=
      (P.multiplyLeft_isLinearMap k l F).map_add G G'
  _ = (P.space (k + l)).add (P.tensorMul k l F G) (P.tensorMul k l F G') := rfl

/-- 本文 `claim_product_of_tensors_is_linear_in_second_factor` の二つ目の式。 -/
theorem tensorMul_smul_right (k l : ℕ) (F : P.T k) (c : ℂ) (G : P.T l) :
    P.tensorMul k l F ((P.space l).smul c G) = (P.space (k + l)).smul c (P.tensorMul k l F G) := calc
  P.tensorMul k l F ((P.space l).smul c G) = P.multiplyLeft k l F ((P.space l).smul c G) := rfl
  _ = (P.space (k + l)).smul c (P.multiplyLeft k l F G) :=
      (P.multiplyLeft_isLinearMap k l F).map_smul c G
  _ = (P.space (k + l)).smul c (P.tensorMul k l F G) := rfl

/-- 本文 `claim_product_of_tensors_is_linear_in_first_factor` の証明の前半：θ_F ⊞ θ_{F'} = θ_{F +_{T_k} F'}。 -/
theorem pointwiseSum_multiplyLeft (k l : ℕ) (F F' : P.T k) :
    pointwiseSumMap (P.space (k + l)) (P.multiplyLeft k l F) (P.multiplyLeft k l F')
      = P.multiplyLeft k l ((P.space k).add F F') := by
  apply P.multiplyLeft_unique k l _ _
    (pointwiseSumMap_isLinearMap (P.multiplyLeft_isLinearMap k l F) (P.multiplyLeft_isLinearMap k l F'))
  intro u'
  calc pointwiseSumMap (P.space (k + l)) (P.multiplyLeft k l F) (P.multiplyLeft k l F') (P.τ l u')
      = (P.space (k + l)).add (P.multiplyLeft k l F (P.τ l u')) (P.multiplyLeft k l F' (P.τ l u')) := rfl
    _ = (P.space (k + l)).add (P.appendMap k l u' F) (P.appendMap k l u' F') := by
        rw [P.multiplyLeft_tau, P.multiplyLeft_tau]
    _ = P.appendMap k l u' ((P.space k).add F F') :=
        ((P.appendMap_isLinearMap k l u').map_add F F').symm
    _ = P.appendMapValue k l ((P.space k).add F F') u' := rfl

/-- 本文 `claim_product_of_tensors_is_linear_in_first_factor` の証明の前半：λ ⊡ θ_F = θ_{λ ·_{T_k} F}。 -/
theorem pointwiseSmul_multiplyLeft (k l : ℕ) (c : ℂ) (F : P.T k) :
    pointwiseSmulMap (P.space (k + l)) c (P.multiplyLeft k l F)
      = P.multiplyLeft k l ((P.space k).smul c F) := by
  apply P.multiplyLeft_unique k l _ _ (pointwiseSmulMap_isLinearMap (P.multiplyLeft_isLinearMap k l F) c)
  intro u'
  calc pointwiseSmulMap (P.space (k + l)) c (P.multiplyLeft k l F) (P.τ l u')
      = (P.space (k + l)).smul c (P.multiplyLeft k l F (P.τ l u')) := rfl
    _ = (P.space (k + l)).smul c (P.appendMap k l u' F) := by rw [P.multiplyLeft_tau]
    _ = P.appendMap k l u' ((P.space k).smul c F) :=
        ((P.appendMap_isLinearMap k l u').map_smul c F).symm
    _ = P.appendMapValue k l ((P.space k).smul c F) u' := rfl

/-- 本文 `claim_product_of_tensors_is_linear_in_first_factor` の一つ目の式。 -/
theorem tensorMul_add_left (k l : ℕ) (F F' : P.T k) (G : P.T l) :
    P.tensorMul k l ((P.space k).add F F') G
      = (P.space (k + l)).add (P.tensorMul k l F G) (P.tensorMul k l F' G) := calc
  P.tensorMul k l ((P.space k).add F F') G = P.multiplyLeft k l ((P.space k).add F F') G := rfl
  _ = pointwiseSumMap (P.space (k + l)) (P.multiplyLeft k l F) (P.multiplyLeft k l F') G := by
      rw [P.pointwiseSum_multiplyLeft k l F F']
  _ = (P.space (k + l)).add (P.multiplyLeft k l F G) (P.multiplyLeft k l F' G) := rfl
  _ = (P.space (k + l)).add (P.tensorMul k l F G) (P.tensorMul k l F' G) := rfl

/-- 本文 `claim_product_of_tensors_is_linear_in_first_factor` の二つ目の式。 -/
theorem tensorMul_smul_left (k l : ℕ) (c : ℂ) (F : P.T k) (G : P.T l) :
    P.tensorMul k l ((P.space k).smul c F) G = (P.space (k + l)).smul c (P.tensorMul k l F G) := calc
  P.tensorMul k l ((P.space k).smul c F) G = P.multiplyLeft k l ((P.space k).smul c F) G := rfl
  _ = pointwiseSmulMap (P.space (k + l)) c (P.multiplyLeft k l F) G := by
      rw [P.pointwiseSmul_multiplyLeft k l c F]
  _ = (P.space (k + l)).smul c (P.multiplyLeft k l F G) := rfl
  _ = (P.space (k + l)).smul c (P.tensorMul k l F G) := rfl

/-- 本文 `def_map_multiplying_fixed_tensor_on_right`：G ∈ T_l を後ろに掛ける写像 θ^R_G(F) := m_{k,l}(F, G)。 -/
noncomputable def multiplyRight (k l : ℕ) (G : P.T l) : P.T k → P.T (k + l) :=
  fun F => P.tensorMul k l F G

end TensorPowers

end CliffordMatrixIsomorphism.ComplexVectorSpace
