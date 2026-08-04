/-
# 補題 Q1′（整数のままの分解 $\tilde E=BG+\ell H$）— cycle 33 step 1

対応する人手証明:

* 根拠 report: `outputs/reports/cycle21_T3_drop_assumption_B_star.md` §3.1（補題 Q1′）
* 台帳: `structured-latex/tools/formalization-coverage.ts` の `paper_106_theorem_drop_assumption`
* 同じ命題の他の段は `DropAssumptionBStar.lean`（組合せ・数え上げ）、
  `CrudeArchimedeanBound.lean`（補題 Q0）、`CyclotomicValuationQ4a.lean`（補題 Q4a）にある。

## 人手証明との対応

> **補題 Q1′.** $B:=\prod_i(\chi^{v_i}-1)^{m_i}$ と置く。$\bar{\tilde E}/\bar B$ の任意の持ち上げ
> $G$ を取ると $H:=(\tilde E-BG)/\ell\in\mathbb{Z}[z^{\pm},w^{\pm}]$ であり、
> $\bar G$ は原始二項式因子 $\chi^v-1$ をひとつも持たない。
>
> **証明.** $\bar B\bar G=\bar{\tilde E}$ なので $\tilde E-BG$ の全係数が $\ell$ で割れる。
> $\bar G=c\chi^{w_0}\bar G_0$ で、$(1.2)$ の一意性から $\bar G_0$ は $\chi^v-1$ 型の因子を持たない。
> 単項式 $\chi^{w_0}$ と単元 $c$ は素元 $\chi^v-1$ で割れないので $\bar G$ も持たない。

証明は 2 つの主張からなる。この file はその 2 つを別々の定理として置く。

| 人手証明の行 | この file の定理 |
|---|---|
| 全係数が $\ell$ で割れるので $H$ が整数係数 | `exists_lift_of_reduction_eq` |
| 単元倍しても素元で割れないことは変わらない | `not_dvd_unit_mul` |
| 上の 2 つを合わせた補題 Q1′ | `lemma_Q1'` |

## 2 変数 Laurent 環をどう置いたか

$\mathbb{Z}[z^{\pm1},w^{\pm1}]$ は $\mathbb{Z}$ 上の群環 $\mathbb{Z}[\mathbb{Z}^2]$ である。
mathlib には 2 変数 Laurent 環そのものの型は無いが、`AddMonoidAlgebra ℤ (ℤ × ℤ)` が
定義上ちょうどこれであり、可換環の構造もそのまま入る。**新しい型を作らずに済むので作っていない。**
単項式 $\chi^{(p,q)}=z^pw^q$ は `AddMonoidAlgebra.single (p, q) 1` にあたる。

証明が使うのは環であることと係数ごとの評価だけなので、**係数の型と指数の型は一般のまま置いた**
（$\mathbb{Z}^2$ に固定していない）。$\mathbb{Z}[z^{\pm},w^{\pm}]$ はその特殊化として
`laurentTwo` で与えてある。

## 形式化しなかったもの

* **$\bar{\tilde E}$ の分解 $(1.2)$ そのもの**（$\bar B$ と $\bar G_0$ の存在と一意性）。
  これは cycle 20 の定理 W1・W4 であって補題 Q1′ の主張ではない。補題 Q1′ は
  「$(1.2)$ が与えられたとき何が言えるか」なので、$(1.2)$ は仮定として型に出してある。
* **$\mathbb{F}_\ell[z^{\pm},w^{\pm}]$ が一意分解環であること。**
  人手証明は $(1.2)$ の一意性を引くためにこれに触れるが、**補題 Q1′ の証明自体は使わない**——
  使うのは「単元倍は割り切りを変えない」という初等的な事実だけである（`not_dvd_unit_mul`）。
  形式化して分かったのはこの点で、一意分解性は $(1.2)$ を作る側の要求であって
  補題 Q1′ の側の要求ではない。
-/
import Mathlib

namespace IntegrableLattice
namespace PropQLaurentLift

open Finset

/-- $\mathbb{Z}[z^{\pm1},w^{\pm1}]$（2 変数 Laurent 多項式環）。
群環 $\mathbb{Z}[\mathbb{Z}^2]$ そのものである。 -/
abbrev laurentTwo : Type := AddMonoidAlgebra ℤ (ℤ × ℤ)

/-- 単項式 $\chi^{(p,q)}=z^pw^q$。 -/
noncomputable def chi (v : ℤ × ℤ) : laurentTwo := AddMonoidAlgebra.single v 1

/-! ## 段 1: 係数がすべて `c` で割れるなら `c` でくくれる -/

/-- 係数がすべて `c` で割り切れる `Finsupp` は `c` でくくれる。
人手証明の「$\tilde E-BG$ の全係数が $\ell$ で割れる」から「$H$ が整数係数」を出す段。 -/
theorem exists_smul_of_forall_dvd {G : Type*} {c : ℤ} (x : G →₀ ℤ)
    (h : ∀ g, c ∣ x g) : ∃ y : G →₀ ℤ, x = c • y := by
  classical
  refine ⟨Finsupp.mapRange (fun a => a / c) (by simp) x, ?_⟩
  ext g
  simp only [Finsupp.smul_apply, Finsupp.mapRange_apply, smul_eq_mul]
  exact (Int.mul_ediv_cancel' (h g)).symm

/-- **段 1（補題 Q1′ の前半）**。`ℓ` を法とする還元で `x` が消えるなら、`x = ℓ • y` と書ける。

`ℓ` を法とする還元は係数ごとの `Int.cast : ℤ → ZMod ℓ` であり、
`AddMonoidAlgebra.mapRingHom` が環準同型にする（積が積へ行くことがこれで保証される）。 -/
theorem exists_lift_of_reduction_eq {G : Type*} [AddMonoid G] (ℓ : ℕ)
    (x : AddMonoidAlgebra ℤ G)
    (hx : AddMonoidAlgebra.mapRingHom G (Int.castRingHom (ZMod ℓ)) x = 0) :
    ∃ y : AddMonoidAlgebra ℤ G, x = (ℓ : ℤ) • y := by
  have hdvd : ∀ g, (ℓ : ℤ) ∣ x.coeff g := by
    intro g
    have h0 : ((x.coeff g : ℤ) : ZMod ℓ) = 0 := by
      have h := congrArg (fun z : AddMonoidAlgebra (ZMod ℓ) G => z.coeff g) hx
      simpa [AddMonoidAlgebra.coeff_mapRingHom] using h
    exact (ZMod.intCast_zmod_eq_zero_iff_dvd _ _).mp h0
  obtain ⟨y, hy⟩ := exists_smul_of_forall_dvd x.coeff hdvd
  refine ⟨AddMonoidAlgebra.ofCoeff y, ?_⟩
  apply AddMonoidAlgebra.coeff_injective
  rw [AddMonoidAlgebra.coeff_smul, AddMonoidAlgebra.coeff_ofCoeff]
  exact hy

/-! ## 段 2: 単元倍は割り切りを変えない -/

/-- `π` が `a` を割らないなら、`a` を単元倍しても割らない。
人手証明の「単項式 $\chi^{w_0}$ と単元 $c$ は素元 $\chi^v-1$ で割れないので $\bar G$ も持たない」。

**一意分解環であることは使わない。** 使うのは単元の逆元だけである。 -/
theorem not_dvd_unit_mul {R : Type*} [CommRing R] {π u a : R} (hu : IsUnit u)
    (h : ¬ π ∣ a) : ¬ π ∣ u * a := by
  intro hdvd
  refine h ?_
  obtain ⟨w, hw⟩ := hu
  obtain ⟨t, ht⟩ := hdvd
  refine ⟨(w⁻¹ : Rˣ) * t, ?_⟩
  have : a = (w⁻¹ : Rˣ) * (u * a) := by
    rw [← hw]
    simp [← mul_assoc]
  rw [this, ht]
  ring

/-- 単項式は Laurent 環の単元である（$\chi^{v}\cdot\chi^{-v}=1$）。 -/
theorem isUnit_chi (v : ℤ × ℤ) : IsUnit (chi v) := by
  have h1 : chi v * chi (-v) = 1 := by
    simp [chi, AddMonoidAlgebra.single_mul_single, AddMonoidAlgebra.one_def]
  have h2 : chi (-v) * chi v = 1 := by
    simp [chi, AddMonoidAlgebra.single_mul_single, AddMonoidAlgebra.one_def]
  exact ⟨⟨chi v, chi (-v), h1, h2⟩, rfl⟩

/-! ## 段 3: 補題 Q1′ -/

/-- **補題 Q1′**。

仮定は人手証明の $(1.2)$ をそのまま型に出したものである:
`B * G` の `ℓ` を法とする還元が `Ẽ` の還元に等しく（`hBG`）、
`G` の還元が「単元 `u` × 二項式因子を持たない `G₀`」の形をしている（`hG`）。

結論は 2 つ。

* `H := (Ẽ - B*G)/ℓ` が整数係数で存在する（`Ẽ = B*G + ℓ*H`）。
* `G` の還元は原始二項式因子 `π` をひとつも持たない。

`π` は `χ^v - 1` の形の元を想定しているが、**証明は `π` が何であるかを使わない**ので
一般の元のまま置いた（人手証明が使うのも「$\bar G_0$ が $\pi$ で割れないこと」だけである）。 -/
theorem lemma_Q1' {G : Type*} [AddCommMonoid G] (ℓ : ℕ)
    (Etilde B Gpoly : AddMonoidAlgebra ℤ G)
    (hBG : AddMonoidAlgebra.mapRingHom G (Int.castRingHom (ZMod ℓ)) (B * Gpoly) =
      AddMonoidAlgebra.mapRingHom G (Int.castRingHom (ZMod ℓ)) Etilde)
    {u G₀ π : AddMonoidAlgebra (ZMod ℓ) G} (hu : IsUnit u)
    (hG : AddMonoidAlgebra.mapRingHom G (Int.castRingHom (ZMod ℓ)) Gpoly = u * G₀)
    (hG₀ : ¬ π ∣ G₀) :
    (∃ H : AddMonoidAlgebra ℤ G, Etilde = B * Gpoly + (ℓ : ℤ) • H) ∧
      ¬ π ∣ AddMonoidAlgebra.mapRingHom G (Int.castRingHom (ZMod ℓ)) Gpoly := by
  constructor
  · -- 前半: 還元が消えるので `ℓ` でくくれる。
    obtain ⟨H, hH⟩ := exists_lift_of_reduction_eq ℓ (Etilde - B * Gpoly) (by
      rw [map_sub, hBG, sub_self])
    exact ⟨H, by rw [← hH]; ring⟩
  · -- 後半: 単元倍しても素元で割れないことは変わらない。
    rw [hG]
    exact not_dvd_unit_mul hu hG₀

end PropQLaurentLift
end IntegrableLattice
