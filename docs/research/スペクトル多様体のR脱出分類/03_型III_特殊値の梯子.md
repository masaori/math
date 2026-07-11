# 03 型Ⅲ：特殊値の梯子（$L$ 値・周期）

最大の家系（カタログ約60例）。$m(P)$ が **weight-$d$ の(準)モジュラー形式の $s=d$ 特殊値**になる。RΛ 双対の主戦場で、「同一 $L$ 函数を二素点で読む」双対が完全に立つ唯一の型。

---

## 0. 定義と核心の梯子

$$
\boxed{\text{型Ⅲ}\iff m(P)=(\text{有理数})\cdot(\text{周期})\cdot L(M,\,d),}
$$
$M=$ スペクトル多様体 $\{P=0\}$（$\dim d-1$）の中間コホモロジーが定める**モチーフ**、$L(M,s)$ はその $L$ 函数、評価点 $s=d$。値は **Beilinson 正則子**＝$K$-理論の記号 $\{x_1,\dots,x_d\}$ の regulator pairing。超越だが**構造化された $L$ 特殊値**。

**梯子**（weight が次元 $d$ とともに上がる）：

| $d$ | $\{P=0\}$ | weight | $L$ 値（$s=d$）|
|---|---|---|---|
| 2 有理 | 曲線（種数0）| Dirichlet (wt1) | $L(\chi,2)$, dilog |
| 3 有理 | 曲面（有理）| $\zeta$ | $\zeta(3)$ |
| 2 楕円 | 曲線（種数1）| wt-2 $=L(E,s)$ | $L(E,2)\sim L'(E,0)$ |
| 3 K3 | 曲面（K3）| **wt-3 newform** | $L(f,3)$ |
| 4 CY | 3-fold（CY）| **wt-4 newform** | $L(f,4)$ |

一言で **weight-$d$ の $s=d$ 特殊値**。$d=2$ 楕円 → $d=3$ K3 → $d=4$ CY と昇る。

**機構**：$m(P)=\frac{1}{2\pi}\int_\gamma\eta$、$\eta=\sum(-1)^i\log|x_i|\,d\arg x_1\wedge\dots\widehat{d\arg x_i}\dots$（regulator 形式）。tempered なら境界項が消え、$m(P)=$ Beilinson 正則子。数論的に特殊なら $L(M,d)$ に評価（Beilinson 予想）。

---

## 1. weight-1 段：Dirichlet $L$・Catalan・dilog（$d=2$ 有理、全て証明済み）

種数0 で regulator が**二重対数**に落ち、$L$ 値は Dirichlet。

- **蜂の巣 dimer** $m(1+x+y)=\dfrac{3\sqrt3}{4\pi}L(\chi_{-3},2)=L'(\chi_{-3},-1)=0.3230659\ldots$（Smyth 1981）。
- **正方 dimer** $m(z+z^{-1}+i(w+w^{-1}))=\dfrac{G}{\pi}=0.2915609\ldots$（$G$=Catalan$=L(\chi_{-4},2)$、Kasteleyn–Temperley–Fisher）。
- $m(1+x+y-xy)=\dfrac{2G}{\pi}$（Smyth）。
- **Cassaigne–Maillot** $m(a+bx+cy)=$ Bloch–Wigner dilog $D(\cdot)$＝双曲三角形/四面体の体積（Vandervelde 2003）。
- **図8結び目 A-多項式** $m=\mathrm{vol}(4_1)/2\pi$（双曲体積＝dilog、Boyd–RV 2002）。

## 2. weight-1 段の $d=3$ 版：$\zeta(3)$

- $m(1+x+y+z)=\dfrac{7}{2\pi^2}\zeta(3)=0.4211\ldots$（Smyth）。線型（有理3-fold）ゆえ $\zeta=L(\mathbf1,s)$ の $s=3$。$d=2$ の $L(\chi_{-3},2)$ の一段上。

---

## 3. weight-2 段：楕円 $L'(E,0)$（$d=2$ 種数1）— 最大の家系

Beilinson 予想（楕円曲線）が $\mathrm{reg}\{x,y\}\sim L'(E,0)\sim\frac{N}{4\pi^2}L(E,2)$ を予言。Boyd (1998) が数値で大量発見、個別証明が進行中。

**Boyd $n(k)=m(x+\tfrac1x+y+\tfrac1y+k)$**：
- $n(1)=L'(E_{15},0)=0.2513304$（Deninger 予想 → **Rogers–Zudilin 証明**）。
- $n(2)=L'(E_{24},0)$、$n(3)=2L'(E_{21},0)$、$n(8)=4n(2)$、$n(2\sqrt2)=L'(E_{32},0)$（**証明済み**）。
- $n(5),\dots,n(12)$ は Boyd の**予想**。退化 $n(4)=\dfrac{4G}\pi$（種数0、証明）。

**Boyd tempered $g(k)=m((1+x)(1+y)(x+y)-kxy)$**：
- $g(1)=L'(E_{14},0)$（**Mellit 証明**）、$g(3)=L'(E_{30},0)$, $g(9)=3L'(E_{30},0)$, $g(24)=5L'(E_{30},0)$（**Lalín et al. 証明**）。
- $g(2)=\tfrac12L'(E_{36},0)$（CM、予想）。

**非 tempered**：$L'(E_N,0)+\log$ 項。例 $m(\sqrt2(x+\tfrac1x)+(y+\tfrac1y)+1)=\tfrac23L'(E_{14},0)+\tfrac13\log2$（証明）。tempered が崩れると代数的 $\log$ 項が付くが、主要部は楕円 $L$ 値ゆえ型Ⅲ。

**アンカー**：$X_1(11)$（$N=11$, Mellit）、Siegel 単元族（$N=35,54$, Brunault）、Hesse $x^3+y^3+1-kxy$（CM 点で証明、Samart）、Bertin–Zudilin 種数2（$L'(E,0)$ へ、証明）。

**Ising**：Onsager 自由エネルギー＝Ising スペクトル曲線の $m$。
- 正方臨界 $m=\tfrac12\log2+\tfrac12 G$（weight-1 Catalan＋代数的 $\log$）。
- 特殊温度で楕円化：$k=8$ で $\frac{24}{\pi^2}L(E_{24},2)$、$k=-4$ で $\frac{18}{\pi^2}L(E_{36},2)$（導手24/36、Viswanathan 2024）。**臨界＝weight-1、特殊温度＝weight-2** の Ising 内部の梯子。

**全域木**：$\mathbb{Z}^2$ 全域木 $=\dfrac4\pi G$（Catalan、weight-1）。YBE 非可積分だが型Ⅲ——[`../R-Lambda-duality §9.4`](../R-Lambda-duality/README.md) の「可積分性と型は独立」。

---

## 4. weight-3 段：K3 の $L(f,3)$（$d=3$）

singular K3（Picard 数 $\rho=20$）は wt-3 newform $f$（超越格子が wt-3 モチーフ）を持ち $m(P)\sim L(f,3)$。$d_3:=\frac{3\sqrt3}{4\pi}L(\chi_{-3},2)$。

- **Bertin $P_k=x+\tfrac1x+y+\tfrac1y+z+\tfrac1z-k$**（$k=0,2,3,6,10,18$）：$P_0=d_3$（3D 立方 Green 定数、CM 退化）、$P_2=\frac{16\sqrt2}{\pi^3}L(g_8,3)$ 等、level 8,15,24,120 の wt-3 CM newform（**証明**）。
- **Samart 族**：$(x+\tfrac1x)(y+\tfrac1y)(z+\tfrac1z)+8$ で $8L'(h,0)=\frac{128}{\pi^3}L(h,3)$、Dwork quartic $x^4+y^4+z^4+1+648^{1/4}xyz$ で level-16 の $L(h,3)$（**証明**、level 8–48）。
- 3-var 楕円（$E_{15},E_{45},E_{48}$、Brunault 証明/予想）、Lalín $z+(x+1)(y+1)$ で $\zeta(3)+L'(f_7,0)$（wt3 level7）。

**機構**：K3 上の higher Chow 群 $CH^2(X,1)$ の regulator ＝ Beilinson 予想@wt3 で $L(f,3)$。$d=2$ 楕円（wt2）の一段上。

---

## 5. weight-4 段：Calabi–Yau の $L(f,4)$（$d=4$）

- **Papanikolas–Rogers–Samart**（唯一の厳密 CY 例）:
$$
m\Bigl((x{+}\tfrac1x)(y{+}\tfrac1y)(z{+}\tfrac1z)(w{+}\tfrac1w)-16\Bigr)=8L'(f,0)-28\zeta'(-2)=\frac{192}{\pi^4}L(f,4)+\frac{7\zeta(3)}{\pi^2},
$$
$f=\eta^4(2\tau)\eta^4(4\tau)\in S_4(\Gamma_0(8))$（wt-4 newform）。$\zeta(3)$ 項は $d=3$ Smyth（§2）の痕跡——**梯子の各段が下段を内包**。
- 予想的 CY/K3-as-$\mathbb{Z}^4$（wt3/wt4）。

---

## 6. 型Ⅲ の RΛ 双対での位置（双対が最も鮮明）

型Ⅲ は「**同一の $L$ 函数を二素点で読む**」双対が完全に立つ（[`../R-Lambda-duality §9.2`](../R-Lambda-duality/README.md)）：
$$
\underbrace{m(P)=(\text{有理})\cdot L(M,d)}_{\infty:\ \text{アルキメデス特殊値（自由エネルギー）}}\ \longleftrightarrow\ \underbrace{P\bmod p\ \text{点数}\to L\text{ の Euler 因子}}_{p:\ \Lambda\text{-native, 決定可能}}
$$

- **$\Lambda$ 側**：$N_p=\#\{P=0\ \text{in}\ \mathbb{F}_p^d\}$、$p$ 進 Newton 多角形、還元型が $L(M,s)=\prod_p L_p(p^{-s})^{-1}$ の局所因子を組む（決定可能）。
- **$\mathbb{R}$ 側**：同じ $L$ の $s=d$ 特殊値が $m(P)$。
- **双対＝可解性の特徴づけ**：「解ける $\iff\{P=0\}$ が数論的特殊 $\iff m(P)$ が $L$ 特殊値」。型Ⅲ はこの同値の成立域（[`../数え上げエントロピーと特殊値/`](../数え上げエントロピーと特殊値/README.md) の本体）。

**証明状況の分別**：
- **定理**：LSW、各 Dirichlet/$\zeta(3)$ 評価（Smyth）、K3（Bertin・Samart）、CY（Papanikolas–RS）、楕円の Rogers–Zudilin/Mellit/Lalín/Brunault の名指し例。
- **予想**：Boyd $n(k)/g(k)$ の未証明行、一般の Beilinson 予想（高 weight は大きく予想的）。$\Lambda$ 側（点数・Euler 因子）は予想と無関係に決定可能——**$\Lambda$ が型を検出、$\mathbb{R}$ が閉形式を（予想的に）与える**非対称。

---

## 7. 総括

| weight | $d$/型 | $L$ 値 | 代表・状態 |
|---|---|---|---|
| 1 | $d{=}2$ 有理 | $L(\chi,2)$, dilog | dimer・Smyth（✓）|
| 1 | $d{=}3$ 有理 | $\zeta(3)$ | Smyth 3-var（✓）|
| 2 | $d{=}2$ 楕円 | $L'(E,0)$ | Boyd $n(k),g(k)$（一部✓）|
| 3 | $d{=}3$ K3 | $L(f,3)$ | Bertin・Samart（✓）|
| 4 | $d{=}4$ CY | $L(f,4)$ | Papanikolas–RS（✓）|

型Ⅲ＝「$\{P=0\}$ の数論が特殊で $m(P)$ が weight-$d$ の $L$ 値@$s=d$」。**次元で weight が上がる一本の梯子**で、$T^2$ の楕円がその $d=2$ 段。RΛ 双対（$\infty$ で $L$ 特殊値＝Mahler、$p$ で Euler 因子）が最も鮮明に立つ中核。

## 参考文献
Smyth (1981); Boyd (1998) Exp. Math. 7（マスター表）; Deninger (1997) JAMS 10; Rodriguez-Villegas *Modular Mahler Measures I* (1999); Rogers–Zudilin（arXiv:1102.1153, 1012.3036）; Lalín–Samart–Zudilin (2016)（arXiv:1507.08743）; arXiv:1907.08389; Mellit（arXiv:1207.4722）; Brunault; Brunault–Zudilin (2020); Cassaigne–Maillot; Vandervelde (2003) JNT 100; Boyd–Rodriguez-Villegas (2002)（arXiv:math/0308041）; Bertin (2008) JNT 128（arXiv:1208.6240）; Samart（arXiv:1205.4803）; Papanikolas–Rogers–Samart (2014) Math. Z. 276（arXiv:1305.2143）; Viswanathan (2024) PRE 110（arXiv:2407.19531）; Beilinson (1985); 詳細は [`../Boyd-Deninger-Beilinson/`](../Boyd-Deninger-Beilinson/README.md).
