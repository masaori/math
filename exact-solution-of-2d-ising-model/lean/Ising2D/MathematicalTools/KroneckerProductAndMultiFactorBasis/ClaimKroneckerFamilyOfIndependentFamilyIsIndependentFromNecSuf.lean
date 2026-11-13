/-
# `<kronecker_family_of_independent_family_is_independent>` の具体版を必要十分版から導く

対応する人手証明:
`structured-latex/content/002_linear_space_general.ts` の `kronecker_family_of_independent_family_is_independent`

必要十分版は `Ising2D/NecSuf/ProductFamilyOfIndependentFamilyIsIndependent.lean`。具体版は
`ClaimKroneckerFamilyOfIndependentFamilyIsIndependent.lean` の `kronecker_family_of_independent_family_is_independent` で、
本ファイルは同じ結論を、必要十分版を `R := ℂ`、`ι := Fin 4`、`κ := Fin 2 × Fin 2`、`b' a (u, v) := (b_a)_{uv}` に
特殊化して得る（README 4 節の要件 4）。

必要十分版へ渡す具体的な部分は次の 3 つである。
1. `hb`: `b' : Fin 4 → (Fin 2 × Fin 2 → ℂ)` の線型独立性。行列 `Σ_a c_a b_a` の `(u, v)` 成分が関数 `Σ_a c_a b'_a` の
   `(u, v)` での値であることから、具体版の仮定（行列の等式）を読み替える。
2. `hd`: `Σ_p d_p F'_p = O`（関数の等式）。`F'_p(W)` は左から掛ける積で、ℂ では `Fin M` の上の積
   `Π_k (b_{p_k})_{(W_k)_1 (W_k)_2}` に等しい（`prefixProductOf_eq_prefixEntryProduct` と具体版の `prefixEntryProduct_eq_prod`）。
   したがって `F'_p(W)` は `siteProd M (b ∘ p)` の `(W_·.1, W_·.2)` 成分であり、具体版の仮定から出る。
3. `x₀ := (0, 0)`（具体版の `U₀` の成分）。
-/
import Ising2D.NecSuf.ProductFamilyOfIndependentFamilyIsIndependent
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerFamilyOfIndependentFamilyIsIndependent

namespace Ising2D

variable {M : ℕ}

/-- 行列 `b_a` を、成分の対 `(u, v)` の関数として読んだもの。 -/
def matrixAsPairFunction (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) : Fin 4 → (Fin 2 × Fin 2 → ℂ) :=
  fun a x => b a x.1 x.2

/-- 必要十分版の左から掛ける積は、具体版の `P^{(s)}` を `U := W_·.1`、`V := W_·.2` で読んだものに等しい（同じ漸化式）。 -/
theorem prefixProductOf_eq_prefixEntryProduct (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ) (p : Fin M → Fin 4)
    (W : Fin M → Fin 2 × Fin 2) :
    ∀ s : ℕ, NecSuf.prefixProductOf (matrixAsPairFunction b) p W s
      = prefixEntryProduct b p (fun k => (W k).1) (fun k => (W k).2) s
  | 0 => rfl
  | s + 1 => by
    rw [NecSuf.prefixProductOf, prefixEntryProduct, prefixProductOf_eq_prefixEntryProduct b p W s]
    rfl

/-- **`<kronecker_family_of_independent_family_is_independent>` を必要十分版から導出した形**（具体版と同じ型）。 -/
theorem kronecker_family_of_independent_family_is_independent_of_necSuf
    (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ)
    (hb : ∀ c : Fin 4 → ℂ, ∑ a, c a • b a = 0 → ∀ a, c a = 0)
    (d : (Fin M → Fin 4) → ℂ) (hd : ∑ p, d p • siteProd M (fun k => b (p k)) = 0) :
    ∀ p, d p = 0 := by
  have hb' : ∀ c : Fin 4 → ℂ, ∑ a, c a • matrixAsPairFunction b a = 0 → ∀ a, c a = 0 := by
    intro c hc
    apply hb c
    ext u v
    have := congrFun hc (u, v)
    simpa [Finset.sum_apply, Matrix.sum_apply, matrixAsPairFunction] using this
  have hd' : ∑ p, d p • NecSuf.productFamilyOf (matrixAsPairFunction b) p = 0 := by
    funext W
    have h := congrArg (fun X : TensorPow M => X (fun k => (W k).1) (fun k => (W k).2)) hd
    simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, siteProd_apply, Matrix.zero_apply] at h
    rw [Finset.sum_apply, Pi.zero_apply]
    refine Eq.trans (Finset.sum_congr rfl fun p _ => ?_) h
    rw [Pi.smul_apply, smul_eq_mul, NecSuf.productFamilyOf, prefixProductOf_eq_prefixEntryProduct,
      prefixEntryProduct_eq_prod b p _ _ M le_rfl]
    rfl
  exact NecSuf.productFamilyOf_independent (matrixAsPairFunction b) hb' (0, 0) d hd'

end Ising2D
