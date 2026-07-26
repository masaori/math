/-
# フェルミオン演算子 `ψ_μ`, `ψ_μ^†` の定義・反交換関係・`T_{(V)}` の作用

対応する人手証明（正本は `structured-latex/content/008_TV1_hatZ_hatY_part2.mjs`）:

* `TV1_hatZ_hatY_030_definition_fermi`（ラベル `def_fermi`）— `ψ_μ, ψ_μ^†` の定義
* `TV1_hatZ_hatY_031_claim_V_psi_commutator`（ラベル `commutation_V_psi`）
  — `T_{(V)}(ψ_μ^†) = λ_{+,μ}ψ_μ^†`, `T_{(V)}(ψ_μ) = λ_{-,μ}ψ_μ`
* `TV1_hatZ_hatY_032_claim_anticommutator_psi`（ラベル `anticommutator_of_psi`）
  — `[ψ_μ^†, ψ_ν^†]₊ = 0`, `[ψ_μ^†, ψ_ν]₊ = δ^M_{μ+ν,0} I`, `[ψ_μ, ψ_ν]₊ = 0`

## 形式化の方針

* 原文の定義は行ベクトル記法 `(ψ_μ^†, ψ_μ) := (hat(Z)_μ^{(-)}, hat(Y)_μ) · P_μ` である。
  すなわち **`P_μ` の第 0 列が `ψ_μ^†` の係数、第 1 列が `ψ_μ` の係数**であるから、
  `Part008/Claim027_EigenATheta.lean` の `Pmat` の列をそのまま使って `psiDag`, `psi` を定義する。
  原文が「すなわち」として与えている明示式との一致は `psiDag_eq` / `psi_eq` で検算する。
* 平方根は既存ファイル（`Claim027_EigenATheta.lean`）と同じ流儀で、
  `t : ℂ` が `t^2 = γ_2(θ_μ)γ_2(-θ_μ)` を満たす、という**仮定**として受け取る。
  複素平方根の分枝関数は導入しない。
* 原文が statement へ格上げしている「定義が意味をもつ条件」`γ_2(θ_μ) ≠ 0` は、
  各定理の仮定 `hg : gamma2 K (thetaMu M μ) ≠ 0` として明示する。
  （`γ_2(-θ_μ) ≠ 0` は `gamma2_neg_eq_zero_iff` から従うので別に仮定しない。）
* `√M` は `(Real.sqrt M : ℂ)`（`sqrtM M`）で表す。`M ≠ 0` のとき非零で、`(√M)^2 = M`。

## 原文の穴（`anticommutator_of_psi` の平方根の分枝）

**原文 `anticommutator_of_psi` の証明には、明示されていない前提がある。**

原文は `δ^M_{μ+ν,0} ≠ 0` すなわち `M ∣ μ+ν` のとき、`γ_2(θ_ν) = γ_2(-θ_μ)`
（`gamma2_thetaMu_of_dvd` で証明済み）から

  `√(γ_2(θ_ν)γ_2(-θ_ν)) · √(γ_2(θ_μ)γ_2(-θ_μ)) = (√(γ_2(θ_μ)γ_2(-θ_μ)))^2 = γ_2(θ_μ)γ_2(-θ_μ)`

を導いている。しかし根号の中身が等しい（`t_ν^2 = t_μ^2`）ことから従うのは `t_ν = ±t_μ` までで、
**`μ` と `ν` で平方根の分枝が同じであることは自明ではない。**

実際に検算すると、分枝が違えば結論は成り立たない。`c_μ := 1/(2√M γ_2(-θ_μ))` として

  `[ψ_μ^†, ψ_ν^†]₊` の係数 `= c_μ c_ν(-t_μ t_ν + γ_2(-θ_μ)γ_2(-θ_ν)) · 2Mδ`

であり、`M ∣ μ+ν` のとき `γ_2(-θ_μ)γ_2(-θ_ν) = γ_2(θ_μ)γ_2(-θ_μ) = t_μ^2` だから、係数の括弧は
`t_μ^2 - t_μ t_ν = t_μ(t_μ - t_ν)` である。ここで `γ_2(θ_μ) ≠ 0` より
`t_μ^2 = γ_2(θ_μ)γ_2(-θ_μ) = -|γ_2(θ_μ)|^2 ≠ 0` すなわち `t_μ ≠ 0` なので、

* `t_ν = t_μ`（同一分枝）なら括弧は `0` となり `[ψ_μ^†, ψ_ν^†]₊ = 0`（原文どおり）
* `t_ν = -t_μ`（逆分枝）なら括弧は `2t_μ^2 ≠ 0` となり `[ψ_μ^†, ψ_ν^†]₊ ≠ 0`（原文は**偽**）

同様に `[ψ_μ^†, ψ_ν]₊` の係数の括弧は `t_μ t_ν + t_μ^2` で、同一分枝なら `2t_μ^2` となって
`δ^M_{μ+ν,0} I` を与えるが、逆分枝なら `0` になり原文の主張は成り立たない。

**したがって「同一分枝の選択」は必要不可欠であり、原文の穴である。**
本ファイルでは仮定 `hbr : (M : ℤ) ∣ (μ + ν) → tν = tμ` として明示する
（`M ∤ μ+ν` のときは分枝の関係は結論に影響しないので、含意の形にしてある）。

## かつての「未証明の穴」（**解消済み・2026-07-26**）

本ファイルの `TV_psiDag_of_action` / `TV_psi_of_action` / `TV_psiDag_psi_of_action` は、
`T_{(V)}` が `(hat(Z)_μ^{(-)}, hat(Y)_μ)` に行列 `A(θ_μ)` で作用すること（原文 `T_V_hatZ_hatY`）を
`hT : ActsBy T (hat(Z)_μ^{(-)}) (hat(Y)_μ) (AMat K (thetaMu M μ))` という**明示的な仮定**として持つ。
以前は「ネストした交換子のテイラー係数抽出（`parts 008` の 001〜005）が未形式化なので
この仮定は証明できない」という状態だった。

**この仮定は現在 `Ising2D/Part008/Claim012_TVActions.lean` の `Ising2D.TV_hatZ_hatY` で
証明されており、穴は残っていない。** 同ファイルには原文 `commutation_V_psi` に対応する
**無条件版** `Ising2D.TV_psiDag` / `Ising2D.TV_psi` / `Ising2D.TV_psiDag_psi` を置いてある
（`T` を具体的に `T_{(V)} = T_{(V_1^{(-)})^{1/2}} ∘ T_{V_2} ∘ T_{(V_1^{(-)})^{1/2}}` に取った形）。

本ファイルの仮定つき版は、`T` を任意の線型写像のままにした一般形として残してある。
仮定から先（`P_μ` の列が固有ベクトルであること、したがって `ψ_μ^†, ψ_μ` が `T` の
固有ベクトルであること）は本ファイルで完全に証明している。

なお、上に述べた**平方根の分枝の仮定 `hbr` は原文の穴に由来するもので、性質が異なる**
（未形式化に由来する仮定ではないので、これは除去できない）。
-/
import Ising2D.Part007.Claim000_AnticommutatorHatZHatY
import Ising2D.Part008.Definition016_TV
import Ising2D.Part008.Claim027_EigenATheta
import Mathlib.Tactic.Module

namespace Ising2D

open Matrix

/-! ## 補助: 反交換子の双線型性（2 元の線型結合どうし） -/

section Bilin

variable {A : Type*} [Ring A] [Algebra ℂ A]

/-- 反交換子の双線型性（原文 `anticommutator_of_psi` の「双線型性より」の行）。 -/
theorem acomm_lin2 (a b c d : ℂ) (z1 y1 z2 y2 : A) :
    acomm (a • z1 + b • y1) (c • z2 + d • y2)
      = (a * c) • acomm z1 z2 + (a * d) • acomm z1 y2
        + (b * c) • acomm y1 z2 + (b * d) • acomm y1 y2 := by
  simp only [acomm, add_mul, mul_add, smul_add, smul_mul_assoc, mul_smul_comm, smul_smul]
  module

end Bilin

/-- `hat(Z)^{(-)}, hat(Y)` の線型結合どうしの反交換子（原文の 4 つの反交換関係を代入した形）。 -/
theorem acomm_hatZMinus_hatY_lin2 {M : ℕ} (hM : M ≠ 0) (a b c d : ℂ) (μ ν : ℤ) :
    acomm (a • hatZMinus M μ + b • hatY M μ) (c • hatZMinus M ν + d • hatY M ν)
      = ((a * c + b * d) * (2 * (M : ℂ) * deltaMod M (μ + ν) 0)) • (1 : TensorPow M) := by
  have h1 : acomm (hatZMinus M μ) (hatZMinus M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 0) • (1 : TensorPow M) :=
    acomm_hatZMinus_hatZMinus hM μ ν
  have h2 : acomm (hatZMinus M μ) (hatY M ν) = 0 := acomm_hatZ_hatY 1 μ ν
  have h3 : acomm (hatY M μ) (hatZMinus M ν) = 0 := acomm_hatY_hatZ 1 μ ν
  have h4 : acomm (hatY M μ) (hatY M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 0) • (1 : TensorPow M) :=
    acomm_hatY_hatY hM μ ν
  rw [acomm_lin2, h1, h2, h3, h4, smul_zero, smul_zero, smul_smul, smul_smul]
  module

/-! ## `√M` -/

/-- 原文の `√M`（`M ∈ ℕ`）を ℂ の元として。 -/
noncomputable def sqrtM (M : ℕ) : ℂ := (Real.sqrt M : ℂ)

theorem sqrtM_ne_zero {M : ℕ} (hM : M ≠ 0) : sqrtM M ≠ 0 := by
  simp only [sqrtM, ne_eq, Complex.ofReal_eq_zero]
  exact Real.sqrt_ne_zero'.2 (by exact_mod_cast Nat.pos_of_ne_zero hM)

@[simp]
theorem sqrtM_sq (M : ℕ) : sqrtM M ^ 2 = (M : ℂ) := by
  have : Real.sqrt M ^ 2 = (M : ℝ) := Real.sq_sqrt (by positivity)
  simp only [sqrtM, ← Complex.ofReal_pow, this, Complex.ofReal_natCast]

/-! ## `ψ_μ`, `ψ_μ^†` の定義（原文 `def_fermi`） -/

variable (K : IsingConst)

/-- **原文 `def_fermi`**: `(ψ_μ^†, ψ_μ) := (hat(Z)_μ^{(-)}, hat(Y)_μ) · P_μ` の**第 0 列**。

`t` は原文の `√(γ_2(θ_μ)γ_2(-θ_μ))` にあたり、`t^2 = γ_2(θ_μ)γ_2(-θ_μ)` を満たすものとして
各定理の仮定で受け取る（分枝関数は導入しない）。 -/
noncomputable def psiDag (M : ℕ) (μ : ℤ) (t : ℂ) : TensorPow M :=
  Pmat K (thetaMu M μ) t (sqrtM M) 0 0 • hatZMinus M μ
    + Pmat K (thetaMu M μ) t (sqrtM M) 1 0 • hatY M μ

/-- **原文 `def_fermi`**: 同じく**第 1 列**が `ψ_μ`。 -/
noncomputable def psi (M : ℕ) (μ : ℤ) (t : ℂ) : TensorPow M :=
  Pmat K (thetaMu M μ) t (sqrtM M) 0 1 • hatZMinus M μ
    + Pmat K (thetaMu M μ) t (sqrtM M) 1 1 • hatY M μ

/-- **原文の「すなわち」の検算**:
`ψ_μ^† = (+i√(γ_2(θ_μ)γ_2(-θ_μ))/(2√M γ_2(-θ_μ))) hat(Z)_μ^{(-)} + (1/(2√M)) hat(Y)_μ`。 -/
theorem psiDag_eq (M : ℕ) (μ : ℤ) (t : ℂ) :
    psiDag K M μ t
      = (Complex.I * t / (2 * sqrtM M * gamma2 K (-thetaMu M μ))) • hatZMinus M μ
        + (1 / (2 * sqrtM M)) • hatY M μ := by
  simp [psiDag, Pmat]

/-- **原文の「すなわち」の検算**:
`ψ_μ = (-i√(γ_2(θ_μ)γ_2(-θ_μ))/(2√M γ_2(-θ_μ))) hat(Z)_μ^{(-)} + (1/(2√M)) hat(Y)_μ`。 -/
theorem psi_eq (M : ℕ) (μ : ℤ) (t : ℂ) :
    psi K M μ t
      = (-(Complex.I * t) / (2 * sqrtM M * gamma2 K (-thetaMu M μ))) • hatZMinus M μ
        + (1 / (2 * sqrtM M)) • hatY M μ := by
  simp [psi, Pmat]

/-! ## 分枝と `γ_2` の対称性（`M ∣ μ+ν` のときに効く事実） -/

/-- `t^2 = γ_2(θ)γ_2(-θ)` と `γ_2(θ) ≠ 0` から `t ≠ 0`。
（`γ_2(θ)γ_2(-θ) = -|γ_2(θ)|^2 ≠ 0` による。） -/
theorem t_ne_zero {θ : ℝ} {t : ℂ} (ht : t ^ 2 = gamma2 K θ * gamma2 K (-θ))
    (hg : gamma2 K θ ≠ 0) : t ≠ 0 := by
  intro h
  have hh : gamma2 K (-θ) ≠ 0 := fun h' => hg ((gamma2_neg_eq_zero_iff K θ).1 h')
  have : (0 : ℂ) = gamma2 K θ * gamma2 K (-θ) := by rw [← ht, h]; ring
  rcases mul_eq_zero.1 this.symm with h1 | h1
  · exact hg h1
  · exact hh h1

/-- `M ∣ μ+ν` のとき `γ_2(-θ_μ)γ_2(-θ_ν) = γ_2(θ_μ)γ_2(-θ_μ)`。
（`gamma2_thetaMu_of_dvd` を `μ, ν` の両向きに使う。） -/
theorem gamma2_neg_mul_gamma2_neg_of_dvd (M : ℕ) (hM : M ≠ 0) (μ ν : ℤ)
    (hd : (M : ℤ) ∣ (μ + ν)) :
    gamma2 K (-thetaMu M μ) * gamma2 K (-thetaMu M ν)
      = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ) := by
  have h1 : gamma2 K (thetaMu M ν) = gamma2 K (-thetaMu M μ) :=
    gamma2_thetaMu_of_dvd K M hM μ ν hd
  have hd' : (M : ℤ) ∣ (ν + μ) := by rwa [add_comm] at hd
  have h2 : gamma2 K (thetaMu M μ) = gamma2 K (-thetaMu M ν) :=
    gamma2_thetaMu_of_dvd K M hM ν μ hd'
  rw [← h1, ← h2]
  ring

/-- `M ∣ μ+ν` のとき `t_ν^2 = t_μ^2`（分枝は決まらない。ファイル冒頭「原文の穴」参照）。 -/
theorem t_sq_eq_of_dvd (M : ℕ) (hM : M ≠ 0) (μ ν : ℤ) (tμ tν : ℂ)
    (htμ : tμ ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (htν : tν ^ 2 = gamma2 K (thetaMu M ν) * gamma2 K (-thetaMu M ν))
    (hd : (M : ℤ) ∣ (μ + ν)) : tν ^ 2 = tμ ^ 2 := by
  have h1 : gamma2 K (thetaMu M ν) = gamma2 K (-thetaMu M μ) :=
    gamma2_thetaMu_of_dvd K M hM μ ν hd
  have hd' : (M : ℤ) ∣ (ν + μ) := by rwa [add_comm] at hd
  have h2 : gamma2 K (thetaMu M μ) = gamma2 K (-thetaMu M ν) :=
    gamma2_thetaMu_of_dvd K M hM ν μ hd'
  rw [htμ, htν, ← h1, ← h2]
  ring

/-! ## `ψ` の反交換関係（原文 `anticommutator_of_psi`）

`hbr` が**同一分枝の選択**（ファイル冒頭「原文の穴」参照）。 -/

section Anticomm

/-- 反交換子の係数計算を 1 箇所にまとめたもの。`ε = +1` が `[ψ^†, ψ^†]₊`・`[ψ, ψ]₊`（結論 `0`）、
`ε = -1` が `[ψ^†, ψ]₊`（結論 `δ`）にあたる（`hat(Z)` 側の係数の積の符号）。 -/
private theorem acomm_psi_coeff {M : ℕ} (K : IsingConst) (hM : M ≠ 0) (μ ν : ℤ) (tμ tν : ℂ) (ε : ℂ)
    (htμ : tμ ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (_htν : tν ^ 2 = gamma2 K (thetaMu M ν) * gamma2 K (-thetaMu M ν))
    (hgμ : gamma2 K (thetaMu M μ) ≠ 0) (hgν : gamma2 K (thetaMu M ν) ≠ 0)
    (hbr : (M : ℤ) ∣ (μ + ν) → tν = tμ) :
    ((ε * (Complex.I * tμ) / (2 * sqrtM M * gamma2 K (-thetaMu M μ)))
        * (Complex.I * tν / (2 * sqrtM M * gamma2 K (-thetaMu M ν)))
      + (1 / (2 * sqrtM M)) * (1 / (2 * sqrtM M)))
        * (2 * (M : ℂ) * deltaMod M (μ + ν) 0)
      = ((1 - ε) / 2) * deltaMod M (μ + ν) 0 := by
  by_cases hd : (M : ℤ) ∣ (μ + ν)
  · -- `δ = 1`。`γ_2(-θ_μ)γ_2(-θ_ν) = t_ν^2` と同一分枝 `t_ν = t_μ` で係数が確定する。
    have hδ : deltaMod M (μ + ν) 0 = 1 := by simp [deltaMod, sub_zero, hd]
    have htt : tν = tμ := hbr hd
    have ht0 : tμ ≠ 0 := t_ne_zero K htμ hgμ
    have ht0' : tν ≠ 0 := by rw [htt]; exact ht0
    have hs : sqrtM M ≠ 0 := sqrtM_ne_zero hM
    have hsq : sqrtM M ^ 2 = (M : ℂ) := sqrtM_sq M
    have hM' : (M : ℂ) ≠ 0 := by rw [← hsq]; exact pow_ne_zero 2 hs
    have hI : Complex.I ^ 2 = -1 := Complex.I_sq
    -- `γ_2(-θ_μ)γ_2(-θ_ν) = γ_2(θ_μ)γ_2(-θ_μ) = t_μ^2 = t_ν^2`
    have hgg : gamma2 K (-thetaMu M μ) * gamma2 K (-thetaMu M ν) = tν ^ 2 := by
      rw [gamma2_neg_mul_gamma2_neg_of_dvd K M hM μ ν hd, ← htμ, htt]
    have hhμ : gamma2 K (-thetaMu M μ) ≠ 0 :=
      fun h => hgμ ((gamma2_neg_eq_zero_iff K _).1 h)
    have hhν : gamma2 K (-thetaMu M ν) ≠ 0 :=
      fun h => hgν ((gamma2_neg_eq_zero_iff K _).1 h)
    -- 積の項をまとめて分母を `4 (√M)^2 (γ_2(-θ_μ)γ_2(-θ_ν))` に揃える。
    have e1 : (ε * (Complex.I * tμ) / (2 * sqrtM M * gamma2 K (-thetaMu M μ)))
        * (Complex.I * tν / (2 * sqrtM M * gamma2 K (-thetaMu M ν)))
        = ε * Complex.I ^ 2 * (tμ * tν) /
            (4 * sqrtM M ^ 2 * (gamma2 K (-thetaMu M μ) * gamma2 K (-thetaMu M ν))) := by
      ring
    have e2 : (1 / (2 * sqrtM M)) * (1 / (2 * sqrtM M)) = 1 / (4 * sqrtM M ^ 2) := by
      ring
    rw [hδ, e1, e2, hgg, hI, hsq, htt]
    field_simp
    ring
  · have hδ : deltaMod M (μ + ν) 0 = 0 := by simp [deltaMod, sub_zero, hd]
    rw [hδ]
    ring

/-- **原文 `anticommutator_of_psi` 第 1 式**: `[ψ_μ^†, ψ_ν^†]₊ = 0`。 -/
theorem acomm_psiDag_psiDag {M : ℕ} (K : IsingConst) (hM : M ≠ 0) (μ ν : ℤ) (tμ tν : ℂ)
    (htμ : tμ ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (htν : tν ^ 2 = gamma2 K (thetaMu M ν) * gamma2 K (-thetaMu M ν))
    (hgμ : gamma2 K (thetaMu M μ) ≠ 0) (hgν : gamma2 K (thetaMu M ν) ≠ 0)
    (hbr : (M : ℤ) ∣ (μ + ν) → tν = tμ) :
    acomm (psiDag K M μ tμ) (psiDag K M ν tν) = 0 := by
  rw [psiDag_eq, psiDag_eq, acomm_hatZMinus_hatY_lin2 hM]
  have h := acomm_psi_coeff K hM μ ν tμ tν 1 htμ htν hgμ hgν hbr
  simp only [one_mul] at h
  rw [h]
  simp

/-- **原文 `anticommutator_of_psi` 第 3 式**: `[ψ_μ, ψ_ν]₊ = 0`。 -/
theorem acomm_psi_psi {M : ℕ} (K : IsingConst) (hM : M ≠ 0) (μ ν : ℤ) (tμ tν : ℂ)
    (htμ : tμ ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (htν : tν ^ 2 = gamma2 K (thetaMu M ν) * gamma2 K (-thetaMu M ν))
    (hgμ : gamma2 K (thetaMu M μ) ≠ 0) (hgν : gamma2 K (thetaMu M ν) ≠ 0)
    (hbr : (M : ℤ) ∣ (μ + ν) → tν = tμ) :
    acomm (psi K M μ tμ) (psi K M ν tν) = 0 := by
  rw [psi_eq, psi_eq, acomm_hatZMinus_hatY_lin2 hM]
  have h := acomm_psi_coeff K hM μ ν tμ tν 1 htμ htν hgμ hgν hbr
  have hrw : (-(Complex.I * tμ) / (2 * sqrtM M * gamma2 K (-thetaMu M μ)))
      * (-(Complex.I * tν) / (2 * sqrtM M * gamma2 K (-thetaMu M ν)))
      = (1 * (Complex.I * tμ) / (2 * sqrtM M * gamma2 K (-thetaMu M μ)))
        * (Complex.I * tν / (2 * sqrtM M * gamma2 K (-thetaMu M ν))) := by
    ring
  rw [hrw, h]
  simp

/-- **原文 `anticommutator_of_psi` 第 2 式**: `[ψ_μ^†, ψ_ν]₊ = δ^M_{μ+ν,0} I`。 -/
theorem acomm_psiDag_psi {M : ℕ} (K : IsingConst) (hM : M ≠ 0) (μ ν : ℤ) (tμ tν : ℂ)
    (htμ : tμ ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (htν : tν ^ 2 = gamma2 K (thetaMu M ν) * gamma2 K (-thetaMu M ν))
    (hgμ : gamma2 K (thetaMu M μ) ≠ 0) (hgν : gamma2 K (thetaMu M ν) ≠ 0)
    (hbr : (M : ℤ) ∣ (μ + ν) → tν = tμ) :
    acomm (psiDag K M μ tμ) (psi K M ν tν)
      = (deltaMod M (μ + ν) 0) • (1 : TensorPow M) := by
  rw [psiDag_eq, psi_eq, acomm_hatZMinus_hatY_lin2 hM]
  have h := acomm_psi_coeff K hM μ ν tμ tν (-1) htμ htν hgμ hgν hbr
  have hrw : (Complex.I * tμ / (2 * sqrtM M * gamma2 K (-thetaMu M μ)))
      * (-(Complex.I * tν) / (2 * sqrtM M * gamma2 K (-thetaMu M ν)))
      = ((-1) * (Complex.I * tμ) / (2 * sqrtM M * gamma2 K (-thetaMu M μ)))
        * (Complex.I * tν / (2 * sqrtM M * gamma2 K (-thetaMu M ν))) := by
    ring
  rw [hrw, h]
  norm_num

end Anticomm

/-! ## `T_{(V)}` の `ψ` への作用（原文 `commutation_V_psi`） -/

/-- `D_μ` の対角成分（原文の `λ_{+,μ}`）。 -/
theorem Dmat_zero_zero (θ : ℝ) (t : ℂ) :
    Dmat K θ t 0 0 = gamma1 K θ - Complex.I * t := by simp [Dmat]

/-- `D_μ` の対角成分（原文の `λ_{-,μ}`）。 -/
theorem Dmat_one_one (θ : ℝ) (t : ℂ) :
    Dmat K θ t 1 1 = gamma1 K θ + Complex.I * t := by simp [Dmat]

/-- `P_μ` の第 0 列は、`eigenvector_of_A_theta` の `v_+ = (i t, γ_2(-θ))` のスカラー倍。 -/
theorem Pmat_col_zero (θ : ℝ) (t sM : ℂ) (hsM : sM ≠ 0) (hh : gamma2 K (-θ) ≠ 0) :
    (fun i => Pmat K θ t sM i 0)
      = (1 / (2 * sM * gamma2 K (-θ))) • ![Complex.I * t, gamma2 K (-θ)] := by
  funext i
  fin_cases i <;> simp [Pmat] <;> field_simp

/-- `P_μ` の第 1 列は、`eigenvector_of_A_theta` の `v_- = (-i t, γ_2(-θ))` のスカラー倍。 -/
theorem Pmat_col_one (θ : ℝ) (t sM : ℂ) (hsM : sM ≠ 0) (hh : gamma2 K (-θ) ≠ 0) :
    (fun i => Pmat K θ t sM i 1)
      = (1 / (2 * sM * gamma2 K (-θ))) • ![-(Complex.I * t), gamma2 K (-θ)] := by
  funext i
  fin_cases i <;> simp [Pmat] <;> field_simp

/-- `P_μ` の第 0 列は `A(θ_μ)` の固有値 `λ_{+,μ} = D_μ(0,0)` の固有ベクトル。 -/
theorem AMat_mulVec_Pmat_col_zero (θ : ℝ) (t sM : ℂ)
    (ht : t ^ 2 = gamma2 K θ * gamma2 K (-θ)) (hsM : sM ≠ 0) (hh : gamma2 K (-θ) ≠ 0) :
    AMat K θ *ᵥ (fun i => Pmat K θ t sM i 0)
      = Dmat K θ t 0 0 • (fun i => Pmat K θ t sM i 0) := by
  rw [Pmat_col_zero K θ t sM hsM hh, Matrix.mulVec_smul, AMat_mulVec_col_pos K θ t ht,
    Dmat_zero_zero, smul_comm]

/-- `P_μ` の第 1 列は `A(θ_μ)` の固有値 `λ_{-,μ} = D_μ(1,1)` の固有ベクトル。 -/
theorem AMat_mulVec_Pmat_col_one (θ : ℝ) (t sM : ℂ)
    (ht : t ^ 2 = gamma2 K θ * gamma2 K (-θ)) (hsM : sM ≠ 0) (hh : gamma2 K (-θ) ≠ 0) :
    AMat K θ *ᵥ (fun i => Pmat K θ t sM i 1)
      = Dmat K θ t 1 1 • (fun i => Pmat K θ t sM i 1) := by
  rw [Pmat_col_one K θ t sM hsM hh, Matrix.mulVec_smul, AMat_mulVec_col_neg K θ t ht,
    Dmat_one_one, smul_comm]

/-- **原文 `commutation_V_psi` 第 1 式（仮定つきの形）**: `T(ψ_μ^†) = λ_{+,μ} ψ_μ^†`。

`hT` は原文 `T_V_hatZ_hatY`（未形式化。ファイル冒頭「未証明の穴」参照）。 -/
theorem TV_psiDag_of_action {M : ℕ} (hM : M ≠ 0) (μ : ℤ) (t : ℂ)
    (ht : t ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hg : gamma2 K (thetaMu M μ) ≠ 0)
    (T : TensorPow M →ₗ[ℂ] TensorPow M)
    (hT : ActsBy T (hatZMinus M μ) (hatY M μ) (AMat K (thetaMu M μ))) :
    T (psiDag K M μ t) = Dmat K (thetaMu M μ) t 0 0 • psiDag K M μ t := by
  have hh : gamma2 K (-thetaMu M μ) ≠ 0 := fun h => hg ((gamma2_neg_eq_zero_iff K _).1 h)
  exact hT.eigen (AMat_mulVec_Pmat_col_zero K (thetaMu M μ) t (sqrtM M) ht (sqrtM_ne_zero hM) hh)

/-- **原文 `commutation_V_psi` 第 2 式（仮定つきの形）**: `T(ψ_μ) = λ_{-,μ} ψ_μ`。 -/
theorem TV_psi_of_action {M : ℕ} (hM : M ≠ 0) (μ : ℤ) (t : ℂ)
    (ht : t ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hg : gamma2 K (thetaMu M μ) ≠ 0)
    (T : TensorPow M →ₗ[ℂ] TensorPow M)
    (hT : ActsBy T (hatZMinus M μ) (hatY M μ) (AMat K (thetaMu M μ))) :
    T (psi K M μ t) = Dmat K (thetaMu M μ) t 1 1 • psi K M μ t := by
  have hh : gamma2 K (-thetaMu M μ) ≠ 0 := fun h => hg ((gamma2_neg_eq_zero_iff K _).1 h)
  exact hT.eigen (AMat_mulVec_Pmat_col_one K (thetaMu M μ) t (sqrtM M) ht (sqrtM_ne_zero hM) hh)

/-- 上の 2 式を原文の `λ_{±,μ}` の明示形で書いた版。 -/
theorem TV_psiDag_psi_of_action {M : ℕ} (hM : M ≠ 0) (μ : ℤ) (t : ℂ)
    (ht : t ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hg : gamma2 K (thetaMu M μ) ≠ 0)
    (T : TensorPow M →ₗ[ℂ] TensorPow M)
    (hT : ActsBy T (hatZMinus M μ) (hatY M μ) (AMat K (thetaMu M μ))) :
    T (psiDag K M μ t)
        = (gamma1 K (thetaMu M μ) - Complex.I * t) • psiDag K M μ t
      ∧ T (psi K M μ t)
        = (gamma1 K (thetaMu M μ) + Complex.I * t) • psi K M μ t := by
  constructor
  · simpa [Dmat_zero_zero] using TV_psiDag_of_action K hM μ t ht hg T hT
  · simpa [Dmat_one_one] using TV_psi_of_action K hM μ t ht hg T hT

end Ising2D
