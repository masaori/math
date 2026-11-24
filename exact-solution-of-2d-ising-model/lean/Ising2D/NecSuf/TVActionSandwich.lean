/-
# 必要十分版: 3 つの共役の合成（サンドイッチ）が `B_1 B_2 B_1` で作用すること

対応する人手証明のラベル:

* **`T_V_plus_check_Z_Y`**（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
  `evensectorT_010_claim_T_V_plus_action`）
* **`calc_of_TxT_check_Z_Y`**（同 `evensectorT_008_claim_product_action`）
* **`linearity_of_T_on_check_Z_Y`**（同 `evensectorT_006_claim_linearity_of_T`）
* **`linearity_of_T_V2`**（同 `evensectorT_006a_claim_linearity_of_T_V2`）
* 008 章の対応物 **`<T_V_hatZ_hatY>`**（`008_TV1_hatZ_hatY_part1.ts` の
  `TV1_hatZ_hatY_018_claim_T_V_action`）

**具体版は `Ising2D/EigenvalueProblem/ReductionToATheta/ClaimTVPlusAction.lean`**（半整数運動量）と
`Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean`（整数運動量）。
半整数運動量の具体版がこの必要十分版の特殊化として得られることは
`EigenvalueProblem/ReductionToATheta/ClaimTVPlusActionFromNecSuf.lean`（`TVPlus_checkZ_checkY_of_necSuf`）に書いた。
**この 2 つは本ファイルの同じ定理の別の特殊化である**ことを
`RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean` の末尾（`TV_hatZ_hatY_via_sandwich`）で明示的に示している。

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

## 何が本質的か

原文は `T_{(V^{(+)})}(check(Z)_μ)` を求めるのに

  `def_T_V_plus` → `T_actions_on_check_Z_Y` → `β_1` の置き方 → `linearity_of_T_V2`
  → `def_pair_of_matrices_times_column_of_numbers` → `calc_of_TxT_check_Z_Y`
  → `pair_of_matrices_times_matrix_times_column_associative` → `def_pair_of_matrices_times_column_of_numbers`
  → `linearity_of_T_on_check_Z_Y` → `def_pair_of_matrices_times_column_of_numbers`
  → もう一度 `calc_of_TxT_check_Z_Y` → `pair_of_matrices_times_matrix_times_column_associative`

という 12 行の鎖を書いている。この鎖に効いているのは

* **`T` が ℂ 線型であること**、および
* **`(T z, T y) = (z, y) B` という記法のもとで合成が行列の積になること**

の 2 つだけである。指数関数も、共役であることも、行列であることも、
`z, y` が何であるかも効いていない。実際、下の `actsBy_sandwich` は
**ℂ 上の任意の加群と任意の ℂ 線型写像**について成り立ち、
証明は合成則 `ActsBy'.comp` を 2 回使うだけである
（線型性はその中に埋め込まれている）。

具体版（`ClaimTVPlusAction.lean`）の行との対応は次のとおりである。

| 具体版の行（`TVPlus_apply_checkZ`・`_checkY`・`TVPlus_checkZ_checkY`） | 必要十分版（`NecSuf.actsBy_sandwich`） |
| --- | --- |
| (z)・(y) の 1 行目 `def_T_V_plus` | `TV'` が `T_{g_1}∘T_{g_2}∘T_{g_1}` であること（`actsBy_TV_sandwich` が `actsBy_sandwich` へ渡す形） |
| (z)・(y) の 2〜3 行目 `T_actions_on_check_Z_Y`・`β_j` の置き方 | 内側の `h₁`（`T_1` が `B_1` で作用すること） |
| (z)・(y) の 4〜7 行目 `linearity_of_T_V2`・`calc_of_TxT_check_Z_Y`（`B_2`）・組の積の結合律 | 1 回目の `ActsBy'.comp`（`map_add`・`map_smul` が線型性、`hS` が `B_2`） |
| (z)・(y) の 8〜12 行目 `linearity_of_T_on_check_Z_Y`・`calc_of_TxT_check_Z_Y`（`B_1(θ~)`）・組の積の結合律 | 2 回目の `ActsBy'.comp` |
| 2 列を並べる鎖の 1〜7 行目（列を並べて `(B_1 B_2) B_1`） | `actsBy_sandwich` の `mul_assoc` |
| 2 列を並べる鎖の 8 行目 `factorization_of_A_theta_general` | 導出 `TVPlus_checkZ_checkY_of_necSuf` の `factorization_of_A_thetaTilde` |

したがって原文の (z)・(y) の 12 行の鎖は「線型写像の合成 ↔ 行列の積」という 1 点に集約される。
`B_1(θ) B_2 B_1(θ) = A(θ)` は別の（純粋に 2×2 行列の）計算であり、
`Ising2D.factorization_of_A_theta_general`（`EigenvalueProblem/ReductionToATheta/ClaimFactorizationATheta.lean`）が担当する。

## 記法と共役作用の置き場

行ベクトル記法の述語 `ActsBy'`（`(T z, T y) = (z, y) B`）・その合成則 `ActsBy'.comp`・共役作用 `TConj'`
（`X ↦ g X g⁻¹`）・その 3 つの合成 `TV'` は、このファイルに必要十分版の側の定義として置く。具体版の同じ定義
`Ising2D.ActsBy`・`Ising2D.ActsBy.comp`・`Ising2D.TConj`・`Ising2D.TV`
（`Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean`）を
参照しないためである（具体版と必要十分版は互いを参照しない。`lean/README.md`）。両者の一致は、具体版と同じフォルダの
導出 `DefinitionTgAndTVFromNecSuf.lean` だけが述べる。

| 具体版 | 必要十分版 | 仮定 |
| --- | --- | --- |
| `ActsBy`（ℂ 上の加群の上の述語） | `ActsBy'`（同じ式） | なし（具体版と同じ） |
| `ActsBy.comp`（`map_add`・`map_smul` で展開して係数を比べる） | `ActsBy'.comp`（同じ手順） | なし（具体版と同じ） |
| `TConj g`（ℂ 上の環 `𝔸` の ℂ 代数の自己同型 `𝔸 ≃ₐ[ℂ] 𝔸`） | `TConj' g`（ℂ 上の半環 `𝔸` の ℂ 線型写像 `𝔸 →ₗ[ℂ] 𝔸`） | 乗法性・逆写像は主張に効かない。負元も使わない（使うのは分配則・スカラーと積の結合・単元だけ）ので、環でなく半環 |
| `TV g₁ g₂`（`TConj` の 3 つの合成） | `TV' g₁ g₂`（`TConj'` の 3 つの合成） | 同上 |

`TConj'` が ℂ 線型写像であるのは、`actsBy_TV_sandwich` が使うのが `T_g` の ℂ 線型性だけだからである
（具体版の `TConj` が持つ乗法性・単位性・逆写像は、この主張では効いていない）。
-/
import Ising2D.NecSuf.TVAction

namespace Ising2D.NecSuf

/-! ## 行ベクトル記法 `(T z, T y) = (z, y) B` と合成則（必要十分版の側の定義） -/

section RowVectorNotation

variable {A : Type*} [AddCommMonoid A] [Module ℂ A]

/-- 行ベクトル記法 `(T z, T y) = (z, y) B` を述語にしたもの（具体版 `Ising2D.ActsBy` と同じ式）。

`T z = B_{00} z + B_{10} y` かつ `T y = B_{01} z + B_{11} y`（`B` の**列**が `T z`, `T y` の `(z, y)` に関する係数）。 -/
def ActsBy' (T : A →ₗ[ℂ] A) (z y : A) (B : Matrix (Fin 2) (Fin 2) ℂ) : Prop :=
  T z = B 0 0 • z + B 1 0 • y ∧ T y = B 0 1 • z + B 1 1 • y

/-- **合成則**（具体版 `Ising2D.ActsBy.comp` と同じ手順）: `(z,y)` に `P` で作用する `T` のあとに
`Q` で作用する `S` を施すと `Q P` で作用する。 -/
theorem ActsBy'.comp {S T : A →ₗ[ℂ] A} {z y : A} {P Q : Matrix (Fin 2) (Fin 2) ℂ}
    (hT : ActsBy' T z y P) (hS : ActsBy' S z y Q) : ActsBy' (S ∘ₗ T) z y (Q * P) := by
  constructor
  · show S (T z) = _
    rw [hT.1, map_add, map_smul, map_smul, hS.1, hS.2]
    match_scalars <;> simp [Matrix.mul_apply, Fin.sum_univ_two] <;> ring
  · show S (T y) = _
    rw [hT.2, map_add, map_smul, map_smul, hS.1, hS.2]
    match_scalars <;> simp [Matrix.mul_apply, Fin.sum_univ_two] <;> ring

end RowVectorNotation

/-! ## 共役作用 `T_g` と `T_{(V)}`（必要十分版の側の定義） -/

section Conjugation

variable {𝔸 : Type*} [Semiring 𝔸] [Algebra ℂ 𝔸]

/-- 共役作用 `T_g : X ↦ g X g⁻¹` を ℂ 線型写像として（具体版 `Ising2D.TConj` と同じ式）。 -/
def TConj' (g : 𝔸ˣ) : 𝔸 →ₗ[ℂ] 𝔸 where
  toFun x := (g : 𝔸) * x * ((g⁻¹ : 𝔸ˣ) : 𝔸)
  map_add' x y := by rw [mul_add, add_mul]
  map_smul' c x := by rw [RingHom.id_apply, mul_smul_comm, smul_mul_assoc]

/-- `T_{(V)} := T_{g_1} ∘ T_{g_2} ∘ T_{g_1}`（具体版 `Ising2D.TV` と同じ合成）。 -/
def TV' (g₁ g₂ : 𝔸ˣ) : 𝔸 →ₗ[ℂ] 𝔸 :=
  TConj' g₁ ∘ₗ TConj' g₂ ∘ₗ TConj' g₁

end Conjugation

section Sandwich

variable {A : Type*} [AddCommMonoid A] [Module ℂ A]

/-- **必要十分版の本体**（人手証明 `<T_V_plus_check_Z_Y>` / `<T_V_hatZ_hatY>` の合成の部分）:

`T_1` が `(z, y)` に `B_1` で、`T_2` が `B_2` で作用するなら、
サンドイッチ `T_1 ∘ T_2 ∘ T_1` は `B_1 B_2 B_1` で作用する。

ℂ 上の任意の加群と任意の ℂ 線型写像について成り立つ。
指数関数も共役も行列も要らない。 -/
theorem actsBy_sandwich {T₁ T₂ : A →ₗ[ℂ] A} {z y : A} {B₁ B₂ : Matrix (Fin 2) (Fin 2) ℂ}
    (h₁ : ActsBy' T₁ z y B₁) (h₂ : ActsBy' T₂ z y B₂) :
    ActsBy' (T₁ ∘ₗ T₂ ∘ₗ T₁) z y (B₁ * B₂ * B₁) := by
  have h := (h₁.comp h₂).comp h₁
  rwa [← mul_assoc] at h

/-- 上を `T_{(V)} = T_{g_1} ∘ T_{g_2} ∘ T_{g_1}`（`TV'`）の形で述べたもの。 -/
theorem actsBy_TV_sandwich {𝔸 : Type*} [Semiring 𝔸] [Algebra ℂ 𝔸] {g₁ g₂ : 𝔸ˣ} {z y : 𝔸}
    {B₁ B₂ : Matrix (Fin 2) (Fin 2) ℂ}
    (h₁ : ActsBy' (TConj' g₁) z y B₁) (h₂ : ActsBy' (TConj' g₂) z y B₂) :
    ActsBy' (TV' g₁ g₂) z y (B₁ * B₂ * B₁) :=
  actsBy_sandwich h₁ h₂

end Sandwich

end Ising2D.NecSuf
