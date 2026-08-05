/-
# 命題 T の舞台を、$\mathfrak m$ 進完備化の側から具体化する段 — cycle 49 step 3

対応する人手証明: 本文ブロック `paper_062_theorem_T`（命題 T）の段 3——
$\mathbb{Q}(\zeta_L)$ の $2$ の上での完備化で $w^2-Aw+1$ の根を持ち上げる段。

## この段が塞ぐ穴と、測って分かったこと

cycle 42 step 2・cycle 43 step 3 で、持ち上げそのものと「完備な局所環が Hensel 的であること」は入った。
cycle 48 step 2 は残りを測り、**要るのは完備化そのものが舞台であることだと書き直し、
そのうち無いのは「付値の位相が $\mathfrak m$ 進位相であること」の 1 本だと測った。**

**cycle 49 step 3 で同じ場所を別の側から測ると、mathlib は舞台そのものを持っていた。そう書く。**
非アルキメデス的局所体については $\mathcal{O}$ の $\mathfrak m$ 進完備性の instance が在り
（`Mathlib/NumberTheory/LocalField/Basic.lean` 176 行）、
**それとは別に、Noether 局所環 $R$ の $\mathfrak m$ 進完備化そのものについても在る**
（`Mathlib/RingTheory/AdicCompletion/LocalRing.lean` 127 行）。
後者は付値にも位相にも触れずに立つ。**したがって舞台は 1 つ書き下せる。**

**それでも 命題 T は完了しない。残る形が変わる。そう書く**——
本文の舞台は付値による完備化であって $\mathfrak m$ 進完備化ではないので、
**残るのは「2 つの完備化が同じものであること」である。**
cycle 48 が測った「付値の位相が $\mathfrak m$ 進位相であること」はその同定の中身であり、
測定そのものは正しい。変わったのは、**その 1 本を渡した先に何が待っているかである**——
渡した先はもう空ではなく、mathlib の instance が待っている。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

**$\mathbb{R}$ へは 1 度も出ない。** $\mathfrak m$ 進位相は $0$ の近傍がイデアルの冪でできる線形位相であり、
アルキメデス的な絶対値も距離も使わない（cycle 43 step 4 が $p$ 進の評価写像について測ったのと同じ形である）。
剰余体は $\mathbb{F}_2$ の拡大であり、$\mathbb{Q}$ にも $\mathbb{R}$ にも触れない。

## 書いたこと（3 段）

1. Noether 局所環の $\mathfrak m$ 進完備化は Hensel 的な局所環である（`henselianLocalRing_adicCompletion`）。
2. その剰余体は元の環の剰余体と同型である（`residueFieldEquiv`）。
   剰余標数の条件は、この同型で元の環の側から移せる。
3. 舞台として使える形に束ねた（`exists_root_quadratic_adicCompletion`）——
   剰余標数 $2$ の Noether 局所環の $\mathfrak m$ 進完備化の上で、
   $L$ が奇なら $w^2-Aw+1$ の根が原始 $L$ 乗根と合同に取れる。
   **cycle 42 step 2 の持ち上げと cycle 44 の根の側が、仮定なしでここへ当たる。**

## 形式化しなかったもの

* **本文の付値による完備化が、この $\mathfrak m$ 進完備化と同じものであること。**
  すなわち $\mathbb{Q}(\zeta_L)$ の 2 の上での完備化が、この舞台の形をしていることである。
  これが 命題 T に残る舞台の同定であり、中身は付値の位相が $\mathfrak m$ 進位相であることである
  （2026-08-05 実測、`mathlib-gap-survey-cycle49-adic-stage.log`。
  `IsAdic` は `Mathlib/Topology/Algebra/Nonarchimedean/AdicTopology.lean` に在るが、
  付値環についてそれを述べた宣言は 3 段とも 0 件であり、
  数体の完備化を非アルキメデス的局所体として登録した instance も無い）。
-/
import Mathlib
import IntegrableLattice.HenselianStage
import IntegrableLattice.PropTResidueRoot

namespace IntegrableLattice
namespace PropTAdicStage

open IsLocalRing

variable (R : Type*) [CommRing R] [IsNoetherianRing R] [IsLocalRing R]

/-- $\mathfrak m$ 進完備化の記号（本文の完備化に対応させる舞台）。 -/
abbrev Completion : Type _ := AdicCompletion (maximalIdeal R) R

/-! ## 1. 舞台が Hensel 的であること -/

/-- **Noether 局所環の $\mathfrak m$ 進完備化は Hensel 的な局所環である。**

中身は 2 つの引き合わせだけである——mathlib が $\mathfrak m$ 進完備性を与え
（`AdicCompletion/LocalRing.lean`）、cycle 43 step 3 の
`HenselianStage.henselianLocalRing_of_isAdicComplete` がそこから Hensel 性を出す。 -/
theorem henselianLocalRing_adicCompletion :
    HenselianLocalRing (Completion R) := by
  haveI : IsLocalRing (Completion R) :=
    AdicCompletion.isLocalRing_of_fg (maximalIdeal R).fg_of_isNoetherianRing
  exact HenselianStage.henselianLocalRing_of_isAdicComplete (Completion R)

/-! ## 2. 剰余体が保たれること -/

/-- **舞台の剰余体は元の環の剰余体と同型である。**

mathlib の `AdicCompletion.residueField_map_bijective_of_fg` を全単射から同型へ束ねるだけである。 -/
noncomputable def residueFieldEquiv :
    haveI := AdicCompletion.isLocalRing_of_fg (R := R) (maximalIdeal R).fg_of_isNoetherianRing
    ResidueField R ≃+* ResidueField (Completion R) :=
  haveI := AdicCompletion.isLocalRing_of_fg (R := R) (maximalIdeal R).fg_of_isNoetherianRing
  haveI := AdicCompletion.algebraMap_isLocalHom_of_fg (R := R)
    (maximalIdeal R).fg_of_isNoetherianRing
  RingEquiv.ofBijective
    (ResidueField.map (algebraMap R (Completion R)))
    (AdicCompletion.residueField_map_bijective_of_fg (maximalIdeal R).fg_of_isNoetherianRing)

/-! ## 3. 舞台として束ねる -/

section Stage

variable [IsDomain (Completion R)] [CharP (ResidueField (Completion R)) 2]

/-- **本文の段 3 の結論を、$\mathfrak m$ 進完備化の上で仮定なしに述べたもの。**

`PropTResidueRoot.exists_root_congr_pow_of_odd_of_charTwo` は舞台の Hensel 性を
インスタンスとして要求していた。段 1 でそれが出るので、**その仮定は落ちる。**
残っているのは剰余標数が $2$ であることだけで、これは元の環の剰余体の性質である
（段 2 の同型で移せる）。 -/
theorem exists_root_quadratic_adicCompletion
    (ζ : (Completion R)ˣ) {L j : ℕ} (hL : Odd L)
    (hζ : IsPrimitiveRoot ((ζ : Completion R)) L) (hj : ¬ L ∣ j) (A : Completion R)
    (hA : A - (((ζ ^ j : (Completion R)ˣ) : Completion R)
      + (((ζ ^ j)⁻¹ : (Completion R)ˣ) : Completion R)) ∈ maximalIdeal (Completion R)) :
    ∃ r : Completion R, r ^ 2 - A * r + 1 = 0 ∧
      r - ((ζ ^ j : (Completion R)ˣ) : Completion R) ∈ maximalIdeal (Completion R) :=
  letI := henselianLocalRing_adicCompletion R
  PropTResidueRoot.exists_root_congr_pow_of_odd_of_charTwo ζ hL hζ hj A hA

end Stage

end PropTAdicStage
end IntegrableLattice
