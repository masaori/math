/-
# 数ベクトルのクロネッカー積 `v_1 ⊠ ⋯ ⊠ v_M`（**具体版**）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_000_definition_kronecker_product`、ラベル **`def_kronecker`** の (1)）

## 人手の定義との対応

| 人手 | Lean |
| --- | --- |
| (1) `v_1, …, v_M ∈ ℂ^2` に対し `(v_1⊠⋯⊠v_M)_{ν(I)} := Π_{k=1}^{M} (v_k)_{i_k}` | `vecKron M v`（成分は `vecKron_apply` で `rfl`） |

- 人手の `v_1, …, v_M ∈ ℂ^2` は Lean の `v : Fin M → Fin 2 → ℂ` である（人手の `v_k` は `v (k - 1)`、人手の成分の番号 `1, 2` は `0, 1`）。
- 人手は多重添字 `I ∈ 𝓘_M = {1,2}^M` を番号 `ν(I) ∈ {1, …, 2^M}` と同一視して成分を並べる。Lean のベクトルは添字型 `Conf M = Fin M → Fin 2`
  の上の関数で、`I : Conf M` がそのまま人手の `ν(I)` を表す（行列の (2) の `siteProd`（`Ising2D/Representation.lean`）と同じ。
  `ν` の式との一致は `PartitionFunction/TransferMatrixRepresentation/ClaimConfigNumberingEqualsKroneckerNumbering.lean`）。
- 人手の有限積 `Π_{k=1}^{M}`（`def_finite_product_of_complex_numbers`）は Lean の `∏ k, …`（ℂ の `Finset.prod`）である。

行列のクロネッカー積（人手の (2)）は `siteProd`（`Ising2D/Representation.lean`）にある。
必要十分版は `Ising2D/NecSuf/KroneckerProductRuleOnVectors.lean` の `NecSuf.vecKron'`（係数は `Mul` だけ、各因子の添字は任意の型）。
-/
import Ising2D.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2D

/-- **人手 `def_kronecker` (1)**: `(v_1⊠⋯⊠v_M)_{ν(I)} := Π_{k=1}^{M} (v_k)_{i_k}`。 -/
noncomputable def vecKron (M : ℕ) (v : Fin M → Fin 2 → ℂ) : Conf M → ℂ :=
  fun I => ∏ k, v k (I k)

/-- `def_kronecker` (1) の成分の式。 -/
theorem vecKron_apply (M : ℕ) (v : Fin M → Fin 2 → ℂ) (I : Conf M) :
    vecKron M v I = ∏ k, v k (I k) := rfl

end Ising2D
