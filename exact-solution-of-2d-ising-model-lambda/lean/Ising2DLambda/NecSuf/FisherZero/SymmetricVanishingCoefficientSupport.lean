/-
節「零代入で消える対称多項式の係数」の主張の必要十分版。

具体版（`Ising2DLambda.FisherZero.symmetricVanishing_coeff_eq_zero`）と同じ段
（対称性 → 変数を置換した多項式の係数 → 互換で末尾の指数を零にする → 零代入の係数 → 仮定 → 零元の係数）で示し、
各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `K` でよい。体であること・零因子が無いこと・符号反転は使わない
  （使う二つの係数の主張 `equivVariable_coeff_necSuf`・`lastVariableZero_coeff_necSuf` と同じ仮定）。
- 対称であること（全ての置換で不変）は要らない。使うのは、指数が零になる添字 `k` と末尾 `n` を入れ替える
  互換ただ一つについての不変性 `vs_{(k n)}(P) = P` だけである。
- 末尾の変数への零代入が消すこと `lz_n(P) = 0` は、互換で移した指数 `a ∘ (k n)` の係数を読む段でだけ使う。
-/
import Ising2DLambda.NecSuf.FisherZero.VariablePermutationCoefficient

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommSemiring K]

/-- 準備（具体版 `swapLast_exponentComp_eq_zeroExtension` と同じ段）。 -/
theorem swapLast_exponentCompEquiv_eq_zeroExtension {n : ℕ} (a : Fin (n + 1) →₀ ℕ) (k : Fin (n + 1))
    (hk : a k = 0) :
    exponentCompEquiv a (Equiv.swap k (Fin.last n)) =
      exponentZeroExtension
        (Finsupp.comapDomain Fin.castSucc (exponentCompEquiv a (Equiv.swap k (Fin.last n)))
          (Fin.castSucc_injective n).injOn) := by
  ext i
  induction i using Fin.lastCases with
  | last =>
    rw [exponentZeroExtension_last, exponentCompEquiv_apply, Equiv.swap_apply_right, hk]
  | cast j =>
    rw [exponentZeroExtension_castSucc, Finsupp.comapDomain_apply]

/-- `claim_symmetric_vanishing_last_variable_coefficient_support` の必要十分版
（具体版 `symmetricVanishing_coeff_eq_zero` と同じ段）。
仮定は互換 `(k n)` ただ一つについての不変性と `lz_n(P) = 0`。 -/
theorem swapInvariantVanishing_coeff_eq_zero_necSuf {n : ℕ} (P : MvPolynomial (Fin (n + 1)) K)
    (a : Fin (n + 1) →₀ ℕ) (k : Fin (n + 1))
    (hswap : aeval (fun i => (X (Equiv.swap k (Fin.last n) i) : MvPolynomial (Fin (n + 1)) K)) P = P)
    (hlz : lastVariableZeroNecSuf n P = 0) (hk : a k = 0) :
    coeff a P = 0 := by
  calc coeff a P
      = coeff a (aeval (fun i => (X (Equiv.swap k (Fin.last n) i) : MvPolynomial (Fin (n + 1)) K)) P) := by
        rw [hswap]
    _ = coeff (exponentCompEquiv a (Equiv.swap k (Fin.last n))) P :=
        equivVariable_coeff_necSuf (Equiv.swap k (Fin.last n)) P a
    _ = coeff (exponentZeroExtension
          (Finsupp.comapDomain Fin.castSucc (exponentCompEquiv a (Equiv.swap k (Fin.last n)))
            (Fin.castSucc_injective n).injOn)) P := by
        rw [← swapLast_exponentCompEquiv_eq_zeroExtension a k hk]
    _ = coeff (Finsupp.comapDomain Fin.castSucc (exponentCompEquiv a (Equiv.swap k (Fin.last n)))
          (Fin.castSucc_injective n).injOn) (lastVariableZeroNecSuf n P) :=
        (lastVariableZero_coeff_necSuf P _).symm
    _ = coeff (Finsupp.comapDomain Fin.castSucc (exponentCompEquiv a (Equiv.swap k (Fin.last n)))
          (Fin.castSucc_injective n).injOn) (0 : MvPolynomial (Fin n) K) := by
        rw [hlz]
    _ = 0 := coeff_zero _

end Ising2DLambda.NecSuf.FisherZero
