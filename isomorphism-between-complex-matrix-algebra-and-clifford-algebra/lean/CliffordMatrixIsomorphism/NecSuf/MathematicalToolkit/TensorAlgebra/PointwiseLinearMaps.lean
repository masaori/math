/-
節「テンソル代数」のうち、線型写像の各点ごとの和とスカラー倍が線型写像であることの必要十分版。具体版
`MathematicalToolkit/TensorAlgebra/PointwiseLinearMaps.lean` と同じ def と calc の行で、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                  このファイル                      K に要るもの
  claim_pointwise_sum_of_linear_maps_is_linear_map              pointwiseSumMap_isLinearMap       なし（K の公理を一つも使わない）
  claim_pointwise_scalar_multiple_of_linear_map_is_linear_map   pointwiseSmulMap_isLinearMap      μ がどの λ とも交換すること（μ · λ = λ · μ）

μ ⊡ f がスカラー倍を保つには、μ ·_U (λ ·_U f(x)) を λ ·_U (μ ·_U f(x)) へ移す行で μ · λ = λ · μ が要る。
乗法が可換でない係数では、中心に入らない μ について μ ⊡ f は線型写像にならない。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v uK

variable {K : Type uK} [Add K] [Mul K] [One K] {V : Type u} {U : Type v}

/-- 本文 `claim_pointwise_sum_of_linear_maps_is_linear_map` の写像 (f ⊞ g)(x) := f(x) +_U g(x)。 -/
def pointwiseSumMap (SU : VectorSpace K U) (f g : V → U) : V → U :=
  fun x => SU.add (f x) (g x)

/-- 本文 `claim_pointwise_scalar_multiple_of_linear_map_is_linear_map` の写像 (μ ⊡ f)(x) := μ ·_U f(x)。 -/
def pointwiseSmulMap (SU : VectorSpace K U) (μ : K) (f : V → U) : V → U :=
  fun x => SU.smul μ (f x)

/-- 本文 `claim_pointwise_sum_of_linear_maps_is_linear_map`：二つの線型写像の各点ごとの和 f ⊞ g は線型写像である。 -/
theorem pointwiseSumMap_isLinearMap {SV : VectorSpace K V} {SU : VectorSpace K U}
    {f g : V → U} (hf : IsLinearMap SV SU f) (hg : IsLinearMap SV SU g) :
    IsLinearMap SV SU (pointwiseSumMap SU f g) where
  map_add x y := calc
    pointwiseSumMap SU f g (SV.add x y) = SU.add (f (SV.add x y)) (g (SV.add x y)) := rfl
    _ = SU.add (SU.add (f x) (f y)) (g (SV.add x y)) := by rw [hf.map_add x y]
    _ = SU.add (SU.add (f x) (f y)) (SU.add (g x) (g y)) := by rw [hg.map_add x y]
    _ = SU.add (f x) (SU.add (f y) (SU.add (g x) (g y))) :=
          SU.add_assoc (f x) (f y) (SU.add (g x) (g y))
    _ = SU.add (f x) (SU.add (SU.add (f y) (g x)) (g y)) := by
          rw [SU.add_assoc (f y) (g x) (g y)]
    _ = SU.add (f x) (SU.add (SU.add (g x) (f y)) (g y)) := by rw [SU.add_comm (f y) (g x)]
    _ = SU.add (f x) (SU.add (g x) (SU.add (f y) (g y))) := by
          rw [SU.add_assoc (g x) (f y) (g y)]
    _ = SU.add (SU.add (f x) (g x)) (SU.add (f y) (g y)) :=
          (SU.add_assoc (f x) (g x) (SU.add (f y) (g y))).symm
    _ = SU.add (pointwiseSumMap SU f g x) (pointwiseSumMap SU f g y) := rfl
  map_smul l x := calc
    pointwiseSumMap SU f g (SV.smul l x) = SU.add (f (SV.smul l x)) (g (SV.smul l x)) := rfl
    _ = SU.add (SU.smul l (f x)) (g (SV.smul l x)) := by rw [hf.map_smul l x]
    _ = SU.add (SU.smul l (f x)) (SU.smul l (g x)) := by rw [hg.map_smul l x]
    _ = SU.smul l (SU.add (f x) (g x)) := (SU.smul_add l (f x) (g x)).symm
    _ = SU.smul l (pointwiseSumMap SU f g x) := rfl

/-- 本文 `claim_pointwise_scalar_multiple_of_linear_map_is_linear_map`：線型写像の各点ごとのスカラー倍 μ ⊡ f は線型写像である。 -/
theorem pointwiseSmulMap_isLinearMap {SV : VectorSpace K V} {SU : VectorSpace K U}
    {f : V → U} (hf : IsLinearMap SV SU f) (μ : K) (hμ : ∀ l : K, μ * l = l * μ) :
    IsLinearMap SV SU (pointwiseSmulMap SU μ f) where
  map_add x y := calc
    pointwiseSmulMap SU μ f (SV.add x y) = SU.smul μ (f (SV.add x y)) := rfl
    _ = SU.smul μ (SU.add (f x) (f y)) := by rw [hf.map_add x y]
    _ = SU.add (SU.smul μ (f x)) (SU.smul μ (f y)) := SU.smul_add μ (f x) (f y)
    _ = SU.add (pointwiseSmulMap SU μ f x) (pointwiseSmulMap SU μ f y) := rfl
  map_smul l x := calc
    pointwiseSmulMap SU μ f (SV.smul l x) = SU.smul μ (f (SV.smul l x)) := rfl
    _ = SU.smul μ (SU.smul l (f x)) := by rw [hf.map_smul l x]
    _ = SU.smul (μ * l) (f x) := (SU.smul_assoc μ l (f x)).symm
    _ = SU.smul (l * μ) (f x) := by rw [hμ l]
    _ = SU.smul l (SU.smul μ (f x)) := SU.smul_assoc l μ (f x)
    _ = SU.smul l (pointwiseSmulMap SU μ f x) := rfl

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
