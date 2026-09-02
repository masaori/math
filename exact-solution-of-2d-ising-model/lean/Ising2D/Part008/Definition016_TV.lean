/-
# 共役作用 `T_g` と `T_{(V)}`、およびその `hat(Z)^{(-)}, hat(Y)` への作用

対応する人手証明（正本は `structured-latex/content/*.mjs`）:

* `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs`
  * `TV1_hatZ_hatY_011_definition_T_g`（ラベル `def_T_g`）
    — `g ∈ (Mat(2,ℂ)^{⊗M})^×` に対し `T_g : h ↦ g h g⁻¹`
  * `TV1_hatZ_hatY_015_claim_linearity_of_T`（ラベル `linearity_of_T`）
    — `T` の ℂ-線型性
  * `TV1_hatZ_hatY_016_definition_T_V`（ラベル `def_T_V`）
    — `T_{(V)}(X) := T_{(V_1^{(±)})^{1/2}}(T_{V_2}(T_{(V_1^{(±)})^{1/2}}(X)))`
  * `TV1_hatZ_hatY_017_definition_A_theta`（ラベル `def_A_theta`）— `A(θ)`
  * `TV1_hatZ_hatY_018_claim_T_V_action`（ラベル `T_V_hatZ_hatY`）
    — `(T_{(V)}(hat(Z)_μ^{(-)}), T_{(V)}(hat(Y)_μ)) = (hat(Z)_μ^{(-)}, hat(Y)_μ) A(2πμ/M)`
  * `TV1_hatZ_hatY_012_claim_TV1_TV2_actions`（ラベル `ホロノミック量子場_p142下段_1`）
    — `T_{(V_1^{(±)})^{1/2}}`, `T_{V_2}` の `hat(Z)^{(-)}, hat(Y)` への作用（行列 `B_1(θ)`, `B_2`）

## 形式化の方針

* `T_g` は既存の `Ising2D.Conjugation.*`（`Part000/Claim045_ConjugationIsRingHom.lean`）を
  再利用する。あちらで `T B (A) = B A B⁻¹` が環自己同型であることまで証明済みなので、
  ここでは `commutes'`（スカラーを固定すること）だけを足して **ℂ-代数自己同型 `A ≃ₐ[ℂ] A`**
  に持ち上げる（`TConj`）。ℂ-線型性（原文 `linearity_of_T`）・乗法性・単位性は
  `AlgEquiv` の構造からただちに従う。
* 原文の行ベクトル記法 `(T z, T y) = (z, y) B` を述語 `ActsBy T z y B` として定義する。
  この記法のもとで合成則は `ActsBy T z y P → ActsBy S z y Q → ActsBy (S ∘ₗ T) z y (Q * P)`
  となる（`ActsBy.comp`）。原文が `T_{(V)} = T_{V_1^{1/2}} ∘ T_{V_2} ∘ T_{V_1^{1/2}}` の
  作用を `B_1 B_2 B_1` と計算しているのはこの合成則そのものである。
* 固有ベクトルの移送（`ActsBy.eigen`）: `B` の固有ベクトル `v` に対し
  `v_0 z + v_1 y` が `T` の固有ベクトルになる。後段（`ψ` が `V` の固有ベクトルであること）で
  使うための一般補題として、`ℂ` 上の任意の加群で述べる。

## かつての「未証明の穴」（**解消済み・2026-07-26**）

本ファイルの `TV_hatZ_hatY_of_action` / `TV_hatZ_hatY_of_action'` は、
`T_{(V_1^{(±)})^{1/2}}` と `T_{V_2}` の `hat(Z)^{(-)}, hat(Y)` への作用が
それぞれ `B_1(θ)`, `B_2` で与えられることを **仮定 `hT1`, `hT2`** として持つ。
これは原文 `TV1_hatZ_hatY_012_claim_TV1_TV2_actions`（`ホロノミック量子場_p142下段_1`）の
内容であり、以前は「ネストした交換子のテイラー係数抽出（`parts 008` の 001〜005）が
未形式化なので証明できない」という理由で仮定に残していた。

**この仮定は現在 `Ising2D/Part008/Claim012_TVActions.lean` で証明されており、
穴は残っていない。** 同ファイルの

* `Ising2D.actsBy_TConj_V1half` — `hT1` にあたる主張（証明済み）
* `Ising2D.actsBy_TConj_V2` — `hT2` にあたる主張（証明済み）
* `Ising2D.TV_hatZ_hatY` — 原文 `T_V_hatZ_hatY` の**無条件版**

を参照すること。証明は `<commutator_of_H_and_Z_Y>` の (1)(3)(4)(6)
（`Part008/Claim001_CommutatorHZY.lean`）と、`ad X` が 2 次元部分空間を保つ場合の
閉じた形（`Part008/Claim006_ExpConjugation.lean` の `matExp_conj_two_dim_z` / `..._y`）
だけから通る。必要十分版は `Ising2D/NecSuf/TVAction.lean`。

本ファイルの仮定つき版は、原文の証明の構造（`B_1`, `B_2` の作用 → 合成則 → `B_1B_2B_1 = A`）を
そのまま写したものとして残してある。仮定から先（合成則による `B_1 B_2 B_1` の計算、
および行列等式 `B_1(θ) B_2 B_1(θ) = A(θ)`）は本ファイルで完全に証明している。

## 形式化の過程で見つかった原文の問題

* `def_A_theta` の `A(θ)` の非対角成分には `c_2`（`= cosh 2K_2`）が現れるが、
  `B_1(θ) B_2 B_1(θ)` を素朴に計算すると同じ位置に現れるのは `c_2^*`（`= cosh 2K_2^*`）
  である。両者が一致するには**双対関係から従う等式 `c_2^* = s_2^* c_2` が必要**
  （`sinh 2K_2 · sinh 2K_2^* = 1` より `s_2^* = 1/s_2`、`c_2^* = coth 2K_2 = c_2/s_2 = s_2^* c_2`）。
  原文はこの等式を `def_A_theta` でも `T_V_hatZ_hatY` の証明でも明示していない。
  本ファイルでは `B1_mul_B2_mul_B1_eq_AMat` の仮定 `hdual : s_2^* c_2 = c_2^*` として明示する。

## `A(θ)` の定義の所在

`A(θ)` の定義は `Part008/Definition019_ThetaGamma.lean` の `Ising2D.AMat`
（`IsingConst` の 5 実数パラメータと実 `θ`）**ただ 1 つ**である。
以前は本ファイルにも 5 個の複素パラメータ版 `Ising2D.Amat` があり二重定義になっていたが、
`AMat` へ一本化して削除した（`lean/README.md` の該当節を参照）。
-/
import Ising2D.Part004.Definition010_H1H2V1V2
import Ising2D.Part000.Claim045_ConjugationIsRingHom
import Ising2D.Part008.Definition019_ThetaGamma
import Mathlib.Algebra.Algebra.Equiv
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Analysis.Complex.Trigonometric

namespace Ising2D

/-! ## `T_g`（原文 `def_T_g`）: 共役作用を ℂ-代数自己同型として -/

section Conj

variable {A : Type*} [Ring A] [Algebra ℂ A]

/-- **原文 `def_T_g`**: `g` が可逆なとき `T_g : X ↦ g X g⁻¹`。

`Ising2D.Conjugation.TMonoidHom g : RingAut A` に「スカラーを固定する」ことを足して
**ℂ-代数自己同型**に持ち上げたもの。 -/
def TConj (g : Aˣ) : A ≃ₐ[ℂ] A :=
  AlgEquiv.ofRingEquiv (f := Conjugation.TMonoidHom g) fun r => by
    show (g : A) * algebraMap ℂ A r * ((g⁻¹ : Aˣ) : A) = algebraMap ℂ A r
    rw [← Algebra.commutes, mul_assoc, Units.mul_inv, mul_one]

@[simp]
theorem TConj_apply (g : Aˣ) (x : A) : TConj g x = (g : A) * x * ((g⁻¹ : Aˣ) : A) := rfl

/-- **原文 `linearity_of_T`**: `T_g` は ℂ-線型。 -/
theorem TConj_linear (g : Aˣ) (a b : ℂ) (z y : A) :
    TConj g (a • z + b • y) = a • TConj g z + b • TConj g y := by
  change (g : A) * (a • z + b • y) * ((g⁻¹ : Aˣ) : A)
      = a • ((g : A) * z * ((g⁻¹ : Aˣ) : A))
        + b • ((g : A) * y * ((g⁻¹ : Aˣ) : A))
  rw [mul_add]
  rw [add_mul]
  rw [mul_smul_comm, mul_smul_comm]
  rw [smul_mul_assoc, smul_mul_assoc]

/-- 合成則 `T_g ∘ T_h = T_{g h}`（原文 `conjugation_is_ring_homomorphism` (3) の言い換え）。 -/
theorem TConj_trans (g h : Aˣ) : (TConj h).trans (TConj g) = TConj (g * h) := by
  ext x
  exact Conjugation.T_T g h x

/-- **原文 `def_T_V`**: `T_{(V)}(X) := T_{g_1}(T_{g_2}(T_{g_1}(X)))`
（`g_1 = (V_1^{(±)})^{1/2}`, `g_2 = V_2`）。 -/
def TV (g1 g2 : Aˣ) : A ≃ₐ[ℂ] A :=
  (TConj g1).trans ((TConj g2).trans (TConj g1))

@[simp]
theorem TV_apply (g1 g2 : Aˣ) (x : A) :
    TV g1 g2 x = TConj g1 (TConj g2 (TConj g1 x)) := rfl

/-- `T_{(V)}` は単一の共役 `T_{g_1 g_2 g_1}` に等しい（合成則の帰結）。 -/
theorem TV_eq_TConj (g1 g2 : Aˣ) : TV g1 g2 = TConj (g1 * g2 * g1) := by
  ext x
  show Conjugation.T g1 (Conjugation.T g2 (Conjugation.T g1 x))
      = Conjugation.T (g1 * g2 * g1) x
  rw [Conjugation.T_T, Conjugation.T_T, mul_assoc]

/-- **原文 `linearity_of_T`**（`T_{(V)}` 版）: ℂ-線型。 -/
theorem TV_linear (g1 g2 : Aˣ) (a b : ℂ) (z y : A) :
    TV g1 g2 (a • z + b • y) = a • TV g1 g2 z + b • TV g1 g2 y := by
  rw [map_add, map_smul, map_smul]

/-- `T_{(V)}` は乗法的。 -/
theorem TV_mul (g1 g2 : Aˣ) (x y : A) : TV g1 g2 (x * y) = TV g1 g2 x * TV g1 g2 y :=
  map_mul _ _ _

/-- `T_{(V)}` は単位的。 -/
theorem TV_one (g1 g2 : Aˣ) : TV g1 g2 (1 : A) = 1 := map_one _

end Conj

/-! ## 行ベクトル記法 `(T z, T y) = (z, y) B` -/

section ActsBy

variable {A : Type*} [AddCommMonoid A] [Module ℂ A]

/-- 原文の行ベクトル記法 `(T z, T y) = (z, y) B` を述語にしたもの。

すなわち `T z = B_{00} z + B_{10} y` かつ `T y = B_{01} z + B_{11} y`
（`B` の**列**が `T z`, `T y` の `(z, y)` に関する係数）。 -/
def ActsBy (T : A →ₗ[ℂ] A) (z y : A) (B : Matrix (Fin 2) (Fin 2) ℂ) : Prop :=
  T z = B 0 0 • z + B 1 0 • y ∧ T y = B 0 1 • z + B 1 1 • y

/-- **合成則**: `(z,y)` に `P` で作用する `T` のあとに `Q` で作用する `S` を施すと `Q P` で作用する。
原文が `T_{(V)}` の作用を `B_1 B_2 B_1` と計算しているのはこれ。 -/
theorem ActsBy.comp {S T : A →ₗ[ℂ] A} {z y : A} {P Q : Matrix (Fin 2) (Fin 2) ℂ}
    (hT : ActsBy T z y P) (hS : ActsBy S z y Q) : ActsBy (S ∘ₗ T) z y (Q * P) := by
  constructor
  · show S (T z) = _
    rw [hT.1, map_add, map_smul, map_smul, hS.1, hS.2]
    match_scalars <;> simp [Matrix.mul_apply, Fin.sum_univ_two] <;> ring
  · show S (T y) = _
    rw [hT.2, map_add, map_smul, map_smul, hS.1, hS.2]
    match_scalars <;> simp [Matrix.mul_apply, Fin.sum_univ_two] <;> ring

/-- **固有ベクトルの移送**（後段で `ψ` が `V` の固有ベクトルであることを導くための一般補題）。

`(T z, T y) = (z, y) B` のとき、`B` の固有ベクトル `v`（固有値 `lam`）に対して
`v_0 z + v_1 y` は `T` の固有値 `lam` の固有ベクトルである。 -/
theorem ActsBy.eigen {T : A →ₗ[ℂ] A} {z y : A} {B : Matrix (Fin 2) (Fin 2) ℂ}
    (h : ActsBy T z y B) {v : Fin 2 → ℂ} {lam : ℂ} (hv : B.mulVec v = lam • v) :
    T (v 0 • z + v 1 • y) = lam • (v 0 • z + v 1 • y) := by
  have h0 : B 0 0 * v 0 + B 0 1 * v 1 = lam * v 0 := by
    have := congrFun hv 0
    simpa [Matrix.mulVec, dotProduct, Fin.sum_univ_two] using this
  have h1 : B 1 0 * v 0 + B 1 1 * v 1 = lam * v 1 := by
    have := congrFun hv 1
    simpa [Matrix.mulVec, dotProduct, Fin.sum_univ_two] using this
  rw [map_add, map_smul, map_smul, h.1, h.2]
  match_scalars
  · linear_combination h0
  · linear_combination h1

end ActsBy

/-! ## 行列 `B_1(θ)`, `B_2`, `A(θ)` -/

/-- 原文 `T_V_hatZ_hatY` の証明中の `B_1(θ)`
（`T_{(V_1^{(±)})^{1/2}}` の `(hat(Z)^{(-)}, hat(Y))` への作用行列）。 -/
noncomputable def B1mat (K1 θ : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![Complex.cosh K1, -Complex.I * Complex.exp (θ * Complex.I) * Complex.sinh K1;
     Complex.I * Complex.exp (-θ * Complex.I) * Complex.sinh K1, Complex.cosh K1]

/-- 原文 `T_V_hatZ_hatY` の証明中の `B_2`（`T_{V_2}` の作用行列）。 -/
noncomputable def B2mat (K2star : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![Complex.cosh (2 * K2star), Complex.I * Complex.sinh (2 * K2star);
     -Complex.I * Complex.sinh (2 * K2star), Complex.cosh (2 * K2star)]

set_option maxHeartbeats 2000000 in
/-- **`B_1(θ) B_2 B_1(θ)` の明示計算**（原文 `T_V_hatZ_hatY` の最後の一行）。

右辺は原文 `def_A_theta` の `A(θ)` を 5 個の複素パラメータで書き下したものである
（`A(θ)` の定義そのものは `Ising2D.AMat` ただ 1 つで、こちらは実パラメータ版。
両者をつなぐのが次の `B1_mul_B2_mul_B1_eq_AMat`）。

`hdual` は双対関係 `sinh 2K_2 · sinh 2K_2^* = 1` から従う等式 `c_2^* = s_2^* c_2`。
原文はこれを明示していない（ファイル冒頭「原文の問題」参照）。 -/
theorem B1_mul_B2_mul_B1_eq_explicit (K1 K2star θ c1 s1 c2 c2star s2star : ℂ)
    (hc1 : c1 = Complex.cosh (2 * K1)) (hs1 : s1 = Complex.sinh (2 * K1))
    (hc2star : c2star = Complex.cosh (2 * K2star))
    (hs2star : s2star = Complex.sinh (2 * K2star))
    (hdual : s2star * c2 = c2star) :
    B1mat K1 θ * B2mat K2star * B1mat K1 θ =
      !![c1 * c2star - s1 * s2star * Complex.cos θ,
         Complex.I * Complex.exp (θ * Complex.I) * s2star *
           (c1 * Complex.cos θ - Complex.I * Complex.sin θ - s1 * c2);
         -Complex.I * Complex.exp (-θ * Complex.I) * s2star *
           (c1 * Complex.cos θ + Complex.I * Complex.sin θ - s1 * c2),
         c1 * c2star - s1 * s2star * Complex.cos θ] := by
  subst hc1; subst hs1; subst hc2star; subst hs2star
  -- 先に行列を展開してから双対関係を使い、`cosh 2K_2^*` を左右とも `s_2^* c_2` に揃える。
  simp only [B1mat, B2mat]
  rw [← hdual]
  have hu : Complex.exp K1 ≠ 0 := Complex.exp_ne_zero _
  have hq : Complex.exp K2star ≠ 0 := Complex.exp_ne_zero _
  have hw : Complex.exp (θ * Complex.I) ≠ 0 := Complex.exp_ne_zero _
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Matrix.mul_apply, Fin.sum_univ_two,
      Complex.cosh, Complex.sinh, Complex.cos, Complex.sin,
      neg_mul, Complex.exp_neg, two_mul, Complex.exp_add] <;>
    field_simp <;>
    ring_nf <;>
    (try simp only [Complex.I_sq]) <;>
    (try ring)

/-- **`B_1(θ) B_2 B_1(θ) = A(θ)`**（原文 `T_V_hatZ_hatY` の最後の一行、`AMat` 版）。

原文の `c_1, s_1, c_2, c_2^*, s_2^*` はすべて実数、`θ = θ_μ = 2πμ/M` も実数なので、
`B1_mul_B2_mul_B1_eq_explicit` の複素パラメータへ `IsingConst` の実数を coe すれば
`AMat`（`Part008/Definition019_ThetaGamma.lean`、`A(θ)` の唯一の定義）に一致する。 -/
theorem B1_mul_B2_mul_B1_eq_AMat (K : IsingConst) (K1 K2star : ℂ) (θ : ℝ)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    B1mat K1 (θ : ℂ) * B2mat K2star * B1mat K1 (θ : ℂ) = AMat K θ := by
  rw [B1_mul_B2_mul_B1_eq_explicit K1 K2star (θ : ℂ)
    (K.c1 : ℂ) (K.s1 : ℂ) (K.c2 : ℂ) (K.c2star : ℂ) (K.s2star : ℂ)
    hc1 hs1 hc2star hs2star hdual]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [AMat, Complex.ofReal_cos, Complex.ofReal_sin, Complex.exp_mul_I,
      mul_comm (Complex.I : ℂ)]

/-! ## `T_{(V)}` の `hat(Z)^{(-)}, hat(Y)` への作用（仮定つき） -/

/-- **原文 `T_V_hatZ_hatY`（仮定つきの形）**。

`hT1`, `hT2` は原文 `ホロノミック量子場_p142下段_1` の内容そのもので、
ネストした交換子のテイラー係数抽出（`parts 008` の 001〜005）が未形式化のため
本リポジトリでは証明できない。ここでは仮定として明示的に持つ。

仮定から先（合成則による `B_1 B_2 B_1` の計算と `B_1 B_2 B_1 = A(θ)`）は完全に証明されている。 -/
theorem TV_hatZ_hatY_of_action {M : ℕ} (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ) (θ : ℝ)
    (T1 T2 : TensorPow M →ₗ[ℂ] TensorPow M)
    (hT1 : ActsBy T1 (hatZMinus M μ) (hatY M μ) (B1mat K1 (θ : ℂ)))
    (hT2 : ActsBy T2 (hatZMinus M μ) (hatY M μ) (B2mat K2star))
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    ActsBy (T1 ∘ₗ T2 ∘ₗ T1) (hatZMinus M μ) (hatY M μ) (AMat K θ) := by
  have h := (hT1.comp hT2).comp hT1
  rw [← mul_assoc] at h
  rwa [B1_mul_B2_mul_B1_eq_AMat K K1 K2star θ hc1 hs1 hc2star hs2star hdual] at h

/-- 上を `T_{(V)} = T_{g_1} ∘ T_{g_2} ∘ T_{g_1}` の形で述べたもの。 -/
theorem TV_hatZ_hatY_of_action' {M : ℕ} (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ) (θ : ℝ)
    (g1 g2 : (TensorPow M)ˣ)
    (hT1 : ActsBy (TConj g1).toLinearMap (hatZMinus M μ) (hatY M μ) (B1mat K1 (θ : ℂ)))
    (hT2 : ActsBy (TConj g2).toLinearMap (hatZMinus M μ) (hatY M μ) (B2mat K2star))
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    ActsBy (TV g1 g2).toLinearMap (hatZMinus M μ) (hatY M μ) (AMat K θ) := by
  have h := TV_hatZ_hatY_of_action K μ K1 K2star θ
    (TConj g1).toLinearMap (TConj g2).toLinearMap hT1 hT2 hc1 hs1 hc2star hs2star hdual
  exact h

end Ising2D
