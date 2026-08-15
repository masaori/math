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



open Polynomial

/--
代数段の第一歩: モニックで既約な `P` の零点 `x` について、`x` の最小多項式は `P` 自身であり、
したがって最小多項式の次数は `P` の次数に一致する（本文の「最小多項式の一意性」の段）。
-/
theorem minpoly_natDegree_eq_of_irreducible_monic {K L : Type} [Field K] [Field L] [Algebra K L]
    (P : K[X]) (hP : Irreducible P) (hm : P.Monic) (x : L) (hx : aeval x P = 0) :
    (minpoly K x).natDegree = P.natDegree := by
  rw [minpoly.eq_of_irreducible_of_monic hP hx hm]

/--
代数段の第二歩: 標数 `0` の体上の既約多項式は分離的である。代数閉体へ移すと分裂し、
重根が無いので、相異なる零点の個数は多項式の次数に一致する。
-/
theorem irreducible_rootSet_card_eq_natDegree
    {K L : Type} [Field K] [CharZero K] [Field L] [IsAlgClosed L]
    [Algebra K L] [FaithfulSMul K L] (P : K[X]) (hP : Irreducible P) :
    Fintype.card (P.rootSet L) = P.natDegree := by
  exact card_rootSet_eq_natDegree hP.separable (IsAlgClosed.splits _)


/--
代数段の第三歩（前半）: 標数 `0` の体上の既約多項式を代数閉体へ移すと、各零点の
代数的重複度は高々 `1` である（分離的なので根の多重集合に重複が無い）。
-/
theorem irreducible_rootMultiplicity_le_one
    {K L : Type} [Field K] [CharZero K] [Field L] [Algebra K L] [DecidableEq L]
    (P : Polynomial K) (hP : Irreducible P) (x : L) :
    Polynomial.rootMultiplicity x (Polynomial.map (algebraMap K L) P) ≤ 1 := by
  rw [← Polynomial.count_roots]
  exact Multiset.nodup_iff_count_le_one.mp
    (Polynomial.nodup_roots (Polynomial.Separable.map hP.separable)) x

/--
代数段の第三歩（後半）: 既約因子 `P` の零点 `x` は `P` 自身では重複度 `1` であり、
`P ^ e` では積を一つずつ増やすたびに重複度が `1` ずつ増えるので、重複度は指数 `e` に等しい。
-/
theorem irreducible_rootMultiplicity_pow_eq_exponent
    {K L : Type} [Field K] [CharZero K] [Field L] [Algebra K L] [DecidableEq L]
    (P : Polynomial K) (hP : Irreducible P) (x : L)
    (hx : Polynomial.IsRoot (Polynomial.map (algebraMap K L) P) x) (e : ℕ) :
    Polynomial.rootMultiplicity x ((Polynomial.map (algebraMap K L) P) ^ e) = e := by
  let Q := Polynomial.map (algebraMap K L) P
  have hQ : Q ≠ 0 := Polynomial.map_ne_zero hP.ne_zero
  have hQMultiplicityPos : 0 < Polynomial.rootMultiplicity x Q :=
    (Polynomial.rootMultiplicity_pos hQ).2 hx
  have hQMultiplicity : Polynomial.rootMultiplicity x Q = 1 :=
    Nat.le_antisymm
      (irreducible_rootMultiplicity_le_one P hP x)
      hQMultiplicityPos
  induction e with
  | zero => simp
  | succ e ih =>
      rw [pow_succ]
      rw [Polynomial.rootMultiplicity_mul (mul_ne_zero (pow_ne_zero e hQ) hQ)]
      rw [ih, hQMultiplicity]

/--
代数段の第四歩: モニックで既約な二つの因子 `P` と `Q` が共通の零点 `x` を持てば、
`x` の最小多項式が `P` にも `Q` にも等しいので `P = Q` である。
対偶として、相異なるモニック既約因子は零点を共有しない（本文の「因子間で零点を共有しない」の段）。
-/
theorem irreducible_monic_eq_of_common_root {K L : Type} [Field K] [Field L] [Algebra K L]
    (P Q : K[X]) (hP : Irreducible P) (hPm : P.Monic) (hQ : Irreducible Q) (hQm : Q.Monic)
    (x : L) (hxP : aeval x P = 0) (hxQ : aeval x Q = 0) : P = Q := by
  exact (minpoly.eq_of_irreducible_of_monic hP hxP hPm).trans
    (minpoly.eq_of_irreducible_of_monic hQ hxQ hQm).symm

end Ising3DCut.NullModel
