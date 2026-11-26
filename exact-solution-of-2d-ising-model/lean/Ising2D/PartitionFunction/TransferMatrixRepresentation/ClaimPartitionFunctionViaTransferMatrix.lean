/-
# 転送行列による分配関数の表式 `(Z(K_1,K_2))_ℂ = tr((V_1V_2)^{N_row})`

対応する人手証明（正本は `structured-latex/content/partition_function_transfer_matrix_representation.ts`）:

* `partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix`
  （ラベル **`partition_function_via_transfer_matrix`**）

`V_1, V_2` は人手 `def_transfer_matrix` の成分定義（`Ising2D.V1`, `Ising2D.V2`）そのものである。

## 人手証明との対応

* 準備 (R)（行列の添字の和を `ord` の全単射で `𝔐` 上の和へ付け替える）
  → Lean の行列の添字型は `Conf M` で、人手の行番号 `ord(μ)` は添字 `ι(μ)` にあたる
  （`config_numbering_equals_kronecker_numbering`）。行列の積・トレースの和は `Conf M` 上の和であり、
  `𝔐` 上の和への付け替えは最後の全単射 `Φ` にまとめて行う（下記）。
* 中間目標「転送行列の積の成分」→ `V1_mul_V2_apply`。
* 中間目標「行列の冪の成分」(*) → 証明の中の `hpow`（`r` についての帰納法。人手の `r ∈ ℤ_{≥1}` は Lean の `r + 1`、
  中間の組 `(μ^{(2)},…,μ^{(r)}) ∈ 𝔐^{r-1}` は `p : Fin r → Conf M`、道 `(μ^{(1)},…,μ^{(r+1)})` は `Fin.snoc (Fin.cons i p) j`）。
* 中間目標「トレースの展開」→ 証明の中の `htrace`。人手の行方向の周期規約 `μ^{(N_row+1)} := μ^{(1)}` は、
  行の添字 `Fin N_row` の上の `nextSite`（`def_transfer_matrix` の周期規約と同じ巡回後者）で書く。
  「トレースの展開」と同じ等式を必要十分版 `Ising2D.NecSuf.trace_pow_succ`（任意の可換半環上の行列）の特殊化として得ることは
  `ClaimPartitionFunctionViaTransferMatrixFromNecSuf.lean` が述べる。
* 中間目標「指数の積を指数の和へ」→ `Real.exp_sum`。
* 実数の値の包含（人手 `inclusion_rr_to_cc`）を積の外へ出す段は具体版で書く。「転送行列の積の成分」の鎖の 5 行目の
  `(exp(…))_ℂ(exp(…))_ℂ = (exp(…)exp(…))_ℂ` は `real_inclusion_mul`（人手 `real_inclusion_preserves_product`）、
  「指数の積を指数の和へ」の鎖の 2 行目の `Π_{k=1}^{N_row}(exp(…))_ℂ = (Π_{k=1}^{N_row} exp(…))_ℂ` は
  `real_inclusion_preserves_finite_product`（`m → N_row`）である。mathlib の `Complex.ofReal_mul`・`Complex.ofReal_prod` は使わない。
* 中間目標「`𝔐^{N_row}` と `𝔖` の全単射」→ `rowsToLattice`（添字 `Conf M` からスピン配置への `ι⁻¹` と、
  行ごとの配置の組 `(μ^{(1)},…,μ^{(N_row)})` から `s(i,j) := μ^{(i)}(j)` への `Φ` の合成）。
  周期規約の整合 (P) は、両方向とも同じ `nextSite` で書いていることから定義どおりに成り立つ。
* 中間目標「分配関数との一致」→ `partition_function_via_transfer_matrix`。
  有限集合 `{1,…,N_row}×{1,…,M_col}` 上の和と二重和の書き直しは `Fintype.sum_prod_type`。

## 仮定について

人手は `N_row ∈ ℤ_{≥1}` を仮定しているので、Lean でも `1 ≤ Nrow` を仮定する
（`N_row = 0` では `tr(I) = 2^{M_col}` と `Z = 1`（空積の和）が一致しないので、この仮定は必要）。
人手は `K_1, K_2 ∈ ℝ_{>0}` を置く（`def_partition_function_2d_ising` の `Z` の定義域）。Lean の `partitionFunction` は
`ℝ × ℝ` の上で定義され、証明は `K_1, K_2 > 0` を使わないが、主張を人手どおりにするため `_hK1`・`_hK2` で受ける
（先例 `partition_function_sandwich_and_limit_in_N_row` の `_hK1`）。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionTransferMatrix
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSum
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteProduct
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionPartitionFunction

namespace Ising2D

variable {M : ℕ}

/-- **人手の中間目標「転送行列の積の成分」**:
`(V_1V_2)_{ord(μ),ord(μ')} = exp(∑_m (K_1 μ(m)μ(m+1) + K_2 μ(m)μ'(m)))`
（Lean の添字 `I, J` のスピン値は `sgn`）。 -/
theorem V1_mul_V2_apply (K1 K2 : ℝ) (I J : Conf M) :
    (V1 M K1 * V2 M K2) I J
      = ((Real.exp (∑ m : Fin M,
          (K1 * sgn (I m) * sgn (I (nextSite m)) + K2 * sgn (I m) * sgn (J m))) : ℝ) : ℂ) := by
  rw [V1_eq_diagonal, Matrix.diagonal_mul, V2_apply,
    real_inclusion_mul,                                     -- 5 行目: `real_inclusion_preserves_product`
    ← Real.exp_add,
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

/-- **人手 `partition_function_via_transfer_matrix`: `(Z(K_1,K_2))_ℂ = tr((V_1V_2)^{N_row})`。**
人手の `r_ℂ`（`inclusion_rr_to_cc`）は Lean の `((· : ℝ) : ℂ)`。人手の分配関数との一致の鎖の最後の行
（包含を和の外へ出す `real_inclusion_preserves_finite_sum`）は、下の `real_inclusion_of_finite_sum_fintype`（添字の格子の配位の集合は空でない）の書き換えに当たる。 -/
theorem partition_function_via_transfer_matrix {K1 K2 : ℝ} (_hK1 : 0 < K1) (_hK2 : 0 < K2)
    {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    ((partitionFunction Nrow M K1 K2 : ℝ) : ℂ) = ((V1 M K1 * V2 M K2) ^ Nrow).trace := by
  obtain ⟨n, rfl⟩ : ∃ n, Nrow = n + 1 := ⟨Nrow - 1, by omega⟩
  -- 人手の `A := V_1 V_2`
  set A : Matrix (Conf M) (Conf M) ℂ := V1 M K1 * V2 M K2 with hA
  -- 中間目標「行列の冪の成分」(*)（`r` についての帰納法）
  have hpow : ∀ (r : ℕ) (i j : Conf M), (A ^ (r + 1)) i j
      = ∑ p : Fin r → Conf M, ∏ k : Fin (r + 1),
          A ((Fin.snoc (Fin.cons i p : Fin (r + 1) → Conf M) j : Fin (r + 2) → Conf M) k.castSucc)
            ((Fin.snoc (Fin.cons i p : Fin (r + 1) → Conf M) j : Fin (r + 2) → Conf M) k.succ) := by
    intro r
    induction r with
    | zero =>
      intro i j
      calc (A ^ (0 + 1)) i j
          = A i j := by rw [zero_add, pow_one]                -- 行列の 1 乗はその行列自身である
        _ = ∏ k : Fin (0 + 1),
              A ((Fin.snoc (Fin.cons i Fin.elim0 : Fin (0 + 1) → Conf M) j : Fin (0 + 2) → Conf M) k.castSucc)
                ((Fin.snoc (Fin.cons i Fin.elim0 : Fin (0 + 1) → Conf M) j : Fin (0 + 2) → Conf M) k.succ) := by
              -- 因子が 1 つの有限積はその因子である
              rw [Fin.prod_univ_one]
              rfl
        _ = ∑ p : Fin 0 → Conf M, ∏ k : Fin (0 + 1),
              A ((Fin.snoc (Fin.cons i p : Fin (0 + 1) → Conf M) j : Fin (0 + 2) → Conf M) k.castSucc)
                ((Fin.snoc (Fin.cons i p : Fin (0 + 1) → Conf M) j : Fin (0 + 2) → Conf M) k.succ) := by
              -- `𝔐^0` は空列のみからなる 1 点集合である
              rw [Fintype.sum_unique]
              congr 3
    | succ r ih =>
      intro i j
      calc (A ^ (r + 1 + 1)) i j
          = ∑ l : Conf M, (A ^ (r + 1)) i l * A l j := by
              rw [pow_succ, Matrix.mul_apply]                 -- `A^{r+1} = A^r A` と `mat_mult`
        _ = ∑ l : Conf M, (∑ p : Fin r → Conf M, ∏ k : Fin (r + 1),
              A ((Fin.snoc (Fin.cons i p : Fin (r + 1) → Conf M) l : Fin (r + 2) → Conf M) k.castSucc)
                ((Fin.snoc (Fin.cons i p : Fin (r + 1) → Conf M) l : Fin (r + 2) → Conf M) k.succ))
              * A l j := by
              exact Finset.sum_congr rfl fun l _ => by rw [ih i l]   -- 帰納法の仮定 (*)
        _ = ∑ l : Conf M, ∑ p : Fin r → Conf M, (∏ k : Fin (r + 1),
              A ((Fin.snoc (Fin.cons i p : Fin (r + 1) → Conf M) l : Fin (r + 2) → Conf M) k.castSucc)
                ((Fin.snoc (Fin.cons i p : Fin (r + 1) → Conf M) l : Fin (r + 2) → Conf M) k.succ))
              * A l j := by
              exact Finset.sum_congr rfl fun l _ => Finset.sum_mul _ _ _   -- 有限和に対する分配律
        _ = ∑ q : Fin (r + 1) → Conf M, ∏ k : Fin (r + 1 + 1),
              A ((Fin.snoc (Fin.cons i q : Fin (r + 2) → Conf M) j : Fin (r + 3) → Conf M) k.castSucc)
                ((Fin.snoc (Fin.cons i q : Fin (r + 2) → Conf M) j : Fin (r + 3) → Conf M) k.succ) := by
              -- `𝔐 × 𝔐^{r-1} → 𝔐^r` の全単射（`(μ^{(r+1)}, p) ↦ Fin.snoc p μ^{(r+1)}`）による添字の付け替えと、
              -- 末尾の因子を有限積へ入れること
              rw [← Fintype.sum_prod_type']
              refine Fintype.sum_equiv (Fin.snocEquiv (fun _ : Fin (r + 1) => Conf M)) _ _ fun lp => ?_
              obtain ⟨l, p⟩ := lp
              show _ = ∏ k : Fin (r + 1 + 1),
                A ((Fin.snoc (Fin.cons i (Fin.snoc p l) : Fin (r + 2) → Conf M) j : Fin (r + 3) → Conf M) k.castSucc)
                  ((Fin.snoc (Fin.cons i (Fin.snoc p l) : Fin (r + 2) → Conf M) j : Fin (r + 3) → Conf M) k.succ)
              conv_rhs => rw [Fin.prod_univ_castSucc]
              rw [Fin.cons_snoc_eq_snoc_cons]
              congr 1
              · refine Finset.prod_congr rfl fun k _ => ?_
                simp only [Fin.snoc_castSucc, ← Fin.castSucc_succ]
              · rw [Fin.snoc_castSucc, Fin.succ_last, Fin.snoc_last, Fin.snoc_last]
  -- 人手の行方向の周期規約 `μ^{(N_row+1)} := μ^{(1)}` を、行の添字の上の `nextSite` で書く段
  have hnext : ∀ (s : Fin (n + 1) → Conf M) (k : Fin (n + 1)),
      (Fin.snoc s (s 0) : Fin (n + 2) → Conf M) k.succ = s (nextSite k) := by
    intro s k
    refine Fin.lastCases ?_ (fun k' => ?_) k
    · rw [Fin.succ_last, Fin.snoc_last]
      congr 1
      exact (Fin.ext (nextSite_val_of_last (by simp))).symm
    · rw [← Fin.castSucc_succ, Fin.snoc_castSucc]
      congr 1
      exact (Fin.ext (nextSite_val_of_lt (by simp))).symm
  -- 中間目標「トレースの展開」
  have htrace : (A ^ (n + 1)).trace
      = ∑ s : Fin (n + 1) → Conf M, ∏ k : Fin (n + 1), A (s k) (s (nextSite k)) := by
    calc (A ^ (n + 1)).trace
        = ∑ i : Conf M, (A ^ (n + 1)) i i := rfl              -- `def_trace`
      _ = ∑ i : Conf M, ∑ p : Fin n → Conf M, ∏ k : Fin (n + 1),
            A ((Fin.snoc (Fin.cons i p : Fin (n + 1) → Conf M) i : Fin (n + 2) → Conf M) k.castSucc)
              ((Fin.snoc (Fin.cons i p : Fin (n + 1) → Conf M) i : Fin (n + 2) → Conf M) k.succ) :=
            Finset.sum_congr rfl fun i _ => hpow n i i        -- (*) を `r = N_row`、`μ^{(N_row+1)} = μ^{(1)}` として
      _ = ∑ s : Fin (n + 1) → Conf M, ∏ k : Fin (n + 1), A (s k) (s (nextSite k)) := by
            -- `𝔐 × 𝔐^{N_row-1} → 𝔐^{N_row}` の全単射（`(μ^{(1)}, p) ↦ Fin.cons μ^{(1)} p`）による添字の付け替え。
            -- 3 行目で置いた `μ^{(N_row+1)} = μ^{(1)}` を、行方向の周期規約 `hnext` で `nextSite` の形にする
            rw [← Fintype.sum_prod_type']
            refine Fintype.sum_equiv (Fin.consEquiv (fun _ : Fin (n + 1) => Conf M)) _ _ fun ip => ?_
            obtain ⟨i, p⟩ := ip
            show _ = ∏ k : Fin (n + 1), A ((Fin.cons i p : Fin (n + 1) → Conf M) k)
              ((Fin.cons i p : Fin (n + 1) → Conf M) (nextSite k))
            refine Finset.prod_congr rfl fun k _ => ?_
            rw [Fin.snoc_castSucc, ← hnext (Fin.cons i p) k, Fin.cons_zero]
  rw [htrace, hA, partitionFunction, ← real_inclusion_of_finite_sum_fintype]
  symm
  -- `Φ` による添字の付け替え
  refine Fintype.sum_equiv (rowsToLattice (n + 1) M) _ _ fun w => ?_
  -- 転送行列の積の成分を各因子へ代入し、指数の積を指数の和へ
  rw [Finset.prod_congr rfl fun k _ => V1_mul_V2_apply K1 K2 (w k) (w (nextSite k)),
    real_inclusion_preserves_finite_product n,              -- 「指数の積を指数の和へ」2 行目: `real_inclusion_preserves_finite_product`（`m → N_row`）
    ← Real.exp_sum]
  congr 2
  -- 有限集合 `{1,…,N_row}×{1,…,M_col}` 上の和を二重和として書き直す
  rw [Fintype.sum_prod_type]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun m _ => ?_
  simp only [rowsToLattice_apply]

end Ising2D
