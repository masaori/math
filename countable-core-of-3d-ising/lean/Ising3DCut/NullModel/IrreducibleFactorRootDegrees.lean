/-
人手証明の主張「既約分解の型が零点の最小多項式次数を決める」
（ラベル `claim_factorization_type_determines_root_minimal_degrees`）の具体版。

既約因子 `j` の相異なる零点を `Fin (degree j)`、各零点の代数的重複を
`Fin (exponent j)` で具体的に添字づける。人手証明の代数部分で得た
「零点数 = 次数」「最小多項式次数 = 因子次数」「代数的重複度 = 因子指数」
をこの添字づけに保持し、最後の有限多重集合の組み立てを形式化する。

住処: 有限型と自然数だけであり、非可算な量は現れない。
-/
import Mathlib

namespace Ising3DCut.NullModel

/-- 既約因子 `j` の相異なる零点を、その次数で添字づける。 -/
abbrev FactorRoot {J : Type} (degree : J → ℕ) := Σ j, Fin (degree j)

/-- 各零点を、その既約因子の指数だけ反復した、代数的重複度込みの零点。 -/
abbrev RepeatedFactorRoot {J : Type} (degree exponent : J → ℕ) :=
  Σ r : FactorRoot degree, Fin (exponent r.1)

/-- 零点のモニック最小多項式の次数は、それが属する既約因子の次数である。 -/
def rootMinimalPolynomialDegree {J : Type} {degree exponent : J → ℕ}
    (r : RepeatedFactorRoot degree exponent) : ℕ :=
  degree r.1.1

/--
`claim_factorization_type_determines_root_minimal_degrees` の具体版。
各既約因子 `j` は `degree j` 個の相異なる零点を持ち、各零点が `exponent j` 回
現れるので、次数 `degree j` は `exponent j * degree j` 回現れる。
-/
theorem factorizationType_determines_rootMinimalPolynomialDegrees
    {J : Type} [Fintype J] [DecidableEq J]
    (degree exponent : J → ℕ) (n : ℕ) :
    Fintype.card { r : RepeatedFactorRoot degree exponent //
      rootMinimalPolynomialDegree r = n } =
      ∑ j : {j : J // degree j = n}, exponent j * degree j := by
  classical
  let e : { r : RepeatedFactorRoot degree exponent //
      rootMinimalPolynomialDegree r = n } ≃
      Σ j : {j : J // degree j = n}, Fin (degree j) × Fin (exponent j) :=
    { toFun := fun r => ⟨⟨r.1.1.1, r.2⟩, r.1.1.2, r.1.2⟩
      invFun := fun r => ⟨⟨⟨r.1.1, r.2.1⟩, r.2.2⟩, r.1.2⟩
      left_inv := by intro r; cases r; rfl
      right_inv := by intro r; cases r; rfl }
  rw [Fintype.card_congr e, Fintype.card_sigma]
  simp [Nat.mul_comm]

end Ising3DCut.NullModel

namespace Ising3DCut.NullModel

open Polynomial

/--
代数段の第一歩: モニックで既約な `P` の零点 `x` について、`x` の最小多項式は `P` 自身であり、
したがって最小多項式の次数は `P` の次数に一致する（本文の「最小多項式の一意性」の段）。
-/
theorem minpoly_natDegree_eq_of_irreducible_monic {K L : Type} [Field K] [Field L] [Algebra K L]
    (P : K[X]) (hP : Irreducible P) (hm : P.Monic) (x : L) (hx : aeval x P = 0) :
    (minpoly K x).natDegree = P.natDegree := by
  rw [minpoly.eq_of_irreducible_of_monic hP hx hm]

end Ising3DCut.NullModel
