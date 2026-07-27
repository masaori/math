/-
# 章 018 の設定（章 014–017 からの入力を「仮定」として明示する）

正本: `structured-latex/content/018_even_sector_closing.ts`。

## なぜ仮定を置くのか（一次情報）

章 018 は半整数運動量のフェルミオン `ψ̌_μ^†, ψ̌_μ`（原文 `def_check_fermi`）、
個数演算子 `ň_μ`（`def_check_number_operator`）、同時固有射影 `Q̌_ε`
（`check_joint_eigenspace_decomposition`）、`V^{(+)}` の固有値
（`eigenvalues_of_V_plus`）の上に立つ。これらは**章 014–017 の内容**であり、
本リポジトリの Lean 側には（本セッション時点で）存在しない
（`grep -rn "checkPsi\|checkNum\|checkQ" --include=*.lean Ising2D/` が
章 013 の `checkZ` / `checkY` 以外にヒットしない）。

そこで**章 014–017 から受け取る入力だけを束ねた構造 `Ising2D.CheckFermi`** を置き、
章 018 の主張はすべてそこからの帰結として証明する。仮定の内訳は次のとおりで、
**いずれも章 014–017 の主張そのままである**。

| `CheckFermi` の場 | 原文の主張 | 章 |
| --- | --- | --- |
| `hcre` / `hann` | `ψ̌_μ^†, ψ̌_μ` は `Ž_μ, Y̌_μ` の ℂ 係数 1 次結合（`def_check_fermi`） | 016 |
| `acomm_cre_cre` ほか 3 本 | `ψ̌` の正準反交換関係（`anticommutator_of_check_psi`） | 016 |
| `hstar` | `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`（`check_number_operator_is_hermitian` (3)） | 016 |

**`ε` が `Ž, Y̌` と反可換であること（原文 (1)(2)）は仮定していない。**
それは章 004・010・013 の形式化済みの定理から**無条件に**従う
（`Ising2D/Part018/Claim001_EpsilonAnticommutes.lean`）。

`V^{(+)}` の固有値は別途 `Ising2D.VPlusData`（`Claim003_...` 冒頭）で受け取る。
-/
import Ising2D.Part018.Claim001_EpsilonAnticommutes
import Ising2D.Part009.Claim008_JointEigenspace
import Ising2D.Part009.Claim013_PositiveDefinite

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 章 014–017 からの入力 -/

/-- **章 014–017 から受け取る入力**（上表を参照）。

添字型は `Fin M`（原文の `𝓜̌ = {1,…,M}` に 1 対 1 で対応する）。
`ann i` は原文の `ψ̌_{M+1-μ_i}` にあたる（したがって `n_μ = ψ̌_μ^† ψ̌_{M+1-μ}`）。 -/
structure CheckFermi (M : ℕ) where
  /-- `ψ̌_μ^†` -/
  cre : Fin M → TensorPow M
  /-- `ψ̌_{M+1-μ}` -/
  ann : Fin M → TensorPow M
  hcre : ∀ i, IsCheckMode (cre i)
  hann : ∀ i, IsCheckMode (ann i)
  acomm_cre_cre : ∀ i j, cre i * cre j + cre j * cre i = 0
  acomm_ann_ann : ∀ i j, ann i * ann j + ann j * ann i = 0
  acomm_cre_ann : ∀ i j, cre i * ann j + ann j * cre i = if i = j then 1 else 0
  hstar : ∀ i, (cre i)ᴴ = ann i

namespace CheckFermi

variable (F : CheckFermi M)

/-- **原文 `def_check_number_operator`**: `ň_μ := ψ̌_μ^† ψ̌_{M+1-μ}`。 -/
noncomputable def nOp (i : Fin M) : TensorPow M := Abstract.num F.cre F.ann i

theorem nOp_def (i : Fin M) : F.nOp i = F.cre i * F.ann i := rfl

theorem acomm_cre_ann_self (i : Fin M) : F.cre i * F.ann i + F.ann i * F.cre i = 1 := by
  have := F.acomm_cre_ann i i
  simpa using this

theorem cre_sq (i : Fin M) : F.cre i * F.cre i = 0 :=
  Abstract.sq_eq_zero_of_acomm_self tensorPow_two_torsion_free (F.acomm_cre_cre i i)

theorem ann_sq (i : Fin M) : F.ann i * F.ann i = 0 :=
  Abstract.sq_eq_zero_of_acomm_self tensorPow_two_torsion_free (F.acomm_ann_ann i i)

theorem ann_mul_cre (i : Fin M) : F.ann i * F.cre i = 1 - F.nOp i :=
  Abstract.ann_mul_cre F.cre F.ann i (F.acomm_cre_ann_self i)

theorem nOp_mul_self (i : Fin M) : F.nOp i * F.nOp i = F.nOp i :=
  Abstract.num_mul_num F.cre F.ann i tensorPow_two_torsion_free
    (F.acomm_cre_cre i i) (F.acomm_ann_ann i i) (F.acomm_cre_ann_self i)

theorem commute_cre_nOp {i j : Fin M} (hij : i ≠ j) :
    Commute (F.cre i) (F.nOp j) :=
  Abstract.commute_cre_num F.cre F.ann (F.acomm_cre_cre i j)
    (by have := F.acomm_cre_ann i j; rwa [if_neg hij] at this)

theorem commute_ann_nOp {i j : Fin M} (hij : i ≠ j) :
    Commute (F.ann i) (F.nOp j) :=
  Abstract.commute_ann_num F.cre F.ann
    (by
      have := F.acomm_cre_ann j i
      rw [if_neg (Ne.symm hij)] at this
      linear_combination (norm := noncomm_ring) this)
    (F.acomm_ann_ann i j)

theorem commute_nOp_nOp (i j : Fin M) : Commute (F.nOp i) (F.nOp j) := by
  by_cases hij : i = j
  · subst hij; exact Commute.refl _
  · refine Abstract.commute_num_num F.cre F.ann (F.acomm_cre_cre i j) ?_ ?_ (F.acomm_ann_ann i j)
    · have := F.acomm_cre_ann i j; rwa [if_neg hij] at this
    · have := F.acomm_cre_ann j i
      rw [if_neg (Ne.symm hij)] at this
      linear_combination (norm := noncomm_ring) this

/-! ## 同時固有射影 `Q̌_ε`（原文 `check_joint_eigenspace_decomposition`） -/

/-- **原文の `Q̌_ε`**（`ε_μ = 1 ⟺ μ ∈ T` で添字づける）。 -/
noncomputable def Qproj (T : Finset (Fin M)) : TensorPow M :=
  Abstract.projOn F.nOp F.commute_nOp_nOp Finset.univ T

theorem Qproj_mul_self (T : Finset (Fin M)) : F.Qproj T * F.Qproj T = F.Qproj T :=
  Abstract.projOn_mul_self F.nOp_mul_self _ _

theorem Qproj_mul_Qproj_of_ne {T T' : Finset (Fin M)} (h : T ≠ T') :
    F.Qproj T * F.Qproj T' = 0 := by
  obtain ⟨ν, hν⟩ : ∃ ν : Fin M, ¬(ν ∈ T ↔ ν ∈ T') := by
    by_contra hc
    push_neg at hc
    exact h (Finset.ext fun ν => hc ν)
  exact Abstract.projOn_mul_projOn_of_ne F.nOp_mul_self (Finset.mem_univ ν) hν

theorem sum_Qproj : ∑ T : Finset (Fin M), F.Qproj T = 1 := by
  have := Abstract.sum_projOn (n := F.nOp) (hn := F.commute_nOp_nOp) Finset.univ
  rwa [Finset.powerset_univ] at this

theorem nOp_mul_Qproj (ν : Fin M) (T : Finset (Fin M)) :
    F.nOp ν * F.Qproj T = (if ν ∈ T then (1 : ℂ) else 0) • F.Qproj T := by
  have h := Abstract.num_mul_projOn (n := F.nOp) (hn := F.commute_nOp_nOp)
    F.nOp_mul_self (T := T) (Finset.mem_univ ν)
  rw [Qproj, h]
  by_cases hT : ν ∈ T <;> simp [hT]

/-- **原文 `check_joint_eigenspace_decomposition` (4)**: `tr(Q̌_ε) = 1`。

半整数運動量では `𝓘 = 𝓜̌` が `M` 個すべてなので、章 009 の `2^{M-m}` が `2^0 = 1` になる。 -/
theorem trace_Qproj (T : Finset (Fin M)) : (F.Qproj T).trace = 1 := by
  have h := Abstract.two_pow_smul_tau_projOn F.cre F.ann F.commute_nOp_nOp
    (Matrix.trace : TensorPow M → ℂ) (fun x y => Matrix.trace_add x y)
    (fun x y => Matrix.trace_mul_comm x y) F.acomm_cre_ann_self
    (fun i j hij => F.commute_cre_nOp hij) (fun i j hij => F.commute_ann_nOp hij)
    Finset.univ T
  rw [trace_one_tensorPow] at h
  have hcard : (Finset.univ : Finset (Fin M)).card = M := by simp
  rw [hcard, nsmul_eq_mul] at h
  have hne : ((2 ^ M : ℕ) : ℂ) ≠ 0 := by
    simp
  have h' : ((2 ^ M : ℕ) : ℂ) * (F.Qproj T).trace = ((2 ^ M : ℕ) : ℂ) * 1 := by
    rw [mul_one]
    exact h
  exact mul_left_cancel₀ hne h'

theorem Qproj_ne_zero (T : Finset (Fin M)) : F.Qproj T ≠ 0 := by
  intro h
  have := F.trace_Qproj T
  rw [h, Matrix.trace_zero] at this
  exact one_ne_zero this.symm

/-! ## `ε` との交換（原文 `epsilon_anticommutes_with_check_Z_Y` (3)(4)） -/

theorem epsilon_anticomm_cre (i : Fin M) :
    epsilon M * F.cre i = -(F.cre i * epsilon M) :=
  epsilon_anticomm_of_isCheckMode (F.hcre i)

theorem epsilon_anticomm_ann (i : Fin M) :
    epsilon M * F.ann i = -(F.ann i * epsilon M) :=
  epsilon_anticomm_of_isCheckMode (F.hann i)

/-- **原文 (4) 前半**: `ε ň_μ = ň_μ ε`。 -/
theorem commute_epsilon_nOp (i : Fin M) : Commute (epsilon M) (F.nOp i) :=
  Abstract.commute_parity_num F.cre F.ann (F.epsilon_anticomm_cre i) (F.epsilon_anticomm_ann i)

/-- **原文 (4) 後半**: `ε Q̌_ε = Q̌_ε ε`。 -/
theorem commute_epsilon_Qproj (T : Finset (Fin M)) : Commute (epsilon M) (F.Qproj T) :=
  Abstract.commute_parity_projOn F.cre F.ann F.commute_nOp_nOp
    F.epsilon_anticomm_cre F.epsilon_anticomm_ann _ T

/-! ## エルミート性（原文 `check_number_operator_is_hermitian` (4)） -/

/-- `(ψ̌_{M+1-μ})^* = ψ̌_μ^†`（`hstar` の帰結）。 -/
theorem ann_conjTranspose (i : Fin M) : (F.ann i)ᴴ = F.cre i := by
  rw [← F.hstar i, Matrix.conjTranspose_conjTranspose]

/-- **原文 (4) 前半**: `ň_μ^* = ň_μ`。 -/
theorem nOp_conjTranspose (i : Fin M) : (F.nOp i)ᴴ = F.nOp i := by
  rw [nOp_def, Matrix.conjTranspose_mul, F.ann_conjTranspose, F.hstar, ← nOp_def]

/-- **原文 (4) 後半**: `Q̌_ε^* = Q̌_ε`（抽象版 `Abstract.star_projOn` の特殊化）。 -/
theorem Qproj_conjTranspose (T : Finset (Fin M)) : (F.Qproj T)ᴴ = F.Qproj T := by
  have h := Abstract.star_projOn (A := TensorPow M) F.nOp F.commute_nOp_nOp
    (fun i => (Matrix.star_eq_conjTranspose (F.nOp i)).trans (F.nOp_conjTranspose i))
    Finset.univ T
  rw [Matrix.star_eq_conjTranspose] at h
  exact h

end CheckFermi

end Ising2D
