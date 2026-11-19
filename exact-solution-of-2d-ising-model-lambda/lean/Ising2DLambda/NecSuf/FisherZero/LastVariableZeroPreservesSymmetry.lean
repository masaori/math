/-
節「対称式の基本定理」のうち、末尾の変数への零代入が対称性を保つことの必要十分版。

具体版（`Ising2DLambda.FisherZero` の `lastFixedExtensionFun_inverse`・
`variablePermutationValues_comp_lastVariableZeroValues`・`variablePermutation_lastVariableZero`・
`lastVariableZero_isQbarSymmetric`）と同じ段で示し、各段が実際に使う性質だけを仮定に置く。

- 延長の逆写像: 添字集合 `τ` が「埋め込み `c : σ → τ` の像と一点 `t`」で覆われること
  （場合分け `k < n`・`k = n`）と、延長の二つの値の式だけを使う。`c` が単射であることも、
  `t` が `c` の像の外にあることも使わない。元の写像について使うのは `g ∘ f = id` だけである。
- 値の写像の一致: 元の写像 `f` が全単射であることを使わない（任意の写像でよい）。使うのは、
  覆い、零代入の値（`c k ↦ X k`、`t ↦ 0`）、延長の値、代入が変数を値へ送り零を零へ送ることだけ。
  係数は可換半環 `K` でよい。代入の合成の段では `Q` の変数の集合 `τ` が有限であることを使う。
- 対称性の保存: 多項式であることも代入であることも要らない。写像 `L : A → B` と、`B` 上の各変換
  `vB i` について、`vB i ∘ L = L ∘ vA j` となる `A` 上の変換 `vA j` があれば、`vA` の全てで固定される
  元の `L` による像は `vB` の全てで固定される。
-/
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionLastVariableZero

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

/-- `claim_last_fixed_permutation_extension_is_bijection` の必要十分版（具体版と同じ段）。 -/
theorem fixedPointExtension_inverse_necSuf {σ τ : Type} (c : σ → τ) (t : τ)
    (hcover : ∀ x : τ, x = t ∨ ∃ k, x = c k) (f g : σ → σ) (F G : τ → τ)
    (hFt : F t = t) (hFc : ∀ k, F (c k) = c (f k))
    (hGt : G t = t) (hGc : ∀ k, G (c k) = c (g k))
    (hgf : ∀ k, g (f k) = k) (x : τ) : G (F x) = x := by
  rcases hcover x with hx | ⟨k, hx⟩ <;> rw [hx]
  · -- 末尾の点の場合。
    calc G (F t) = G t := by rw [hFt]
      _ = t := hGt
  · -- 埋め込みの像の場合。
    calc G (F (c k)) = G (c (f k)) := by rw [hFc]
      _ = c (g (f k)) := hGc (f k)
      _ = c k := by rw [hgf k]

variable {K : Type} [CommSemiring K]

/-- `claim_last_variable_zero_commutes_with_variable_permutation` の必要十分版（具体版と同じ段）。 -/
theorem lastPointZero_comm_variableMap_necSuf {σ τ : Type} [Fintype τ] (c : σ → τ) (t : τ)
    (hcover : ∀ x : τ, x = t ∨ ∃ k, x = c k)
    (z : τ → MvPolynomial σ K) (hzt : z t = 0) (hzc : ∀ k, z (c k) = X k)
    (f : σ → σ) (F : τ → τ) (hFt : F t = t) (hFc : ∀ k, F (c k) = c (f k))
    (Q : MvPolynomial τ K) :
    aeval (fun k => (X (f k) : MvPolynomial σ K)) (aeval z Q) =
      aeval z (aeval (fun x => (X (F x) : MvPolynomial τ K)) Q) := by
  -- 準備: 値の写像の一致。
  have hvalues : ∀ x : τ, aeval (fun k => (X (f k) : MvPolynomial σ K)) (z x) =
      aeval z (X (F x) : MvPolynomial τ K) := by
    intro x
    rcases hcover x with hx | ⟨k, hx⟩ <;> rw [hx]
    · calc aeval (fun k => (X (f k) : MvPolynomial σ K)) (z t)
          = aeval (fun k => (X (f k) : MvPolynomial σ K)) 0 := by rw [hzt]
        _ = 0 := map_zero _
        _ = z t := hzt.symm
        _ = aeval z (X t : MvPolynomial τ K) := (aeval_X _ _).symm
        _ = aeval z (X (F t) : MvPolynomial τ K) := by rw [hFt]
    · calc aeval (fun k => (X (f k) : MvPolynomial σ K)) (z (c k))
          = aeval (fun k => (X (f k) : MvPolynomial σ K)) (X k) := by rw [hzc]
        _ = X (f k) := aeval_X _ k
        _ = z (c (f k)) := (hzc (f k)).symm
        _ = aeval z (X (c (f k)) : MvPolynomial τ K) := (aeval_X _ _).symm
        _ = aeval z (X (F (c k)) : MvPolynomial τ K) := by rw [hFc]
  -- 代入の合成、値の写像の一致、代入の合成の逆向き。
  exact mvSubst_comm_of_values_comm_necSuf z (fun k => X (f k)) (fun x => X (F x)) z hvalues Q

/-- `claim_last_variable_zero_preserves_symmetry` の必要十分版（具体版と同じ段）。 -/
theorem invariant_map_of_comm_necSuf {A B I J : Type} (L : A → B) (vA : J → A → A)
    (vB : I → B → B) (lift : I → J) (hcomm : ∀ i a, vB i (L a) = L (vA (lift i) a))
    (P : A) (hP : ∀ j, vA j P = P) (i : I) : vB i (L P) = L P := by
  calc vB i (L P) = L (vA (lift i) P) := hcomm i P
    _ = L P := by rw [hP (lift i)]

end Ising2DLambda.NecSuf.FisherZero
