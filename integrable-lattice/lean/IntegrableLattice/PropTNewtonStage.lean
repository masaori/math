/-
# 命題 T の段 4（Newton 多角形）の $v(m_j)=1$ そのもの — cycle 50 step 3

対応する人手証明: 本文ブロック `paper_062_theorem_T`（命題 T）の証明の段 4——
$r_j=\zeta^{j}(1+m_j)$ と置いたとき $v(m_j)=1$ であり、そこから $v(r_j^{L}-1)=1$ が出る段。

## この段が数えられていなかった経緯

`PropT.lean` は段 4 の**組合せ核**（3 係数の付値が $(0,0,1)$ なら 2 根の付値は $0$ と $1$）を
書いているが、**$v(m_j)=1$ そのものは外から来る事実として仮定の形で受け取っていた。**
cycle 49 step 1 の全数の突き合わせで、`PropTHenselLift.lean` が挙げているこの事柄を
欄が 1 度も数えていなかったことが分かり、残り項目として足された。本ファイルがそれを書く。

## Newton 多角形を経由しない（本 step の主題）

**書いてみると、この段は Newton 多角形を組み立てずに出る。そう書く。**

本文の 2 次方程式
$$\zeta^{j}m^{2}+(3\zeta^{j}+\zeta^{-j}-4)m-2(1-\zeta^{j})(1-\zeta^{-j})=0$$
の 3 つの係数は、$z=\zeta^{j}$ と置くと
$$z,\qquad z^{-1}(z-1)(3z-1),\qquad 2z^{-1}(z-1)^{2}$$
と因数分解できる。**剰余体の標数が 2 で $1-z$ が単元なら、はじめの 2 つは単元で、
3 つ目はちょうど 2 の単元倍である。**

このとき $m$ が極大イデアルに属していれば（Hensel の持ち上げが $r_j\equiv\zeta^{j}$ を与えるので、
これは段 3 の結論である）、方程式を $m\,(a_2m+a_1)=-a_0$ と読み替えるだけでよい——
**$a_2m+a_1$ は単元（極大イデアルの元と単元の和）だから、$m$ は $a_0$ の単元倍、
すなわち 2 の単元倍である。** これが $v(m_j)=1$ の中身である。

**2 根の付値の対を作る必要も、付値写像を導入する必要も無い。**
結論を「$m$ は 2 の単元倍である」という形で書けば、環の言葉だけで閉じる。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

**$\mathbb{R}$ へも $\overline{\mathbb{Q}}$ へも 1 度も出ない。**
使うのは可換局所環の単元と極大イデアルの計算だけで、付値写像も順序も距離も出てこない。
$\mathbb{Z}$ の側で使うのは $L$ が奇数であることだけである。

## 書いたこと（5 段）

1. 極大イデアルの元と単元の和は単元である（`isUnit_add_of_mem_maximalIdeal`）。
2. 本文の 2 次方程式そのもの（`quadratic_of_root`。$r=z(1+m)$ を $r^2-Ar+1=0$ へ代入する）。
3. 3 係数の因数分解（`middle_coeff_eq` / `const_coeff_eq`）と、
   前 2 つが単元であること（`isUnit_middle_coeff`）。
4. **$m$ は 2 の単元倍である**（`eq_two_mul_unit_of_mem_maximalIdeal`）。段 4 の結論そのもの。
5. 二項展開の側（`pow_sub_one_eq_mul_unit`。$r^{L}-1=m\cdot(\text{単元})$）と、
   それらを合わせた形（`pow_sub_one_eq_two_mul_unit`）。

## 形式化しなかったもの

* **$v(2)=1$ であること（2 が素元であること）。** 本文はこれを「$L$ 奇なら 2 は
  $\mathbb{Q}(\zeta_L)$ で不分岐」から得ている。本ファイルの結論は「2 の単元倍である」までで、
  そこから付値の値 $1$ を読むには 2 が素元である舞台が要る。**舞台そのものは
  `PropTMixedWitness.lean` が混標数で与えている**が、本文の完備化がその舞台であることは
  別の残り項目（付値の位相が $\mathfrak m$ 進位相であること）である。
-/
import Mathlib
import IntegrableLattice.PropTResidueRoot

namespace IntegrableLattice
namespace PropTNewtonStage

open Finset IsLocalRing

variable {O : Type*} [CommRing O] [IsLocalRing O]

/-! ## 1. 極大イデアルの元と単元の和は単元である -/

/-- 局所環では、単元に極大イデアルの元を足しても単元である。 -/
theorem isUnit_add_of_mem_maximalIdeal {x y : O} (hx : x ∈ maximalIdeal O) (hy : IsUnit y) :
    IsUnit (x + y) := by
  by_contra h
  have hmem : x + y ∈ maximalIdeal O := (mem_maximalIdeal _).mpr h
  have hy' : y ∈ maximalIdeal O := by
    have : (x + y) - x ∈ maximalIdeal O := Ideal.sub_mem _ hmem hx
    simpa using this
  exact (notMem_maximalIdeal.mpr hy) hy'

/-! ## 2. 本文の 2 次方程式

$r=z(1+m)$ を $r^{2}-Ar+1=0$（$A=4-z-z^{-1}$）へ代入して $z$ で割る。純代数である。 -/

/-- **本文の段 4 の 2 次方程式そのもの。** -/
theorem quadratic_of_root (z : Oˣ) (m r : O) (hr : r = (z : O) * (1 + m))
    (hroot : r ^ 2 - (4 - (z : O) - ((z⁻¹ : Oˣ) : O)) * r + 1 = 0) :
    (z : O) * m ^ 2 + (3 * (z : O) + ((z⁻¹ : Oˣ) : O) - 4) * m
      - 2 * (1 - (z : O)) * (1 - ((z⁻¹ : Oˣ) : O)) = 0 := by
  have hzz : (z : O) * ((z⁻¹ : Oˣ) : O) = 1 := z.mul_inv
  have hz : IsUnit (z : O) := z.isUnit
  -- 代入した式は、もとの式の $z$ 倍である。
  have hexp : (z : O) * ((z : O) * m ^ 2 + (3 * (z : O) + ((z⁻¹ : Oˣ) : O) - 4) * m
      - 2 * (1 - (z : O)) * (1 - ((z⁻¹ : Oˣ) : O)))
      = r ^ 2 - (4 - (z : O) - ((z⁻¹ : Oˣ) : O)) * r + 1 := by
    subst hr
    linear_combination (1 - 2 * (z : O)) * hzz
  rw [hroot] at hexp
  exact hz.mul_left_cancel (by rw [hexp, mul_zero])

/-! ## 3. 3 係数の因数分解と単元性 -/

/-- 中央の係数は $z^{-1}(z-1)(3z-1)$ である。 -/
theorem middle_coeff_eq (z : Oˣ) :
    3 * (z : O) + ((z⁻¹ : Oˣ) : O) - 4
      = ((z⁻¹ : Oˣ) : O) * (((z : O) - 1) * (3 * (z : O) - 1)) := by
  have hzz : (z : O) * ((z⁻¹ : Oˣ) : O) = 1 := z.mul_inv
  linear_combination (4 - 3 * (z : O)) * hzz

/-- 定数項は $-2z^{-1}(z-1)^{2}$ である（本文の $-2(1-\zeta^{j})(1-\zeta^{-j})$）。 -/
theorem const_coeff_eq (z : Oˣ) :
    -(2 * (1 - (z : O)) * (1 - ((z⁻¹ : Oˣ) : O)))
      = 2 * (((z⁻¹ : Oˣ) : O) * ((z : O) - 1) ^ 2) := by
  have hzz : (z : O) * ((z⁻¹ : Oˣ) : O) = 1 := z.mul_inv
  linear_combination (2 - 2 * (z : O)) * hzz

/-- **中央の係数は単元である**（剰余体の標数が 2 で $z-1$ が単元のとき）。

$z^{-1}(z-1)(3z-1)$ の 3 因子がどれも単元だからである。
$3z-1=(z-1)+2z$ は、$2$ が極大イデアルに属するので $z-1$ と剰余体で同じである。 -/
theorem isUnit_middle_coeff (z : Oˣ) (h2 : (2 : O) ∈ maximalIdeal O)
    (hz1 : IsUnit ((z : O) - 1)) :
    IsUnit (3 * (z : O) + ((z⁻¹ : Oˣ) : O) - 4) := by
  rw [middle_coeff_eq]
  refine (z⁻¹).isUnit.mul (hz1.mul ?_)
  have h3 : 3 * (z : O) - 1 = 2 * (z : O) + ((z : O) - 1) := by ring
  rw [h3]
  exact isUnit_add_of_mem_maximalIdeal (Ideal.mul_mem_right _ _ h2) hz1

/-! ## 4. 段 4 の結論: $m$ は 2 の単元倍である -/

/-- **段 4 の結論。** 2 次方程式 $a_2m^{2}+a_1m+2w=0$（$a_1$ と $w$ は単元）を満たす $m$ が
極大イデアルに属していれば、$m$ は 2 の単元倍である。

**$m\,(a_2m+a_1)=-2w$ と読み替えるだけである**——$m$ が極大イデアルに属するので
$a_2m+a_1$ は単元であり、$m$ はその逆元を掛けた形で書ける。
**Newton 多角形も付値写像も要らない。** -/
theorem eq_two_mul_unit_of_mem_maximalIdeal {a₂ a₁ m : O} {w : Oˣ}
    (ha₁ : IsUnit a₁) (hm : m ∈ maximalIdeal O)
    (heq : a₂ * m ^ 2 + a₁ * m + 2 * (w : O) = 0) :
    ∃ v : Oˣ, m = 2 * (v : O) := by
  have hfac : m * (a₂ * m + a₁) = -(2 * (w : O)) := by linear_combination heq
  have hunit : IsUnit (a₂ * m + a₁) :=
    isUnit_add_of_mem_maximalIdeal (Ideal.mul_mem_left _ _ hm) ha₁
  obtain ⟨s, hs⟩ := hunit
  refine ⟨-w * s⁻¹, ?_⟩
  have : m * (s : O) = 2 * (-(w : O)) := by rw [hs, hfac]; ring
  calc m = m * (s : O) * ((s⁻¹ : Oˣ) : O) := by
        rw [mul_assoc]
        simp
    _ = 2 * (-(w : O)) * ((s⁻¹ : Oˣ) : O) := by rw [this]
    _ = 2 * ((-w * s⁻¹ : Oˣ) : O) := by push_cast; ring

/-! ## 5. 二項展開の側 -/

/-- **$r^{L}-1=m\cdot(\text{単元})$**（$z^{L}=1$、$L$ は単元、$m$ は極大イデアルの元）。

$r^{L}-1=(1+m)^{L}-1=m\sum_{i<L}(1+m)^{i}$ で、和は剰余体で $L$ と等しい。 -/
theorem pow_sub_one_eq_mul_unit (z : Oˣ) {L : ℕ} (m r : O) (hr : r = (z : O) * (1 + m))
    (hzL : (z : O) ^ L = 1) (hm : m ∈ maximalIdeal O) (hL : IsUnit (L : O)) :
    ∃ v : Oˣ, r ^ L - 1 = m * (v : O) := by
  classical
  have hgeom : (∑ i ∈ range L, (1 + m) ^ i) * m = (1 + m) ^ L - 1 := by
    have := geom_sum_mul (1 + m) L
    simpa using this
  have hsum : IsUnit (∑ i ∈ range L, (1 + m) ^ i) := by
    -- 各項は $1$ と極大イデアルの元の和なので、総和は $L$ と剰余体で等しい。
    have hstep : ∑ i ∈ range L, (1 + m) ^ i - (L : O) ∈ maximalIdeal O := by
      have : ∑ i ∈ range L, ((1 + m) ^ i - 1) ∈ maximalIdeal O := by
        refine Ideal.sum_mem _ fun i _ => ?_
        have := geom_sum_mul (1 + m) i
        rw [show (1 + m) ^ i - 1 = (∑ k ∈ range i, (1 + m) ^ k) * m by simpa using this.symm]
        exact Ideal.mul_mem_left _ _ hm
      simpa [Finset.sum_sub_distrib] using this
    have := isUnit_add_of_mem_maximalIdeal hstep hL
    simpa using this
  obtain ⟨s, hs⟩ := hsum
  refine ⟨s, ?_⟩
  rw [hr, mul_pow, hzL, one_mul, ← hgeom, hs]
  ring

/-- **段 4 の 2 つを合わせた形。** $r^{L}-1$ は 2 の単元倍である
（本文の $v(r_j^{L}-1)=v(m_j)=1$）。 -/
theorem pow_sub_one_eq_two_mul_unit (z : Oˣ) {L : ℕ} {m r : O} {w : Oˣ} {a₂ a₁ : O}
    (hr : r = (z : O) * (1 + m)) (hzL : (z : O) ^ L = 1) (hm : m ∈ maximalIdeal O)
    (hLunit : IsUnit (L : O)) (ha₁ : IsUnit a₁)
    (heq : a₂ * m ^ 2 + a₁ * m + 2 * (w : O) = 0) :
    ∃ v : Oˣ, r ^ L - 1 = 2 * (v : O) := by
  obtain ⟨v₁, hv₁⟩ := pow_sub_one_eq_mul_unit z m r hr hzL hm hLunit
  obtain ⟨v₂, hv₂⟩ := eq_two_mul_unit_of_mem_maximalIdeal ha₁ hm heq
  exact ⟨v₂ * v₁, by rw [hv₁, hv₂]; push_cast; ring⟩

/-! ## 6. 本文の仮定のままで述べた形

段 3（Hensel の持ち上げ）が与えるのは $r\equiv\zeta^{j}$ すなわち $r-z$ が極大イデアルに属することなので、
そこから $m$ が極大イデアルに属することを出しておく。 -/

/-- $r\equiv z$ なら $m=z^{-1}r-1$ は極大イデアルに属する。 -/
theorem mem_maximalIdeal_of_congr (z : Oˣ) {m r : O} (hr : r = (z : O) * (1 + m))
    (hcong : r - (z : O) ∈ maximalIdeal O) : m ∈ maximalIdeal O := by
  have hzz : ((z⁻¹ : Oˣ) : O) * (z : O) = 1 := z.inv_mul
  have : ((z⁻¹ : Oˣ) : O) * (r - (z : O)) = m := by
    rw [hr]; linear_combination (1 + m) * hzz - hzz
  rw [← this]
  exact Ideal.mul_mem_left _ _ hcong

/-- **本文の段 4 そのもの。** $r=\zeta^{j}(1+m)$ が $w^{2}-A w+1=0$（$A=4-\zeta^{j}-\zeta^{-j}$）の根で、
$r\equiv\zeta^{j}$、剰余体の標数が 2、$\zeta^{j}-1$ が単元なら、**$m$ は 2 の単元倍である。** -/
theorem eq_two_mul_unit_of_root (z : Oˣ) {m r : O} (hr : r = (z : O) * (1 + m))
    (hroot : r ^ 2 - (4 - (z : O) - ((z⁻¹ : Oˣ) : O)) * r + 1 = 0)
    (h2 : (2 : O) ∈ maximalIdeal O) (hz1 : IsUnit ((z : O) - 1))
    (hcong : r - (z : O) ∈ maximalIdeal O) :
    ∃ v : Oˣ, m = 2 * (v : O) := by
  have hm : m ∈ maximalIdeal O := mem_maximalIdeal_of_congr z hr hcong
  have hquad := quadratic_of_root z m r hr hroot
  -- 定数項を 2 の単元倍の形へ書き直す。
  set wu : Oˣ := z⁻¹ * hz1.unit ^ 2 with hwu
  have hwuval : (wu : O) = ((z⁻¹ : Oˣ) : O) * ((z : O) - 1) ^ 2 := by
    rw [hwu]
    push_cast [IsUnit.unit_spec]
    ring
  have heq : (z : O) * m ^ 2 + (3 * (z : O) + ((z⁻¹ : Oˣ) : O) - 4) * m + 2 * (wu : O) = 0 := by
    rw [hwuval, ← const_coeff_eq z]
    linear_combination hquad
  exact eq_two_mul_unit_of_mem_maximalIdeal (isUnit_middle_coeff z h2 hz1) hm heq

/-- **段 4 の結論を本文の形で述べたもの。** 上の仮定の下で $r^{L}-1$ は 2 の単元倍である
（本文の $v(r_j^{L}-1)=v(m_j)=1$。$v(2)=1$ を読むには 2 が素元である舞台が要る）。 -/
theorem pow_sub_one_eq_two_mul_unit_of_root (z : Oˣ) {L : ℕ} {m r : O}
    (hr : r = (z : O) * (1 + m))
    (hroot : r ^ 2 - (4 - (z : O) - ((z⁻¹ : Oˣ) : O)) * r + 1 = 0)
    (hzL : (z : O) ^ L = 1) (hLunit : IsUnit (L : O))
    (h2 : (2 : O) ∈ maximalIdeal O) (hz1 : IsUnit ((z : O) - 1))
    (hcong : r - (z : O) ∈ maximalIdeal O) :
    ∃ v : Oˣ, r ^ L - 1 = 2 * (v : O) := by
  have hm : m ∈ maximalIdeal O := mem_maximalIdeal_of_congr z hr hcong
  obtain ⟨v₁, hv₁⟩ := pow_sub_one_eq_mul_unit z m r hr hzL hm hLunit
  obtain ⟨v₂, hv₂⟩ := eq_two_mul_unit_of_root z hr hroot h2 hz1 hcong
  exact ⟨v₂ * v₁, by rw [hv₁, hv₂]; push_cast; ring⟩

end PropTNewtonStage
end IntegrableLattice
