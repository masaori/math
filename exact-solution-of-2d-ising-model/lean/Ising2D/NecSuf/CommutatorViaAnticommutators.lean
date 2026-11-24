/-
# 反交換子と、交換子を反交換子で書く式（**必要十分版**の側の定義）

対応する人手の項目は `commutator_via_anticommutators`（`[a b, c] = a [b, c]₊ - [a, c]₊ b`）と、
`anticommutator_of_finite_sums_of_scalar_multiples`（反交換子の線型結合の展開）である。
具体版の側では、人手の主張 `commutator_via_anticommutators` は複素行列について
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimCommutatorViaAnticommutators.lean`
の `Ising2D.matComm_mul_eq_matAcomm_sub_matAcomm` が述べ、同じファイルに反交換子 `Ising2D.acomm`（任意の環）と
`acomm_comm`・`sum_smul_mul_sum_smul`・`acomm_sum_smul_left`・`acomm_sum_smul` がある。
具体版の `acomm` とこのファイルの `acomm'` が同じ値であることは、具体版と同じフォルダの
`ClaimCommutatorViaAnticommutatorsFromNecSuf.lean` が述べる。

## 何が効いているか / 効いていないか

| 具体版 | 必要十分版 | 仮定 |
| --- | --- | --- |
| `acomm`（`a b + b a`） | `acomm'`（同じ式） | 環 `R`（同じ） |
| `acomm_comm`（`[a, b]₊ = [b, a]₊`） | `acomm'_comm`（同じ手順） | 環 `R`（同じ） |
| `matComm_mul_eq_matAcomm_sub_matAcomm`（`Mat(n, ℂ)`） | `commutator_via_anticommutators'`（同じ式。証明は定義で展開して `noncomm_ring` で正規化する。具体版は人手証明の 6 段の `calc`） | `Mat(n, ℂ)` → 任意の環 `R` |
| なし（Lie 括弧の形） | `sub_mul_comm_eq_lie'`・`lie_mul_eq_acomm'_sub_acomm'` | 環 `R` |
| `sum_smul_mul_sum_smul`・`acomm_sum_smul_left`・`acomm_sum_smul` | `sum_smul_mul_sum_smul'`・`acomm'_sum_smul_left`・`acomm'_sum_smul`（同じ手順） | 環 `R` 上の可換半環 `S` の代数（同じ） |

* 式は分配律・結合律だけで従うので、係数は具体版の側と同じ任意の環のままにする。
* このファイルを置くのは、反交換子を使う必要十分版（`CliffordIndependence.lean`・`CommutatorClifford.lean`・
  `Fermion.lean`・`FermionLadder.lean`・`FourierClifford.lean`・`SiteLocalAnticomm.lean`・`AntiperiodicFourier.lean`）が
  具体版のファイルを参照せずに済むようにするためである（具体版と必要十分版は互いを参照しない。`lean/README.md`）。
-/
import Mathlib.Algebra.Algebra.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Lie.OfAssociative
import Mathlib.Tactic.NoncommRing

namespace Ising2D.NecSuf

section Ring

variable {R : Type*} [Ring R]

/-- 反交換子 `[a, b]₊ := a b + b a`（具体版の側 `Ising2D.acomm` と同じ式）。 -/
def acomm' (a b : R) : R := a * b + b * a

@[simp]
theorem acomm'_def (a b : R) : acomm' a b = a * b + b * a := rfl

/-- 反交換子は対称（具体版の側 `Ising2D.acomm_comm` と同じ手順）。 -/
theorem acomm'_comm (a b : R) : acomm' a b = acomm' b a := by
  simp [acomm', add_comm]

/-- 交換子 `x y - y x` は mathlib の Lie 括弧と一致する。 -/
theorem sub_mul_comm_eq_lie' (a b : R) : a * b - b * a = ⁅a, b⁆ :=
  (Ring.lie_def a b).symm

/-- `[a b, c] = a [b, c]₊ - [a, c]₊ b`（具体版 `Ising2D.matComm_mul_eq_matAcomm_sub_matAcomm` と同じ式。
証明は右辺を反交換子の定義で展開し、`noncomm_ring` で正規化する。具体版は人手証明の 6 段の `calc`）。 -/
theorem commutator_via_anticommutators' (a b c : R) :
    (a * b) * c - c * (a * b) = a * acomm' b c - acomm' a c * b := by
  simp only [acomm']
  noncomm_ring

/-- 上を mathlib の Lie 括弧で述べた版。 -/
theorem lie_mul_eq_acomm'_sub_acomm' (a b c : R) :
    ⁅a * b, c⁆ = a * acomm' b c - acomm' a c * b := by
  rw [← sub_mul_comm_eq_lie']
  exact commutator_via_anticommutators' a b c

end Ring

section Bilinear

variable {R : Type*} [Ring R] {S : Type*} [CommSemiring S] [Algebra S R]
variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- 線型結合どうしの積の展開 `(∑ᵢ cᵢ xᵢ)(∑ⱼ dⱼ yⱼ) = ∑ᵢ∑ⱼ (cᵢdⱼ) (xᵢ yⱼ)`
（具体版の側 `Ising2D.sum_smul_mul_sum_smul` と同じ手順）。 -/
theorem sum_smul_mul_sum_smul' (c : ι → S) (d : κ → S) (x : ι → R) (y : κ → R) :
    (∑ i, c i • x i) * (∑ j, d j • y j) = ∑ i, ∑ j, (c i * d j) • (x i * y j) := by
  rw [Finset.sum_mul_sum]
  exact Finset.sum_congr rfl fun i _ =>
    Finset.sum_congr rfl fun j _ => smul_mul_smul_comm _ _ _ _

/-- 反交換子は左の引数について線型: `[∑ᵢ cᵢ xᵢ, y]₊ = ∑ᵢ cᵢ [xᵢ, y]₊`
（具体版の側 `Ising2D.acomm_sum_smul_left` と同じ手順）。 -/
theorem acomm'_sum_smul_left (c : ι → S) (x : ι → R) (y : R) :
    acomm' (∑ i, c i • x i) y = ∑ i, c i • acomm' (x i) y := by
  simp only [acomm', Finset.sum_mul, Finset.mul_sum, Algebra.smul_mul_assoc,
    Algebra.mul_smul_comm, smul_add, Finset.sum_add_distrib]

/-- 反交換子の両引数を線型結合で展開する:
`[∑ᵢ cᵢ xᵢ, ∑ⱼ dⱼ yⱼ]₊ = ∑ᵢ∑ⱼ (cᵢdⱼ) [xᵢ, yⱼ]₊`（具体版の側 `Ising2D.acomm_sum_smul` と同じ手順）。 -/
theorem acomm'_sum_smul (c : ι → S) (d : κ → S) (x : ι → R) (y : κ → R) :
    acomm' (∑ i, c i • x i) (∑ j, d j • y j)
      = ∑ i, ∑ j, (c i * d j) • acomm' (x i) (y j) := by
  have hBA : (∑ j, d j • y j) * (∑ i, c i • x i)
      = ∑ i, ∑ j, (c i * d j) • (y j * x i) := by
    rw [sum_smul_mul_sum_smul', Finset.sum_comm]
    exact Finset.sum_congr rfl fun i _ =>
      Finset.sum_congr rfl fun j _ => by rw [mul_comm]
  rw [acomm', sum_smul_mul_sum_smul', hBA, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun j _ => by rw [acomm', smul_add]

end Bilinear

end Ising2D.NecSuf
