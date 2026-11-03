/-
# `{0,1}^r` の上の和を `Finset.sum` で書く（必要十分版）

具体版: `Ising2D/EigenvalueProblem/EigenvaluesOfVPlus/ClaimCheckJointEigenspace.lean` の `CheckFermiSetup.sum_Qproj_eq_binWordSum`
（人手 `check_joint_eigenspace_decomposition` (2) の和 `Σ_{ε∈{0,1}^𝓜̌} Q̌_ε`。和は `def_sum_over_binary_words` による）。

人手の `{0,1}^r` の上の和は、最後の成分で `1` を `0` より先に足す帰納法の定義 `def_sum_over_binary_words`（Lean の `binWordSum`）である。
Lean の `sum_Qproj` は、mathlib の `Finset.sum`（足す順序を持たない和）で述べてある。
`binWordSum_eq_sum` は二つが等しいことを述べる。人手の証明の行ではなく、Lean の二つの和をつなぐ等式である。

| 等式の段 | 使うもの |
| --- | --- |
| `r = 0`（`{0,1}^1`） | `binWordSum_zero`（`B_{(1)} + B_{(0)}`）、`{0,1}^1` と `{0,1}` の全単射（`Equiv.funUnique`）、`Fin.sum_univ_two`、和の可換則 |
| `r → r + 1` | `binWordSum_succ`、帰納法の仮定、`Fin.sum_univ_two` と和の可換則（各項へ）、`Fintype.sum_prod_type`、`Fin.snocEquiv`（`(ε', e) ↦ Fin.snoc ε' e`） |

## 何が効いているか / 効いていないか

- `α` は加法についての可換モノイドである。`Finset.sum` が足す順序を持たない和として定まるのに、零元・結合則・可換則が要る。
  全単射による添字の付け替え（`Fintype.sum_equiv`）は、`Finset.sum` がそう定まっていることにだけ依る。
  等式の証明の段で効くのは、`{0,1}` の上の和を `B_{(1)} + B_{(0)}` の順へ並べ替える和の可換則（明示の `add_comm`。`r = 0` の段と、
  `r → r + 1` の各項）と、二重の和を積集合の上の和へまとめる結合則・可換則（`Fintype.sum_prod_type` の中で使われる）である。
  `binWordSum` 自身は `Add α` だけで定まり、零元・結合則・可換則を使わない（`BinaryWordSum.lean`）。この等式で初めてそれらが効く。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Logic.Equiv.Fin.Basic
import Ising2D.NecSuf.BinaryWordSum

namespace Ising2D.NecSuf

open Finset

/-- **`{0,1}^{r+1}` の上の和 `binWordSum` と `Finset.sum` は等しい**（加法についての可換モノイド）。 -/
theorem binWordSum_eq_sum {α : Type*} [AddCommMonoid α] :
    ∀ (r : ℕ) (B : (Fin (r + 1) → Fin 2) → α), binWordSum r B = ∑ ε, B ε
  | 0, B =>
    calc binWordSum 0 B
        = B (fun _ => 1) + B (fun _ => 0) := binWordSum_zero B          -- 和の定義（`r = 0`）
      _ = B (fun _ => 0) + B (fun _ => 1) := add_comm _ _                -- 和の可換則
      _ = ∑ e : Fin 2, B (fun _ => e) := (Fin.sum_univ_two (fun e => B (fun _ => e))).symm
                                                                         -- `{0,1}` の上の和
      _ = ∑ ε : Fin 1 → Fin 2, B ε :=
          Fintype.sum_equiv (Equiv.funUnique (Fin 1) (Fin 2)).symm _ _ (fun _ => rfl)
                                                                         -- `e ↦ (e)` は `{0,1}` から `{0,1}^1` への全単射
  | r + 1, B =>
    calc binWordSum (r + 1) B
        = binWordSum r (fun ε' => B (Fin.snoc (α := fun _ => Fin 2) ε' 1) + B (Fin.snoc (α := fun _ => Fin 2) ε' 0)) :=
          binWordSum_succ r B                                            -- 和の定義（`r → r + 1`）
      _ = ∑ ε' : Fin (r + 1) → Fin 2,
            (B (Fin.snoc (α := fun _ => Fin 2) ε' 1) + B (Fin.snoc (α := fun _ => Fin 2) ε' 0)) :=
          binWordSum_eq_sum r _                                          -- 帰納法の仮定
      _ = ∑ ε' : Fin (r + 1) → Fin 2, ∑ e : Fin 2, B (Fin.snoc (α := fun _ => Fin 2) ε' e) := by
          refine Finset.sum_congr rfl (fun ε' _ => ?_)
          rw [Fin.sum_univ_two, add_comm]                                -- 各項へ `{0,1}` の上の和と和の可換則
      _ = ∑ p : (Fin (r + 1) → Fin 2) × Fin 2, B (Fin.snoc (α := fun _ => Fin 2) p.1 p.2) :=
          (Fintype.sum_prod_type (fun p : (Fin (r + 1) → Fin 2) × Fin 2 =>
            B (Fin.snoc (α := fun _ => Fin 2) p.1 p.2))).symm             -- 二重の和を積集合の上の和へ
      _ = ∑ ε : Fin (r + 2) → Fin 2, B ε :=
          Fintype.sum_equiv ((Equiv.prodComm _ _).trans (Fin.snocEquiv (fun _ => Fin 2))) _ _ (fun _ => rfl)
                                                                         -- `(ε', e) ↦ Fin.snoc ε' e` は全単射（`Fin.snocEquiv`）

end Ising2D.NecSuf
