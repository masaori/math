/-
# `<anticommutator_of_Z_and_Y>` — 具体版を必要十分版の特殊化として導出する

対応する人手証明:
`parts/006_ZとYの反交換関係/000_claim_Z_muとZ_nuとY_muとY_nuの反交換関係.typ`
(`<anticommutator_of_Z_and_Y>`)

## このファイルの位置づけ（README のゴール設定 4 節「2 本立て」）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | `Ising2D.anticomm_Z_Z` 他（`Claim000_AnticommutatorZY.lean`） | クロネッカー積 `siteProd` と Pauli 行列 |
| **必要十分版** | `NecSuf.acomm_jwStr` 他（`NecSuf/SiteLocalAnticomm.lean`） | 単位的・乗法的・多重線型な `P : (ι → A) → B` と線型順序つきのサイト添字 |

本ファイルは、**具体版が必要十分版の特殊化にすぎないこと**を導出として書く。
特殊化で埋めるべきなのは

* クロネッカー積 `siteProd M` が必要十分版の仮定 `IsSiteProd` を満たすこと（`siteProd_isSiteProd`）
* 具体版の族 `jwFamily` が必要十分版の族 `NecSuf.jwStr` の `s = σ^x` の場合であること
  （`jwFamily_eq_jwStr`）
* Pauli 行列の関係式 `σ^z σ^x = -σ^x σ^z`, `σ^y σ^x = -σ^x σ^y`, `σ^y σ^z = -σ^z σ^y`,
  `σ^z σ^z = σ^y σ^y = σ^x σ^x = I`

の 3 点だけである。したがって原文の計算に効いているのは
**「サイトごとの積が多重線型かつ乗法的であること」と「1 サイトでだけ符号が食い違うこと」**
だけで、行列の成分計算・2 次元であること・複素数であることは効いていない。
-/
import Ising2D.NecSuf.SiteLocalAnticomm
import Ising2D.Part006.Claim000_AnticommutatorZY

namespace Ising2D

variable {M : ℕ}

/-- クロネッカー積 `siteProd M` は必要十分版の仮定 `IsSiteProd` を満たす。

`map_one` は `siteProd_one`、`map_mul` は `siteProd_mul`、
`map_smul_univ` は多重線型性（`siteProd_smul_family`）である。 -/
theorem siteProd_isSiteProd (M : ℕ) :
    NecSuf.IsSiteProd ℂ (fun x : Fin M → Matrix (Fin 2) (Fin 2) ℂ => siteProd M x) where
  map_one := siteProd_one M
  map_mul := siteProd_mul M
  map_smul_univ := siteProd_smul_family

/-- 具体版の族 `jwFamily` は、必要十分版の族 `NecSuf.jwStr` の `s = σ^x` の場合そのものである。 -/
theorem jwFamily_eq_jwStr (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    jwFamily m A = NecSuf.jwStr pauliX m A := by
  funext i
  by_cases h : (i : ℕ) < (m : ℕ)
  · rw [jwFamily_of_lt h, NecSuf.jwStr_of_lt pauliX A (Fin.lt_def.2 h)]
  · by_cases he : i = m
    · rw [he, jwFamily_self, NecSuf.jwStr_self]
    · have hne : (i : ℕ) ≠ (m : ℕ) := fun hh => he (Fin.val_injective hh)
      have h1 : (m : ℕ) < (i : ℕ) := by omega
      rw [jwFamily_of_gt h1, NecSuf.jwStr_of_gt pauliX A (Fin.lt_def.2 h1)]

/-- **必要十分版から得た `Z_μ Z_ν` 型の反交換**（`jw_anticomm` の必要十分版による証明）。 -/
theorem jw_anticomm_of_necSuf (μ ν : Fin M) (A B : Matrix (Fin 2) (Fin 2) ℂ)
    (hAx : A * pauliX = -(pauliX * A)) (hBx : B * pauliX = -(pauliX * B))
    (hAB : μ = ν → B * A = -(A * B)) :
    acomm (siteProd M (jwFamily μ A)) (siteProd M (jwFamily ν B)) = 0 := by
  rw [jwFamily_eq_jwStr, jwFamily_eq_jwStr]
  exact NecSuf.acomm_jwStr (siteProd_isSiteProd M) pauliX μ ν A B hAx hBx hAB

/-- **必要十分版から得た `jw_sq`**（原文の `μ = ν` の計算）。 -/
theorem jw_sq_of_necSuf (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) (hA : A * A = 1) :
    siteProd M (jwFamily m A) * siteProd M (jwFamily m A) = 1 := by
  rw [jwFamily_eq_jwStr]
  exact NecSuf.jwStr_sq (siteProd_isSiteProd M) pauliX_mul_pauliX m hA

/-- **`[Z_μ, Z_ν]₊ = 2 I δ^M_{(μ,ν)}` を必要十分版の特殊化として導出した形**
（`<anticommutator_of_Z_and_Y>` 第 1 式）。 -/
theorem anticomm_Z_Z_of_necSuf (μ ν : Fin M) :
    acomm (Z μ) (Z ν) = (2 * deltaM μ ν) • (1 : TensorPow M) := by
  by_cases h : μ = ν
  · have h1 : Z μ * Z ν = 1 := by
      rw [h]; exact jw_sq_of_necSuf ν pauliZ pauliZ_mul_pauliZ
    have h2 : Z ν * Z μ = 1 := by
      rw [h]; exact jw_sq_of_necSuf ν pauliZ pauliZ_mul_pauliZ
    rw [acomm, h1, h2, deltaM, if_pos h, mul_one, two_smul]
  · have h0 : acomm (Z μ) (Z ν) = 0 :=
      jw_anticomm_of_necSuf μ ν pauliZ pauliZ pauliZ_mul_pauliX pauliZ_mul_pauliX
        fun he => absurd he h
    rw [h0, deltaM, if_neg h, mul_zero, zero_smul]

/-- **`[Z_μ, Y_ν]₊ = 0` を必要十分版の特殊化として導出した形**
（`<anticommutator_of_Z_and_Y>` 第 2 式）。 -/
theorem anticomm_Z_Y_of_necSuf (μ ν : Fin M) : acomm (Z μ) (Y ν) = 0 :=
  jw_anticomm_of_necSuf μ ν pauliZ pauliY pauliZ_mul_pauliX pauliY_mul_pauliX
    fun _ => pauliY_mul_pauliZ_anticomm

/-- **`[Y_μ, Y_ν]₊ = 2 I δ^M_{(μ,ν)}` を必要十分版の特殊化として導出した形**
（`<anticommutator_of_Z_and_Y>` 第 3 式）。 -/
theorem anticomm_Y_Y_of_necSuf (μ ν : Fin M) :
    acomm (Y μ) (Y ν) = (2 * deltaM μ ν) • (1 : TensorPow M) := by
  by_cases h : μ = ν
  · have h1 : Y μ * Y ν = 1 := by
      rw [h]; exact jw_sq_of_necSuf ν pauliY pauliY_mul_pauliY
    have h2 : Y ν * Y μ = 1 := by
      rw [h]; exact jw_sq_of_necSuf ν pauliY pauliY_mul_pauliY
    rw [acomm, h1, h2, deltaM, if_pos h, mul_one, two_smul]
  · have h0 : acomm (Y μ) (Y ν) = 0 :=
      jw_anticomm_of_necSuf μ ν pauliY pauliY pauliY_mul_pauliX pauliY_mul_pauliX
        fun he => absurd he h
    rw [h0, deltaM, if_neg h, mul_zero, zero_smul]

end Ising2D
