/-
# 命題 W\* の整数への降下（Euler の係数行列を整数の Hankel 行列として書く）

対応する人手証明:

* 本文ブロック `paper_wstar_different`（命題 W\*）
  （`structured-latex/content/004_lambda_finite.ts`）の第 2 段・第 3 段

## このファイルが担当する範囲

`WStarElementaryDivisors.lean` は Euler の双対基底公式を行列の等式 $C\,G=M_\eta$ として入れたが、
それは体 $K$ の上の等式であり、人手証明が使う「$C\in GL_r(\mathbb{Z})$ だから
$G$ と $M_\eta$ の余核が同型」という整数の言明には届いていなかった。
残っていたのは 2 つで、どちらも mathlib の欠落ではなくこちらの未記述である、と台帳に書いてあった:

1. $C$ の成分が整数であること。
2. 行列の像と $\eta A$ を基底で同一視する配線。

本ファイルはこの 2 つを埋める。埋め方は台帳が予定していた道
（`coeff_minpolyDiv_mem_adjoin` で所属を言い、それを座標へ翻訳する）ではない。
実際に書いてみると、**$C$ の成分は「整数である」より強く、$\rho$ の係数そのものである**:

$$ C_{ij}=\rho_{i+j+1}. $$

すなわち $C$ は $\rho$ の係数を並べた Hankel 行列で、反対角線より下が $0$、
反対角線が $\rho_r=1$ である。したがって $\det C=\pm1$ が
（三角行列の行列式ひとつで）出る。所属の議論も座標への翻訳も要らなくなった。

## 何が入ったか

1. `eulerHankel`（$\rho$ の係数の Hankel 行列）と `isUnit_det_eulerHankel`（$\det=\pm1$）。
   これは可換環の上で成り立ち、体も分離性も既約性も使わない。
2. `coeff_minpolyDiv_eq_sum`——$\rho(y)/(y-\theta)$ の $y^i$ の係数が
   $\sum_j \rho_{i+j+1}\theta^j$ に等しいこと。mathlib の漸化式 `coeff_minpolyDiv`
   （$c_i=\rho_{i+1}+c_{i+1}\theta$）からの降下帰納法で出る。
3. `eulerMatrix_eq_eulerHankel`——`WStarElementaryDivisors.lean` の
   `eulerMatrix`（体の上で基底の座標として定義したもの）が、
   1 の整数 Hankel 行列の像であること。これが「$C$ の整数への降下」の中身である。
4. `isLeast_isPLevel_range_of_euler`——**降下そのもの**。
   可逆な整数行列 $C$ と $C\,G=M_\eta$ から、$G$ の像の $p$ レベルが
   $\eta A$ の $p$ レベルに等しいことを出す。これが人手証明の
   「$\operatorname{coker}(G)\cong A/\eta A$ だから $G$ の単因子は $A/\eta A$ の不変量」の中身であり、
   `WStarElementaryDivisors.lean` の `isLeast_isPLevel_ideal` と繋がって
   $w^*=\min\{j:\ p^j\eta^{-1}\in A_{(p)}\}$ を与える。

## 何が入っていないか（命題 W\* が完了でない理由）

**$\rho$ が可約な場合の Euler の等式そのもの。** 本ファイルの 4 は
「$C\,G=M_\eta$ が与えられたら」という形の降下であり、その仮定を供給するのは
`WStarElementaryDivisors.lean` の `eulerMatrix_mul_weightedGram` である。
そちらは `PowerBasis K L`（$L$ は体）を使っており、$\rho$ が既約な場合しか覆っていない。
$\rho$ が可約なとき $A\otimes\mathbb{Q}$ は体でなく体の積であり、
mathlib のトレース双対（`Module.Basis.traceDual`）も双対基底（`LinearMap.BilinForm.dualBasis`）も
体の上にしか無い（2026-08-04 実測。`lean/logs/mathlib-gap-survey-cycle30-euler.log`）。
これは配線の欠落ではなく素材の欠落であり、可換環の上の Euler の双対基底公式
$\operatorname{Tr}_{A/R}(c_i\theta^j)=\delta_{ij}$ を自前で書くことになる。

* **その可換環版は cycle 36 step 1 で書いた**（`EulerDualBasisCommRing.lean`）。
  **本ファイルはそれを書いていない**ので、可約な場合を使うときはそちらを見ること。

## 形式化して分かったこと

* **$C$ の成分の整数性は、証明すべきことではなく定義から見えることだった。**
  台帳は `coeff_minpolyDiv_mem_adjoin`（$c_i\in R[\theta]$）を経由する予定と書いていたが、
  実際には係数がそのまま $\rho_{i+j+1}$ なので、所属を経由せずに等式で書ける。
* **降下の段に環の構造も分離性も要らない。** 効くのは
  「可逆な行列を左から掛けても像は同型に移る」ことだけである。
-/
import Mathlib
import IntegrableLattice.WStarElementaryDivisors

namespace IntegrableLattice

open Finset Module Polynomial

/-! ## 1. Euler の係数行列は $\rho$ の係数の Hankel 行列である

$\rho(y)/(y-\theta)=\sum_i c_i y^i$ の $c_i$ を $1,\theta,\dots,\theta^{r-1}$ で展開したときの
係数は $\rho$ の係数そのものである。ここではその行列を先に定義し、
行列式が $\pm1$ であることを（体を使わずに）示す。 -/

section EulerHankel

variable {R : Type*} [CommRing R]

/-- **Euler の係数行列**を $\rho$ の係数で直接書いたもの。第 $(i,j)$ 成分は $\rho_{i+j+1}$。 -/
def eulerHankel (ρ : R[X]) (r : ℕ) : Matrix (Fin r) (Fin r) R :=
  Matrix.of fun i j => ρ.coeff (i.val + j.val + 1)

/-- 反対角線より下（$i+j+1>r$）は $0$。次数が $r$ であることだけを使う。 -/
theorem eulerHankel_apply_of_lt {ρ : R[X]} {r : ℕ} (hdeg : ρ.natDegree = r)
    {i j : Fin r} (h : r < i.val + j.val + 1) : eulerHankel ρ r i j = 0 := by
  refine coeff_eq_zero_of_natDegree_lt ?_
  omega

/-- 反対角線（$i+j+1=r$）は $1$。モニックであることを使う。 -/
theorem eulerHankel_apply_antidiag {ρ : R[X]} {r : ℕ} (hmon : ρ.Monic) (hdeg : ρ.natDegree = r)
    {i j : Fin r} (h : i.val + j.val + 1 = r) : eulerHankel ρ r i j = 1 := by
  have : ρ.coeff r = 1 := by rw [← hdeg]; exact hmon
  simpa [eulerHankel, h] using this

/-- 列を逆順に並べ替えると上三角行列になり、対角成分がすべて $1$ になる。
すなわち**列の反転の置換の符号と $\det C$ の積は $1$ である**。
体も分離性も既約性も使わない。

`isUnit_det_eulerHankel`（単元であること）と `det_eulerHankel_sq`（$2$ 乗が $1$、
すなわち $\det C=\pm1$）は、どちらもこの等式から出る。 -/
theorem sign_mul_det_eulerHankel {ρ : R[X]} {r : ℕ} (hmon : ρ.Monic) (hdeg : ρ.natDegree = r) :
    ((Equiv.Perm.sign (Fin.revPerm : Equiv.Perm (Fin r)) : ℤ) : R) * (eulerHankel ρ r).det = 1 := by
  classical
  set H := eulerHankel ρ r with hH
  -- 列を `Fin.rev` で並べ替えた行列。
  set N := H.submatrix id (Fin.revPerm : Equiv.Perm (Fin r)) with hN
  have hNapply : ∀ i j : Fin r, N i j = ρ.coeff (i.val + (r - (j.val + 1)) + 1) := by
    intro i j
    simp [hN, hH, eulerHankel, Fin.val_rev]
  -- `N` は上三角: `i > j` なら成分は `0`。
  have hupper : N.BlockTriangular id := by
    intro i j hij
    rw [hNapply]
    refine coeff_eq_zero_of_natDegree_lt ?_
    have hj : j.val < r := j.isLt
    have : j.val < i.val := hij
    omega
  -- 対角成分はすべて `1`。
  have hdiag : ∀ i : Fin r, N i i = 1 := by
    intro i
    rw [hNapply]
    have hi : i.val < r := i.isLt
    have : i.val + (r - (i.val + 1)) + 1 = r := by omega
    rw [this, ← hdeg]
    exact hmon
  have hdetN : N.det = 1 := by
    rw [Matrix.det_of_upperTriangular hupper]
    simp [hdiag]
  have hperm : N.det = Equiv.Perm.sign (Fin.revPerm : Equiv.Perm (Fin r)) * H.det :=
    Matrix.det_permute' _ _
  exact hperm.symm.trans hdetN

/-- **$\det C$ は単元である。** -/
theorem isUnit_det_eulerHankel {ρ : R[X]} {r : ℕ} (hmon : ρ.Monic) (hdeg : ρ.natDegree = r) :
    IsUnit (eulerHankel ρ r).det :=
  isUnit_iff_exists_inv.2 ⟨_, by rw [mul_comm]; exact sign_mul_det_eulerHankel hmon hdeg⟩

/-- 置換の符号を $R$ へ写したものの $2$ 乗は $1$。 -/
theorem sign_cast_sq (σ : Equiv.Perm (Fin r)) :
    (((Equiv.Perm.sign σ : ℤ) : R)) ^ 2 = 1 := by
  rcases Int.units_eq_one_or (Equiv.Perm.sign σ) with h | h <;> rw [h] <;> norm_num

/-- **$\det C=\pm1$**（$2$ 乗が $1$ という形で述べる）。
本文が $\det C=\pm1$ と書いているものの中身であり、体も分離性も既約性も使わない。 -/
theorem det_eulerHankel_sq {ρ : R[X]} {r : ℕ} (hmon : ρ.Monic) (hdeg : ρ.natDegree = r) :
    (eulerHankel ρ r).det ^ 2 = 1 := by
  set s : R := ((Equiv.Perm.sign (Fin.revPerm : Equiv.Perm (Fin r)) : ℤ) : R) with hs
  have hkey : s * (eulerHankel ρ r).det = 1 := sign_mul_det_eulerHankel hmon hdeg
  have hssq : s ^ 2 = 1 := sign_cast_sq _
  -- 両辺に `s` を掛けると `det = s` が出る。
  have hdet : (eulerHankel ρ r).det = s := by
    have h := congrArg (fun x => s * x) hkey
    simp only [← mul_assoc, mul_one] at h
    rwa [← sq, hssq, one_mul] at h
  rw [hdet, hssq]

end EulerHankel

/-! ## 2. $\rho(y)/(y-\theta)$ の係数は $\rho$ の係数で書ける

mathlib の `coeff_minpolyDiv` は漸化式 $c_i=\rho_{i+1}+c_{i+1}\theta$ を与える。
これを下から積み上げると $c_i=\sum_j\rho_{i+j+1}\theta^j$ になる。
ここは体を使わない（可換環と整な元だけ）。 -/

section CoeffSum

variable {R S : Type*} [CommRing R] [CommRing S] [Nontrivial S] [Algebra R S]

/-- **$c_i=\sum_{j<k}\rho_{i+j+1}\theta^{\,j}$**（$k$ は $\deg\rho\le i+k$ を満たす任意の長さ）。
`coeff_minpolyDiv` の漸化式についての帰納法で、$k$ について上から詰めていく。 -/
theorem coeff_minpolyDiv_eq_sum (x : S) (hx : IsIntegral R x) :
    ∀ (k i : ℕ), (minpoly R x).natDegree ≤ i + k →
      (minpolyDiv R x).coeff i =
        ∑ j ∈ Finset.range k, algebraMap R S ((minpoly R x).coeff (i + j + 1)) * x ^ j := by
  intro k
  induction k with
  | zero =>
    intro i hi
    simp only [Finset.range_zero, Finset.sum_empty, add_zero] at hi ⊢
    refine coeff_eq_zero_of_natDegree_lt ?_
    have hpos : 0 < (minpoly R x).natDegree := minpoly.natDegree_pos hx
    have := natDegree_minpolyDiv_lt (R := R) (x := x) hx
    omega
  | succ k IH =>
    intro i hi
    have hrec := coeff_minpolyDiv R x i
    have hIH : (minpolyDiv R x).coeff (i + 1) =
        ∑ j ∈ Finset.range k, algebraMap R S ((minpoly R x).coeff (i + 1 + j + 1)) * x ^ j := by
      refine IH (i + 1) ?_
      omega
    rw [hrec, hIH, Finset.sum_range_succ']
    have hterm : ∀ j : ℕ,
        algebraMap R S ((minpoly R x).coeff (i + (j + 1) + 1)) * x ^ (j + 1)
          = algebraMap R S ((minpoly R x).coeff (i + 1 + j + 1)) * x ^ j * x := by
      intro j
      have h1 : i + (j + 1) + 1 = i + 1 + j + 1 := by omega
      rw [h1, pow_succ]
      ring
    simp only [hterm, ← Finset.sum_mul, pow_zero, mul_one, Nat.add_zero]
    ring

end CoeffSum

/-! ## 3. 体の上で定義した Euler の係数行列は、この Hankel 行列である

`WStarElementaryDivisors.lean` の `eulerMatrix` は基底の座標として定義してあり、
成分が整数かどうかは見えない形になっていた。
実際にはそれは $\rho$ の係数を並べた行列そのものである。 -/

section EulerMatrixIsHankel

variable {K L : Type*} [Field K] [Field L] [Algebra K L] [FiniteDimensional K L]

open Polynomial

omit [FiniteDimensional K L] in
/-- **$C$ の整数への降下の中身**。体の上で座標として定義した `eulerMatrix` は、
$\rho=\mathrm{minpoly}$ の係数の Hankel 行列に一致する。
とくに $\rho$ が整数係数なら $C$ の成分は整数である。

過剰仮定を 1 つ落としてある: この等式に有限次元性は要らない
（効くのは冪基底があることと $\rho$ がその生成元の最小多項式であることだけ）。 -/
theorem eulerMatrix_eq_eulerHankel (pb : PowerBasis K L) :
    eulerMatrix pb = eulerHankel (minpoly K pb.gen) pb.dim := by
  classical
  ext i j
  have hdeg : (minpoly K pb.gen).natDegree = pb.dim := pb.natDegree_minpoly
  have hx : IsIntegral K pb.gen := pb.isIntegral_gen
  have hcoeff := coeff_minpolyDiv_eq_sum (R := K) (S := L) pb.gen hx pb.dim i.val (by omega)
  have hbasis : ∀ n : Fin pb.dim, pb.basis n = pb.gen ^ (n : ℕ) := fun n => by
    simp [PowerBasis.basis_eq_pow]
  -- 座標を取り出すために、和を基底の一次結合の形にそろえる。
  have hsum : (minpolyDiv K pb.gen).coeff i.val
      = ∑ n : Fin pb.dim, (minpoly K pb.gen).coeff (i.val + n.val + 1) • pb.basis n := by
    rw [hcoeff, ← Fin.sum_univ_eq_sum_range]
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [hbasis n, Algebra.smul_def]
  rw [eulerMatrix, eulerHankel]
  simp only [Matrix.of_apply]
  rw [hsum]
  simpa using
    congrFun (pb.basis.repr_sum_self fun n => (minpoly K pb.gen).coeff (i.val + n.val + 1)) j

end EulerMatrixIsHankel

/-! ## 4. 降下そのもの

可逆な整数行列を左から掛けても像は同型に移る。したがって
$C\,G=M_\eta$ から $G$ の像の $p$ レベルは $\eta A$ の $p$ レベルに等しい。
これが人手証明の「$\operatorname{coker}(G)\cong A/\eta A$」の中身である。 -/

section Descent

variable {ι S : Type*} [Fintype ι] [DecidableEq ι] [CommRing S] [IsDomain S]

omit [IsDomain S] in
/-- $\eta$ 倍の写像の像は $\eta A$（イデアル $(\eta)$ を $\mathbb{Z}$ 加群と見たもの）である。

過剰仮定を 1 つ落としてある: 整域であることは要らない。 -/
theorem range_mulLeft_eq_span (η : S) :
    LinearMap.range ((LinearMap.mulLeft ℤ η).restrictScalars ℤ)
      = (Ideal.span {η}).restrictScalars ℤ := by
  ext x
  simp only [LinearMap.mem_range, LinearMap.restrictScalars_apply, LinearMap.mulLeft_apply,
    Submodule.restrictScalars_mem, Ideal.mem_span_singleton']
  constructor
  · rintro ⟨y, rfl⟩
    exact ⟨y, by ring⟩
  · rintro ⟨y, rfl⟩
    exact ⟨y, by ring⟩

/-- **本 step の主定理（降下）**。可逆な整数行列 $C$ と $C\,G=M_\eta$ が与えられれば、
$\{j:\ p^jA\subseteq\operatorname{im}G\ (p\ \text{の外で})\}$ の最小元は
適合基底の係数の $p$ 進付値の最大値、すなわち本文の $w^*$ である。

人手証明の「$G$ の単因子は $A/\eta A$ の不変量に等しい」を、
単因子の列（mathlib に無い）を経由せずに書いたものである。 -/
theorem isLeast_isPLevel_range_of_euler {p : ℕ} (hp : p.Prime)
    (b : Basis ι ℤ S) (η : S) (hη : η ≠ 0) (G C : Matrix ι ι ℤ) (hC : IsUnit C.det)
    (hCG : C * G = LinearMap.toMatrix b b (LinearMap.mulLeft ℤ η)) :
    IsLeast {j | IsPLevel p (LinearMap.range (Matrix.toLin b b G)) j}
      (wStarOfCoeffs p
        (Ideal.smithCoeffs b (Ideal.span {η}) (by simpa [Ideal.span_singleton_eq_bot] using hη))) := by
  classical
  have hIbot : Ideal.span {η} ≠ ⊥ := by simpa [Ideal.span_singleton_eq_bot] using hη
  -- `C` が定める同型。
  set u := Matrix.toLinearEquiv b C hC with hu
  have hcomp : Matrix.toLin b b (C * G)
      = ((u : S →ₗ[ℤ] S).comp (Matrix.toLin b b G)) := by
    rw [Matrix.toLin_mul b b b]
    rfl
  -- 像の `p` レベルは等しい。
  have hlevel : ∀ j : ℕ, IsPLevel p (LinearMap.range (Matrix.toLin b b (C * G))) j ↔
      IsPLevel p (LinearMap.range (Matrix.toLin b b G)) j := by
    intro j
    rw [hcomp]
    exact isPLevel_range_comp u (Matrix.toLin b b G) p j
  -- `C * G` の像は `η A`。
  have hrange : LinearMap.range (Matrix.toLin b b (C * G))
      = (Ideal.span {η}).restrictScalars ℤ := by
    rw [hCG, Matrix.toLin_toMatrix]
    exact range_mulLeft_eq_span η
  have hmain := isLeast_isPLevel_ideal (S := S) hp b (Ideal.span {η}) hIbot
  constructor
  · exact (hlevel _).mp (by rw [hrange]; exact hmain.1)
  · intro j hj
    refine hmain.2 ?_
    have := (hlevel j).mpr hj
    rwa [hrange] at this

end Descent

end IntegrableLattice
