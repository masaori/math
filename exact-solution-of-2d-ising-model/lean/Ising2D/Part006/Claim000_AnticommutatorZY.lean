/-
# `Z` と `Y` の反交換関係

対応する人手証明:
`parts/006_ZとYの反交換関係/000_claim_Z_muとZ_nuとY_muとY_nuの反交換関係.typ`
(`<anticommutator_of_Z_and_Y>`)

原文の主張:

  `[Z_μ, Z_ν]₊ = 2 I δ^M_{(μ,ν)}`,  `[Z_μ, Y_ν]₊ = 0`,  `[Y_μ, Y_ν]₊ = 2 I δ^M_{(μ,ν)}`

（`δ^M` は `parts/004_転送行列/007_definition_クロネッカーのデルタ_delta_M.typ`。
添字を `{1, …, M}` の代表元にとれば `μ ≡ ν (mod M) ⟺ μ = ν` なので、
Lean では `Fin M` 上の `deltaM μ ν = if μ = ν then 1 else 0` として形式化する。）

## 原文の証明の状態

原文は `μ = ν` の場合と `μ < ν` の場合の `[Z_μ, Z_ν]₊` だけを計算し、
`[Z_μ, Y_ν]₊` と `[Y_μ, Y_ν]₊` は **TODO** のまま残している。
本ファイルでは 3 つすべてを証明する。

## 証明の構造（原文の計算をどう一般化したか）

原文は `Z_μ Z_ν` と `Z_ν Z_μ` をテンソル因子ごとに書き下し、
「サイト `μ` の因子だけが `σ^z σ^x` と `σ^x σ^z = -σ^z σ^x` で食い違い、
他のサイトの因子は一致する」ことから和が `0` になる、と論じている。

これを次の 2 段に分けて形式化した。

1. `siteProd_anticomm_of_single_site`:
   テンソル積の因子のうち **ただ 1 つのサイト `j` でだけ反可換**で、
   他のサイトでは可換ならば、2 つのテンソル積は反交換する。
   `siteProd` が多重線型であること（`MultilinearMap.map_smul_univ`）から、
   符号 `-1` がテンソル積の外へ出る、というのが証明の核。
2. `jw_anticomm`: `Z_μ, Y_ν` の形（Jordan–Wigner 文字列）に 1 を適用する。
   `μ < ν`, `μ = ν`, `μ > ν` の 3 通りで「食い違うサイト `j`」がそれぞれ
   `μ`, `μ`, `ν` になる。
-/
import Ising2D.Part000.Claim046_CommutatorViaAnticommutators
import Ising2D.Part004.Definition000_TransferMatrixSymbols

namespace Ising2D

variable {M : ℕ}

/-! ## テンソル積の反交換に関する一般補題 -/

/-- `siteProd` の多重線型性: 各サイトのスカラー倍はテンソル積の外へ出る。 -/
theorem siteProd_smul_family (c : Fin M → ℂ) (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (fun i => c i • x i) = (∏ i, c i) • siteProd M x :=
  MultilinearMap.map_smul_univ (siteProd M) c x

/-- **原文の計算の一般化**。

`x, y : Fin M → Mat(2, ℂ)` の作るテンソル積 `siteProd x`, `siteProd y` について、
あるサイト `j` でだけ `y j` と `x j` が反可換で、残りのサイトでは可換ならば、
`siteProd x` と `siteProd y` は反交換する。

原文が「サイト `μ` の因子だけが `σ^z σ^x` と `σ^x σ^z` で符号だけ違い、
他は完全に一致する」と書き下している部分にあたる。 -/
theorem siteProd_anticomm_of_single_site
    (x y : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (j : Fin M)
    (hj : y j * x j = -(x j * y j))
    (hcomm : ∀ i, i ≠ j → y i * x i = x i * y i) :
    siteProd M x * siteProd M y + siteProd M y * siteProd M x = 0 := by
  classical
  have hswap : siteProd M y * siteProd M x = -(siteProd M x * siteProd M y) := by
    rw [← siteProd_mul, ← siteProd_mul]
    have hfam : (y * x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) =
        fun i => (Function.update (1 : Fin M → ℂ) j (-1) i) •
          ((x * y : Fin M → Matrix (Fin 2) (Fin 2) ℂ) i) := by
      funext i
      by_cases hij : i = j
      · have hupd : Function.update (1 : Fin M → ℂ) j (-1) i = -1 := by
          rw [Function.update_apply, if_pos hij]
        rw [Pi.mul_apply, Pi.mul_apply, hupd, hij, hj, neg_smul, one_smul]
      · have hupd : Function.update (1 : Fin M → ℂ) j (-1) i = 1 := by
          rw [Function.update_apply, if_neg hij]; rfl
        rw [Pi.mul_apply, Pi.mul_apply, hupd, one_smul]
        exact hcomm i hij
    rw [hfam, siteProd_smul_family]
    have hprod : (∏ i, Function.update (1 : Fin M → ℂ) j (-1) i) = -1 := by
      rw [Finset.prod_update_of_mem (Finset.mem_univ j)]
      simp
    rw [hprod, neg_smul, one_smul]
  rw [hswap, add_neg_cancel]

/-! ## Jordan–Wigner 文字列の反交換関係 -/

/-- 各サイトで自乗が `I` になる行列を載せた Jordan–Wigner 文字列は、自乗すると `I`。

`Z_μ Z_μ = I`, `Y_μ Y_μ = I`（原文の `μ = ν` の場合）にあたる。
文字列部分 `σ^x ⋯ σ^x` は `σ^x σ^x = I` で消える。 -/
theorem jw_sq (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) (hA : A * A = 1) :
    siteProd M (jwFamily m A) * siteProd M (jwFamily m A) = 1 := by
  rw [← siteProd_mul]
  have h : (jwFamily m A * jwFamily m A : Fin M → Matrix (Fin 2) (Fin 2) ℂ) = 1 := by
    funext i
    rw [Pi.mul_apply, Pi.one_apply]
    rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
    · rw [jwFamily_of_lt h, pauliX_mul_pauliX]
    · rw [Fin.val_injective h, jwFamily_self, hA]
    · rw [jwFamily_of_gt h, mul_one]
  rw [h, siteProd_one]

/-- **Jordan–Wigner 文字列どうしの反交換**（原文の計算の一般形）。

サイト `μ` に `A`、サイト `ν` に `B` を載せた 2 つの Jordan–Wigner 文字列は、
`A`, `B` がともに `σ^x` と反可換であり、かつ（`μ = ν` の場合に限り）`A` と `B` が
互いに反可換ならば、反交換する。

食い違うサイトは `μ < ν` なら `μ`（`A` と `σ^x`）、`μ > ν` なら `ν`（`σ^x` と `B`）、
`μ = ν` なら `μ`（`A` と `B`）の 1 つだけである。 -/
theorem jw_anticomm (μ ν : Fin M) (A B : Matrix (Fin 2) (Fin 2) ℂ)
    (hAx : A * pauliX = -(pauliX * A)) (hBx : B * pauliX = -(pauliX * B))
    (hAB : μ = ν → B * A = -(A * B)) :
    siteProd M (jwFamily μ A) * siteProd M (jwFamily ν B) +
      siteProd M (jwFamily ν B) * siteProd M (jwFamily μ A) = 0 := by
  rcases lt_trichotomy (μ : ℕ) (ν : ℕ) with h | h | h
  · -- `μ < ν`: 食い違うのはサイト `μ`（`σ^x` と `A`）
    refine siteProd_anticomm_of_single_site _ _ μ ?_ ?_
    · rw [jwFamily_of_lt h, jwFamily_self, hAx, neg_neg]
    · intro i hi
      rcases lt_trichotomy (i : ℕ) (μ : ℕ) with h1 | h1 | h1
      · rw [jwFamily_of_lt h1, jwFamily_of_lt (by omega : (i : ℕ) < (ν : ℕ))]
      · exact absurd (Fin.val_injective h1) hi
      · rw [jwFamily_of_gt h1, one_mul, mul_one]
  · -- `μ = ν`: 食い違うのはサイト `μ`（`A` と `B`）
    have he : μ = ν := Fin.val_injective h
    refine siteProd_anticomm_of_single_site _ _ μ ?_ ?_
    · rw [← he, jwFamily_self, jwFamily_self]
      exact hAB he
    · intro i hi
      rw [← he]
      rcases lt_trichotomy (i : ℕ) (μ : ℕ) with h1 | h1 | h1
      · rw [jwFamily_of_lt h1, jwFamily_of_lt h1]
      · exact absurd (Fin.val_injective h1) hi
      · rw [jwFamily_of_gt h1, one_mul, mul_one]
  · -- `μ > ν`: 食い違うのはサイト `ν`（`B` と `σ^x`）
    refine siteProd_anticomm_of_single_site _ _ ν ?_ ?_
    · rw [jwFamily_of_lt h, jwFamily_self]
      exact hBx
    · intro i hi
      rcases lt_trichotomy (i : ℕ) (ν : ℕ) with h1 | h1 | h1
      · rw [jwFamily_of_lt h1, jwFamily_of_lt (by omega : (i : ℕ) < (μ : ℕ))]
      · exact absurd (Fin.val_injective h1) hi
      · rw [jwFamily_of_gt h1, one_mul, mul_one]

/-! ## 原文の 3 つの反交換関係 -/

/-- 原文 `parts/004_転送行列/007_definition_クロネッカーのデルタ_delta_M.typ` の `δ^M_{(μ,ν)}`。

原文は `μ ≡ ν (mod M)` で定義しているが、添字を `{1, …, M}`（Lean では `Fin M`）の
代表元にとれば `μ ≡ ν (mod M) ⟺ μ = ν` なので、こう定義してよい。 -/
def deltaM (μ ν : Fin M) : ℂ := if μ = ν then 1 else 0

/-- **`[Z_μ, Z_ν]₊ = 2 I δ^M_{(μ,ν)}`**（`<anticommutator_of_Z_and_Y>` 第 1 式）。 -/
theorem anticomm_Z_Z (μ ν : Fin M) :
    acomm (Z μ) (Z ν) = (2 * deltaM μ ν) • (1 : TensorPow M) := by
  rw [acomm]
  by_cases h : μ = ν
  · have h1 : Z μ * Z ν = 1 := by rw [h]; exact jw_sq ν pauliZ pauliZ_mul_pauliZ
    have h2 : Z ν * Z μ = 1 := by rw [h]; exact jw_sq ν pauliZ pauliZ_mul_pauliZ
    rw [h1, h2, deltaM, if_pos h, mul_one, two_smul]
  · have h0 : Z μ * Z ν + Z ν * Z μ = 0 :=
      jw_anticomm μ ν pauliZ pauliZ pauliZ_mul_pauliX pauliZ_mul_pauliX fun he => absurd he h
    rw [h0, deltaM, if_neg h, mul_zero, zero_smul]

/-- **`[Z_μ, Y_ν]₊ = 0`**（`<anticommutator_of_Z_and_Y>` 第 2 式、原文では TODO）。

`μ = ν` の場合も含めてすべての `μ, ν` で成立する
（`σ^y σ^z = -σ^z σ^y` があるので対角成分も消える）。 -/
theorem anticomm_Z_Y (μ ν : Fin M) : acomm (Z μ) (Y ν) = 0 := by
  rw [acomm]
  exact jw_anticomm μ ν pauliZ pauliY pauliZ_mul_pauliX pauliY_mul_pauliX
    fun _ => pauliY_mul_pauliZ_anticomm

/-- **`[Y_μ, Y_ν]₊ = 2 I δ^M_{(μ,ν)}`**（`<anticommutator_of_Z_and_Y>` 第 3 式、原文では TODO）。 -/
theorem anticomm_Y_Y (μ ν : Fin M) :
    acomm (Y μ) (Y ν) = (2 * deltaM μ ν) • (1 : TensorPow M) := by
  rw [acomm]
  by_cases h : μ = ν
  · have h1 : Y μ * Y ν = 1 := by rw [h]; exact jw_sq ν pauliY pauliY_mul_pauliY
    have h2 : Y ν * Y μ = 1 := by rw [h]; exact jw_sq ν pauliY pauliY_mul_pauliY
    rw [h1, h2, deltaM, if_pos h, mul_one, two_smul]
  · have h0 : Y μ * Y ν + Y ν * Y μ = 0 :=
      jw_anticomm μ ν pauliY pauliY pauliY_mul_pauliX pauliY_mul_pauliX fun he => absurd he h
    rw [h0, deltaM, if_neg h, mul_zero, zero_smul]

/-- `[Y_μ, Z_ν]₊ = 0`（`anticomm_Z_Y` の対称版）。 -/
theorem anticomm_Y_Z (μ ν : Fin M) : acomm (Y μ) (Z ν) = 0 := by
  rw [acomm_comm]
  exact anticomm_Z_Y ν μ

/-- `Z_μ Z_μ = I`（原文の `μ = ν` の計算そのもの）。 -/
@[simp]
theorem Z_mul_self (μ : Fin M) : Z μ * Z μ = 1 := jw_sq μ pauliZ pauliZ_mul_pauliZ

/-- `Y_μ Y_μ = I`。 -/
@[simp]
theorem Y_mul_self (μ : Fin M) : Y μ * Y μ = 1 := jw_sq μ pauliY pauliY_mul_pauliY

end Ising2D
