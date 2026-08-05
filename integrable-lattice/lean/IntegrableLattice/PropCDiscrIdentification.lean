/-
# 命題 C′ の残り 1 段（2 つの判別式の同定）— cycle 47 step 1

対応する人手証明:

* 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の statement の
  「$\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda$」の段と、
  「$w^*=0$ は『$\rho\bmod p$ が分離的、……』と同値である」の段を繋ぐところ

cycle 46 は同じ主張の 2 箇所へ、**別々の意味の判別式**を入れていた。

| どこ | 何を入れたか | Lean |
|---|---|---|
| $\det G$ の分解（cycle 42 step 1） | 冪基底のトレース形式の Gram 行列式 | `Algebra.discr` |
| 分離性との同値（cycle 46 step 2） | 多項式そのものの判別式（Sylvester 行列式） | `Polynomial.discr` |

**2 つが同じものであることは mathlib に無い。** それが 命題 C′ に残っていた 1 段であり、
本 file はそこを埋める。

## まず測ったこと（本 step が掲げた焦点そのもの）

**`Algebra.discr_powerBasis_eq_norm` はそのままでは当たらない**（2026-08-05 実測。
`Mathlib/RingTheory/Discriminant.lean` 201 行を直読）。
この宣言は `[Algebra.IsSeparable K L]` を要求し、しかも $K,L$ が体であることを要求する。
本文が当てる先は $\mathbb{Z}[x]/(\rho)$ と $\mathbb{F}_p[x]/(\bar\rho)$ であり、
**$\bar\rho$ が分離的でない側こそが主張の中身**なので、分離性を仮定する形は使えない。
$\rho$ が可約なら $A$ は体でもない。

**そこで分離性も体も使わない道で書いた。** 使うのは本プロジェクトが既に持っている
Euler の双対基底（`EulerDualBasisCommRing.lean`。可換環の上で成立する）である——
$C\,G=M_{\rho'(\theta)}$ の両辺の行列式を取れば、根にも分離性にも触れずに
$\det G=\det C\cdot N(\rho'(\theta))$ が出る。**残っていたのは $\det C$ の符号を確定させることと、
$N(\rho'(\theta))$ が終結式 $\operatorname{Res}(\rho,\rho')$ であることの 2 つである。**

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。$\overline{\mathbb{Q}}$ へも出ない（根を 1 度も使わない）。
扱うのは可換環 $R$ の上の多項式・行列・置換の符号だけで、
本文が当てる先は $R=\mathbb{Z}$ と $R=\mathbb{F}_p$（どちらも可算）である。

## 書いたこと（3 段）

1. **反転の置換の符号**（`sign_revPerm`）。$\operatorname{sign}(\mathrm{rev})=(-1)^{r(r-1)/2}$。
   mathlib に無い（2026-08-05 実測。`revPerm` と `sign` を同時に含む宣言 0 件）。
   転倒数を数えるだけである——$i<j$ なら必ず $\mathrm{rev}\,j<\mathrm{rev}\,i$ なので、
   すべての対が転倒しており、対の個数は $r(r-1)/2$ である。
2. **Euler の係数行列の行列式**（`det_eulerHankel`）。$\det C=(-1)^{r(r-1)/2}$。
   `sign_mul_det_eulerHankel` は
   $\operatorname{sign}(\mathrm{rev})\cdot\det C=1$ までを与えており、
   **符号そのものは確定していなかった**（$\pm1$ の形でしか使われていなかった）。段 1 で確定する。
3. **判別式とノルムの関係（分離性を使わない版）**（`discr_eq_sign_mul_norm_derivative`）。
   $\operatorname{discr}_{A/R}(b)=(-1)^{r(r-1)/2}N_{A/R}(\rho'(\theta))$。
   **これが mathlib の `Algebra.discr_powerBasis_eq_norm` の、体も分離性も要らない版である。**
   $\rho$ が可約でも重根を持ってもよい。

## 形式化しなかったもの（実測つき）

* **$N_{A/R}(g(\theta))=\operatorname{Res}(\rho,g)$（モニックな $\rho$ について）。**
  段 3 と `Polynomial.resultant_deriv` を繋ぐと
  $\operatorname{discr}_{A/R}(b)=\operatorname{discr}(\rho)$ が出るので、
  **命題 C′ の残りはこの 1 件へ移る。**
  **2026-08-05 実測**: mathlib の終結式の章（`Mathlib/RingTheory/Polynomial/Resultant/Basic.lean`）に
  `Algebra.norm` は 1 度も現れず、終結式を剰余環の乗法写像の行列式として述べた宣言は無い。
  終結式を根の像の積として述べた宣言（`resultant_eq_prod_roots_sub`・480 行）は在るが、
  $\rho$ が分解することを要求するので、**本文が当てる $\mathbb{Z}[x]$ の側には使えない。**
  道具の側は在る——`sylvesterMap`（Sylvester 行列を線形写像として与える）と
  `Polynomial.modByMonic`（モニックな除法）で、
  $R[X]_{<m+n}\cong R[X]_{<n}\oplus R[X]_{<m}$ の分解の下で Sylvester 写像がブロック三角になり、
  対角ブロックの片方が単位行列、もう片方が $g$ 倍写像になる、という道である。
  **ここは配線ではなく、書く量のある段である。そう書く。**
-/
import Mathlib
import IntegrableLattice.EulerDualBasisCommRing
import IntegrableLattice.WStarIntegralDescent
import IntegrableLattice.WStarGramDiscriminant

namespace IntegrableLattice
namespace PropCDiscrIdentification

open Polynomial Finset Module Matrix

/-! ## 段 1: 反転の置換の符号

$\operatorname{sign}(\mathrm{rev})=(-1)^{r(r-1)/2}$。転倒数を数えるだけである。 -/

/-- **反転の置換の符号は $(-1)^{r(r-1)/2}$ である。**

$i<j$ ならば $\mathrm{rev}\,j<\mathrm{rev}\,i$ なので、すべての対 $(i,j)$（$i<j$）が転倒しており、
その個数は $\sum_i\#\{j>i\}=\sum_{i<r}(r-1-i)=r(r-1)/2$ である。 -/
theorem sign_revPerm (r : ℕ) :
    Equiv.Perm.sign (Fin.revPerm : Equiv.Perm (Fin r)) = (-1) ^ (r * (r - 1) / 2) := by
  have hterm : ∀ i : Fin r,
      (∏ j ∈ Finset.Ioi i,
        (if (Fin.revPerm : Equiv.Perm (Fin r)) i < (Fin.revPerm : Equiv.Perm (Fin r)) j then
          (1 : ℤˣ) else -1))
        = (-1 : ℤˣ) ^ (Finset.Ioi i).card := by
    intro i
    have hstep : ∀ j ∈ Finset.Ioi i,
        (if (Fin.revPerm : Equiv.Perm (Fin r)) i < (Fin.revPerm : Equiv.Perm (Fin r)) j then
          (1 : ℤˣ) else -1) = (-1 : ℤˣ) := by
      intro j hj
      have hij : i < j := Finset.mem_Ioi.mp hj
      have hnot : ¬ ((Fin.revPerm : Equiv.Perm (Fin r)) i < (Fin.revPerm : Equiv.Perm (Fin r)) j) := by
        simp only [Fin.revPerm_apply, Fin.rev_lt_rev]
        exact not_lt.mpr hij.le
      exact if_neg hnot
    rw [Finset.prod_congr rfl hstep, Finset.prod_const]
    rfl
  -- 転倒数の合計は $\sum_{i<r}(r-1-i)=r(r-1)/2$。
  have hsum : (∑ i : Fin r, (Finset.Ioi i).card) = r * (r - 1) / 2 := by
    have hcard : ∀ i ∈ (Finset.univ : Finset (Fin r)),
        (Finset.Ioi i).card = r - 1 - (i : ℕ) := fun i _ => Fin.card_Ioi i
    rw [Finset.sum_congr rfl hcard, Fin.sum_univ_eq_sum_range (fun i => r - 1 - i) r,
      ← Finset.sum_range_reflect (fun i => r - 1 - i) r]
    have hid : ∀ i ∈ Finset.range r, r - 1 - (r - 1 - i) = i := by
      intro i hi
      have := Finset.mem_range.mp hi
      omega
    rw [Finset.sum_congr rfl hid, Finset.sum_range_id]
  calc Equiv.Perm.sign (Fin.revPerm : Equiv.Perm (Fin r))
      = ∏ i, ∏ j ∈ Finset.Ioi i,
          (if (Fin.revPerm : Equiv.Perm (Fin r)) i < (Fin.revPerm : Equiv.Perm (Fin r)) j then
            (1 : ℤˣ) else -1) := Equiv.Perm.sign_eq_prod_prod_Ioi _
    _ = ∏ i : Fin r, (-1 : ℤˣ) ^ (Finset.Ioi i).card :=
        Finset.prod_congr rfl fun i _ => hterm i
    _ = (-1 : ℤˣ) ^ (∑ i : Fin r, (Finset.Ioi i).card) :=
        Finset.prod_pow_eq_pow_sum _ _ _
    _ = (-1 : ℤˣ) ^ (r * (r - 1) / 2) := by rw [hsum]

/-! ## 段 2: Euler の係数行列の行列式の符号

`sign_mul_det_eulerHankel` は $\operatorname{sign}(\mathrm{rev})\cdot\det C=1$
までを与えている。段 1 で符号が確定したので、$\det C$ そのものが決まる。 -/

variable {R : Type*} [CommRing R]

/-- **$\det C=(-1)^{r(r-1)/2}$。**

`det_eulerHankel_sq`（$2$ 乗が $1$）は符号を決めていなかった。ここで決める。 -/
theorem det_eulerHankel {ρ : R[X]} {r : ℕ} (hmon : ρ.Monic) (hdeg : ρ.natDegree = r) :
    (eulerHankel ρ r).det = (-1 : R) ^ (r * (r - 1) / 2) := by
  classical
  have hkey := sign_mul_det_eulerHankel (R := R) hmon hdeg
  rw [sign_revPerm r] at hkey
  have hs : (((((-1 : ℤˣ) ^ (r * (r - 1) / 2)) : ℤˣ) : ℤ) : R) = (-1 : R) ^ (r * (r - 1) / 2) := by
    norm_cast
  rw [hs] at hkey
  -- 両辺に $(-1)^{r(r-1)/2}$ を掛ける。
  have hsq : ((-1 : R) ^ (r * (r - 1) / 2)) * ((-1 : R) ^ (r * (r - 1) / 2)) = 1 := by
    rw [← pow_add, ← two_mul, pow_mul]
    simp
  calc (eulerHankel ρ r).det
      = 1 * (eulerHankel ρ r).det := by rw [one_mul]
    _ = (((-1 : R) ^ (r * (r - 1) / 2)) * ((-1 : R) ^ (r * (r - 1) / 2)))
          * (eulerHankel ρ r).det := by rw [hsq]
    _ = ((-1 : R) ^ (r * (r - 1) / 2))
          * (((-1 : R) ^ (r * (r - 1) / 2)) * (eulerHankel ρ r).det) := by
        rw [mul_assoc]
    _ = (-1 : R) ^ (r * (r - 1) / 2) := by rw [hkey, mul_one]

/-! ## 段 3: 判別式とノルムの関係（分離性も体も使わない版）

mathlib の `Algebra.discr_powerBasis_eq_norm` は分離的な体拡大を要求する。
**Euler の双対基底を経由すると、可換環の上でそのまま同じ等式が出る。** -/

section Discr

variable {A : Type*} [CommRing A] [Algebra R A]
variable {m : ℕ} {ρ : R[X]} {θ : A} (b : Basis (Fin (m + 1)) R A)

/-- **冪基底の判別式は $(-1)^{r(r-1)/2}N(\rho'(\theta))$ である**（$r=m+1=\deg\rho$）。

mathlib の `Algebra.discr_powerBasis_eq_norm` と同じ等式だが、
**体も分離性も既約性も使わない。** $\rho$ が可約でも重根を持ってもよい。

証明は根に 1 度も触れない——Euler の双対基底が与える $C\,G=M_{\rho'(\theta)}$ の
両辺の行列式を取り、$\det C$（段 2）を左へ移すだけである。 -/
theorem discr_eq_sign_mul_norm_derivative
    (hb : EulerDualBasis.IsPowerBasisOf b θ) (hred : EulerDualBasis.IsReductionOf ρ θ m)
    (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) :
    Algebra.discr R b
      = (-1 : R) ^ ((m + 1) * m / 2) * Algebra.norm R (aeval θ (derivative ρ)) := by
  classical
  have hG := EulerDualBasis.det_weightedGram b hb hred hmonic hdeg 1
  rw [EulerDualBasis.eulerMatrix_eq_eulerHankel b hb hmonic hdeg,
    det_eulerHankel hmonic hdeg,
    WStarGramDiscriminant.weightedGram_one_eq_traceMatrix b hb, ← Algebra.discr_def] at hG
  simpa using hG

end Discr

end PropCDiscrIdentification
end IntegrableLattice
