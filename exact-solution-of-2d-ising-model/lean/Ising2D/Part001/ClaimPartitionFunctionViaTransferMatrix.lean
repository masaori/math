/-
# 転送行列による分配関数の表式 `Z(K_1,K_2) = tr((V_1V_2)^{N_row})`

対応する人手証明（正本は `structured-latex/content/001_partition_function_2d_ising.ts`）:

* `partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix`
  （ラベル **`partition_function_via_transfer_matrix`**）

`V_1, V_2` は人手 `def_transfer_matrix` の成分定義（`Ising2D.V1`, `Ising2D.V2`）そのものである。

## 人手証明との対応

* 準備 (R)（行列の添字の和を `ord` の全単射で `𝔐` 上の和へ付け替える）
  → Lean の行列の添字型は `Conf M` で、人手の行番号 `ord(μ)` は添字 `ι(μ)` にあたる
  （`config_numbering_equals_kronecker_numbering`）。行列の積・トレースの和は `Conf M` 上の和であり、
  `𝔐` 上の和への付け替えは最後の全単射 `Φ` にまとめて行う（下記）。
* 中間目標「転送行列の積の成分」→ `V1_mul_V2_apply`。
* 中間目標「行列の冪の成分」(*) と「トレースの展開」→ 必要十分版
  `Ising2D.NecSuf.trace_pow_succ`（`tr(A^{n+1})` は閉じた道の重みの総和。任意の可換半環上の行列で成り立つ）。
  人手の行方向の周期規約 `μ^{(N_row+1)} := μ^{(1)}` はそこでの巡回後者 `cycSucc`（= `nextSite`）。
* 中間目標「指数の積を指数の和へ」→ `Real.exp_sum`。
* 中間目標「`𝔐^{N_row}` と `𝔖` の全単射」→ `rowsToLattice`（添字 `Conf M` からスピン配置への `ι⁻¹` と、
  行ごとの配置の組 `(μ^{(1)},…,μ^{(N_row)})` から `s(i,j) := μ^{(i)}(j)` への `Φ` の合成）。
  周期規約の整合 (P) は、両方向とも同じ `nextSite` で書いていることから定義どおりに成り立つ。
* 中間目標「分配関数との一致」→ `partition_function_via_transfer_matrix`。
  有限集合 `{1,…,N_row}×{1,…,M_col}` 上の和と二重和の書き直しは `Fintype.sum_prod_type`。

## 仮定について

人手は `N_row ∈ ℤ_{≥1}` を仮定しているので、Lean でも `1 ≤ Nrow` を仮定する
（`N_row = 0` では `tr(I) = 2^{M_col}` と `Z = 1`（空積の和）が一致しないので、この仮定は必要）。
`K_1, K_2 > 0` は証明で使わないので仮定に置かない。
-/
import Ising2D.Part001.DefinitionTransferMatrix
import Ising2D.Part001.DefinitionPartitionFunction
import Ising2D.NecSuf.TracePathSum

namespace Ising2D

variable {M : ℕ}

/-- `nextSite` は必要十分版の巡回後者そのもの。 -/
theorem nextSite_eq_cycSucc {n : ℕ} : (nextSite : Fin n → Fin n) = NecSuf.cycSucc := rfl

/-- **人手の中間目標「転送行列の積の成分」**:
`(V_1V_2)_{ord(μ),ord(μ')} = exp(∑_m (K_1 μ(m)μ(m+1) + K_2 μ(m)μ'(m)))`
（Lean の添字 `I, J` のスピン値は `sgn`）。 -/
theorem V1_mul_V2_apply (K1 K2 : ℝ) (I J : Conf M) :
    (V1 M K1 * V2 M K2) I J
      = ((Real.exp (∑ m : Fin M,
          (K1 * sgn (I m) * sgn (I (nextSite m)) + K2 * sgn (I m) * sgn (J m))) : ℝ) : ℂ) := by
  rw [V1_eq_diagonal, Matrix.diagonal_mul, V2_apply, ← Complex.ofReal_mul, ← Real.exp_add,
    Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
  congr 2
  exact Finset.sum_congr rfl fun m _ => by ring

/-- **人手の全単射 `Φ : 𝔐^{N_row} → 𝔖`**（添字 `Conf M` を `ι⁻¹` でスピン配置へ戻したうえで
`s(i,j) := μ^{(i)}(j)` とする）。 -/
noncomputable def rowsToLattice (Nrow M : ℕ) : (Fin Nrow → Conf M) ≃ (Fin Nrow × Fin M → SpinVal) :=
  (Equiv.piCongrRight fun _ : Fin Nrow => (configBasisIso M).symm).trans
    (Equiv.curry (Fin Nrow) (Fin M) SpinVal).symm

theorem rowsToLattice_apply {Nrow : ℕ} (w : Fin Nrow → Conf M) (p : Fin Nrow × Fin M) :
    ((rowsToLattice Nrow M w p : SpinVal) : ℝ) = sgn (w p.1 p.2) := by
  simp only [rowsToLattice, Equiv.trans_apply, Equiv.curry_symm_apply]
  exact coe_configBasisIso_symm_apply _ _

/-- **人手 `partition_function_via_transfer_matrix`: `Z(K_1,K_2) = tr((V_1V_2)^{N_row})`。** -/
theorem partition_function_via_transfer_matrix (K1 K2 : ℝ) {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    ((partitionFunction Nrow M K1 K2 : ℝ) : ℂ) = ((V1 M K1 * V2 M K2) ^ Nrow).trace := by
  obtain ⟨n, rfl⟩ : ∃ n, Nrow = n + 1 := ⟨Nrow - 1, by omega⟩
  -- 行列の冪の成分とトレースの展開（閉じた道の重みの総和）
  rw [NecSuf.trace_pow_succ, partitionFunction, Complex.ofReal_sum]
  symm
  -- `Φ` による添字の付け替え
  refine Fintype.sum_equiv (rowsToLattice (n + 1) M) _ _ fun w => ?_
  -- 転送行列の積の成分を各因子へ代入し、指数の積を指数の和へ
  rw [Finset.prod_congr rfl fun k _ => V1_mul_V2_apply K1 K2 (w k) (w (NecSuf.cycSucc k)),
    ← Complex.ofReal_prod, ← Real.exp_sum]
  congr 2
  -- 有限集合 `{1,…,N_row}×{1,…,M_col}` 上の和を二重和として書き直す
  rw [Fintype.sum_prod_type]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun m _ => ?_
  simp only [rowsToLattice_apply, nextSite_eq_cycSucc]

end Ising2D
