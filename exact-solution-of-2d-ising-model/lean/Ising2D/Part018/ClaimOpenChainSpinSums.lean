/-
# 1 次元開鎖の二つのスピン和と正値性（具体版）

正本: `structured-latex/content/018_even_sector_closing.ts`

| 人手 | Lean |
| --- | --- |
| `def_open_chain_spin_energy` の `E(s) = ∑_{m=1}^{M_col-1}s(m)s(m+1)` | `openChainEnergy` |
| 同 `E(s) ∈ ℤ` | `openChainEnergy_mem_int` |
| `open_chain_partition_sum` の Step 1 の `t_m := s(m)s(m+1)` と `Φ(s) = (s(1); t_1,…,t_{M_col-1})` | `openChainBondSpin`・`openChainChange` |
| 同 Step 1 の「`s(m+1) = s(m)t_m` で順に一意に定まる」 | `openChainChange_injective` |
| 同 Step 1 の「両側の集合はともに `2^{M_col}` 個の元をもつ」 | `card_spinConf`（`Part001/ClaimRowConfigurationNumberingBijective.lean`）・`card_openChainChange_target` |
| 同 Step 1 の「`Φ` は全単射」 | `openChainChange_bijective` |
| 同 Step 2 の `E(s) = ∑_m t_m` と `exp(KE(s)) = ∏_m exp(Kt_m)`（`theorem_exp_product`） | `openChainEnergy_eq_sum_bondSpin`・`exp_openChainEnergy` |
| 同 Step 2 の式変形と `open_chain_partition_sum` | `open_chain_partition_sum` |
| `open_chain_endpoint_product_sum` の Step 2 の `∏_m t_m = s(1)s(M_col)` | `prod_openChainBondSpin` |
| 同 Step 2 の式変形と `open_chain_endpoint_product_sum` | `open_chain_endpoint_product_sum` |
| `open_chain_spin_sums_positive` | `open_chain_partition_sum_pos`・`open_chain_endpoint_product_sum_pos` |
| `D0_G_diagonal_action` の `D_0f_{ι(s)}` の係数を `E(s)` で書いたもの（`trace_of_epsilon_V_plus` で使う） | `openChainD0_mulVec_basisVec_eq_energy` |

人手の列の添字 `{1,…,M_col}` は `Fin M`（人手の `m` が Lean の `(m : ℕ) + 1`）、人手の `1` と `M_col` は
`firstSite`・`lastSite`、人手の `m+1` は `nextSite m` である。開鎖の結合の添字 `{1,…,M_col-1}` は、
`openChainD0`・`openChainD0_mulVec_basisVec` と同じ「`(m : ℕ) + 1 ≠ M` なる `m : Fin M`」で、
`Φ` の値域の因子 `{-1,1}^{M_col-1}` の添字には、その部分型 `OpenChainBond M` を使う。
`openChainEnergy` は `openChainD0_mulVec_basisVec` の係数と定義で一致する。

人手の `{-1,1}` 上の有限和 `∑_{t∈{-1,1}} f(t) = f(1) + f(-1)` は `sum_spinVal`、
「有限個の因子の積の展開（各 `t_m` は独立に走る）」は `Fintype.prod_sum` である。

人手の Step 1 は「`s(m+1) = s(m)t_m` で順に一意に定まる」「逆にこの手続きで作った `s` は元の組を与える」
「両側の集合はともに `2^{M_col}` 個の元をもつ」の三つを述べる。Lean は一つ目（単射）と三つ目（元の個数）から
全単射を出し（`Fintype.bijective_iff_injective_and_card`）、二つ目（逆写像の構成）は元の個数の一致で代替した。
和の添字の付け替えは `Equiv.sum_comp` である。

`prod_openChainBondSpin` は、人手の一段「`ℝ` の乗法の可換性と結合性」で `s(1)(∏_{m=2}^{M_col-1}s(m)s(m))s(M_col)` へ
並べ替える段を、`∏_m s(m)` と `∏_m s(m+1)` への分解・添字のずらし（`prevSite`）・両端の括り出しの段に割って書く。

この証明が使うのは、`Fin M` 上の自然数の算術、有限和・有限積の並べ替えと展開、実数の指数法則と
双曲線関数の定義・正値性である。仮定は人手の主張に合わせて残し、実際に効いているものは次のとおりである。
- `open_chain_partition_sum` の証明は `M_col ≠ 0` しか使わない（人手の `M_col ≥ 2` は使わない）。
- `prod_openChainBondSpin`・`open_chain_endpoint_product_sum` の証明は、両端を別々に括り出すので `1 ≠ M_col`
  （`M_col ≥ 2`）を使う（主張そのものは `M_col = 1` でも成り立つ）。
- `open_chain_partition_sum_pos` の証明は `K > 0` を使わない（`cosh K > 0` は任意の `K` で成り立つ）。
値は実数である必要がなく、可換半環（端点因子の書き替えは可換モノイドと `s(m)s(m) = 1`）で足りるので、
必要十分版を `Ising2D/NecSuf/OpenChainSpinSum.lean` に置き、具体版をその系として
`Ising2D/Part018/ClaimOpenChainSpinSumsFromNecSuf.lean` で導出した。
-/
import Ising2D.Part001.ClaimRowConfigurationNumberingBijective
import Ising2D.Part004.Definition010_H1H2V1V2
import Ising2D.Part004.DefinitionConfigBasisIso
import Ising2D.Part008.Claim001_CommutatorHZY
import Ising2D.Part018.ClaimEpsilonD0GCommuteAndDiagonalAction
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv

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

/-- 人手の開鎖の結合の添字 `{1,…,M_col-1}`（`(m : ℕ) + 1 ≠ M` なる `m : Fin M`）。 -/
abbrev OpenChainBond (M : ℕ) : Type := {m : Fin M // (m : ℕ) + 1 ≠ M}

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

/-! ## `open_chain_partition_sum` の Step 1（変数変換） -/

/-- 人手の `t_m := s(m)s(m+1)`。 -/
def openChainBondSpin (s : SpinConf M) (b : OpenChainBond M) : SpinVal :=
  spinMul (s b.1) (s (nextSite b.1))

/-- 人手の `Φ(s) := (s(1); t_1,…,t_{M_col-1})`。 -/
def openChainChange (hM : M ≠ 0) (s : SpinConf M) : SpinVal × (OpenChainBond M → SpinVal) :=
  (s (firstSite M hM), openChainBondSpin s)

/-- 人手の「`(s(1); t_1,…,t_{M_col-1})` が与えられれば `s(m+1) = s(m)t_m` により
`s(2),…,s(M_col)` が順に一意に定まる」: `Φ` は単射。 -/
theorem openChainChange_injective (hM : M ≠ 0) : Function.Injective (openChainChange hM) := by
  intro s s' h
  simp only [openChainChange, Prod.mk.injEq] at h
  obtain ⟨h0, ht⟩ := h
  have key : ∀ k (hk : k < M), s ⟨k, hk⟩ = s' ⟨k, hk⟩ := by
    intro k
    induction k with
    | zero => intro hk; exact h0
    | succ k ih =>
      intro hk
      have hk' : k < M := by omega
      have hb : ((⟨k, hk'⟩ : Fin M) : ℕ) + 1 ≠ M := by simp only; omega
      have hnext : nextSite (⟨k, hk'⟩ : Fin M) = ⟨k + 1, hk⟩ :=
        Fin.ext (nextSite_val_of_lt (by simp only; omega))
      -- `t_k` の一致: `s(k)s(k+1) = s'(k)s'(k+1)`
      have e : (s ⟨k, hk'⟩ : ℝ) * (s ⟨k + 1, hk⟩ : ℝ) = (s' ⟨k, hk'⟩ : ℝ) * (s' ⟨k + 1, hk⟩ : ℝ) := by
        have := congrArg Subtype.val (congrFun ht ⟨⟨k, hk'⟩, hb⟩)
        simpa only [openChainBondSpin, coe_spinMul, hnext] using this
      rw [ih hk'] at e
      apply Subtype.ext
      -- `s(k+1) = s(k)t_k`（`s(k)s(k) = 1`）
      calc (s ⟨k + 1, hk⟩ : ℝ)
          = ((s' ⟨k, hk'⟩ : ℝ) * (s' ⟨k, hk'⟩ : ℝ)) * (s ⟨k + 1, hk⟩ : ℝ) := by
            rw [spinVal_mul_self, one_mul]
        _ = (s' ⟨k, hk'⟩ : ℝ) * ((s' ⟨k, hk'⟩ : ℝ) * (s ⟨k + 1, hk⟩ : ℝ)) := mul_assoc _ _ _
        _ = (s' ⟨k, hk'⟩ : ℝ) * ((s' ⟨k, hk'⟩ : ℝ) * (s' ⟨k + 1, hk⟩ : ℝ)) := by rw [e]
        _ = ((s' ⟨k, hk'⟩ : ℝ) * (s' ⟨k, hk'⟩ : ℝ)) * (s' ⟨k + 1, hk⟩ : ℝ) := (mul_assoc _ _ _).symm
        _ = (s' ⟨k + 1, hk⟩ : ℝ) := by rw [spinVal_mul_self, one_mul]
  funext i
  exact key i.1 i.2

/-- 開鎖の結合の個数 `M_col - 1`。 -/
theorem card_openChainBond (hM : M ≠ 0) : Fintype.card (OpenChainBond M) = M - 1 := by
  rw [Fintype.card_subtype]
  have hfilter : Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M)
      = Finset.univ.filter (fun m : Fin M => m ≠ lastSite M hM) := by
    apply Finset.filter_congr
    intro m _
    rw [Ne, Ne, Fin.ext_iff, lastSite]
    simp only
    omega
  rw [hfilter, Finset.filter_ne', Finset.card_erase_of_mem (Finset.mem_univ _), Finset.card_univ,
    Fintype.card_fin]

/-- 人手の `|{-1,1} × {-1,1}^{M_col-1}| = 2^{M_col}`。 -/
theorem card_openChainChange_target (hM : M ≠ 0) :
    Fintype.card (SpinVal × (OpenChainBond M → SpinVal)) = 2 ^ M := by
  rw [Fintype.card_prod, Fintype.card_fun, card_spinVal, card_openChainBond hM, ← pow_succ',
    Nat.sub_add_cancel (Nat.one_le_iff_ne_zero.mpr hM)]

/-- **人手 `open_chain_partition_sum` の Step 1**: `Φ` は全単射。 -/
theorem openChainChange_bijective (hM : M ≠ 0) : Function.Bijective (openChainChange hM) :=
  (Fintype.bijective_iff_injective_and_card _).mpr
    ⟨openChainChange_injective hM, by rw [card_spinConf, card_openChainChange_target hM]⟩

/-! ## `open_chain_partition_sum` の Step 2（スピン和の計算） -/

/-- 人手の `E(s) = ∑_{m=1}^{M_col-1} t_m`。 -/
theorem openChainEnergy_eq_sum_bondSpin (s : SpinConf M) :
    openChainEnergy s = ∑ b : OpenChainBond M, (openChainBondSpin s b : ℝ) := by
  rw [openChainEnergy,
    Finset.sum_subtype (p := fun m : Fin M => (m : ℕ) + 1 ≠ M) _ (fun m => by simp)]
  rfl

/-- 人手の `exp(KE(s)) = ∏_{m=1}^{M_col-1} exp(Kt_m)`（`theorem_exp_product`、実数の指数法則）。 -/
theorem exp_openChainEnergy (K : ℝ) (s : SpinConf M) :
    Real.exp (K * openChainEnergy s)
      = ∏ b : OpenChainBond M, Real.exp (K * (openChainBondSpin s b : ℝ)) := by
  rw [openChainEnergy_eq_sum_bondSpin, Finset.mul_sum, Real.exp_sum]

/-- **人手 `open_chain_partition_sum`**: `∑_{s∈𝔐} exp(KE(s)) = 2(2cosh K)^{M_col-1}`。 -/
theorem open_chain_partition_sum (hM : 2 ≤ M) (K : ℝ) :
    ∑ s : SpinConf M, Real.exp (K * openChainEnergy s) = 2 * (2 * Real.cosh K) ^ (M - 1) := by
  have hM0 : M ≠ 0 := by omega
  calc ∑ s : SpinConf M, Real.exp (K * openChainEnergy s)
      = ∑ s : SpinConf M, ∏ b : OpenChainBond M, Real.exp (K * ((openChainChange hM0 s).2 b : ℝ)) :=
        Finset.sum_congr rfl fun s _ => exp_openChainEnergy K s
    -- Step 1 の全単射
    _ = ∑ y : SpinVal × (OpenChainBond M → SpinVal),
          ∏ b : OpenChainBond M, Real.exp (K * (y.2 b : ℝ)) :=
        (Equiv.ofBijective _ (openChainChange_bijective hM0)).sum_comp
          (fun y => ∏ b : OpenChainBond M, Real.exp (K * (y.2 b : ℝ)))
    _ = ∑ a : SpinVal, ∑ t : OpenChainBond M → SpinVal,
          ∏ b : OpenChainBond M, Real.exp (K * (t b : ℝ)) := Fintype.sum_prod_type _
    -- 有限個の因子の積の展開（各 `t_m` は独立に走る）
    _ = (∑ _a : SpinVal, (1 : ℝ)) *
          ∏ b : OpenChainBond M, ∑ x : SpinVal, Real.exp (K * (x : ℝ)) := by
        rw [Fintype.prod_sum, Finset.sum_mul]
        simp only [one_mul]
    -- 二元集合 `{-1,1}` 上の二つの有限和を計算
    _ = 2 * ∏ _b : OpenChainBond M, (Real.exp K + Real.exp (-K)) := by
        rw [sum_spinVal, sum_spinVal]
        simp only [mul_one, mul_neg]
        norm_num
    -- 双曲線余弦の定義
    _ = 2 * ∏ _b : OpenChainBond M, (2 * Real.cosh K) := by
        rw [Real.cosh_eq]
        congr 1
        exact Finset.prod_congr rfl fun _ _ => by ring
    -- 同じ因子 `2cosh K` の `M_col - 1` 個の積
    _ = 2 * (2 * Real.cosh K) ^ (M - 1) := by
        rw [Finset.prod_const, Finset.card_univ, card_openChainBond hM0]

/-! ## `open_chain_endpoint_product_sum` -/

/-- 人手の `m ∈ {1,…,M_col-1}` に対する `m+1`: 結合の添字では `nextSite m` は `m+1` そのもの。 -/
theorem nextSite_val_of_bond {m : Fin M} (h : (m : ℕ) + 1 ≠ M) :
    ((nextSite m : Fin M) : ℕ) = (m : ℕ) + 1 :=
  nextSite_val_of_lt (by have := m.isLt; omega)

/-- 人手の `m ∈ {2,…,M_col}` に対する `m-1`（添字のずらしの逆向き）。 -/
def prevSite (m : Fin M) : Fin M := ⟨((m : ℕ) + M - 1) % M, Nat.mod_lt _ m.pos⟩

theorem prevSite_val_of_ne_zero {m : Fin M} (h : (m : ℕ) ≠ 0) :
    ((prevSite m : Fin M) : ℕ) = (m : ℕ) - 1 := by
  have := m.isLt
  simp only [prevSite]
  rw [show (m : ℕ) + M - 1 = ((m : ℕ) - 1) + M by omega, Nat.add_mod_right,
    Nat.mod_eq_of_lt (by omega)]

/-- **人手 `open_chain_endpoint_product_sum` の Step 2**: `∏_{m=1}^{M_col-1} t_m = s(1)s(M_col)`。

人手の三段（`ℝ` の乗法の可換性と結合性で `s(1)(∏_{m=2}^{M_col-1}s(m)s(m))s(M_col)` に並べ替え、
`s(m)s(m) = 1` を各 `m` へ適用し、有限積の単位元で消す）を、
`∏_m s(m)s(m+1) = (∏_{m≠M_col} s(m))(∏_{m≠1} s(m))` と両側の因子から `s(1)`・`s(M_col)` を
括り出す形で書く。`1 ≠ M_col`（`M_col ≥ 2`）を使う。 -/
theorem prod_openChainBondSpin (hM : 2 ≤ M) (s : SpinConf M) :
    ∏ b : OpenChainBond M, (openChainBondSpin s b : ℝ)
      = (s (firstSite M (by omega)) : ℝ) * (s (lastSite M (by omega)) : ℝ) := by
  have hM0 : M ≠ 0 := by omega
  have hfirst : ((firstSite M hM0 : Fin M) : ℕ) = 0 := rfl
  have hlast : ((lastSite M hM0 : Fin M) : ℕ) = M - 1 := rfl
  -- 人手の結合の添字 `m = 1,…,M_col-1`、ずらした添字 `m = 2,…,M_col`、中間の添字 `m = 2,…,M_col-1`
  obtain ⟨F, hF⟩ : ∃ F : Finset (Fin M),
      F = Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M) := ⟨_, rfl⟩
  obtain ⟨G, hG⟩ : ∃ G : Finset (Fin M),
      G = Finset.univ.filter (fun m : Fin M => m ≠ firstSite M hM0) := ⟨_, rfl⟩
  obtain ⟨I, hI⟩ : ∃ I : Finset (Fin M), I = Finset.univ.filter
      (fun m : Fin M => m ≠ firstSite M hM0 ∧ m ≠ lastSite M hM0) := ⟨_, rfl⟩
  have memF : ∀ m : Fin M, m ∈ F ↔ (m : ℕ) + 1 ≠ M := fun m => by simp [hF]
  have memG : ∀ m : Fin M, m ∈ G ↔ (m : ℕ) ≠ 0 := fun m => by
    simp only [hG, Finset.mem_filter, Finset.mem_univ, true_and, Ne, Fin.ext_iff, hfirst]
  have memI : ∀ m : Fin M, m ∈ I ↔ (m : ℕ) ≠ 0 ∧ (m : ℕ) ≠ M - 1 := fun m => by
    simp only [hI, Finset.mem_filter, Finset.mem_univ, true_and, Ne, Fin.ext_iff, hfirst, hlast]
  have hfirstF : firstSite M hM0 ∈ F := by rw [memF, hfirst]; omega
  have hlastG : lastSite M hM0 ∈ G := by rw [memG, hlast]; omega
  have hFI : F.erase (firstSite M hM0) = I := by
    ext m
    rw [Finset.mem_erase, memF, memI, Ne, Fin.ext_iff, hfirst]
    have := m.isLt
    omega
  have hGI : G.erase (lastSite M hM0) = I := by
    ext m
    rw [Finset.mem_erase, memG, memI, Ne, Fin.ext_iff, hlast]
    tauto
  -- `∏_{m=1}^{M_col-1} s(m+1) = ∏_{m=2}^{M_col} s(m)`（添字のずらし）
  have hshift : ∏ m ∈ F, (s (nextSite m) : ℝ) = ∏ m ∈ G, (s m : ℝ) := by
    apply Finset.prod_nbij' nextSite prevSite
    · intro m hm
      rw [memF] at hm
      rw [memG, nextSite_val_of_bond hm]
      omega
    · intro m hm
      rw [memG] at hm
      rw [memF, prevSite_val_of_ne_zero hm]
      have := m.isLt
      omega
    · intro m hm
      rw [memF] at hm
      apply Fin.ext
      rw [prevSite_val_of_ne_zero (by rw [nextSite_val_of_bond hm]; omega), nextSite_val_of_bond hm]
      omega
    · intro m hm
      rw [memG] at hm
      have hb : ((prevSite m : Fin M) : ℕ) + 1 ≠ M := by
        rw [prevSite_val_of_ne_zero hm]
        have := m.isLt
        omega
      apply Fin.ext
      rw [nextSite_val_of_bond hb, prevSite_val_of_ne_zero hm]
      omega
    · intro m _
      rfl
  calc ∏ b : OpenChainBond M, (openChainBondSpin s b : ℝ)
      = ∏ m ∈ F, (s m : ℝ) * (s (nextSite m) : ℝ) := by
        rw [Finset.prod_subtype (p := fun m : Fin M => (m : ℕ) + 1 ≠ M) F memF]
        rfl
    -- `ℝ` の乗法の可換性と結合性
    _ = (∏ m ∈ F, (s m : ℝ)) * ∏ m ∈ F, (s (nextSite m) : ℝ) := Finset.prod_mul_distrib
    _ = (∏ m ∈ F, (s m : ℝ)) * ∏ m ∈ G, (s m : ℝ) := by rw [hshift]
    _ = ((s (firstSite M hM0) : ℝ) * ∏ m ∈ I, (s m : ℝ))
          * ((s (lastSite M hM0) : ℝ) * ∏ m ∈ I, (s m : ℝ)) := by
        rw [Finset.mul_prod_erase F (fun m => (s m : ℝ)) hfirstF |>.symm, hFI,
          Finset.mul_prod_erase G (fun m => (s m : ℝ)) hlastG |>.symm, hGI]
    _ = (s (firstSite M hM0) : ℝ) * (∏ m ∈ I, (s m : ℝ) * (s m : ℝ)) * (s (lastSite M hM0) : ℝ) := by
        rw [Finset.prod_mul_distrib]
        ring
    -- `s(m)s(m) = 1` を各 `m` へ同時適用
    _ = (s (firstSite M hM0) : ℝ) * (∏ _m ∈ I, (1 : ℝ)) * (s (lastSite M hM0) : ℝ) := by
        rw [Finset.prod_congr rfl fun m _ => spinVal_mul_self (s m)]
    -- 有限積の単位元
    _ = (s (firstSite M hM0) : ℝ) * (s (lastSite M hM0) : ℝ) := by
        rw [Finset.prod_const_one, mul_one]

/-- **人手 `open_chain_endpoint_product_sum`**:
`∑_{s∈𝔐} s(M_col)s(1) exp(KE(s)) = 2(2sinh K)^{M_col-1}`。 -/
theorem open_chain_endpoint_product_sum (hM : 2 ≤ M) (K : ℝ) :
    ∑ s : SpinConf M, (s (lastSite M (by omega)) : ℝ) * (s (firstSite M (by omega)) : ℝ)
        * Real.exp (K * openChainEnergy s)
      = 2 * (2 * Real.sinh K) ^ (M - 1) := by
  have hM0 : M ≠ 0 := by omega
  calc ∑ s : SpinConf M, (s (lastSite M (by omega)) : ℝ) * (s (firstSite M (by omega)) : ℝ)
        * Real.exp (K * openChainEnergy s)
      = ∑ s : SpinConf M, (∏ b : OpenChainBond M, ((openChainChange hM0 s).2 b : ℝ))
          * ∏ b : OpenChainBond M, Real.exp (K * ((openChainChange hM0 s).2 b : ℝ)) :=
        Finset.sum_congr rfl fun s _ => by
          rw [exp_openChainEnergy K s, mul_comm (s (lastSite M _) : ℝ)]
          exact congrArg (· * _) (prod_openChainBondSpin hM s).symm
    _ = ∑ s : SpinConf M, ∏ b : OpenChainBond M,
          ((openChainChange hM0 s).2 b : ℝ) * Real.exp (K * ((openChainChange hM0 s).2 b : ℝ)) :=
        Finset.sum_congr rfl fun s _ => Finset.prod_mul_distrib.symm
    -- Step 1 の全単射
    _ = ∑ y : SpinVal × (OpenChainBond M → SpinVal),
          ∏ b : OpenChainBond M, (y.2 b : ℝ) * Real.exp (K * (y.2 b : ℝ)) :=
        (Equiv.ofBijective _ (openChainChange_bijective hM0)).sum_comp
          (fun y => ∏ b : OpenChainBond M, (y.2 b : ℝ) * Real.exp (K * (y.2 b : ℝ)))
    _ = ∑ a : SpinVal, ∑ t : OpenChainBond M → SpinVal,
          ∏ b : OpenChainBond M, (t b : ℝ) * Real.exp (K * (t b : ℝ)) := Fintype.sum_prod_type _
    -- 有限個の因子の積の展開
    _ = (∑ _a : SpinVal, (1 : ℝ)) *
          ∏ b : OpenChainBond M, ∑ x : SpinVal, (x : ℝ) * Real.exp (K * (x : ℝ)) := by
        rw [Fintype.prod_sum, Finset.sum_mul]
        simp only [one_mul]
    -- 二元集合 `{-1,1}` 上の二つの有限和を計算
    _ = 2 * ∏ _b : OpenChainBond M, (Real.exp K - Real.exp (-K)) := by
        rw [sum_spinVal, sum_spinVal]
        simp only [one_mul, mul_one, mul_neg, neg_mul]
        norm_num
        rfl
    -- 双曲線正弦の定義
    _ = 2 * ∏ _b : OpenChainBond M, (2 * Real.sinh K) := by
        rw [Real.sinh_eq]
        congr 1
        exact Finset.prod_congr rfl fun _ _ => by ring
    -- 同じ因子 `2sinh K` の `M_col - 1` 個の積
    _ = 2 * (2 * Real.sinh K) ^ (M - 1) := by
        rw [Finset.prod_const, Finset.card_univ, card_openChainBond hM0]

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
