/-
# 具体版: `T_{(V_1^{(±)})^{1/2}}`, `T_{V_2}`, `T_{(V)}` の `hat(Z)^{(-)}, hat(Y)` への作用

対応する人手の主張は、本文から参照用ノート `structured-latex/notes/integer_momentum_route_not_adopted.ts` へ
退避した次のものである（整数運動量の経路を本文から外したため）。本ファイルはその形式化の記録として残す。

* もと `TV1_hatZ_hatY_002_claim_nesting_commutator`（ラベル `nesting_of_commutator_of_H_and_Z`）
  — `n` 重の入れ子交換子の偶奇による閉じた形
* もと `TV1_hatZ_hatY_005_claim_extract_taylor_coefficient`（ラベル `extract_taylor_coefficient_of_Z_Y`）
  — 上の級数和が `cosh K_1`, `i e^{-iθ_μ} sinh K_1` 等になること
* もと `TV1_hatZ_hatY_012_claim_TV1_TV2_actions`（ラベル `ホロノミック量子場_p142下段_1`）
  — `T_{(V_1^{(±)})^{1/2}}`, `T_{V_2}` の作用行列が `B_1(θ_μ)`, `B_2` であること
* もと `TV1_hatZ_hatY_018_claim_T_V_action`（ラベル `T_V_hatZ_hatY`）
  — `(T_{(V)}(hat(Z)_μ^{(-)}), T_{(V)}(hat(Y)_μ)) = (hat(Z)_μ^{(-)}, hat(Y)_μ) A(2πμ/M)`

**必要十分版は `Ising2D/NecSuf/TVAction.lean`**（名前空間 `Ising2D.NecSuf`）。
本ファイルの主要定理はそこからの特殊化として導出する。何が本質的かは必要十分版の冒頭に書いた。

## 仮定つき版と無条件版

本ファイルの `TV_hatZ_hatY_of_action` / `TV_hatZ_hatY_of_action'` と
`RoutesNotAdopted/IntegerMomentum/DefinitionFermiPsi.lean` の `TV_psiDag_of_action` / `TV_psi_of_action` は、
`ActsBy`（原文の行ベクトル記法）を**明示的な仮定**に取る。本ファイルはその仮定を
`actsBy_TConj_V1pmHalf`・`actsBy_TConj_V2H2Form` で証明し、
`TV_hatZ_hatY`（原文 `<T_V_hatZ_hatY>`）と
`TV_psiDag` / `TV_psi`（原文 `<commutation_V_psi>`）を**無条件の定理**として与える。

## 証明の骨格（原文との対応）

原文が「入れ子交換子の偶奇の場合分け（`002`）→ テイラー係数の抽出（`005`）」の 2 段で
やっていることを、Lean では **`ad X` が `span{hat(Z)_μ^{(-)}, hat(Y)_μ}` を保つ**という
1 つの事実に集約し、既に形式化済みの `matExp_conj_two_dim_z` / `..._y`
（`EigenvalueProblem/ReductionToATheta/ClaimExpConjugation.lean`）へ渡す。

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
   （`B1mat_eq_twoDimConjMat`, `B2mat_eq_twoDimConjMat` が突き合わせそのもの。この 2 本と
   `actsBy_TConj_matExpUnits`・`actsBy_TConj_smulUnits` は経路に依らないので
   `EigenvalueProblem/ReductionToATheta/ClaimTActionsOnCheckFromNecSuf.lean` に置き、本ファイルはそれを使う。
   原文の誤りは見つからなかった）。
4. `V_2` のスカラー因子 `(2s_2)^{M/2}` は共役で打ち消える（`NecSuf.conj_smul_eq`）。
   原文が「スカラーは共役で打ち消し合う」と書いている一行がこれである。
5. 1〜4 を `ActsBy.comp` でつないで `B_1(θ_μ) B_2 B_1(θ_μ) = A(θ_μ)`
   （`B1_mul_B2_mul_B1_eq_AMat`）へ帰着させる。

## 原文の符号の選択について

原文 `012` の証明は「本主張では `hat(Z)_μ^{(-)}` に作用させるので、`±` はいずれも `-`
（すなわち `H_1^{(-)}` と `hat(Z)_μ^{(-)}` の組）を選んで適用する」と明記している。
Lean の記法では `hat(Z)^{(-)} = hatZ M 1 μ`、`H_1^{(-)} = H1 M 1`（引数 `η` が原文の `∓1`）
なので、本ファイルでは一貫して `η = 1` を使う。`<commutator_of_H_and_Z_Y>` のうち
**偽であることが判明している (2)(5)**（`RoutesNotAdopted/IntegerMomentum/ClaimCommutatorHAndHatZHatY.lean` 冒頭参照）は
`hat(Z)^{(∓)}` すなわち逆符号の組についての式なので、**本ファイルの経路では一切使わない**。

## 残っている仮定について

`B_1 B_2 B_1 = A(θ)` には双対関係の帰結 `s_2^* c_2 = c_2^*` が要る（原文はこれを
明示していない。`Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean` 冒頭「原文の問題」参照）。これは
**未形式化に由来する穴ではなく数学的に必要な仮定**なので、`hdual` として残す。
同様に `c_1 = cosh 2K_1` 等の `IsingConst` の成分と `K_1, K_2^*` の関係も仮定として持つ。
-/
import Ising2D.NecSuf.TVAction
import Ising2D.NecSuf.TVActionSandwich
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimTActionsOnCheckFromNecSuf
import Ising2D.RoutesNotAdopted.IntegerMomentum.ClaimCommutatorHAndHatZHatY
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExpConjugation
import Ising2D.MathematicalTools.InvertibleMatricesLinearMapCorrespondenceAndConjugation.DefinitionTgAndTV
import Ising2D.RoutesNotAdopted.IntegerMomentum.DefinitionFermiPsi

namespace Ising2D

open Ising2D.NecSuf (sinhc twoDimConjMat)

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

/-! ## `T_{(V_1^{(-)})^{1/2}}` の作用（原文 `012` の第 1・第 2 式） -/

/-- `ad ((1/2) i K_1 H_1^{(-)})` は `span{hat(Z)_μ^{(-)}, hat(Y)_μ}` を保つ（`z` 側）。
`<commutator_of_H_and_Z_Y>` (1)（`lie_H1_hatZ_same`）の帰結。 -/
theorem ad_V1pmHalf_hatZMinus (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (((1 / 2 : ℂ) * Complex.I * K1) • H1 M 1) * hatZMinus M μ -
        hatZMinus M μ * (((1 / 2 : ℂ) * Complex.I * K1) • H1 M 1)
      = (Complex.I * K1 * Complex.exp (-((thetaMu M μ : ℝ) : ℂ) * Complex.I)) • hatY M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, hatZMinus_def, ← Ring.lie_def,
    lie_H1_hatZ_same hM (by norm_num) μ, smul_smul, ← expPhase_eq_exp_neg_thetaMu]
  congr 1
  ring

/-- 同上（`y` 側）。`<commutator_of_H_and_Z_Y>` (3)（`lie_H1_hatY`）の帰結。 -/
theorem ad_V1pmHalf_hatY (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
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
theorem actsBy_TConj_V1pmHalf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    ActsBy (TConj (V1pmHalfUnits M K1 1)).toLinearMap (hatZMinus M μ) (hatY M μ)
      (B1mat K1 ((thetaMu M μ : ℝ) : ℂ)) := by
  rw [B1mat_eq_twoDimConjMat]
  refine actsBy_TConj_matExpUnits (ad_V1pmHalf_hatZMinus hM K1 μ) (ad_V1pmHalf_hatY hM K1 μ) ?_
  -- `αβ = (i K_1 e^{-iθ})(-i K_1 e^{iθ}) = K_1^2`（`i^2 = -1` と `e^{-iθ}e^{iθ} = 1`）
  have h := exp_neg_mul_exp ((thetaMu M μ : ℝ) : ℂ)
  have hI : Complex.I * Complex.I = -1 := Complex.I_mul_I
  linear_combination (-(K1 ^ 2)) * h +
    (K1 ^ 2 * Complex.exp (-((thetaMu M μ : ℝ) : ℂ) * Complex.I) *
      Complex.exp (((thetaMu M μ : ℝ) : ℂ) * Complex.I)) * hI

/-! ## `T_{V_2}` の作用（原文 `012` の第 3・第 4 式） -/

/-- `ad (i K_2^* H_2)` は `span{hat(Z)_μ^{(-)}, hat(Y)_μ}` を保つ（`z` 側）。
`<commutator_of_H_and_Z_Y>` (4)（`lie_H2_hatZMinus`）の帰結。 -/
theorem ad_V2H2Form_hatZMinus (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ((Complex.I * K2star) • H2 M) * hatZMinus M μ -
        hatZMinus M μ * ((Complex.I * K2star) • H2 M)
      = (-(2 * Complex.I * K2star)) • hatY M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, hatZMinus_def, ← Ring.lie_def,
    lie_H2_hatZMinus hM μ, smul_smul]
  congr 1
  ring

/-- 同上（`y` 側）。`<commutator_of_H_and_Z_Y>` (6)（`lie_H2_hatY`）の帰結。 -/
theorem ad_V2H2Form_hatY (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) :
    ((Complex.I * K2star) • H2 M) * hatY M μ - hatY M μ * ((Complex.I * K2star) • H2 M)
      = (2 * Complex.I * K2star) • hatZMinus M μ := by
  rw [smul_mul_assoc, mul_smul_comm, ← smul_sub, ← Ring.lie_def, lie_H2_hatY hM μ, smul_smul,
    hatZMinus_def]
  congr 1
  ring

/-- **原文 `012` の第 3・第 4 式**（`T_{V_2}` の作用行列は `B_2`）。
`V_2` のスカラー因子 `(2s_2)^{M/2}` は共役で打ち消える。 -/
theorem actsBy_TConj_V2H2Form (hM : M ≠ 0) {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) (μ : ℤ) :
    ActsBy (TConj (V2H2FormUnits M hs2 K2star)).toLinearMap (hatZMinus M μ) (hatY M μ)
      (B2mat K2star) := by
  rw [B2mat_eq_twoDimConjMat]
  refine actsBy_TConj_smulUnits _ ?_
  refine actsBy_TConj_matExpUnits (ad_V2H2Form_hatZMinus hM K2star μ) (ad_V2H2Form_hatY hM K2star μ) ?_
  ring_nf
  rw [Complex.I_sq]
  ring

/-! ## `T_{(V)}` の `hat(Z)^{(-)}, hat(Y)` への作用（仮定つき） -/

/-- **原文 `T_V_hatZ_hatY`（仮定つきの形）**。

`hT1`, `hT2` は原文 `ホロノミック量子場_p142下段_1` の内容で、ここでは仮定として受け取る。
仮定から先（合成則による `B_1 B_2 B_1` の計算と `B_1 B_2 B_1 = A(θ)`）をここで証明する。
仮定は下の `actsBy_TConj_V1pmHalf`・`actsBy_TConj_V2H2Form` で埋まり、無条件版が `TV_hatZ_hatY` である。 -/
theorem TV_hatZ_hatY_of_action (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ) (θ : ℝ)
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
theorem TV_hatZ_hatY_of_action' (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ) (θ : ℝ)
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

/-! ## `T_{(V)}` の作用（原文 `<T_V_hatZ_hatY>`、無条件版） -/

/-- **原文 `<T_V_hatZ_hatY>`（無条件版）**:

  `(T_{(V)}(hat(Z)_μ^{(-)}), T_{(V)}(hat(Y)_μ)) = (hat(Z)_μ^{(-)}, hat(Y)_μ) A(θ_μ)`

上の `TV_hatZ_hatY_of_action'` の
`ActsBy` の仮定 `hT1`, `hT2` を、`actsBy_TConj_V1pmHalf` / `actsBy_TConj_V2H2Form` で埋めた形。

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
    ActsBy (TV (V1pmHalfUnits M K1 1) (V2H2FormUnits M hs2 K2star)).toLinearMap
      (hatZMinus M μ) (hatY M μ) (AMat K (thetaMu M μ)) :=
  TV_hatZ_hatY_of_action' K μ K1 K2star (thetaMu M μ) _ _
    (actsBy_TConj_V1pmHalf hM K1 μ) (actsBy_TConj_V2H2Form hM hs2 K2star μ)
    hc1 hs1 hc2star hs2star hdual

/-! ## `ψ_μ^†`, `ψ_μ` が `T_{(V)}` の固有ベクトルであること（原文 `<commutation_V_psi>`、無条件版） -/

variable (K : IsingConst)

/-- **原文 `<commutation_V_psi>` 第 1 式（無条件版）**: `T_{(V)}(ψ_μ^†) = λ_{+,μ} ψ_μ^†`。

`RoutesNotAdopted/IntegerMomentum/DefinitionFermiPsi.lean` の `TV_psiDag_of_action` が持っていた
`ActsBy` の仮定 `hT` を `TV_hatZ_hatY` で埋めた形。 -/
theorem TV_psiDag (hM : M ≠ 0) (μ : ℤ) (t : ℂ) (K1 K2star : ℂ) {s2 : ℝ} (hs2 : 0 < s2)
    (ht : t ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hg : gamma2 K (thetaMu M μ) ≠ 0)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    (TV (V1pmHalfUnits M K1 1) (V2H2FormUnits M hs2 K2star)).toLinearMap (psiDag K M μ t)
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
    (TV (V1pmHalfUnits M K1 1) (V2H2FormUnits M hs2 K2star)).toLinearMap (psi K M μ t)
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
    (TV (V1pmHalfUnits M K1 1) (V2H2FormUnits M hs2 K2star)).toLinearMap (psiDag K M μ t)
        = (gamma1 K (thetaMu M μ) - Complex.I * t) • psiDag K M μ t
      ∧ (TV (V1pmHalfUnits M K1 1) (V2H2FormUnits M hs2 K2star)).toLinearMap (psi K M μ t)
        = (gamma1 K (thetaMu M μ) + Complex.I * t) • psi K M μ t :=
  TV_psiDag_psi_of_action K hM μ t ht hg _
    (TV_hatZ_hatY hM K μ K1 K2star hs2 hc1 hs1 hc2star hs2star hdual)

/-! ## 整数運動量版と半整数運動量版は同じ必要十分版の別の特殊化であること

008 章の結論 `<T_V_hatZ_hatY>`（既存の `Ising2D.TV_hatZ_hatY`）も、
本文の章「離散 Fourier 変換による 2×2 行列 A(θ̃_μ) への帰着」の結論 `TVPlus_checkZ_checkY` を必要十分版から導いた `TVPlus_checkZ_checkY_of_necSuf`（`EigenvalueProblem/ReductionToATheta/ClaimTVPlusActionFromNecSuf.lean`）と**まったく同じ必要十分版 `NecSuf.actsBy_TV_sandwich` の特殊化**として得られる。
渡すものが `(hat(Z)^{(-)}_μ, hat(Y)_μ, B_1(θ_μ))` か
`(check(Z)_μ, check(Y)_μ, B_1(θ~_μ))` かの違いしかない。 -/

/-- **整数運動量版（008 章 `<T_V_hatZ_hatY>`）を同じ必要十分版から導いたもの**。
既存の `Ising2D.TV_hatZ_hatY` と同じ主張である（`NecSuf.actsBy_TV_sandwich` 経由の別証明）。 -/
theorem TV_hatZ_hatY_via_sandwich (hM : M ≠ 0) (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ)
    {s2 : ℝ} (hs2 : 0 < s2)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    ActsBy (TV (V1pmHalfUnits M K1 1) (V2H2FormUnits M hs2 K2star)).toLinearMap
      (hatZMinus M μ) (hatY M μ) (AMat K (thetaMu M μ)) := by
  have h := NecSuf.actsBy_TV_sandwich (actsBy_TConj_V1pmHalf hM K1 μ)
    (actsBy_TConj_V2H2Form hM hs2 K2star μ)
  rwa [B1_mul_B2_mul_B1_eq_AMat K K1 K2star (thetaMu M μ) hc1 hs1 hc2star hs2star hdual] at h

end Ising2D
