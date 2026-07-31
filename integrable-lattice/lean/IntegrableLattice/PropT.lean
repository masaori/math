/-
# 命題 T（トーラス全域木数の 2 進付値 $v_2(\tau(L))=2(L-1)$、$L$ 奇）

対応する人手証明:
`integrable-lattice/structured-latex/content/006_propositions_TVW.ts` の
`paper_062_theorem_T`（ラベル `paper_prop_T`）、
根拠 report は `outputs/reports/cycle13_T1_observation_T_settlement.md`。

## 形式化できた段と、できなかった段（先に明示する）

人手証明は 5 段からなる。

1. **（代数）指標による対角化と matrix-tree 定理**で $\tau(L)=\prod_{j=1}^{L-1}(r_j^L+r_j^{-L}-2)$。
2. **（代数）$k$ についての部分積の閉形式** $\prod_{k=0}^{L-1}(A_j-\zeta^k-\zeta^{-k})=r_j^L+r_j^{-L}-2$
   （$A_j=r_j+r_j^{-1}$）。
3. **（数論）$L$ 奇なら 2 は $\mathbb{Q}(\zeta_L)$ で不分岐**、$w^2-A_jw+1$ が $\bmod\,P$ で相異なる 2 根に
   分解し、Hensel で $r_j\equiv\zeta^j$ が取れる。
4. **（数論）Newton 多角形**により $v(m_j)=1$（$r_j=\zeta^j(1+m_j)$）、二項展開で $v(r_j^L-1)=1$。
5. **（算術）総和** $v_2(\tau(L))=\sum_{j=1}^{L-1}2\,v(r_j^L-1)=2(L-1)$。

**本ファイルが Lean で閉じたのは 2・4 の組合せ核・5、および「$L$ 奇」が効く初等的な 2 箇所である。**
1 と 3 は形式化していない。理由（一次情報つき）:

* **段 1: mathlib に Kirchhoff の matrix-tree 定理（全域木の個数の公式）が無い。**
  `scripts/mathlib-gap-survey.sh` の cycle 18 実行（`logs/mathlib-gap-survey-cycle18.log`）で
  `matrixTree` / `kirchhoff`（内容・ファイル名とも）が 0 件、`spanning tree` のヒットは
  全域木の**存在**（`SimpleGraph/Acyclic.lean`）と arborescence だけで個数の公式は無い。
* **段 3: 2 の不分岐性と Hensel 持ち上げを $\mathbb{Q}(\zeta_L)$ の完備化で扱う段。**
  mathlib に Hensel の補題（`Mathlib/NumberTheory/Padics/Hensel.lean`）はあるが $\mathbb{Z}_p$ 上の
  1 変数版であり、$\mathbb{Q}(\zeta_L)$ の素点での完備化・その付値環へ持ち上げる配線は自前で作る必要がある。
  **「mathlib に無い」とは書かない**（Hensel 自体は在る）。無いのは配線であって道具ではない。

段 5 の総和と段 4 の Newton 多角形の組合せ核は、外部から来る事実を**仮定として明示**した形で形式化した
（`v2_tau_eq_of_root_valuations`）。何を仮定したかが型に現れるので、人手証明のどこが Lean で
閉じていて、どこが外部依存かが機械的に読める。

**新規性は主張しない。**
-/
import Mathlib.RingTheory.Polynomial.Cyclotomic.Basic
import Mathlib.RingTheory.RootsOfUnity.PrimitiveRoots
import Mathlib.NumberTheory.Padics.PadicVal.Basic

namespace IntegrableLattice

open Finset Polynomial

/-! ## 段 2: 部分積の閉形式（純代数。$L$ の偶奇にも標数にも依らない） -/

section Step2

variable {K : Type*} [Field K] {L : ℕ} {ζ r : K}

/-- 1 の原始 $L$ 乗根 $u$ について $\prod_{k<L}(r-u^k)=r^L-1$。 -/
theorem prod_sub_pow_eq (hL : 0 < L) (hu : IsPrimitiveRoot ζ L) (r : K) :
    ∏ k ∈ range L, (r - ζ ^ k) = r ^ L - 1 := by
  classical
  have himg : nthRootsFinset L (1 : K) = (range L).image (fun k => ζ ^ k) := by
    refine (Finset.eq_of_subset_of_card_le ?_ ?_).symm
    · intro x hx
      simp only [Finset.mem_image, Finset.mem_range] at hx
      obtain ⟨k, _, rfl⟩ := hx
      rw [mem_nthRootsFinset hL]
      rw [← pow_mul, mul_comm, pow_mul, hu.pow_eq_one, one_pow]
    · rw [hu.card_nthRootsFinset, Finset.card_image_of_injOn, card_range]
      intro i hi j hj hij
      exact hu.pow_inj (Finset.mem_range.mp hi) (Finset.mem_range.mp hj) hij
  have hpoly : (X : K[X]) ^ L - 1 = ∏ μ ∈ nthRootsFinset L (1 : K), (X - C μ) :=
    X_pow_sub_one_eq_prod hL hu
  have := congrArg (Polynomial.eval r) hpoly
  simp only [eval_sub, eval_pow, eval_X, eval_one, eval_prod, eval_C] at this
  rw [this, himg, Finset.prod_image]
  intro i hi j hj hij
  exact hu.pow_inj (Finset.mem_range.mp hi) (Finset.mem_range.mp hj) hij

/-- **段 2（人手証明 (3.1)）**: $A=r+r^{-1}$ とすると
$$\prod_{k=0}^{L-1}\bigl(A-\zeta^k-\zeta^{-k}\bigr)=r^L+r^{-L}-2 .$$ -/
theorem prod_A_sub_zeta_eq (hL : 0 < L) (hζ : IsPrimitiveRoot ζ L) (hr : r ≠ 0) (hζ0 : ζ ≠ 0) :
    ∏ k ∈ range L, (r + r⁻¹ - ζ ^ k - (ζ ^ k)⁻¹) = r ^ L + (r ^ L)⁻¹ - 2 := by
  have hfac : ∀ k ∈ range L,
      r + r⁻¹ - ζ ^ k - (ζ ^ k)⁻¹ = r⁻¹ * ((r - ζ ^ k) * (r - (ζ⁻¹) ^ k)) := by
    intro k _
    have hzk : ζ ^ k ≠ 0 := pow_ne_zero _ hζ0
    rw [inv_pow]
    field_simp
    ring
  rw [Finset.prod_congr rfl hfac, Finset.prod_mul_distrib, Finset.prod_mul_distrib,
    prod_sub_pow_eq hL hζ, prod_sub_pow_eq hL hζ.inv, Finset.prod_const, card_range]
  have hrL : r ^ L ≠ 0 := pow_ne_zero _ hr
  rw [inv_pow]
  field_simp
  ring

end Step2

/-! ## 「$L$ 奇」が効く初等的な 2 箇所 -/

/-- 人手証明が奇数性を使う箇所その 1: $j\not\equiv0$ かつ $L$ 奇なら $2j\not\equiv0\pmod L$。 -/
theorem not_dvd_two_mul_of_odd {L j : ℕ} (hL : Odd L) (hj : ¬ L ∣ j) : ¬ L ∣ 2 * j := by
  intro h
  exact hj (Nat.Coprime.dvd_of_dvd_mul_left (Nat.coprime_two_right.mpr hL) h)

/-- 人手証明が奇数性を使う箇所その 2: $L$ 奇なら $v_2(L)=0$（二項展開で主項が残る根拠）。 -/
theorem padicValNat_two_eq_zero_of_odd {L : ℕ} (hL : Odd L) : padicValNat 2 L = 0 :=
  padicValNat.eq_zero_of_not_dvd (by
    have h := Nat.odd_iff.mp hL
    omega)

/-! ## 段 4 の Newton 多角形の組合せ核

3 係数の付値が $(0,0,1)$ の 2 次方程式について、2 根の付値が $0$ と $1$ になる段。
非アルキメデス性（付値が異なるとき和の付値は最小値）を仮定として明示的に受け取る。 -/

/-- **段 4 の核**: 2 根の付値を $a,b$、和の付値を $c$ とする。根の積の付値が $1$（＝定数項/主係数）、
和の付値が $0$（＝1 次係数/主係数）で、非アルキメデス性が使えるなら $\{a,b\}=\{0,1\}$。 -/
theorem newton_two_root_valuations {a b c : ℤ} (hprod : a + b = 1) (hc : c = 0)
    (hne : a ≠ b → c = min a b) : (a = 0 ∧ b = 1) ∨ (a = 1 ∧ b = 0) := by
  have hab : a ≠ b := by omega
  have := hne hab
  omega

/-! ## 段 5: 総和

人手証明の最終段を、外部から来る 2 つの事実（段 1 の積公式、段 3–4 の各点付値）を
**仮定として明示した**形で形式化する。 -/

/-- **段 5**: 各 $j\in[1,L-1]$ で $v(D_j)=2$（＝ $v(r_j^L-1)=1$）なら $v_2(\tau(L))=2(L-1)$。

* `hprod` は段 1（matrix-tree ＋ 対角化）から来る積公式を付値の言葉で書いたもの。
* `hval` は段 3–4（不分岐性・Hensel・Newton 多角形・二項展開）の結論。

どちらも本ファイルでは**仮定**であり、証明していない（上のヘッダ参照）。 -/
theorem v2_tau_eq_of_root_valuations {L : ℕ} (hL : 1 ≤ L) (v2tau : ℤ) (vD : ℕ → ℤ)
    (hprod : v2tau = ∑ j ∈ Finset.Ico 1 L, vD j)
    (hval : ∀ j ∈ Finset.Ico 1 L, vD j = 2) :
    v2tau = 2 * ((L : ℤ) - 1) := by
  rw [hprod, Finset.sum_congr rfl hval, Finset.sum_const, Nat.card_Ico]
  have : ((L - 1 : ℕ) : ℤ) = (L : ℤ) - 1 := by
    have : (1 : ℕ) ≤ L := hL
    omega
  rw [nsmul_eq_mul, this]
  ring

end IntegrableLattice
