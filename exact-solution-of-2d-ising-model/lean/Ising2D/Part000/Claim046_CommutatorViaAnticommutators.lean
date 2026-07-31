/-
# 交換子と反交換子の関係

対応する人手証明:
`parts/000_計算公式/046_claim_交換子と反交換子の関係.typ`
(`<commutator_via_anticommutators>`)

原文: `n ∈ ℤ_{≥1}`、`a, b, c ∈ Mat(n, ℂ)` について、
交換子 `[x, y] := x y - y x`、反交換子 `[x, y]₊ := x y + y x` とするとき

  `[a b, c] = a [b, c]₊ - [a, c]₊ b`

が成り立つ。

原文の証明は分配法則・結合法則しか使っていないので、ここでは
**任意の（非可換）環 `R`** に対して定式化する（`Mat(n, ℂ)` はその特別な場合であり、
系 `matrix_commutator_via_anticommutators` として原文の形でも述べる）。
交換子は mathlib の Lie 括弧 `⁅·,·⁆`（`Ring.lie_def : ⁅x, y⁆ = x * y - y * x`）と
一致するので、その形の言い換えも与える。
-/
import Mathlib.Algebra.Algebra.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Lie.OfAssociative
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Matrix.Basic
import Mathlib.Tactic.NoncommRing

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

/-- 原文の交換子 `[x, y] := x y - y x` は mathlib の Lie 括弧と一致する。 -/
theorem sub_mul_comm_eq_lie (a b : R) : a * b - b * a = ⁅a, b⁆ :=
  (Ring.lie_def a b).symm

/-- **`<commutator_via_anticommutators>` の形式化**:
`[a b, c] = a [b, c]₊ - [a, c]₊ b`。

原文の証明（右辺を反交換子の定義で展開し、分配法則・結合法則で整理する）と同じ内容を
`noncomm_ring`（非可換環の正規化）で実行する。 -/
theorem commutator_via_anticommutators (a b c : R) :
    (a * b) * c - c * (a * b) = a * acomm b c - acomm a c * b := by
  simp only [acomm]
  noncomm_ring

/-- 上を mathlib の Lie 括弧で述べた版。 -/
theorem lie_mul_eq_acomm_sub_acomm (a b c : R) :
    ⁅a * b, c⁆ = a * acomm b c - acomm a c * b := by
  rw [← sub_mul_comm_eq_lie]
  exact commutator_via_anticommutators a b c

end Ring

/-! ## 反交換子の双線型性（線型結合の展開）

原文には対応する主張が無い**補助補題**。
`parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ` と
`parts/007_hatZとhatYの反交換関係/000_claim_....typ` の計算は、いずれも
「反交換子の中の有限線型結合を外へ出す」操作を暗黙に使っているので、
その操作をここで一度だけ証明しておく。 -/

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

section Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- 原文の記法（`Mat(n, ℂ)` の元 `a, b, c`）に沿った系。 -/
theorem matrix_commutator_via_anticommutators (a b c : Matrix n n ℂ) :
    (a * b) * c - c * (a * b) = a * (b * c + c * b) - (a * c + c * a) * b :=
  commutator_via_anticommutators a b c

end Matrix

/-! ## 原文と 1 対 1 に対応する具体版（複素行列）

`exact-solution-of-2d-ising-model/README.md` 4 節の方針にしたがい、上の必要十分版
（任意の環 `R`）とは別に、**人手証明 `<commutator_via_anticommutators>` と 1 対 1 に
対応する形**をここで立てる。原文は

> `n ∈ ℤ_{≥1}`、`a, b, c ∈ Mat(n, ℂ)`、
> `[x, y] := x y - y x`、`[x, y]₊ := x y + y x` とするとき
> `[a b, c] = a [b, c]₊ - [a, c]₊ b`

であり、`Mat(n, ℂ)` は `Matrix (Fin n) (Fin n) ℂ` である。
交換子・反交換子も、原文と同じく**複素行列に対する演算として**定義し直す
（必要十分版の `acomm` は任意の環の上の演算なので、記法としては原文と一致しない）。

仮定 `1 ≤ n` は**証明では使わない**。必要十分版から分かるとおりこの恒等式は分配法則と
結合法則だけで従うので、`n = 0`（自明な零環）でも成り立つ。原文との対応を明示するために
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

/-- 複素行列に対する交換子・反交換子が、必要十分版の対応物と一致すること
（具体版を必要十分版の特殊化として導くための橋渡し）。 -/
theorem matAcomm_eq_acomm (x y : Matrix (Fin n) (Fin n) ℂ) : matAcomm x y = acomm x y := rfl

/-- **`<commutator_via_anticommutators>` の具体版（原文と 1 対 1 に対応する形）**:
`n ∈ ℤ_{≥1}`、`a, b, c ∈ Mat(n, ℂ)` について `[a b, c] = a [b, c]₊ - [a, c]₊ b`。

証明は必要十分版 `commutator_via_anticommutators` を `R := Matrix (Fin n) (Fin n) ℂ` へ
特殊化するだけである。 -/
theorem matComm_mul_eq_matAcomm_sub_matAcomm (_hn : 1 ≤ n)
    (a b c : Matrix (Fin n) (Fin n) ℂ) :
    matComm (a * b) c = a * matAcomm b c - matAcomm a c * b := by
  rw [matComm_def, matAcomm_eq_acomm, matAcomm_eq_acomm]
  exact commutator_via_anticommutators a b c

end ConcreteMatrix

end Ising2D
