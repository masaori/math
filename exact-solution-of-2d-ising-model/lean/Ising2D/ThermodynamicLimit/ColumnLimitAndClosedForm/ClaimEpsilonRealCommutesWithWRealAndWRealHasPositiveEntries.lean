/-
# `W_ℝ` の成分はすべて正、`ε_ℝW_ℝ = W_ℝε_ℝ`

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

* `maxeig_claim_W_real_has_positive_entries`（ラベル **`W_real_has_positive_entries`**）
* `maxeig_claim_epsilon_real_commutes_with_W_real`（ラベル **`epsilon_real_commutes_with_W_real`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `W_has_positive_entries` の言い換えの形「すべての `k, l` について `W_kl > 0`、すなわち `W_kl = w_ℂ` を満たす `w ∈ ℝ_{>0}` が在る」（人手の最後の段: `μ ↦ ν(ι(μ))` の全単射性で `k = ν(ι(λ))`・`l = ν(ι(λ'))` と書き、主張を `(λ, λ')` で使う） | `W_has_positive_entries_as_inclusion` |
| `W_real_has_positive_entries` の 2 行の鎖 `((W_ℝ)_kl)_ℂ = W_kl = w_ℂ` と `inclusion_rr_to_cc_is_injective`（`a → (W_ℝ)_kl`, `b → w`）、`w > 0` | `W_real_has_positive_entries` の `calc` の 2 段と結び |
| `epsilon_real_commutes_with_W_real` の 3 行の鎖 `ε_ℝW_ℝ = ϱ(εW) = ϱ(Wε) = W_ℝε_ℝ` | `epsilon_real_commutes_with_W_real` の `calc` の 3 段 |

- 人手の `W_ℝ` は `realMatrixOfRealEntries (physicalSymTransferC …) (physicalSymTransferC_hasRealEntries …)`（`def_W_real`）、
  人手の `ε_ℝ` は `epsilonReal n`（`def_epsilon_real`、人手の `M_col` は `n + 1`）である。
- 人手の `W_has_positive_entries` の主張の形（複素行列 `W` の `ι(μ), ι(μ')` 成分が `w_ℂ`、`w ∈ ℝ_{>0}`）は
  `ClaimPhysicalWHasPositiveEntries.lean` の `W_has_positive_entries`。`W_has_positive_entries_as_inclusion` は、
  人手の最後の段どおり `configBasisIso` の全射性で `k = ι(λ)`・`l = ι(λ')` と書き、それを `(λ, λ')` で引く。
- 人手の `εW = Wε`（`epsilon_commutes_with_W`。複素行列の等式）は Lean の `epsilon_commute_physicalSymTransferC`。
  Lean の `epsilon_commutes_with_W` は同じ内容を実成分で組んだ `epsilonR`・`physicalSymTransferR` について述べたもので、
  人手の `ϱ` を経由する形と 1 対 1 なのは本ファイルの `epsilon_real_commutes_with_W_real` である。

- 人手はどちらの主張も `M_col ∈ ℤ_{≥1}`・`K_1, K_2 ∈ ℝ_{>0}` を置き、Lean も同じ仮定を取る。`W_ℝ` を作るのに要るのは
  `K_2 > 0` だけ（`physicalSymTransferC_hasRealEntries`）で、`W_real_has_positive_entries` は `K_1, K_2 > 0` を
  `W_has_positive_entries_as_inclusion`（人手 `W_has_positive_entries` と同じ `K_1, K_2 > 0` を取る）へ渡す。
  `M_col ≥ 1` は、`W_real_has_positive_entries` では `_hM : 1 ≤ M` で受け、`epsilon_real_commutes_with_W_real` では
  `ε_ℝ`（`epsilonReal n`）の側が `M_col = n + 1` で持つ。どちらの証明も `M_col ≥ 1` を使わない。`K_1 > 0` は下へ渡すだけで、最後に受ける `W_has_positive_entries_physical` も
  `_hK1` として受けて使わない。

必要十分版は置かない。どちらの主張も、引いた主張（`W_has_positive_entries`・`epsilon_commutes_with_W`・
`real_matrix_of_real_entry_matrix_preserves_product`・`inclusion_rr_to_cc_is_injective`）を成分ごと、または 1 回ずつ当てることに尽き、
それらの外に抽象的な内容を持たない（`W_real_is_symmetric`・`epsilon_real_square_is_identity` と同じ）。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealIsSymmetricAndSquareIsIdentity
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonCommutesWithW
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimPhysicalWHasPositiveEntries
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.PhysicalPartitionFunctionSandwich

namespace Ising2D

open Matrix

/-- **人手 `W_has_positive_entries` の言い換えの形**: すべての `k, l` について `W_kl > 0`、すなわち
`W_kl = w_ℂ` を満たす `w ∈ ℝ_{>0}` が在る（人手の主張文の「`z > 0`」の読み方）。
人手の最後の段: `μ ↦ ν(ι(μ))` は全単射（`config_numbering_equals_kronecker_numbering`・`row_configuration_numbering_bijective`。
Lean では `configBasisIso` の全射性）なので `k = ι(λ)`・`l = ι(λ')` と書け、`W_has_positive_entries` を `(μ, μ') := (λ, λ')`（Lean の `lam`・`lam'`）で引く。 -/
theorem W_has_positive_entries_as_inclusion {M : ℕ} {K1 K2 : ℝ} (hK1 : 0 < K1) (hK2 : 0 < K2) (k l : Conf M) :
    ∃ w : ℝ, 0 < w ∧ physicalSymTransferC M K1 K2 k l = (w : ℂ) := by
  obtain ⟨lam, rfl⟩ := (configBasisIso M).surjective k
  obtain ⟨lam', rfl⟩ := (configBasisIso M).surjective l
  exact W_has_positive_entries hK1 hK2 lam lam'

/-- **人手 `W_real_has_positive_entries`**: `W_ℝ`（`def_W_real`）のすべての成分は `ℝ` の順序で正。
`W_has_positive_entries` の `w` を取り、2 行の鎖 `((W_ℝ)_kl)_ℂ = W_kl = w_ℂ` に `inclusion_rr_to_cc_is_injective`
（`a → (W_ℝ)_kl`, `b → w`）を当てて `(W_ℝ)_kl = w > 0`。 -/
theorem W_real_has_positive_entries {M : ℕ} (_hM : 1 ≤ M) {K1 K2 : ℝ} (hK1 : 0 < K1) (hK2 : 0 < K2)
    (k l : Conf M) :
    0 < realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
      (physicalSymTransferC_hasRealEntries K1 hK2) k l := by
  obtain ⟨w, hw, hW⟩ := W_has_positive_entries_as_inclusion (M := M) hK1 hK2 k l
  have h : realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
      (physicalSymTransferC_hasRealEntries K1 hK2) k l = w :=
    inclusion_rr_to_cc_is_injective <|
      calc ((realMatrixOfRealEntries (physicalSymTransferC M K1 K2)
              (physicalSymTransferC_hasRealEntries K1 hK2) k l : ℝ) : ℂ)
          = physicalSymTransferC M K1 K2 k l :=
            ofReal_realMatrixOfRealEntries_apply _ _ k l                       -- `def_W_real`
        _ = (w : ℂ) := hW                                                     -- `w` の取り方（`W_has_positive_entries`）
  rw [h]
  exact hw                                                                    -- `w ∈ ℝ_{>0}`

/-- **人手 `epsilon_real_commutes_with_W_real`**: `ε_ℝW_ℝ = W_ℝε_ℝ`（人手の `M_col` は `n + 1`、`d := 2^{M_col}`）。
準備（`ε, W ∈ Mat^re`、`ε_ℝ = ϱ(ε)`、`W_ℝ = ϱ(W)`）は `epsilonReal` の定義と `epsilon_hasRealEntries`・`physicalSymTransferC_hasRealEntries`。
人手の `εW = Wε`（`epsilon_commutes_with_W`）は Lean の `epsilon_commute_physicalSymTransferC`。 -/
theorem epsilon_real_commutes_with_W_real (n : ℕ) {K1 K2 : ℝ} (_hK1 : 0 < K1) (hK2 : 0 < K2) :
    epsilonReal n * realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2)
        (physicalSymTransferC_hasRealEntries K1 hK2)
      = realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2) * epsilonReal n :=
  calc epsilonReal n * realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2)
      = realMatrixOfRealEntries (epsilon (n + 1) * physicalSymTransferC (n + 1) K1 K2)
          (matrix_mul_hasRealEntries _ _ (epsilon_hasRealEntries n)
            (physicalSymTransferC_hasRealEntries K1 hK2)) :=
        (real_matrix_of_real_entry_matrix_preserves_product _ _
          (epsilon_hasRealEntries n) (physicalSymTransferC_hasRealEntries K1 hK2)).symm
                                                                            -- `real_matrix_of_real_entry_matrix_preserves_product`（`A → ε`, `B → W`）を右辺から左辺へ
    _ = realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2 * epsilon (n + 1))
          (matrix_mul_hasRealEntries _ _ (physicalSymTransferC_hasRealEntries K1 hK2)
            (epsilon_hasRealEntries n)) :=
        realMatrixOfRealEntries_congr (epsilon_commute_physicalSymTransferC K1 hK2).eq _ _
                                                                            -- `epsilon_commutes_with_W` の `εW = Wε`
    _ = realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2)
          (physicalSymTransferC_hasRealEntries K1 hK2) * epsilonReal n :=
        real_matrix_of_real_entry_matrix_preserves_product _ _
          (physicalSymTransferC_hasRealEntries K1 hK2) (epsilon_hasRealEntries n)
                                                                            -- `real_matrix_of_real_entry_matrix_preserves_product`（`A → W`, `B → ε`）

end Ising2D
