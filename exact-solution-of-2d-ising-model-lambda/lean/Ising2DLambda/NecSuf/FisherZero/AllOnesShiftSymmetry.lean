/-
節「指数を一つ下げた多項式の対称性」の主張の必要十分版。

具体版（`Ising2DLambda.FisherZero.allOnesShift_isQbarSymmetric`）と同じ段
（準備 `(d + 1) ∘ e = d ∘ e + 1` → 置換した多項式の係数 → 指数を一つ下げた係数 → 準備 → 置換した係数 → 不変性 → 指数を一つ下げた係数）
で示し、各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `K` でよい（使う係数の主張 `equivVariable_coeff_necSuf` と同じ仮定）。
- 対称性（全ての置換で不変）は要らない。一つの全単射 `e : σ ≃ σ` について `P` が不変なら、
  `sd(P)` も同じ `e` について不変である。置換ごとに独立に成り立つ。
- 添字集合が有限であることは、指数 `1`（全ての成分が 1）が有限台を持つことと、
  代入を全変数にわたる有限積で書く段（`equivVariable_coeff_necSuf`）で使う。
-/
import Ising2DLambda.NecSuf.FisherZero.SymmetricVanishingShiftedQuotient
import Ising2DLambda.NecSuf.FisherZero.VariablePermutationCoefficient

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommSemiring K]

variable {σ : Type} [Fintype σ] [DecidableEq σ]

omit [DecidableEq σ] in
/-- 準備（具体版 `exponentComp_add_allOnes` と同じ段）。 -/
theorem exponentCompEquiv_add_allOnes (d : σ →₀ ℕ) (e : σ ≃ σ) :
    exponentCompEquiv (d + allOnesExponent σ) e = exponentCompEquiv d e + allOnesExponent σ := by
  ext k
  calc exponentCompEquiv (d + allOnesExponent σ) e k
      = (d + allOnesExponent σ) (e k) := exponentCompEquiv_apply _ e k
    _ = d (e k) + allOnesExponent σ (e k) := Finsupp.add_apply _ _ _
    _ = d (e k) + 1 := by rw [allOnesExponent_apply]
    _ = exponentCompEquiv d e k + allOnesExponent σ k := by
        rw [exponentCompEquiv_apply, allOnesExponent_apply]
    _ = (exponentCompEquiv d e + allOnesExponent σ) k := (Finsupp.add_apply _ _ _).symm

/-- `claim_qbar_all_ones_shift_preserves_symmetry` の必要十分版（具体版と同じ段）。
一つの全単射 `e` について `P` が不変なら、`sd(P)` も `e` について不変。 -/
theorem allOnesShift_equivInvariant_necSuf (e : σ ≃ σ) (P : MvPolynomial σ K)
    (hinv : aeval (fun k => (X (e k) : MvPolynomial σ K)) P = P) :
    aeval (fun k => (X (e k) : MvPolynomial σ K)) (allOnesShiftNecSuf P) = allOnesShiftNecSuf P := by
  ext d
  calc coeff d (aeval (fun k => (X (e k) : MvPolynomial σ K)) (allOnesShiftNecSuf P))
      = coeff (exponentCompEquiv d e) (allOnesShiftNecSuf P) := equivVariable_coeff_necSuf e _ d
    _ = coeff (exponentCompEquiv d e + allOnesExponent σ) P := allOnesShiftNecSuf_coeff _ _
    _ = coeff (exponentCompEquiv (d + allOnesExponent σ) e) P := by
        rw [exponentCompEquiv_add_allOnes]
    _ = coeff (d + allOnesExponent σ) (aeval (fun k => (X (e k) : MvPolynomial σ K)) P) :=
        (equivVariable_coeff_necSuf e P _).symm
    _ = coeff (d + allOnesExponent σ) P := by rw [hinv]
    _ = coeff d (allOnesShiftNecSuf P) := (allOnesShiftNecSuf_coeff P d).symm

end Ising2DLambda.NecSuf.FisherZero
