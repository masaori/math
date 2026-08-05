/-
# 系 W7 の素材（格子周長）の第 1 段 — cycle 47 step 4

対応する人手証明:

* 本文ブロック `paper_101_theorem_s_infinity_decision`（命題 K）の 系 W7
  「$b\le\frac12\operatorname{per}(\operatorname{Newt}(\bar{\tilde E}))$」（per は格子周長）

## 掲げた焦点と、その判断

cycle 46 step 4 の測定は、4 欄 11 件のうち**素材が要るのはこの 1 件だけ**だと書いた
（mathlib に `perimeter` を含む宣言 0 件・`latticeLength` 0 件。2026-08-05 実測）。
本 step の焦点は**自分で書くかを決めること**である。

**決めた。自分で書く。** 理由は 3 つある。

1. **前例がある。** Newton 多面体の加法性（Ostrowski の定理）は cycle 39 step 1 で自前に書いた
   （`NewtonPolytopeAdditivity.lean`）。格子周長はその上に乗る量である。
2. **可算側の内容を担う。** 格子周長は格子点の数え上げであり、
   $\mathbb{R}$ にも $\overline{\mathbb{Q}}$ にも出ない。決定可能である。
3. **外部定理ではない。** 系 W7 は本論文自身の主張であり、引用で済ませる道は無い。

## この file が書いた第 1 段

**格子周長そのものではなく、その各辺の長さ（線分の格子長）と、その加法性を書いた。**
格子周長は「凸格子多角形の各辺の格子長の総和」なので、
Minkowski 和での加法性は**平行な辺どうしの格子長が足し算になること**へ帰着する。
本 file はその 1 点である。

* `latticeLength` — 2 つの格子点を結ぶ線分の格子長。
  定義は座標差の最大公約数である（線分上の格子点の個数から $1$ を引いたものに等しい）。
* `latticeLength_eq_zero_iff` — $0$ になるのは両端が一致するときに限る。
* `latticeLength_of_smul` — 原始ベクトル $v$ の $m$ 倍だけ離れていれば格子長は $|m|$ である。
* `latticeLength_add_of_parallel` — **平行な 2 線分の Minkowski 和の格子長は、
  それぞれの格子長の和である。** これが周長の加法性の芯である。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。扱うのは $\mathbb{Z}\times\mathbb{Z}$ の点と、
自然数の最大公約数だけである。**すべて決定可能な世界に留まる。**

## 形式化しなかったもの（実測つき）

* **格子周長そのもの**（凸格子多角形の辺への分解と、その総和）。
  ここには「Newton 多面体の頂点集合を辺へ分ける段」が要る。
  頂点の側は cycle 39 step 1 が書いてある（`NewtonPolytopeAdditivity.lean` の
  `convexHull_eq_of_midpoint`）が、**辺へ分ける段は書いていない。**
* **系 W7 の不等式そのもの**（$b\le\frac12\operatorname{per}$）。
  $S_\infty$ の各点が Newton 多面体の辺の方向を与えることと、
  向かい合う 2 辺が同じ方向に対応するので $\frac12$ が付くことを言う段である。
  **2026-08-05 実測**では mathlib に格子周長は無い（`perimeter` を含む宣言 0 件・
  `latticeLength` 0 件。cycle 46 step 4 の実測と同じ）。
  ただし**線分の格子長そのものは最大公約数ひとつなので、素材は要らなかった**——
  要ったのは `Int.gcd` と `Nat.gcd_mul_left` だけである。そう書く。
-/
import Mathlib

namespace IntegrableLattice
namespace LatticeSegmentLength

/-- **線分の格子長。** $a,b\in\mathbb{Z}^2$ を結ぶ線分の上にある格子点の個数から $1$ を引いたもので、
座標差の最大公約数に等しい。ここではその最大公約数を定義として採る。 -/
def latticeLength (a b : ℤ × ℤ) : ℕ :=
  Int.gcd (b.1 - a.1) (b.2 - a.2)

/-- 格子長が $0$ になるのは両端が一致するときに限る。 -/
theorem latticeLength_eq_zero_iff (a b : ℤ × ℤ) :
    latticeLength a b = 0 ↔ a = b := by
  constructor
  · intro h
    have h1 : b.1 - a.1 = 0 ∧ b.2 - a.2 = 0 := Int.gcd_eq_zero_iff.mp h
    have : b.1 = a.1 := by omega
    have h2 : b.2 = a.2 := by omega
    exact Prod.ext this.symm h2.symm
  · intro h
    subst h
    simp [latticeLength]

/-- 原始ベクトル（座標が互いに素）であること。 -/
def IsPrimitive (v : ℤ × ℤ) : Prop := Int.gcd v.1 v.2 = 1

/-- **原始ベクトル $v$ の $m$ 倍だけ離れた 2 点の格子長は $|m|$ である。**

これが「格子長は $v$ を単位として数えた歩数である」ことの中身である。 -/
theorem latticeLength_of_smul {v : ℤ × ℤ} (hv : IsPrimitive v) (a : ℤ × ℤ) (m : ℤ) :
    latticeLength a (a.1 + m * v.1, a.2 + m * v.2) = m.natAbs := by
  have h1 : (a.1 + m * v.1) - a.1 = m * v.1 := by ring
  have h2 : (a.2 + m * v.2) - a.2 = m * v.2 := by ring
  rw [latticeLength]
  simp only [h1, h2]
  rw [Int.gcd_mul_left]
  rw [show Int.gcd v.1 v.2 = 1 from hv, Nat.mul_one]

/-- **平行な 2 線分の Minkowski 和の格子長は、それぞれの格子長の和である。**

$b-a=m\,v$、$d-c=n\,v$（$v$ は原始的、$m,n\ge0$）なら
$(b+d)-(a+c)=(m+n)\,v$ なので格子長は $m+n$ になる。
**格子周長が Minkowski 和について加法的であることの芯がこれである**——
周長は各辺の格子長の総和であり、Minkowski 和では平行な辺どうしが足し合わされる。 -/
theorem latticeLength_add_of_parallel {v : ℤ × ℤ} (hv : IsPrimitive v)
    (a c : ℤ × ℤ) {m n : ℤ} (hm : 0 ≤ m) (hn : 0 ≤ n) :
    latticeLength (a.1 + c.1, a.2 + c.2)
        ((a.1 + m * v.1) + (c.1 + n * v.1), (a.2 + m * v.2) + (c.2 + n * v.2))
      = latticeLength a (a.1 + m * v.1, a.2 + m * v.2)
        + latticeLength c (c.1 + n * v.1, c.2 + n * v.2) := by
  have hsum : latticeLength (a.1 + c.1, a.2 + c.2)
      ((a.1 + m * v.1) + (c.1 + n * v.1), (a.2 + m * v.2) + (c.2 + n * v.2))
      = latticeLength (a.1 + c.1, a.2 + c.2)
        ((a.1 + c.1) + (m + n) * v.1, (a.2 + c.2) + (m + n) * v.2) := by
    have e1 : (a.1 + m * v.1) + (c.1 + n * v.1) = (a.1 + c.1) + (m + n) * v.1 := by ring
    have e2 : (a.2 + m * v.2) + (c.2 + n * v.2) = (a.2 + c.2) + (m + n) * v.2 := by ring
    rw [e1, e2]
  rw [hsum, latticeLength_of_smul hv (a.1 + c.1, a.2 + c.2) (m + n),
    latticeLength_of_smul hv a m, latticeLength_of_smul hv c n]
  omega

end LatticeSegmentLength
end IntegrableLattice
