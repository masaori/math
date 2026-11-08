/-
# `Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col} c(M_col)^n`（具体版）

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
（`maxeig_008a_claim_trace_power_upper_bound`、ラベル **`trace_power_upper_bound`**）

必要十分版: `Ising2D.NecSuf.IsPsdPair.moment_le_pow`（`Ising2D/NecSuf/RayleighMoments.lean`）。
各 `k` の評価 `e_k^⊤(W_ℝ)^ne_k ≤ c^n` の部分を、内積と自己共役な線型写像の組へ上げたもので、手順は同じ
（偶数 `n = 2a` は `‖W^ax‖^2 ≤ c^{2a}‖x‖^2`、奇数 `n = 2a+1` は `u := W^ax` について `⟪u, Wu⟫ ≤ c⟪u, u⟫ ≤ c·c^{2a}⟪x, x⟫`。
人手の【冪の対称性】と成分の鎖で `e_k^⊤(W_ℝ)^{2a}e_k = ‖u‖^2`・`e_k^⊤(W_ℝ)^{2a+1}e_k = u^⊤W_ℝu` に着く段は、
必要十分版では自己共役性から出る `moment_split`（`⟪x, W^{p+q}x⟫ = ⟪W^px, W^qx⟫`）である）。
具体版と同じ主張を必要十分版の特殊化として得ることは `ClaimTracePowerUpperBoundFromNecSuf.lean` の `trace_power_upper_bound_of_necSuf` が記録している。
必要十分版は半正定値性と `c ≥ 0` だけで通る。具体版の `hpd`（正定値性）は、人手が引く `rayleigh_bounds_operator_norm` と
`c ∈ ℝ_{>0}`（`def_rayleigh_sup`）の仮定から来ており、この主張そのものには要らない。
トレース（対角成分の和）の段は有限の添字と `ℝ` の順序に固有なので、必要十分版を置かない（`Σ_k c^n = ι(d)c^n`・`ι(2^{M_col}) = 2^{M_col}` の段が引く主張の必要十分版は `Ising2D/NecSuf/NaturalNumberCastIntoSemiring.lean`）。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: `e_k`（`(e_k)_k = 1`、`i ≠ k` で `(e_k)_i = 0`） | `Pi.single k 1`（成分は `Pi.single_eq_same`・`Pi.single_eq_of_ne`） |
| 【`e_k` のノルム】`i ≠ k` の `|(e_k)_i|^2` の 3 行の鎖とノルムの 7 行 | `norm_of_standard_basis_vector` の `hoff` の `calc` の 3 段と `calc` の 7 段 |
| 【冪の実数の行列】`(W^p)_ℝ = (W_ℝ)^p` | `real_matrix_of_real_entry_matrix_preserves_power`（`A → W`, `q → p`）をそのまま引く |
| 【冪の対称性】6 行と単射性 | `power_of_W_real_entry_symm` の `calc` の 6 段と `inclusion_rr_to_cc_is_injective` |
| 【対角成分の表示】5 行 | `diagonal_entry_via_standard_basis` の `calc` の 5 段 |
| 【`(W_ℝ)^ae_k` の成分とノルム】成分の 3 行 | `power_of_W_real_mulVec_standard_basis_apply` の `calc` の 3 段 |
| 同じ段のノルムの 3 行 | `norm_power_of_W_real_mulVec_standard_basis_le` の `calc` の 3 段 |
| 同じ段の平方の 2 行 | `norm_sq_power_of_W_real_mulVec_standard_basis_le` の `calc` の 2 段 |
| 偶数: `(W_ℝ)^{2a} = (W_ℝ)^a(W_ℝ)^a` の 5 行 | `power_of_W_real_even_split` の `calc` の 5 段 |
| 偶数: `e_k^⊤(W_ℝ)^{2a}e_k ≤ c^n` の 9 行 | `diagonal_bound_even` の `calc` の 9 段 |
| 奇数: `W^{2a+1} = W^a(WW^a)`（`Mat(d,ℂ)`）の 7 行 | `power_of_W_odd_split` の `calc` の 7 段 |
| 奇数: `(W_ℝ)^{2a+1} = (W_ℝ)^a(W_ℝ(W_ℝ)^a)` の 5 行 | `power_of_W_real_odd_split` の `calc` の 5 段 |
| 奇数: `e_k^⊤(W_ℝ)^{2a+1}e_k ≤ c^n` の 12 行 | `diagonal_bound_odd` の `calc` の 12 段 |
| 最後のトレースの 5 行 | `trace_power_upper_bound` の `calc` の 5 段（`Σ_k c^n = ι(d)c^n` は `finite_sum_of_constant_real_number_fintype`、`ι(2^{M_col}) = 2_ℝ^{M_col}` は `inclusion_zz_to_rr_of_power_of_two`。人手の `ι_{ℤ→ℝ}` は Lean の `Nat.cast`） |

- 人手の `W ∈ Mat(d,ℂ)` は Lean の `W : TensorPow M`（添字 `Conf M`、`d = 2_ℤ^M` は `ℕ` の等式 `card_conf_nat`、`d ∈ ℤ_{≥1}` は `power_of_two_in_integers_is_at_least_one`）である。
  一般の `W` で述べ、人手が引く主張を仮定に置く: `hW` は `W_is_real_symmetric_positive_definite` の実対称性、
  `hWRsymm`・`hpd` は `rayleigh_bounds_operator_norm` が要る `W_real_is_symmetric`・`W_real_is_positive_definite`
  （`hpd` は `c ∈ ℝ_{>0}`（`def_rayleigh_sup`、Lean の `rayleighSup_pos`）にも使う）。具体的な `W` への当てはめは
  `PhysicalPartitionFunctionSandwich.lean` の `trace_power_upper_bound_physical`。
- 人手の `W_ℝ = ϱ(W)` は `realMatrixOfRealEntries W hW.1`、`(W^p)_ℝ` に渡す証明は `matrix_pow_hasRealEntries`、
  `(AB)_ℝ` に渡す証明は `matrix_mul_hasRealEntries` である（`ClaimRealMatrixOfRealEntryMatrixPreservesProductAndPower.lean`）。
  `A = B` から `A_ℝ = B_ℝ` を出す行は `realMatrixOfRealEntries_congr` で書く。
- 人手の `def_real_matrix_product`・`def_real_matrix_vector_product` は Lean の `Matrix _ _ ℝ` の `*`・`*ᵥ`（成分は和で `rfl`）、
  `def_real_bilinear_value` は `dotProduct_mulVec_eq_real_bilinear_value`、`‖·‖` は `vecNorm`（`def_matrix_norm` の `K = ℝ`）である。
- 人手の「`i ≠ k` の項は 0」の行は、mathlib の `Finset.sum_eq_single`（一つの項を除いて 0 の有限和はその項）で書く。
  本文に対応する主張は `finite_sum_with_single_nonzero_term`（係数 `ℂ`）で、`ℝ` の版は本文に無い。
- 人手の `ℝ` の冪の指数法則・平方の単調性は mathlib の `pow_mul`・`pow_succ'`・`pow_le_pow_left₀` で書く。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimOperatorBound
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimNormOfNormalizedRealVectorIsOne
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealMatrixOfRealEntryMatrixPreservesProductAndPower
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPowerOfRealSymmetricComplexMatrixIsRealSymmetric
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimInclusionOfIntegersIntoRealNumbers
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionConfigBasisIso
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSqrtOfRealOneIsOne

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 人手【`e_k` のノルム】: `i ≠ k` の `|(e_k)_i|^2 = 0`（3 行の鎖、`hoff`）と `‖e_k‖ = 1`（7 行）。 -/
theorem norm_of_standard_basis_vector (k : Conf M) : vecNorm (Pi.single k (1 : ℝ)) = 1 := by
  have hoff : ∀ i, i ≠ k → |(Pi.single k (1 : ℝ) : Conf M → ℝ) i| ^ 2 = 0 := fun i hi =>
    calc |(Pi.single k (1 : ℝ) : Conf M → ℝ) i| ^ 2
        = |(0 : ℝ)| ^ 2 := by rw [Pi.single_eq_of_ne hi]                    -- `i ≠ k` なので `(e_k)_i = 0`
      _ = (0 : ℝ) ^ 2 := by rw [abs_of_nonneg (le_refl (0 : ℝ))]            -- `def_real_absolute_value` の `0 ≥ 0` の場合 `|0| = 0`
      _ = 0 := zero_pow two_ne_zero                                         -- `ℝ` で `0^2 = 0`
  calc vecNorm (Pi.single k (1 : ℝ))
      = Real.sqrt (∑ i, |(Pi.single k (1 : ℝ) : Conf M → ℝ) i| ^ 2) := by
        rw [vecNorm, vecNormSq_eq_sum]
        simp only [square_of_real_absolute_value]                           -- `def_matrix_norm`（`K = ℝ`、`w → e_k`）。`square_of_real_absolute_value` は書き方の差を埋める段
    _ = Real.sqrt (∑ i, if i = k then |(Pi.single k (1 : ℝ) : Conf M → ℝ) k| ^ 2 else 0) := by
        congr 1
        refine Finset.sum_congr rfl fun i _ => ?_
        by_cases h : i = k
        · rw [if_pos h, h]
        · rw [if_neg h, hoff i h]                                           -- 上の `|(e_k)_i|^2 = 0`（`i ≠ k`）を `k` 以外の各項へ（`0 + ⋯ + 0 + |(e_k)_k|^2 + 0 + ⋯ + 0`）
    _ = Real.sqrt (|(Pi.single k (1 : ℝ) : Conf M → ℝ) k| ^ 2) := by
        rw [Finset.sum_ite_eq' Finset.univ k, if_pos (Finset.mem_univ k)]
                                                                            -- `ℝ` で `0 + a = a` と `a + 0 = a` を左から順に（`def_finite_sum_of_real_numbers`。具体版が無いので mathlib。`vecNorm_single` と同じ）
    _ = Real.sqrt (|(1 : ℝ)| ^ 2) := by rw [Pi.single_eq_same]              -- `(e_k)_k = 1`
    _ = Real.sqrt ((1 : ℝ) ^ 2) := by rw [abs_of_nonneg (zero_le_one' ℝ)]   -- `def_real_absolute_value` の `1 ≥ 0` の場合 `|1| = 1`
    _ = Real.sqrt 1 := by rw [power_of_real_one_is_one 2]                   -- `power_of_real_one_is_one`（`m → 2`）
    _ = 1 := sqrt_of_real_one_is_one                                        -- `sqrt_of_real_one_is_one`

section General

variable (W : TensorPow M) (hW : MatrixIsRealSymmetric W)

/-- 人手【冪の対称性】: `((W_ℝ)^p)_kl = ((W_ℝ)^p)_lk`（6 行の鎖と `inclusion_rr_to_cc_is_injective`）。 -/
theorem power_of_W_real_entry_symm (p : ℕ) (k l : Conf M) :
    (realMatrixOfRealEntries W hW.1 ^ p) k l = (realMatrixOfRealEntries W hW.1 ^ p) l k := by
  have hT : (W ^ p)ᵀ = W ^ p :=
    (power_of_real_symmetric_complex_matrix_is_real_symmetric W hW p).2    -- `power_of_real_symmetric_complex_matrix_is_real_symmetric`（`n → d`, `A → W`）
  apply inclusion_rr_to_cc_is_injective                                     -- `a → ((W_ℝ)^p)_kl`, `b → ((W_ℝ)^p)_lk`
  calc (((realMatrixOfRealEntries W hW.1 ^ p) k l : ℝ) : ℂ)
      = ((realMatrixOfRealEntries (W ^ p) (matrix_pow_hasRealEntries W hW.1 p) k l : ℝ) : ℂ) := by
        rw [real_matrix_of_real_entry_matrix_preserves_power W hW.1 p]      -- 【冪の実数の行列】の `(W^p)_ℝ = (W_ℝ)^p`
    _ = (W ^ p) k l := ofReal_realMatrixOfRealEntries_apply _ _ k l         -- `def_real_matrix_of_real_entry_matrix`（`B → W^p`）
    _ = (W ^ p)ᵀ k l := by rw [hT]                                          -- `(W^p)^⊤ = W^p`
    _ = (W ^ p) l k := rfl                                                  -- `def_matrix_transpose`
    _ = ((realMatrixOfRealEntries (W ^ p) (matrix_pow_hasRealEntries W hW.1 p) l k : ℝ) : ℂ) :=
        (ofReal_realMatrixOfRealEntries_apply _ _ l k).symm                 -- `def_real_matrix_of_real_entry_matrix`（`B → W^p`）
    _ = (((realMatrixOfRealEntries W hW.1 ^ p) l k : ℝ) : ℂ) := by
        rw [real_matrix_of_real_entry_matrix_preserves_power W hW.1 p]      -- 【冪の実数の行列】の `(W^p)_ℝ = (W_ℝ)^p`

/-- 人手【対角成分の表示】: `e_k^⊤(W_ℝ)^pe_k = ((W_ℝ)^p)_kk`（5 行）。 -/
theorem diagonal_entry_via_standard_basis (p : ℕ) (k : Conf M) :
    (Pi.single k (1 : ℝ)) ⬝ᵥ (realMatrixOfRealEntries W hW.1 ^ p) *ᵥ (Pi.single k (1 : ℝ))
      = (realMatrixOfRealEntries W hW.1 ^ p) k k := by
  set P := realMatrixOfRealEntries W hW.1 ^ p
  set e : Conf M → ℝ := Pi.single k 1 with he
  calc e ⬝ᵥ P *ᵥ e
      = ∑ i, ∑ j, e i * P i j * e j :=
        dotProduct_mulVec_eq_real_bilinear_value e e P                     -- `def_real_bilinear_value`（`P → (W_ℝ)^p`, `x, y → e_k`）
    _ = ∑ j, e k * P k j * e j := by
        rw [Finset.sum_eq_single k
          (fun i _ hik => by
            simp only [he, Pi.single_eq_of_ne hik, zero_mul, Finset.sum_const_zero])
          (fun h => absurd (Finset.mem_univ k) h)]                         -- `i ≠ k` の項は `(e_k)_i = 0` なので `0`
    _ = ∑ j, P k j * e j := by simp only [he, Pi.single_eq_same, one_mul]          -- `(e_k)_k = 1`
    _ = P k k * e k := by
        rw [Finset.sum_eq_single k
          (fun j _ hjk => by rw [he, Pi.single_eq_of_ne hjk, mul_zero])
          (fun h => absurd (Finset.mem_univ k) h)]                         -- `j ≠ k` の項は `(e_k)_j = 0` なので `0`
    _ = P k k := by rw [he, Pi.single_eq_same, mul_one]                     -- `(e_k)_k = 1`

/-- 人手【`(W_ℝ)^ae_k` の成分とノルム】の成分の 3 行: `u_l = ((W_ℝ)^a)_lk`（`u := (W_ℝ)^ae_k`）。 -/
theorem power_of_W_real_mulVec_standard_basis_apply (a : ℕ) (k l : Conf M) :
    ((realMatrixOfRealEntries W hW.1 ^ a) *ᵥ (Pi.single k (1 : ℝ))) l
      = (realMatrixOfRealEntries W hW.1 ^ a) l k := by
  set P := realMatrixOfRealEntries W hW.1 ^ a
  set e : Conf M → ℝ := Pi.single k 1 with he
  calc (P *ᵥ e) l
      = ∑ m, P l m * e m := rfl                                             -- `def_real_matrix_vector_product`（`P → (W_ℝ)^a`, `x → e_k`）
    _ = P l k * e k := by
        rw [Finset.sum_eq_single k
          (fun m _ hmk => by rw [he, Pi.single_eq_of_ne hmk, mul_zero])
          (fun h => absurd (Finset.mem_univ k) h)]                         -- `m ≠ k` の項は `(e_k)_m = 0` なので `0`
    _ = P l k := by rw [he, Pi.single_eq_same, mul_one]                     -- `(e_k)_k = 1`

/-- 人手 偶数の場合の 5 行: `(W_ℝ)^{2a} = (W_ℝ)^a(W_ℝ)^a`。 -/
theorem power_of_W_real_even_split (a : ℕ) :
    realMatrixOfRealEntries W hW.1 ^ (2 * a)
      = realMatrixOfRealEntries W hW.1 ^ a * realMatrixOfRealEntries W hW.1 ^ a :=
  calc realMatrixOfRealEntries W hW.1 ^ (2 * a)
      = realMatrixOfRealEntries (W ^ (2 * a)) (matrix_pow_hasRealEntries W hW.1 (2 * a)) :=
        (real_matrix_of_real_entry_matrix_preserves_power W hW.1 (2 * a)).symm  -- 【冪の実数の行列】（`p → 2a`）
    _ = realMatrixOfRealEntries (W ^ (a + a)) (matrix_pow_hasRealEntries W hW.1 (a + a)) :=
        realMatrixOfRealEntries_congr (by rw [Nat.two_mul]) _ _             -- `ℤ` で `2a = a + a`
    _ = realMatrixOfRealEntries (W ^ a * W ^ a)
          (matrix_mul_hasRealEntries _ _ (matrix_pow_hasRealEntries W hW.1 a)
            (matrix_pow_hasRealEntries W hW.1 a)) :=
        realMatrixOfRealEntries_congr (matrix_power_exponent_law W a a) _ _ -- `matrix_power_exponent_law`（`A → W`, `p, q → a`）
    _ = realMatrixOfRealEntries (W ^ a) (matrix_pow_hasRealEntries W hW.1 a)
          * realMatrixOfRealEntries (W ^ a) (matrix_pow_hasRealEntries W hW.1 a) :=
        real_matrix_of_real_entry_matrix_preserves_product _ _ _ _          -- `real_matrix_of_real_entry_matrix_preserves_product`（`A, B → W^a`）
    _ = realMatrixOfRealEntries W hW.1 ^ a * realMatrixOfRealEntries W hW.1 ^ a := by
        rw [real_matrix_of_real_entry_matrix_preserves_power W hW.1 a]      -- 【冪の実数の行列】（`p → a`）を二つの因子へ同時に

/-- 人手 奇数の場合の `Mat(d,ℂ)` の 7 行: `W^{2a+1} = W^a(WW^a)`。 -/
theorem power_of_W_odd_split (a : ℕ) : W ^ (2 * a + 1) = W ^ a * (W * W ^ a) :=
  calc W ^ (2 * a + 1)
      = W ^ (a + (1 + a)) := by rw [show 2 * a + 1 = a + (1 + a) by omega]  -- `ℤ` で `2a + 1 = a + (1 + a)`
    _ = W ^ a * W ^ (1 + a) := matrix_power_exponent_law W a (1 + a)       -- `matrix_power_exponent_law`（`p → a`, `q → 1 + a`）
    _ = W ^ a * (W ^ 1 * W ^ a) := by rw [matrix_power_exponent_law W 1 a]  -- `matrix_power_exponent_law`（`p → 1`, `q → a`）
    _ = W ^ a * (W ^ (0 + 1) * W ^ a) := by rw [Nat.zero_add]           -- `ℤ` で `1 = 0 + 1`
    _ = W ^ a * ((W ^ 0 * W) * W ^ a) := by rw [pow_succ W 0]               -- `def_exp` (1) の `A^{m+1} := A^mA`（`m = 0`）
    _ = W ^ a * ((1 * W) * W ^ a) := by rw [pow_zero]                       -- `def_exp` (1) の `A^0 := I`
    _ = W ^ a * (W * W ^ a) := by rw [identity_matrix_mul_tensorPow W]      -- `identity_matrix_is_left_unit_of_mat_mult`

/-- 人手 奇数の場合の 5 行: `(W_ℝ)^{2a+1} = (W_ℝ)^a(W_ℝ(W_ℝ)^a)`（`WW^a` の成分の実性と `(WW^a)_ℝ = W_ℝ(W^a)_ℝ` は
`real_matrix_of_real_entry_matrix_preserves_product`（`A → W`, `B → W^a`））。 -/
theorem power_of_W_real_odd_split (a : ℕ) :
    realMatrixOfRealEntries W hW.1 ^ (2 * a + 1)
      = realMatrixOfRealEntries W hW.1 ^ a
          * (realMatrixOfRealEntries W hW.1 * realMatrixOfRealEntries W hW.1 ^ a) := by
  have hWa := matrix_pow_hasRealEntries W hW.1 a
  have hWWa := matrix_mul_hasRealEntries W (W ^ a) hW.1 hWa
  calc realMatrixOfRealEntries W hW.1 ^ (2 * a + 1)
      = realMatrixOfRealEntries (W ^ (2 * a + 1)) (matrix_pow_hasRealEntries W hW.1 (2 * a + 1)) :=
        (real_matrix_of_real_entry_matrix_preserves_power W hW.1 (2 * a + 1)).symm  -- 【冪の実数の行列】（`p → 2a + 1`）
    _ = realMatrixOfRealEntries (W ^ a * (W * W ^ a)) (matrix_mul_hasRealEntries _ _ hWa hWWa) :=
        realMatrixOfRealEntries_congr (power_of_W_odd_split W a) _ _        -- 上の式変形
    _ = realMatrixOfRealEntries (W ^ a) hWa * realMatrixOfRealEntries (W * W ^ a) hWWa :=
        real_matrix_of_real_entry_matrix_preserves_product _ _ _ _          -- `real_matrix_of_real_entry_matrix_preserves_product`（`A → W^a`, `B → WW^a`）
    _ = realMatrixOfRealEntries (W ^ a) hWa
          * (realMatrixOfRealEntries W hW.1 * realMatrixOfRealEntries (W ^ a) hWa) := by
        rw [real_matrix_of_real_entry_matrix_preserves_product W (W ^ a) hW.1 hWa]
                                                                            -- `real_matrix_of_real_entry_matrix_preserves_product`（`A → W`, `B → W^a`）
    _ = realMatrixOfRealEntries W hW.1 ^ a
          * (realMatrixOfRealEntries W hW.1 * realMatrixOfRealEntries W hW.1 ^ a) := by
        rw [real_matrix_of_real_entry_matrix_preserves_power W hW.1 a]      -- 【冪の実数の行列】（`p → a`）を二か所へ同時に

variable (hWRsymm : (realMatrixOfRealEntries W hW.1).IsSymm)
  (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x)

include hWRsymm hpd

/-- 人手【`(W_ℝ)^ae_k` の成分とノルム】のノルムの 3 行: `‖u‖ ≤ c^a`。 -/
theorem norm_power_of_W_real_mulVec_standard_basis_le (a : ℕ) (k : Conf M) :
    vecNorm ((realMatrixOfRealEntries W hW.1 ^ a) *ᵥ (Pi.single k (1 : ℝ)))
      ≤ rayleighSup (realMatrixOfRealEntries W hW.1) ^ a := by
  set u := (realMatrixOfRealEntries W hW.1 ^ a) *ᵥ (Pi.single k (1 : ℝ)) with hu  -- `u := (W_ℝ)^ae_k`
  calc vecNorm u
      = vecNorm ((realMatrixOfRealEntries W hW.1 ^ a) *ᵥ (Pi.single k (1 : ℝ))) := by rw [hu]
                                                                            -- `u := (W_ℝ)^ae_k`
    _ ≤ rayleighSup (realMatrixOfRealEntries W hW.1) ^ a * vecNorm (Pi.single k (1 : ℝ)) :=
        rayleigh_bounds_operator_norm_pow hWRsymm hpd a _                   -- `rayleigh_bounds_operator_norm` の冪の主張（指数 `k → a`, `x → e_k`）
    _ = rayleighSup (realMatrixOfRealEntries W hW.1) ^ a := by
        rw [norm_of_standard_basis_vector, mul_one]                         -- 【`e_k` のノルム】

/-- 人手【`(W_ℝ)^ae_k` の成分とノルム】の平方の 2 行: `‖u‖^2 ≤ c^{2a}`。 -/
theorem norm_sq_power_of_W_real_mulVec_standard_basis_le (a : ℕ) (k : Conf M) :
    vecNorm ((realMatrixOfRealEntries W hW.1 ^ a) *ᵥ (Pi.single k (1 : ℝ))) ^ 2
      ≤ rayleighSup (realMatrixOfRealEntries W hW.1) ^ (2 * a) :=
  calc vecNorm ((realMatrixOfRealEntries W hW.1 ^ a) *ᵥ (Pi.single k (1 : ℝ))) ^ 2
      ≤ (rayleighSup (realMatrixOfRealEntries W hW.1) ^ a) ^ 2 :=
        pow_le_pow_left₀ (vecNorm_nonneg _)
          (norm_power_of_W_real_mulVec_standard_basis_le W hW hWRsymm hpd a k) 2
                                                                            -- `0 ≤ ‖u‖ ≤ c^a` と `ℝ_{≥0}` の平方の単調性
    _ = rayleighSup (realMatrixOfRealEntries W hW.1) ^ (2 * a) := by
        rw [← pow_mul, Nat.mul_comm]                                        -- `ℝ` の冪の指数法則

/-- 人手 偶数の場合 `n = 2a`（`a ≥ 1`）の 9 行: `e_k^⊤(W_ℝ)^{2a}e_k ≤ c^n`（Lean は `a = 0` も含めて述べる）。 -/
theorem diagonal_bound_even (n a : ℕ) (hn : n = 2 * a) (k : Conf M) :
    (Pi.single k (1 : ℝ)) ⬝ᵥ (realMatrixOfRealEntries W hW.1 ^ (2 * a)) *ᵥ (Pi.single k (1 : ℝ))
      ≤ rayleighSup (realMatrixOfRealEntries W hW.1) ^ n := by
  set WR := realMatrixOfRealEntries W hW.1 with hWR
  set u := (WR ^ a) *ᵥ (Pi.single k (1 : ℝ)) with hu                       -- `u := (W_ℝ)^ae_k`
  have hul : ∀ l, u l = (WR ^ a) l k :=
    power_of_W_real_mulVec_standard_basis_apply W hW a k                    -- 【`(W_ℝ)^ae_k` の成分とノルム】の `u_l = ((W_ℝ)^a)_lk`
  calc (Pi.single k (1 : ℝ)) ⬝ᵥ (WR ^ (2 * a)) *ᵥ (Pi.single k (1 : ℝ))
      = (WR ^ (2 * a)) k k := diagonal_entry_via_standard_basis W hW (2 * a) k  -- 【対角成分の表示】（`p → 2a`）
    _ = (WR ^ a * WR ^ a) k k := by rw [power_of_W_real_even_split W hW a]  -- 上の式変形
    _ = ∑ l, (WR ^ a) k l * (WR ^ a) l k := rfl                             -- `def_real_matrix_product`（`P, Q → (W_ℝ)^a`）
    _ = ∑ l, (WR ^ a) l k * (WR ^ a) l k :=
        Finset.sum_congr rfl fun l _ => by
          rw [power_of_W_real_entry_symm W hW a k l]                        -- 【冪の対称性】の `((W_ℝ)^a)_kl = ((W_ℝ)^a)_lk`
    _ = ∑ l, u l * u l := by simp only [hul]                                -- `u_l = ((W_ℝ)^a)_lk`
    _ = ∑ l, |u l| ^ 2 :=
        Finset.sum_congr rfl fun l _ => by
          rw [square_of_real_absolute_value, sq]                            -- `u_l ∈ ℝ` なので `u_lu_l = |u_l|^2`（`square_of_real_absolute_value`。人手は `def_real_absolute_value` を引く）
    _ = vecNorm u ^ 2 := (vecNorm_sq_eq_sum_abs_sq u).symm                  -- `def_matrix_norm` と `(√b)^2 = b`
    _ ≤ rayleighSup WR ^ (2 * a) :=
        norm_sq_power_of_W_real_mulVec_standard_basis_le W hW hWRsymm hpd a k  -- 【`(W_ℝ)^ae_k` の成分とノルム】の `‖u‖^2 ≤ c^{2a}`
    _ = rayleighSup WR ^ n := by rw [hn]                                    -- `n = 2a`

/-- 人手 奇数の場合 `n = 2a+1` の 12 行: `e_k^⊤(W_ℝ)^{2a+1}e_k ≤ c^n`。 -/
theorem diagonal_bound_odd (n a : ℕ) (hn : n = 2 * a + 1) (k : Conf M) :
    (Pi.single k (1 : ℝ)) ⬝ᵥ (realMatrixOfRealEntries W hW.1 ^ (2 * a + 1)) *ᵥ (Pi.single k (1 : ℝ))
      ≤ rayleighSup (realMatrixOfRealEntries W hW.1) ^ n := by
  set WR := realMatrixOfRealEntries W hW.1 with hWR
  set c := rayleighSup WR with hc
  have hc0 : 0 < c := rayleighSup_pos hpd                                   -- `c ∈ ℝ_{>0}`（`def_rayleigh_sup`）
  set u := (WR ^ a) *ᵥ (Pi.single k (1 : ℝ)) with hu                       -- `u := (W_ℝ)^ae_k`
  have hul : ∀ l, u l = (WR ^ a) l k :=
    power_of_W_real_mulVec_standard_basis_apply W hW a k                    -- 【`(W_ℝ)^ae_k` の成分とノルム】の `u_l = ((W_ℝ)^a)_lk`
  calc (Pi.single k (1 : ℝ)) ⬝ᵥ (WR ^ (2 * a + 1)) *ᵥ (Pi.single k (1 : ℝ))
      = (WR ^ (2 * a + 1)) k k := diagonal_entry_via_standard_basis W hW (2 * a + 1) k
                                                                            -- 【対角成分の表示】（`p → 2a + 1`）
    _ = (WR ^ a * (WR * WR ^ a)) k k := by rw [power_of_W_real_odd_split W hW a]  -- 上の式変形
    _ = ∑ l, (WR ^ a) k l * (WR * WR ^ a) l k := rfl                        -- `def_real_matrix_product`（`P → (W_ℝ)^a`, `Q → W_ℝ(W_ℝ)^a`）
    _ = ∑ l, (WR ^ a) k l * ∑ m, WR l m * (WR ^ a) m k := rfl               -- `def_real_matrix_product`（`P → W_ℝ`, `Q → (W_ℝ)^a`）
    _ = ∑ l, ∑ m, (WR ^ a) k l * WR l m * (WR ^ a) m k := by
        simp only [Finset.mul_sum, mul_assoc]                               -- 分配則と乗法の結合則
    _ = ∑ l, ∑ m, (WR ^ a) l k * WR l m * (WR ^ a) m k :=
        Finset.sum_congr rfl fun l _ => Finset.sum_congr rfl fun m _ => by
          rw [power_of_W_real_entry_symm W hW a k l]                        -- 【冪の対称性】の `((W_ℝ)^a)_kl = ((W_ℝ)^a)_lk`
    _ = ∑ l, ∑ m, u l * WR l m * u m := by simp only [hul]                  -- `u_l = ((W_ℝ)^a)_lk`, `u_m = ((W_ℝ)^a)_mk`
    _ = u ⬝ᵥ WR *ᵥ u := (dotProduct_mulVec_eq_real_bilinear_value u u WR).symm  -- `def_real_bilinear_value`（`P → W_ℝ`, `x, y → u`）
    _ ≤ c * vecNorm u ^ 2 := by
        rw [vecNorm_sq]; exact quad_le_rayleighSup_mul u                    -- `def_rayleigh_sup` の `x^⊤W_ℝx ≤ c‖x‖^2`（`x → u`）
    _ ≤ c * c ^ (2 * a) :=
        mul_le_mul_of_nonneg_left
          (norm_sq_power_of_W_real_mulVec_standard_basis_le W hW hWRsymm hpd a k) hc0.le
                                                                            -- 【`(W_ℝ)^ae_k` の成分とノルム】の `‖u‖^2 ≤ c^{2a}` と `c > 0`
    _ = c ^ (2 * a + 1) := (pow_succ' c (2 * a)).symm                       -- `ℝ` の冪の指数法則
    _ = c ^ n := by rw [hn]                                                 -- `n = 2a + 1`

/-- **人手 `trace_power_upper_bound`**: `n ≥ 1` について `Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col} c(M_col)^n`。
`n` の偶奇で各 `k` の `e_k^⊤(W_ℝ)^ne_k ≤ c^n` を出し、最後のトレースの 5 行で足し合わせる。
仮定 `1 ≤ n` は人手の主張に合わせて置いたもので、証明は使わない（`n = 0` でも `Σ_k (I_ℝ)_kk = 2^{M_col}` で成り立つ）。 -/
theorem trace_power_upper_bound {n : ℕ} (_hn : 1 ≤ n) :
    ∑ k, (realMatrixOfRealEntries W hW.1 ^ n) k k
      ≤ 2 ^ M * rayleighSup (realMatrixOfRealEntries W hW.1) ^ n := by
  set WR := realMatrixOfRealEntries W hW.1 with hWR
  set c := rayleighSup WR with hc
  have hbound : ∀ k : Conf M,
      (Pi.single k (1 : ℝ)) ⬝ᵥ (WR ^ n) *ᵥ (Pi.single k (1 : ℝ)) ≤ c ^ n := by
    intro k
    rcases Nat.even_or_odd' n with ⟨a, hna | hna⟩
    · rw [show WR ^ n = WR ^ (2 * a) by rw [hna]]
      exact diagonal_bound_even W hW hWRsymm hpd n a hna k                  -- `n = 2a` の場合
    · rw [show WR ^ n = WR ^ (2 * a + 1) by rw [hna]]
      exact diagonal_bound_odd W hW hWRsymm hpd n a hna k                   -- `n = 2a + 1` の場合
  calc ∑ k, (WR ^ n) k k
      = ∑ k, (Pi.single k (1 : ℝ)) ⬝ᵥ (WR ^ n) *ᵥ (Pi.single k (1 : ℝ)) :=
        Finset.sum_congr rfl fun k _ =>
          (diagonal_entry_via_standard_basis W hW n k).symm                 -- 【対角成分の表示】（`p → n`）を `d` 個の項へ同時に
    _ ≤ ∑ _k : Conf M, c ^ n :=
        finite_sum_of_real_numbers_is_monotone_fintype _ _ hbound           -- `finite_sum_of_real_numbers_is_monotone`（各 `k` は偶数・奇数の鎖）
    _ = (Fintype.card (Conf M) : ℝ) * c ^ n :=
        finite_sum_of_constant_real_number_fintype
          (by rw [card_conf_nat]; exact power_of_two_in_integers_is_at_least_one M) (c ^ n)
                                                                            -- `finite_sum_of_constant_real_number`（`m → d ∈ ℤ_{≥1}`, `r → c^n`）
    _ = ((2 ^ M : ℕ) : ℝ) * c ^ n := by rw [card_conf_nat]                  -- `d := 2_ℤ^{M_col}`
    _ = 2 ^ M * c ^ n := by rw [inclusion_zz_to_rr_of_power_of_two M]       -- `inclusion_zz_to_rr_of_power_of_two`（`M → M_col`）

end General

end Ising2D
