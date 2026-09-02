/-
# 必要十分版: 3 つの共役の合成（サンドイッチ）が `B_1 B_2 B_1` で作用すること

対応する人手証明のラベル:

* **`T_V_plus_check_Z_Y`**（`structured-latex/content/014_even_sector_T_action.ts` の
  `evensectorT_010_claim_T_V_plus_action`）
* **`calc_of_TxT_check_Z_Y`**（同 `evensectorT_008_claim_product_action`）
* **`linearity_of_T_on_check_Z_Y`**（同 `evensectorT_006_claim_linearity_of_T`）
* **`linearity_of_T_V2`**（同 `evensectorT_006a_claim_linearity_of_T_V2`）
* 008 章の対応物 **`<T_V_hatZ_hatY>`**（`008_TV1_hatZ_hatY_part1.ts` の
  `TV1_hatZ_hatY_018_claim_T_V_action`）

**具体版は `Ising2D/Part014/Claim010_TVPlusAction.lean`**（半整数運動量）と
`Ising2D/Part008/Claim012_TVActions.lean`（整数運動量）。
**この 2 つは本ファイルの同じ定理の別の特殊化である**ことを
`Part014/Claim010_TVPlusAction.lean` の末尾で明示的に示している。

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

## 何が本質的か

原文は `T_{(V^{(+)})}(check(Z)_μ)` を求めるのに

  `T_actions_on_check_Z_Y` → `linearity_of_T_V2`
  → `calc_of_TxT_check_Z_Y` → `linearity_of_T_on_check_Z_Y`
  → もう一度 `calc_of_TxT_check_Z_Y`

という 4 段の往復を行っている。この往復に効いているのは

* **`T` が ℂ 線型であること**、および
* **`(T z, T y) = (z, y) B` という記法のもとで合成が行列の積になること**

の 2 つだけである。指数関数も、共役であることも、行列であることも、
`z, y` が何であるかも効いていない。実際、下の `actsBy_sandwich` は
**ℂ 上の任意の加群と任意の ℂ 線型写像**について成り立ち、
証明は既存の合成則 `Ising2D.ActsBy.comp` を 2 回使うだけである
（線型性はその中に埋め込まれている）。

したがって原文の 4 段は「線型写像の合成 ↔ 行列の積」という 1 点に集約される。
`B_1(θ) B_2 B_1(θ) = A(θ)` は別の（純粋に 2×2 行列の）計算であり、
`Ising2D.B1_mul_B2_mul_B1_eq_AMat` が担当する。

## 記法について

行ベクトル記法の述語 `Ising2D.ActsBy`（`Part008/Definition016_TV.lean`）は
`{A : Type*} [AddCommMonoid A] [Module ℂ A]` で定義された**記法だけの道具**なので、
必要十分版でもそのまま使う（重複定義を避ける）。
-/
import Ising2D.NecSuf.TVAction
import Ising2D.Part008.Definition016_TV

namespace Ising2D.NecSuf

section Sandwich

variable {A : Type*} [AddCommMonoid A] [Module ℂ A]

/-- **必要十分版の本体**（人手証明 `<T_V_plus_check_Z_Y>` / `<T_V_hatZ_hatY>` の合成の部分）:

`T_1` が `(z, y)` に `B_1` で、`T_2` が `B_2` で作用するなら、
サンドイッチ `T_1 ∘ T_2 ∘ T_1` は `B_1 B_2 B_1` で作用する。

ℂ 上の任意の加群と任意の ℂ 線型写像について成り立つ。
指数関数も共役も行列も要らない。 -/
theorem actsBy_sandwich {T₁ T₂ : A →ₗ[ℂ] A} {z y : A} {B₁ B₂ : Matrix (Fin 2) (Fin 2) ℂ}
    (h₁ : Ising2D.ActsBy T₁ z y B₁) (h₂ : Ising2D.ActsBy T₂ z y B₂) :
    Ising2D.ActsBy (T₁ ∘ₗ T₂ ∘ₗ T₁) z y (B₁ * B₂ * B₁) := by
  have h := (h₁.comp h₂).comp h₁
  rwa [← mul_assoc] at h

/-- 上を `T_{(V)} = T_{g_1} ∘ T_{g_2} ∘ T_{g_1}`（`Ising2D.TV`）の形で述べたもの。 -/
theorem actsBy_TV_sandwich {𝔸 : Type*} [Ring 𝔸] [Algebra ℂ 𝔸] {g₁ g₂ : 𝔸ˣ} {z y : 𝔸}
    {B₁ B₂ : Matrix (Fin 2) (Fin 2) ℂ}
    (h₁ : Ising2D.ActsBy (Ising2D.TConj g₁).toLinearMap z y B₁)
    (h₂ : Ising2D.ActsBy (Ising2D.TConj g₂).toLinearMap z y B₂) :
    Ising2D.ActsBy (Ising2D.TV g₁ g₂).toLinearMap z y (B₁ * B₂ * B₁) :=
  actsBy_sandwich h₁ h₂

end Sandwich

end Ising2D.NecSuf
