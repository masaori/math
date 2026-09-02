/-
# 具体版: `T_{(V^{(+)})}` の `check(Z), check(Y)` への作用（**章 014 の結論**）

対応する人手証明のラベル: **`T_V_plus_check_Z_Y`**
（`structured-latex/content/014_even_sector_T_action.ts` の
`evensectorT_010_claim_T_V_plus_action`）

**必要十分版**は `Ising2D/NecSuf/TVActionSandwich.lean` の
`Ising2D.NecSuf.actsBy_TV_sandwich`（`exp(x₁) · c exp(x₂) · exp(x₁)` の共役の
`span{z, y}` への作用行列が `B₁ B₂ B₁` であること。ℂ 上の完備ノルム環なら何でもよい）。
本ファイルの結論は、そこへ `(α, β, s)` を代入し `B₁B₂B₁ = A(θ~_μ)` を掛け合わせたものである。

## 原文の主張

  `(T_{(V^{(+)})}(check(Z)_μ), T_{(V^{(+)})}(check(Y)_μ))
     = (check(Z)_μ, check(Y)_μ) A(θ~_μ)`,  `θ~_μ = 2π(μ - 1/2)/M`

## 証明の骨格（原文との対応）

原文は `T_actions_on_check_Z_Y` → `linearity_of_T_V2` → `calc_of_TxT_check_Z_Y`
→ `linearity_of_T_on_check_Z_Y` → もう一度 `calc_of_TxT_check_Z_Y`
の順で `B_1(θ~) B_2 B_1(θ~)` と掛け、最後に `factorization_of_A_theta_general` を当てている。
Lean では行ベクトル記法の合成則 `Ising2D.ActsBy.comp`
（`Part008/Definition016_TV.lean`。線型性はここに埋め込まれている）を 2 回使って
`B_1(θ~_μ) B_2 B_1(θ~_μ)` を作り、`factorization_of_A_theta_general` で `A(θ~_μ)` へ移す。

## 残る仮定について（008 章と同じ）

`IsingConst` の 5 成分が `K_1, K_2^*` の双曲線関数であることと、双対関係の帰結
`hdual : s_2^* c_2 = c_2^*` だけである。いずれも**数学的に必要**で、
未形式化に由来する仮定は無い。
-/
import Ising2D.NecSuf.TVActionSandwich
import Ising2D.Part014.Claim005_TActionsOnCheck
import Ising2D.Part014.Claim009_FactorizationATheta
import Ising2D.Part014.Definition001_VPlus

namespace Ising2D

variable {M : ℕ}

/-- **章 014 の結論（原文 `T_V_plus_check_Z_Y`）**:

  `(T_{(V^{(+)})}(check(Z)_μ), T_{(V^{(+)})}(check(Y)_μ))
     = (check(Z)_μ, check(Y)_μ) A(θ~_μ)`

行ベクトル記法は `Ising2D.ActsBy`（`B` の**列**が像の係数）。 -/
theorem TVPlus_checkZ_checkY (hM : M ≠ 0) (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ)
    {s2 : ℝ} (hs2 : 0 < s2)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    ActsBy (TVPlus M hs2 K1 K2star).toLinearMap (checkZ M μ) (checkY M μ)
      (AMat K (thetaTilde M μ)) := by
  have h := NecSuf.actsBy_TV_sandwich (actsBy_TConj_V1halfPlus hM K1 μ)
    (actsBy_TConj_V2_check hM hs2 K2star μ)
  rwa [factorization_of_A_thetaTilde (M := M) K K1 K2star μ hc1 hs1 hc2star hs2star hdual] at h

/-- 上を成分の形（原文の 2 本の等式）で書いた版。 -/
theorem TVPlus_checkZ_checkY_components (hM : M ≠ 0) (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ)
    {s2 : ℝ} (hs2 : 0 < s2)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    TVPlus M hs2 K1 K2star (checkZ M μ)
        = AMat K (thetaTilde M μ) 0 0 • checkZ M μ
          + AMat K (thetaTilde M μ) 1 0 • checkY M μ
      ∧ TVPlus M hs2 K1 K2star (checkY M μ)
        = AMat K (thetaTilde M μ) 0 1 • checkZ M μ
          + AMat K (thetaTilde M μ) 1 1 • checkY M μ :=
  TVPlus_checkZ_checkY hM K μ K1 K2star hs2 hc1 hs1 hc2star hs2star hdual

/-! ## 整数運動量版と半整数運動量版は同じ必要十分版の別の特殊化であること

008 章の結論 `<T_V_hatZ_hatY>`（既存の `Ising2D.TV_hatZ_hatY`）も、
本章の結論と**まったく同じ必要十分版 `NecSuf.actsBy_TV_sandwich` の特殊化**として得られる。
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
    ActsBy (TV (V1halfUnits M K1 1) (V2Units M hs2 K2star)).toLinearMap
      (hatZMinus M μ) (hatY M μ) (AMat K (thetaMu M μ)) := by
  have h := NecSuf.actsBy_TV_sandwich (actsBy_TConj_V1half hM K1 μ)
    (actsBy_TConj_V2 hM hs2 K2star μ)
  rwa [B1_mul_B2_mul_B1_eq_AMat K K1 K2star (thetaMu M μ) hc1 hs1 hc2star hs2star hdual] at h

end Ising2D
