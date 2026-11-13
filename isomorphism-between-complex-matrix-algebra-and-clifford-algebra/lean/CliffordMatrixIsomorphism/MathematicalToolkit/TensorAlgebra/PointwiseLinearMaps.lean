/-
節「テンソル代数」のうち、線型写像の各点ごとの和とスカラー倍が線型写像であることの具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                  このファイル
  claim_pointwise_sum_of_linear_maps_is_linear_map              pointwiseSumMap（f ⊞ g）・pointwiseSumMap_isLinearMap
  claim_pointwise_scalar_multiple_of_linear_map_is_linear_map   pointwiseSmulMap（μ ⊡ f）・pointwiseSmulMap_isLinearMap

本文は f ⊞ g と μ ⊡ f を主張の文の中で定めるので、Lean ではその式を def に書き、docstring に主張のラベルを書く。

必要十分版は `NecSuf/MathematicalToolkit/TensorAlgebra/PointwiseLinearMaps.lean`、導出版は `TensorAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v

variable {V : Type u} {U : Type v}

/-- 本文 `claim_pointwise_sum_of_linear_maps_is_linear_map` の写像 (f ⊞ g)(x) := f(x) +_U g(x)。 -/
def pointwiseSumMap (SU : ComplexVectorSpace U) (f g : V → U) : V → U :=
  fun x => SU.add (f x) (g x)

/-- 本文 `claim_pointwise_scalar_multiple_of_linear_map_is_linear_map` の写像 (μ ⊡ f)(x) := μ ·_U f(x)。 -/
def pointwiseSmulMap (SU : ComplexVectorSpace U) (μ : ℂ) (f : V → U) : V → U :=
  fun x => SU.smul μ (f x)

/-- 本文 `claim_pointwise_sum_of_linear_maps_is_linear_map`：二つの線型写像の各点ごとの和 f ⊞ g は線型写像である。 -/
theorem pointwiseSumMap_isLinearMap {SV : ComplexVectorSpace V} {SU : ComplexVectorSpace U}
    {f g : V → U} (hf : IsComplexLinearMap SV SU f) (hg : IsComplexLinearMap SV SU g) :
    IsComplexLinearMap SV SU (pointwiseSumMap SU f g) where
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
theorem pointwiseSmulMap_isLinearMap {SV : ComplexVectorSpace V} {SU : ComplexVectorSpace U}
    {f : V → U} (hf : IsComplexLinearMap SV SU f) (μ : ℂ) :
    IsComplexLinearMap SV SU (pointwiseSmulMap SU μ f) where
  map_add x y := calc
    pointwiseSmulMap SU μ f (SV.add x y) = SU.smul μ (f (SV.add x y)) := rfl
    _ = SU.smul μ (SU.add (f x) (f y)) := by rw [hf.map_add x y]
    _ = SU.add (SU.smul μ (f x)) (SU.smul μ (f y)) := SU.smul_add μ (f x) (f y)
    _ = SU.add (pointwiseSmulMap SU μ f x) (pointwiseSmulMap SU μ f y) := rfl
  map_smul l x := calc
    pointwiseSmulMap SU μ f (SV.smul l x) = SU.smul μ (f (SV.smul l x)) := rfl
    _ = SU.smul μ (SU.smul l (f x)) := by rw [hf.map_smul l x]
    _ = SU.smul (μ * l) (f x) := (SU.smul_assoc μ l (f x)).symm
    _ = SU.smul (l * μ) (f x) := by rw [mul_comm μ l]
    _ = SU.smul l (SU.smul μ (f x)) := SU.smul_assoc l μ (f x)
    _ = SU.smul l (pointwiseSmulMap SU μ f x) := rfl

end CliffordMatrixIsomorphism.ComplexVectorSpace
