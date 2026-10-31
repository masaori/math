/-
# `c_+(M_col) = Λ^{(1/2)}_{M_col}`、`Λ^{(1/2)}_{M_col} ≤ c(M_col) ≤ 2Λ^{(1/2)}_{M_col}` と 2 重極限の閉形式

対応する人手証明（正本は `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`）:

* `column_limit_and_closed_form_claim_c_plus_sandwich_and_double_limit`
  （ラベル **`c_plus_value_c_sandwich_and_double_limit_of_log_Z`**）

主張（`K_1, K_2 > 0`、`M_col ≥ 2`。`W = V_1^{1/2}V_2V_1^{1/2}`）:

1. `c_+(M_col) = sup{xᵀWx | x ∈ 𝓕^{(+)} ∩ ℝ^{2^{M_col}}, ‖x‖ = 1} = Λ^{(1/2)}_{M_col}`
2. `Λ^{(1/2)}_{M_col} ≤ c(M_col) ≤ 2Λ^{(1/2)}_{M_col}`
3. `lim_{M_col→∞} lim_{N_row→∞} (1/(M_col N_row)) log Z = (1/2)log(2 sinh 2K_2) + (1/4π)∫₀^{2π} γ(θ)dθ`

`W` は `physicalSymTransferR M K_1 K_2`、`c(M_col)` は `rayleighSup W`、`c_+(M_col)` は
`evenSectorRayleighSup W (epsilonR M)`、`Z` は `partitionFunction N_row M K_1 K_2` である。

## 人手証明との対応

- (1): 人手 `c_plus_equals_Lambda_half_integer`（`EvenSectorBridge.c_plus_equals_lamMax` を具体的な `W` の橋渡し
  `physicalEvenSectorBridge` に適用し、`EvenSectorBridge.lamMax_eq_LambdaM` で `Λ̌_max = Λ^{(1/2)}_M` に読み替える）
- (2): 人手 `c_between_Lambda_half_and_twice_Lambda_half`（`rayleighSup_sandwich_LambdaM_physical`）
- (3): 人手 `onsager_exact_solution`（`onsager_exact_solution_unconditional`）

## 仮定

入力は結合定数の組 `P : IsingParam`（`K_1, K_2 > 0`）だけである（`onsager_exact_solution_unconditional` と同じ）。

人手の主張は既存の主張を並べるだけなので、必要十分版は置かない
（(2) の上からの評価の必要十分版は `Ising2D/NecSuf/EvenSectorUpperBound.lean`、(3) の挟み撃ちと
Riemann 和は `Ising2D/NecSuf/LogSqueeze.lean`・`Ising2D/NecSuf/RiemannSum.lean` が持つ）。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.TheoremOnsagerUnconditional

namespace Ising2D

open Filter
open scoped Topology

/-- **人手 `c_plus_value_c_sandwich_and_double_limit_of_log_Z` の (1)**:
`c_+(M_col) = Λ^{(1/2)}_{M_col}`（人手 `c_plus_equals_Lambda_half_integer`）。仮定は `M_col ≥ 2` だけ。 -/
theorem c_plus_eq_LambdaM_half_physical (P : IsingParam) {M : ℕ} (hM2 : 2 ≤ M) :
    evenSectorRayleighSup (physicalSymTransferR M P.K1 P.K2) (epsilonR M) = LambdaM P (1 / 2) M :=
  have hM : M ≠ 0 := by omega
  calc evenSectorRayleighSup (physicalSymTransferR M P.K1 P.K2) (epsilonR M)
      = (vPlusDataOf P hM P.c2_mul_s2star_eq_c2star).lamMax :=
        (physicalEvenSectorBridge P hM2 hM).c_plus_equals_lamMax (trace_epsilon_vPlusDataOf_pos P hM2 hM)
    _ = LambdaM P (1 / 2) M := EvenSectorBridge.lamMax_eq_LambdaM P rfl (sum_checkGam P M)

/-- **人手 `c_plus_value_c_sandwich_and_double_limit_of_log_Z`**:
(1) `c_+(M_col) = Λ^{(1/2)}_{M_col}`、(2) `Λ^{(1/2)}_{M_col} ≤ c(M_col) ≤ 2Λ^{(1/2)}_{M_col}`、
(3) `(1/(M_col N_row)) log Z` の 2 重極限が Onsager の表式に等しい。 -/
theorem c_plus_value_c_sandwich_and_double_limit_of_log_Z (P : IsingParam) :
    (∀ m : ℕ, 2 ≤ m →
        evenSectorRayleighSup (physicalSymTransferR m P.K1 P.K2) (epsilonR m) = LambdaM P (1 / 2) m)
      ∧ (∀ m : ℕ, 2 ≤ m →
          LambdaM P (1 / 2) m ≤ rayleighSup (physicalSymTransferR m P.K1 P.K2)
            ∧ rayleighSup (physicalSymTransferR m P.K1 P.K2) ≤ 2 * LambdaM P (1 / 2) m)
      ∧ (∀ m : ℕ, 2 ≤ m →
          Tendsto (fun N : ℕ => 1 / ((m : ℝ) * N) * Real.log (partitionFunction N m P.K1 P.K2))
            atTop (𝓝 (1 / (m : ℝ) * Real.log (rayleighSup (physicalSymTransferR m P.K1 P.K2)))))
      ∧ Tendsto (fun m : ℕ => 1 / (m : ℝ) * Real.log (rayleighSup (physicalSymTransferR m P.K1 P.K2)))
          atTop
          (𝓝 (1 / 2 * Real.log (2 * Real.sinh (2 * P.K2))
            + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi), gammaFn P θ)) :=
  -- (1): 人手 c_plus_equals_Lambda_half_integer
  ⟨fun _ hm => c_plus_eq_LambdaM_half_physical P hm,
  -- (2): 人手 c_between_Lambda_half_and_twice_Lambda_half
   fun _ hm => rayleighSup_sandwich_LambdaM_physical P hm,
  -- (3): 人手 onsager_exact_solution
   (onsager_exact_solution_unconditional P).1, (onsager_exact_solution_unconditional P).2⟩

end Ising2D
