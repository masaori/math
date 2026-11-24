/-
# 共役作用 `T_g`・`T_{(V)}` と行ベクトル記法（必要十分版からの導出）

具体版 `DefinitionTgAndTV.lean` の `Ising2D.ActsBy`・`Ising2D.TConj`・`Ising2D.TV` と、必要十分版
`Ising2D/NecSuf/TVActionSandwich.lean` の `NecSuf.ActsBy'`・`NecSuf.TConj'`・`NecSuf.TV'` は、同じ式で定義した同じものである
（具体版の `TConj`・`TV` は ℂ 代数の自己同型、必要十分版の `TConj'`・`TV'` は同じ式の ℂ 線型写像で、具体版の側は
`toLinearMap` で比べる）。必要十分版の主張（`NecSuf.actsBy_TV_sandwich`）から具体版を導くときは、この一致で読み替える。
-/
import Ising2D.MathematicalTools.InvertibleMatricesLinearMapCorrespondenceAndConjugation.DefinitionTgAndTV
import Ising2D.NecSuf.TVActionSandwich

namespace Ising2D

/-- 具体版の行ベクトル記法の述語は、必要十分版の述語と一致する（同じ式の定義）。 -/
theorem actsBy_iff_actsBy_necSuf {A : Type*} [AddCommMonoid A] [Module ℂ A]
    (T : A →ₗ[ℂ] A) (z y : A) (B : Matrix (Fin 2) (Fin 2) ℂ) :
    ActsBy T z y B ↔ NecSuf.ActsBy' T z y B :=
  Iff.rfl

section Conj

variable {𝔸 : Type*} [Ring 𝔸] [Algebra ℂ 𝔸]

/-- 具体版の `T_g` を ℂ 線型写像として見たものは、必要十分版の `T_g` と一致する（同じ式 `X ↦ g X g⁻¹`）。 -/
theorem TConj_toLinearMap_eq_TConj_necSuf (g : 𝔸ˣ) :
    (TConj g).toLinearMap = NecSuf.TConj' g :=
  LinearMap.ext fun _ => rfl

/-- 具体版の `T_{(V)}` を ℂ 線型写像として見たものは、必要十分版の `T_{(V)}` と一致する（同じ 3 つの合成）。 -/
theorem TV_toLinearMap_eq_TV_necSuf (g₁ g₂ : 𝔸ˣ) :
    (TV g₁ g₂).toLinearMap = NecSuf.TV' g₁ g₂ :=
  LinearMap.ext fun _ => rfl

end Conj

end Ising2D
