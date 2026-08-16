/-
人手証明「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の第二歩
（`Σ_σ X ^ #B(σ) = Σ_m Ω(m) X^m`、水準集合で束ねる）の必要十分版。

  使っている性質                       なぜ削れないか
  `Fintype Configuration`               配位についての有限和を水準集合ごとに束ねるため。
  `DecidableEq ℕ`（自動）               水準集合 `{σ | f σ = m}` を Finset で切り出すため。
  破れ数の上界 `f σ ≤ N`                和の添字を `0..N` の有限範囲へ収めるため。
  係数環 `R` の `CommSemiring`          一変数多項式環の最小の構造。

具体版が持っていた次の構造は仮定しない: 係数環が `ℤ`、箱型 `Config L`・`Edge L`、
破れ集合の定義（`f` は配位から自然数への任意の写像でよい）。

住処: 一変数多項式環（可換半環係数）と自然数の数え上げ。ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Polynomial.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising3DCut.NecSuf

open Polynomial

variable {Configuration R : Type*} [CommSemiring R] [Fintype Configuration]

theorem sum_X_pow_eq_sum_levelSet_card_smul
    (f : Configuration → ℕ) (N : ℕ) (hN : ∀ σ, f σ ≤ N) :
    ∑ σ : Configuration, (Polynomial.X : Polynomial R) ^ f σ =
      ∑ m ∈ Finset.range (N + 1),
        (Finset.univ.filter fun σ : Configuration => f σ = m).card •
          (Polynomial.X : Polynomial R) ^ m := by
  have hmaps :
      ∀ σ ∈ (Finset.univ : Finset Configuration), f σ ∈ Finset.range (N + 1) := by
    intro σ _
    rw [Finset.mem_range, Nat.lt_succ_iff]
    exact hN σ
  rw [← Finset.sum_fiberwise_of_maps_to hmaps]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [Finset.sum_congr rfl (fun σ hσ => by rw [(Finset.mem_filter.mp hσ).2]),
    Finset.sum_const]

end Ising3DCut.NecSuf
