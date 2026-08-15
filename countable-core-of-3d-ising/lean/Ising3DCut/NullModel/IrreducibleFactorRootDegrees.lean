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
import Mathlib.Data.Multiset.Bind
import Mathlib.Data.Multiset.Filter

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

/--
代数段から有限数え上げ段への結合の第一歩: 既約因子の冪の有限積について、積多項式の
零点の多重集合は、各因子の零点の多重集合をその指数だけ反復して結合したものに等しい。
したがって、右辺は因子ごとのタグ付き零点ではなく、積多項式そのものの零点を
代数的重複度込みで列挙している。
-/
theorem irreducibleFactorProduct_roots_eq_bind
    {J K L : Type} [Fintype J] [DecidableEq J]
    [Field K] [Field L] [Algebra K L]
    (P : J → K[X]) (exponent : J → ℕ)
    (hIrreducible : ∀ j, Irreducible (P j)) :
    (∏ j : J, (Polynomial.map (algebraMap K L) (P j)) ^ exponent j).roots =
      Finset.univ.val.bind fun j =>
        exponent j • (Polynomial.map (algebraMap K L) (P j)).roots := by
  rw [Polynomial.roots_prod]
  · simp only [Polynomial.roots_pow]
  · exact Finset.prod_ne_zero_iff.mpr fun j _ =>
      pow_ne_zero _ (Polynomial.map_ne_zero (hIrreducible j).ne_zero)

/-- 既約因子の実際の零点を、因子指数だけ反復した有限型。 -/
abbrev RepeatedPolynomialRoot {J K : Type} [Field K]
    (L : Type) [Field L] [Algebra K L] (P : J → K[X]) (exponent : J → ℕ) :=
  Σ r : (Σ j, (P j).rootSet L), Fin (exponent r.1)

/-- 反復した実際の零点に、そのモニック最小多項式の次数を記録する。 -/
noncomputable def repeatedPolynomialRootMinpolyDegree {J K L : Type} [Field K] [Field L] [Algebra K L]
    {P : J → K[X]} {exponent : J → ℕ} (r : RepeatedPolynomialRoot L P exponent) : ℕ :=
  (minpoly K (r.1.2 : L)).natDegree

/--
本文の主張そのものの具体版。モニック既約因子の実際の相異なる零点を因子指数だけ反復すると、
最小多項式次数 `n` の零点数は、次数 `n` の因子ごとの `指数 × 次数` の有限和になる。
-/
theorem irreducibleFactorizationType_determines_rootMinimalPolynomialDegrees
    {J K L : Type} [Fintype J] [DecidableEq J]
    [Field K] [CharZero K] [Field L] [IsAlgClosed L]
    [Algebra K L] [FaithfulSMul K L]
    (P : J → K[X]) (exponent : J → ℕ)
    (hIrreducible : ∀ j, Irreducible (P j)) (hMonic : ∀ j, (P j).Monic)
    (n : ℕ) :
    Fintype.card {r : RepeatedPolynomialRoot L P exponent //
      repeatedPolynomialRootMinpolyDegree r = n} =
      ∑ j : {j : J // (P j).natDegree = n}, exponent j * (P j).natDegree := by
  classical
  let rootEquiv : ∀ j : J, (P j).rootSet L ≃ Fin (P j).natDegree := fun j =>
    Fintype.equivFinOfCardEq (irreducible_rootSet_card_eq_natDegree (P j) (hIrreducible j))
  let repeatedEquiv : RepeatedPolynomialRoot L P exponent ≃
      RepeatedFactorRoot (fun j => (P j).natDegree) exponent :=
    { toFun := fun r => ⟨⟨r.1.1, rootEquiv r.1.1 r.1.2⟩, r.2⟩
      invFun := fun r => ⟨⟨r.1.1, (rootEquiv r.1.1).symm r.1.2⟩, r.2⟩
      left_inv := by intro r; cases r; simp
      right_inv := by intro r; cases r; simp }
  let restrictedEquiv : {r : RepeatedPolynomialRoot L P exponent //
      repeatedPolynomialRootMinpolyDegree r = n} ≃
      {r : RepeatedFactorRoot (fun j => (P j).natDegree) exponent //
        rootMinimalPolynomialDegree r = n} :=
    Equiv.subtypeEquiv repeatedEquiv (by
      intro r
      change (minpoly K (r.1.2 : L)).natDegree = n ↔ (P r.1.1).natDegree = n
      have hr : aeval (r.1.2 : L) (P r.1.1) = 0 :=
        (Polynomial.mem_rootSet_of_ne (hIrreducible r.1.1).ne_zero).mp r.1.2.2
      rw [minpoly_natDegree_eq_of_irreducible_monic
        (P r.1.1) (hIrreducible r.1.1) (hMonic r.1.1) (r.1.2 : L) hr])
  rw [Fintype.card_congr restrictedEquiv]
  exact factorizationType_determines_rootMinimalPolynomialDegrees
    (fun j => (P j).natDegree) exponent n

/--
本文の主張そのものの結合。有限積の零点の多重集合へ最小多項式次数を写したとき、
次数 `n` の出現回数は、次数 `n` の既約因子ごとの `指数 × 次数` の有限和になる。
上の有限積の零点結合補題を使うので、因子ごとのタグ付き零点だけでなく、積多項式
そのものの零点を代数的重複度込みで数えている。
-/
theorem irreducibleFactorProduct_count_rootMinimalPolynomialDegree
    {J K L : Type} [Fintype J] [DecidableEq J]
    [Field K] [CharZero K] [Field L] [IsAlgClosed L]
    [Algebra K L] [FaithfulSMul K L] [DecidableEq L]
    (P : J → K[X]) (exponent : J → ℕ)
    (hIrreducible : ∀ j, Irreducible (P j)) (hMonic : ∀ j, (P j).Monic)
    (n : ℕ) :
    Multiset.count n
      ((∏ j : J, (Polynomial.map (algebraMap K L) (P j)) ^ exponent j).roots.map
        fun x ↦ (minpoly K x).natDegree) =
      ∑ j : J, if (P j).natDegree = n then exponent j * (P j).natDegree else 0 := by
  classical
  rw [irreducibleFactorProduct_roots_eq_bind P exponent hIrreducible]
  rw [Multiset.map_bind, Multiset.count_bind]
  simp only [Multiset.map_nsmul, Multiset.count_nsmul]
  apply Finset.sum_congr rfl
  intro j _
  have hDegree : ∀ x ∈ (Polynomial.map (algebraMap K L) (P j)).roots,
      (minpoly K x).natDegree = (P j).natDegree := by
    intro x hx
    have hxRoot : Polynomial.IsRoot (Polynomial.map (algebraMap K L) (P j)) x :=
      (Polynomial.mem_roots (Polynomial.map_ne_zero (hIrreducible j).ne_zero)).mp hx
    exact minpoly_natDegree_eq_of_irreducible_monic
      (P j) (hIrreducible j) (hMonic j) x
      (by simpa [Polynomial.IsRoot] using hxRoot)
  rw [Multiset.count_map]
  by_cases h : (P j).natDegree = n
  · simp only [h, if_true]
    have hFilter :
        Multiset.filter (fun x ↦ n = (minpoly K x).natDegree)
          (Polynomial.map (algebraMap K L) (P j)).roots =
          (Polynomial.map (algebraMap K L) (P j)).roots :=
      Multiset.filter_eq_self.2 fun x hx ↦ h.symm.trans (hDegree x hx).symm
    rw [hFilter]
    rw [← (IsAlgClosed.splits (Polynomial.map (algebraMap K L) (P j))).natDegree_eq_card_roots]
    simp [h]
  · simp only [h, if_false]
    have hFilter :
        Multiset.filter (fun x ↦ n = (minpoly K x).natDegree)
          (Polynomial.map (algebraMap K L) (P j)).roots = 0 :=
      Multiset.filter_eq_nil.2 fun x hx hnx ↦
        h ((hDegree x hx).symm.trans hnx.symm)
    rw [hFilter]
    simp

end Ising3DCut.NullModel
