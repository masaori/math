/-
節「零代入で消える対称多項式の係数」の具体版。

  人手証明                                                          このファイル
  主張 `claim_symmetric_vanishing_last_variable_coefficient_support` `symmetricVanishing_coeff_eq_zero`
    準備（互換 τ で末尾の指数を零にする。a ∘ τ = ez_n((a ∘ τ)|_{<n})）
                                                                    `swapLast_exponentComp_eq_zeroExtension`
    第一の等号（対称性）                                            `IsQbarSymmetric`
    第二の等号（変数を置換した多項式の係数）                        `variablePermutation_coeff`
    第三の等号（準備）                                              `swapLast_exponentComp_eq_zeroExtension`
    第四の等号（末尾の変数に零を代入した多項式の係数）              `lastVariableZero_coeff`
    第五・第六の等号（仮定 lz_n(P) = 0 と零元の係数）               `MvPolynomial.coeff_zero`

本文の互換 τ（`τ(k) = n`、`τ(n) = k`、他は動かさない）は `Equiv.swap k (Fin.last n)`。
本文の制限 `(a ∘ τ)|_{<n}` は `Finsupp.comapDomain Fin.castSucc` で書く。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.VariablePermutationCoefficient

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `claim_symmetric_vanishing_last_variable_coefficient_support` の準備。
`a(k) = 0` なら、互換 `τ = (k n)` について `a ∘ τ = ez_n((a ∘ τ)|_{<n})`。 -/
theorem swapLast_exponentComp_eq_zeroExtension {n : ℕ} (a : Fin (n + 1) →₀ ℕ) (k : Fin (n + 1))
    (hk : a k = 0) :
    exponentComp a (Equiv.swap k (Fin.last n)) =
      exponentZeroExtension
        (Finsupp.comapDomain Fin.castSucc (exponentComp a (Equiv.swap k (Fin.last n)))
          (Fin.castSucc_injective n).injOn) := by
  ext i
  induction i using Fin.lastCases with
  | last =>
    -- (a ∘ τ)(n) = a(τ(n)) = a(k) = 0 = ez_n(…)(n)。
    rw [exponentZeroExtension_last, exponentComp_apply, Equiv.swap_apply_right, hk]
  | cast j =>
    -- j < n では ez_n(b)(j) = b(j) = (a ∘ τ)(j)。
    rw [exponentZeroExtension_castSucc, Finsupp.comapDomain_apply]

/-- `claim_symmetric_vanishing_last_variable_coefficient_support` の具体版。
対称で `lz_n(P) = 0` の `P` について、`a(k) = 0` となる `k` があれば `mco_a(P) = 0`。 -/
theorem symmetricVanishing_coeff_eq_zero {n : ℕ} (P : QbarMvPoly (n + 1))
    (hsym : IsQbarSymmetric P) (hlz : lastVariableZero n P = 0)
    (a : Fin (n + 1) →₀ ℕ) (k : Fin (n + 1)) (hk : a k = 0) :
    coeff a P = 0 := by
  calc coeff a P
      -- 第一の等号: 対称性 vs_τ(P) = P。
      = coeff a (variablePermutation (n + 1) (Equiv.swap k (Fin.last n)) P) := by
        rw [hsym (Equiv.swap k (Fin.last n))]
      -- 第二の等号: 変数を置換した多項式の係数。
    _ = coeff (exponentComp a (Equiv.swap k (Fin.last n))) P :=
        variablePermutation_coeff (Equiv.swap k (Fin.last n)) P a
      -- 第三の等号: 準備。
    _ = coeff (exponentZeroExtension
          (Finsupp.comapDomain Fin.castSucc (exponentComp a (Equiv.swap k (Fin.last n)))
            (Fin.castSucc_injective n).injOn)) P := by
        rw [← swapLast_exponentComp_eq_zeroExtension a k hk]
      -- 第四の等号: 末尾の変数に零を代入した多項式の係数。
    _ = coeff (Finsupp.comapDomain Fin.castSucc (exponentComp a (Equiv.swap k (Fin.last n)))
          (Fin.castSucc_injective n).injOn) (lastVariableZero n P) :=
        (lastVariableZero_coeff P _).symm
      -- 第五の等号: 仮定 lz_n(P) = 0。
    _ = coeff (Finsupp.comapDomain Fin.castSucc (exponentComp a (Equiv.swap k (Fin.last n)))
          (Fin.castSucc_injective n).injOn) (0 : QbarMvPoly n) := by
        rw [hlz]
      -- 第六の等号: 零元の係数は零。
    _ = 0 := coeff_zero _

end Ising2DLambda.FisherZero
