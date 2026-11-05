/-
# 1 次元開鎖の二つのスピン和と正値性（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`

| 人手 | Lean |
| --- | --- |
| `def_open_chain_spin_energy` の `E(s) = ∑_{m=1}^{M_col-1}s(m)s(m+1)` | `openChainEnergy` |
| 同 `E(s) ∈ ℤ` | `openChainEnergy_mem_int` |
| `open_chain_partition_sum` の Step 1 の `t_m(s) := s(m)s(m+1)` と `Φ(s) = (s(1); t_1(s),…,t_{M_col-1}(s))` | `bondSpin`・`openChainPhi` |
| 同 Step 1 の逆向きの手続き `s(1) := u`、`s(m+1) := s(m)τ_m` | `openChainPhiInv`・`openChainPhiInv_zero`・`openChainPhiInv_succ` |
| 同 Step 1 の「`Φ` は全単射」（`s(m)s(m) = 1` による同値と、手続きで作った `s` が元の組を与えること） | `openChainPhiEquiv` の `left_inv`・`right_inv` |
| 同 Step 1 の「両側の集合はともに `2^{M_col}` 個の元をもつ」 | 対応する補題は無い（全単射を逆写像で示すので、この文は使わない） |
| 同 Step 1 の `ς(e) := 2e - 1`、`ς(1) = 1`、`ς(0) = -1`、`ς` と `ε ↦ (ς(ε_1),…)` は全単射 | `varsigma`・`coe_varsigma_one`・`coe_varsigma_zero`・`varsigmaEquiv`・`varsigmaWordEquiv` |
| 同 Step 2 の準備の鎖（3 行）`exp(KE(s)) = … = Π_m exp(Kt_m(s))` | `exp_openChainEnergy_eq_prod_bondSpin`（同じ 3 段の calc） |
| 同 Step 2 の鎖（左辺と 10 行） | `open_chain_partition_sum`（印 `人手 1`〜`人手 10` の calc） |
| （運ぶ段。人手の行は無い）`{0,1}^r` の上の和を全体の上の `∑` で読む、`E(s)` を添字 `Fin (n + 1)` の和で読む | `binaryWordRealSum_eq_sum_univ`・`openChainEnergy_eq_sum_fin` |
| `open_chain_endpoint_product_sum` の Step 1（`open_chain_partition_sum` の Step 1 の `Φ` と `ς` を使う） | `openChainPhiEquiv`・`varsigmaWordEquiv` |
| 同 Step 2 の `M_col = 2` の鎖（3 行）`Π_{m=1}^{1}t_m(s) = t_1(s) = s(1)s(2) = s(1)s(M_col)` | `prod_bondSpin_of_two`（同じ 3 段の calc） |
| 同 Step 2 の `M_col ≥ 3` の鎖（4 行）`Π_{m=1}^{M_col-1}t_m(s) = ⋯ = s(1)s(M_col)` | `prod_bondSpin_of_ge_three`（同じ 4 段の calc。2 行目の「ℝ の乗法の可換性と結合性」は `prod_bondSpin_rearrange`）・二つの鎖をまとめた `prod_bondSpin_eq_first_mul_last` |
| 同 Step 2 の `exp(KE(s))` の鎖（3 行） | `exp_openChainEnergy_eq_prod_bondSpin`（`open_chain_partition_sum` の準備の鎖と同じ行） |
| 同 Step 2 の `s(M_col)s(1)exp(KE(s)) = ⋯ = Π_m(t_m(s)exp(Kt_m(s)))`（左辺と 4 行） | `endpoint_mul_exp_openChainEnergy_eq_prod`（同じ 4 段の calc） |
| 同 Step 2 の最後の鎖（左辺と 12 行） | `open_chain_endpoint_product_sum`（印 `人手 1`〜`人手 12` の calc） |
| `open_chain_spin_sums_positive` | `open_chain_partition_sum_pos`・`open_chain_endpoint_product_sum_pos` |
| `D0_G_diagonal_action` の `D_0f_{ι(s)}` の係数を `E(s)` で書いたもの（`trace_of_epsilon_V_plus` で使う） | `openChainD0_mulVec_basisVec_eq_energy` |

`openChainEnergy` の定義と二つの主張の型では、人手の列の添字 `{1,…,M_col}` は `Fin M`（人手の `m` が Lean の `(m : ℕ) + 1`）、
人手の `1` と `M_col` は `firstSite`・`lastSite`、人手の `m+1` は `nextSite m` である（証明の中の書き方は下の節の冒頭に書いた）。
`openChainEnergy` の開鎖の結合の添字 `{1,…,M_col-1}` は、
`openChainD0`・`openChainD0_mulVec_basisVec` と同じ「`(m : ℕ) + 1 ≠ M` なる `m : Fin M`」である。
`openChainEnergy` は `openChainD0_mulVec_basisVec` の係数と定義で一致する。

人手の `{-1,1}` 上の有限和 `∑_{t∈{-1,1}} f(t) = f(1) + f(-1)` は `sum_spinVal` である。

`open_chain_partition_sum` と `open_chain_endpoint_product_sum` は、2026-11-04 に書き換えた人手の Step 1・Step 2 と
同じ行で書いてある（結合の添字は `Fin (n + 1)`、人手の `M_col` は Lean の `n + 2`）。

この証明が使うのは、`Fin M` 上の自然数の算術、有限和・有限積の並べ替えと展開、実数の指数法則と
双曲線関数の定義・正値性である。仮定は人手の主張に合わせて残し、実際に効いているものは次のとおりである。
- `open_chain_partition_sum` の証明は、人手と同じく `M_col ≥ 2`（Lean の `M = n + 2`）で結合の添字を `Fin (n + 1)` に取る
  （主張そのものは `M_col = 1` でも成り立つ）。
- `open_chain_endpoint_product_sum` の証明は、人手と同じく `M_col ≥ 2` で結合の添字を `Fin (n + 1)` に取り、
  Step 2 を `M_col = 2` と `M_col ≥ 3` に分ける（主張そのものは `M_col = 1` でも成り立つ）。
- `open_chain_partition_sum_pos` の証明は `K > 0` を使わない（`cosh K > 0` は任意の `K` で成り立つ）。
値は実数である必要がなく、可換半環（端点因子の書き替えは可換モノイドと `s(m)s(m) = 1`）で足りるので、
必要十分版を `Ising2D/NecSuf/OpenChainSpinSum.lean` に置き、具体版をその系として
`Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimOpenChainSpinSumsFromNecSuf.lean` で導出した。
必要十分版は、二つの主張の最後の鎖のうち重みに依らない行（`Φ` と `ς` による付け替え、二項の和の有限積の展開、
`ς(1) = 1`・`ς(0) = -1`、`{-1,1}` の上の和）と、Step 2 の `M_col = 2`・`M_col ≥ 3` の鎖を、この具体版と同じ並びで踏む。
重みに固有の行と冪の行は、導出のファイルに具体版と同じ根拠で置く。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimRowConfigurationNumberingBijective
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionH1H2V1V2
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionConfigBasisIso
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimEpsilonD0GCommuteAndDiagonalAction
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbers
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSum
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfRealProducts

namespace Ising2D

open Finset Matrix

variable {M : ℕ}

/-! ## `{-1,1}` の上の計算 -/

/-- 人手の `{-1,1}` 上の有限和: `∑_{t∈{-1,1}} f(t) = f(1) + f(-1)`。 -/
theorem sum_spinVal (f : SpinVal → ℝ) :
    ∑ x : SpinVal, f x = f ⟨1, Or.inl rfl⟩ + f ⟨-1, Or.inr rfl⟩ := by
  rw [← spinIdxEquiv.symm.sum_comp, Fin.sum_univ_two]
  congr 2

/-- 人手の `s(m)s(m) = 1`。 -/
theorem spinVal_mul_self (a : SpinVal) : (a : ℝ) * (a : ℝ) = 1 := by
  rcases a.2 with h | h <;> rw [h] <;> norm_num

/-- `{-1,1}` の二元の積は `{-1,1}` の元（人手の `t_m = s(m)s(m+1) ∈ {-1,1}`）。 -/
def spinMul (a b : SpinVal) : SpinVal :=
  ⟨(a : ℝ) * (b : ℝ), by rcases a.2 with h | h <;> rcases b.2 with h' | h' <;> simp [h, h']⟩

@[simp] theorem coe_spinMul (a b : SpinVal) : ((spinMul a b : SpinVal) : ℝ) = (a : ℝ) * (b : ℝ) := rfl

/-! ## `def_open_chain_spin_energy` -/

/-- **人手 `def_open_chain_spin_energy`**: `E(s) := ∑_{m=1}^{M_col-1} s(m)s(m+1)`。 -/
noncomputable def openChainEnergy (s : SpinConf M) : ℝ :=
  ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M), (s m : ℝ) * (s (nextSite m) : ℝ)

/-- 人手 `def_open_chain_spin_energy` の `E(s) ∈ ℤ`。 -/
theorem openChainEnergy_mem_int (s : SpinConf M) : ∃ n : ℤ, openChainEnergy s = n := by
  have h : ∀ a : SpinVal, ∃ z : ℤ, (a : ℝ) = z := fun a => by
    rcases a.2 with h | h
    · exact ⟨1, by rw [h]; norm_num⟩
    · exact ⟨-1, by rw [h]; norm_num⟩
  choose z hz using h
  refine ⟨∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
    z (s m) * z (s (nextSite m)), ?_⟩
  rw [openChainEnergy, Int.cast_sum]
  exact Finset.sum_congr rfl fun m _ => by rw [Int.cast_mul, hz, hz]

/-- 人手 `D0_G_diagonal_action` の係数は `E(s)`: `D_0f_{ι(s)} = E(s)f_{ι(s)}`。 -/
theorem openChainD0_mulVec_basisVec_eq_energy (s : SpinConf M) :
    openChainD0 M *ᵥ basisVec (configBasisIso M s)
      = ((openChainEnergy s : ℝ) : ℂ) • basisVec (configBasisIso M s) :=
  openChainD0_mulVec_basisVec s

/-! ## `open_chain_partition_sum`（人手の Step 1・Step 2 と同じ行）

人手の `M_col` は Lean の `n + 2`、人手の結合の添字 `m = 1,…,M_col-1` は `m : Fin (n + 1)`（人手の `m` が Lean の
`(m : ℕ) + 1`）、人手の `s(m)`・`s(m+1)` は `s m.castSucc`・`s m.succ`、人手の `s(1)` は `s 0` である。
人手の有限和 `Σ_{m=1}^{M_col-1}`（`def_finite_sum_of_real_numbers`）と有限積 `Π_{m=1}^{M_col-1}`
（`def_finite_product_of_real_numbers`）は `Fin (n + 1)` の上の `∑`・`∏` で、`real_exp_of_finite_sum`・
`expansion_of_finite_product_of_two_term_sums_of_real` の添字の形（人手の `m`・`r` が Lean の `n + 1`）にそのまま合う。 -/

section OpenChainPartitionSum

variable {n : ℕ}

/-- 人手 Step 1 の `t_m(s) := s(m)s(m+1) ∈ {-1,1}`（`m = 1,…,M_col-1`）。 -/
def bondSpin (s : SpinConf (n + 2)) (m : Fin (n + 1)) : SpinVal :=
  spinMul (s m.castSucc) (s m.succ)

/-- 人手 Step 1 の `Φ(s) := (s(1); t_1(s),…,t_{M_col-1}(s))`。 -/
def openChainPhi (s : SpinConf (n + 2)) : SpinVal × (Fin (n + 1) → SpinVal) :=
  (s 0, bondSpin s)

/-- 人手 Step 1 の逆向きの手続き: `(u; τ_1,…,τ_{M_col-1})` から `s(1) := u`、`s(m+1) := s(m)τ_m` で順に定める。 -/
def openChainPhiInv (y : SpinVal × (Fin (n + 1) → SpinVal)) : SpinConf (n + 2) :=
  fun k => Fin.induction (motive := fun _ => SpinVal) y.1 (fun m sm => spinMul sm (y.2 m)) k

/-- 人手の `s(1) := u`。 -/
theorem openChainPhiInv_zero (y : SpinVal × (Fin (n + 1) → SpinVal)) : openChainPhiInv y 0 = y.1 := rfl

/-- 人手の `s(m+1) := s(m)τ_m`。 -/
theorem openChainPhiInv_succ (y : SpinVal × (Fin (n + 1) → SpinVal)) (m : Fin (n + 1)) :
    openChainPhiInv y m.succ = spinMul (openChainPhiInv y m.castSucc) (y.2 m) := rfl

/-- **人手 `open_chain_partition_sum` の Step 1**: `Φ` は全単射で、逆写像は `s(1) := u`、`s(m+1) := s(m)τ_m`。
`left_inv` は人手の「`s(m)s(m) = 1` なので `s(m+1) = s(m)τ_m` は `τ_m = s(m)s(m+1)` と同値」の `⇐`（`m` に関する帰納法）、
`right_inv` は人手の「この手続きで作った `s` は `Φ(s)` として元の組を与える」である。 -/
def openChainPhiEquiv : SpinConf (n + 2) ≃ SpinVal × (Fin (n + 1) → SpinVal) where
  toFun := openChainPhi
  invFun := openChainPhiInv
  left_inv s := by
    funext k
    induction k using Fin.induction with
    | zero => rfl                                       -- `s(1) := u = s(1)`
    | succ m ih =>
      apply Subtype.ext
      calc (openChainPhiInv (openChainPhi s) m.succ : ℝ)
          = (openChainPhiInv (openChainPhi s) m.castSucc : ℝ) * (bondSpin s m : ℝ) := by
            rw [openChainPhiInv_succ]; rfl              -- `s(m+1) := s(m)τ_m`（`τ_m → t_m(s)`）
        _ = (s m.castSucc : ℝ) * ((s m.castSucc : ℝ) * (s m.succ : ℝ)) := by
            rw [ih]; rfl                                -- 帰納法の仮定と `t_m(s) := s(m)s(m+1)`
        _ = ((s m.castSucc : ℝ) * (s m.castSucc : ℝ)) * (s m.succ : ℝ) :=
            (mul_assoc _ _ _).symm                      -- ℝ の乗法の結合性
        _ = (s m.succ : ℝ) := by
            rw [spinVal_mul_self, one_mul]              -- `s(m)s(m) = 1`
  right_inv y := by
    refine Prod.ext (openChainPhiInv_zero y) (funext fun m => Subtype.ext ?_)
    calc (bondSpin (openChainPhiInv y) m : ℝ)
        = (openChainPhiInv y m.castSucc : ℝ) * (openChainPhiInv y m.succ : ℝ) := rfl
                                                        -- `t_m(s) := s(m)s(m+1)`
      _ = (openChainPhiInv y m.castSucc : ℝ) * ((openChainPhiInv y m.castSucc : ℝ) * (y.2 m : ℝ)) := by
          rw [openChainPhiInv_succ]; rfl                -- `s(m+1) := s(m)τ_m`
      _ = ((openChainPhiInv y m.castSucc : ℝ) * (openChainPhiInv y m.castSucc : ℝ)) * (y.2 m : ℝ) :=
          (mul_assoc _ _ _).symm                        -- ℝ の乗法の結合性
      _ = (y.2 m : ℝ) := by
          rw [spinVal_mul_self, one_mul]                -- `s(m)s(m) = 1`

/-- 人手 Step 1 の `ς(e) := 2e - 1`（`{0,1} → {-1,1}`）。 -/
def varsigma (e : Fin 2) : SpinVal :=
  ⟨2 * ((e : ℕ) : ℝ) - 1, by fin_cases e <;> norm_num⟩

/-- 人手の `ς(1) = 1`。 -/
theorem coe_varsigma_one : (varsigma 1 : ℝ) = 1 := by
  simp only [varsigma]; norm_num

/-- 人手の `ς(0) = -1`。 -/
theorem coe_varsigma_zero : (varsigma 0 : ℝ) = -1 := by
  simp only [varsigma]; norm_num

/-- 人手 Step 1 の「`ς` は全単射」。逆写像は人手の `τ ↦ (τ+1)/2`（`1 ↦ 1`、`-1 ↦ 0`）で、Lean は値で場合を分けて書く。 -/
noncomputable def varsigmaEquiv : Fin 2 ≃ SpinVal where
  toFun := varsigma
  invFun τ := if (τ : ℝ) = 1 then 1 else 0
  left_inv e := by
    fin_cases e
    · show (if (varsigma 0 : ℝ) = 1 then (1 : Fin 2) else 0) = 0
      rw [coe_varsigma_zero, if_neg (by norm_num)]
    · show (if (varsigma 1 : ℝ) = 1 then (1 : Fin 2) else 0) = 1
      rw [coe_varsigma_one, if_pos rfl]
  right_inv τ := by
    apply Subtype.ext
    show (varsigma (if (τ : ℝ) = 1 then 1 else 0) : ℝ) = τ
    rcases τ.2 with h | h
    · rw [if_pos h, coe_varsigma_one, h]
    · rw [if_neg (by rw [h]; norm_num), coe_varsigma_zero, h]

/-- 人手 Step 1 の全単射 `ε ↦ (ς(ε_1),…,ς(ε_{M_col-1}))`（`{0,1}^{M_col-1} → {-1,1}^{M_col-1}`。成分ごとに `ς`）。 -/
noncomputable def varsigmaWordEquiv : (Fin (n + 1) → Fin 2) ≃ (Fin (n + 1) → SpinVal) :=
  Equiv.piCongrRight fun _ => varsigmaEquiv

/-- 運ぶ段（人手の行は無い）: 人手の `{0,1}^{r}` の上の和（`def_sum_over_binary_words_of_real_numbers`、Lean の
`binaryWordRealSum`）を、`Fin (r + 1) → Fin 2` の全体の上の `∑` で読む。人手の付け替えの行は値域の全体の上の和を
引き移すので、Lean の付け替え（`Equiv.sum_comp`）はこの形の和で行い、この補題で人手の和へ戻す。 -/
theorem binaryWordRealSum_eq_sum_univ :
    ∀ (r : ℕ) (x : (Fin (r + 1) → Fin 2) → ℝ), binaryWordRealSum r x = ∑ ε, x ε
  | 0, x => by
    rw [binaryWordRealSum_zero, ← (Equiv.funUnique (Fin 1) (Fin 2)).symm.sum_comp x, Fin.sum_univ_two, add_comm]
    rfl
  | r + 1, x => by
    rw [binaryWordRealSum_succ, binaryWordRealSum_eq_sum_univ r,
      ← (Fin.snocEquiv (fun _ => Fin 2)).sum_comp x, Fintype.sum_prod_type_right]
    refine Finset.sum_congr rfl fun ε' _ => ?_
    rw [Fin.sum_univ_two, add_comm]
    rfl

/-- 運ぶ段（人手の行は無い）: Lean の `openChainEnergy` は `openChainD0` の係数と揃えて `Fin M` の部分集合の上の和で
定めてあるので、人手 `def_open_chain_spin_energy` の `E(s) = Σ_{m=1}^{M_col-1} s(m)s(m+1)` の添字 `Fin (n + 1)` の形へ読む。 -/
theorem openChainEnergy_eq_sum_fin (s : SpinConf (n + 2)) :
    openChainEnergy s = ∑ m : Fin (n + 1), (s m.castSucc : ℝ) * (s m.succ : ℝ) := by
  rw [openChainEnergy, Finset.sum_filter, Fin.sum_univ_castSucc]
  have hlast : ¬(((Fin.last (n + 1) : Fin (n + 2)) : ℕ) + 1 ≠ n + 2) := by simp
  rw [if_neg hlast, add_zero]
  refine Finset.sum_congr rfl fun m _ => ?_
  have hm : ((Fin.castSucc m : Fin (n + 2)) : ℕ) + 1 ≠ n + 2 := by simp; omega
  have hnext : nextSite (Fin.castSucc m : Fin (n + 2)) = m.succ :=
    Fin.ext (by rw [nextSite_val_of_lt (by simp; omega)]; simp)
  rw [if_pos hm, hnext]

/-- 人手 `open_chain_partition_sum` の Step 2 の準備の鎖: `exp(KE(s)) = Π_{m=1}^{M_col-1} exp(Kt_m(s))`。 -/
theorem exp_openChainEnergy_eq_prod_bondSpin (K : ℝ) (s : SpinConf (n + 2)) :
    Real.exp (K * openChainEnergy s) = ∏ m : Fin (n + 1), Real.exp (K * (bondSpin s m : ℝ)) :=
  calc Real.exp (K * openChainEnergy s)
      = Real.exp (K * ∑ m : Fin (n + 1), (bondSpin s m : ℝ)) := by
        rw [openChainEnergy_eq_sum_fin]; rfl            -- `def_open_chain_spin_energy`（と上の運ぶ段）と `t_m(s) := s(m)s(m+1)`
    _ = Real.exp (∑ m : Fin (n + 1), K * (bondSpin s m : ℝ)) := by
        rw [finite_sum_of_real_scalar_multiples (n + 1) K]
                                                        -- ℝ の分配則を有限和の各項へ（`finite_sum_of_real_scalar_multiples` を右辺から左辺へ）
    _ = ∏ m : Fin (n + 1), Real.exp (K * (bondSpin s m : ℝ)) :=
        real_exp_of_finite_sum n _                      -- `real_exp_of_finite_sum`（`m → M_col-1`、`j → m`、`x_j → Kt_m(s)`）

end OpenChainPartitionSum

/-- **人手 `open_chain_partition_sum`**: `∑_{s∈𝔐} exp(KE(s)) = 2(2cosh K)^{M_col-1}`。
人手の Step 2 の鎖（左辺と 10 行）と、印 `人手 1`〜`人手 10` で 1 対 1 の `calc` である。人手の `M_col` は Lean の `n + 2`。 -/
theorem open_chain_partition_sum (hM : 2 ≤ M) (K : ℝ) :
    ∑ s : SpinConf M, Real.exp (K * openChainEnergy s) = 2 * (2 * Real.cosh K) ^ (M - 1) := by
  obtain ⟨n, rfl⟩ : ∃ n, M = n + 2 := ⟨M - 2, by omega⟩
  calc ∑ s : SpinConf (n + 2), Real.exp (K * openChainEnergy s)
      = ∑ s : SpinConf (n + 2), ∏ m : Fin (n + 1), Real.exp (K * (bondSpin s m : ℝ)) :=
        Finset.sum_congr rfl fun s _ => exp_openChainEnergy_eq_prod_bondSpin K s
                                                        -- 人手 1: 準備の等式を各項へ
    _ = ∑ u : SpinVal, ∑ τ : Fin (n + 1) → SpinVal, ∏ m : Fin (n + 1), Real.exp (K * (τ m : ℝ)) := by
        rw [← Fintype.sum_prod_type']
        exact openChainPhiEquiv.sum_comp (fun y => ∏ m : Fin (n + 1), Real.exp (K * (y.2 m : ℝ)))
                                                        -- 人手 2: Step 1 の全単射 `Φ` で和の添字を `s` から `(u; τ) = Φ(s)` へ付け替える
                                                        -- （`Fintype.sum_prod_type'` は組の上の和を `u` と `τ` の二重の和に読む運ぶ段）
    _ = ∑ u : SpinVal, binaryWordRealSum n
          (fun ε => ∏ m : Fin (n + 1), Real.exp (K * (varsigma (ε m) : ℝ))) := by
        refine Finset.sum_congr rfl fun u _ => ?_
        rw [binaryWordRealSum_eq_sum_univ]
        exact (varsigmaWordEquiv.sum_comp (fun τ => ∏ m : Fin (n + 1), Real.exp (K * (τ m : ℝ)))).symm
                                                        -- 人手 3: Step 1 の全単射 `ε ↦ (ς(ε_1),…)` で内側の和の添字を付け替える
                                                        -- （`binaryWordRealSum_eq_sum_univ` は上の運ぶ段）
    _ = ∑ u : SpinVal, ∏ m : Fin (n + 1),
          (Real.exp (K * (varsigma 1 : ℝ)) + Real.exp (K * (varsigma 0 : ℝ))) :=
        Finset.sum_congr rfl fun u _ =>
          (expansion_of_finite_product_of_two_term_sums_of_real n
            (fun _ e => Real.exp (K * (varsigma e : ℝ)))).symm
                                                        -- 人手 4: `expansion_of_finite_product_of_two_term_sums_of_real_numbers`
                                                        -- （`r → M_col-1`、`j → m`、`a_j^{(e)} → exp(Kς(e))`）を右辺から左辺へ、各 `u` の項へ
    _ = ∑ u : SpinVal, ∏ m : Fin (n + 1), (Real.exp (K * 1) + Real.exp (K * (-1))) := by
        rw [coe_varsigma_one, coe_varsigma_zero]        -- 人手 5: `ς(1) = 1`、`ς(0) = -1` を各因子へ
    _ = ∑ u : SpinVal, ∏ m : Fin (n + 1), (Real.exp K + Real.exp (K * (-1))) := by
        rw [mul_one]                                    -- 人手 6: ℝ で `a·1 = a` を各因子へ
    _ = ∑ u : SpinVal, ∏ m : Fin (n + 1), (Real.exp K + Real.exp (-K)) := by
        rw [mul_neg_one]                                -- 人手 7: ℝ で `a·(-1) = -a` を各因子へ
    _ = 2 * ∏ m : Fin (n + 1), (Real.exp K + Real.exp (-K)) := by
        rw [sum_spinVal, ← two_mul]                     -- 人手 8: `u` に依らない実数 `c` の `{-1,1}` 上の和は `c + c = 2c`
    _ = 2 * ∏ m : Fin (n + 1), (2 * Real.cosh K) := by
        rw [Real.cosh_eq, mul_div_cancel₀ _ (two_ne_zero : (2 : ℝ) ≠ 0)]
                                                        -- 人手 9: `def_cosh_sinh`（`x → K`）を各因子へ（`def_cosh_sinh` は Lean で
                                                        -- 定義し直していないので mathlib の `Real.cosh_eq`。人手の `2cosh K` を
                                                        -- `exp K + exp(-K)` へ戻す `2·(b/2) = b` を同じ段に置く）
    _ = 2 * (2 * Real.cosh K) ^ (n + 2 - 1) := by
        rw [Fin.prod_const]; rfl                        -- 人手 10: 主張の `x^n := Π_{j=1}^{n} x`（`x → 2cosh K`、`n → M_col-1`）。
                                                        -- 指数の `n + 2 - 1` は Lean の自然数の引き算で、`n + 1` と同じ数

/-! 以下、`open_chain_endpoint_product_sum` の Step 2 と本体の鎖を、`open_chain_partition_sum` と同じく人手の `M_col` を
Lean の `n + 2`、結合の添字を `Fin (n + 1)` で書く。人手の `s(1)` は `s 0`、`s(M_col)` は `s (Fin.last (n + 1))` である。 -/

section OpenChainEndpointProductSum

variable {n : ℕ}

/-- 人手 `open_chain_endpoint_product_sum` の Step 2 の `M_col = 2` の鎖（Lean の `n = 0`）:
`Π_{m=1}^{1}t_m(s) = t_1(s) = s(1)s(2) = s(1)s(M_col)`。 -/
theorem prod_bondSpin_of_two (s : SpinConf 2) :
    ∏ m : Fin 1, (bondSpin s m : ℝ) = (s 0 : ℝ) * (s (Fin.last 1) : ℝ) :=
  calc ∏ m : Fin 1, (bondSpin s m : ℝ)
      = (bondSpin s 0 : ℝ) := Fin.prod_univ_one _       -- `def_finite_product_of_real_numbers`（`m → 1`）
    _ = (s 0 : ℝ) * (s 1 : ℝ) := rfl                    -- `t_1(s) := s(1)s(2)`
    _ = (s 0 : ℝ) * (s (Fin.last 1) : ℝ) := rfl         -- `M_col = 2`（人手の `2` が Lean の `Fin.last 1`）

/-- 人手 `open_chain_endpoint_product_sum` の Step 2 の `M_col ≥ 3` の鎖の 2 行目の根拠「ℝ の乗法の可換性と結合性」
（人手の `M_col` は Lean の `k + 3`、中間の添字 `m = 2,…,M_col-1` は `j : Fin (k + 1)`（人手の `m` が Lean の `(j : ℕ) + 2`、
サイトは `j.succ.castSucc`））: `Π_{m=1}^{M_col-1}s(m)s(m+1) = s(1)(Π_{m=2}^{M_col-1}s(m)s(m))s(M_col)`。
人手の一段を、Lean では有限積の端の因子を外へ出す段（末尾の因子は `def_finite_product_of_real_numbers` の帰納の式
`Fin.prod_univ_castSucc`、先頭の因子は可換性と結合性から従う `Fin.prod_univ_succ`）と、因子の並べ替え
（`finite_product_of_real_products` と `mul_assoc`）に割って書く。 -/
theorem prod_bondSpin_rearrange (k : ℕ) (s : SpinConf (k + 3)) :
    ∏ m : Fin (k + 2), (s m.castSucc : ℝ) * (s m.succ : ℝ)
      = (s 0 : ℝ) * (∏ j : Fin (k + 1), (s j.succ.castSucc : ℝ) * (s j.succ.castSucc : ℝ))
          * (s (Fin.last (k + 2)) : ℝ) :=
  calc ∏ m : Fin (k + 2), (s m.castSucc : ℝ) * (s m.succ : ℝ)
      = (∏ m : Fin (k + 2), (s m.castSucc : ℝ)) * ∏ m : Fin (k + 2), (s m.succ : ℝ) :=
        finite_product_of_real_products (k + 1) _ _      -- 因子の並べ替え（`finite_product_of_real_products`）
    _ = ((s 0 : ℝ) * ∏ j : Fin (k + 1), (s j.succ.castSucc : ℝ))
          * ((∏ j : Fin (k + 1), (s j.castSucc.succ : ℝ)) * (s (Fin.last (k + 2)) : ℝ)) := by
        rw [Fin.prod_univ_succ (fun m : Fin (k + 2) => (s m.castSucc : ℝ)),
          Fin.prod_univ_castSucc (fun m : Fin (k + 2) => (s m.succ : ℝ))]
        rfl                                             -- 先頭の因子 `s(1)` と末尾の因子 `s(M_col)` を外へ出す
    _ = ((s 0 : ℝ) * ∏ j : Fin (k + 1), (s j.succ.castSucc : ℝ))
          * ((∏ j : Fin (k + 1), (s j.succ.castSucc : ℝ)) * (s (Fin.last (k + 2)) : ℝ)) := by
        simp only [Fin.succ_castSucc]                   -- 中間のサイト `m = 2,…,M_col-1` の二つの書き方を揃える
    _ = (s 0 : ℝ) * ((∏ j : Fin (k + 1), (s j.succ.castSucc : ℝ)) * ∏ j : Fin (k + 1), (s j.succ.castSucc : ℝ))
          * (s (Fin.last (k + 2)) : ℝ) := by
        rw [mul_assoc, mul_assoc, mul_assoc]            -- ℝ の乗法の結合性
    _ = (s 0 : ℝ) * (∏ j : Fin (k + 1), (s j.succ.castSucc : ℝ) * (s j.succ.castSucc : ℝ))
          * (s (Fin.last (k + 2)) : ℝ) := by
        rw [← finite_product_of_real_products k]        -- 因子の並べ替え（`finite_product_of_real_products` を右辺から左辺へ）

/-- 人手 `open_chain_endpoint_product_sum` の Step 2 の `M_col ≥ 3` の鎖（人手の `M_col` は Lean の `k + 3`）:
`Π_{m=1}^{M_col-1}t_m(s) = ⋯ = s(1)s(M_col)`（4 行）。 -/
theorem prod_bondSpin_of_ge_three (k : ℕ) (s : SpinConf (k + 3)) :
    ∏ m : Fin (k + 2), (bondSpin s m : ℝ) = (s 0 : ℝ) * (s (Fin.last (k + 2)) : ℝ) :=
  calc ∏ m : Fin (k + 2), (bondSpin s m : ℝ)
      = ∏ m : Fin (k + 2), (s m.castSucc : ℝ) * (s m.succ : ℝ) := rfl
                                                        -- `t_m(s) := s(m)s(m+1)`
    _ = (s 0 : ℝ) * (∏ j : Fin (k + 1), (s j.succ.castSucc : ℝ) * (s j.succ.castSucc : ℝ))
          * (s (Fin.last (k + 2)) : ℝ) :=
        prod_bondSpin_rearrange k s                     -- ℝ の乗法の可換性と結合性
    _ = (s 0 : ℝ) * (∏ _j : Fin (k + 1), (1 : ℝ)) * (s (Fin.last (k + 2)) : ℝ) := by
        rw [Finset.prod_congr rfl fun j _ => spinVal_mul_self (s j.succ.castSucc)]
                                                        -- `s(m)s(m) = 1` を各 `m` へ同時適用
    _ = (s 0 : ℝ) * (s (Fin.last (k + 2)) : ℝ) := by
        rw [Finset.prod_const_one, mul_one]             -- `1` の有限積は `1`（と `a·1 = a`）

/-- 人手 `open_chain_endpoint_product_sum` の Step 2 の `Π_{m=1}^{M_col-1}t_m(s) = s(1)s(M_col)`
（`M_col = 2` と `M_col ≥ 3` の二つの鎖。人手の `M_col` は Lean の `n + 2`）。 -/
theorem prod_bondSpin_eq_first_mul_last : ∀ {n : ℕ} (s : SpinConf (n + 2)),
    ∏ m : Fin (n + 1), (bondSpin s m : ℝ) = (s 0 : ℝ) * (s (Fin.last (n + 1)) : ℝ)
  | 0, s => prod_bondSpin_of_two s
  | k + 1, s => prod_bondSpin_of_ge_three k s

/-- 人手 `open_chain_endpoint_product_sum` の Step 2 の最後の鎖（左辺と 4 行）:
`s(M_col)s(1)exp(KE(s)) = ⋯ = Π_{m=1}^{M_col-1}(t_m(s)exp(Kt_m(s)))`。 -/
theorem endpoint_mul_exp_openChainEnergy_eq_prod (K : ℝ) (s : SpinConf (n + 2)) :
    (s (Fin.last (n + 1)) : ℝ) * (s 0 : ℝ) * Real.exp (K * openChainEnergy s)
      = ∏ m : Fin (n + 1), (bondSpin s m : ℝ) * Real.exp (K * (bondSpin s m : ℝ)) :=
  calc (s (Fin.last (n + 1)) : ℝ) * (s 0 : ℝ) * Real.exp (K * openChainEnergy s)
      = (s 0 : ℝ) * (s (Fin.last (n + 1)) : ℝ) * Real.exp (K * openChainEnergy s) := by
        rw [mul_comm (s (Fin.last (n + 1)) : ℝ)]        -- ℝ の乗法の可換性
    _ = (∏ m : Fin (n + 1), (bondSpin s m : ℝ)) * Real.exp (K * openChainEnergy s) := by
        rw [prod_bondSpin_eq_first_mul_last]            -- 上の等式（`prod_bondSpin_eq_first_mul_last`）を右辺から左辺へ
    _ = (∏ m : Fin (n + 1), (bondSpin s m : ℝ)) * ∏ m : Fin (n + 1), Real.exp (K * (bondSpin s m : ℝ)) := by
        rw [exp_openChainEnergy_eq_prod_bondSpin]       -- 上の `exp(KE(s))` の鎖
    _ = ∏ m : Fin (n + 1), (bondSpin s m : ℝ) * Real.exp (K * (bondSpin s m : ℝ)) :=
        (finite_product_of_real_products n _ _).symm   -- `finite_product_of_real_products`（`m → M_col-1`、`j → m`、
                                                        -- `x_j → t_m(s)`、`y_j → exp(Kt_m(s))`）を右辺から左辺へ

end OpenChainEndpointProductSum

/-- **人手 `open_chain_endpoint_product_sum`**:
`∑_{s∈𝔐} s(M_col)s(1) exp(KE(s)) = 2(2sinh K)^{M_col-1}`。
人手の最後の鎖（左辺と 12 行）と、印 `人手 1`〜`人手 12` で 1 対 1 の `calc` である。人手の `M_col` は Lean の `n + 2`。 -/
theorem open_chain_endpoint_product_sum (hM : 2 ≤ M) (K : ℝ) :
    ∑ s : SpinConf M, (s (lastSite M (by omega)) : ℝ) * (s (firstSite M (by omega)) : ℝ)
        * Real.exp (K * openChainEnergy s)
      = 2 * (2 * Real.sinh K) ^ (M - 1) := by
  obtain ⟨n, rfl⟩ : ∃ n, M = n + 2 := ⟨M - 2, by omega⟩
  calc ∑ s : SpinConf (n + 2), (s (lastSite (n + 2) (by omega)) : ℝ) * (s (firstSite (n + 2) (by omega)) : ℝ)
        * Real.exp (K * openChainEnergy s)
      = ∑ s : SpinConf (n + 2), ∏ m : Fin (n + 1), (bondSpin s m : ℝ) * Real.exp (K * (bondSpin s m : ℝ)) :=
        Finset.sum_congr rfl fun s _ => endpoint_mul_exp_openChainEnergy_eq_prod K s
                                                        -- 人手 1: 直前の等式を各項へ（人手の `s(M_col)`・`s(1)` は
                                                        -- `lastSite`・`firstSite` で、`Fin.last (n + 1)`・`0` と定義で一致）
    _ = ∑ u : SpinVal, ∑ τ : Fin (n + 1) → SpinVal, ∏ m : Fin (n + 1), (τ m : ℝ) * Real.exp (K * (τ m : ℝ)) := by
        rw [← Fintype.sum_prod_type']
        exact openChainPhiEquiv.sum_comp (fun y => ∏ m : Fin (n + 1), (y.2 m : ℝ) * Real.exp (K * (y.2 m : ℝ)))
                                                        -- 人手 2: Step 1 の全単射 `Φ` で和の添字を `s` から `(u; τ) = Φ(s)` へ付け替える
                                                        -- （`Fintype.sum_prod_type'` は組の上の和を `u` と `τ` の二重の和に読む運ぶ段）
    _ = ∑ u : SpinVal, binaryWordRealSum n
          (fun ε => ∏ m : Fin (n + 1), (varsigma (ε m) : ℝ) * Real.exp (K * (varsigma (ε m) : ℝ))) := by
        refine Finset.sum_congr rfl fun u _ => ?_
        rw [binaryWordRealSum_eq_sum_univ]
        exact (varsigmaWordEquiv.sum_comp
          (fun τ => ∏ m : Fin (n + 1), (τ m : ℝ) * Real.exp (K * (τ m : ℝ)))).symm
                                                        -- 人手 3: Step 1 の全単射 `ε ↦ (ς(ε_1),…)` で内側の和の添字を付け替える
                                                        -- （`binaryWordRealSum_eq_sum_univ` は運ぶ段）
    _ = ∑ u : SpinVal, ∏ m : Fin (n + 1),
          ((varsigma 1 : ℝ) * Real.exp (K * (varsigma 1 : ℝ))
            + (varsigma 0 : ℝ) * Real.exp (K * (varsigma 0 : ℝ))) :=
        Finset.sum_congr rfl fun u _ =>
          (expansion_of_finite_product_of_two_term_sums_of_real n
            (fun _ e => (varsigma e : ℝ) * Real.exp (K * (varsigma e : ℝ)))).symm
                                                        -- 人手 4: `expansion_of_finite_product_of_two_term_sums_of_real_numbers`
                                                        -- （`r → M_col-1`、`j → m`、`a_j^{(e)} → ς(e)exp(Kς(e))`）を右辺から左辺へ、各 `u` の項へ
    _ = ∑ u : SpinVal, ∏ m : Fin (n + 1), (1 * Real.exp (K * 1) + (-1) * Real.exp (K * (-1))) := by
        rw [coe_varsigma_one, coe_varsigma_zero]        -- 人手 5: `ς(1) = 1`、`ς(0) = -1` を各因子へ
    _ = ∑ u : SpinVal, ∏ m : Fin (n + 1), (Real.exp (K * 1) + (-1) * Real.exp (K * (-1))) := by
        rw [one_mul]                                    -- 人手 6: ℝ で `1·b = b` を各因子へ
    _ = ∑ u : SpinVal, ∏ m : Fin (n + 1), (Real.exp K + (-1) * Real.exp (K * (-1))) := by
        rw [mul_one]                                    -- 人手 7: ℝ で `a·1 = a` を各因子へ
    _ = ∑ u : SpinVal, ∏ m : Fin (n + 1), (Real.exp K + (-1) * Real.exp (-K)) := by
        rw [mul_neg_one K]                              -- 人手 8: ℝ で `a·(-1) = -a` を各因子へ
    _ = ∑ u : SpinVal, ∏ m : Fin (n + 1), (Real.exp K - Real.exp (-K)) := by
        rw [neg_one_mul, ← sub_eq_add_neg]              -- 人手 9: ℝ で `a + (-1)b = a - b` を各因子へ
                                                        -- （Lean では `(-1)b = -b` と `a + (-b) = a - b` の二つの補題）
    _ = 2 * ∏ m : Fin (n + 1), (Real.exp K - Real.exp (-K)) := by
        rw [sum_spinVal, ← two_mul]                     -- 人手 10: `u` に依らない実数 `c` の `{-1,1}` 上の和は `c + c = 2c`
    _ = 2 * ∏ m : Fin (n + 1), (2 * Real.sinh K) := by
        rw [Real.sinh_eq, mul_div_cancel₀ _ (two_ne_zero : (2 : ℝ) ≠ 0)]
                                                        -- 人手 11: `def_cosh_sinh`（`x → K`）を各因子へ（`def_cosh_sinh` は Lean で
                                                        -- 定義し直していないので mathlib の `Real.sinh_eq`。人手の `2sinh K` を
                                                        -- `exp K - exp(-K)` へ戻す `2·(b/2) = b` を同じ段に置く）
    _ = 2 * (2 * Real.sinh K) ^ (n + 2 - 1) := by
        rw [Fin.prod_const]; rfl                        -- 人手 12: 主張の `x^n := Π_{j=1}^{n} x`（`x → 2sinh K`、`n → M_col-1`）。
                                                        -- 指数の `n + 2 - 1` は Lean の自然数の引き算で、`n + 1` と同じ数

/-! ## `open_chain_spin_sums_positive` -/

/-- **人手 `open_chain_spin_sums_positive`** の一つ目: `∑_{s∈𝔐} exp(KE(s)) > 0`。 -/
theorem open_chain_partition_sum_pos (hM : 2 ≤ M) {K : ℝ} (_hK : 0 < K) :
    0 < ∑ s : SpinConf M, Real.exp (K * openChainEnergy s) := by
  rw [open_chain_partition_sum hM K]
  exact mul_pos two_pos (pow_pos (mul_pos two_pos (Real.cosh_pos K)) _)

/-- **人手 `open_chain_spin_sums_positive`** の二つ目: `∑_{s∈𝔐} s(M_col)s(1) exp(KE(s)) > 0`。 -/
theorem open_chain_endpoint_product_sum_pos (hM : 2 ≤ M) {K : ℝ} (hK : 0 < K) :
    0 < ∑ s : SpinConf M, (s (lastSite M (by omega)) : ℝ) * (s (firstSite M (by omega)) : ℝ)
        * Real.exp (K * openChainEnergy s) := by
  rw [open_chain_endpoint_product_sum hM K]
  exact mul_pos two_pos (pow_pos (mul_pos two_pos (Real.sinh_pos_iff.mpr hK)) _)

end Ising2D
