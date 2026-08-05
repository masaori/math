/-
# 命題 T の舞台の構成（完備な局所環が Hensel 的であること）— cycle 43 step 3

対応する人手証明:

* 本文ブロック `paper_062_theorem_T`（命題 T）の証明のうち、
  「2 は $\mathbb{Q}(\zeta_L)$ で不分岐であり、$w^2-Aw+1$ の根が持ち上がる」の段

## この step が何を埋めるか

cycle 42 step 2（`PropTHenselLift.lean`）は、この段の中身を
**「Hensel 的な局所環で、剰余体が原始 $L$ 乗根を持つ」という舞台を仮定として受け取った形**で書いた。
**残っていたのはその舞台そのものの構成である。**

## 2026-08-05 実測（台帳の記録が 1 つ誤っていた。そう書く）

台帳は「`HenselianLocalRing` はこの版の mathlib では 1 ファイルにしか現れず、
**インスタンスが 1 つも無い**」と書いていた。

* **1 ファイルにしか現れないことは正しい**（`Mathlib/RingTheory/Henselian.lean`）。
* **インスタンスが無いという側は誤りである。** `Field.henselian`（同 114 行）が在り、
  体は Hensel 的な局所環である。ただしこれは退化した舞台であって、この段が要求するものではない。
* **無いのは向きである。** 在るのは
  `HenselianLocalRing R → HenselianRing R (\mathfrak m)`（同 154 行）と
  `IsAdicComplete I R → HenselianRing R I`（同 170 行）で、
  **`HenselianRing` から `HenselianLocalRing` へ戻る向きが無い。**
  台帳が「配線である」と判定していたのは当たっている。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。使うのは可換環の演算と剰余体への還元だけである。
舞台となる環（$\mathbb{Z}_p$ や局所体の整数環）自身は非可算でありうるが、
**濃度は主張に入らない**（cycle 41 step 3・cycle 42 step 2 と同じ扱い）。
$p$ 進の位相は非アルキメデス的であり、$\mathbb{R}$ の完備性を使う場面は無い。

## 書いたこと

1. **`HenselianRing` から `HenselianLocalRing` へ戻る向き**（`henselianLocalRing_of_henselianRing`）。
   **芯は 1 行である**——2 つの定義の違いは、微分の値に単元性を要求する場所が
   $R$ の中か剰余環の中かだけで、$R$ の単元は剰余環でも単元だからである。
2. **したがって完備な局所環は Hensel 的である**（`henselianLocalRing_of_isAdicComplete`）。
3. **本文が使う舞台にそれが当たること**——
   $\mathbb{Z}_p$（`henselianLocalRing_padicInt`）と、非アルキメデス的局所体の整数環（`henselianLocalRing_localField`）。
   どちらも mathlib が完備性のインスタンスを持っているので、段 2 がそのまま当たる。

## 形式化しなかったもの

* **その舞台の剰余体が原始 $L$ 乗根を持つこと。**
  本文が言っているのは $\mathbb{Q}(\zeta_L)$ の 2 の上での完備化についてであり、
  剰余体が $\zeta_L$ の像を含むことは `PropTHenselLift.lean` の段 1・段 2 が
  仮定として受け取ったままである。**舞台の Hensel 性は入ったが、根の側は入っていない。そう書く。**
-/
import Mathlib
import IntegrableLattice.PropTHenselLift

namespace IntegrableLattice
namespace HenselianStage

open IsLocalRing ValuativeRel

/-! ## 段 1: `HenselianRing` から `HenselianLocalRing` へ戻る -/

section Bridge

variable (R : Type*) [CommRing R] [IsLocalRing R]

/-- **極大イデアルで Hensel 的な局所環は、Hensel 的な局所環である。**

mathlib は逆向き（`HenselianLocalRing R → HenselianRing R (\mathfrak m)`）だけを持っている。

2 つの定義の違いは、微分の値 $f'(a_0)$ に単元性を要求する場所だけである——
`HenselianLocalRing` は $R$ の中で、`HenselianRing` は剰余環の中で要求する。
$R$ の単元は環準同型で単元へ移るので、こちらの向きは仮定が強いほうから弱いほうへ渡すだけで済む。 -/
theorem henselianLocalRing_of_henselianRing
    [HenselianRing R (maximalIdeal R)] : HenselianLocalRing R where
  is_henselian f hf a₀ h₁ h₂ :=
    HenselianRing.is_henselian f hf a₀ h₁ (h₂.map (Ideal.Quotient.mk (maximalIdeal R)))

/-- **極大イデアルについて完備な局所環は Hensel 的である。**

段 1 に mathlib の `IsAdicComplete.henselianRing` を渡すだけである。
**これが 命題 T の段 3 が要求している舞台である。** -/
theorem henselianLocalRing_of_isAdicComplete
    [IsAdicComplete (maximalIdeal R) R] : HenselianLocalRing R :=
  henselianLocalRing_of_henselianRing R

end Bridge

/-! ## 段 2: 本文が使う舞台に当てる -/

section Instances

/-- $p$ 進整数環は Hensel 的な局所環である。 -/
theorem henselianLocalRing_padicInt (p : ℕ) [Fact p.Prime] :
    HenselianLocalRing ℤ_[p] :=
  henselianLocalRing_of_isAdicComplete ℤ_[p]

/-- **非アルキメデス的局所体の整数環は Hensel 的な局所環である。**

本文の「$\mathbb{Q}(\zeta_L)$ の 2 の上の素点での完備化」はこの形をしている。 -/
theorem henselianLocalRing_localField (K : Type*) [Field K] [ValuativeRel K]
    [UniformSpace K] [IsUniformAddGroup K] [IsNonarchimedeanLocalField K] :
    HenselianLocalRing 𝒪[K] :=
  henselianLocalRing_of_isAdicComplete 𝒪[K]

end Instances

/-! ## 段 3: 段 3 の芯を、仮定ではなく完備性から受け取る形で述べ直す -/

section Applied

variable (K : Type*) [Field K] [ValuativeRel K] [UniformSpace K] [IsUniformAddGroup K]
  [IsNonarchimedeanLocalField K]

/-- **cycle 42 step 2 の持ち上げを、完備な舞台の上で述べ直したもの。**

`PropTHenselLift.exists_root_quadratic_of_henselian` は舞台の Hensel 性を仮定として受け取っていた。
段 2 でそれが局所体の整数環について成り立つので、**仮定を落とせる。** -/
theorem exists_root_quadratic_localField (A : 𝒪[K]) (z : (𝒪[K])ˣ)
    (hA : A - ((z : 𝒪[K]) + ((z⁻¹ : (𝒪[K])ˣ) : 𝒪[K])) ∈ maximalIdeal 𝒪[K])
    (hsep : IsUnit ((z : 𝒪[K]) - ((z⁻¹ : (𝒪[K])ˣ) : 𝒪[K]))) :
    ∃ r : 𝒪[K], r ^ 2 - A * r + 1 = 0 ∧ r - (z : 𝒪[K]) ∈ maximalIdeal 𝒪[K] :=
  letI := henselianLocalRing_localField K
  PropTHenselLift.exists_root_quadratic_of_henselian A z hA hsep

end Applied

end HenselianStage
end IntegrableLattice
