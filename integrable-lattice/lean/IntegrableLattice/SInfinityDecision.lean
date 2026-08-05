/-
# 定理 W3（$S_\infty$ の判定手続き）・補題 W2・定理 W4／系 W6（$j^*$＝二項式因子の重複度）
— cycle 20 step 2

対応する人手証明:

* 本文ブロック `paper_prop_K` の (K2)(K3)(K4)(K6)（`structured-latex/content/009_s_infinity_decision.ts`）
* 根拠 report: `outputs/reports/cycle20_T3_s_infinity_decision.md` §2.2（補題 W2）・§3（定理 W3）・
  §4（定理 W4）・§5.2（系 W6）

## 目的

**証明の正しさではなく、主張の検算**である。定理 W3 は「$D$ の係数だけからの**有限手続き**が
$S_\infty$ を完全に決める」という**決定可能性の主張**なので、Lean の `Decidable` として
型に出せる。ここではその判定の中身（補題 W2 の (iv)）を実際に `decide` で走らせ、
report §5.2 の検算表の 2 例を機械的に再計算する。

## 形式化した主張

* `BucketVanish` / `BucketVanishFin` / `bucketVanish_iff` / `instDecidableBucketVanish` —
  **定理 W3 のステップ 3**（補題 W2 の (iv) による判定）が**決定可能**であること。
  判定は「$\gamma$ が $\mathbb{Z}$ 全体を走る」形で書かれているが、
  $S$ の像の外では和が空なので**有限個の $\gamma$ だけ見ればよい**。
* `psiHom` / `psi_apply` — $\bar\psi_u$（指数を $\gamma=pa+qb$ へ潰す環準同型）と、
  その係数がちょうどバケツ和であること。
* `psi_chi_perp_sub_one` / `bucketVanish_of_dvd` — **補題 W2 の (iii) ⇒ (iv)**
  （$(\chi^{u^\perp}-1)\mid\bar{\tilde E}\Rightarrow$ 全バケツが消える）。
* `torusE` / `torus_diag` / `torus_anti` / `torus_not_e1` / `torus_Sinf_candidates` —
  $\ell=2$ トーラス（report §1.1 の例）で判定手続きを `decide` で走らせ、
  $S_\infty=\{(1{:}1),(1{:}-1)\}$（$\pm$ で 4 個の候補として現れる）を得る。
* `famE3` / `fam3_e1` / `fam3_Sinf_card` — 族 $\ell\mid p'$ の例（$\ell=3$、$(p,q)=(3,1)$）。
  **例外直線は 1 本だけで、しかも $b=2$**（重複度 2）である。

## 形式化で分かったこと（記述の精度）

1. **系 W6 の $b$ は $|S_\infty|$ ではない。**
   本文 (K6) は $b=\sum_{P\in S_\infty}j^*(P)=\sum_im_i$ と正しく書いているが、
   $\ell=3$・$(p,q)=(3,1)$ の族（`famE3`）では **$S_\infty$ の点は 1 個なのに $b=2$**（重複度 2）である。
   Lean で判定手続きを走らせると $S_\infty$ の**点の個数**しか出てこないので、
   $j^*$ を出すには (K4) の重複度計算（$\mathbb{F}_\ell[z,w]$ の割り算）が別に要ることが型で見える。
   すなわち **(K3) の手続きだけでは $b$ は決まらず、(K4) が本質的に必要**である。
   report §3.1 のステップ 4 はそれを含んでいるが、本文 (K3) の「$S_\infty$ を完全に決める」は
   点集合までであって $j^*$ を含まないので、(K3) と (K4) の役割分担が読み取りにくい。
2. **判定条件 (iv) の「すべての $\gamma\in\mathbb{Z}$」は有限判定に落ちる**が、
   落とすには「$S$ の像の外では和が空」という一行が要る（`bucketVanish_iff`）。
   本文 (K3) は「(K2) の (iv) を判定する」としか書いておらず、
   **$\gamma$ の走査範囲が有限であることは書かれていない**。$O(|S|^3)$ という計算量の主張は
   この有限性に依存している。

## 形式化しなかったもの（mathlib の欠落か配線か）

`lean/logs/mathlib-gap-survey-cycle21.log`（3 段方式）を参照。

* **補題 W2 の (iv) ⇒ (iii)**（$\ker\bar\psi_u=(\chi^{u^\perp}-1)$）:
  Laurent 多項式環の商が $\mathbb{F}_\ell[y^{\pm1}]$ になるという座標変換が要る。
  `AddMonoidAlgebra` も `Finsupp.mapDomain` の環準同型性（`AddMonoidAlgebra.mapDomain_mul`）も
  **mathlib に在る**ので、欠落ではなく**配線**である。
  **cycle 48 step 3 で書いた**（`PropKW2Converse.lean` の `dvd_of_psi_eq_zero`。
  同値そのものは `psi_eq_zero_iff_dvd`）。**「配線である」という cycle 20 の判定は当たっていた**——
  使った素材は `AddMonoidAlgebra.domCongr` と `AddMonoidAlgebra.mapDomain` の 2 つだけである。
  **いまは残りではない。そう書く。**
* **定理 W4 の $e_j$ 側**（$\ell$ 進近傍の変形から定まる量）:
  $T$ 展開と $\bar\psi_u$ の合成を組む必要がある。これも配線。
* **系 W7（$b\le\frac12\mathrm{per}(\mathrm{Newt})$）**: Ostrowski（Newton 多面体の加法性）と
  格子周長の Minkowski 和加法性が要る。`Newton polytope` は mathlib の
  `Mathlib/RingTheory/MvPolynomial/Symmetric/NewtonIdentities.lean`（Newton 恒等式）とは別物で、
  **多面体としての Newton 多面体は無い**（本サイクルの調査で `newtonPolytope` 0 件・
  `newton polygon` の内容ヒットはすべて Newton–Raphson / Newton 恒等式）。
-/
import Mathlib

namespace IntegrableLattice
namespace SInfinity

open Finset

/-- $\bar{\tilde E}\in\mathbb{F}_\ell[z^{\pm1},w^{\pm1}]$ を「台＋係数」で与えたもの。 -/
structure Supp (ℓ : ℕ) where
  /-- 台（$\mathrm{supp}(\bar{\tilde E})$）。 -/
  S : Finset (ℤ × ℤ)
  /-- 係数。 -/
  c : ℤ × ℤ → ZMod ℓ

variable {ℓ : ℕ}

/-- 指数の対 $(p,q)$ と方向 $u=(a,b)$ の組 $pa+qb$。 -/
def pair (u pq : ℤ × ℤ) : ℤ := pq.1 * u.1 + pq.2 * u.2

/-- **補題 W2 の (iv)**（バケツ分けの判定）。$\gamma$ は $\mathbb{Z}$ 全体を走る。 -/
def BucketVanish (E : Supp ℓ) (u : ℤ × ℤ) : Prop :=
  ∀ γ : ℤ, ∑ pq ∈ E.S.filter (fun pq => pair u pq = γ), E.c pq = 0

/-- 有限判定版（$S$ の像の上だけを走る）。 -/
def BucketVanishFin (E : Supp ℓ) (u : ℤ × ℤ) : Prop :=
  ∀ γ ∈ E.S.image (pair u), ∑ pq ∈ E.S.filter (fun pq => pair u pq = γ), E.c pq = 0

/-- **定理 W3 のステップ 3 が有限判定であること**。
$S$ の像の外では和が空なので、無限個の $\gamma$ を見る必要はない。 -/
theorem bucketVanish_iff (E : Supp ℓ) (u : ℤ × ℤ) :
    BucketVanish E u ↔ BucketVanishFin E u := by
  constructor
  · intro h γ _
    exact h γ
  · intro h γ
    by_cases hγ : γ ∈ E.S.image (pair u)
    · exact h γ hγ
    · have : E.S.filter (fun pq => pair u pq = γ) = ∅ := by
        refine Finset.filter_eq_empty_iff.mpr ?_
        intro pq hpq hcon
        exact hγ (Finset.mem_image.mpr ⟨pq, hpq, hcon⟩)
      simp [this]

instance decidableBucketVanishFin (E : Supp ℓ) (u : ℤ × ℤ) :
    Decidable (BucketVanishFin E u) :=
  Finset.decidableDforallFinset

instance decidableBucketVanish (E : Supp ℓ) (u : ℤ × ℤ) : Decidable (BucketVanish E u) :=
  decidable_of_iff _ (bucketVanish_iff E u).symm

/-! ## $\bar\psi_u$（環準同型）と補題 W2 の (iii) ⇒ (iv) -/

/-- $\mathbb{F}_\ell[z^{\pm1},w^{\pm1}]$ を群環として実現したもの。 -/
abbrev LaurentF (ℓ : ℕ) := AddMonoidAlgebra (ZMod ℓ) (ℤ × ℤ)

/-- $\chi^{v}=z^{v_1}w^{v_2}$。 -/
noncomputable def chi (v : ℤ × ℤ) : LaurentF ℓ := AddMonoidAlgebra.single v 1

/-- 指数を $\gamma=pa+qb$ へ潰す加法準同型。 -/
def pairAddHom (u : ℤ × ℤ) : (ℤ × ℤ) →+ ℤ where
  toFun := pair u
  map_zero' := by simp [pair]
  map_add' := by
    intro x y
    simp [pair]
    ring

/-- $\bar\psi_u:\mathbb{F}_\ell[z^{\pm1},w^{\pm1}]\to\mathbb{F}_\ell[y^{\pm1}]$。 -/
noncomputable def psiHom (u : ℤ × ℤ) :
    LaurentF ℓ →+* AddMonoidAlgebra (ZMod ℓ) ℤ where
  toFun := AddMonoidAlgebra.mapDomain (pairAddHom u)
  map_one' := by
    rw [AddMonoidAlgebra.one_def, AddMonoidAlgebra.mapDomain_single, AddMonoidAlgebra.one_def]
    simp [pairAddHom, pair]
  map_mul' x y := AddMonoidAlgebra.mapDomain_mul (pairAddHom u) x y
  map_zero' := AddMonoidAlgebra.mapDomain_zero _
  map_add' x y := AddMonoidAlgebra.mapDomain_add _ _ _

/-- $\bar\psi_u(\chi^{u^\perp}-1)=0$（$\langle u^\perp,u\rangle=0$）。 -/
theorem psi_chi_perp_sub_one (u : ℤ × ℤ) :
    psiHom (ℓ := ℓ) u (chi (u.2, -u.1) - 1) = 0 := by
  have hzero : pair u (u.2, -u.1) = 0 := by simp [pair]; ring
  have h1 : psiHom (ℓ := ℓ) u (chi (u.2, -u.1)) = 1 := by
    show AddMonoidAlgebra.mapDomain (pairAddHom u) (AddMonoidAlgebra.single _ (1 : ZMod ℓ)) = 1
    rw [AddMonoidAlgebra.mapDomain_single, AddMonoidAlgebra.one_def]
    simp [pairAddHom, hzero]
  rw [map_sub, h1, map_one, sub_self]

/-- **補題 W2 の (iii) ⇒ (iv) の代数的な核**。
$(\chi^{u^\perp}-1)\mid\bar{\tilde E}$ なら $\bar\psi_u(\bar{\tilde E})=0$。 -/
theorem psi_eq_zero_of_dvd (u : ℤ × ℤ) (E : LaurentF ℓ)
    (h : (chi (u.2, -u.1) - 1) ∣ E) : psiHom u E = 0 := by
  obtain ⟨H, rfl⟩ := h
  rw [map_mul, psi_chi_perp_sub_one, zero_mul]

/-- $\bar\psi_u(E)$ の $\gamma$ 係数はちょうどバケツ和である。 -/
theorem psi_coeff (u : ℤ × ℤ) (E : LaurentF ℓ) (γ : ℤ) :
    (psiHom u E).coeff γ
      = ∑ pq ∈ E.coeff.support.filter (fun pq => pair u pq = γ), E.coeff pq := by
  show (Finsupp.mapDomain (pairAddHom u) E.coeff) γ = _
  rw [Finsupp.mapDomain, Finsupp.sum_apply, Finsupp.sum, Finset.sum_filter]
  refine Finset.sum_congr rfl fun pq _ => ?_
  by_cases h : pair u pq = γ <;>
    simp [Finsupp.single_apply, pairAddHom, pair, h]

/-! ## 判定手続きを実例で走らせる -/

/-- $\ell=2$ トーラス（bouquet $(1,0),(0,1)$、$p=q=1$）の $\bar{\tilde E}$。
$\tilde E=-(z^2w+w+zw^2+z-4zw)$ の $\bmod\ 2$ 還元で、$(1,1)$ の係数は $4\equiv0$ なので台に入らない。
report `cycle20_T3_cancellation_recursion.md` §1.1 の例と同じ。 -/
def torusE : Supp 2 where
  S := {(2, 1), (0, 1), (1, 2), (1, 0)}
  c := fun _ => 1

/-- $u=(1,1)$（対角）は $S_\infty$ に入る。 -/
theorem torus_diag : BucketVanish torusE (1, 1) := by decide

/-- $u=(1,-1)$（反対角）も $S_\infty$ に入る。 -/
theorem torus_anti : BucketVanish torusE (1, -1) := by decide

/-- $u=(1,0)$ は入らない。 -/
theorem torus_not_e1 : ¬ BucketVanish torusE (1, 0) := by decide

/-- 定理 W3 のステップ 2 の候補集合（$S$ の差ベクトルから作る）を、
トーラスについて具体的に与えたもの（原始化ずみ・$\pm$ を潰していない）。 -/
def torusCandidates : Finset (ℤ × ℤ) :=
  {(1, 1), (1, -1), (1, 0), (0, 1), (2, 1), (1, 2)}

/-- 候補のうち判定を通るのはちょうど $(1,1)$ と $(1,-1)$ である
（$\mathbb{P}^1$ の点としては 2 点。cycle 16 定理 D2 の $b=2$ と整合）。 -/
theorem torus_Sinf_candidates :
    torusCandidates.filter (fun u => BucketVanish torusE u) = {(1, 1), (1, -1)} := by
  decide

/-- 族 $\ell\mid p'$ の例（$\ell=3$、$(p,q)=(3,1)$）。
$E=-(3f_z+f_w)$、$\tilde E\bmod 3=-(zw^2+z-2zw)$ で台は $\{(1,2),(1,0),(1,1)\}$、
係数はすべて $-1\equiv2$、$(1,1)$ は $+2$。 -/
def famE3 : Supp 3 where
  S := {(1, 2), (1, 0), (1, 1)}
  c := fun pq => if pq = (1, 1) then 2 else 2

/-- 例外直線の方向 $u=(1,0)$（$u^\perp=(0,-1)$、$\bar{\tilde E}$ は $(w-1)^2$ を含む）。 -/
theorem fam3_e1 : BucketVanish famE3 (1, 0) := by decide

/-- 対角方向は入らない。 -/
theorem fam3_not_diag : ¬ BucketVanish famE3 (1, 1) := by decide

/-- **$b$ は $|S_\infty|$ ではない**ことの witness。
この族では判定を通る候補は $\pm(1,0)$ の 1 方向だけ（$\mathbb{P}^1$ の 1 点）だが、
系 W6 の $b$ は重複度 2 である（report §5.2 の検算表「族 $\ell\mid p'$」）。 -/
theorem fam3_Sinf_singleton :
    ({(1, 0), (0, 1), (1, 1), (1, -1), (1, 2), (2, 1)} : Finset (ℤ × ℤ)).filter
      (fun u => BucketVanish famE3 u) = {(1, 0)} := by
  decide

end SInfinity
end IntegrableLattice
