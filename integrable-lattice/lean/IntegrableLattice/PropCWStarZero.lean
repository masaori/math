/-
# 命題 C′ の $w^*=0$ の判定を、行列式の側へ渡す段

対応する人手証明:

* 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の statement の後半——
  $w^*=0$ は「$\rho\bmod p$ が分離的、かつ全ての重複度で $p\nmid m_\lambda$」と同値である。

## この段が塞ぐ穴

`WStarElementaryDivisors.wStarOfCoeffs_eq_zero_iff` が与えるのは
「適合基底の係数がどれも $p$ で割れない」という判定であって、本文の判定ではない。
本文は $w^*$ を Gram 行列 $G$ の最大単因子の $p$ 進付値として定義しており、
$\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda$ を経由して
分離性と重複度の条件へ渡す。

**台帳は cycle 44 から「その道には $\det G$ が単因子の積であること（整数行列の Smith 標準形）が
要り、それは mathlib に無いと実測されている」と書いていた。measure したところ、要らなかった。**
単因子の積という順序づけられた不変量を経由せずに、次の 2 つで直接渡せる。

* $p\nmid\det G$ ならば、余因子行列が $\det G$ 倍の逆を与えるので、
  $G$ の像は $p$ の外で全体を含む（レベル $0$）。
* 逆にレベルが $0$ なら、$p$ と素な $m$ と整数行列 $Y$ で $G\,Y=m\,I$ となるので
  （`TracePeriodWStar.exists_mul_eq_smul_one_of_isPLevel`）、行列式を取って $p\nmid\det G$ が出る。

どちらも整除の鎖にも Smith 標準形にも触れない。**$\mathbb{R}$ へも $\overline{\mathbb{Q}}$ へも出ない**——
係数は $\mathbb{Z}$ のままである。

## 何が入って、何が残るか

入ったのは $w^*=0\iff p\nmid\det G$ と、$\det G$ が積の形に分かれているときの
$p$ 進の条件の分解である。**残るのは $p\nmid\operatorname{disc}(\rho)$ と
「$\rho\bmod p$ が分離的」の同値だけである**（2026-08-05 実測。mathlib の
`Algebra.discr` についての宣言は `discr_not_zero_of_basis` / `discr_isUnit_of_basis` のように
いずれも分離的な体拡大を仮定として要求する形で、逆向き——判別式が $0$ でなければ分離的——を
述べた宣言も、`Algebra.discr` の係数環の取り替えを述べた宣言も無い）。
-/
import Mathlib
import IntegrableLattice.WStarElementaryDivisors
import IntegrableLattice.TracePeriodWStarLift

namespace IntegrableLattice
namespace PropCWStarZero

open Finset Matrix Module

/-! ## 1. 余因子行列の側（$p\nmid\det G$ ならレベルは $0$） -/

/-- $\det G$ 倍したベクトルは、いつでも $G$ の像に入る（余因子行列を当てるだけ）。 -/
theorem det_smul_mem_range {r : ℕ} (G : Matrix (Fin r) (Fin r) ℤ) (x : Fin r → ℤ) :
    G.det • x ∈ LinearMap.range G.mulVecLin := by
  refine ⟨G.adjugate.mulVec x, ?_⟩
  rw [Matrix.mulVecLin_apply, Matrix.mulVec_mulVec, Matrix.mul_adjugate]
  ext i
  simp [Matrix.mulVec, dotProduct, Matrix.one_apply]

/-- **段 1**。$p\nmid\det G$ ならば、$G$ の像は $p$ の外で全体を含む。 -/
theorem isPLevel_zero_of_not_dvd_det {r p : ℕ} (G : Matrix (Fin r) (Fin r) ℤ)
    (hdet : ¬ (p : ℤ) ∣ G.det) : IsPLevel p (LinearMap.range G.mulVecLin) 0 := by
  intro x
  refine ⟨G.det, hdet, ?_⟩
  rw [pow_zero, one_smul]
  exact det_smul_mem_range G x

/-! ## 2. 行列式の側（レベルが $0$ なら $p\nmid\det G$） -/

/-- **段 2**。$G$ の像のレベルが $0$ ならば $p\nmid\det G$。

心臓部は `TracePeriodWStar.exists_mul_eq_smul_one_of_isPLevel` で、
そこから行列式を取るだけである。 -/
theorem not_dvd_det_of_isPLevel_zero {r p : ℕ} (hp : p.Prime) (G : Matrix (Fin r) (Fin r) ℤ)
    (hlevel : IsPLevel p (LinearMap.range G.mulVecLin) 0) : ¬ (p : ℤ) ∣ G.det := by
  obtain ⟨Y, m, hm, hGY⟩ := TracePeriodWStar.exists_mul_eq_smul_one_of_isPLevel hp G hlevel
  have hdet : G.det * Y.det = m ^ r := by
    have := congrArg Matrix.det hGY
    rwa [Matrix.det_mul, Matrix.smul_eq_diagonal_mul, Matrix.det_mul, Matrix.det_diagonal,
      Matrix.det_one, mul_one, Finset.prod_const, Finset.card_univ, Fintype.card_fin,
      pow_zero, mul_one] at this
  intro hdvd
  refine hm ?_
  have hpp : Prime (p : ℤ) := Nat.prime_iff_prime_int.mp hp
  exact hpp.dvd_of_dvd_pow (n := r) (hdet ▸ Dvd.dvd.mul_right hdvd Y.det)

/-- **段 1・段 2 を合わせた形**。$G$ の像の $p$ の外でのレベルが $0$ であることと、
$p$ が $\det G$ を割らないことは同値である。 -/
theorem isPLevel_zero_iff_not_dvd_det {r p : ℕ} (hp : p.Prime) (G : Matrix (Fin r) (Fin r) ℤ) :
    IsPLevel p (LinearMap.range G.mulVecLin) 0 ↔ ¬ (p : ℤ) ∣ G.det :=
  ⟨not_dvd_det_of_isPLevel_zero hp G, isPLevel_zero_of_not_dvd_det G⟩

/-! ## 3. $w^*=0$ をレベル $0$ へ移す -/

section WStar

variable {ι M : Type*} [Fintype ι] [AddCommGroup M]

/-- **段 3**。適合基底が与えられているとき、$w^*=0$ はレベルが $0$ であることと同値である。

`isLeast_isPLevel` が最小元であることを言っているので、
最小元が $0$ であることと $0$ が集合に属することが同値になる、というだけである。 -/
theorem wStar_eq_zero_iff_isPLevel_zero {p : ℕ} (hp : p.Prime) (bM : Basis ι ℤ M)
    (N : Submodule ℤ M) (bN : Basis ι ℤ N) (a : ι → ℤ)
    (hb : ∀ i, (bN i : M) = a i • bM i) (ha : ∀ i, a i ≠ 0) :
    wStarOfCoeffs p a = 0 ↔ IsPLevel p N 0 := by
  have hleast := isLeast_isPLevel bM N bN a hp hb ha
  constructor
  · intro h
    have := hleast.1
    rwa [h] at this
  · intro h
    exact Nat.le_zero.mp (hleast.2 h)

end WStar

/-- **本文の判定の骨格**。適合基底が Gram 行列 $G$ の像を与えているとき、
$w^*=0$ は $p\nmid\det G$ と同値である。

**本文が「最大単因子の $p$ 進付値」として定義している $w^*$ が消えることを、
単因子を 1 度も経由せずに行列式ひとつの条件へ移している。** -/
theorem wStar_eq_zero_iff_not_dvd_det {r p : ℕ} (hp : p.Prime)
    (G : Matrix (Fin r) (Fin r) ℤ)
    (bM : Basis (Fin r) ℤ (Fin r → ℤ)) (bN : Basis (Fin r) ℤ (LinearMap.range G.mulVecLin))
    (a : Fin r → ℤ) (hb : ∀ i, (bN i : Fin r → ℤ) = a i • bM i) (ha : ∀ i, a i ≠ 0) :
    wStarOfCoeffs p a = 0 ↔ ¬ (p : ℤ) ∣ G.det :=
  (wStar_eq_zero_iff_isPLevel_zero hp bM _ bN a hb ha).trans (isPLevel_zero_iff_not_dvd_det hp G)

/-! ## 4. 積の形をした行列式で、$p$ 進の条件を分ける -/

/-- **段 4**。本文の $\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda$ の形に対して、
$p\nmid\det G$ は「$p\nmid\operatorname{disc}(\rho)$ かつ全ての $\lambda$ で $p\nmid m_\lambda$」と同値。

素数が積を割ることと、どれかの因子を割ることが同値であることだけを使う。 -/
theorem not_dvd_mul_prod_iff {ι : Type*} [Fintype ι] {p : ℕ} (hp : p.Prime) (d : ℤ) (m : ι → ℤ) :
    ¬ (p : ℤ) ∣ d * ∏ i, m i ↔ (¬ (p : ℤ) ∣ d) ∧ ∀ i, ¬ (p : ℤ) ∣ m i := by
  classical
  have hpp : Prime (p : ℤ) := Nat.prime_iff_prime_int.mp hp
  constructor
  · intro h
    refine ⟨fun hd => h (hd.mul_right _), fun i hi => h ?_⟩
    exact Dvd.dvd.mul_left (hi.trans (Finset.dvd_prod_of_mem m (mem_univ i))) d
  · rintro ⟨hd, hm⟩ h
    rcases hpp.dvd_mul.mp h with h | h
    · exact hd h
    · obtain ⟨i, -, hi⟩ := (Prime.dvd_finsetProd_iff hpp m).mp h
      exact hm i hi

/-- **本文の後半そのものの骨格**。$\det G$ が本文の形に分かれているとき、
$w^*=0$ は「$p\nmid\operatorname{disc}(\rho)$ かつ全ての重複度で $p\nmid m_\lambda$」と同値。

**残っているのは $p\nmid\operatorname{disc}(\rho)$ と「$\rho\bmod p$ が分離的」の同値だけである。** -/
theorem wStar_eq_zero_iff_of_det_factorization {r p : ℕ} {ι : Type*} [Fintype ι] (hp : p.Prime)
    (G : Matrix (Fin r) (Fin r) ℤ) (d : ℤ) (m : ι → ℤ) (hfac : G.det = d * ∏ i, m i)
    (bM : Basis (Fin r) ℤ (Fin r → ℤ)) (bN : Basis (Fin r) ℤ (LinearMap.range G.mulVecLin))
    (a : Fin r → ℤ) (hb : ∀ i, (bN i : Fin r → ℤ) = a i • bM i) (ha : ∀ i, a i ≠ 0) :
    wStarOfCoeffs p a = 0 ↔ (¬ (p : ℤ) ∣ d) ∧ ∀ i, ¬ (p : ℤ) ∣ m i := by
  rw [wStar_eq_zero_iff_not_dvd_det hp G bM bN a hb ha, hfac, not_dvd_mul_prod_iff hp]

end PropCWStarZero
end IntegrableLattice
