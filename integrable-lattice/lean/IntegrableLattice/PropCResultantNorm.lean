/-
# 命題 C′ の残り 1 段（終結式が剰余環のノルムであること）— cycle 48 step 1

対応する人手証明:

* 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の statement の
  「$\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda$」の段

cycle 47 step 1 は $\operatorname{discr}_{A/R}(b)=(-1)^{r(r-1)/2}N_{A/R}(\rho'(\theta))$ を
分離性も体も使わずに書いた（`PropCDiscrIdentification.lean`）。
そこで残った 1 段が本 file である——**モニックな $\rho$ について
$N_{A/R}(g(\theta))=\operatorname{Res}(\rho,g)$ であること。**
これと mathlib の `Polynomial.resultant_deriv` を繋ぐと、
トレース形式の Gram 行列式と多項式の判別式が同じものになる。

## まず測ったこと

**mathlib に無い**（2026-08-05 実測、mathlib `520045ab14`）。
終結式の章 `Mathlib/RingTheory/Polynomial/Resultant/Basic.lean` に `Algebra.norm` は
1 度も現れず、終結式を剰余環の乗法写像の行列式として述べた宣言は無い。
根の像の積として述べた宣言（`resultant_eq_prod_roots_sub`）は $\rho$ が分解することを要求するので、
本文が当てる $\mathbb{Z}[x]$ の側には使えない。

**素材の側は在る**——`Polynomial.sylvesterMap`（Sylvester 行列を線形写像として与える）と
`Polynomial.modByMonic`（モニックな除法）である。cycle 47 step 1 が見立てた道はそのまま通った。
ただし**除法の商が $R$ 線形であることは mathlib に無かった**（余り `Polynomial.modByMonicHom` は在る）。
そこを書く必要があった。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。$\overline{\mathbb{Q}}$ へも出ない（$\rho$ の根を 1 度も使わない）。
扱うのは可換環 $R$ の上の多項式・行列だけで、本文が当てる先は $R=\mathbb{Z}$ と $R=\mathbb{F}_p$
（どちらも可算）である。**根を使わないことがこの段の要点である**——
根で書く道（`resultant_eq_prod_roots_sub`）は $\rho$ の分解体、すなわち
$\overline{\mathbb{Q}}$ の側へ出てしまう。

## 道筋（人手証明と 1 対 1）

$d=\deg\rho$、$n\ge\deg g$ とする。Sylvester 写像

$$S:R[X]_d\times R[X]_n\to R[X]_{d+n},\qquad (p,q)\mapsto \rho q+g p$$

の行列式が $\operatorname{Res}(\rho,g)$ である（mathlib の定義）。$g=1$ と置いた

$$E:(p,q)\mapsto \rho q+p$$

の行列式は $\operatorname{Res}(\rho,1)=\rho_d^{\,n}=1$ である（$\rho$ はモニック）。
ここでモニック除法を使って

$$T:(p,q)\mapsto\bigl((g p)\bmod\rho,\ q+(g p)\operatorname{div}\rho\bigr)$$

と置くと $E\circ T=S$ である（$\rho\cdot(a\operatorname{div}\rho)+(a\bmod\rho)=a$ そのもの）。
$T$ は**ブロック三角**である——第 1 成分は $p$ にしか依らず、第 2 成分の $q$ の側は恒等写像である。
したがって

$$\operatorname{Res}(\rho,g)=\det S=\det E\cdot\det T=1\cdot\det\bigl(p\mapsto (g p)\bmod\rho\bigr)$$

であり、右端は $R[X]/(\rho)$ の上の $g$ 倍写像の行列式、すなわち $N(g(\theta))$ である。

## 書いたこと（5 段）

1. **モニック除法の商が $R$ 線形であること**（`divByMonicHom`）。mathlib に無い（余りだけ在る）。
2. **ブロック三角の写像 $T$**（`triangularMap`）と $E\circ T=S$（`sylvesterMap_one_comp_triangularMap`）。
3. **$T$ の行列がブロック三角であること**（`toMatrix_triangularMap`）と、そこから
   $\operatorname{Res}(\rho,g)=\det(p\mapsto (gp)\bmod\rho)$（`resultant_eq_det_modMulMap`）。
4. **剰余環のノルムとの同定**（`norm_aeval_eq_resultant`）。冪基底を持つ任意の可換 $R$ 代数 $A$
   について、$\theta$ が $\rho$ の根であれば $N_{A/R}(g(\theta))=\operatorname{Res}(\rho,g)$ である。
5. **2 つの判別式の同定**（`algebra_discr_eq_polynomial_discr`）。
   段 4 と cycle 47 step 1 の `discr_eq_sign_mul_norm_derivative` と
   mathlib の `Polynomial.resultant_deriv` を繋ぐと、符号が 2 度現れて打ち消し合い、
   $\operatorname{discr}_{A/R}(b)=\operatorname{disc}(\rho)$ が出る。
   **これが 命題 C′ の台帳が数えていた残り 1 件である。**
6. **本文の $w^*=0$ の同値の組み立て**（`wStar_eq_zero_iff_separable_and_not_dvd`）。
   **台帳は数えていなかったが、`lean/` の 3 つの file が残りとして挙げていた事柄である。**
   部品は cycle 45・46 で揃っており、新しい数学は 1 つも入っていない——
   $w^*=0\iff p\nmid\det G$ と「$\rho\bmod p$ が分離的 $\iff p\nmid\operatorname{disc}(\rho)$」を、
   段 5 の同定を挟んで繋ぐだけである。
-/
import Mathlib
import IntegrableLattice.EulerDualBasisCommRing
import IntegrableLattice.PropCDiscrIdentification
import IntegrableLattice.PropCDiscSeparable

namespace IntegrableLattice
namespace PropCResultantNorm

open Polynomial Module Matrix Finset

variable {R : Type*} [CommRing R]

/-! ## 段 1: モニック除法の商は $R$ 線形である

mathlib は余りの側（`Polynomial.modByMonicHom`）しか持っていない。商の側を書く。
証明は余りの側と同じ形で、`div_modByMonic_unique` の一意性から出る。 -/

/-- **商の加法性**。$(p_1+p_2)\operatorname{div}\rho
= p_1\operatorname{div}\rho+p_2\operatorname{div}\rho$。 -/
theorem add_divByMonic {q : R[X]} (hq : q.Monic) (p₁ p₂ : R[X]) :
    (p₁ + p₂) /ₘ q = p₁ /ₘ q + p₂ /ₘ q := by
  rcases subsingleton_or_nontrivial R with hR | hR
  · simp only [eq_iff_true_of_subsingleton]
  · exact (div_modByMonic_unique (p₁ /ₘ q + p₂ /ₘ q) (p₁ %ₘ q + p₂ %ₘ q) hq
      ⟨by
        rw [mul_add, add_left_comm, add_assoc, modByMonic_add_div, ← add_assoc,
          add_comm (q * _), modByMonic_add_div],
        (degree_add_le _ _).trans_lt
          (max_lt (degree_modByMonic_lt _ hq) (degree_modByMonic_lt _ hq))⟩).1

/-- **商のスカラー倍**。$(c\cdot p)\operatorname{div}\rho=c\cdot(p\operatorname{div}\rho)$。 -/
theorem smul_divByMonic {q : R[X]} (hq : q.Monic) (c : R) (p : R[X]) :
    (c • p) /ₘ q = c • (p /ₘ q) := by
  rcases subsingleton_or_nontrivial R with hR | hR
  · simp only [eq_iff_true_of_subsingleton]
  · exact (div_modByMonic_unique (c • (p /ₘ q)) (c • (p %ₘ q)) hq
      ⟨by rw [mul_smul_comm, ← smul_add, modByMonic_add_div],
        (degree_smul_le _ _).trans_lt (degree_modByMonic_lt _ hq)⟩).1

/-- `_ /ₘ q` を $R$ 線形写像として見たもの（モニックな `q` について）。 -/
@[simps]
noncomputable def divByMonicHom {q : R[X]} (hq : q.Monic) : R[X] →ₗ[R] R[X] where
  toFun p := p /ₘ q
  map_add' := add_divByMonic hq
  map_smul' := smul_divByMonic hq

/-! ## 段 2: 次数の見積もりとブロック三角の写像 -/

section Triangular

variable {d n : ℕ} {ρ g : R[X]}

/-- 余りは $R[X]_d$ に属する（$\rho$ がモニックで次数 $d$）。 -/
theorem modByMonic_mem (hρ : ρ.Monic) (hd : ρ.natDegree = d) (p : R[X]) :
    p %ₘ ρ ∈ R[X]_d := by
  rcases subsingleton_or_nontrivial R with hR | hR
  · have : p %ₘ ρ = 0 := Subsingleton.elim _ _
    simp [this]
  · rw [mem_degreeLT]
    refine (degree_modByMonic_lt p hρ).trans_le ?_
    rw [degree_eq_natDegree hρ.ne_zero, hd]

/-- $g\,p$ の次数は $d+n$ 未満である（$\deg g\le n$、$p\in R[X]_d$）。 -/
theorem mul_degree_lt (hg : g.natDegree ≤ n) (p : R[X]_d) :
    (g * (p : R[X])).degree < ((d + n : ℕ) : WithBot ℕ) := by
  have hp : ((p : R[X])).degree < (d : WithBot ℕ) := mem_degreeLT.mp p.2
  rcases eq_or_ne (g * (p : R[X])) 0 with h | h
  · rw [h, degree_zero]
    exact WithBot.bot_lt_coe _
  · have hp0 : (p : R[X]) ≠ 0 := fun hh => h (by simp [hh])
    have hdlt : ((p : R[X])).natDegree < d := by
      rw [degree_eq_natDegree hp0] at hp
      exact_mod_cast hp
    have hle : (g * (p : R[X])).natDegree ≤ g.natDegree + ((p : R[X])).natDegree :=
      natDegree_mul_le
    rw [degree_eq_natDegree h]
    exact_mod_cast hle.trans_lt (by omega)

/-- 次数が $d+n$ 未満の多項式をモニックな次数 $d$ の $\rho$ で割った商は $R[X]_n$ に属する。 -/
theorem divByMonic_mem (hρ : ρ.Monic) (hd : ρ.natDegree = d) {a : R[X]}
    (ha : a.degree < ((d + n : ℕ) : WithBot ℕ)) : a /ₘ ρ ∈ R[X]_n := by
  rcases subsingleton_or_nontrivial R with hR | hR
  · have : a /ₘ ρ = 0 := Subsingleton.elim _ _
    simp [this]
  · rw [mem_degreeLT]
    by_cases hz : a /ₘ ρ = 0
    · simp [hz]
    have hdeg : ρ.degree ≤ a.degree := by
      by_contra h
      exact hz ((divByMonic_eq_zero_iff hρ).2 (not_le.1 h))
    -- $\deg\rho+\deg(a/ₘ\rho)=\deg a<d+n$ から $\deg(a/ₘ\rho)<n$。
    have hsum := degree_add_divByMonic hρ hdeg
    rw [degree_eq_natDegree hρ.ne_zero, hd, degree_eq_natDegree hz] at hsum
    rw [degree_eq_natDegree hz]
    have : ((d : WithBot ℕ) + ((a /ₘ ρ).natDegree : WithBot ℕ)) < ((d + n : ℕ) : WithBot ℕ) := by
      rw [hsum]; exact ha
    rw [← Nat.cast_add, Nat.cast_lt] at this
    exact_mod_cast Nat.lt_of_add_lt_add_left this

variable (ρ g)

/-- $p\mapsto (g\,p)\bmod\rho$（$R[X]_d$ の自己準同型）。$R[X]/(\rho)$ の上の $g$ 倍写像である。 -/
@[simps]
noncomputable def modMulMap (hρ : ρ.Monic) (hd : ρ.natDegree = d) :
    R[X]_d →ₗ[R] R[X]_d where
  toFun p := ⟨(g * (p : R[X])) %ₘ ρ, modByMonic_mem hρ hd _⟩
  map_add' p₁ p₂ := by
    ext1
    simp [mul_add, add_modByMonic]
  map_smul' c p := by
    ext1
    simp [smul_modByMonic]

/-- $p\mapsto (g\,p)\operatorname{div}\rho$（$R[X]_d\to R[X]_n$）。 -/
@[simps]
noncomputable def divMulMap (hρ : ρ.Monic) (hd : ρ.natDegree = d) (hg : g.natDegree ≤ n) :
    R[X]_d →ₗ[R] R[X]_n where
  toFun p := ⟨(g * (p : R[X])) /ₘ ρ, divByMonic_mem hρ hd (mul_degree_lt hg p)⟩
  map_add' p₁ p₂ := by
    ext1
    simp [mul_add, add_divByMonic hρ]
  map_smul' c p := by
    ext1
    simp [smul_divByMonic hρ]

/-- **ブロック三角の写像 $T$**。$(p,q)\mapsto((g p)\bmod\rho,\ q+(g p)\operatorname{div}\rho)$。 -/
noncomputable def triangularMap (hρ : ρ.Monic) (hd : ρ.natDegree = d) (hg : g.natDegree ≤ n) :
    (R[X]_d × R[X]_n) →ₗ[R] (R[X]_d × R[X]_n) :=
  LinearMap.prod
    ((modMulMap ρ g hρ hd).comp (LinearMap.fst R _ _))
    (LinearMap.snd R _ _ + (divMulMap ρ g hρ hd hg).comp (LinearMap.fst R _ _))

/-- **$E\circ T=S$**。$\rho\cdot(a\operatorname{div}\rho)+(a\bmod\rho)=a$ そのものである。 -/
theorem sylvesterMap_one_comp_triangularMap
    (hρ : ρ.Monic) (hd : ρ.natDegree = d) (hg : g.natDegree ≤ n)
    (hf : ρ.natDegree ≤ d) (h1 : (1 : R[X]).natDegree ≤ n) :
    (sylvesterMap ρ 1 hf h1).comp (triangularMap ρ g hρ hd hg)
      = sylvesterMap ρ g hf hg := by
  refine LinearMap.ext fun pq => ?_
  apply Subtype.ext
  show ρ * ((pq.2 : R[X]) + (g * (pq.1 : R[X])) /ₘ ρ) + 1 * ((g * (pq.1 : R[X])) %ₘ ρ)
      = ρ * (pq.2 : R[X]) + g * (pq.1 : R[X])
  rw [mul_add, one_mul]
  have := modByMonic_add_div (g * (pq.1 : R[X])) ρ
  linear_combination this

end Triangular

/-! ## 段 3: 行列がブロック三角であること -/

section Matrices

variable {d n : ℕ} {ρ g : R[X]}

/-- **$T$ の行列は $\begin{pmatrix}A&0\\C&I\end{pmatrix}$ である。**

第 1 成分が $p$ にしか依らないので右上のブロックが $0$、
第 2 成分の $q$ の側が恒等写像なので右下のブロックが単位行列である。 -/
theorem toMatrix_triangularMap (hρ : ρ.Monic) (hd : ρ.natDegree = d) (hg : g.natDegree ≤ n) :
    LinearMap.toMatrix ((degreeLT.basis R d).prod (degreeLT.basis R n))
        ((degreeLT.basis R d).prod (degreeLT.basis R n)) (triangularMap ρ g hρ hd hg)
      = Matrix.fromBlocks
          (LinearMap.toMatrix (degreeLT.basis R d) (degreeLT.basis R d) (modMulMap ρ g hρ hd))
          0
          (LinearMap.toMatrix (degreeLT.basis R d) (degreeLT.basis R n)
            (divMulMap ρ g hρ hd hg))
          1 := by
  classical
  ext (i | i) (j | j) <;>
    simp [LinearMap.toMatrix, triangularMap, Matrix.one_apply, Finsupp.single_apply, eq_comm]

/-- **$\operatorname{Res}(\rho,g)=\det(p\mapsto (g p)\bmod\rho)$。** -/
theorem resultant_eq_det_modMulMap (hρ : ρ.Monic) (hd : ρ.natDegree = d) (hg : g.natDegree ≤ n) :
    ρ.resultant g d n = LinearMap.det (modMulMap ρ g hρ hd) := by
  classical
  have hf : ρ.natDegree ≤ d := le_of_eq hd
  have h1 : (1 : R[X]).natDegree ≤ n := by simp
  set b₁ := degreeLT.basisProd R d n with hb₁
  set b₂ := degreeLT.basis R (d + n) with hb₂
  -- $E\circ T=S$ を行列へ移す。
  have hcomp := sylvesterMap_one_comp_triangularMap ρ g hρ hd hg hf h1
  have hmat : LinearMap.toMatrix b₁ b₂ (sylvesterMap ρ 1 hf h1)
      * LinearMap.toMatrix b₁ b₁ (triangularMap ρ g hρ hd hg)
      = LinearMap.toMatrix b₁ b₂ (sylvesterMap ρ g hf hg) := by
    rw [← LinearMap.toMatrix_comp b₁ b₁ b₂, hcomp]
  have hSg : LinearMap.toMatrix b₁ b₂ (sylvesterMap ρ g hf hg) = sylvester ρ g d n :=
    toMatrix_sylvesterMap' ρ g hf hg
  have hE : LinearMap.toMatrix b₁ b₂ (sylvesterMap ρ 1 hf h1) = sylvester ρ 1 d n :=
    toMatrix_sylvesterMap' ρ 1 hf h1
  -- $\det E=\operatorname{Res}(\rho,1)=\rho_d^{\,n}=1$。
  have hdetE : (sylvester ρ 1 d n).det = 1 := by
    have hres : ρ.resultant 1 d n = ρ.coeff d ^ n := by simp
    have hcoeff : ρ.coeff d = 1 := by rw [← hd]; exact hρ.coeff_natDegree
    rw [show (sylvester ρ 1 d n).det = ρ.resultant 1 d n from rfl, hres, hcoeff, one_pow]
  -- ブロック三角の行列式。
  have hdetT : (LinearMap.toMatrix b₁ b₁ (triangularMap ρ g hρ hd hg)).det
      = LinearMap.det (modMulMap ρ g hρ hd) := by
    have hre : LinearMap.toMatrix b₁ b₁ (triangularMap ρ g hρ hd hg)
        = (LinearMap.toMatrix ((degreeLT.basis R d).prod (degreeLT.basis R n))
            ((degreeLT.basis R d).prod (degreeLT.basis R n))
            (triangularMap ρ g hρ hd hg)).submatrix finSumFinEquiv.symm finSumFinEquiv.symm := by
      ext i j
      simp [hb₁, degreeLT.basisProd, LinearMap.toMatrix_apply, Basis.reindex_apply]
    rw [hre, Matrix.det_submatrix_equiv_self, toMatrix_triangularMap,
      Matrix.det_fromBlocks_zero₁₂, Matrix.det_one, mul_one, LinearMap.det_toMatrix]
  calc ρ.resultant g d n = (sylvester ρ g d n).det := rfl
    _ = (sylvester ρ 1 d n).det
          * (LinearMap.toMatrix b₁ b₁ (triangularMap ρ g hρ hd hg)).det := by
        rw [← Matrix.det_mul, ← hE, ← hSg, hmat]
    _ = LinearMap.det (modMulMap ρ g hρ hd) := by rw [hdetE, hdetT, one_mul]

end Matrices

/-! ## 段 4: 剰余環のノルムとの同定

$A$ が $\theta$ の冪を基底に持ち、$\theta$ が $\rho$ の根であるとき、
$g(\theta)$ 倍写像は $R[X]_d$ の上の $p\mapsto (g p)\bmod\rho$ と共役である。 -/

section Norm

variable {A : Type*} [CommRing A] [Algebra R A]
variable {m : ℕ} {ρ g : R[X]} {θ : A}

/-- 冪基底と `IsReductionOf` から $\rho(\theta)=0$ が出る（$\rho$ はモニックで次数 $m+1$）。 -/
theorem aeval_eq_zero (hred : EulerDualBasis.IsReductionOf ρ θ m)
    (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) :
    aeval θ ρ = 0 := by
  classical
  have hlead : ρ.coeff (m + 1) = 1 := by
    have := hmonic.coeff_natDegree
    rwa [hdeg] at this
  rw [aeval_eq_sum_range, hdeg, Finset.sum_range_succ, hlead, one_smul]
  rw [EulerDualBasis.IsReductionOf] at hred
  rw [hred]
  simp [Algebra.smul_def]

/-- $R[X]_{m+1}\simeq A$（$X^j\mapsto\theta^j$）。 -/
noncomputable def evalEquiv (b : Basis (Fin (m + 1)) R A) :
    R[X]_(m + 1) ≃ₗ[R] A :=
  (degreeLT.basis R (m + 1)).equiv b (Equiv.refl _)

theorem evalEquiv_apply_basis (b : Basis (Fin (m + 1)) R A)
    (hb : EulerDualBasis.IsPowerBasisOf b θ) (i : Fin (m + 1)) :
    evalEquiv b (degreeLT.basis R (m + 1) i) = θ ^ (i : ℕ) := by
  rw [evalEquiv, Basis.equiv_apply, Equiv.refl_apply, hb i]

/-- $R[X]_{m+1}$ の元については、この同型は代入写像そのものである。 -/
theorem evalEquiv_eq_aeval (b : Basis (Fin (m + 1)) R A)
    (hb : EulerDualBasis.IsPowerBasisOf b θ) (p : R[X]_(m + 1)) :
    evalEquiv b p = aeval θ (p : R[X]) := by
  classical
  have hmap : ((evalEquiv b : R[X]_(m + 1) ≃ₗ[R] A) : R[X]_(m + 1) →ₗ[R] A)
      = (aeval θ : R[X] →ₐ[R] A).toLinearMap.comp (Submodule.subtype (R[X]_(m + 1))) := by
    refine (degreeLT.basis R (m + 1)).ext fun i => ?_
    simp [evalEquiv_apply_basis b hb i, degreeLT.basis_val]
  exact congrArg (fun f => f p) hmap

/-- **本 step の主定理**。$\theta$ が モニックな $\rho$ の根で、$A$ が $\theta$ の冪を基底に持つとき、
$g(\theta)$ のノルムは終結式 $\operatorname{Res}(\rho,g)$ である。

**mathlib の同種の宣言（`resultant_eq_prod_roots_sub`）と違い、$\rho$ の根を 1 度も使わない。**
したがって $\overline{\mathbb{Q}}$ へ出ず、$\mathbb{Z}[x]$ と $\mathbb{F}_p[x]$ の側でそのまま使える。 -/
theorem norm_aeval_eq_resultant {n : ℕ}
    (b : Basis (Fin (m + 1)) R A) (hb : EulerDualBasis.IsPowerBasisOf b θ)
    (hred : EulerDualBasis.IsReductionOf ρ θ m)
    (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) (hg : g.natDegree ≤ n) :
    Algebra.norm R (aeval θ g) = ρ.resultant g (m + 1) n := by
  classical
  have hroot : aeval θ ρ = 0 := aeval_eq_zero hred hmonic hdeg
  have hconj : (Algebra.lmul R A (aeval θ g) : A →ₗ[R] A)
      = ((evalEquiv b : R[X]_(m + 1) →ₗ[R] A)).comp
          ((modMulMap ρ g hmonic hdeg).comp
            ((evalEquiv b).symm : A →ₗ[R] R[X]_(m + 1))) := by
    refine LinearMap.ext fun y => ?_
    set x : R[X]_(m + 1) := (evalEquiv b).symm y with hx
    have hy : evalEquiv b x = y := by rw [hx]; simp
    show aeval θ g * y = evalEquiv b (modMulMap ρ g hmonic hdeg x)
    rw [evalEquiv_eq_aeval b hb]
    show aeval θ g * y = aeval θ ((g * (x : R[X])) %ₘ ρ)
    rw [aeval_modByMonic_eq_self_of_root hroot, map_mul, ← evalEquiv_eq_aeval b hb x, hy]
  rw [resultant_eq_det_modMulMap hmonic hdeg hg, Algebra.norm_apply, hconj,
    LinearMap.det_conj]

/-! ## 段 5: 2 つの判別式の同定（命題 C′ に残っていた 1 件）

cycle 47 step 1 の `discr_eq_sign_mul_norm_derivative` と段 4 と
mathlib の `Polynomial.resultant_deriv` を繋ぐ。符号が 2 度現れて打ち消し合う。 -/

/-- **冪基底のトレース形式の Gram 行列式は、多項式の判別式に等しい。**

左辺は `Algebra.discr`（本文の $\det G$ の側）、右辺は `Polynomial.discr`（本文の
$\operatorname{disc}(\rho)$ を終結式で書いた側）である。**mathlib はこの 2 つを結んでいない**
（`Algebra.discr_powerBasis_eq_norm` は分離的な体拡大を要求する）。

体も分離性も既約性も使わない。$\rho$ が可約でも重根を持ってもよい。 -/
theorem algebra_discr_eq_polynomial_discr
    (b : Basis (Fin (m + 1)) R A) (hb : EulerDualBasis.IsPowerBasisOf b θ)
    (hred : EulerDualBasis.IsReductionOf ρ θ m)
    (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) :
    Algebra.discr R b = ρ.discr := by
  classical
  have hdegpos : 0 < ρ.degree := by
    rw [← natDegree_pos_iff_degree_pos, hdeg]
    exact Nat.succ_pos m
  have hderiv : (derivative ρ).natDegree ≤ m := by
    have h := natDegree_derivative_le ρ
    rw [hdeg] at h
    simpa using h
  have h1 := PropCDiscrIdentification.discr_eq_sign_mul_norm_derivative b hb hred hmonic hdeg
  have h2 := norm_aeval_eq_resultant (g := derivative ρ) (n := m) b hb hred hmonic hdeg hderiv
  have h3 := Polynomial.resultant_deriv hdegpos
  rw [hdeg, hmonic.leadingCoeff, mul_one, Nat.add_sub_cancel] at h3
  rw [h1, h2, h3, ← mul_assoc, ← pow_add, ← two_mul, pow_mul]
  simp

end Norm

/-! ## 段 6: 本文の $w^*=0$ の同値（組み立て）

命題 C′ の statement のもう一方の段——$w^*=0$ が「$\rho\bmod p$ が分離的、かつ全ての重複度で
$p\nmid m_\lambda$」と同値であること——は、部品がすべて揃っていながら
**1 つの主張として組み立てられていなかった。**

* $w^*=0\iff p\nmid\det G$（cycle 45 step 2、`PropCWStarZero.wStar_eq_zero_iff_of_det_factorization`）
* $\rho\bmod p$ が分離的 $\iff p\nmid\operatorname{disc}(\rho)$
  （cycle 46 step 2、`PropCDiscSeparable.separable_map_iff_not_dvd_discr`）

前者の $\det G=d\cdot\prod_\lambda m_\lambda$ の $d$ が多項式の判別式であることは、
段 5 の同定（`algebra_discr_eq_polynomial_discr`）が与える。ここで繋ぐ。 -/

section WStarZero

/-- **本文の $w^*=0$ の同値そのもの。**

$\det G$ が本文の形 $\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda$ に分かれているとき、
$w^*=0$ であることは「$\rho\bmod p$ が分離的、かつ全ての重複度で $p\nmid m_\lambda$」と同値である。

**新しい数学は 1 つも入っていない。在る 2 つを繋いだだけである。そう書く。** -/
theorem wStar_eq_zero_iff_separable_and_not_dvd
    {r p : ℕ} [hp : Fact p.Prime] {ι : Type*} [Fintype ι] {ρ : ℤ[X]}
    (hmonic : ρ.Monic) (hdeg : 0 < ρ.natDegree)
    (G : Matrix (Fin r) (Fin r) ℤ) (m : ι → ℤ) (hfac : G.det = ρ.discr * ∏ i, m i)
    (bM : Basis (Fin r) ℤ (Fin r → ℤ))
    (bN : Basis (Fin r) ℤ (LinearMap.range G.mulVecLin))
    (a : Fin r → ℤ) (hb : ∀ i, (bN i : Fin r → ℤ) = a i • bM i) (ha : ∀ i, a i ≠ 0) :
    wStarOfCoeffs p a = 0
      ↔ (ρ.map (Int.castRingHom (ZMod p))).Separable ∧ ∀ i, ¬ ((p : ℤ) ∣ m i) := by
  rw [PropCWStarZero.wStar_eq_zero_iff_of_det_factorization hp.out G ρ.discr m hfac bM bN a hb ha,
    PropCDiscSeparable.separable_map_iff_not_dvd_discr hmonic hdeg]

end WStarZero

end PropCResultantNorm
end IntegrableLattice
