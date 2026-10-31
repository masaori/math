/-
# `tr(εV^{(+)})` を二つのスピン和で書き、閉じた式と正値性を得る（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_006_theorem_trace_of_epsilon_V_plus`、ラベル **`trace_of_epsilon_V_plus`** の Step 4・Step 5 と主張）

| 人手 | Lean |
| --- | --- |
| Step 4 の `tr(X) = ∑_{s∈𝔐} X_{ι(s),ι(s)}`（`def_trace` を `ι` の番号付けで読む） | `trace_eq_sum_configBasisIso` |
| Step 4 の最初の式 `tr(εV^{(+)}) = cosh(K_1)tr(exp(K_1D_0)εV_2) + sinh(K_1)tr(exp(K_1D_0)GV_2)`（Step 2 を Step 1 に代入し `trace_basic_properties` (1)） | `trace_epsilon_VPlusOfTransfer_split` |
| 同 第 1 項の対角成分 `(exp(K_1D_0)εV_2)_{ι(s),ι(s)} = exp(K_1E(s))exp(-M_colK_2)` | `matExp_openChainD0_mul_epsilon_mul_V2_apply_self` |
| 同 第 2 項の対角成分 `(exp(K_1D_0)GV_2)_{ι(s),ι(s)} = exp(K_1E(s))s(M_col)s(1)exp(M_colK_2)` | `matExp_openChainD0_mul_boundaryG_mul_V2_apply_self` |
| 同 最後の式鎖の 1 行目（`def_trace` と直前の 2 式） | `trace_epsilon_VPlusOfTransfer_eq_spin_sums` |
| 同 2 行目から 4 行目（二つの 1 次元開鎖のスピン和公式、`2·2^{M_col-1} = 2^{M_col}`） | `trace_epsilon_VPlusOfTransfer_closed_form` |
| Step 5（正値性） | `trace_epsilon_VPlusOfTransfer_pos` |
| 主張 `tr(εV^{(+)}) = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col} ∈ ℝ_{>0}` | `trace_of_epsilon_V_plus` |
| Step 4 の最初の式の途中（Lean で補った中間）: 行列の積の分配則 `exp(K_1D_0)(aε + bG)V_2 = a·exp(K_1D_0)εV_2 + b·exp(K_1D_0)GV_2` | `trace_epsilon_VPlusOfTransfer_split` の 3 行目 |
| 二つの対角成分の最初の行（Lean で補った中間）: 積の結合則 `(exp(K_1D_0)X)V_2 = exp(K_1D_0)(XV_2)` | 二つの対角成分の補題の 1 行目 |
| 最後の式鎖の 1 行目の途中（Lean で補った中間）: 定数を和の外へ出し実数の積として並べる | `trace_epsilon_VPlusOfTransfer_eq_spin_sums` の最後の行 |

`V^{(+)}` は人手 `def_V_plus` の `(V_1^{(+)})^{1/2}V_2(V_1^{(+)})^{1/2}`、Lean の `VPlusOfTransfer M K_1 K_2` である。
最終定理の入力が持つ `vPlusDataOf` の `V^{(+)}` は、`V_2` を `V2_exponential_representation` で書き換えた形
`VPlus M (sinh 2K_2) K_1 K_2^*` なので、`VPlusOfTransfer_eq_VPlus` で人手の形へ戻して
`trace_epsilon_vPlusDataOf_pos` を得る。これで最終定理 `onsager_exact_solution_unconditional` の入力から `htr` を外した。

人手 Step 5 は、閉じた式ではなく Step 4 の最後の式鎖の 1 行目（二つのスピン和で書いた形）から正値性を出す。
Lean も同じく `trace_epsilon_VPlusOfTransfer_eq_spin_sums` と `open_chain_spin_sums_positive`
（`open_chain_partition_sum_pos`・`open_chain_endpoint_product_sum_pos`）、`cosh K_1 > 0`、`sinh K_1 > 0`、
`exp(±M_colK_2) > 0` から出す。

人手 Step 4 の式鎖の 3 行目は根拠に `2·2^{M_col-1} = 2^{M_col}` だけを挙げるが、同じ行で
`cosh(K_1)(cosh K_1)^{M_col-1} = (cosh K_1)^{M_col}`（`sinh` も同じ）も使っている。4 行目は根拠を書いていないが、
`exp(-M_colK_2) = (exp(-K_2))^{M_col}`（指数法則）と積の冪の分配 `(abc)^n = a^nb^nc^n` を使っている。
Lean ではこの二つを別々の行にした。

必要十分版は置かない。一般化できるのは、行列の積の分配と対角成分の読み取り（可換環上の行列で成り立つ）と、
順序体での正の数の積と和の正値性だけで、必要十分版にしても何が本質的かについて情報を与えない
（`ClaimTraceEpsilonVPlusMatrixEntries.lean` と同じ扱い。二つのスピン和の一般形は `NecSuf/OpenChainSpinSum.lean` が既に持つ）。
-/
import Ising2D.Part018.ClaimTraceEpsilonVPlusMatrixEntries
import Ising2D.Part018.ClaimTraceEpsilonVPlusReduction
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusDataFromEigenvaluesOfVPlus

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## トレースを配置の番号で書く -/

/-- 人手 Step 4 の `tr(X) = ∑_{s∈𝔐} X_{ι(s),ι(s)}`（`def_trace` を `ι` の番号付けで足し直す）。 -/
theorem trace_eq_sum_configBasisIso (X : TensorPow M) :
    X.trace = ∑ s : SpinConf M, X (configBasisIso M s) (configBasisIso M s) := by
  rw [trace_eq_sum_diag]
  exact ((configBasisIso M).sum_comp (fun I => X I I)).symm

/-! ## Step 4 -/

/-- **人手 Step 4 の最初の式**: Step 2 の表示を Step 1 に代入し、`trace_basic_properties` (1) で 2 項に分ける。
`tr(εV^{(+)}) = cosh(K_1)tr(exp(K_1D_0)εV_2) + sinh(K_1)tr(exp(K_1D_0)GV_2)`。 -/
theorem trace_epsilon_VPlusOfTransfer_split (hM : 2 ≤ M) (K1 K2 : ℝ) :
    (epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace
      = ((Real.cosh K1 : ℝ) : ℂ) * (matExp ((K1 : ℂ) • openChainD0 M) * epsilon M * V2 M K2).trace
        + ((Real.sinh K1 : ℝ) : ℂ)
          * (matExp ((K1 : ℂ) • openChainD0 M) * boundaryG M (by omega) * V2 M K2).trace :=
  calc (epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace
      = (epsilon M * V1plus M (K1 : ℂ) * V2 M K2).trace := trace_epsilon_VPlusOfTransfer _ _
    -- Step 2
    _ = (matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • epsilon M + ((Real.sinh K1 : ℝ) : ℂ) • boundaryG M (by omega))
          * V2 M K2).trace := by
        rw [epsilon_mul_V1plus hM]
    -- 行列の積の分配則
    _ = (((Real.cosh K1 : ℝ) : ℂ) • (matExp ((K1 : ℂ) • openChainD0 M) * epsilon M * V2 M K2)
          + ((Real.sinh K1 : ℝ) : ℂ)
            • (matExp ((K1 : ℂ) • openChainD0 M) * boundaryG M (by omega) * V2 M K2)).trace := by
        rw [mul_add, add_mul, mul_smul_comm, mul_smul_comm, smul_mul_assoc, smul_mul_assoc]
    -- `trace_basic_properties` (1)
    _ = ((Real.cosh K1 : ℝ) : ℂ) * (matExp ((K1 : ℂ) • openChainD0 M) * epsilon M * V2 M K2).trace
          + ((Real.sinh K1 : ℝ) : ℂ)
            * (matExp ((K1 : ℂ) • openChainD0 M) * boundaryG M (by omega) * V2 M K2).trace :=
        trace_linear _ _ _ _

/-- **人手 Step 4 の第 1 項の対角成分**:
`(exp(K_1D_0)εV_2)_{ι(s),ι(s)} = exp(K_1E(s))exp(-M_colK_2)`。 -/
theorem matExp_openChainD0_mul_epsilon_mul_V2_apply_self (K1 K2 : ℝ) (s : SpinConf M) :
    (matExp ((K1 : ℂ) • openChainD0 M) * epsilon M * V2 M K2) (configBasisIso M s) (configBasisIso M s)
      = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) * ((Real.exp (-((M : ℝ) * K2)) : ℝ) : ℂ) :=
  calc (matExp ((K1 : ℂ) • openChainD0 M) * epsilon M * V2 M K2) (configBasisIso M s) (configBasisIso M s)
      = (matExp ((K1 : ℂ) • openChainD0 M) * (epsilon M * V2 M K2))
          (configBasisIso M s) (configBasisIso M s) := by rw [mul_assoc]
    -- (a) の対角性
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
          * (epsilon M * V2 M K2) (configBasisIso M s) (configBasisIso M s) :=
        matExp_smul_openChainD0_mul_apply K1 _ s _
    -- (b)、`ε` は行番号 `ι(s)` を `ι(-s)` に移す置換行列
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
          * V2 M K2 (configBasisIso M (negSpinConf s)) (configBasisIso M s) := by
        rw [epsilon_mul_apply_configBasisIso]
    -- (c)
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) * ((Real.exp (-((M : ℝ) * K2)) : ℝ) : ℂ) := by
        rw [V2_apply_configBasisIso_neg_self]

/-- **人手 Step 4 の第 2 項の対角成分**:
`(exp(K_1D_0)GV_2)_{ι(s),ι(s)} = exp(K_1E(s))s(M_col)s(1)exp(M_colK_2)`。 -/
theorem matExp_openChainD0_mul_boundaryG_mul_V2_apply_self (hM : M ≠ 0) (K1 K2 : ℝ) (s : SpinConf M) :
    (matExp ((K1 : ℂ) • openChainD0 M) * boundaryG M hM * V2 M K2)
        (configBasisIso M s) (configBasisIso M s)
      = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
          * ((((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ)
            * ((Real.exp ((M : ℝ) * K2) : ℝ) : ℂ)) :=
  calc (matExp ((K1 : ℂ) • openChainD0 M) * boundaryG M hM * V2 M K2)
        (configBasisIso M s) (configBasisIso M s)
      = (matExp ((K1 : ℂ) • openChainD0 M) * (boundaryG M hM * V2 M K2))
          (configBasisIso M s) (configBasisIso M s) := by rw [mul_assoc]
    -- (a) の `exp(K_1D_0)` の対角性
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
          * (boundaryG M hM * V2 M K2) (configBasisIso M s) (configBasisIso M s) :=
        matExp_smul_openChainD0_mul_apply K1 _ s _
    -- (a) の `G` の対角性
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
          * ((((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ)
            * V2 M K2 (configBasisIso M s) (configBasisIso M s)) := by
        rw [boundaryG_mul_apply]
    -- (c)
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
          * ((((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ)
            * ((Real.exp ((M : ℝ) * K2) : ℝ) : ℂ)) := by
        rw [V2_apply_configBasisIso_self]

/-- **人手 Step 4 の最後の式鎖の 1 行目**（`def_trace` と直前の 2 式）:
`tr(εV^{(+)}) = cosh(K_1)exp(-M_colK_2)∑_s exp(K_1E(s)) + sinh(K_1)exp(M_colK_2)∑_s s(M_col)s(1)exp(K_1E(s))`。
右辺は実数である。 -/
theorem trace_epsilon_VPlusOfTransfer_eq_spin_sums (hM : 2 ≤ M) (K1 K2 : ℝ) :
    (epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace
      = ((Real.cosh K1 * Real.exp (-((M : ℝ) * K2))
            * ∑ s : SpinConf M, Real.exp (K1 * openChainEnergy s)
          + Real.sinh K1 * Real.exp ((M : ℝ) * K2)
            * ∑ s : SpinConf M, (s (lastSite M (by omega)) : ℝ) * (s (firstSite M (by omega)) : ℝ)
                * Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) := by
  have hM0 : M ≠ 0 := by omega
  calc (epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace
      = ((Real.cosh K1 : ℝ) : ℂ) * (matExp ((K1 : ℂ) • openChainD0 M) * epsilon M * V2 M K2).trace
          + ((Real.sinh K1 : ℝ) : ℂ)
            * (matExp ((K1 : ℂ) • openChainD0 M) * boundaryG M hM0 * V2 M K2).trace :=
        trace_epsilon_VPlusOfTransfer_split hM K1 K2
    -- `def_trace`（`ι` の番号付けで足す）
    _ = ((Real.cosh K1 : ℝ) : ℂ) * ∑ s : SpinConf M,
            (matExp ((K1 : ℂ) • openChainD0 M) * epsilon M * V2 M K2)
              (configBasisIso M s) (configBasisIso M s)
          + ((Real.sinh K1 : ℝ) : ℂ) * ∑ s : SpinConf M,
            (matExp ((K1 : ℂ) • openChainD0 M) * boundaryG M hM0 * V2 M K2)
              (configBasisIso M s) (configBasisIso M s) := by
        rw [trace_eq_sum_configBasisIso, trace_eq_sum_configBasisIso]
    -- 直前の 2 式（対角成分）
    _ = ((Real.cosh K1 : ℝ) : ℂ) * ∑ s : SpinConf M,
            ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) * ((Real.exp (-((M : ℝ) * K2)) : ℝ) : ℂ)
          + ((Real.sinh K1 : ℝ) : ℂ) * ∑ s : SpinConf M,
            ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
              * ((((s (lastSite M hM0) : ℝ) * (s (firstSite M hM0) : ℝ) : ℝ) : ℂ)
                * ((Real.exp ((M : ℝ) * K2) : ℝ) : ℂ)) := by
        rw [Finset.sum_congr rfl fun s _ => matExp_openChainD0_mul_epsilon_mul_V2_apply_self K1 K2 s,
          Finset.sum_congr rfl fun s _ => matExp_openChainD0_mul_boundaryG_mul_V2_apply_self hM0 K1 K2 s]
    -- 和の外へ定数を出し、実数の積として並べる
    _ = ((Real.cosh K1 * Real.exp (-((M : ℝ) * K2))
            * ∑ s : SpinConf M, Real.exp (K1 * openChainEnergy s)
          + Real.sinh K1 * Real.exp ((M : ℝ) * K2)
            * ∑ s : SpinConf M, (s (lastSite M hM0) : ℝ) * (s (firstSite M hM0) : ℝ)
                * Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) := by
        push_cast
        rw [Finset.mul_sum, Finset.mul_sum, Finset.mul_sum, Finset.mul_sum]
        congr 1 <;> exact Finset.sum_congr rfl fun s _ => by ring

/-- **人手 Step 4 の最後の式鎖の 2 行目から 4 行目**:
`tr(εV^{(+)}) = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col}`。 -/
theorem trace_epsilon_VPlusOfTransfer_closed_form (hM : 2 ≤ M) (K1 K2 : ℝ) :
    (epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace
      = (((2 * Real.exp (-K2) * Real.cosh K1) ^ M + (2 * Real.exp K2 * Real.sinh K1) ^ M : ℝ) : ℂ) := by
  rw [trace_epsilon_VPlusOfTransfer_eq_spin_sums hM K1 K2]
  congr 1
  obtain ⟨n, rfl⟩ : ∃ n : ℕ, M = n + 1 := ⟨M - 1, by omega⟩
  calc Real.cosh K1 * Real.exp (-(((n + 1 : ℕ) : ℝ) * K2))
          * ∑ s : SpinConf (n + 1), Real.exp (K1 * openChainEnergy s)
        + Real.sinh K1 * Real.exp (((n + 1 : ℕ) : ℝ) * K2)
          * ∑ s : SpinConf (n + 1), (s (lastSite (n + 1) (by omega)) : ℝ)
              * (s (firstSite (n + 1) (by omega)) : ℝ) * Real.exp (K1 * openChainEnergy s)
      = Real.cosh K1 * Real.exp (-(((n + 1 : ℕ) : ℝ) * K2)) * (2 * (2 * Real.cosh K1) ^ (n + 1 - 1))
        + Real.sinh K1 * Real.exp (((n + 1 : ℕ) : ℝ) * K2) * (2 * (2 * Real.sinh K1) ^ (n + 1 - 1)) := by
        -- 二つの 1 次元開鎖のスピン和公式（`open_chain_partition_sum`・`open_chain_endpoint_product_sum`、`K = K_1`）
        rw [open_chain_partition_sum hM K1, open_chain_endpoint_product_sum hM K1]
    -- `2·2^{M_col-1} = 2^{M_col}`、`cosh(K_1)(cosh K_1)^{M_col-1} = (cosh K_1)^{M_col}`（`sinh` も同じ）
    _ = 2 ^ (n + 1) * Real.exp (-(((n + 1 : ℕ) : ℝ) * K2)) * Real.cosh K1 ^ (n + 1)
        + 2 ^ (n + 1) * Real.exp (((n + 1 : ℕ) : ℝ) * K2) * Real.sinh K1 ^ (n + 1) := by
        rw [Nat.add_sub_cancel]
        ring
    -- 指数法則 `exp(±M_colK_2) = (exp(±K_2))^{M_col}`
    _ = 2 ^ (n + 1) * Real.exp (-K2) ^ (n + 1) * Real.cosh K1 ^ (n + 1)
        + 2 ^ (n + 1) * Real.exp K2 ^ (n + 1) * Real.sinh K1 ^ (n + 1) := by
        rw [← Real.exp_nat_mul, ← Real.exp_nat_mul, mul_neg]
    -- 積の冪の分配
    _ = (2 * Real.exp (-K2) * Real.cosh K1) ^ (n + 1) + (2 * Real.exp K2 * Real.sinh K1) ^ (n + 1) := by
        rw [mul_pow, mul_pow, mul_pow, mul_pow]

/-! ## Step 5 -/

/-- **人手 Step 5**: `tr(εV^{(+)}) > 0`。Step 4 の最後の式鎖の 1 行目の二項がともに正であることから出す
（`open_chain_spin_sums_positive`、`cosh K_1 > 0`、`sinh K_1 > 0`、`exp(±M_colK_2) > 0`）。 -/
theorem trace_epsilon_VPlusOfTransfer_pos (hM : 2 ≤ M) {K1 : ℝ} (hK1 : 0 < K1) (K2 : ℝ) :
    0 < ((epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace).re := by
  rw [trace_epsilon_VPlusOfTransfer_eq_spin_sums hM K1 K2, Complex.ofReal_re]
  exact add_pos
    (mul_pos (mul_pos (Real.cosh_pos K1) (Real.exp_pos _)) (open_chain_partition_sum_pos hM hK1))
    (mul_pos (mul_pos (Real.sinh_pos_iff.mpr hK1) (Real.exp_pos _))
      (open_chain_endpoint_product_sum_pos hM hK1))

/-! ## 主張 -/

/-- **人手 `trace_of_epsilon_V_plus`**:
`tr(εV^{(+)}) = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col} ∈ ℝ_{>0}`。 -/
theorem trace_of_epsilon_V_plus (hM : 2 ≤ M) {K1 : ℝ} (hK1 : 0 < K1) (K2 : ℝ) :
    (epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace
        = (((2 * Real.exp (-K2) * Real.cosh K1) ^ M + (2 * Real.exp K2 * Real.sinh K1) ^ M : ℝ) : ℂ)
      ∧ 0 < ((epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace).re :=
  ⟨trace_epsilon_VPlusOfTransfer_closed_form hM K1 K2, trace_epsilon_VPlusOfTransfer_pos hM hK1 K2⟩

/-- 最終定理の入力が持つ `vPlusDataOf` の `V^{(+)}`（`VPlus M (sinh 2K_2) K_1 K_2^*`）について `tr(εV^{(+)}) > 0`。
`VPlusOfTransfer_eq_VPlus` で人手 `def_V_plus` の形へ戻して `trace_of_epsilon_V_plus` を使う。 -/
theorem trace_epsilon_vPlusDataOf_pos (P : IsingParam) (hM2 : 2 ≤ M) (hM : M ≠ 0) :
    0 < ((epsilon M * (vPlusDataOf P hM P.c2_mul_s2star_eq_c2star).V).trace).re := by
  rw [vPlusDataOf_V, IsingParam.K2star, ← VPlusOfTransfer_eq_VPlus P.K2_pos]
  exact (trace_of_epsilon_V_plus hM2 P.K1_pos P.K2).2

end Ising2D
