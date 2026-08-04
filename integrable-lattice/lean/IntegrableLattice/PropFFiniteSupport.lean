/-
# 命題 F（有限台なら $\lambda$ は有限手続きで計算できる）

対応する人手証明:

* 本文ブロック `paper_prop_F`（`structured-latex/content/005_duality.ts`）
* 数値検証: `sagemath/check/cycle16_T1_lambda_l0`

## このファイルが担当する範囲（正直な範囲宣言）

命題 F は (F1 計算可能性) と (F2 境界) からなる。

**(F1) の心臓部は、非可算な添字集合が有限集合まで落ちることである。**
人手証明はそこを次のように書いている——素イデアル $(\gamma_v-1)$ の添字集合
$\mathbb{P}^{d-1}(\mathbb{Z}_p)$ は非可算だが、$\bar P$ を割りうるものは
**有限個の有理方向 $V(\bar P)=\{\mathrm{prim}(e-e'):e\ne e'\in E\}$ に限られる**。
その根拠は、割るためには
$$(\gamma_v-1)\mid\bar f\iff\forall a\in\pi(E):\ \sum_{e\in E,\ \pi(e)=a}c_e=0$$
の右辺が要り、各 $c_e\ne0$ なので**どのファイバーも 2 点以上でなければならない**という
数え上げの一点である。

**本ファイルが形式化するのはこの一点と、そこから出る有限性の結論である。**

形式化していないものと、その理由:

* **上の同値そのもの**（$(\gamma_v-1)\mid\bar f$ と係数和の消滅の同値）は、
  完備群環 $\mathbb{F}_p[[\Gamma]]$ と、$\{\prod_i(1+T_i)^{a_i}\}_{a\in A}$ の
  $\mathbb{F}_p$ 上の線形独立性（$(1+T)^{p^N}=1+T^{p^N}$ で $\mathbb{Z}/p^N$ へ落として示す段）が要る。
  mathlib に岩澤代数 $\mathbb{Z}_p[[T]]$ の一般論は `Mathlib/RingTheory/PowerSeries` と
  `Mathlib/Topology/Algebra/...` の断片としてしか無く、$d$ 変数の完備群環と
  その素イデアルの記述は**在らない**。ここは配線ではなく素材から要る。
* **(F2 境界)**（$d\ge2$ で述語 $l_0(f)\ge1$ が停止問題へ帰着する）は、
  計算可能性理論の主張である。mathlib には `Nat.Partrec` / `Turing` の一般論が在るが、
  「係数を計算する手続きで与えられた $f\in\mathbb{Z}_p[[\Gamma]]$」という**入力の与え方**を
  型にする設計をこちらがまだ持っていない。**mathlib の欠落ではなく、こちらの未設計である。**

## 形式化して分かったこと（本文との差）

* **「どのファイバーも 2 点以上」の段に、体であることも標数 $p$ であることも要らない。**
  必要なのは「$c_e\ne0$」と「和が 0」だけで、係数は任意の可換群（`AddCommGroup`）でよい。
  本文が $\mathbb{F}_p$ で書いているのは文脈がそうだからであって、
  この段の主張が要求しているからではない（cycle 27 step 2・本サイクルの命題 W* と同じ形）。
* **有限性の結論は「$V(\bar P)$ が有限」ではなく「候補が $V(\bar P)$ に入る」である。**
  $V(\bar P)$ が有限なのは $E$ が有限だから自明で、内容があるのは
  **割りうる方向がそこから出られない**という包含のほうである。
  本文の「右辺は有限個の演算だけで計算できる」が意味を持つのはこの包含による。

**新規性は主張しない**（群環の素因子を線形代数で決める議論は folklore の可能性が高く、
対応する文献命題は特定できていない。本文の但し書きと同じ）。
-/
import Mathlib

namespace IntegrableLattice

open Finset

/-! ## ファイバーが 2 点以上でなければならない段

人手証明の「各 $c_e\ne0$ なので、割るためにはどのファイバーも 2 点以上でなければならず、
したがって $\pi(e)=\pi(e')$ なる $e\ne e'$ が存在する」。 -/

section Fiber

variable {α β M : Type*} [DecidableEq α] [DecidableEq β] [AddCommGroup M]

/-- **命題 F (F1) の心臓部。**

`E` を有限な台、`c` を係数（`E` の上で 0 でない）、`π` を方向による分類とする。
**すべてのファイバーの係数和が消えるなら、`π` は `E` の上で単射でない。**

人手証明の「割るためにはどのファイバーも 2 点以上でなければならず、したがって
$\pi(e)=\pi(e')$ なる $e\ne e'$ が存在する」がこれである。

係数は任意の可換群でよい（体であることも標数 $p$ であることも使わない）。 -/
theorem exists_ne_of_fibers_sum_eq_zero (E : Finset α) (c : α → M) (π : α → β)
    (hc : ∀ e ∈ E, c e ≠ 0)
    (hsum : ∀ a ∈ E.image π, ∑ e ∈ E.filter (fun e => π e = a), c e = 0)
    (e₀ : α) (he₀ : e₀ ∈ E) :
    ∃ e ∈ E, ∃ e' ∈ E, e ≠ e' ∧ π e = π e' := by
  classical
  by_contra hcon
  push Not at hcon
  -- `π` は `E` 上で単射。よって `e₀` のファイバーは `{e₀}` だけ。
  have hfiber : E.filter (fun e => π e = π e₀) = {e₀} := by
    apply Finset.eq_singleton_iff_unique_mem.mpr
    refine ⟨Finset.mem_filter.mpr ⟨he₀, rfl⟩, ?_⟩
    intro x hx
    obtain ⟨hxE, hxπ⟩ := Finset.mem_filter.mp hx
    by_contra hne
    exact (hcon x hxE e₀ he₀ hne) hxπ
  have := hsum (π e₀) (Finset.mem_image_of_mem π he₀)
  rw [hfiber, Finset.sum_singleton] at this
  exact hc e₀ he₀ this

end Fiber

/-! ## 方向が有限集合に落ちる段

前段の結論「$\pi(e)=\pi(e')$ なる $e\ne e'$ が存在する」から、
方向が $V(E)=\{\mathrm{prim}(e-e'):e\ne e'\in E\}$ に入ることを言う。
$V(E)$ は `E` から有限手続きで作れる `Finset` である。 -/

section Directions

variable {d : ℕ}

/-- ベクトルの成分の最大公約数。$\mathrm{prim}$ の分母。 -/
def vecGcd (x : Fin d → ℤ) : ℤ := (Finset.univ : Finset (Fin d)).gcd x

/-- **原始化** $\mathrm{prim}(x)=x/\gcd(x)$。$x=0$ のときは $\gcd=0$ なので $0$ を返す
（本文は $e\ne e'$ にしか使わないので、この場合は現れない）。 -/
def prim (x : Fin d → ℤ) : Fin d → ℤ := fun i => x i / vecGcd x

/-- 原始化は成分ごとの整除で定義されている（$\gcd$ は各成分を割る）。 -/
theorem vecGcd_dvd (x : Fin d → ℤ) (i : Fin d) : vecGcd x ∣ x i :=
  Finset.gcd_dvd (Finset.mem_univ i)

/-- 各成分は $\gcd$ 倍で原始化から復元できる。 -/
theorem eq_vecGcd_mul_prim (x : Fin d → ℤ) (i : Fin d) : x i = vecGcd x * prim x i := by
  unfold prim
  exact (Int.mul_ediv_cancel' (vecGcd_dvd x i)).symm

/-- **原始化したベクトルは原始的である**（成分の $\gcd$ が単元）。

$x\ne0$ のときに成り立つ。本文が「方向が有理的に決まる」と言うときの
「方向」——$\mathbb{Z}_p v=\mathbb{Z}_p\,\mathrm{prim}(e-e')$ という**直線**——が
単元倍を除いて一意に取れることに対応する。単元倍の自由度は直線には効かないので、
ここで言えるのは「単元」までであり、それで十分である。 -/
theorem isUnit_vecGcd_prim (x : Fin d → ℤ) (hx : ∃ i, x i ≠ 0) :
    IsUnit (vecGcd (prim x)) := by
  classical
  obtain ⟨i₀, hi₀⟩ := hx
  have hg : vecGcd x ≠ 0 := by
    intro h
    apply hi₀
    have := eq_vecGcd_mul_prim x i₀
    rw [h, zero_mul] at this
    exact this
  -- `vecGcd x * vecGcd (prim x)` は `x` の全成分を割るので `vecGcd x` を割る
  have hdvd : vecGcd x * vecGcd (prim x) ∣ vecGcd x := by
    refine Finset.dvd_gcd fun i _ => ?_
    obtain ⟨k, hk⟩ : vecGcd (prim x) ∣ prim x i := Finset.gcd_dvd (Finset.mem_univ i)
    exact ⟨k, by rw [eq_vecGcd_mul_prim x i, hk]; ring⟩
  refine isUnit_of_dvd_one ?_
  obtain ⟨t, ht⟩ := hdvd
  refine ⟨t, ?_⟩
  have hcancel : vecGcd x * 1 = vecGcd x * (vecGcd (prim x) * t) := by
    rw [mul_one, ← mul_assoc, ← ht]
  exact mul_left_cancel₀ hg hcancel

/-- **候補となる方向の有限集合** $V(E)=\{\mathrm{prim}(e-e'):e\ne e'\in E\}$。
`E` から有限手続きで作れる（本文の「$\gcd$、Smith 標準形、多項式展開、係数和だけで計算できる」の
うち方向の列挙にあたる部分）。 -/
noncomputable def directions (E : Finset (Fin d → ℤ)) : Finset (Fin d → ℤ) := by
  classical
  exact ((E ×ˢ E).filter (fun q => q.1 ≠ q.2)).image (fun q => prim (q.1 - q.2))

/-- **(F1) の結論**: すべてのファイバーの係数和が消えるなら、
その方向は有限集合 $V(E)$ の元から作られる。
すなわち**非可算な添字集合を走る必要が無い**——これが本文の計算可能性の中身である。 -/
theorem mem_directions_of_fibers_sum_eq_zero
    {β : Type*} [DecidableEq β] {M : Type*} [AddCommGroup M]
    (E : Finset (Fin d → ℤ)) (c : (Fin d → ℤ) → M) (π : (Fin d → ℤ) → β)
    (hc : ∀ e ∈ E, c e ≠ 0)
    (hsum : ∀ a ∈ E.image π, ∑ e ∈ E.filter (fun e => π e = a), c e = 0)
    (e₀ : Fin d → ℤ) (he₀ : e₀ ∈ E) :
    ∃ e ∈ E, ∃ e' ∈ E, e ≠ e' ∧ π e = π e' ∧ prim (e - e') ∈ directions E := by
  classical
  obtain ⟨e, heE, e', he'E, hne, hπ⟩ :=
    exists_ne_of_fibers_sum_eq_zero E c π hc hsum e₀ he₀
  refine ⟨e, heE, e', he'E, hne, hπ, ?_⟩
  unfold directions
  refine Finset.mem_image.mpr ⟨(e, e'), ?_, rfl⟩
  exact Finset.mem_filter.mpr ⟨Finset.mem_product.mpr ⟨heE, he'E⟩, hne⟩

end Directions

end IntegrableLattice
