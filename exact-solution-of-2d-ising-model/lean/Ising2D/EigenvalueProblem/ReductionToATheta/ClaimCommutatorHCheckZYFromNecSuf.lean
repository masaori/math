/-
# `commutator_of_H_and_check_Z_Y` — 具体版を必要十分版の特殊化として導出する

対応する人手証明のラベル: `commutator_of_H_and_check_Z_Y`
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensector_004_claim_commutator_H_check_Z_Y`）

| | 定理 | 何を仮定しているか |
| --- | --- | --- |
| **具体版** | `lie_H1Plus_checkZ` / `lie_H1Plus_checkY` / `lie_H2_checkZ` / `lie_H2_checkY`（`ClaimCommutatorHCheckZY.lean`） | `Mat(2,ℂ)^{⊗M}` の `Z_j, Y_j` と位相 `checkPhase` |
| **必要十分版** | `NecSuf.SiteZY.lie_h1_checkZ` / `lie_h1_checkY` / `lie_h2_checkZ` / `lie_h2_checkY`（`NecSuf/CommutatorSiteSum.lean`） | `R`-代数の族 `z, y` の反交換関係 5 つ、位相の加法性と `p(0) = 1`、境界の符号と位相の一周の関係 |

特殊化で埋めるのは次の 3 点だけである。

* `Z, Y` が `SiteZY` の 5 つの欄を満たすこと（`zySiteZY`。欄はすべて `ClaimCommutatorHCheckZY.lean` の
  準備の補題と `anticommutator_of_Z_and_Y` の `Z_mul_self`・`Y_mul_self`）。
* `H_2`・`H_1^{(+)}`・`check(Z)`・`check(Y)` が必要十分版の `h2`・`h1 (-1)`・`checkZ`・`checkY` と定義で一致すること
  （`lastSign` と `bdSign`、`nextSite` と `nextIdx` は同じ定義）。
* 位相 `p k := checkPhase M k ν` について、`checkPhase_add_left`・`checkPhase_zero_left` と、
  反周期性 `checkPhase_antiperiodic` から出る `η = p(M)`（`-1 = -1`）・`p(M) η = 1`（`(-1)(-1) = 1`）。
-/
import Ising2D.NecSuf.CommutatorSiteSum
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimCommutatorHCheckZY

namespace Ising2D

variable {M : ℕ}

/-- `Z_j, Y_j` は必要十分版の族 `SiteZY` を成す。 -/
noncomputable def zySiteZY (M : ℕ) : NecSuf.SiteZY (TensorPow M) M where
  z := Z
  y := Y
  z_mul_z_of_ne := Z_mul_Z_of_ne
  y_mul_y_of_ne := Y_mul_Y_of_ne
  z_mul_y := Z_mul_Y_anticomm
  z_mul_self := Z_mul_self
  y_mul_self := Y_mul_self

theorem H2_eq_zySiteZY_h2 : H2 M = (zySiteZY M).h2 := rfl

theorem H1plus_eq_zySiteZY_h1 : H1plus M = (zySiteZY M).h1 (-1 : ℂ) := rfl

theorem checkZ_eq_zySiteZY_checkZ (ν : ℤ) :
    checkZ M ν = (zySiteZY M).checkZ (fun k => checkPhase M k ν) := rfl

theorem checkY_eq_zySiteZY_checkY (ν : ℤ) :
    checkY M ν = (zySiteZY M).checkY (fun k => checkPhase M k ν) := rfl

/-- **(C) を必要十分版の特殊化として導出した形**: `[H_2, check(Z)_μ] = -2 check(Y)_μ`。 -/
theorem lie_H2_checkZ_of_necSuf (ν : ℤ) :
    ⁅H2 M, checkZ M ν⁆ = (-2 : ℂ) • checkY M ν :=
  (zySiteZY M).lie_h2_checkZ (fun k => checkPhase M k ν)

/-- **(D) を必要十分版の特殊化として導出した形**: `[H_2, check(Y)_μ] = 2 check(Z)_μ`。 -/
theorem lie_H2_checkY_of_necSuf (ν : ℤ) :
    ⁅H2 M, checkY M ν⁆ = (2 : ℂ) • checkZ M ν :=
  (zySiteZY M).lie_h2_checkY (fun k => checkPhase M k ν)

/-- **(A) を必要十分版の特殊化として導出した形**:
`[H_1^{(+)}, check(Z)_μ] = 2 e^{-iθ~_μ} check(Y)_μ`。
境界の符号 `η = -1` が位相の一周 `checkPhase M M ν = -1` と一致することを渡す。 -/
theorem lie_H1Plus_checkZ_of_necSuf (hM : M ≠ 0) (ν : ℤ) :
    ⁅H1plus M, checkZ M ν⁆ = (2 * checkPhase M 1 ν) • checkY M ν :=
  (zySiteZY M).lie_h1_checkZ hM (fun k => checkPhase M k ν) (-1)
    (fun k l => checkPhase_add_left M k l ν) (checkPhase_zero_left M ν)
    (checkPhase_antiperiodic hM ν).symm

/-- **(B) を必要十分版の特殊化として導出した形**:
`[H_1^{(+)}, check(Y)_μ] = -2 e^{iθ~_μ} check(Z)_μ`。
境界の符号 `η = -1` と位相の一周 `checkPhase M M ν = -1` の積が `1` であることを渡す。 -/
theorem lie_H1Plus_checkY_of_necSuf (hM : M ≠ 0) (ν : ℤ) :
    ⁅H1plus M, checkY M ν⁆ = (-2 * checkPhase M (-1) ν) • checkZ M ν :=
  (zySiteZY M).lie_h1_checkY hM (fun k => checkPhase M k ν) (-1)
    (fun k l => checkPhase_add_left M k l ν)
    (by show checkPhase M (M : ℤ) ν * (-1) = 1
        rw [checkPhase_antiperiodic hM]; norm_num)

end Ising2D
