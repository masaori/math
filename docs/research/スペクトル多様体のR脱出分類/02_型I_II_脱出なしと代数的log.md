# 02 型Ⅰ・型Ⅱ：脱出なしと代数的 $\log$

$\mathbb{R}$ 脱出が最も浅い二つの型。**型Ⅰ**（値 $\in\Lambda\otimes\mathbb{Q}$ または整数、脱出なし）と**型Ⅱ**（値 $=\log$(代数的数)、脱出は $\log_\mathbb{R}$ 一点）。境界は「$\alpha^n\in\mathbb{Q}$ か否か」で決まる。

---

## 1. 型Ⅱ：代数的 $\log$（定義と意義）

$$
\boxed{\text{型Ⅱ}\iff m(P)=\log_\mathbb{R}\alpha,\quad \alpha\in\overline{\mathbb{Q}}\cap\mathbb{R}_{>0}.}
$$
値は一般に超越（Baker：代数的 $\alpha\ne0,1$ で $\log_\mathbb{R}\alpha$ 超越）だが、**$\mathbb{R}$ 脱出は $\log_\mathbb{R}$ ただ一つを通り、引数 $\alpha$ は可算・代数的で決定可能**。RΛ で「ほぼ $\Lambda$-native」——$\Lambda$ 側（$\alpha$ の付値・分解）も $\mathbb{R}$ 側（$\alpha$ まで）も可算、脱出が一点に隔離（[`../R-Lambda-duality 観察4–6`](../R-Lambda-duality/README.md)）。

**型Ⅰ との境**：$\alpha$ が有理数の冪根（$\alpha^n\in\mathbb{Q}$）なら $\log\alpha\in\Lambda\otimes\mathbb{Q}$ に落ち、**脱出そのものが消える（型Ⅰ）**。genuine な型Ⅱ は $\alpha$ が「有理数の冪根でない」代数的無理数。

---

## 2. 型Ⅱ 家系A：$d=1$ Mahler 測度（全て型Ⅱ）

[`01`](01_Mahler測度の厳密な定義.md) の $(\ast)$：$M(P)=|a_n|\prod\max(1,|\alpha_i|)\in\overline{\mathbb{Q}}$ ゆえ **$d=1$ は無条件で型Ⅱ**（0 次元スペクトル多様体＝単位円上の点集合）。

| $P$ | $\alpha=M(P)$ | 種別 | 型細分 |
|---|---|---|---|
| 円分・単項式（Kronecker）| $1$ | 冪根のみ | Ⅰ（$m=0\in\Lambda$）|
| Lehmer 10次 $x^{10}+x^9-\dots+1$ | $1.17628$ | 最小既知 Salem | Ⅱ |
| $x^2-x-1$（Fibonacci）| $\varphi=1.618$ | Pisot | Ⅱ |
| 4/6/10次 Salem | Salem 数 | Salem | Ⅱ |
| 一般 monic | $\prod\max(1,\|\alpha_i\|)$ | 定理 | Ⅱ |

**Pisot vs Salem（構造）**：
- **Pisot 数** $\theta>1$：共役すべてが**円内**（$|\cdot|<1$）。最小2次 Pisot は黄金比 $\varphi$（$x^2-x-1$）、最小 Pisot はプラスチック数 $1.3247$（$x^3-x-1$）。転送行列 $Z_N=\varphi^N+\psi^N\to\varphi^N$ に急速収束。
- **Salem 数** $\alpha>1$：1共役が $1/\alpha$（円内）、**残りは円上**。Lehmer 数（10次、$1.17628$）が最小既知。Pisot 数の集積点（Salem の定理）。円上共役が振動的に残り、$\Lambda$ 側の残差 $r_p(N)$ の周期構造がより豊か。
- **両者とも型Ⅱ**（$m=\log\alpha$、$\alpha\in\overline{\mathbb{Q}}$）で $\mathbb{R}$ 脱出は $\log_\mathbb{R}$ 一点。

**Lehmer 問題**：$\inf\{m(P):m(P)>0\}>0$ か。回文＝Salem 型が難所（非回文は Smyth 下限 $\log(1.3247)$ で守られる）。70 年以上未解決。

**RΛ 双対**：転送行列（Fibonacci $\begin{psmallmatrix}1&1\\1&0\end{psmallmatrix}$ 等）の特性多項式。$\infty$ で $\log\alpha$（型Ⅱ）、各 $p$ で $L_N,F_N$ の $v_p$（Pisano/Wall 周期）が決定可能。[`../R-Lambda-duality 定理P`](../R-Lambda-duality/README.md) の $v_p(Z_N)=\mu_{\min}(p)N+r_p(N)$ が綺麗に成立。

---

## 3. 型Ⅱ 家系B：$d\ge2$ で例外的に代数的

$d\ge2$ の $m(P)=\int_{\mathbb{T}^d}\log|P|$ は**一般に超越**。代数的数の $\log$ に落ちるのは、模型が特殊で **$\lambda_{\max}$ 自体が代数的**（有限被覆の Perron 根が代数的、または厳密解が代数的数に潰れる）ときのみ。

| 模型 | 値 | 代数次数 | $\log$ の住処 | 真の型 | 特殊性の源 |
|---|---|---|---|---|---|
| **square ice**（Lieb 1967）| $(4/3)^{3/2}=1.5396$ | 2（有理の$\sqrt{}$）| $\Lambda\otimes\mathbb{Q}$ | **Ⅰ** | 自由フェルミオン・有理潰れ |
| **hard hexagon**（Baxter 1980）| $\kappa=1.395486$ | 12 | $\mathbb{R}$（超越）| **Ⅱ** | Baxter 楕円解の代数的特殊点 |
| **六角 SAW**（Duminil-Copin–Smirnov 2012）| $\sqrt{2+\sqrt2}=1.847759$ | 4 | $\mathbb{R}$（超越）| **Ⅱ** | parafermion 可解性 |
| 三角 percolation（Sykes–Essam）| $2\sin(\pi/18)=0.347296$ | 3 | （エントロピー外）| Ⅱ* | star–triangle |

### 3.1 square ice：実は型Ⅰ

正方 ice 模型（六頂点 $a{=}b{=}c{=}1$）の残余エントロピー $W=(4/3)^{3/2}$。$W^2=64/27\in\mathbb{Q}$ ゆえ
$$
m=\log W=\tfrac12\log\tfrac{64}{27}=3\log2-\tfrac32\log3=\rho\bigl(3\ell_2-\tfrac32\ell_3\bigr)\in\rho(\Lambda\otimes\mathbb{Q}).
$$
**$\mathbb{R}$ 脱出が消える**（[`../R-Lambda-duality 観察6`](../R-Lambda-duality/README.md)）。$W$ が「有理数の平方根」ゆえ $\log$ が素数の対数の $\mathbb{Q}$-結合に落ちる。カタログは「代数的無理数」で型Ⅱ に置いたが、**エントロピーとしては型Ⅰ（最強、$\Lambda\otimes\mathbb{Q}$ 内）**。六頂点 $(1,1,2),L=2$ の $\lambda_{\max}=6$, $\log6=\ell_2+\ell_3$ と同じ機構。

### 3.2 hard hexagon：genuine な型Ⅱ

三角格子 hard hexagon（最近接排他）の成長率 $\kappa=1.3954859724\ldots$。Baxter が Rogers–Ramanujan・corner transfer matrix で厳密に解いた。**$\kappa$ は12次の代数的数**、有理数の冪根でない（$\kappa^n\notin\mathbb{Q}$）ゆえ $\log\kappa$ は真に超越（Baker）、$\Lambda\otimes\mathbb{Q}$ に落ちない。$\mathbb{R}$ 脱出は $\log_\mathbb{R}\kappa$ 一点に隔離されるが**消えない**。

**深い意義**：hard hexagon は**相互作用あり・可積分**（YBE）なのにエントロピーが代数的。dimer/Ising（自由フェルミオン、型Ⅲ $L$ 値）と可積分性を共有しながら、数論型が違うので型が違う。**可解性の分類子は YBE でなくスペクトル曲線の数論**であることの決定的実例（[`../R-Lambda-duality §9.4`](../R-Lambda-duality/README.md)）。

### 3.3 六角 SAW：parafermion 可解性

蜂の巣 SAW 連結定数 $\mu=\sqrt{2+\sqrt2}$（$\mu^4-4\mu^2+2=0$、4次）。Nienhuis 1982 予想を Duminil-Copin–Smirnov が parafermionic observable で証明。$\mu^2=2+\sqrt2\notin\mathbb{Q}$ ゆえ genuine 型Ⅱ。**六角だけ**が代数的で、正方 $\mu\approx2.638$・三角 $\mu\approx4.151$ は代数的と知られず型Ⅳ（[`04`](04_型IV_一般超越.md)）。

### 3.4 三角 percolation：外れ値

$p_c=2\sin(\pi/18)$（$\sin(\pi/18)$ は $8x^3-6x+1$ の根、3次）。star–triangle 由来で代数的だが、**臨界確率であってエントロピー $m(P)$ でない**。$\log p_c$ に意味はなく、代数性が YBE 構造から来る点だけ他の型Ⅱ と共通の外れ値。

---

## 4. 型Ⅰ：脱出なし（$\in\Lambda\otimes\mathbb{Q}$・整数）

$$
\boxed{\text{型Ⅰ}\iff \text{値}\in\rho(\Lambda\otimes\mathbb{Q})\ (\lambda_{\max}\in\mathbb{Q}_{>0})\ \text{または そもそも整数（表現数）}.}
$$

### 4.1 $m(P)$ が $\Lambda\otimes\mathbb{Q}$ に落ちる

- 円分・単項式：$m=0\in\Lambda$。
- square ice：$\log W\in\Lambda\otimes\mathbb{Q}$（§3.1）。
- 有限系で $\lambda_{\max}\in\mathbb{Q}$：六頂点 $(1,1,2),L=2$ で $\tfrac12\log6$、蜂の巣 dimer 円筒 $Z_N=2\cdot4^N+1$。**有限 $L$ でのみ・$L\to\infty$ で一般に崩れる不安定な性質**（[`../R-Lambda-duality §8.3`](../R-Lambda-duality/README.md) 軸C）。

### 4.2 表現数・指標多様体（$\Lambda$-native な整数、非可換でも可算）

$N=1$ の $P$ でなく、$\pi_1$ 表現の**数**が整数（[`../曲面群スペクトル曲線_球面とトーラス/03_任意次元トーラス_Zd.md`](../曲面群スペクトル曲線_球面とトーラス/03_任意次元トーラス_Zd.md), [`../数え上げエントロピーと特殊値/07_曲面群のスペクトル曲線_Λ言語.md`](../数え上げエントロピーと特殊値/07_曲面群のスペクトル曲線_Λ言語.md)）。$\Phi=\log(\text{整数})\in\Lambda$ 常に決定可能、$\mathbb{R}$ 脱出は連続化（体積）のみ。

- **可換対点数** $k(GL_N(\mathbb{F}_q))$＝$q$ の $N$ 次整数多項式（Feit–Fine 1960）。
- **Frobenius–Mednykh** $\#\mathrm{Hom}(\Gamma_g,G)=|G|^{2g-1}\sum_\chi\chi(1)^{2-2g}\in\mathbb{Z}$。脱出は $q\to\infty$ で **Witten 体積**（平坦接続モジュライの symplectic 体積）。
- **指標多様体点数** $X_{\Gamma_g,N}(\mathbb{F}_q)$（palindromic 整数多項式、Hausel–Rodriguez-Villegas）。
- **$\mathrm{Sym}^N((\mathbb{C}^\times)^d)$ 点数**（PORC、Bridger–Kamgarpour）。脱出は Hitchin ファイバー体積。

曲面群が良い（語の問題可解・整数 $L^2$-Betti）ので $\mu_{\min}$ の**有限素点法則**は失うが**可算性は保つ**（[`../数え上げエントロピーと特殊値/06_非周期グラフと双曲格子.md`](../数え上げエントロピーと特殊値/06_非周期グラフと双曲格子.md) §1a）。

---

## 5. まとめ

| | 値の住処 | 例 | 脱出 |
|---|---|---|---|
| **型Ⅰ** | $\Lambda\otimes\mathbb{Q}$／整数 | 円分・square ice・表現数・有限系 $\lambda_{\max}\in\mathbb{Q}$ | なし |
| **型Ⅱ** | $\log\overline{\mathbb{Q}}$ | 全 $d{=}1$ Mahler・hard hexagon・六角 SAW | $\log_\mathbb{R}$ 一点 |

境界は $\alpha^n\in\mathbb{Q}$ か否か（square ice は $\Lambda\otimes\mathbb{Q}$ で型Ⅰ、hard hexagon は12次で型Ⅱ）。両型とも $\Lambda$ 側は完全に決定可能で、$\mathbb{R}$ 脱出は無い（Ⅰ）か $\log_\mathbb{R}$ 一点（Ⅱ）に隔離される。$d\ge2$ で本格的に脱出する型Ⅲ（[`03`](03_型III_特殊値の梯子.md)）・型Ⅳ（[`04`](04_型IV_一般超越.md)）と対照的。

## 参考文献
Kronecker; Lehmer (1933); Smyth (1971) *On the product of conjugates outside the unit circle*; Salem; Lieb (1967) PR 162（square ice）; Baxter (1980) J. Phys. A 13, L61（hard hexagon）; Duminil-Copin–Smirnov (2012) Ann. Math. 175（arXiv:1007.0575, 六角 SAW）; Feit–Fine (1960) Duke 27; Frobenius (1896); Mednykh; Hausel–Rodriguez-Villegas (2008) Invent. 174; Florentino–Lawton (2014)（arXiv:1301.7616）.
