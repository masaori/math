/-
# `ψ` の反交換関係 — **抽象版**と、そこからの具体版の導出、および分枝の必要性

対応する人手証明（正本は `structured-latex/content/008_TV1_hatZ_hatY_part2.mjs`）:
- `TV1_hatZ_hatY_032_claim_anticommutator_psi`（ラベル `anticommutator_of_psi`）
- 係数の由来: `TV1_hatZ_hatY_030_definition_fermi`（ラベル `def_fermi`）

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

`Part008/Definition030_Fermi.lean` にある `acomm_psiDag_psiDag` / `acomm_psiDag_psi` /
`acomm_psi_psi` は、人手証明と 1 対 1 に対応する **具体版**（`TensorPow M` の
`hat(Z)_μ^{(-)}`, `hat(Y)_μ` を直接扱う）である。本ファイルはその **抽象版**を置き、
**具体版が抽象版の特殊化として得られることを実際に導出**する。

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **抽象版** | `acomm_lincomb_clifford`, `car_of_coeffs` | ℂ-代数の 4 元 `z, y, z', y'` の反交換関係 `[z,z']₊ = D·1`, `[z,y']₊ = 0`, `[y,z']₊ = 0`, `[y,y']₊ = D·1` と、係数のスカラー恒等式 2 本**だけ**。行列であることも `hat(Z)`, `hat(Y)` の具体形も、`M`・`δ^M`・`γ_2` も使わない |
| **具体版** | `Definition030_Fermi.lean` の 3 定理。本ファイルの `acomm_psi_relations_of_car` はそれと同じ主張を**抽象版の系として**導いたもの | 上に `z = hat(Z)_μ^{(-)}`, `y = hat(Y)_μ`, `D = 2Mδ^M_{μ+ν,0}`, `p = i t_μ/(2√M γ_2(-θ_μ))`, `q = 1/(2√M)` を代入 |

抽象版が明らかにしているのは「**この主張に効いているのは反交換関係と係数の 2 本の恒等式だけ**」
ということである。逆に、具体版が余計な構造（複素行列であること、テンソル冪であること、
`γ_2` の具体形）に依存していないことの検査にもなっている。
持ち込んだ抽象化は ℂ-代数までで、テンソル積の一般論は使っていない。

具体版の反交換関係 `acomm_hatZMinus_hatY_lin2`（`Definition030_Fermi.lean`）が
抽象版の特殊化にすぎないことも `acomm_hatZMinus_hatY_lin2_of_abstract` で確認する。

## 平方根の分枝の必要性（原文の穴の定量化）

`Definition030_Fermi.lean` の冒頭が述べているとおり、`M ∣ μ+ν` のとき
`t_ν = ±t_μ` のどちらであるかは原文の statement からは決まらず、
逆分枝を取ると結論が破れる。本ファイルではそれを**定理として証明**する:

* `acomm_psiDag_psiDag_of_opposite_branch`: `M ∣ μ+ν` かつ `t_ν = -t_μ` のとき
  `[ψ_μ^†, ψ_ν^†]₊ = I`（`≠ 0`。原文第 1 式が破れる）
* `acomm_psiDag_psi_of_opposite_branch`: 同じ状況で `[ψ_μ^†, ψ_ν]₊ = 0`
  （`δ^M_{μ+ν,0} I = I` にならず、原文第 2 式が破れる）

すなわち仮定 `hbr : M ∣ μ+ν → t_ν = t_μ` は**省略できない**。
なお原文の `√` を「積の値だけで決まる単一値関数」と読めば逆分枝は起こらないので、
**原文が誤っているわけではない**（statement に分枝の指定が無い、という穴である）。
-/
import Ising2D.Part008.Definition030_Fermi

namespace Ising2D

/-! ## 抽象版 -/

section Abstract

variable {A : Type*} [Ring A] [Algebra ℂ A]

/-- **抽象版の本体**（人手証明 `anticommutator_of_psi` の a), b), c) の計算はすべてこれ 1 本）。

`z, y, z', y'` が `[z, z']₊ = D·1`, `[z, y']₊ = 0`, `[y, z']₊ = 0`, `[y, y']₊ = D·1`
を満たすとき、線型結合どうしの反交換子は `((p p' + q q')·D)·1`。 -/
theorem acomm_lincomb_clifford (p q p' q' D : ℂ) (z y z' y' : A)
    (hzz : acomm z z' = D • (1 : A)) (hzy : acomm z y' = 0)
    (hyz : acomm y z' = 0) (hyy : acomm y y' = D • (1 : A)) :
    acomm (p • z + q • y) (p' • z' + q' • y') = ((p * p' + q * q') * D) • (1 : A) := by
  rw [acomm_lin2, hzz, hzy, hyz, hyy, smul_zero, smul_zero, add_zero, add_zero,
    smul_smul, smul_smul, ← add_smul]
  congr 1
  ring

/-- **抽象版の CAR（正準反交換関係）**。

`ψ^†` にあたるのが `p·z + q·y`、`ψ` にあたるのが `(-p)·z + q·y`
（原文 `def_fermi` の `±i√(γ_2(θ_μ)γ_2(-θ_μ))` が第 1 係数の符号反転にあたる）。

必要な仮定は反交換関係のほかには**係数のスカラー恒等式 2 本だけ**である。 -/
theorem car_of_coeffs (p q p' q' D δ : ℂ) (z y z' y' : A)
    (hzz : acomm z z' = D • (1 : A)) (hzy : acomm z y' = 0)
    (hyz : acomm y z' = 0) (hyy : acomm y y' = D • (1 : A))
    (hzero : (p * p' + q * q') * D = 0)
    (hone : (-(p * p') + q * q') * D = δ) :
    acomm (p • z + q • y) (p' • z' + q' • y') = 0
      ∧ acomm (p • z + q • y) ((-p') • z' + q' • y') = δ • (1 : A)
      ∧ acomm ((-p) • z + q • y) ((-p') • z' + q' • y') = 0 := by
  refine ⟨?_, ?_, ?_⟩
  · rw [acomm_lincomb_clifford p q p' q' D z y z' y' hzz hzy hyz hyy, hzero, zero_smul]
  · rw [acomm_lincomb_clifford p q (-p') q' D z y z' y' hzz hzy hyz hyy]
    rw [show (p * -p' + q * q') * D = (-(p * p') + q * q') * D by ring, hone]
  · rw [acomm_lincomb_clifford (-p) q (-p') q' D z y z' y' hzz hzy hyz hyy]
    rw [show (-p * -p' + q * q') * D = (p * p' + q * q') * D by ring, hzero, zero_smul]

end Abstract

/-! ## 具体版が抽象版の特殊化であることの確認 -/

/-- `Definition030_Fermi.lean` の `acomm_hatZMinus_hatY_lin2` は
抽象版 `acomm_lincomb_clifford` に `Part007` の 4 つの反交換関係を代入しただけである。 -/
theorem acomm_hatZMinus_hatY_lin2_of_abstract {M : ℕ} (hM : M ≠ 0) (a b c d : ℂ) (μ ν : ℤ) :
    acomm (a • hatZMinus M μ + b • hatY M μ) (c • hatZMinus M ν + d • hatY M ν)
      = ((a * c + b * d) * (2 * (M : ℂ) * deltaMod M (μ + ν) 0)) • (1 : TensorPow M) :=
  acomm_lincomb_clifford a b c d (2 * (M : ℂ) * deltaMod M (μ + ν) 0) _ _ _ _
    (acomm_hatZMinus_hatZMinus hM μ ν)
    (acomm_hatZ_hatY (M := M) 1 μ ν)
    (acomm_hatY_hatZ (M := M) 1 μ ν)
    (acomm_hatY_hatY hM μ ν)

/-! ## 具体版を抽象版の系として導出する

以下で使う係数は原文 `def_fermi` のもの:
`p_μ = i t_μ/(2√M γ_2(-θ_μ))`, `q = 1/(2√M)`。 -/

section Concrete

variable (K : IsingConst) {M : ℕ} (μ ν : ℤ) (tμ tν : ℂ)

/-- `ψ_μ` は `ψ_μ^†` の第 1 係数の符号を反転した形（抽象版の `(-p)·z + q·y`）。 -/
theorem psi_eq_neg_coeff :
    psi K M μ tμ
      = (-(Complex.I * tμ / (2 * sqrtM M * gamma2 K (-thetaMu M μ)))) • hatZMinus M μ
        + (1 / (2 * sqrtM M)) • hatY M μ := by
  rw [psi_eq, neg_div]

/-- 具体版の係数が満たすスカラー恒等式（`M ∣ μ+ν` の場合が本質）。
`hbr` が**同一分枝の選択**（原文の `√` が単一値関数であることに対応）。 -/
theorem psi_coeff_identities (hM : M ≠ 0)
    (htμ : tμ ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hgμ : gamma2 K (thetaMu M μ) ≠ 0)
    (hbr : (M : ℤ) ∣ (μ + ν) → tν = tμ) :
    let p := Complex.I * tμ / (2 * sqrtM M * gamma2 K (-thetaMu M μ))
    let q := (1 : ℂ) / (2 * sqrtM M)
    let p' := Complex.I * tν / (2 * sqrtM M * gamma2 K (-thetaMu M ν))
    (p * p' + q * q) * (2 * (M : ℂ) * deltaMod M (μ + ν) 0) = 0
      ∧ (-(p * p') + q * q) * (2 * (M : ℂ) * deltaMod M (μ + ν) 0)
          = deltaMod M (μ + ν) 0 := by
  intro p q p'
  by_cases hd : (M : ℤ) ∣ (μ + ν)
  · have hδ : deltaMod M (μ + ν) 0 = 1 := by simp [deltaMod, sub_zero, hd]
    have htt : tν = tμ := hbr hd
    have hs : sqrtM M ≠ 0 := sqrtM_ne_zero hM
    have hsq : sqrtM M ^ 2 = (M : ℂ) := sqrtM_sq M
    have hMc : (M : ℂ) ≠ 0 := by rw [← hsq]; exact pow_ne_zero 2 hs
    have ht0 : tμ ≠ 0 := t_ne_zero K htμ hgμ
    have hgg : gamma2 K (-thetaMu M μ) * gamma2 K (-thetaMu M ν) = tμ ^ 2 := by
      rw [gamma2_neg_mul_gamma2_neg_of_dvd K M hM μ ν hd, ← htμ]
    have hpp : p * p' = -(1 / (4 * (M : ℂ))) := by
      show Complex.I * tμ / (2 * sqrtM M * gamma2 K (-thetaMu M μ)) *
        (Complex.I * tν / (2 * sqrtM M * gamma2 K (-thetaMu M ν))) = _
      rw [htt, div_mul_div_comm,
        show (2 * sqrtM M * gamma2 K (-thetaMu M μ)) * (2 * sqrtM M * gamma2 K (-thetaMu M ν))
          = 4 * sqrtM M ^ 2 * (gamma2 K (-thetaMu M μ) * gamma2 K (-thetaMu M ν)) by ring,
        hgg, hsq,
        show Complex.I * tμ * (Complex.I * tμ) = -(tμ ^ 2) by
          linear_combination tμ ^ 2 * Complex.I_sq]
      field_simp
    have hqq : q * q = 1 / (4 * (M : ℂ)) := by
      show (1 : ℂ) / (2 * sqrtM M) * ((1 : ℂ) / (2 * sqrtM M)) = _
      rw [div_mul_div_comm, show (2 * sqrtM M) * (2 * sqrtM M) = 4 * sqrtM M ^ 2 by ring, hsq]
      norm_num
    refine ⟨?_, ?_⟩
    · rw [hpp, hqq, hδ]; ring
    · rw [hpp, hqq, hδ]; field_simp; norm_num
  · have hδ : deltaMod M (μ + ν) 0 = 0 := by simp [deltaMod, sub_zero, hd]
    constructor <;> rw [hδ] <;> ring

/-- **原文 `anticommutator_of_psi` の 3 式を、抽象版 `car_of_coeffs` の系として導いたもの。**

`Definition030_Fermi.lean` の `acomm_psiDag_psiDag` / `acomm_psiDag_psi` / `acomm_psi_psi`
と同じ主張であり、**具体版が抽象版の特殊化で得られる**ことを示している
（仮定も同じ。ただし `t_ν` 側の平方根条件 `htν` は抽象版の経路では不要なので現れない）。 -/
theorem acomm_psi_relations_of_car (hM : M ≠ 0)
    (htμ : tμ ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hgμ : gamma2 K (thetaMu M μ) ≠ 0)
    (hbr : (M : ℤ) ∣ (μ + ν) → tν = tμ) :
    acomm (psiDag K M μ tμ) (psiDag K M ν tν) = 0
      ∧ acomm (psiDag K M μ tμ) (psi K M ν tν)
          = deltaMod M (μ + ν) 0 • (1 : TensorPow M)
      ∧ acomm (psi K M μ tμ) (psi K M ν tν) = 0 := by
  obtain ⟨hzero, hone⟩ := psi_coeff_identities K μ ν tμ tν hM htμ hgμ hbr
  have h := car_of_coeffs
    (Complex.I * tμ / (2 * sqrtM M * gamma2 K (-thetaMu M μ))) ((1 : ℂ) / (2 * sqrtM M))
    (Complex.I * tν / (2 * sqrtM M * gamma2 K (-thetaMu M ν))) ((1 : ℂ) / (2 * sqrtM M))
    (2 * (M : ℂ) * deltaMod M (μ + ν) 0) (deltaMod M (μ + ν) 0)
    (hatZMinus M μ) (hatY M μ) (hatZMinus M ν) (hatY M ν)
    (acomm_hatZMinus_hatZMinus hM μ ν)
    (acomm_hatZ_hatY (M := M) 1 μ ν)
    (acomm_hatY_hatZ (M := M) 1 μ ν)
    (acomm_hatY_hatY hM μ ν)
    hzero hone
  rw [psiDag_eq K M μ tμ, psiDag_eq K M ν tν, psi_eq_neg_coeff K μ tμ, psi_eq_neg_coeff K ν tν]
  exact h

/-! ### 同一分枝の仮定 `hbr` が省略できないことの証明 -/

/-- **逆分枝では原文第 1 式が破れる**: `M ∣ μ+ν` かつ `t_ν = -t_μ` のとき
`[ψ_μ^†, ψ_ν^†]₊ = I`（`0` ではない）。 -/
theorem acomm_psiDag_psiDag_of_opposite_branch (hM : M ≠ 0)
    (htμ : tμ ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hgμ : gamma2 K (thetaMu M μ) ≠ 0)
    (hd : (M : ℤ) ∣ (μ + ν)) (hopp : tν = -tμ) :
    acomm (psiDag K M μ tμ) (psiDag K M ν tν) = (1 : TensorPow M) := by
  have hδ : deltaMod M (μ + ν) 0 = 1 := by simp [deltaMod, sub_zero, hd]
  have hs : sqrtM M ≠ 0 := sqrtM_ne_zero hM
  have hsq : sqrtM M ^ 2 = (M : ℂ) := sqrtM_sq M
  have hMc : (M : ℂ) ≠ 0 := by rw [← hsq]; exact pow_ne_zero 2 hs
  have ht0 : tμ ≠ 0 := t_ne_zero K htμ hgμ
  have hgg : gamma2 K (-thetaMu M μ) * gamma2 K (-thetaMu M ν) = tμ ^ 2 := by
    rw [gamma2_neg_mul_gamma2_neg_of_dvd K M hM μ ν hd, ← htμ]
  have hpp : Complex.I * tμ / (2 * sqrtM M * gamma2 K (-thetaMu M μ)) *
      (Complex.I * tν / (2 * sqrtM M * gamma2 K (-thetaMu M ν))) = 1 / (4 * (M : ℂ)) := by
    rw [hopp, div_mul_div_comm,
      show (2 * sqrtM M * gamma2 K (-thetaMu M μ)) * (2 * sqrtM M * gamma2 K (-thetaMu M ν))
        = 4 * sqrtM M ^ 2 * (gamma2 K (-thetaMu M μ) * gamma2 K (-thetaMu M ν)) by ring,
      hgg, hsq,
      show Complex.I * tμ * (Complex.I * -tμ) = tμ ^ 2 by
        linear_combination (-(tμ ^ 2)) * Complex.I_sq]
    field_simp
  have hqq : (1 : ℂ) / (2 * sqrtM M) * ((1 : ℂ) / (2 * sqrtM M)) = 1 / (4 * (M : ℂ)) := by
    rw [div_mul_div_comm, show (2 * sqrtM M) * (2 * sqrtM M) = 4 * sqrtM M ^ 2 by ring, hsq]
    norm_num
  rw [psiDag_eq K M μ tμ, psiDag_eq K M ν tν,
    acomm_lincomb_clifford _ _ _ _ (2 * (M : ℂ) * deltaMod M (μ + ν) 0) _ _ _ _
      (acomm_hatZMinus_hatZMinus hM μ ν)
      (acomm_hatZ_hatY (M := M) 1 μ ν)
      (acomm_hatY_hatZ (M := M) 1 μ ν)
      (acomm_hatY_hatY hM μ ν),
    hpp, hqq, hδ,
    show (1 / (4 * (M : ℂ)) + 1 / (4 * (M : ℂ))) * (2 * (M : ℂ) * 1) = 1 by
      field_simp; ring,
    one_smul]

/-- **逆分枝では原文第 2 式も破れる**: `M ∣ μ+ν` かつ `t_ν = -t_μ` のとき
`[ψ_μ^†, ψ_ν]₊ = 0`（本来は `δ^M_{μ+ν,0} I = I` のはず）。 -/
theorem acomm_psiDag_psi_of_opposite_branch (hM : M ≠ 0)
    (htμ : tμ ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ))
    (hgμ : gamma2 K (thetaMu M μ) ≠ 0)
    (hd : (M : ℤ) ∣ (μ + ν)) (hopp : tν = -tμ) :
    acomm (psiDag K M μ tμ) (psi K M ν tν) = 0 := by
  have hδ : deltaMod M (μ + ν) 0 = 1 := by simp [deltaMod, sub_zero, hd]
  have hs : sqrtM M ≠ 0 := sqrtM_ne_zero hM
  have hsq : sqrtM M ^ 2 = (M : ℂ) := sqrtM_sq M
  have hMc : (M : ℂ) ≠ 0 := by rw [← hsq]; exact pow_ne_zero 2 hs
  have ht0 : tμ ≠ 0 := t_ne_zero K htμ hgμ
  have hgg : gamma2 K (-thetaMu M μ) * gamma2 K (-thetaMu M ν) = tμ ^ 2 := by
    rw [gamma2_neg_mul_gamma2_neg_of_dvd K M hM μ ν hd, ← htμ]
  have hpp : Complex.I * tμ / (2 * sqrtM M * gamma2 K (-thetaMu M μ)) *
      (-(Complex.I * tν / (2 * sqrtM M * gamma2 K (-thetaMu M ν)))) = -(1 / (4 * (M : ℂ))) := by
    rw [hopp]
    rw [show Complex.I * tμ / (2 * sqrtM M * gamma2 K (-thetaMu M μ)) *
        (-(Complex.I * -tμ / (2 * sqrtM M * gamma2 K (-thetaMu M ν))))
        = -(Complex.I * tμ * (Complex.I * -tμ) /
            (4 * sqrtM M ^ 2 * (gamma2 K (-thetaMu M μ) * gamma2 K (-thetaMu M ν)))) by ring,
      hgg, hsq,
      show Complex.I * tμ * (Complex.I * -tμ) = tμ ^ 2 by
        linear_combination (-(tμ ^ 2)) * Complex.I_sq]
    field_simp
  have hqq : (1 : ℂ) / (2 * sqrtM M) * ((1 : ℂ) / (2 * sqrtM M)) = 1 / (4 * (M : ℂ)) := by
    rw [div_mul_div_comm, show (2 * sqrtM M) * (2 * sqrtM M) = 4 * sqrtM M ^ 2 by ring, hsq]
    norm_num
  rw [psiDag_eq K M μ tμ, psi_eq_neg_coeff K ν tν,
    acomm_lincomb_clifford _ _ _ _ (2 * (M : ℂ) * deltaMod M (μ + ν) 0) _ _ _ _
      (acomm_hatZMinus_hatZMinus hM μ ν)
      (acomm_hatZ_hatY (M := M) 1 μ ν)
      (acomm_hatY_hatZ (M := M) 1 μ ν)
      (acomm_hatY_hatY hM μ ν),
    hpp, hqq, hδ,
    show (-(1 / (4 * (M : ℂ))) + 1 / (4 * (M : ℂ))) * (2 * (M : ℂ) * 1) = 0 by ring,
    zero_smul]

end Concrete

end Ising2D
