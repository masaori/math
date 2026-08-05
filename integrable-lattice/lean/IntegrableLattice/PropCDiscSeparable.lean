/-
# 命題 C′ の残り 1 段（判別式と分離性の同値）— cycle 46 step 2

対応する人手証明:

* 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の statement の
  「$w^*=0$ は『$\rho\bmod p$ が分離的、かつ全ての重複度で $p\nmid m_\lambda$』と同値である」の段
* cycle 45 step 2 が書いた `PropCWStarZero.lean` の段 4・段 5 が、
  $w^*=0\iff p\nmid\det G$ と $\det G=\operatorname{disc}(\rho)\prod_\lambda m_\lambda$ の分解まで進めており、
  **残っていたのは $p\nmid\operatorname{disc}(\rho)$ と「$\rho\bmod p$ が分離的」の同値だけである。**

## 測ったこと（掲げた焦点そのもの）

cycle 45 step 2 は「`Algebra.discr` についての宣言はいずれも分離性を仮定として要求する形で、
逆向きが無い」と実測し、**「したがってここは配線ではなく素材の側である」と書いた。**

**測り直した。素材は在った。そう書く**（2026-08-05 実測）。
**探していた場所が違った**——本文の $\operatorname{disc}(\rho)$ は
$\rho$ という**多項式の判別式**であって、基底のトレース形式の判別式（`Algebra.discr`）ではない。
多項式の側には mathlib に一式が在る。

| 要る事柄 | mathlib | 場所 |
|---|---|---|
| 多項式の判別式 | `Polynomial.discr` | `RingTheory/Polynomial/Resultant/Basic.lean` 930 行 |
| 判別式と終結式の関係 | `Polynomial.resultant_deriv` | 同 973 行 |
| 終結式が単元 $\iff$ 互いに素（モニック） | `Polynomial.isUnit_resultant_iff_isCoprime` | 同 885 行 |
| 分離的の定義（微分と互いに素） | `Polynomial.Separable` | `FieldTheory/Separable.lean` 49 行 |
| 終結式が環準同型と交換する | `Polynomial.resultant_map_map` | 同 140 行 |

**これで「書けない理由」の記録が誤りだった件は 13 件目になる。形は cycle 40・41 と同じである**——
引いた語（`Algebra.discr`）で見えるものは正しく見えていたが、
**要るものはその語では引けない場所に在った。**

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。扱うのは $\mathbb{Z}[x]$ と $\mathbb{F}_p[x]$ の多項式、
その終結式・判別式（どちらも係数の多項式＝整数）だけである。
判定は $p\mid\operatorname{disc}(\rho)$ という整数の整除ひとつで、決定可能である。

## 書いたこと（3 段）

1. **体の上で「分離的 $\iff$ 判別式が $0$ でない」**（`separable_iff_discr_ne_zero`）。
   モニックで次数が正なら成り立つ。芯は 3 つで、分離的の定義（微分と互いに素）、
   モニックなら終結式が単元であることと互いに素が同値であること、
   そして終結式と判別式の関係である。**次数を $\deg\rho-1$ へ揃える段が要る**——
   微分の次数は体によって落ちうるので、揃えるのに
   「モニックなら次数を上げても終結式は変わらない」（`resultant_add_right_deg` で
   先頭係数が $1$）を使う。
2. **判別式が還元と交換すること**（`discr_map_of_monic`）。
   $\rho$ がモニックなら $\operatorname{disc}(\bar\rho)=\overline{\operatorname{disc}(\rho)}$。
   終結式が環準同型と交換することから出る（符号と先頭係数はどちらも $\pm1$ なので消える）。
3. **本文の同値**（`separable_map_iff_not_dvd_discr`）。
   $\rho\bmod p$ が分離的 $\iff p\nmid\operatorname{disc}(\rho)$。

## 形式化しなかったもの

* **本文の $\operatorname{disc}(\rho)$ が `Polynomial.discr` であること。**
  **書いてみて、外側に段が 1 つ現れた。そう書く**——本文の
  $\det G=\operatorname{disc}(\rho)\prod_\lambda m_\lambda$ の $\operatorname{disc}(\rho)$ は
  Lean 側では冪基底のトレース形式の Gram 行列式（`Algebra.discr`）として入っており
  （`WStarGramDiscriminant.lean`）、本 file が扱ったのは多項式の判別式（`Polynomial.discr`）である。
  **2 つが等しいことは mathlib に無い**（2026-08-05 実測。`Polynomial.discr` を参照している file は
  Sylvester 行列式の定義元と Weierstrass 曲線の 2 本だけで、`Algebra.discr` と結ぶ宣言は無い。
  `Algebra.discr_powerBasis_eq_norm` は在るが分離的な体拡大を要求するので、
  $\rho\bmod p$ が分離的でない側には当たらない）。
  **したがって 命題 C′ はまだ完了しない。残りは 2 つの判別式の同定 1 件である。**
-/
import Mathlib
import IntegrableLattice.PropCWStarZero

namespace IntegrableLattice
namespace PropCDiscSeparable

open Polynomial

/-! ## 1. 体の上で「分離的 $\iff$ 判別式が $0$ でない」 -/

section Field

variable {K : Type*} [Field K]

/-- 微分の次数を $\deg f-1$ へ揃えても、モニックなら終結式は変わらない。 -/
theorem resultant_deriv_eq_resultant {f : K[X]} (hmonic : f.Monic) :
    resultant f (derivative f) f.natDegree (f.natDegree - 1)
      = resultant f (derivative f) := by
  obtain ⟨k, hk⟩ : ∃ k, f.natDegree - 1 = (derivative f).natDegree + k :=
    ⟨f.natDegree - 1 - (derivative f).natDegree,
      (Nat.add_sub_cancel' (natDegree_derivative_le f)).symm⟩
  rw [hk, resultant_add_right_deg _ _ _ _ _ le_rfl, hmonic.coeff_natDegree, one_pow, one_mul]

/-- **体の上のモニックな多項式について、分離的であることと判別式が $0$ でないことは同値である。**

mathlib は分離性を仮定として要求する形しか持っていない（cycle 45 step 2 の実測）。
**逆向きは多項式の判別式の側の道具で書ける。** -/
theorem separable_iff_discr_ne_zero {f : K[X]} (hmonic : f.Monic) (hdeg : 0 < f.natDegree) :
    f.Separable ↔ f.discr ≠ 0 := by
  have hdeg' : 0 < f.degree := natDegree_pos_iff_degree_pos.mp hdeg
  have hres : resultant f (derivative f)
      = (-1) ^ (f.natDegree * (f.natDegree - 1) / 2) * f.leadingCoeff * f.discr := by
    rw [← resultant_deriv_eq_resultant hmonic, resultant_deriv hdeg']
  constructor
  · intro hsep hzero
    have := (isUnit_resultant_iff_isCoprime (g := derivative f) hmonic).mpr hsep
    rw [hres, hzero, mul_zero] at this
    exact this.ne_zero rfl
  · intro hne
    refine (isUnit_resultant_iff_isCoprime (g := derivative f) hmonic).mp ?_
    rw [hres, hmonic.leadingCoeff, mul_one]
    exact (((isUnit_one (M := K)).neg).pow _).mul (isUnit_iff_ne_zero.mpr hne)

end Field

/-! ## 2. 判別式は還元と交換する -/

section Map

variable {R S : Type*} [CommRing R] [CommRing S] [Nontrivial S]

/-- **モニックな多項式の判別式は環準同型と交換する。** -/
theorem discr_map_of_monic {f : R[X]} (hmonic : f.Monic) (hdeg : 0 < f.natDegree)
    (φ : R →+* S) : (f.map φ).discr = φ f.discr := by
  have hmonic' : (f.map φ).Monic := hmonic.map φ
  have hdegmap : (f.map φ).natDegree = f.natDegree := hmonic.natDegree_map φ
  have hdeg' : 0 < f.degree := natDegree_pos_iff_degree_pos.mp hdeg
  have hdegmap' : 0 < (f.map φ).degree :=
    natDegree_pos_iff_degree_pos.mp (by rw [hdegmap]; exact hdeg)
  set e := f.natDegree * (f.natDegree - 1) / 2 with he
  -- 終結式の側で写す（次数は $\deg f$ と $\deg f-1$ に固定する）
  have hmapres : resultant (f.map φ) (derivative (f.map φ)) f.natDegree (f.natDegree - 1)
      = φ (resultant f (derivative f) f.natDegree (f.natDegree - 1)) := by
    rw [derivative_map, resultant_map_map]
  have hL : resultant (f.map φ) (derivative (f.map φ)) f.natDegree (f.natDegree - 1)
      = (-1 : S) ^ e * (f.map φ).discr := by
    have h := resultant_deriv (f := f.map φ) hdegmap'
    rw [hdegmap, hmonic'.leadingCoeff, mul_one] at h
    exact h
  have hR : φ (resultant f (derivative f) f.natDegree (f.natDegree - 1))
      = (-1 : S) ^ e * φ f.discr := by
    rw [resultant_deriv hdeg', hmonic.leadingCoeff, mul_one, map_mul, map_pow, map_neg, map_one]
  have hkey : (-1 : S) ^ e * (f.map φ).discr = (-1 : S) ^ e * φ f.discr := by
    rw [← hL, hmapres, hR]
  -- 符号は $\pm1$ なので、もう一度掛ければ落ちる（$S$ の非自明性を割り算に使わない形にする）
  have hsq : ((-1 : S) ^ e) * ((-1 : S) ^ e) = 1 := by
    rw [← mul_pow]; simp
  calc (f.map φ).discr = ((-1 : S) ^ e * (-1 : S) ^ e) * (f.map φ).discr := by rw [hsq, one_mul]
    _ = (-1 : S) ^ e * ((-1 : S) ^ e * (f.map φ).discr) := by ring
    _ = (-1 : S) ^ e * ((-1 : S) ^ e * φ f.discr) := by rw [hkey]
    _ = ((-1 : S) ^ e * (-1 : S) ^ e) * φ f.discr := by ring
    _ = φ f.discr := by rw [hsq, one_mul]

end Map

/-! ## 3. 本文の同値 -/

section Main

/-- **本文の同値**: $\rho\bmod p$ が分離的であることと $p\nmid\operatorname{disc}(\rho)$ は同値である。

**これが 命題 C′ の残り 1 段である。** -/
theorem separable_map_iff_not_dvd_discr {p : ℕ} [Fact p.Prime] {ρ : ℤ[X]}
    (hmonic : ρ.Monic) (hdeg : 0 < ρ.natDegree) :
    (ρ.map (Int.castRingHom (ZMod p))).Separable ↔ ¬ ((p : ℤ) ∣ ρ.discr) := by
  have hmonic' : (ρ.map (Int.castRingHom (ZMod p))).Monic := hmonic.map _
  have hdegmap : (ρ.map (Int.castRingHom (ZMod p))).natDegree = ρ.natDegree :=
    hmonic.natDegree_map _
  rw [separable_iff_discr_ne_zero hmonic' (by rw [hdegmap]; exact hdeg),
    discr_map_of_monic hmonic hdeg]
  constructor
  · intro hne hdvd
    exact hne (by simpa using (ZMod.intCast_zmod_eq_zero_iff_dvd ρ.discr p).mpr hdvd)
  · intro hdvd hzero
    exact hdvd ((ZMod.intCast_zmod_eq_zero_iff_dvd ρ.discr p).mp (by simpa using hzero))

end Main

end PropCDiscSeparable
end IntegrableLattice
