/-
# 双対命題 D の $p$ 素点側（有限 $L$ の段）

対応する人手証明: 本文 `structured-latex/content/005_duality.ts` の
`paper_051_theorem_duality`（双対命題 D）のうち **(p 素点, 有限 L)** の段。

## この段が主張していること

> 任意の素数 $p$ と任意の $L$ について $v_p(a^{\mathrm{red}}_L)\in\mathbb{Z}_{\ge0}$ は
> $\mathbb{Z}$ 上の有限手続きで計算できる。さらに $L=p^n$ の塔では非自明性が完全に判定できる。

ここで $a^{\mathrm{red}}_L$ は本文 `002_setup.ts` の `paper_021_definition_curve` が定める
簡約周期点数、すなわち $1$ の $L$ 乗根のうち $P$ の零点でないものだけをわたる積である。

## 命題 D の 3 段のうち、なぜこの段だけを切り出せるのか

- **(∞ 素点)** は $\frac{1}{L^d}\log|a^{\mathrm{red}}_L|\to\log m(P)$ であり、絶対値・実対数・
  $L\to\infty$ の極限を使う。$\mathbb{R}$ に依る。しかも本論文はこれを証明せず外部定理を引用している。
- **(p 素点, 塔の漸近)** は $\mathbb{Q}$ の中で閉じるが、Monsky の定理と Cuoco–Monsky の定理の
  適用であって本論文は証明しない。
- **(p 素点, 有限 L)** だけが、$\mathbb{Z}$ の中で閉じ、かつ本論文が自分で証明している。

したがって切り出せるのはこの段である。

## このファイルが埋めるもの（$d=1$）

**簡約周期点数 $a^{\mathrm{red}}_L$ は、これまで Lean のどこにも定義されていなかった。**
既存の `PropV.lean` と `PeriodicPointResultant.lean` はいずれも簡約しない $a_L$ だけを扱う。
本ファイルは $d=1$ について次を書く。

| 人手証明の内容 | Lean |
| --- | --- |
| $a^{\mathrm{red}}_L=\prod_{\zeta^L=1,\ P(\zeta)\neq0}P(\zeta)$ | `aRedOne` |
| $a^{\mathrm{red}}_L\neq0$（$v_p$ が値をもつ前提） | `aRedOne_ne_zero` |
| 簡約因子 $h=\prod_{\zeta\ \text{good}}(X-\zeta)$ は $X^L-1$ の monic な因子 | `redFactor_monic` / `redFactor_dvd` |
| $a^{\mathrm{red}}_L=\mathrm{Res}(h,P)$（終結式による有限計算の形） | `resultant_redFactor_eq_aRedOne` |
| $P$ が $1$ の冪根で零点をもたなければ $a^{\mathrm{red}}_L=a_L$ | `aRedOne_eq_resultant_of_no_root` |
| $h=(X^L-1)/\gcd(X^L-1,P)$ は monic で $\mathbb{Z}[X]$ に属する | `exists_int_redFactorQ` |
| その $h$ の根がちょうど「良い根」であること | `map_redFactorQ_eq_redFactor` |
| $a^{\mathrm{red}}_L$ は $0$ でない整数（ゆえに $v_p\in\mathbb{Z}_{\ge0}$ が意味をもつ） | `exists_int_aRedOne` |

## 形式化していないもの（正直に書く）

- **「有限手続きで計算できる」という計算可能性の言明そのもの。** これは命題ではないので
  Lean の定理にしていない（命題 A の (4) と同じ扱い。`lean/README.md` の表を参照）。
  形式化したのは、その言明が意味をもつために必要な**命題の側**——
  $a^{\mathrm{red}}_L$ が $0$ でない整数であること、および
  $\mathbb{Z}$ 係数の終結式ひとつで書けることである。
- **$d\ge2$。** 本文の $a^{\mathrm{red}}_L$ は $d$ 変数の主張である。ここで書いたのは $d=1$ に限る。
- **$L=p^n$ の塔の非自明性の判定**は `PropV.lean` が $d=1,2$ で既に持っている（$a_L$ について）。
  本ファイルはそれを重複して書かない。

## 帰属について

$1$ の $L$ 乗根は $\overline{\mathbb{Q}}$ の元である。本ファイルは根が住む体 $K$ を仮定として
受け取るだけで、$\mathbb{R}$ も $\mathbb{C}$ も型として一度も現れない。
簡約因子の整数性を論じる節だけが $\mathbb{Q}$ を経由するが、これは $\mathbb{Z}$ の商体であって
非可算側への脱出ではない。
-/
import Mathlib
import IntegrableLattice.PeriodicPointResultant

namespace IntegrableLattice

open Polynomial

/-! ## 1. 簡約周期点数 $a^{\mathrm{red}}_L$（$d=1$）

根が住む体 $K$ の上で、本文の定義をそのまま書く。 -/

section ReducedOneVariable

variable {K : Type*} [Field K] [DecidableEq K]

/-- $X^L-1$ の根のうち $Q$ の零点でないもの（本文の積の添字集合）。 -/
noncomputable def goodRoots (L : ℕ) (Q : K[X]) : Multiset K :=
  ((X : K[X]) ^ L - 1).roots.filter fun ζ => Q.eval ζ ≠ 0

theorem mem_goodRoots {L : ℕ} {Q : K[X]} {ζ : K} :
    ζ ∈ goodRoots L Q ↔ ζ ∈ ((X : K[X]) ^ L - 1).roots ∧ Q.eval ζ ≠ 0 :=
  Multiset.mem_filter

/-- **本文の簡約周期点数** $a^{\mathrm{red}}_L=\prod_{\zeta^L=1,\ P(\zeta)\neq0}P(\zeta)$（$d=1$）。 -/
noncomputable def aRedOne (L : ℕ) (Q : K[X]) : K := ((goodRoots L Q).map Q.eval).prod

/-- 簡約因子 $h:=\prod_{\zeta\ \text{good}}(X-\zeta)$。 -/
noncomputable def redFactor (L : ℕ) (Q : K[X]) : K[X] :=
  ((goodRoots L Q).map fun ζ => X - C ζ).prod

/-- **$a^{\mathrm{red}}_L\neq0$**。本文が $v_p(a^{\mathrm{red}}_L)\in\mathbb{Z}_{\ge0}$ と書けるのは
この一点による（簡約しない $a_L$ は $0$ になりうる）。積の各因子が $0$ でないことしか使わない。 -/
theorem aRedOne_ne_zero (L : ℕ) (Q : K[X]) : aRedOne L Q ≠ 0 := by
  refine Multiset.prod_ne_zero ?_
  intro h0
  obtain ⟨ζ, hζ, hev⟩ := Multiset.mem_map.mp h0
  exact (mem_goodRoots.mp hζ).2 hev

theorem redFactor_monic (L : ℕ) (Q : K[X]) : (redFactor L Q).Monic :=
  monic_multiset_prod_of_monic _ _ fun ζ _ => monic_X_sub_C ζ

theorem redFactor_splits (L : ℕ) (Q : K[X]) : (redFactor L Q).Splits := by
  refine Splits.multisetProd ?_
  intro f hf
  obtain ⟨ζ, _, rfl⟩ := Multiset.mem_map.mp hf
  exact Splits.X_sub_C ζ

theorem roots_redFactor (L : ℕ) (Q : K[X]) : (redFactor L Q).roots = goodRoots L Q :=
  roots_multiset_prod_X_sub_C _

/-- **簡約因子は $X^L-1$ の因子である。** 使うのは「良い根の多重集合は根の多重集合の部分である」
ことだけで、分離性は要らない。 -/
theorem redFactor_dvd (L : ℕ) (Q : K[X]) : redFactor L Q ∣ (X : K[X]) ^ L - 1 :=
  (Multiset.prod_dvd_prod_of_le (Multiset.map_le_map (Multiset.filter_le _ _))).trans
    (prod_multiset_X_sub_C_dvd _)

/-- **$a^{\mathrm{red}}_L$ は終結式ひとつで書ける**: $a^{\mathrm{red}}_L=\mathrm{Res}(h,Q)$。

人手証明が $a_L$ について使っている論法（$\mathrm{Res}(f,g)=\mathrm{lc}(f)^{\deg g}\prod_{f(\alpha)=0}g(\alpha)$
で $f$ が monic）を、$X^L-1$ ではなく簡約因子 $h$ に適用しただけである。 -/
theorem resultant_redFactor_eq_aRedOne (L N : ℕ) (Q : K[X]) (hN : Q.natDegree ≤ N) :
    (redFactor L Q).resultant Q (redFactor L Q).natDegree N = aRedOne L Q := by
  rw [resultant_eq_prod_eval _ _ N hN (redFactor_splits L Q),
    (redFactor_monic L Q).leadingCoeff, one_pow, one_mul, roots_redFactor]
  rfl

/-- **本文の「$P$ が $1$ の冪根の組で零点をもたなければ両者は一致する」**（$d=1$）。
右辺は `PeriodicPointResultant.lean` が $a_L$ として書いた終結式そのものである。 -/
theorem aRedOne_eq_resultant_of_no_root {L : ℕ} (hL : 0 < L) (Q : K[X]) (M : ℕ)
    (hM : Q.natDegree ≤ M) (hsplits : ((X : K[X]) ^ L - 1).Splits)
    (h : ∀ ζ ∈ ((X : K[X]) ^ L - 1).roots, Q.eval ζ ≠ 0) :
    aRedOne L Q = ((X : K[X]) ^ L - 1).resultant Q L M := by
  rw [resultant_X_pow_sub_one_eq_prod_eval hL Q M hM hsplits]
  unfold aRedOne goodRoots
  rw [Multiset.filter_eq_self.mpr h]

end ReducedOneVariable

/-! ## 2. 簡約因子は $\mathbb{Z}$ の中で作れる

本文が「$v_p(a^{\mathrm{red}}_L)\in\mathbb{Z}_{\ge0}$ は $\mathbb{Z}$ 上の有限手続きで計算できる」と
書くとき、暗黙に $a^{\mathrm{red}}_L\in\mathbb{Z}$ を使っている（本文 `paper_021_definition_curve` は
これを「Galois 不変な代数的整数だから」と述べる）。ここでは Galois 理論を経由せず、
$\mathbb{Q}$ 上の最大公約子ひとつで同じ結論を出す道を書く。

$$h:=\frac{X^L-1}{\gcd(X^L-1,\ P)}$$

は $\mathbb{Q}[X]$ で monic であり、monic な $X^L-1\in\mathbb{Z}[X]$ を割るので
$\mathbb{Z}[X]$ に属する（Gauss）。そして $h$ の根はちょうど本文の「良い根」である。
$\gcd$ も終結式も $\mathbb{Z}$ 係数の有限計算なので、これが本文の言う有限手続きの中身にあたる。 -/

section IntegerDescent

/-- $\mathbb{Q}$ 上の最大公約子 $\gcd(X^L-1,\ P)$。 -/
noncomputable def gcdQ (L : ℕ) (P : ℤ[X]) : ℚ[X] :=
  EuclideanDomain.gcd ((X : ℚ[X]) ^ L - 1) (P.map (Int.castRingHom ℚ))

/-- それを monic にしたもの。 -/
noncomputable def gcdMonicQ (L : ℕ) (P : ℤ[X]) : ℚ[X] :=
  gcdQ L P * C (gcdQ L P).leadingCoeff⁻¹

/-- 簡約因子の $\mathbb{Q}$ 上の実体 $h=(X^L-1)/\gcd(X^L-1,\ P)$。 -/
noncomputable def redFactorQ (L : ℕ) (P : ℤ[X]) : ℚ[X] :=
  ((X : ℚ[X]) ^ L - 1) /ₘ gcdMonicQ L P

theorem monic_X_pow_sub_one {R : Type*} [CommRing R] [Nontrivial R] {L : ℕ} (hL : 0 < L) :
    ((X : R[X]) ^ L - 1).Monic := by
  have h : (X : R[X]) ^ L - 1 = (X : R[X]) ^ L - C 1 := by simp
  rw [h]
  exact monic_X_pow_sub_C 1 hL.ne'

theorem gcdQ_ne_zero {L : ℕ} (hL : 0 < L) (P : ℤ[X]) : gcdQ L P ≠ 0 := by
  intro h
  exact (monic_X_pow_sub_one (R := ℚ) hL).ne_zero (EuclideanDomain.gcd_eq_zero_iff.mp h).1

theorem gcdMonicQ_monic {L : ℕ} (hL : 0 < L) (P : ℤ[X]) : (gcdMonicQ L P).Monic :=
  monic_mul_leadingCoeff_inv (gcdQ_ne_zero hL P)

theorem gcdMonicQ_dvd {L : ℕ} (hL : 0 < L) (P : ℤ[X]) :
    gcdMonicQ L P ∣ (X : ℚ[X]) ^ L - 1 := by
  obtain ⟨q, hq⟩ := EuclideanDomain.gcd_dvd_left ((X : ℚ[X]) ^ L - 1)
    (P.map (Int.castRingHom ℚ))
  refine ⟨C (gcdQ L P).leadingCoeff * q, ?_⟩
  have hlc : (gcdQ L P).leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr (gcdQ_ne_zero hL P)
  rw [gcdMonicQ]
  calc (X : ℚ[X]) ^ L - 1 = gcdQ L P * q := hq
    _ = gcdQ L P * C (gcdQ L P).leadingCoeff⁻¹ * (C (gcdQ L P).leadingCoeff * q) := by
        rw [mul_assoc, ← mul_assoc (C (gcdQ L P).leadingCoeff⁻¹), ← C_mul,
          inv_mul_cancel₀ hlc, C_1, one_mul]

/-- $X^L-1=\gcd\cdot h$（$\mathbb{Q}$ 上）。 -/
theorem X_pow_sub_one_eq_gcdMonicQ_mul {L : ℕ} (hL : 0 < L) (P : ℤ[X]) :
    (X : ℚ[X]) ^ L - 1 = gcdMonicQ L P * redFactorQ L P := by
  have h := modByMonic_add_div ((X : ℚ[X]) ^ L - 1) (gcdMonicQ L P)
  rw [(modByMonic_eq_zero_iff_dvd (gcdMonicQ_monic hL P)).mpr (gcdMonicQ_dvd hL P),
    zero_add] at h
  exact h.symm

theorem redFactorQ_monic {L : ℕ} (hL : 0 < L) (P : ℤ[X]) : (redFactorQ L P).Monic :=
  Monic.of_mul_monic_left (gcdMonicQ_monic hL P)
    (by rw [← X_pow_sub_one_eq_gcdMonicQ_mul hL P]; exact monic_X_pow_sub_one hL)

theorem redFactorQ_dvd {L : ℕ} (hL : 0 < L) (P : ℤ[X]) :
    redFactorQ L P ∣ (X : ℚ[X]) ^ L - 1 :=
  ⟨gcdMonicQ L P, by rw [mul_comm, ← X_pow_sub_one_eq_gcdMonicQ_mul hL P]⟩

/-- **Gauss の段**: monic な $X^L-1\in\mathbb{Z}[X]$ の monic な因子は $\mathbb{Z}[X]$ に属する。
したがって簡約因子 $h$ は整数係数であり、$\gcd$ の計算は $\mathbb{Z}$ の中で閉じる。 -/
theorem exists_int_redFactorQ {L : ℕ} (hL : 0 < L) (P : ℤ[X]) :
    ∃ h : ℤ[X], h.Monic ∧ h ∣ (X : ℤ[X]) ^ L - 1 ∧
      h.map (Int.castRingHom ℚ) = redFactorQ L P := by
  have hmapF : ((X : ℤ[X]) ^ L - 1).map (algebraMap ℤ ℚ) = (X : ℚ[X]) ^ L - 1 := by simp
  have hdvd : redFactorQ L P ∣ ((X : ℤ[X]) ^ L - 1).map (algebraMap ℤ ℚ) := by
    rw [hmapF]; exact redFactorQ_dvd hL P
  obtain ⟨h, hh⟩ := IsIntegrallyClosed.eq_map_mul_C_of_dvd (R := ℤ) ℚ
    (monic_X_pow_sub_one (R := ℤ) hL) hdvd
  rw [(redFactorQ_monic hL P).leadingCoeff, C_1, mul_one] at hh
  have hinj : Function.Injective (algebraMap ℤ ℚ) := fun a b hab => by exact_mod_cast hab
  have hmonic : h.Monic := by
    have hlc := congrArg Polynomial.leadingCoeff hh
    rw [(redFactorQ_monic hL P).leadingCoeff, leadingCoeff_map_of_injective hinj] at hlc
    exact (map_eq_one_iff (algebraMap ℤ ℚ) hinj).mp hlc
  refine ⟨h, hmonic, ?_, hh⟩
  refine (monic_X_pow_sub_one (R := ℤ) hL).dvd_of_fraction_map_dvd_fraction_map
    (K := ℚ) hmonic ?_
  rw [hh, hmapF]
  exact redFactorQ_dvd hL P

end IntegerDescent

/-! ## 3. $\mathbb{Q}$ 上の簡約因子と、根の側の簡約因子が一致すること

ここまでで $h\in\mathbb{Z}[X]$ が取れた。残るのは、その $h$ の根がちょうど本文の「良い根」——
$1$ の $L$ 乗根のうち $P$ の零点でないもの——であることである。使うのは
$X^L-1$ が分離的であること（重根を持たないこと）と、$\gcd$ の根が共通根であることの 2 点だけである。 -/

section Identify

variable {K : Type*} [Field K] [DecidableEq K]

/-- $\gcd$ の像の根は、$X^L-1$ と $P$ の共通根である。 -/
theorem isRoot_gcdMonicQ_map_iff {L : ℕ} (hL : 0 < L) (P : ℤ[X]) (φ : ℚ →+* K) (ζ : K) :
    ((gcdMonicQ L P).map φ).IsRoot ζ ↔
      ((X : K[X]) ^ L - 1).IsRoot ζ ∧ ((P.map (Int.castRingHom ℚ)).map φ).IsRoot ζ := by
  have hlc : (gcdQ L P).leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr (gcdQ_ne_zero hL P)
  have hgcdmap : (gcdQ L P).map φ
      = EuclideanDomain.gcd (((X : ℚ[X]) ^ L - 1).map φ)
          ((P.map (Int.castRingHom ℚ)).map φ) := (Polynomial.gcd_map φ).symm
  have hFK : ((X : ℚ[X]) ^ L - 1).map φ = (X : K[X]) ^ L - 1 := by simp
  constructor
  · intro hz
    have : ((gcdQ L P).map φ).IsRoot ζ := by
      have hz' : ((gcdQ L P).map φ).eval ζ * φ (gcdQ L P).leadingCoeff⁻¹ = 0 := by
        simpa [gcdMonicQ, Polynomial.map_mul, IsRoot] using hz
      rcases mul_eq_zero.mp hz' with h | h
      · exact h
      · exact absurd h (by simpa using (map_ne_zero_iff φ φ.injective).mpr (inv_ne_zero hlc))
    rw [hgcdmap, hFK] at this
    exact isRoot_gcd_iff_isRoot_left_right.mp this
  · intro hz
    have : (EuclideanDomain.gcd ((X : K[X]) ^ L - 1)
        ((P.map (Int.castRingHom ℚ)).map φ)).IsRoot ζ := isRoot_gcd_iff_isRoot_left_right.mpr hz
    rw [← hFK, ← hgcdmap] at this
    simp [gcdMonicQ, Polynomial.map_mul, IsRoot, this.eq_zero]

/-- **簡約因子の同定**: $\mathbb{Q}$ 上で $\gcd$ を割って作った $h$ の像は、
根の側で定義した簡約因子と一致する。 -/
theorem map_redFactorQ_eq_redFactor {L : ℕ} (hL : 0 < L) (P : ℤ[X]) (φ : ℚ →+* K)
    (hsplits : ((X : K[X]) ^ L - 1).Splits) :
    (redFactorQ L P).map φ = redFactor L ((P.map (Int.castRingHom ℚ)).map φ) := by
  set QK := (P.map (Int.castRingHom ℚ)).map φ with hQK
  set FK : K[X] := (X : K[X]) ^ L - 1 with hFKdef
  have hFKmonic : FK.Monic := monic_X_pow_sub_one hL
  have hgmK : ((gcdMonicQ L P).map φ).Monic := (gcdMonicQ_monic hL P).map φ
  have hhK : ((redFactorQ L P).map φ).Monic := (redFactorQ_monic hL P).map φ
  have hmul : FK = (gcdMonicQ L P).map φ * (redFactorQ L P).map φ := by
    rw [hFKdef, ← Polynomial.map_mul, ← X_pow_sub_one_eq_gcdMonicQ_mul hL P]
    simp
  -- 分離性: $L$ が $K$ で可逆
  have hLK : ((L : ℕ) : K) ≠ 0 := by
    have : φ ((L : ℚ)) = ((L : ℕ) : K) := by simp
    rw [← this]
    exact (map_ne_zero_iff φ φ.injective).mpr (by exact_mod_cast hL.ne')
  have hsep : FK.Separable := by
    have h1 : FK = (X : K[X]) ^ L - C 1 := by rw [hFKdef]; simp
    rw [h1]
    exact separable_X_pow_sub_C 1 hLK one_ne_zero
  have hnodup : FK.roots.Nodup := nodup_roots hsep
  have hrootsadd : FK.roots = ((gcdMonicQ L P).map φ).roots + ((redFactorQ L P).map φ).roots := by
    conv_lhs => rw [hmul]
    exact roots_mul (by rw [← hmul]; exact hFKmonic.ne_zero)
  -- 根の集合が一致する
  have hext : ((redFactorQ L P).map φ).roots = goodRoots L QK := by
    have hle : ((redFactorQ L P).map φ).roots ≤ FK.roots := by
      rw [hrootsadd]; exact Multiset.le_add_left _ _
    have hnodupH : ((redFactorQ L P).map φ).roots.Nodup := Multiset.nodup_of_le hle hnodup
    have hnodupG : (goodRoots L QK).Nodup := Multiset.nodup_of_le (Multiset.filter_le _ _) hnodup
    refine (Multiset.Nodup.ext hnodupH hnodupG).mpr fun ζ => ?_
    constructor
    · intro hζ
      refine mem_goodRoots.mpr ⟨Multiset.mem_of_le hle hζ, ?_⟩
      intro hQ
      -- ζ が gcd 側の根でもあると重根になり、分離性に反する
      have hgz : ζ ∈ ((gcdMonicQ L P).map φ).roots := by
        refine (mem_roots hgmK.ne_zero).mpr ?_
        exact (isRoot_gcdMonicQ_map_iff hL P φ ζ).mpr
          ⟨(mem_roots hFKmonic.ne_zero).mp (Multiset.mem_of_le hle hζ), hQ⟩
      have h2 : 2 ≤ Multiset.count ζ FK.roots := by
        rw [hrootsadd, Multiset.count_add]
        have := Multiset.one_le_count_iff_mem.mpr hgz
        have := Multiset.one_le_count_iff_mem.mpr hζ
        omega
      have := Multiset.nodup_iff_count_le_one.mp hnodup ζ
      omega
    · intro hζ
      obtain ⟨hmem, hQ⟩ := mem_goodRoots.mp hζ
      rw [hrootsadd] at hmem
      rcases Multiset.mem_add.mp hmem with hg | hh
      · exact absurd ((isRoot_gcdMonicQ_map_iff hL P φ ζ).mp
          ((mem_roots hgmK.ne_zero).mp hg)).2 hQ
      · exact hh
  -- monic かつ分解するので、根が決まれば多項式が決まる
  have hsplitH : ((redFactorQ L P).map φ).Splits :=
    Splits.of_dvd hsplits hFKmonic.ne_zero ⟨(gcdMonicQ L P).map φ, by rw [hmul]; ring⟩
  rw [hsplitH.eq_prod_roots_of_monic hhK, hext, redFactor]

/-- **この段の結論**: $a^{\mathrm{red}}_L$ は $\mathbb{Z}$ 係数の終結式ひとつで書ける $0$ でない整数である。
したがって $v_p(a^{\mathrm{red}}_L)\in\mathbb{Z}_{\ge0}$ が意味をもつ。

「有限手続きで計算できる」という言明そのものは命題ではないので定理にしていない。
定理にしたのは、その言明が意味をもつために要る命題の側である。 -/
theorem exists_int_aRedOne {L : ℕ} (hL : 0 < L) (P : ℤ[X]) (φ : ℚ →+* K)
    (hsplits : ((X : K[X]) ^ L - 1).Splits) (N : ℕ) (hN : P.natDegree ≤ N) :
    ∃ h : ℤ[X], h.Monic ∧ h ∣ (X : ℤ[X]) ^ L - 1 ∧
      (φ (((h.resultant P h.natDegree N : ℤ) : ℚ)) =
        aRedOne L ((P.map (Int.castRingHom ℚ)).map φ)) ∧
      h.resultant P h.natDegree N ≠ 0 := by
  obtain ⟨h, hmonic, hdvd, hmap⟩ := exists_int_redFactorQ hL P
  set QK := (P.map (Int.castRingHom ℚ)).map φ with hQK
  set ψ : ℤ →+* K := φ.comp (Int.castRingHom ℚ) with hψ
  have hmapK : h.map ψ = redFactor L QK := by
    rw [hψ, ← Polynomial.map_map, hmap]
    exact map_redFactorQ_eq_redFactor hL P φ hsplits
  have hψinj : Function.Injective ψ := φ.injective.comp Int.cast_injective
  have hdegK : (h.map ψ).natDegree = h.natDegree := natDegree_map_eq_of_injective hψinj h
  have hPK : P.map ψ = QK := by rw [hQK, hψ, ← Polynomial.map_map]
  have hNK : QK.natDegree ≤ N := by rw [← hPK]; exact natDegree_map_le.trans hN
  have hres : (h.map ψ).resultant (P.map ψ) (h.map ψ).natDegree N
      = ψ (h.resultant P h.natDegree N) := by
    rw [hdegK]; exact resultant_map_map h P h.natDegree N ψ
  have hval : ψ (h.resultant P h.natDegree N) = aRedOne L QK := by
    rw [← hres, hPK, hmapK]
    exact resultant_redFactor_eq_aRedOne L N QK hNK
  refine ⟨h, hmonic, hdvd, ?_, ?_⟩
  · rw [← hval, hψ]; simp
  · intro h0
    rw [h0] at hval
    exact aRedOne_ne_zero L QK (by simpa using hval.symm)

end Identify

end IntegrableLattice
