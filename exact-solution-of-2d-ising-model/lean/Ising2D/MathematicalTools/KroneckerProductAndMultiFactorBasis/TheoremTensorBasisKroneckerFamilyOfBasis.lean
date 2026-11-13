/-
# クロネッカー積がつくる基底: 一般の基底のクロネッカー積の族（`<tensor_basis>` (2)）

対応する人手証明:
`structured-latex/content/002_linear_space_general.ts` の `tensor_basis` の (2) と、その証明の Step 4

記号の読み替え（`ClaimKroneckerFamilyOfSpanningFamilySpans.lean` と同じ）:
- 人手の `𝓑 = {b_1, …, b_4}` は Lean の `b : Fin 4 → Mat(2, ℂ)`（添字は `0, …, 3`）、人手の `π(q) ∈ 𝒫 = {1,2,3,4}^M` は
  Lean の `p : Fin M → Fin 4` である。人手は `def_finite_sum_of_matrices` の `1, …, N` の和に合わせて `𝒫` を全単射 `π` で
  並べるが、Lean は `p` を添字とする有限和で書くので、人手 Step 4 の最後の「`π` は全単射なので `(F_q)` は族
  `(b_{a_1} ⊠ ⋯ ⊠ b_{a_M})` の元を並べたもの」の段は Lean には現れない。
- 人手の「基底」は、張ることと線型独立であることの両方である（人手 Step 4 の「張り、かつ線型独立なので基底」）。
  Lean ではこの 2 つを `∧` で並べて述べ、mathlib の `Module.Basis` は使わない。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| (2) の仮定「`𝓑` は基底」の「張る」「線型独立」 | 仮定 `hspan`・`hind` |
| Step 4「`kronecker_family_of_spanning_family_spans` より `(F_q)` は張る」 | `kronecker_family_of_spanning_family_spans` |
| Step 4「`kronecker_family_of_independent_family_is_independent` より `(F_q)` は線型独立」 | `kronecker_family_of_independent_family_is_independent` |
| Step 4「張り、かつ線型独立なので基底」 | `tensor_basis_kronecker_family_of_basis` の `⟨_, _⟩` |

## 必要十分版を置かない理由

Step 4 は、2 つの主張を当てはめて結論を `∧` で並べるだけで、計算を含まない。取り払える構造を示す計算は
2 つの主張の側にあり、それぞれの必要十分版
（`Ising2D/NecSuf/MultilinearImageOfSpanningFamilySpans.lean`・`Ising2D/NecSuf/ProductFamilyOfIndependentFamilyIsIndependent.lean`）が
既にそれを示している。

人手の主張は `M ≥ 1` で述べるが、引く 2 つの主張の Lean が `M` に条件を置かないので、ここでも置かない。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerFamilyOfIndependentFamilyIsIndependent

namespace Ising2D

variable {M : ℕ}

/-- **`<tensor_basis>` (2) の形式化**: `b_1, …, b_4` が `Mat(2, ℂ)` の ℂ-基底（張り、かつ線型独立）ならば、
族 `(b_{a_1} ⊠ ⋯ ⊠ b_{a_M})_{(a_1, …, a_M) ∈ {1,2,3,4}^M}` は `Mat(2^M, ℂ)`（Lean の `TensorPow M`）を張り、
かつ線型独立である。

人手 Step 4: 張ることは `kronecker_family_of_spanning_family_spans`、線型独立であることは
`kronecker_family_of_independent_family_is_independent` による。 -/
theorem tensor_basis_kronecker_family_of_basis (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ)
    (hspan : ∀ A : Matrix (Fin 2) (Fin 2) ℂ, ∃ c : Fin 4 → ℂ, A = ∑ a, c a • b a)
    (hind : ∀ c : Fin 4 → ℂ, ∑ a, c a • b a = 0 → ∀ a, c a = 0) :
    (∀ X : TensorPow M, ∃ d : (Fin M → Fin 4) → ℂ, X = ∑ p, d p • siteProd M (fun k => b (p k)))
      ∧ (∀ d : (Fin M → Fin 4) → ℂ, ∑ p, d p • siteProd M (fun k => b (p k)) = 0 → ∀ p, d p = 0) :=
  ⟨fun X => kronecker_family_of_spanning_family_spans b hspan X,           -- `(F_q)` は張る
    fun d hd => kronecker_family_of_independent_family_is_independent b hind d hd⟩  -- `(F_q)` は線型独立

end Ising2D
