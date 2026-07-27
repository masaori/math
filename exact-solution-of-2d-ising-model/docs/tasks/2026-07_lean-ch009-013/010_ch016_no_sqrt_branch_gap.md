# 016 章 `anticommutator_of_check_psi` に「平方根の分枝」の穴は無い（検証結果）

対象: `structured-latex/content/016_even_sector_fermions.ts` の
`evenfermi_003_claim_anticommutator`（ラベル `anticommutator_of_check_psi`）

## 何を確認したか

008 章の `anticommutator_of_psi`（`structured-latex/content/008_TV1_hatZ_hatY_part2.mjs` の
`TV1_hatZ_hatY_032`）では、`M ∣ μ+ν` のとき

    √(γ_2(θ_ν)γ_2(-θ_ν)) = √(γ_2(θ_μ)γ_2(-θ_μ))

を「根号の中身が等しい」ことから使っており、`μ` と `ν` で同じ分枝を取ることが
自明でないという論点があった（Lean 側では `Ising2D/Part008/Definition030_Fermi.lean` の
仮定 `hbr` として明示され、逆分枝では第 1・第 2 式が偽になることが
`acomm_psiDag_psiDag_of_opposite_branch` / `acomm_psiDag_psi_of_opposite_branch` で
証明されている）。

**016 章（半整数運動量版）に同じ論点があるかを Lean で確認した。結論は「無い」である。**

## 根拠（一次情報）

016 章の `def_check_fermi` は係数に平方根ではなく **`r_μ := |γ_2(θ̃_μ)|`（非負実数）** を使う。
Lean では `Ising2D/Part016/Definition001_CheckFermi.lean` に

```lean
noncomputable def checkR (K : IsingConst) (M : ℕ) (μ : ℤ) : ℝ :=
  Real.sqrt (Complex.normSq (gamma2 K (thetaTilde M μ)))

theorem checkR_sq (K : IsingConst) (M : ℕ) (μ : ℤ) :
    ((checkR K M μ : ℝ) : ℂ) ^ 2
      = -(gamma2 K (thetaTilde M μ) * gamma2 K (-thetaTilde M μ))
```

として定義してある。008 章と違い、

* `checkR` は **`ℝ` への一意な写像**であり、選ぶ分枝が無い。
* `checkR_sq`（`(r:ℂ)^2 = -(γ_2(θ̃_μ)γ_2(-θ̃_μ))`）は**無条件**に成り立つ。
  008 章は `t` を「`t^2 = γ_2 γ_2(-)` を満たす任意の複素数」として受け取るので
  `t = ±ir` の自由度が残り、そこから `hbr` が必要になっていた。
* 原文 Step 1 の `r_ν = r_μ`（`ν = M+1-μ`）は、絶対値の計算だけで従う。Lean では

```lean
theorem checkR_conj (K : IsingConst) (hM : M ≠ 0) (μ : ℤ) :
    checkR K M ((M : ℤ) + 1 - μ) = checkR K M μ
```

  として、`γ_2(θ̃_{M+1-μ}) = γ_2(-θ̃_μ)`（`gamma2_thetaTilde_conj`）と
  `γ_2(-θ) = -conj(γ_2(θ))`（008 章の `gamma2_neg_eq_neg_conj`）と
  `normSq(-z) = normSq(z) = normSq(conj z)` だけから証明できている。

その結果、`Ising2D/Part016/Claim003_AnticommutatorCheckPsi.lean` の 3 式

* `Ising2D.acomm_checkPsiDag_checkPsiDag`
* `Ising2D.acomm_checkPsiDag_checkPsi`
* `Ising2D.acomm_checkPsi_checkPsi`

には、**分枝に関する仮定が 1 つも現れない**（残る仮定は `M ≠ 0`、`μ, ν ∈ 𝓜̌`、
015 章の `γ_2(θ̃_μ) ≠ 0` だけ）。

## 結論

**原文 016 章の `anticommutator_of_check_psi` に穴は無い。**
原文が Step 1 の末尾で述べている「ここが 008 章との差である／分枝の議論は生じない」は、
上記のとおり Lean で機械的に裏づけられた。本文の修正は不要である。
