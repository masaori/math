/-
# 成分で定義された転送行列（001 章）と、パウリ表示の `V_1`（004 章）

対応する人手証明:

* `structured-latex/content/001_partition_function_2d_ising.ts`
  * `partition_function_2d_ising_002_definition_partition_function`（ラベル `def_partition_function_2d_ising`）
  * `partition_function_2d_ising_003_definition_transfer_matrix`（ラベル `def_transfer_matrix`）
* `structured-latex/content/004_transfer_matrix.ts` の `def_transfer_matrix_symbols`（`V_1` のパウリ表示）
* `structured-latex/content/010_transfer_matrix_bridge.ts` の `bridge_000_remark_overview`（記号の対応）

## 記号の読み替え（010 章冒頭の表のとおり）

| 001 章 | 004 章以降・本ファイル | 意味 |
| --- | --- | --- |
| `N` | `M` | 鎖の長さ（1 列ぶんのサイト数） |
| `M` | `N_row` | 転送の回数（行数） |
| `J'` | `K_1` | 同一の鎖の隣接サイトを結ぶ結合定数 |
| `J`  | `K_2` | 隣り合う 2 本の鎖の同じサイトを結ぶ結合定数 |

## 添字の同一視

`TensorPow M = Matrix (Conf M) (Conf M) ℂ` の添字型 `Conf M` が
`def_config_basis_iso` の `𝓘 = {1,2}^M` そのものなので、
原文が `(V_a)_{μ,μ'} := (V_a)_{ι(μ),ι(μ')}` と読んでいる同一視は、
本ファイルでは「添字 `I : Conf M` のスピン値を `sgn I m` で読む」ことに対応する
（`Ising2D.sgn`, `Ising2D.configBasisIso` は `Part010/Definition001_ConfigBasisIso.lean`）。

## 周期境界条件

原文の `μ(N+1) := μ(1)`（および `s(M+1,j) := s(1,j)`, `s(i,N+1) := s(i,1)`）は、
`Fin M` 上の巡回後者 `Ising2D.nextSite`（`Part004/Definition010_H1H2V1V2.lean`）で表す。
-/
import Ising2D.Part004.Definition010_H1H2V1V2
import Ising2D.Part010.Claim002_SigmaZDiagonal
import Ising2D.Part010.Claim003_ExpDiagonal

namespace Ising2D

variable {M : ℕ}

/-! ## 成分で定義された転送行列（001 章 `def_transfer_matrix`） -/

/-- 1 行ぶんのエネルギー（原文 `V_1` の指数の肩）
`∑_{m} K_1 μ(m) μ(m+1)`。 -/
noncomputable def rowEnergy (K1 : ℂ) (I : Conf M) : ℂ :=
  ∑ m : Fin M, K1 * sgnC (I m) * sgnC (I (nextSite m))

/-- 隣接する 2 行の間のエネルギー（原文 `V_2` の指数の肩）
`∑_{m} K_2 μ(m) μ'(m)`。 -/
noncomputable def interEnergy (K2 : ℂ) (I J : Conf M) : ℂ :=
  ∑ m : Fin M, K2 * sgnC (I m) * sgnC (J m)

/-- **原文 `def_transfer_matrix` の `(V_1)_{μ,μ'} = δ_{μ=μ'} exp(∑_j J' μ(j)μ(j+1))`**
（`ι` による同一視のもとで読んだもの）。 -/
noncomputable def V1comp (M : ℕ) (K1 : ℂ) : TensorPow M :=
  Matrix.diagonal (fun I : Conf M => Complex.exp (rowEnergy K1 I))

/-- **原文 `def_transfer_matrix` の `(V_2)_{μ,μ'} = exp(∑_j J μ(j)μ'(j))`**。 -/
noncomputable def V2comp (M : ℕ) (K2 : ℂ) : TensorPow M :=
  Matrix.of fun I J : Conf M => Complex.exp (interEnergy K2 I J)

theorem V1comp_apply (K1 : ℂ) (I J : Conf M) :
    V1comp M K1 I J = if I = J then Complex.exp (rowEnergy K1 I) else 0 := by
  rw [V1comp]
  by_cases h : I = J
  · subst h; simp
  · rw [Matrix.diagonal_apply_ne _ h, if_neg h]

@[simp]
theorem V2comp_apply (K2 : ℂ) (I J : Conf M) :
    V2comp M K2 I J = Complex.exp (interEnergy K2 I J) := rfl

/-! ## パウリ表示の `V_1`（004 章 `def_transfer_matrix_symbols`） -/

/-- **原文 `def_transfer_matrix_symbols` の
`V_1 = exp(K_1 (σ^z_1σ^z_2 + ⋯ + σ^z_Mσ^z_1))`。**

（既存の `Ising2D.V1` は `def_V1_pm` の `V_1^{(±)} = exp(√-1 K_1 H_1^{(±)})` であって、
こちらとは別物である。） -/
noncomputable def V1pauli (M : ℕ) (K1 : ℂ) : TensorPow M :=
  matExp (K1 • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))

/-- `∑_m σ^z_m σ^z_{m+1}` は対角行列で、対角成分は `∑_m μ(m)μ(m+1)`。 -/
theorem sum_sigmaZ_sigmaZ_eq_diagonal (M : ℕ) :
    (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))
      = Matrix.diagonal (fun I : Conf M => ∑ m : Fin M, sgnC (I m) * sgnC (I (nextSite m))) := by
  ext I J
  rw [Matrix.sum_apply]
  by_cases h : I = J
  · subst h
    simp only [sigmaZ_mul_sigmaZ_eq_diagonal, Matrix.diagonal_apply_eq]
  · simp only [sigmaZ_mul_sigmaZ_eq_diagonal, Matrix.diagonal_apply_ne _ h,
      Finset.sum_const_zero]

/-- パウリ表示の `V_1` も対角行列であり、その対角成分は `exp(K_1 ∑_m μ(m)μ(m+1))`。 -/
theorem V1pauli_eq_diagonal (K1 : ℂ) :
    V1pauli M K1 = Matrix.diagonal
      (fun I : Conf M => Complex.exp (K1 * ∑ m : Fin M, sgnC (I m) * sgnC (I (nextSite m)))) := by
  rw [V1pauli, sum_sigmaZ_sigmaZ_eq_diagonal, ← Matrix.diagonal_smul, matExp_diagonal]
  simp only [Pi.smul_apply, smul_eq_mul]

end Ising2D
