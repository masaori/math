/-
# 具体版: `exp(X) A exp(-X)` の級数展開（`Mat(2,ℂ)^{⊗M}` 上）

対応する人手証明のラベル: **`<exp_X_Y_exp_-X>`**
（`structured-latex/content/008_TV1_hatZ_hatY_part1.mjs` の
`TV1_hatZ_hatY_006_claim_exp_conjugation`。級数展開の本体は 005 章
`structured-latex/content/005_exp_conjugation_proof.mjs` の
`<matrix_exp_conjugation>`、`ad_X^n` の定義は `<ad_binomial>` / `<def_ad_X_matrix>`）。

**抽象版は `Ising2D/Abstract/ExpConjugation.lean`**（名前空間 `Ising2D.Abstract`）。
本ファイルの各定理はそこからの特殊化として導出する。何が本質的かは抽象版の冒頭に書いた。

人手証明との対応:

| 人手証明 | 本ファイル |
| --- | --- |
| `ad_X^0(Y) = Y`, `ad_X^{m+1}(Y) = [X, ad_X^m(Y)]`（`<ad_binomial>` の再帰） | `Ising2D.adPow` |
| `exp(X) Y exp(-X) = Σ_{n≥0} (1/n!) [X,[X,…,[X,Y]…]]`（`<exp_X_Y_exp_-X>`） | `Ising2D.matExp_conj_eq_tsum` |
| 同上（級数の収束もあわせて主張している部分） | `Ising2D.hasSum_matExp_conj` |
| `Ad_{exp X}(Y) = exp(ad_X)(Y)`（同 (3)） | `Ising2D.matExp_conj_eq_tsum` と `Ising2D.matExpUnits` |

## 2 次元不変部分空間での閉じた形（後段の `T_V_hatZ_hatY` で使う）

`ad X` が `z, y` の張る部分空間を保つとき、すなわち
`[X, z] = α y`, `[X, y] = β z` のとき、`s^2 = α β` を満たす `s ∈ ℂ` に対し

  `exp(X) z exp(-X) = cosh(s) z + α sinhc(s) y`
  `exp(X) y exp(-X) = cosh(s) y + β sinhc(s) z`

（`Ising2D.matExp_conj_two_dim_z` / `..._y`）。ここで
`sinhc(s) = sinh(s)/s`（`s = 0` では `1`、`Ising2D.Abstract.sinhc`）である。
`sinh(s)/s` と書くと `s = 0` で 0 割りになるので、**`s = 0` の場合も含めて成り立つ形**に
するために `sinhc` を別に定義してある。

人手証明 `<extract_taylor_coefficient_of_Z_Y>`（`TV1_hatZ_hatY_005_claim_extract_taylor_coefficient`）
の (h1.z) `cosh(K_1) Ẑ_μ + i e^{-iθ_μ} sinh(K_1) Ŷ_μ` は、
`X = (i/2)K_1 H_1^{(±)}`, `z = Ẑ_μ^{(±)}`, `y = Ŷ_μ`, `s = K_1`,
`α = i e^{-iθ_μ} K_1`, `β = -i e^{iθ_μ} K_1` の場合であり、
`αβ = K_1^2 = s^2` が成り立つ（`α sinhc(K_1) = i e^{-iθ_μ} sinh(K_1)`、
`β sinhc(K_1) = -i e^{iθ_μ} sinh(K_1)`）。**この形は本ファイルで独立に導出したものであり、
人手証明の cosh/sinh はその特殊化として説明がつく。**

## 原文について気づいたこと

`<exp_X_Y_exp_-X>` の statement には `exp(X)` の正則性が書かれているが、その逆行列が
`exp(-X)` であること（`Ad_{exp X}` の well-defined 性）は `<matrix_exp_conjugation>` (3) に
委ねられている。Lean 側では `Ising2D.matExpUnits`（`Part004/Definition010_H1H2V1V2.lean`）が
`exp X` を単元として与えており、その逆元が定義から `exp (-X)` なので、この点に穴は無い。
-/
import Ising2D.Abstract.ExpConjugation
import Ising2D.Part004.Definition010_H1H2V1V2

namespace Ising2D

open NormedSpace Nat

-- mathlib の `Matrix.exp_add_of_commute` 等と同じ事情。`l^∞` 作用素ノルムの
-- 加法・位相の instance は既定の `Matrix` のものと定義的に等しいが、その照合には
-- instance-reducible な定義を展開させる必要がある。
set_option backward.isDefEq.respectTransparency false

variable {M : ℕ}

/-- 人手証明 `<ad_binomial>` / `<def_ad_X_matrix>` の `ad_X^n(Y)`（`n` 重の入れ子交換子）。

`adPow X 0 A = A`、`adPow X (n+1) A = [X, adPow X n A] = X (adPow X n A) - (adPow X n A) X`。 -/
noncomputable def adPow (X : TensorPow M) : ℕ → TensorPow M → TensorPow M
  | 0, A => A
  | n + 1, A => X * adPow X n A - adPow X n A * X

@[simp] theorem adPow_zero (X A : TensorPow M) : adPow X 0 A = A := rfl

@[simp] theorem adPow_succ (X A : TensorPow M) (n : ℕ) :
    adPow X (n + 1) A = X * adPow X n A - adPow X n A * X := rfl

open scoped Matrix.Norms.Operator in
/-- `adPow` は抽象版の `adCLM` の冪と一致する（特殊化のための橋渡し）。 -/
theorem adPow_eq_adCLM (X : TensorPow M) :
    ∀ (n : ℕ) (A : TensorPow M), adPow X n A = (Abstract.adCLM X ^ n) A
  | 0, A => by simp
  | n + 1, A => by
      rw [adPow_succ, adPow_eq_adCLM X n, pow_succ,
        ← ((Commute.refl (Abstract.adCLM X)).pow_right n).eq]
      rfl

open scoped Matrix.Norms.Operator in
/-- 抽象版の特殊化そのもの（`Mat(2,ℂ)^{⊗M}` に `l^∞` 作用素ノルムを入れた文脈で述べた版）。
公開する `Ising2D.hasSum_matExp_conj` はこれをノルム非依存の形へ移したものである。 -/
private theorem hasSum_matExp_conj_aux (X A : TensorPow M) :
    HasSum (fun n : ℕ => ((n ! : ℂ))⁻¹ • adPow X n A)
      (NormedSpace.exp X * A * NormedSpace.exp (-X)) := by
  simpa only [adPow_eq_adCLM] using Abstract.hasSum_exp_conj X A

set_option backward.isDefEq.respectTransparency false in
/-- **具体版の本体**（人手証明 `<exp_X_Y_exp_-X>`）:
`Mat(2,ℂ)^{⊗M}` において級数 `Σ_n (1/n!) ad_X^n(A)` は収束し、その和は
`exp(X) A exp(-X)` に等しい。 -/
theorem hasSum_matExp_conj (X A : TensorPow M) :
    HasSum (fun n : ℕ => ((n ! : ℂ))⁻¹ • adPow X n A) (matExp X * A * matExp (-X)) :=
  hasSum_matExp_conj_aux X A

set_option backward.isDefEq.respectTransparency false in
/-- 同じ主張を `tsum` で書いた版（人手証明 `<exp_X_Y_exp_-X>` の等式そのもの）。 -/
theorem matExp_conj_eq_tsum (X A : TensorPow M) :
    matExp X * A * matExp (-X) = ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow X n A :=
  (hasSum_matExp_conj X A).tsum_eq.symm

set_option backward.isDefEq.respectTransparency false in
/-- 単元 `Ising2D.matExpUnits X` を使った `Ad_{exp X}` の形
（人手証明 `<exp_X_Y_exp_-X>` の `Ad_{exp(X)}(Y) = exp(ad_X)(Y)`）。 -/
theorem matExpUnits_conj_eq_tsum (X A : TensorPow M) :
    ((matExpUnits X : (TensorPow M)ˣ) : TensorPow M) * A *
        (((matExpUnits X)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
      = ∑' n : ℕ, ((n ! : ℂ))⁻¹ • adPow X n A := by
  rw [matExpUnits_val, matExpUnits_inv]
  exact matExp_conj_eq_tsum X A

/-! ## 2 次元不変部分空間での閉じた形 -/

open scoped Matrix.Norms.Operator in
/-- 抽象版の特殊化（`l^∞` 作用素ノルムを入れた文脈での版）。 -/
private theorem matExp_conj_two_dim_z_aux {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) :
    NormedSpace.exp X * z * NormedSpace.exp (-X)
      = Complex.cosh s • z + (α * Abstract.sinhc s) • y :=
  Abstract.exp_conj_two_dim_z (y := y) hz hy hs

open scoped Matrix.Norms.Operator in
/-- 同上（`y` 始点）。 -/
private theorem matExp_conj_two_dim_y_aux {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) :
    NormedSpace.exp X * y * NormedSpace.exp (-X)
      = Complex.cosh s • y + (β * Abstract.sinhc s) • z :=
  Abstract.exp_conj_two_dim_y (z := z) hz hy hs

set_option backward.isDefEq.respectTransparency false in
/-- **系**（後段 `<T_V_hatZ_hatY>` で使う）: `[X, z] = α y`, `[X, y] = β z` かつ `s^2 = αβ` のとき

`exp(X) z exp(-X) = cosh(s) z + α sinhc(s) y`。

`s = 0` の場合も含めて成り立つ（`Ising2D.Abstract.sinhc` は `s = 0` で `1`）。 -/
theorem matExp_conj_two_dim_z {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) :
    matExp X * z * matExp (-X) = Complex.cosh s • z + (α * Abstract.sinhc s) • y :=
  matExp_conj_two_dim_z_aux hz hy hs

set_option backward.isDefEq.respectTransparency false in
/-- 同上（`y` 始点）: `exp(X) y exp(-X) = cosh(s) y + β sinhc(s) z`。 -/
theorem matExp_conj_two_dim_y {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) :
    matExp X * y * matExp (-X) = Complex.cosh s • y + (β * Abstract.sinhc s) • z :=
  matExp_conj_two_dim_y_aux hz hy hs

end Ising2D
