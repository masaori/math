/-
# `ε` の成分を 1 行ぶんのスピン配置の番号で読む、`(ε_ℝu)_{ord(s)} = u_{ord(-s)}`

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

* `maxeig_claim_epsilon_entries_in_row_configuration_numbering`（ラベル **`epsilon_entries_in_row_configuration_numbering`**）
* `maxeig_claim_epsilon_real_permutes_entries_by_spin_flip`（ラベル **`epsilon_real_permutes_entries_by_spin_flip`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `-s`（`def_negated_row_configuration`） | `negSpinConf`（`ClaimTraceEpsilonVPlusMatrixEntries.lean`。値は `coe_negSpinConf_apply`） |
| `ε` の成分: 準備の `s'(m) = -s(m)` の場合の 3 行 `⟹ s'(m) ≠ s(m) ⟹ i_m ≠ j_m ⟹ (σ^x)_{i_m j_m} = 1_ℂ` | `pauliX_configBasisIso_apply_of_eq_neg` の `hne`・`hij`・最後の段 |
| `ε` の成分: 準備の `s'(m) ≠ -s(m)` の場合の 3 行 `⟹ s'(m) = s(m) ⟹ i_m = j_m ⟹ (σ^x)_{i_m j_m} = 0_ℂ` | `pauliX_configBasisIso_apply_of_ne_neg` の `heq`・`hij`・最後の段 |
| `ε` の成分: `s' = -s` の 5 行の鎖 `ε_{ord(s),ord(s')} = ε_{ν(I),ν(J)} = (σ^x⊠⋯⊠σ^x)_{ν(I),ν(J)} = Π_m (σ^x)_{i_m j_m} = Π_m 1_ℂ = 1_ℂ` | `epsilon_entries_in_row_configuration_numbering` の `if_pos` の側の `calc` の 4 段（1 行目は下の注記） |
| `ε` の成分: `s' ≠ -s` の `s'(n) ≠ -s(n)` なる `n` と 4 行の鎖 `ε_{ord(s),ord(s')} = ⋯ = Π_m (σ^x)_{i_m j_m} = 0_ℂ` | 同じ定理の `if_neg` の側の `Function.ne_iff`・`hn0` と `calc` の 3 段 |
| 並べ替え: `l ≠ ord(-s)` の 5 行 `(y_l)_ℂ = ⋯ = 0_ℂ` | `epsilon_real_permutes_entries_by_spin_flip` の `hoff` の `calc` の 5 段 |
| 並べ替え: `l = ord(-s)` の 5 行 `(y_{ord(-s)})_ℂ = ⋯ = (u_{ord(-s)})_ℂ` | 同じ定理の `hon` の `calc` の 5 段 |
| 並べ替え: 5 行の鎖 `((ε_ℝu)_{ord(s)})_ℂ = ⋯ = (u_{ord(-s)})_ℂ` と `inclusion_rr_to_cc_is_injective` | 同じ定理の最後の `calc` の 5 段と単射性 |

- 人手の `ord(s)` で番号を付けた行・列は、Lean では添字 `configBasisIso M s : Conf M` そのものである
  （`PartitionFunction/TransferMatrixRepresentation/DefinitionTransferMatrix.lean` 冒頭の「行列の添字」）。このため人手の鎖の 1 行目
  `ε_{ord(s),ord(s')} = ε_{ν(I),ν(J)}`（`config_numbering_equals_kronecker_numbering`）は Lean では添字の読み方であって段は無い
  （`basisVec_configBasisIso_apply` と同じ扱い）。人手の `I = ι(s)` の第 `m` 成分 `i_m` は `configBasisIso M s m`、
  `-s` は `negSpinConf s`（`ClaimTraceEpsilonVPlusMatrixEntries.lean`）である。
- 人手の `global_spin_flip_kronecker_form` は `epsilon_eq_siteProd`、`def_kronecker` (2) は `siteProd_apply` である。
- 人手の `ε_ℝ` は `epsilonReal n`（人手の `M_col` は `n + 1`）、`def_epsilon_real` の `((ε_ℝ)_kl)_ℂ = ε_kl` は `ofReal_epsilonReal_apply`、
  `def_real_matrix_vector_product` は `*ᵥ`（成分は `dotProduct` で人手の式と `rfl`）である。
- `row_configuration_numbering_bijective` で `l = ord(t)` と書く段は `ι` の全射性 `(configBasisIso _).surjective` である
  （`mulVec_basisVec_configBasisIso_apply` と同じ扱い）。
- `real_inclusion_preserves_product` は `real_inclusion_mul`、`real_inclusion_preserves_finite_sum` は具体版 `real_inclusion_of_finite_sum_fintype`（添字 `Conf M` は空でない）、
  `finite_sum_with_single_nonzero_term` は具体版が無く `Finset.sum_eq_single`、`finite_product_of_complex_ones` は `Finset.prod_const_one`、
  `finite_product_with_zero_factor_is_zero` は `Finset.prod_eq_zero`、`complex_zero_times_is_zero` は `zero_mul`、
  `complex_numbers_form_a_field` の積の単位元は `one_mul` である（いずれも既存の慣行どおり）。

- 人手 `epsilon_entries_in_row_configuration_numbering` は `M_col ∈ ℤ_{≥1}` を置くので、Lean もその定理と証明の準備の 2 補題に
  `1 ≤ M` を仮定に取る（証明は使わない）。`epsilon_real_permutes_entries_by_spin_flip` は `M_col = n + 1` なので
  `Nat.le_add_left 1 n`（`1 ≤ n + 1`）を渡す。

必要十分版は置かない。`ε` の成分は具体的な行列 `σ^x` の成分と `{-1,1}` の場合分けの計算であり、並べ替えの主張は引いた主張
（`ε` の成分、包含が和と積を保つこと、一つの項のほかが 0 の和）を 1 回ずつ当てることに尽きる。置換行列の一般の性質は
`Ising2D/NecSuf/PermMatrix.lean` にあり、`epsilonR_mulVec_apply` はその系である（人手と 1 対 1 なのはこちら）。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimTraceEpsilonVPlusMatrixEntries
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSum
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealFixedVectorIffInclusionInEvenEigenvectors

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 人手 `epsilon_entries_in_row_configuration_numbering` の証明の準備の `s'(m) = -s(m)` の場合の 3 行:
`s'(m) = -s(m) ⟹ s'(m) ≠ s(m) ⟹ i_m ≠ j_m ⟹ (σ^x)_{i_m j_m} = 1_ℂ`（`I = ι(s)`, `J = ι(s')`）。 -/
theorem pauliX_configBasisIso_apply_of_eq_neg (_hM : 1 ≤ M) (s s' : SpinConf M) (m : Fin M)
    (h : (s' m : ℝ) = -(s m : ℝ)) :
    pauliX (configBasisIso M s m) (configBasisIso M s' m) = 1 := by
  have hne : (s' m : ℝ) ≠ (s m : ℝ) := by                          -- `s(m) ∈ {-1,1}` なので `-s(m) ≠ s(m)`
    rw [h]
    rcases (s m).2 with hs | hs <;> rw [hs] <;> norm_num
  have hij : configBasisIso M s m ≠ configBasisIso M s' m := by    -- `def_config_basis_iso` の `i_m` の場合分け
    rw [configBasisIso_apply, configBasisIso_apply]
    rcases (s m).2 with hs | hs <;> rcases (s' m).2 with hs' | hs' <;>
      simp only [idxOfSpin, hs, hs'] at hne ⊢ <;>
      first | exact absurd rfl hne | norm_num
  -- `def_pauli_matrices` の `σ^x` の成分 `(σ^x)_{12} = (σ^x)_{21} = 1_ℂ`
  revert hij
  generalize configBasisIso M s m = a
  generalize configBasisIso M s' m = b
  intro hij
  fin_cases a <;> fin_cases b <;> simp_all [pauliX]

/-- 人手 `epsilon_entries_in_row_configuration_numbering` の証明の準備の `s'(m) ≠ -s(m)` の場合の 3 行:
`s'(m) ≠ -s(m) ⟹ s'(m) = s(m) ⟹ i_m = j_m ⟹ (σ^x)_{i_m j_m} = 0_ℂ`。 -/
theorem pauliX_configBasisIso_apply_of_ne_neg (_hM : 1 ≤ M) (s s' : SpinConf M) (m : Fin M)
    (h : (s' m : ℝ) ≠ -(s m : ℝ)) :
    pauliX (configBasisIso M s m) (configBasisIso M s' m) = 0 := by
  have heq : s' m = s m := by                                       -- `s'(m)` は 2 元の集合 `{-1,1} = {s(m), -s(m)}` の元
    apply Subtype.ext
    rcases (s m).2 with hs | hs <;> rcases (s' m).2 with hs' | hs' <;>
      simp only [hs, hs'] at h ⊢ <;>
      first | exact absurd rfl h | norm_num at h
  have hij : configBasisIso M s m = configBasisIso M s' m := by    -- `def_config_basis_iso` の `i_m` の場合分け
    rw [configBasisIso_apply, configBasisIso_apply, heq]
  -- `def_pauli_matrices` の `σ^x` の成分 `(σ^x)_{11} = (σ^x)_{22} = 0_ℂ`
  rw [← hij]
  generalize configBasisIso M s m = a
  fin_cases a <;> simp [pauliX]

/-- **人手 `epsilon_entries_in_row_configuration_numbering`**: `ε_{ord(s),ord(s')}` は `s' = -s` のとき `1_ℂ`、
そうでないとき `0_ℂ`。人手は場合ごとに `ε_{ord(s),ord(s')}` から始まる 1 本の鎖を書き、Lean も共通の 3 行（2 段）を
2 つの場合の `calc` にそれぞれ書く。 -/
theorem epsilon_entries_in_row_configuration_numbering (hM : 1 ≤ M) (s s' : SpinConf M) :
    epsilon M (configBasisIso M s) (configBasisIso M s') = if s' = negSpinConf s then 1 else 0 := by
  by_cases h : s' = negSpinConf s
  · -- `s' = -s`: すべての `m` で `s'(m) = -s(m)`
    rw [if_pos h]
    calc epsilon M (configBasisIso M s) (configBasisIso M s')
        = siteProd M (fun _ => pauliX) (configBasisIso M s) (configBasisIso M s') := by
          rw [epsilon_eq_siteProd]                                  -- `global_spin_flip_kronecker_form`
      _ = ∏ m : Fin M, pauliX (configBasisIso M s m) (configBasisIso M s' m) := by
          rw [siteProd_apply]                                       -- `def_kronecker` (2)（`A_k → σ^x`）
      _ = ∏ _m : Fin M, (1 : ℂ) :=
          Finset.prod_congr rfl fun m _ =>
            pauliX_configBasisIso_apply_of_eq_neg hM s s' m (by rw [h, coe_negSpinConf_apply])
                                                                    -- 準備の `s'(m) = -s(m)` の場合を各因子へ同時に
      _ = 1 := Finset.prod_const_one                                -- `finite_product_of_complex_ones`
  · -- `s' ≠ -s`: `s'(n) ≠ -s(n)` なる `n` が在り、準備より `(σ^x)_{i_n j_n} = 0_ℂ`
    rw [if_neg h]
    obtain ⟨n, hn⟩ := Function.ne_iff.mp h
    have hn0 : pauliX (configBasisIso M s n) (configBasisIso M s' n) = 0 :=
      pauliX_configBasisIso_apply_of_ne_neg hM s s' n
        (fun hc => hn (Subtype.ext (by rw [coe_negSpinConf_apply, hc])))
    calc epsilon M (configBasisIso M s) (configBasisIso M s')
        = siteProd M (fun _ => pauliX) (configBasisIso M s) (configBasisIso M s') := by
          rw [epsilon_eq_siteProd]                                  -- `global_spin_flip_kronecker_form`
      _ = ∏ m : Fin M, pauliX (configBasisIso M s m) (configBasisIso M s' m) := by
          rw [siteProd_apply]                                       -- `def_kronecker` (2)（`A_k → σ^x`）
      _ = 0 := Finset.prod_eq_zero (Finset.mem_univ n) hn0          -- `finite_product_with_zero_factor_is_zero`（`n → n`）

/-- **人手 `epsilon_real_permutes_entries_by_spin_flip`**: `(ε_ℝu)_{ord(s)} = u_{ord(-s)}`（人手の `M_col` は `n + 1`）。人手の `y_l` は Lean の `r l`。 -/
theorem epsilon_real_permutes_entries_by_spin_flip (n : ℕ) (u : Conf (n + 1) → ℝ) (s : SpinConf (n + 1)) :
    (epsilonReal n *ᵥ u) (configBasisIso (n + 1) s)
      = u (configBasisIso (n + 1) (negSpinConf s)) := by
  -- `y_l := (ε_ℝ)_{ord(s),l} u_l`
  let r : Conf (n + 1) → ℝ := fun l => epsilonReal n (configBasisIso (n + 1) s) l * u l
  have hoff : ∀ l, l ≠ configBasisIso (n + 1) (negSpinConf s) → ((r l : ℝ) : ℂ) = 0 := by
    intro l hl
    obtain ⟨t, rfl⟩ := (configBasisIso (n + 1)).surjective l      -- `row_configuration_numbering_bijective`（`l = ord(t)`）
    have ht : t ≠ negSpinConf s := fun hc => hl (by rw [hc])
    calc ((r (configBasisIso (n + 1) t) : ℝ) : ℂ)
        = ((epsilonReal n (configBasisIso (n + 1) s) (configBasisIso (n + 1) t)
              * u (configBasisIso (n + 1) t) : ℝ) : ℂ) := rfl     -- `y_l` の置き方と `l = ord(t)`
      _ = ((epsilonReal n (configBasisIso (n + 1) s) (configBasisIso (n + 1) t) : ℝ) : ℂ)
            * ((u (configBasisIso (n + 1) t) : ℝ) : ℂ) :=
          (real_inclusion_mul _ _).symm                             -- `real_inclusion_preserves_product`（`a → (ε_ℝ)_{ord(s),l}`, `b → u_l`）を右辺から左辺へ
      _ = epsilon (n + 1) (configBasisIso (n + 1) s) (configBasisIso (n + 1) t)
            * ((u (configBasisIso (n + 1) t) : ℝ) : ℂ) := by
          rw [ofReal_epsilonReal_apply]                             -- `def_epsilon_real`
      _ = 0 * ((u (configBasisIso (n + 1) t) : ℝ) : ℂ) := by
          rw [epsilon_entries_in_row_configuration_numbering (Nat.le_add_left 1 n), if_neg ht]
                                                                    -- `epsilon_entries_in_row_configuration_numbering`（`s' → t`）
      _ = 0 := zero_mul _                                           -- `complex_zero_times_is_zero`
  have hon : ((r (configBasisIso (n + 1) (negSpinConf s)) : ℝ) : ℂ)
      = ((u (configBasisIso (n + 1) (negSpinConf s)) : ℝ) : ℂ) :=
    calc ((r (configBasisIso (n + 1) (negSpinConf s)) : ℝ) : ℂ)
        = ((epsilonReal n (configBasisIso (n + 1) s) (configBasisIso (n + 1) (negSpinConf s))
              * u (configBasisIso (n + 1) (negSpinConf s)) : ℝ) : ℂ) := rfl
                                                                    -- `y_l` の置き方（`l → ord(-s)`）
      _ = ((epsilonReal n (configBasisIso (n + 1) s) (configBasisIso (n + 1) (negSpinConf s)) : ℝ) : ℂ)
            * ((u (configBasisIso (n + 1) (negSpinConf s)) : ℝ) : ℂ) :=
          (real_inclusion_mul _ _).symm                             -- `real_inclusion_preserves_product`（`a → (ε_ℝ)_{ord(s),l}`, `b → u_l`）を右辺から左辺へ
      _ = epsilon (n + 1) (configBasisIso (n + 1) s) (configBasisIso (n + 1) (negSpinConf s))
            * ((u (configBasisIso (n + 1) (negSpinConf s)) : ℝ) : ℂ) := by
          rw [ofReal_epsilonReal_apply]                             -- `def_epsilon_real`
      _ = 1 * ((u (configBasisIso (n + 1) (negSpinConf s)) : ℝ) : ℂ) := by
          rw [epsilon_entries_in_row_configuration_numbering (Nat.le_add_left 1 n), if_pos rfl]
                                                                    -- `epsilon_entries_in_row_configuration_numbering`（`s' → -s`）
      _ = ((u (configBasisIso (n + 1) (negSpinConf s)) : ℝ) : ℂ) := one_mul _
                                                                    -- `complex_numbers_form_a_field` の積の単位元
  apply inclusion_rr_to_cc_is_injective                             -- `a → (ε_ℝu)_{ord(s)}`, `b → u_{ord(-s)}`
  calc (((epsilonReal n *ᵥ u) (configBasisIso (n + 1) s) : ℝ) : ℂ)
      = ((∑ l, epsilonReal n (configBasisIso (n + 1) s) l * u l : ℝ) : ℂ) := rfl
                                                                    -- `def_real_matrix_vector_product`（`i → ord(s)`）
    _ = ((∑ l, r l : ℝ) : ℂ) := rfl                                 -- `y_l` の置き方を `d` 個の項へ
    _ = ∑ l, ((r l : ℝ) : ℂ) := (real_inclusion_of_finite_sum_fintype _).symm -- `real_inclusion_preserves_finite_sum` を右辺から左辺へ
    _ = ((r (configBasisIso (n + 1) (negSpinConf s)) : ℝ) : ℂ) :=
        Finset.sum_eq_single _ (fun l _ hl => hoff l hl)
          (fun h => absurd (Finset.mem_univ _) h)                   -- `finite_sum_with_single_nonzero_term`（`n → ord(-s)`）
    _ = ((u (configBasisIso (n + 1) (negSpinConf s)) : ℝ) : ℂ) := hon
                                                                    -- 上で示した `(y_{ord(-s)})_ℂ = (u_{ord(-s)})_ℂ`

end Ising2D
