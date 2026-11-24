/-
# 交換子と反交換子の関係

対応する人手証明:
`parts/000_計算公式/046_claim_交換子と反交換子の関係.typ`
(`<commutator_via_anticommutators>`)

原文: `n ∈ ℤ_{≥1}`、`a, b, c ∈ Mat(n, ℂ)` について、
交換子 `[x, y] := x y - y x`、反交換子 `[x, y]₊ := x y + y x` とするとき

  `[a b, c] = a [b, c]₊ - [a, c]₊ b`

が成り立つ。

人手証明と 1 対 1 に対応する具体版は下の `matComm_mul_eq_matAcomm_sub_matAcomm` である。
任意の（非可換）環 `R` の上の同じ式（`[a b, c] = a [b, c]₊ - [a, c]₊ b` と、その Lie 括弧の形）は
必要十分版 `Ising2D/NecSuf/CommutatorViaAnticommutators.lean` の `NecSuf.commutator_via_anticommutators'`・
`NecSuf.lie_mul_eq_acomm'_sub_acomm'` にある。反交換子 `acomm` とその双線型性は、具体版の補題
（`ClaimAnticommutatorHatZHatY.lean` など）が使うのでこのファイルに置く。必要十分版の側の同じ式
`NecSuf.acomm'` との一致は導出 `ClaimCommutatorViaAnticommutatorsFromNecSuf.lean` が述べる。
-/
import Mathlib.Algebra.Algebra.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Matrix.Basic

namespace Ising2D

section Ring

variable {R : Type*} [Ring R]

/-- 反交換子 `[a, b]₊ := a b + b a`（原文の `[a, b]_(+)`）。
mathlib には対応する定義が無いのでここで導入する。 -/
def acomm (a b : R) : R := a * b + b * a

@[simp]
theorem acomm_def (a b : R) : acomm a b = a * b + b * a := rfl

/-- 反交換子は対称。 -/
theorem acomm_comm (a b : R) : acomm a b = acomm b a := by
  simp [acomm, add_comm]

end Ring

/-! ## 反交換子の双線型性（線型結合の展開）

`acomm_sum_smul` は、本文の `anticommutator_of_finite_sums_of_scalar_multiples`（`Mat(n, ℂ)` の反交換子
`[X, W]_+` についての主張）を任意の環 `R` へ一般化した形である。本文どおりの `Mat(n, ℂ)` と `matAnticomm` についての
具体版は無く、証明も本文の成分ごとの計算ではなく `Finset.sum_mul_sum` による。 -/

section Bilinear

variable {R : Type*} [Ring R] {S : Type*} [CommSemiring S] [Algebra S R]
variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- 線型結合どうしの積の展開 `(∑ᵢ cᵢ xᵢ)(∑ⱼ dⱼ yⱼ) = ∑ᵢ∑ⱼ (cᵢdⱼ) (xᵢ yⱼ)`。 -/
theorem sum_smul_mul_sum_smul (c : ι → S) (d : κ → S) (x : ι → R) (y : κ → R) :
    (∑ i, c i • x i) * (∑ j, d j • y j) = ∑ i, ∑ j, (c i * d j) • (x i * y j) := by
  rw [Finset.sum_mul_sum]
  exact Finset.sum_congr rfl fun i _ =>
    Finset.sum_congr rfl fun j _ => smul_mul_smul_comm _ _ _ _

/-- 反交換子は左の引数について線型: `[∑ᵢ cᵢ xᵢ, y]₊ = ∑ᵢ cᵢ [xᵢ, y]₊`。 -/
theorem acomm_sum_smul_left (c : ι → S) (x : ι → R) (y : R) :
    acomm (∑ i, c i • x i) y = ∑ i, c i • acomm (x i) y := by
  simp only [acomm, Finset.sum_mul, Finset.mul_sum, Algebra.smul_mul_assoc,
    Algebra.mul_smul_comm, smul_add, Finset.sum_add_distrib]

/-- 反交換子の両引数を線型結合で展開する:
`[∑ᵢ cᵢ xᵢ, ∑ⱼ dⱼ yⱼ]₊ = ∑ᵢ∑ⱼ (cᵢdⱼ) [xᵢ, yⱼ]₊`。 -/
theorem acomm_sum_smul (c : ι → S) (d : κ → S) (x : ι → R) (y : κ → R) :
    acomm (∑ i, c i • x i) (∑ j, d j • y j)
      = ∑ i, ∑ j, (c i * d j) • acomm (x i) (y j) := by
  have hBA : (∑ j, d j • y j) * (∑ i, c i • x i)
      = ∑ i, ∑ j, (c i * d j) • (y j * x i) := by
    rw [sum_smul_mul_sum_smul, Finset.sum_comm]
    exact Finset.sum_congr rfl fun i _ =>
      Finset.sum_congr rfl fun j _ => by rw [mul_comm]
  rw [acomm, sum_smul_mul_sum_smul, hBA, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun j _ => by rw [acomm, smul_add]

end Bilinear

/-! ## 原文と 1 対 1 に対応する具体版（複素行列）

`exact-solution-of-2d-ising-model/README.md` 4 節の方針にしたがい、必要十分版
（任意の環 `R`。`NecSuf/CommutatorViaAnticommutators.lean`）とは別に、**人手証明 `<commutator_via_anticommutators>` と 1 対 1 に
対応する形**をここで立てる。原文は

> `n ∈ ℤ_{≥1}`、`a, b, c ∈ Mat(n, ℂ)`、
> `[x, y] := x y - y x`、`[x, y]₊ := x y + y x` とするとき
> `[a b, c] = a [b, c]₊ - [a, c]₊ b`

であり、`Mat(n, ℂ)` は `Matrix (Fin n) (Fin n) ℂ` である。
交換子・反交換子も、原文と同じく**複素行列に対する演算として**定義し直す
（任意の環の上の `acomm` は、記法としては原文と一致しない）。

仮定 `1 ≤ n` は**証明では使わない**。この恒等式は分配律と
結合律だけで従うので、`n = 0`（自明な零環）でも成り立つ。原文との対応を明示するために
引数としては残してある。 -/
section ConcreteMatrix

variable {n : ℕ}

/-- 原文の交換子 `[x, y] := x y - y x`（複素行列に対する演算として定義）。 -/
def matComm (x y : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ := x * y - y * x

/-- 原文の反交換子 `[x, y]₊ := x y + y x`（複素行列に対する演算として定義）。 -/
def matAcomm (x y : Matrix (Fin n) (Fin n) ℂ) : Matrix (Fin n) (Fin n) ℂ := x * y + y * x

@[simp]
theorem matComm_def (x y : Matrix (Fin n) (Fin n) ℂ) : matComm x y = x * y - y * x := rfl

@[simp]
theorem matAcomm_def (x y : Matrix (Fin n) (Fin n) ℂ) : matAcomm x y = x * y + y * x := rfl

/-- 複素行列の反交換子 `matAcomm` は、任意の環の上の反交換子 `acomm` を複素行列に当てはめたものと一致する。 -/
theorem matAcomm_eq_acomm (x y : Matrix (Fin n) (Fin n) ℂ) : matAcomm x y = acomm x y := rfl

/-- **`<commutator_via_anticommutators>` の具体版（原文と 1 対 1 に対応する形）**:
`n ∈ ℤ_{≥1}`、`a, b, c ∈ Mat(n, ℂ)` について `[a b, c] = a [b, c]₊ - [a, c]₊ b`。

証明は人手証明の 6 段の鎖と同じ段の `calc` である。 -/
theorem matComm_mul_eq_matAcomm_sub_matAcomm (_hn : 1 ≤ n)
    (a b c : Matrix (Fin n) (Fin n) ℂ) :
    matComm (a * b) c = a * matAcomm b c - matAcomm a c * b := by
  calc matComm (a * b) c
      = (a * b) * c - c * (a * b) := matComm_def _ _                          -- 交換子の定義
    _ = a * (b * c) - c * a * b := by
        rw [Matrix.mul_assoc a b c, ← Matrix.mul_assoc c a b]                -- 行列の積の結合律
    _ = a * (b * c) + a * (c * b) - a * (c * b) - c * a * b := by
        rw [add_sub_cancel_right]                                            -- acb - acb = O
    _ = a * (b * c + c * b) - a * (c * b) - c * a * b := by
        rw [Matrix.mul_add]                                                  -- 行列の積の分配律
    _ = a * (b * c + c * b) - (a * c + c * a) * b := by
        rw [sub_sub, Matrix.add_mul, Matrix.mul_assoc a c b]                 -- 行列の積の分配律（人手が括弧を書かない x - y - z = x - (y + z) と結合律も使う）
    _ = a * matAcomm b c - matAcomm a c * b := by
        rw [matAcomm_def, matAcomm_def]                                      -- 反交換子の定義

end ConcreteMatrix

end Ising2D
