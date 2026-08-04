/-
# 無平方性から $\det G\neq0$ を出す段（命題 W\* の最後の 1 件）— cycle 38 step 1

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の
  「$\rho$ は分離的なので Euler の双対基底公式より」および $\det G=\pm N(\eta)$ の段

## このファイルが埋めるもの

台帳（`structured-latex/tools/formalization-coverage.ts`）が 命題 W\* の残りとして
名指ししていた最後の 1 件、すなわち **$\rho=\mathrm{rad}(\chi)$ が無平方であることから
$\det G\neq0$ を出す段**である。

cycle 37 step 1 は、この段の材料が mathlib に無いと実測して止めた——無平方性を
$R[x]$ から $K[x]$（$K$ は商体）へ移す Gauss 型の補題が無い
（`lean/logs/mathlib-gap-survey-cycle37-squarefree.log`）。**その実測は正しい。
誤っていたのは「だから書けない」という推論のほうである。** 同じログが名指しした
`IsIntegrallyClosed.eq_map_mul_C_of_dvd` と `Monic.dvd_of_fraction_map_dvd_fraction_map` を
使うと、移送そのものは自前で 1 本書ける（下記 `squarefree_map_of_monic`）。

## 書いたこと（4 段）

1. **無平方性の移送**（`squarefree_map_of_monic`）。$R$ が整閉整域、$K$ がその商体、
   $f\in R[x]$ がモニックで無平方なら、$f$ の $K[x]$ への像も無平方である。
2. **$\rho\mid\rho'g\Rightarrow\rho\mid g$**（`dvd_of_dvd_derivative_mul`）。
   $K$ の側で $\rho_K$ と $\rho_K'$ が互いに素であることを使い、
   $\rho$ がモニックであること（余りつき除算が $R[x]$ の中でできること）で $R[x]$ へ戻す。
3. **$\rho'(\theta)$ が零因子でないこと**（`derivative_mem_nonZeroDivisors`）。
   段 2 を $A=R[x]/(\rho)$ の言葉へ言い換えただけである。
4. **$\det G\neq0$**（`det_weightedGram_ne_zero_of_squarefree`）。段 3 と、
   cycle 37 step 1 の段 7（$\det G=\pm N(\eta)$）を繋ぐ。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

**この file は $\mathbb{R}$ へ 1 度も出ない。** 扱うのは $R[x]$（本論文では $\mathbb{Z}[x]$）と
その商体 $K$（$\mathbb{Q}$）の上の多項式の整除だけで、判定はすべて可算側で閉じている。
$K$ を経由するのは Bézout の関係を得るためであり、$\mathbb{R}$ 脱出ではない。

## 形式化しなかったもの

* **$\mu$（成分ごとに重複度 $a_i$ をとる元）が零因子でないこと**は仮定として受け取っている。
  本文は $a_i\ge1$ からこれを読んでいるが、$\mu$ を重複度から構成する段は書いていない。
* **$\rho=\mathrm{rad}(\chi)$ が無平方であること自体**は仮定として受け取っている。
  根基の構成（$\chi$ の相異なる既約因子の積）は書いていない。
-/
import Mathlib
import IntegrableLattice.EulerDualBasisCommRing
import IntegrableLattice.WStarPowerBasisInstance

namespace IntegrableLattice
namespace WStarSquarefree

open Polynomial

/-! ## 1. 無平方性を商体へ移す（Gauss 型の移送）

mathlib に無いことは cycle 37 step 1 が実測している
（`lean/logs/mathlib-gap-survey-cycle37-squarefree.log`）。素材は在るので自前で書く。 -/

section Transport

variable {R : Type*} [CommRing R] [IsIntegrallyClosed R]
variable (K : Type*) [Field K] [Algebra R K] [IsFractionRing R K]

/-- **モニックな無平方多項式の像は無平方である。**

$g\in K[x]$ が $g^2\mid f_K$ を満たすとする。$g$ をモニックに正規化した $h$ は
`IsIntegrallyClosed.eq_map_mul_C_of_dvd` により $R[x]$ の元の像である。
そこで $h'^2\mid f$ が `Monic.dvd_of_fraction_map_dvd_fraction_map` で $R[x]$ の中で成り立ち、
$f$ の無平方性から $h'$ が単元、したがって $g$ も単元になる。

体も分離性も既約性も使わない。使うのは $R$ が整閉整域であることだけである。 -/
theorem squarefree_map_of_monic {f : R[X]} (hf : f.Monic) (hsq : Squarefree f) :
    Squarefree (f.map (algebraMap R K)) := by
  classical
  intro g hg
  -- $f_K$ はモニックなので $0$ でなく、したがって $g\neq0$。
  have hfK : (f.map (algebraMap R K)).Monic := hf.map _
  have hg0 : g ≠ 0 := by
    rintro rfl
    exact hfK.ne_zero (by simpa using hg)
  have hc : g.leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr hg0
  -- $h:=g\cdot C(c^{-1})$ はモニックで、$g$ と同伴である。
  set h : K[X] := g * C g.leadingCoeff⁻¹ with hh
  have hunit : IsUnit (C g.leadingCoeff⁻¹ : K[X]) :=
    isUnit_C.mpr (inv_ne_zero hc).isUnit
  have hassoc : Associated h g := by
    rw [hh]; exact (associated_mul_isUnit_left_iff hunit).mpr (Associated.refl g)
  have hmonic : h.Monic := by
    rw [Monic, hh, leadingCoeff_mul, leadingCoeff_C, mul_inv_cancel₀ hc]
  -- $h\mid f_K$（$g\mid g\cdot g\mid f_K$ を経由する）。
  have hgdvd : g ∣ f.map (algebraMap R K) := (dvd_mul_left g g).trans hg
  have hhdvd : h ∣ f.map (algebraMap R K) := hassoc.dvd.trans hgdvd
  -- 段 (i): $h$ は $R[x]$ の元の像である。
  obtain ⟨h', hh'⟩ := IsIntegrallyClosed.eq_map_mul_C_of_dvd K hf hhdvd
  rw [hmonic.leadingCoeff, map_one, mul_one] at hh'
  have hmonic' : h'.Monic := by
    have hlc : algebraMap R K h'.leadingCoeff = 1 := by
      have hmap : (h'.map (algebraMap R K)).leadingCoeff = 1 := by
        rw [hh']; exact hmonic
      rwa [Polynomial.leadingCoeff_map_of_injective (IsFractionRing.injective R K)] at hmap
    have : algebraMap R K h'.leadingCoeff = algebraMap R K 1 := by simpa using hlc
    exact IsFractionRing.injective R K this
  -- 段 (ii): $h'^2\mid f$ を $R[x]$ の中で得る。
  have hsqdvd : (h' * h').map (algebraMap R K) ∣ f.map (algebraMap R K) := by
    rw [Polynomial.map_mul, hh']
    calc h * h ∣ g * g := (hassoc.mul_mul hassoc).dvd
      _ ∣ f.map (algebraMap R K) := hg
  have : h' * h' ∣ f :=
    hf.dvd_of_fraction_map_dvd_fraction_map (K := K) (hmonic'.mul hmonic') hsqdvd
  -- 段 (iii): 無平方性から $h'$ が単元、したがって $h$ も $g$ も単元。
  have hu' : IsUnit h' := hsq h' this
  have hu : IsUnit h := hh' ▸ hu'.map (Polynomial.mapRingHom (algebraMap R K))
  exact (hassoc.isUnit_iff).mp hu

end Transport

/-! ## 2. $\rho\mid\rho' g$ ならば $\rho\mid g$ -/

section Coprime

variable {R : Type*} [CommRing R] [IsIntegrallyClosed R]
set_option maxHeartbeats 1000000 in
/-- **無平方でモニックな $\rho$ について、$\rho\mid\rho'g$ ならば $\rho\mid g$。**

$K$ の側で $\rho_K$ が無平方（段 1）$\Rightarrow$ 分離的（$K$ は標数 $0$ なので完全体）
$\Rightarrow$ $\rho_K$ と $\rho_K'$ が互いに素、というのが芯である。
$R[x]$ へ戻すのに $\rho$ がモニック（したがって原始的）であることを使う。 -/
theorem dvd_of_dvd_derivative_mul (K : Type*) [Field K] [Algebra R K] [IsFractionRing R K]
    [CharZero K] {ρ : R[X]} (hmonic : ρ.Monic) (hsq : Squarefree ρ) {g : R[X]}
    (h : ρ ∣ derivative ρ * g) : ρ ∣ g := by
  classical
  set ι := algebraMap R K with hι
  have hsqK : Squarefree (ρ.map ι) := squarefree_map_of_monic K hmonic hsq
  -- $K$ は標数 $0$ の体なので完全体であり、無平方 $\Rightarrow$ 分離的。
  have hsep : (ρ.map ι).Separable := PerfectField.separable_iff_squarefree.mpr hsqK
  have hcop : IsCoprime (ρ.map ι) (derivative (ρ.map ι)) := hsep
  -- 仮定を $K[x]$ へ写す。
  have hK : ρ.map ι ∣ derivative (ρ.map ι) * g.map ι := by
    have hd := Polynomial.map_dvd ι h
    rwa [Polynomial.map_mul, ← Polynomial.derivative_map] at hd
  have hKg : ρ.map ι ∣ g.map ι := hcop.dvd_of_dvd_mul_left hK
  -- $\rho$ はモニックなので $R[x]$ の中で余りつき除算ができる。余りの像が $0$ なら余りも $0$。
  refine (Polynomial.modByMonic_eq_zero_iff_dvd hmonic).mp ?_
  have hzero : (g %ₘ ρ).map ι = 0 := by
    rw [Polynomial.map_modByMonic ι hmonic]
    exact (Polynomial.modByMonic_eq_zero_iff_dvd (hmonic.map ι)).mpr hKg
  exact Polynomial.map_injective ι (IsFractionRing.injective R K)
    (by rw [hzero, Polynomial.map_zero])

end Coprime

/-! ## 3. $\rho'(\theta)$ が零因子でないこと -/

section NonZeroDivisor

variable {R : Type*} [CommRing R] [IsIntegrallyClosed R]

/-- **$\rho$ がモニックで無平方なら、$A=R[x]/(\rho)$ の中で $\rho'(\theta)$ は零因子でない。**

段 2 を $A$ の言葉へ言い換えただけである（`AdjoinRoot.mk_eq_zero` で
$A$ の等式を $R[x]$ の整除へ戻す）。 -/
theorem derivative_mem_nonZeroDivisors (K : Type*) [Field K] [Algebra R K] [IsFractionRing R K]
    [CharZero K] {ρ : R[X]} (hmonic : ρ.Monic) (hsq : Squarefree ρ) :
    aeval (AdjoinRoot.root ρ) (derivative ρ) ∈ nonZeroDivisors (AdjoinRoot ρ) := by
  classical
  rw [mem_nonZeroDivisors_iff_left]
  intro z hz
  -- $A$ の元は $R[x]$ の元の像である。
  obtain ⟨g, rfl⟩ := AdjoinRoot.mk_surjective z
  rw [AdjoinRoot.aeval_eq, ← map_mul, AdjoinRoot.mk_eq_zero] at hz
  exact AdjoinRoot.mk_eq_zero.mpr (dvd_of_dvd_derivative_mul K hmonic hsq hz)

end NonZeroDivisor

/-! ## 4. $\det G\neq0$ -/

section Determinant

variable {R : Type*} [CommRing R] [IsDomain R] [IsIntegrallyClosed R]

/-- **命題 W\* の $\det G\neq0$。**

$\rho$ がモニックで無平方であること（＝本文の $\rho=\mathrm{rad}(\chi)$）と、
$\mu$ が零因子でないこと（＝本文の重複度 $a_i\ge1$）から出る。
$\det G=\pm N(\eta)$ は cycle 37 step 1 の段 7（`EulerDualBasis.det_weightedGram`）である。

**体も整域も分離性も既約性も使わない**——$A=R[x]/(\rho)$ は $\rho$ が可約なら整域でない。 -/
theorem det_weightedGram_ne_zero_of_squarefree (K : Type*) [Field K] [Algebra R K]
    [IsFractionRing R K] [CharZero K] {m : ℕ} {ρ : R[X]}
    (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) (hsq : Squarefree ρ)
    {μ : AdjoinRoot ρ} (hμ : μ ∈ nonZeroDivisors (AdjoinRoot ρ)) :
    (EulerDualBasis.weightedGram (R := R) (m := m) (AdjoinRoot.root ρ) μ).det ≠ 0 := by
  classical
  set b := WStarPowerBasis.adjoinRootBasis hmonic hdeg with hb
  have hpb := WStarPowerBasis.isPowerBasisOf_adjoinRoot hmonic hdeg
  have hred := WStarPowerBasis.isReductionOf_adjoinRoot hmonic hdeg
  rw [EulerDualBasis.det_weightedGram b hpb hred hmonic hdeg μ]
  refine mul_ne_zero ?_ ?_
  · -- $\det C=\pm1$ なので $0$ でない。
    have hsqC := EulerDualBasis.det_eulerMatrix_sq b hpb hmonic hdeg
    intro h
    rw [h] at hsqC
    simpa using hsqC.symm
  · -- $N(\eta)\neq0$ は $\eta$ が零因子でないことと同値（段 7 の相棒）。
    refine (EulerDualBasis.norm_ne_zero_iff_mem_nonZeroDivisors b _).mpr ?_
    exact mul_mem (derivative_mem_nonZeroDivisors K hmonic hsq) hμ

end Determinant

end WStarSquarefree
end IntegrableLattice
