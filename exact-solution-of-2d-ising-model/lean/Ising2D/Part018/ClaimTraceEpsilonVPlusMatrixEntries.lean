/-
# `exp(K_1D_0)`・`G`・`ε`・`V_2` の成分を配置の基底で読み取る（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_006_theorem_trace_of_epsilon_V_plus`、ラベル **`trace_of_epsilon_V_plus`** の Step 3）

| 人手 | Lean |
| --- | --- |
| Step 3 (b) の `(-s)(m) := -s(m)` | `negSpinConf`（値の側は `negSpinVal`） |
| Step 3 (a) の `D0_G_diagonal_action` から `exp(K_1D_0)` の対角性へ進む途中の段（Lean で補った中間）: `D_0` は対角行列で `(D_0)_{ι(s),ι(s)} = E(s)` | `openChainD0_eq_diagonal` |
| 同 `exp_of_diagonal_matrix` より `exp(K_1D_0)` は対角行列で `(exp(K_1D_0))_{ι(s),ι(s)} = exp(K_1E(s))` | `matExp_smul_openChainD0`（成分は `matExp_smul_openChainD0_apply`、左から掛けた積の行 `ι(s)` は `matExp_smul_openChainD0_mul_apply`） |
| 同 `G` は対角行列で `G_{ι(s),ι(s)} = s(M_col)s(1)` | `boundaryG_eq_diagonal`（成分は `boundaryG_apply`、左から掛けた積の行 `ι(s)` は `boundaryG_mul_apply`） |
| Step 3 (b) `εf_{ι(s)} = f_{ι(-s)}` | `epsilon_mulVec_basisVec_configBasisIso` |
| Step 4 が (b) として使う「`ε` は行番号 `ι(s)` を `ι(-s)` に移す置換行列」: `ε_{ι(s),J} = δ_{J,ι(-s)}`、`(εA)_{ι(s),J} = A_{ι(-s),J}` | `epsilon_apply_configBasisIso`・`epsilon_mul_apply_configBasisIso` |
| Step 3 (c) `(V_2)_{ι(s),ι(s')} = exp(K_2∑_m s(m)s'(m))` | `V2_apply_configBasisIso`（`PartitionFunction/TransferMatrixRepresentation/DefinitionTransferMatrix.lean`） |
| 同 `(V_2)_{ι(s),ι(s)} = exp(M_colK_2)` | `V2_apply_configBasisIso_self` |
| 同 `(V_2)_{ι(-s),ι(s)} = exp(-M_colK_2)` | `V2_apply_configBasisIso_neg_self` |

人手 (a) は `D0_G_diagonal_action` から直接対角性を述べる。Lean ではその途中を、行列の第 `ι(s)` 列が
`A f_{ι(s)}` であること（`(A f_I)_J = A_{J,I}`）から成分を読む形 `eq_diagonal_of_mulVec_basisVec` で書く。
`D_0f_{ι(s)} = E(s)f_{ι(s)}` は `openChainD0_mulVec_basisVec_eq_energy`、`Gf_{ι(s)} = s(M_col)s(1)f_{ι(s)}` は
`boundaryG_mulVec_basisVec`（`D0_G_diagonal_action`）、`exp_of_diagonal_matrix` は `matExp_diagonal` である。
人手 (b) の理由のうち「`ε` はすべての成分を入れ替える」は `epsilon_mulVec_basisVec`（`ε f_I = f_{π(I)}`、
`π` は `flipConf`）であり、`ι` のもとで `π(ι(s)) = ι(-s)` となること（人手の `+1 ↦ 1`, `-1 ↦ 2` の入れ替え）を
`configBasisIso_negSpinConf` で示す。
(b) の `εf_{ι(s)} = f_{ι(-s)}` が述べるのは `ε` の列 `ι(s)` の成分 `ε_{J,ι(s)} = δ_{J,ι(-s)}` だが、人手 Step 4 が
使うのは行 `ι(s)` の成分 `ε_{ι(s),J} = δ_{J,ι(-s)}` である。人手は列の形から行の形へ移るのに `-(-s) = s`（`π` が自分自身の逆）を
断らずに使っている。Lean では行の形を `epsilon_apply`（`ε_{l,k} = δ_{k,π(l)}`）と `configBasisIso_negSpinConf` から導く。人手 (c) の二つの特別な場合は `∑_m s(m)s(m) = M_col`
（`sum_spin_mul_self`）と `∑_m (-s(m))s(m) = -M_col` による。

一般化できるのは、行列の列の読み取り（任意の半環・任意の有限添字の行列で成り立つ自明な事実）と、
`{±1}` の符号反転の組合せだけである。必要十分版にしても何が本質的かについて情報を与えないので、置かない。
-/
import Ising2D.Part018.ClaimOpenChainSpinSums
import Ising2D.Part018.ClaimEpsilonD0GCommuteAndDiagonalAction
import Ising2D.Part004.ClaimExpOfDiagonalMatrix
import Ising2D.Part011.ClaimEpsilonIsRealSymmetric
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionTransferMatrix

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## スピン配置の符号反転 `-s` -/

/-- 人手の `-s(m)`（`{-1,1}` は符号反転で閉じている）。 -/
def negSpinVal (a : SpinVal) : SpinVal :=
  ⟨-(a : ℝ), by
    rcases a.2 with h | h
    · right; rw [h]
    · left; rw [h, neg_neg]⟩

@[simp] theorem coe_negSpinVal (a : SpinVal) : ((negSpinVal a : SpinVal) : ℝ) = -(a : ℝ) := rfl

/-- **人手 Step 3 (b) の `(-s)(m) := -s(m)`。** -/
def negSpinConf (s : SpinConf M) : SpinConf M := fun m => negSpinVal (s m)

@[simp] theorem coe_negSpinConf_apply (s : SpinConf M) (m : Fin M) :
    ((negSpinConf s m : SpinVal) : ℝ) = -(s m : ℝ) := rfl

/-! ## 対角性の読み取り -/

/-- 人手 (a) の対角性を導くために Lean で補った段: `f_{ι(s)}` に `d(s)` 倍で作用する行列は、`(ι(s), ι(s))` 成分が `d(s)` の対角行列である。

第 `I` 列は `A f_I` なので、`A f_{ι(s)} = d(s) f_{ι(s)}` の第 `J` 成分が `A_{J, ι(s)}` を与える。 -/
theorem eq_diagonal_of_mulVec_basisVec {A : TensorPow M} {d : SpinConf M → ℂ}
    (h : ∀ s : SpinConf M, A *ᵥ basisVec (configBasisIso M s) = d s • basisVec (configBasisIso M s)) :
    A = Matrix.diagonal (fun I => d ((configBasisIso M).symm I)) := by
  ext J I
  -- 第 `I` 列の第 `J` 成分: `(A f_I)_J = A_{J,I}`
  have hcol : (A *ᵥ basisVec I) J = A J I := by
    rw [basisVec, Matrix.mulVec, dotProduct, Finset.sum_eq_single I (fun j _ hj => by
      rw [Pi.single_eq_of_ne hj, mul_zero]) (fun hI => absurd (Finset.mem_univ I) hI),
      Pi.single_eq_same, mul_one]
  have hJ := congrFun (h ((configBasisIso M).symm I)) J
  rw [Equiv.apply_symm_apply, hcol, Pi.smul_apply, smul_eq_mul, basisVec] at hJ
  rw [hJ, Matrix.diagonal_apply]
  by_cases hJI : J = I
  · subst hJI
    rw [Pi.single_eq_same, mul_one, if_pos rfl]
  · rw [Pi.single_eq_of_ne hJI, mul_zero, if_neg hJI]

/-! ## Step 3 (a) -/

/-- **人手 Step 3 (a) の前半**: `D_0` は対角行列で `(D_0)_{ι(s),ι(s)} = E(s)`（`D0_G_diagonal_action`）。 -/
theorem openChainD0_eq_diagonal :
    openChainD0 M
      = Matrix.diagonal (fun I => ((openChainEnergy ((configBasisIso M).symm I) : ℝ) : ℂ)) :=
  eq_diagonal_of_mulVec_basisVec openChainD0_mulVec_basisVec_eq_energy

/-- **人手 Step 3 (a)**: `exp(K_1D_0)` は対角行列で `(exp(K_1D_0))_{ι(s),ι(s)} = exp(K_1E(s))`
（`openChainD0_eq_diagonal` と `exp_of_diagonal_matrix`）。 -/
theorem matExp_smul_openChainD0 (K1 : ℝ) :
    matExp ((K1 : ℂ) • openChainD0 M)
      = Matrix.diagonal (fun I =>
          ((Real.exp (K1 * openChainEnergy ((configBasisIso M).symm I)) : ℝ) : ℂ)) :=
  calc matExp ((K1 : ℂ) • openChainD0 M)
      = matExp ((K1 : ℂ) • Matrix.diagonal (fun I =>
          ((openChainEnergy ((configBasisIso M).symm I) : ℝ) : ℂ))) := by
        rw [openChainD0_eq_diagonal]
    _ = matExp (Matrix.diagonal (fun I =>
          (K1 : ℂ) * ((openChainEnergy ((configBasisIso M).symm I) : ℝ) : ℂ))) := by
        rw [← Matrix.diagonal_smul]
        rfl
    _ = Matrix.diagonal (fun I =>
          Complex.exp ((K1 : ℂ) * ((openChainEnergy ((configBasisIso M).symm I) : ℝ) : ℂ))) := by
        rw [matExp_diagonal]
    _ = Matrix.diagonal (fun I =>
          ((Real.exp (K1 * openChainEnergy ((configBasisIso M).symm I)) : ℝ) : ℂ)) := by
        simp only [← Complex.ofReal_mul, ← Complex.ofReal_exp]

open Classical in
/-- 人手 Step 3 (a) の成分表示: `(exp(K_1D_0))_{ι(s),ι(s')} = δ_{s=s'} exp(K_1E(s))`。 -/
theorem matExp_smul_openChainD0_apply (K1 : ℝ) (s s' : SpinConf M) :
    matExp ((K1 : ℂ) • openChainD0 M) (configBasisIso M s) (configBasisIso M s')
      = if s = s' then ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) else 0 := by
  rw [matExp_smul_openChainD0, Matrix.diagonal_apply, Equiv.symm_apply_apply]
  by_cases h : s = s'
  · rw [if_pos (by rw [h]), if_pos h]
  · rw [if_neg (fun hc => h ((configBasisIso M).injective hc)), if_neg h]

/-- **人手 Step 3 (a) の後半**: `G` は対角行列で `G_{ι(s),ι(s)} = s(M_col)s(1)`（`D0_G_diagonal_action`）。 -/
theorem boundaryG_eq_diagonal (hM : M ≠ 0) :
    boundaryG M hM
      = Matrix.diagonal (fun I =>
          (((((configBasisIso M).symm I (lastSite M hM) : SpinVal) : ℝ)
            * (((configBasisIso M).symm I (firstSite M hM) : SpinVal) : ℝ) : ℝ) : ℂ)) :=
  eq_diagonal_of_mulVec_basisVec (boundaryG_mulVec_basisVec hM)

open Classical in
/-- 人手 Step 3 (a) の `G` の成分表示: `G_{ι(s),ι(s')} = δ_{s=s'} s(M_col)s(1)`。 -/
theorem boundaryG_apply (hM : M ≠ 0) (s s' : SpinConf M) :
    boundaryG M hM (configBasisIso M s) (configBasisIso M s')
      = if s = s' then (((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ) else 0 := by
  rw [boundaryG_eq_diagonal hM, Matrix.diagonal_apply, Equiv.symm_apply_apply]
  by_cases h : s = s'
  · rw [if_pos (by rw [h]), if_pos h]
  · rw [if_neg (fun hc => h ((configBasisIso M).injective hc)), if_neg h]

/-- 人手 Step 4 が (a) の `exp(K_1D_0)` の対角性として使う形:
`(exp(K_1D_0)X)_{ι(s),J} = exp(K_1E(s))X_{ι(s),J}`。 -/
theorem matExp_smul_openChainD0_mul_apply (K1 : ℝ) (X : TensorPow M) (s : SpinConf M) (J : Conf M) :
    (matExp ((K1 : ℂ) • openChainD0 M) * X) (configBasisIso M s) J
      = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) * X (configBasisIso M s) J := by
  rw [matExp_smul_openChainD0, Matrix.diagonal_mul, Equiv.symm_apply_apply]

/-- 人手 Step 4 が (a) の `G` の対角性として使う形: `(GX)_{ι(s),J} = s(M_col)s(1)X_{ι(s),J}`。 -/
theorem boundaryG_mul_apply (hM : M ≠ 0) (X : TensorPow M) (s : SpinConf M) (J : Conf M) :
    (boundaryG M hM * X) (configBasisIso M s) J
      = (((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ) * X (configBasisIso M s) J := by
  rw [boundaryG_eq_diagonal hM, Matrix.diagonal_mul, Equiv.symm_apply_apply]

/-! ## Step 3 (b) -/

/-- 人手 (b) の理由の、`ι`（`+1 ↦ 1`, `-1 ↦ 2`）のもとで全成分の入れ替えが `s ↦ -s` になる段:
`π(ι(s)) = ι(-s)`。 -/
theorem configBasisIso_negSpinConf (s : SpinConf M) :
    configBasisIso M (negSpinConf s) = flipConf (configBasisIso M s) := by
  funext m
  rw [configBasisIso_apply, flipConf_apply, configBasisIso_apply]
  rcases (s m).2 with h | h
  · rw [idxOfSpin, idxOfSpin, if_neg (by rw [coe_negSpinConf_apply, h]; norm_num), if_pos h,
      flipIdx_zero]
  · rw [idxOfSpin, idxOfSpin, if_pos (by rw [coe_negSpinConf_apply, h, neg_neg]),
      if_neg (by rw [h]; norm_num), flipIdx_one]

/-- **人手 Step 3 (b)**: `εf_{ι(s)} = f_{ι(-s)}`。 -/
theorem epsilon_mulVec_basisVec_configBasisIso (s : SpinConf M) :
    epsilon M *ᵥ basisVec (configBasisIso M s) = basisVec (configBasisIso M (negSpinConf s)) :=
  calc epsilon M *ᵥ basisVec (configBasisIso M s)
      = basisVec (flipConf (configBasisIso M s)) := epsilon_mulVec_basisVec _
    _ = basisVec (configBasisIso M (negSpinConf s)) := by rw [configBasisIso_negSpinConf]

/-- 人手 Step 4 が (b) として使う「`ε` は行番号 `ι(s)` を `ι(-s)` に移す置換行列」の成分:
`ε_{ι(s),J} = δ_{J,ι(-s)}`（`epsilon_apply` の `ε_{l,k} = δ_{k,π(l)}` と `π(ι(s)) = ι(-s)`）。 -/
theorem epsilon_apply_configBasisIso (s : SpinConf M) (J : Conf M) :
    epsilon M (configBasisIso M s) J = if J = configBasisIso M (negSpinConf s) then 1 else 0 := by
  rw [epsilon_apply, configBasisIso_negSpinConf]

/-- 人手 Step 4 の `(εA)_{ι(s),J} = A_{ι(-s),J}`（行 `ι(s)` の和で残るのは `ι(-s)` の項だけ）。 -/
theorem epsilon_mul_apply_configBasisIso (A : TensorPow M) (s : SpinConf M) (J : Conf M) :
    (epsilon M * A) (configBasisIso M s) J = A (configBasisIso M (negSpinConf s)) J := by
  rw [Matrix.mul_apply, Finset.sum_eq_single (configBasisIso M (negSpinConf s))]
  · rw [epsilon_apply_configBasisIso, if_pos rfl, one_mul]
  · intro K _ hK
    rw [epsilon_apply_configBasisIso, if_neg hK, zero_mul]
  · intro h
    exact absurd (Finset.mem_univ _) h

/-! ## Step 3 (c) -/

/-- 人手 (c) の `∑_{m=1}^{M_col} s(m)s(m) = M_col`。 -/
theorem sum_spin_mul_self (s : SpinConf M) : ∑ m : Fin M, (s m : ℝ) * (s m : ℝ) = M := by
  have h : ∀ m : Fin M, (s m : ℝ) * (s m : ℝ) = 1 := fun m => by
    rcases (s m).2 with h | h <;> rw [h] <;> norm_num
  rw [Finset.sum_congr rfl fun m _ => h m, Finset.sum_const, Finset.card_univ, Fintype.card_fin,
    nsmul_eq_mul, mul_one]

/-- **人手 Step 3 (c) の一つ目の特別な場合**: `(V_2)_{ι(s),ι(s)} = exp(M_colK_2)`。 -/
theorem V2_apply_configBasisIso_self (K2 : ℝ) (s : SpinConf M) :
    V2 M K2 (configBasisIso M s) (configBasisIso M s) = ((Real.exp ((M : ℝ) * K2) : ℝ) : ℂ) :=
  calc V2 M K2 (configBasisIso M s) (configBasisIso M s)
      = ((Real.exp (K2 * ∑ m : Fin M, (s m : ℝ) * (s m : ℝ)) : ℝ) : ℂ) :=
        V2_apply_configBasisIso K2 s s
    _ = ((Real.exp (K2 * M) : ℝ) : ℂ) := by rw [sum_spin_mul_self]
    _ = ((Real.exp ((M : ℝ) * K2) : ℝ) : ℂ) := by rw [mul_comm]

/-- **人手 Step 3 (c) の二つ目の特別な場合**: `(V_2)_{ι(-s),ι(s)} = exp(-M_colK_2)`。 -/
theorem V2_apply_configBasisIso_neg_self (K2 : ℝ) (s : SpinConf M) :
    V2 M K2 (configBasisIso M (negSpinConf s)) (configBasisIso M s)
      = ((Real.exp (-((M : ℝ) * K2)) : ℝ) : ℂ) :=
  calc V2 M K2 (configBasisIso M (negSpinConf s)) (configBasisIso M s)
      = ((Real.exp (K2 * ∑ m : Fin M, (negSpinConf s m : ℝ) * (s m : ℝ)) : ℝ) : ℂ) :=
        V2_apply_configBasisIso K2 (negSpinConf s) s
    _ = ((Real.exp (K2 * ∑ m : Fin M, -((s m : ℝ) * (s m : ℝ))) : ℝ) : ℂ) := by
        simp only [coe_negSpinConf_apply, neg_mul]
    _ = ((Real.exp (K2 * -(M : ℝ)) : ℝ) : ℂ) := by rw [Finset.sum_neg_distrib, sum_spin_mul_self]
    _ = ((Real.exp (-((M : ℝ) * K2)) : ℝ) : ℂ) := by rw [mul_neg, mul_comm]

end Ising2D
