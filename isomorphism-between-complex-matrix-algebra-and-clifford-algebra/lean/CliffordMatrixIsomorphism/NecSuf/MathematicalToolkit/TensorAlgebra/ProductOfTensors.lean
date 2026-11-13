/-
節「テンソル代数」のうち、テンソルの積とその双線型性の必要十分版。具体版
`MathematicalToolkit/TensorAlgebra/ProductOfTensors.lean` と同じ structure・def と calc の行で、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                  このファイル                         K に要るもの
  def_linear_map_appending_fixed_tuple                          appendMap 等                         なし
  claim_appending_map_value_is_multilinear_in_appended_tuple    appendMapValue_isMultilinearMap      乗法の交換法則
  def_linear_map_multiplying_fixed_tensor_on_left               multiplyLeft 等                      乗法の交換法則（前の主張を経由）
  def_product_of_tensors                                        tensorMul                            同上
  claim_product_of_pure_tensors_is_pure_tensor_of_concatenation tensorMul_tau_tau                    同上（ほかに使わない）
  claim_product_of_tensors_is_linear_in_second_factor           tensorMul_add_right・smul_right      同上（ほかに使わない）
  claim_product_of_tensors_is_linear_in_first_factor            tensorMul_add_left・smul_left        同上

乗法の交換法則は、ρ_•(F) がスカラー倍を保つことを示す行で、λ ⊡ ρ_b が線型写像であること
（`pointwiseSmulMap_isLinearMap` の μ · λ = λ · μ）に要る。λ はどの係数でもよいので、どの λ もどの元とも交換することが要る。
θ_F を定めるには ρ_•(F) が l 重線型写像であることが要るので、θ_F とテンソルの積 m_{k,l} はこの性質を仮定に持つ。
前の因子についての線型性は、λ ⊡ θ_F が線型写像であることでもう一度この性質を使う。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.Concatenation
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.PointwiseLinearMaps

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v uK

variable {K : Type uK} [Add K] [Mul K] [One K] {V : Type u}

/-- 本文の「各 j ∈ ℤ_{≥0} について (T_j, τ_j) を V の j 重テンソル積とする」：j 重テンソル積の族。 -/
structure TensorPowers (SV : VectorSpace K V) where
  /-- 各 j の線型空間 T_j の集合 -/
  T : ℕ → Type v
  /-- T_j の K 上の線型空間の構造 -/
  space : ∀ j : ℕ, VectorSpace K (T j)
  /-- j 重線型写像 τ_j -/
  τ : ∀ j : ℕ, Tuple V j → T j
  /-- (T_j, τ_j) は V の j 重テンソル積 -/
  isTensorProduct : ∀ j : ℕ, IsTensorProduct.{u, v, v, uK} SV j (space j) (τ j)

namespace TensorPowers

variable {SV : VectorSpace K V} (P : TensorPowers.{u, v} SV)

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
    (IsLinearMap (P.space k) (P.space (k + l)) (P.appendMap k l u') ∧
        ∀ u : Tuple V k, P.appendMap k l u' (P.τ k u) = fixSecond (P.τ (k + l)) u' u) ∧
      ∀ g : P.T k → P.T (k + l),
        (IsLinearMap (P.space k) (P.space (k + l)) g ∧
            ∀ u : Tuple V k, g (P.τ k u) = fixSecond (P.τ (k + l)) u' u) →
          g = P.appendMap k l u' :=
  Classical.choose_spec ((P.isTensorProduct k).universal (P.T (k + l)) (P.space (k + l))
    (fixSecond (P.τ (k + l)) u') (P.fixSecond_tau_isMultilinearMap k l u'))

/-- 本文 `def_linear_map_appending_fixed_tuple`：ρ_{u'} は線型写像である。 -/
theorem appendMap_isLinearMap (k l : ℕ) (u' : Tuple V l) :
    IsLinearMap (P.space k) (P.space (k + l)) (P.appendMap k l u') :=
  (P.appendMap_spec k l u').1.1

/-- 本文 `def_linear_map_appending_fixed_tuple`：ρ_{u'}(τ_k(u)) = τ_{k+l}(cat_{k,l}(u, u'))。 -/
theorem appendMap_tau (k l : ℕ) (u' : Tuple V l) (u : Tuple V k) :
    P.appendMap k l u' (P.τ k u) = P.τ (k + l) (concatTuple u u') :=
  (P.appendMap_spec k l u').1.2 u

/-- 本文 `def_linear_map_appending_fixed_tuple`：τ_k と合成して (τ_{k+l})_{•,u'} になる線型写像は ρ_{u'} だけである。 -/
theorem appendMap_unique (k l : ℕ) (u' : Tuple V l) (g : P.T k → P.T (k + l))
    (hg : IsLinearMap (P.space k) (P.space (k + l)) g)
    (hgτ : ∀ u : Tuple V k, g (P.τ k u) = fixSecond (P.τ (k + l)) u' u) :
    g = P.appendMap k l u' :=
  (P.appendMap_spec k l u').2 g ⟨hg, hgτ⟩

/-- 本文 `claim_appending_map_value_is_multilinear_in_appended_tuple` の写像 ρ_•(F)(u') := ρ_{u'}(F)。 -/
noncomputable def appendMapValue (k l : ℕ) (F : P.T k) : Tuple V l → P.T (k + l) :=
  fun u' => P.appendMap k l u' F

/-- 本文 `claim_appending_map_value_is_multilinear_in_appended_tuple`：ρ_•(F) は l 重線型写像である。
a := u'[r ↦ x +_V y]、b := u'[r ↦ x]、c := u'[r ↦ y]、d := u'[r ↦ λ ·_V x] と置き、
ρ_b ⊞ ρ_c = ρ_a と λ ⊡ ρ_b = ρ_d を普遍性の一意性で示してから値を比べる。 -/
theorem appendMapValue_isMultilinearMap (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (F : P.T k) :
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
      apply P.appendMap_unique k l _ _ (pointwiseSmulMap_isLinearMap (P.appendMap_isLinearMap k l _) c (hcomm c))
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
noncomputable def multiplyLeft (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (F : P.T k) : P.T l → P.T (k + l) :=
  Classical.choose ((P.isTensorProduct l).universal (P.T (k + l)) (P.space (k + l))
    (P.appendMapValue k l F) (P.appendMapValue_isMultilinearMap hcomm k l F))

theorem multiplyLeft_spec (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (F : P.T k) :
    (IsLinearMap (P.space l) (P.space (k + l)) (P.multiplyLeft hcomm k l F) ∧
        ∀ u' : Tuple V l, P.multiplyLeft hcomm k l F (P.τ l u') = P.appendMapValue k l F u') ∧
      ∀ g : P.T l → P.T (k + l),
        (IsLinearMap (P.space l) (P.space (k + l)) g ∧
            ∀ u' : Tuple V l, g (P.τ l u') = P.appendMapValue k l F u') →
          g = P.multiplyLeft hcomm k l F :=
  Classical.choose_spec ((P.isTensorProduct l).universal (P.T (k + l)) (P.space (k + l))
    (P.appendMapValue k l F) (P.appendMapValue_isMultilinearMap hcomm k l F))

/-- 本文 `def_linear_map_multiplying_fixed_tensor_on_left`：θ_F は線型写像である。 -/
theorem multiplyLeft_isLinearMap (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (F : P.T k) :
    IsLinearMap (P.space l) (P.space (k + l)) (P.multiplyLeft hcomm k l F) :=
  (P.multiplyLeft_spec hcomm k l F).1.1

/-- 本文 `def_linear_map_multiplying_fixed_tensor_on_left`：θ_F(τ_l(u')) = ρ_{u'}(F)。 -/
theorem multiplyLeft_tau (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (F : P.T k) (u' : Tuple V l) :
    P.multiplyLeft hcomm k l F (P.τ l u') = P.appendMap k l u' F :=
  (P.multiplyLeft_spec hcomm k l F).1.2 u'

/-- 本文 `def_linear_map_multiplying_fixed_tensor_on_left`：τ_l と合成して ρ_•(F) になる線型写像は θ_F だけである。 -/
theorem multiplyLeft_unique (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (F : P.T k) (g : P.T l → P.T (k + l))
    (hg : IsLinearMap (P.space l) (P.space (k + l)) g)
    (hgτ : ∀ u' : Tuple V l, g (P.τ l u') = P.appendMapValue k l F u') :
    g = P.multiplyLeft hcomm k l F :=
  (P.multiplyLeft_spec hcomm k l F).2 g ⟨hg, hgτ⟩

/-- 本文 `def_product_of_tensors`：テンソルの積 m_{k,l}(F, G) := θ_F(G)。 -/
noncomputable def tensorMul (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (F : P.T k) (G : P.T l) : P.T (k + l) :=
  P.multiplyLeft hcomm k l F G

/-- 本文 `claim_product_of_pure_tensors_is_pure_tensor_of_concatenation`：
m_{k,l}(τ_k(u), τ_l(u')) = τ_{k+l}(cat_{k,l}(u, u'))。 -/
theorem tensorMul_tau_tau (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (u : Tuple V k) (u' : Tuple V l) :
    P.tensorMul hcomm k l (P.τ k u) (P.τ l u') = P.τ (k + l) (concatTuple u u') := calc
  P.tensorMul hcomm k l (P.τ k u) (P.τ l u') = P.multiplyLeft hcomm k l (P.τ k u) (P.τ l u') := rfl
  _ = P.appendMap k l u' (P.τ k u) := P.multiplyLeft_tau hcomm k l (P.τ k u) u'
  _ = P.τ (k + l) (concatTuple u u') := P.appendMap_tau k l u' u

/-- 本文 `claim_product_of_tensors_is_linear_in_second_factor` の一つ目の式。 -/
theorem tensorMul_add_right (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (F : P.T k) (G G' : P.T l) :
    P.tensorMul hcomm k l F ((P.space l).add G G')
      = (P.space (k + l)).add (P.tensorMul hcomm k l F G) (P.tensorMul hcomm k l F G') := calc
  P.tensorMul hcomm k l F ((P.space l).add G G') = P.multiplyLeft hcomm k l F ((P.space l).add G G') := rfl
  _ = (P.space (k + l)).add (P.multiplyLeft hcomm k l F G) (P.multiplyLeft hcomm k l F G') :=
      (P.multiplyLeft_isLinearMap hcomm k l F).map_add G G'
  _ = (P.space (k + l)).add (P.tensorMul hcomm k l F G) (P.tensorMul hcomm k l F G') := rfl

/-- 本文 `claim_product_of_tensors_is_linear_in_second_factor` の二つ目の式。 -/
theorem tensorMul_smul_right (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (F : P.T k) (c : K) (G : P.T l) :
    P.tensorMul hcomm k l F ((P.space l).smul c G) = (P.space (k + l)).smul c (P.tensorMul hcomm k l F G) := calc
  P.tensorMul hcomm k l F ((P.space l).smul c G) = P.multiplyLeft hcomm k l F ((P.space l).smul c G) := rfl
  _ = (P.space (k + l)).smul c (P.multiplyLeft hcomm k l F G) :=
      (P.multiplyLeft_isLinearMap hcomm k l F).map_smul c G
  _ = (P.space (k + l)).smul c (P.tensorMul hcomm k l F G) := rfl

/-- 本文 `claim_product_of_tensors_is_linear_in_first_factor` の証明の前半：θ_F ⊞ θ_{F'} = θ_{F +_{T_k} F'}。 -/
theorem pointwiseSum_multiplyLeft (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (F F' : P.T k) :
    pointwiseSumMap (P.space (k + l)) (P.multiplyLeft hcomm k l F) (P.multiplyLeft hcomm k l F')
      = P.multiplyLeft hcomm k l ((P.space k).add F F') := by
  apply P.multiplyLeft_unique hcomm k l _ _
    (pointwiseSumMap_isLinearMap (P.multiplyLeft_isLinearMap hcomm k l F) (P.multiplyLeft_isLinearMap hcomm k l F'))
  intro u'
  calc pointwiseSumMap (P.space (k + l)) (P.multiplyLeft hcomm k l F) (P.multiplyLeft hcomm k l F') (P.τ l u')
      = (P.space (k + l)).add (P.multiplyLeft hcomm k l F (P.τ l u')) (P.multiplyLeft hcomm k l F' (P.τ l u')) := rfl
    _ = (P.space (k + l)).add (P.appendMap k l u' F) (P.appendMap k l u' F') := by
        rw [P.multiplyLeft_tau, P.multiplyLeft_tau]
    _ = P.appendMap k l u' ((P.space k).add F F') :=
        ((P.appendMap_isLinearMap k l u').map_add F F').symm
    _ = P.appendMapValue k l ((P.space k).add F F') u' := rfl

/-- 本文 `claim_product_of_tensors_is_linear_in_first_factor` の証明の前半：λ ⊡ θ_F = θ_{λ ·_{T_k} F}。 -/
theorem pointwiseSmul_multiplyLeft (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (c : K) (F : P.T k) :
    pointwiseSmulMap (P.space (k + l)) c (P.multiplyLeft hcomm k l F)
      = P.multiplyLeft hcomm k l ((P.space k).smul c F) := by
  apply P.multiplyLeft_unique hcomm k l _ _ (pointwiseSmulMap_isLinearMap (P.multiplyLeft_isLinearMap hcomm k l F) c (hcomm c))
  intro u'
  calc pointwiseSmulMap (P.space (k + l)) c (P.multiplyLeft hcomm k l F) (P.τ l u')
      = (P.space (k + l)).smul c (P.multiplyLeft hcomm k l F (P.τ l u')) := rfl
    _ = (P.space (k + l)).smul c (P.appendMap k l u' F) := by rw [P.multiplyLeft_tau]
    _ = P.appendMap k l u' ((P.space k).smul c F) :=
        ((P.appendMap_isLinearMap k l u').map_smul c F).symm
    _ = P.appendMapValue k l ((P.space k).smul c F) u' := rfl

/-- 本文 `claim_product_of_tensors_is_linear_in_first_factor` の一つ目の式。 -/
theorem tensorMul_add_left (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (F F' : P.T k) (G : P.T l) :
    P.tensorMul hcomm k l ((P.space k).add F F') G
      = (P.space (k + l)).add (P.tensorMul hcomm k l F G) (P.tensorMul hcomm k l F' G) := calc
  P.tensorMul hcomm k l ((P.space k).add F F') G = P.multiplyLeft hcomm k l ((P.space k).add F F') G := rfl
  _ = pointwiseSumMap (P.space (k + l)) (P.multiplyLeft hcomm k l F) (P.multiplyLeft hcomm k l F') G := by
      rw [P.pointwiseSum_multiplyLeft hcomm k l F F']
  _ = (P.space (k + l)).add (P.multiplyLeft hcomm k l F G) (P.multiplyLeft hcomm k l F' G) := rfl
  _ = (P.space (k + l)).add (P.tensorMul hcomm k l F G) (P.tensorMul hcomm k l F' G) := rfl

/-- 本文 `claim_product_of_tensors_is_linear_in_first_factor` の二つ目の式。 -/
theorem tensorMul_smul_left (hcomm : ∀ a b : K, a * b = b * a) (k l : ℕ) (c : K) (F : P.T k) (G : P.T l) :
    P.tensorMul hcomm k l ((P.space k).smul c F) G = (P.space (k + l)).smul c (P.tensorMul hcomm k l F G) := calc
  P.tensorMul hcomm k l ((P.space k).smul c F) G = P.multiplyLeft hcomm k l ((P.space k).smul c F) G := rfl
  _ = pointwiseSmulMap (P.space (k + l)) c (P.multiplyLeft hcomm k l F) G := by
      rw [P.pointwiseSmul_multiplyLeft hcomm k l c F]
  _ = (P.space (k + l)).smul c (P.multiplyLeft hcomm k l F G) := rfl
  _ = (P.space (k + l)).smul c (P.tensorMul hcomm k l F G) := rfl

end TensorPowers

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
