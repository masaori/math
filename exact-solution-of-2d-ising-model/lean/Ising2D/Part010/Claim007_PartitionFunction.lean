/-
# 分配関数をパウリ行列表示の転送行列で書く

対応する人手証明:

* `structured-latex/content/010_transfer_matrix_bridge.ts` の
  `bridge_007_claim_partition_function_in_pauli_form`
  （ラベル **`partition_function_in_pauli_form`**）
* その証明が引用している 001 章の
  `partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix`
  （ラベル **`partition_function_via_transfer_matrix`**）と
  `partition_function_2d_ising_002_definition_partition_function`
  （ラベル `def_partition_function_2d_ising`）

## このファイルの内容

1. 分配関数 `Z(J, J')` の定義（001 章。Lean には無かったので新規に定義した）。
   記号の読み替えは 010 章冒頭のとおり（001 章の `N, M, J', J` が
   本ファイルの `M, N_row, K_1, K_2`）。
2. `Z(J,J') = tr((V_1 V_2)^{N_row})`（**成分定義**の `V_1, V_2` について。001 章の主張）。
   道の総和への展開は必要十分版 `Ising2D/NecSuf/TracePathSum.lean` にあり、
   ここではその系として得る。
3. `Z(J,J') = tr((V_1 V_2)^{N_row})`（**パウリ表示**の `V_1, V_2` について。010 章の主張）。
   2 と `V1_component_equals_pauli` / `V2_component_equals_pauli` を合わせるだけである。

## `N_row ≥ 1` について

原文は `N_row ∈ ℤ_{≥1}` を仮定しているので、Lean でも `N_row = m + 1` の形で述べる
（`N_row = 0` では `tr(I) = 2^M` と `Z = 1`（空積の和）が一致しないので、この仮定は必要）。
-/
import Ising2D.Part010.Claim004_V1Bridge
import Ising2D.Part010.Claim006_V2Bridge
import Ising2D.NecSuf.TracePathSum

namespace Ising2D

open NormedSpace

variable {M : ℕ}

/-! ## 分配関数の定義（001 章） -/

/-- **原文 `def_partition_function_2d_ising` の `Z(J, J')`**（記号は 010 章の読み替え済み）。

`s : Fin N_row → SpinConf M` が原文の
`𝔖 = Map({1,…,N_row}×{1,…,M}, {-1,1})`（カリー化した形）であり、
周期境界条件 `s(i+1)`, `s(m+1)` は巡回後者 `nextSite` で表す。
`J` が行間（第 1 引数方向）、`J'` が行内（第 2 引数方向）の結合定数。 -/
noncomputable def partitionFunction (Nrow M : ℕ) (J J' : ℝ) : ℝ :=
  ∑ s : Fin Nrow → SpinConf M,
    Real.exp (∑ i : Fin Nrow, ∑ m : Fin M,
      (J * ((s i m : ℝ)) * ((s (nextSite i) m : ℝ))
        + J' * ((s i m : ℝ)) * ((s i (nextSite m) : ℝ))))

/-- 上を多重添字 `Conf M`（`= ι(𝔐)`）で書いた版。`def_config_basis_iso` の同一視を通すと
`partitionFunction` と一致する（`partitionFunction_eq_conf`）。 -/
noncomputable def partitionFunctionC (Nrow M : ℕ) (K2 K1 : ℂ) : ℂ :=
  ∑ s : Fin Nrow → Conf M,
    Complex.exp (∑ i : Fin Nrow, ∑ m : Fin M,
      (K2 * sgnC (s i m) * sgnC (s (nextSite i) m)
        + K1 * sgnC (s i m) * sgnC (s i (nextSite m))))

/-- **原文 Step 5 の全単射 `Φ`（および `ι`）による添字の付け替え。** -/
theorem partitionFunction_eq_conf (Nrow : ℕ) (J J' : ℝ) :
    ((partitionFunction Nrow M J J' : ℝ) : ℂ)
      = partitionFunctionC Nrow M (J : ℂ) (J' : ℂ) := by
  rw [partitionFunction, Complex.ofReal_sum, partitionFunctionC]
  refine Fintype.sum_equiv
    (Equiv.piCongrRight (fun _ : Fin Nrow => configBasisIso M)) _ _ ?_
  intro s
  rw [Complex.ofReal_exp, Complex.ofReal_sum]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Complex.ofReal_sum]
  refine Finset.sum_congr rfl fun m _ => ?_
  simp only [Equiv.piCongrRight_apply, Pi.map_apply, sgnC_configBasisIso]
  push_cast
  ring

/-! ## 成分定義の転送行列でのトレース公式（001 章の主張） -/

/-- `nextSite` は必要十分版の巡回後者そのもの。 -/
theorem nextSite_eq_cycSucc {n : ℕ} : (nextSite : Fin n → Fin n) = NecSuf.cycSucc := rfl

/-- `V_1 V_2` の成分（原文 001 章 Step 1）。 -/
theorem V1comp_mul_V2comp_apply (K1 K2 : ℂ) (I J : Conf M) :
    (V1comp M K1 * V2comp M K2) I J
      = Complex.exp (rowEnergy K1 I + interEnergy K2 I J) := by
  rw [V1comp, Matrix.diagonal_mul, V2comp_apply, Complex.exp_add]

/-- **原文 `partition_function_via_transfer_matrix`（001 章）の具体版。**

必要十分版 `Ising2D.NecSuf.trace_pow_succ`（任意の可換半環上の行列で成り立つ）の系である。 -/
theorem partitionFunctionC_eq_trace (K1 K2 : ℂ) (m : ℕ) :
    partitionFunctionC (m + 1) M K2 K1
      = ((V1comp M K1 * V2comp M K2) ^ (m + 1)).trace := by
  rw [NecSuf.trace_pow_succ, partitionFunctionC]
  refine Finset.sum_congr rfl fun s _ => ?_
  rw [Complex.exp_sum]
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [V1comp_mul_V2comp_apply, nextSite_eq_cycSucc]
  congr 1
  rw [rowEnergy, interEnergy, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun m' _ => ?_
  ring

/-! ## パウリ表示でのトレース公式（010 章の主張） -/

/-- **原文 `partition_function_in_pauli_form`。**

`K_1 = J'`, `K_2 = J` のもとで、`Z(J,J')` は**パウリ行列表示**の `V_1, V_2` の
トレースで書ける。 -/
theorem partition_function_in_pauli_form {J J' : ℝ} (hJ : 0 < J) (m : ℕ) :
    ((partitionFunction (m + 1) M J J' : ℝ) : ℂ)
      = ((V1pauli M (J' : ℂ) * V2pauli M (Real.sinh (2 * J)) ((Kstar J : ℝ) : ℂ))
          ^ (m + 1)).trace := by
  rw [partitionFunction_eq_conf, partitionFunctionC_eq_trace, V1pauli_eq_V1comp,
    V2pauli_eq_V2comp hJ]

/-- 既存の `Ising2D.V2`（`H_2` を使う表式）で述べた版。 -/
theorem partition_function_in_pauli_form_V2 {J J' : ℝ} (hJ : 0 < J) (m : ℕ) :
    ((partitionFunction (m + 1) M J J' : ℝ) : ℂ)
      = ((V1pauli M (J' : ℂ) * V2 M (Real.sinh (2 * J)) ((Kstar J : ℝ) : ℂ))
          ^ (m + 1)).trace := by
  rw [V2_eq_V2pauli]
  exact partition_function_in_pauli_form hJ m

end Ising2D
