/-
# 具体版: `T_{(V_1^{(±)})^{1/2}}`, `T_{V_2}`, `T_{(V)}` の `hat(Z)^{(-)}, hat(Y)` への作用

対応する人手証明のラベル（正本は `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs`）:

* **`<nesting_of_commutator_of_H_and_Z>`**（`TV1_hatZ_hatY_002_claim_nesting_commutator`）
  — `n` 重の入れ子交換子の偶奇による閉じた形
* **`<extract_taylor_coefficient_of_Z_Y>`**（`TV1_hatZ_hatY_005_claim_extract_taylor_coefficient`）
  — 上の級数和が `cosh K_1`, `i e^{-iθ_μ} sinh K_1` 等になること
* **`<ホロノミック量子場_p142下段_1>`**（`TV1_hatZ_hatY_012_claim_TV1_TV2_actions`）
  — `T_{(V_1^{(±)})^{1/2}}`, `T_{V_2}` の作用行列が `B_1(θ_μ)`, `B_2` であること
* **`<T_V_hatZ_hatY>`**（`TV1_hatZ_hatY_018_claim_T_V_action`）
  — `(T_{(V)}(hat(Z)_μ^{(-)}), T_{(V)}(hat(Y)_μ)) = (hat(Z)_μ^{(-)}, hat(Y)_μ) A(2πμ/M)`

**抽象版は `Ising2D/Abstract/TVAction.lean`**（名前空間 `Ising2D.Abstract`）。
本ファイルの主要定理はそこからの特殊化として導出する。何が本質的かは抽象版の冒頭に書いた。

## このファイルで解消した「未証明の穴」

`Part008/Definition016_TV.lean` の `TV_hatZ_hatY_of_action` /
`TV_hatZ_hatY_of_action'`、および `Part008/Definition030_Fermi.lean` の
`TV_psiDag_of_action` / `TV_psi_of_action` は、`ActsBy`（原文の行ベクトル記法）を
**明示的な仮定**として持っていた。本ファイルでその仮定を証明して除去し、
`TV_hatZ_hatY`（原文 `<T_V_hatZ_hatY>`）と
`TV_psiDag` / `TV_psi`（原文 `<commutation_V_psi>`）を**無条件の定理**にする。

## 証明の骨格（原文との対応）

原文が「入れ子交換子の偶奇の場合分け（`002`）→ テイラー係数の抽出（`005`）」の 2 段で
やっていることを、Lean では **`ad X` が `span{hat(Z)_μ^{(-)}, hat(Y)_μ}` を保つ**という
1 つの事実に集約し、既に形式化済みの `matExp_conj_two_dim_z` / `..._y`
（`Part008/Claim006_ExpConjugation.lean`）へ渡す。

1. `X_1 := (1/2) i K_1 H_1^{(-)}` について、`<commutator_of_H_and_Z_Y>` の (1) と (3)
   （`lie_H1_hatZ_same`, `lie_H1_hatY`）から

     `ad X_1 (Ẑ_μ^{(-)}) = (i K_1 e^{-iθ_μ}) Ŷ_μ`,  `ad X_1 (Ŷ_μ) = (-i K_1 e^{iθ_μ}) Ẑ_μ^{(-)}`

   したがって `α β = K_1^2`、すなわち `s = K_1` が取れる。
2. `X_2 := i K_2^* H_2` について、同 (4) と (6)（`lie_H2_hatZMinus`, `lie_H2_hatY`）から

     `ad X_2 (Ẑ_μ^{(-)}) = (-2 i K_2^*) Ŷ_μ`,  `ad X_2 (Ŷ_μ) = (2 i K_2^*) Ẑ_μ^{(-)}`

   したがって `α β = (2K_2^*)^2`、すなわち `s = 2 K_2^*` が取れる。
3. `exp(X) z exp(-X) = cosh(s) z + α sinhc(s) y` に代入して係数を突き合わせると、
   `α sinhc(K_1) = i e^{-iθ_μ} sinh(K_1)` 等となり、**原文 `005` / `012` の
   `cosh K_1`, `±i e^{∓iθ_μ} sinh K_1`, `cosh 2K_2^*`, `±i sinh 2K_2^*` と完全に一致する**
   （`B1mat_eq_twoDimConjMat`, `B2mat_eq_twoDimConjMat` が突き合わせそのもの。
   原文の誤りは見つからなかった）。
4. `V_2` のスカラー因子 `(2s_2)^{M/2}` は共役で打ち消える（`Abstract.conj_smul_eq`）。
   原文が「スカラーは共役で打ち消し合う」と書いている一行がこれである。
5. 1〜4 を `ActsBy.comp` でつないで `B_1(θ_μ) B_2 B_1(θ_μ) = A(θ_μ)`
   （`B1_mul_B2_mul_B1_eq_AMat`）へ帰着させる。

## 原文の符号の選択について

原文 `012` の証明は「本主張では `hat(Z)_μ^{(-)}` に作用させるので、`±` はいずれも `-`
（すなわち `H_1^{(-)}` と `hat(Z)_μ^{(-)}` の組）を選んで適用する」と明記している。
Lean の記法では `hat(Z)^{(-)} = hatZ M 1 μ`、`H_1^{(-)} = H1 M 1`（引数 `η` が原文の `∓1`）
なので、本ファイルでは一貫して `η = 1` を使う。`<commutator_of_H_and_Z_Y>` のうち
**偽であることが判明している (2)(5)**（`Part008/Claim001_CommutatorHZY.lean` 冒頭参照）は
`hat(Z)^{(∓)}` すなわち逆符号の組についての式なので、**本ファイルの経路では一切使わない**。

## 残っている仮定について

`B_1 B_2 B_1 = A(θ)` には双対関係の帰結 `s_2^* c_2 = c_2^*` が要る（原文はこれを
明示していない。`Part008/Definition016_TV.lean` 冒頭「原文の問題」参照）。これは
**未形式化に由来する穴ではなく数学的に必要な仮定**なので、`hdual` として残す。
同様に `c_1 = cosh 2K_1` 等の `IsingConst` の成分と `K_1, K_2^*` の関係も仮定として持つ。
-/
import Ising2D.Abstract.TVAction
import Ising2D.Part008.Claim001_CommutatorHZY
import Ising2D.Part008.Claim006_ExpConjugation
import Ising2D.Part008.Definition016_TV
import Ising2D.Part008.Definition030_Fermi

namespace Ising2D

open Ising2D.Abstract (sinhc twoDimConjMat)

variable {M : ℕ}

/-! ## 位相因子と `θ_μ` -/

/-- `exp(-i 2πμ/M) = exp(-θ_μ i)`（`θ_μ = 2πμ/M`）。`M = 0` でも両辺 `1` で成り立つ。 -/
theorem expPhase_eq_exp_neg_thetaMu (M : ℕ) (μ : ℤ) :
    expPhase M μ = Complex.exp (-((thetaMu M μ : ℝ) : ℂ) * Complex.I) := by
  rw [expPhase, thetaMu]
  congr 1
  push_cast
  ring

/-- `exp(-i 2π(-μ)/M) = exp(θ_μ i)`。 -/
theorem expPhase_neg_eq_exp_thetaMu (M : ℕ) (μ : ℤ) :
    expPhase M (-μ) = Complex.exp (((thetaMu M μ : ℝ) : ℂ) * Complex.I) := by
  rw [expPhase, thetaMu]
  congr 1
  push_cast
  ring

/-! ## `B_1(θ)`, `B_2` が抽象版の作用行列であること -/

/-- **原文 `005` (h1.z)(h1.y) の係数の突き合わせ**:
`α = i K_1 e^{-iθ}`, `β = -i K_1 e^{iθ}`, `s = K_1` のとき、抽象版の作用行列
`twoDimConjMat α β s` は原文の `B_1(θ)` に一致する。

要点は `K_1 · sinhc(K_1) = sinh(K_1)`（`Abstract.mul_sinhc`）だけである。 -/
theorem B1mat_eq_twoDimConjMat (K1 θ : ℂ) :
    B1mat K1 θ = twoDimConjMat
      (Complex.I * K1 * Complex.exp (-θ * Complex.I))
      (-Complex.I * K1 * Complex.exp (θ * Complex.I)) K1 := by
  have h := Abstract.mul_sinhc K1
  -- 非対角成分だけが `sinhc` を含む。`K_1 sinhc(K_1) = sinh(K_1)` で `sinh` へ直す。
  have e01 : -Complex.I * K1 * Complex.exp (θ * Complex.I) * sinhc K1
      = -Complex.I * Complex.exp (θ * Complex.I) * Complex.sinh K1 := by
    linear_combination (-Complex.I * Complex.exp (θ * Complex.I)) * h
  have e10 : Complex.I * K1 * Complex.exp (-θ * Complex.I) * sinhc K1
      = Complex.I * Complex.exp (-θ * Complex.I) * Complex.sinh K1 := by
    linear_combination (Complex.I * Complex.exp (-θ * Complex.I)) * h
  simp only [B1mat, twoDimConjMat, e01, e10]

/-- **原文 `005` (h2.z−)(h2.y) の係数の突き合わせ**:
`α = -2i K_2^*`, `β = 2i K_2^*`, `s = 2K_2^*` のとき、抽象版の作用行列は原文の `B_2` に一致する。 -/
theorem B2mat_eq_twoDimConjMat (K2star : ℂ) :
    B2mat K2star = twoDimConjMat
      (-(2 * Complex.I * K2star)) (2 * Complex.I * K2star) (2 * K2star) := by
  have h := Abstract.mul_sinhc (2 * K2star)
  have e01 : 2 * Complex.I * K2star * sinhc (2 * K2star)
      = Complex.I * Complex.sinh (2 * K2star) := by
    linear_combination Complex.I * h
  have e10 : -(2 * Complex.I * K2star) * sinhc (2 * K2star)
      = -Complex.I * Complex.sinh (2 * K2star) := by
    linear_combination (-Complex.I) * h
  simp only [B2mat, twoDimConjMat, e01, e10]

/-! ## exp 共役が `ActsBy` で作用すること（抽象版の特殊化） -/

/-- **抽象版 `Abstract.exp_conj_two_dim_actsBy` の具体版**: `ad X` が `span{z, y}` を保つとき、
共役 `T_{exp X}` は `(z, y)` に `twoDimConjMat α β s` で作用する。 -/
theorem actsBy_TConj_matExpUnits {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) :
    ActsBy (TConj (matExpUnits X)).toLinearMap z y (twoDimConjMat α β s) := by
  constructor
  · show matExp X * z * matExp (-X) = _
    rw [matExp_conj_two_dim_z hz hy hs]
    rfl
  · show matExp X * y * matExp (-X) = _
    rw [matExp_conj_two_dim_y hz hy hs, add_comm]
    rfl

/-- **原文「`(2s_2)^{M/2}` のスカラーは共役で打ち消し合う」の具体版**
（抽象版は `Abstract.conj_smul_eq`）。 -/
theorem actsBy_TConj_smulUnits {c : ℂ} (hc : c ≠ 0) {u : (TensorPow M)ˣ}
    {z y : TensorPow M} {B : Matrix (Fin 2) (Fin 2) ℂ}
    (h : ActsBy (TConj u).toLinearMap z y B) :
    ActsBy (TConj (smulUnits c hc u)).toLinearMap z y B := by
  obtain ⟨h1, h2⟩ := h
  constructor
  · show (c • (u : TensorPow M)) * z * (c⁻¹ • ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M)) = _
    rw [Abstract.conj_smul_eq hc]
    exact h1
  · show (c • (u : TensorPow M)) * y * (c⁻¹ • ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M)) = _
    rw [Abstract.conj_smul_eq hc]
    exact h2

/-! ## `T_{(V_1^{(-)})^{1/2}}` の作用（原文 `012` の第 1・第 2 式） -/

/-- `ad ((1/2) i K_1 H_1^{(-)})` は `span{hat(Z)_μ^{(-)}, hat(Y)_μ}` を保つ（`z` 側）。
`<commutator_of_H_and_Z_Y>` (1)（`lie_H1_hatZ_same`）の帰結。 -/
theorem ad_V1half_hatZMinus (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (((1 / 2 : ℂ) * Complex.I * K1) • H1 M 1) * hatZMinus M μ -
        hatZMinus M μ * (((1 / 2 : ℂ) * Complex.I * K1) • H1 M 1)
      = (Complex.I * K1 * Complex.exp (-((thetaMu M μ : ℝ) : ℂ) * Complex.I)) • hatY M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, hatZMinus_def, ← Ring.lie_def,
    lie_H1_hatZ_same hM (by norm_num) μ, smul_smul, ← expPhase_eq_exp_neg_thetaMu]
  congr 1
  ring

/-- 同上（`y` 側）。`<commutator_of_H_and_Z_Y>` (3)（`lie_H1_hatY`）の帰結。 -/
theorem ad_V1half_hatY (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (((1 / 2 : ℂ) * Complex.I * K1) • H1 M 1) * hatY M μ -
        hatY M μ * (((1 / 2 : ℂ) * Complex.I * K1) • H1 M 1)
      = (-Complex.I * K1 * Complex.exp (((thetaMu M μ : ℝ) : ℂ) * Complex.I)) •
          hatZMinus M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def,
    lie_H1_hatY hM (by norm_num) μ, smul_smul, ← expPhase_neg_eq_exp_thetaMu, hatZMinus_def]
  congr 1
  ring

/-- `e^{-iθ} e^{iθ} = 1`。 -/
private theorem exp_neg_mul_exp (θ : ℂ) :
    Complex.exp (-θ * Complex.I) * Complex.exp (θ * Complex.I) = 1 := by
  rw [← Complex.exp_add]
  simp

/-- **原文 `012` の第 1・第 2 式**（`T_{(V_1^{(±)})^{1/2}}` の作用行列は `B_1(θ_μ)`）。
原文が明示的な仮定として置いていたものを、ここで**証明する**。 -/
theorem actsBy_TConj_V1half (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    ActsBy (TConj (V1halfUnits M K1 1)).toLinearMap (hatZMinus M μ) (hatY M μ)
      (B1mat K1 ((thetaMu M μ : ℝ) : ℂ)) := by
  rw [B1mat_eq_twoDimConjMat]
  refine actsBy_TConj_matExpUnits (ad_V1half_hatZMinus hM K1 μ) (ad_V1half_hatY hM K1 μ) ?_
  -- `αβ = (i K_1 e^{-iθ})(-i K_1 e^{iθ}) = K_1^2`（`i^2 = -1` と `e^{-iθ}e^{iθ} = 1`）
  have h := exp_neg_mul_exp ((thetaMu M μ : ℝ) : ℂ)
  have hI : Complex.I * Complex.I = -1 := Complex.I_mul_I
  linear_combination (-(K1 ^ 2)) * h +
    (K1 ^ 2 * Complex.exp (-((thetaMu M μ : ℝ) : ℂ) * Complex.I) *
      Complex.exp (((thetaMu M μ : ℝ) : ℂ) * Complex.I)) * hI

/-! ## `T_{V_2}` の作用（原文 `012` の第 3・第 4 式） -/

/-- `ad (i K_2^* H_2)` は `span{hat(Z)_μ^{(-)}, hat(Y)_μ}` を保つ（`z` 側）。
`<commutator_of_H_and_Z_Y>` (4)（`lie_H2_hatZMinus`）の帰結。 -/
theorem ad_V2_hatZMinus (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ((Complex.I * K2star) • H2 M) * hatZMinus M μ -
        hatZMinus M μ * ((Complex.I * K2star) • H2 M)
      = (-(2 * Complex.I * K2star)) • hatY M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, hatZMinus_def, ← Ring.lie_def,
    lie_H2_hatZMinus hM μ, smul_smul]
  congr 1
  ring

/-- 同上（`y` 側）。`<commutator_of_H_and_Z_Y>` (6)（`lie_H2_hatY`）の帰結。 -/
theorem ad_V2_hatY (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ((Complex.I * K2star) • H2 M) * hatY M μ - hatY M μ * ((Complex.I * K2star) • H2 M)
      = (2 * Complex.I * K2star) • hatZMinus M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H2_hatY hM μ, smul_smul,
    hatZMinus_def]
  congr 1
  ring

/-- **原文 `012` の第 3・第 4 式**（`T_{V_2}` の作用行列は `B_2`）。
`V_2` のスカラー因子 `(2s_2)^{M/2}` は共役で打ち消える。 -/
theorem actsBy_TConj_V2 (hM : M ≠ 0) {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) (μ : ℤ) :
    ActsBy (TConj (V2Units M hs2 K2star)).toLinearMap (hatZMinus M μ) (hatY M μ)
      (B2mat K2star) := by
  rw [B2mat_eq_twoDimConjMat]
  refine actsBy_TConj_smulUnits _ ?_
  refine actsBy_TConj_matExpUnits (ad_V2_hatZMinus hM K2star μ) (ad_V2_hatY hM K2star μ) ?_
  ring_nf
  rw [Complex.I_sq]
  ring

/-! ## `T_{(V)}` の作用（原文 `<T_V_hatZ_hatY>`、無条件版） -/

/-- **原文 `<T_V_hatZ_hatY>`（無条件版）**:

  `(T_{(V)}(hat(Z)_μ^{(-)}), T_{(V)}(hat(Y)_μ)) = (hat(Z)_μ^{(-)}, hat(Y)_μ) A(θ_μ)`

`Part008/Definition016_TV.lean` の `TV_hatZ_hatY_of_action'` が持っていた
`ActsBy` の仮定 `hT1`, `hT2` を、`actsBy_TConj_V1half` / `actsBy_TConj_V2` で埋めた形。

残る仮定は「`IsingConst` の成分が `K_1, K_2^*` の双曲線関数であること」と
双対関係の帰結 `hdual : s_2^* c_2 = c_2^*` だけで、いずれも**数学的に必要**な仮定である
（未形式化に由来する仮定は残っていない）。 -/
theorem TV_hatZ_hatY (hM : M ≠ 0) (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ)
    {s2 : ℝ} (hs2 : 0 < s2)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    ActsBy (TV (V1halfUnits M K1 1) (V2Units M hs2 K2star)).toLinearMap
      (hatZMinus M μ) (hatY M μ) (AMat K (thetaMu M μ)) :=
  TV_hatZ_hatY_of_action' K μ K1 K2star (thetaMu M μ) _ _
    (actsBy_TConj_V1half hM K1 μ) (actsBy_TConj_V2 hM hs2 K2star μ)
    hc1 hs1 hc2star hs2star hdual

/-! ## `ψ_μ^†`, `ψ_μ` が `T_{(V)}` の固有ベクトルであること（原文 `<commutation_V_psi>`、無条件版） -/

variable (K : IsingConst)

/-- **原文 `<commutation_V_psi>` 第 1 式（無条件版）**: `T_{(V)}(ψ_μ^†) = λ_{+,μ} ψ_μ^†`。

`Part008/Definition030_Fermi.lean` の `TV_psiDag_of_action` が持っていた
`ActsBy` の仮定 `hT` を `TV_hatZ_hatY` で埋めた形。 -/
theorem TV_psiDag (hM : M ≠ 0) (μ : ℤ) (t : ℂ) (K1 K2star : ℂ) {s2 : ℝ} (hs2 : 0 < s2)
    (ht : t ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hg : gamma2 K (thetaMu M μ) ≠ 0)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    (TV (V1halfUnits M K1 1) (V2Units M hs2 K2star)).toLinearMap (psiDag K M μ t)
      = Dmat K (thetaMu M μ) t 0 0 • psiDag K M μ t :=
  TV_psiDag_of_action K hM μ t ht hg _
    (TV_hatZ_hatY hM K μ K1 K2star hs2 hc1 hs1 hc2star hs2star hdual)

/-- **原文 `<commutation_V_psi>` 第 2 式（無条件版）**: `T_{(V)}(ψ_μ) = λ_{-,μ} ψ_μ`。 -/
theorem TV_psi (hM : M ≠ 0) (μ : ℤ) (t : ℂ) (K1 K2star : ℂ) {s2 : ℝ} (hs2 : 0 < s2)
    (ht : t ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hg : gamma2 K (thetaMu M μ) ≠ 0)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    (TV (V1halfUnits M K1 1) (V2Units M hs2 K2star)).toLinearMap (psi K M μ t)
      = Dmat K (thetaMu M μ) t 1 1 • psi K M μ t :=
  TV_psi_of_action K hM μ t ht hg _
    (TV_hatZ_hatY hM K μ K1 K2star hs2 hc1 hs1 hc2star hs2star hdual)

/-- 上の 2 式を原文の `λ_{±,μ} = γ_1(θ_μ) ∓ i t` の明示形で書いた無条件版。 -/
theorem TV_psiDag_psi (hM : M ≠ 0) (μ : ℤ) (t : ℂ) (K1 K2star : ℂ) {s2 : ℝ} (hs2 : 0 < s2)
    (ht : t ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hg : gamma2 K (thetaMu M μ) ≠ 0)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    (TV (V1halfUnits M K1 1) (V2Units M hs2 K2star)).toLinearMap (psiDag K M μ t)
        = (gamma1 K (thetaMu M μ) - Complex.I * t) • psiDag K M μ t
      ∧ (TV (V1halfUnits M K1 1) (V2Units M hs2 K2star)).toLinearMap (psi K M μ t)
        = (gamma1 K (thetaMu M μ) + Complex.I * t) • psi K M μ t :=
  TV_psiDag_psi_of_action K hM μ t ht hg _
    (TV_hatZ_hatY hM K μ K1 K2star hs2 hc1 hs1 hc2star hs2star hdual)

end Ising2D
