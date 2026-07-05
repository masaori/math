# 00 Mahler 測度と正則子

## Mahler 測度の定義

$n\in\mathbb{N}_{>0}$、$P\in\mathbb{C}[x_1^{\pm1},\dots,x_n^{\pm1}]$（$0$ でない Laurent 多項式）に対し、**（対数）Mahler 測度**を
$$
m(P):=\int_{\mathbb{T}^n}\log|P(x_1,\dots,x_n)|\,d\mu(x_1)\cdots d\mu(x_n)\in\mathbb{R}
$$
で定める。ここで $\mathbb{T}=\{x\in\mathbb{C}:|x|=1\}$（単位円周）、$d\mu=\frac{d\theta}{2\pi}$（$x=e^{i\theta}$ の正規化 Haar 測度、$\int_{\mathbb{T}}d\mu=1$）。積分は $\log|P|$ が可積分（$P$ の零点が $\mathbb{T}^n$ 上で測度 0）ゆえ収束。**Mahler 測度**（乗法版）は $M(P):=\exp(m(P))\in\mathbb{R}_{>0}$。

**住処の注意**: 被積分関数 $\log|P|$ は $\mathbb{R}$ 値、積分は $\mathbb{R}/\mathbb{C}$（非可算・連続極限）を本質的に使う。$m(P)$ は一般に超越数で、可算な代数的データからは初等的に書けない——これが「解析的閉形式か否か」の問題の源（R-Λ 双対 §8.5 定義 Y）。

## 1 変数：Jensen 公式

$n=1$、$P(x)=a_d\prod_{i=1}^d(x-\alpha_i)\in\mathbb{C}[x]$（$a_d\ne0$, $\alpha_i\in\mathbb{C}$）に対し Jensen 公式より
$$
m(P)=\log|a_d|+\sum_{i=1}^d\log^+|\alpha_i|,\qquad \log^+t:=\max(0,\log t).
$$
*導出*: $\int_{\mathbb{T}}\log|x-\alpha|\,d\mu=\log^+|\alpha|$（Jensen）を各因子に適用。すなわち 1 変数では Mahler 測度は**単位円外の根の対数の和**で、代数的データから閉形式で書ける（$\mathbb{R}$ 脱出は $\log$ 一つ）。多変数で初めて非自明になる。

## Lehmer 問題と Kronecker の定理

**Kronecker (1857)**: $P\in\mathbb{Z}[x]$ monic に対し $m(P)=0\iff P$ は円分多項式と単項式 $x$ の積。すなわち整数多項式で $M(P)=1$ となるのは全根が単位根または $0$ のときに限る。

**Lehmer 問題 (1933, 未解決)**: $\inf\{M(P)>1:P\in\mathbb{Z}[x]\}>1$ か（$1$ から離れているか）。現在知られる最小値の候補は **Lehmer 多項式**
$$
L(x)=x^{10}+x^9-x^7-x^6-x^5-x^4-x^3+x+1,\quad M(L)\approx1.17628\ldots
$$
これより小さい $M(P)>1$ は未発見。Lehmer 問題は数論的高さ・$K$ 理論とも結ぶ深い未解決問題。

## 多変数：Smyth の最初の評価（$\to$ Dirichlet $L$ 値）

**Smyth (1981)**: 単位円外根の和という 1 変数の描像は多変数で壊れ、$L$ 函数が現れる。
$$
m(1+x+y)=\frac{3\sqrt3}{4\pi}L(\chi_{-3},2)=L'(\chi_{-3},-1),
$$
$$
m(1+x+y+z)=\frac{7}{2\pi^2}\zeta(3).
$$
ここで $\chi_{-3}$ は法 $3$ の非自明（奇）Dirichlet 指標（$\chi_{-3}(1)=1,\chi_{-3}(2)=-1$）、$L(\chi_{-3},s)=\sum_{k\ge1}\chi_{-3}(k)k^{-s}$、$\zeta$ は Riemann ゼータ。等号 $L(\chi_{-3},2)$ と $L'(\chi_{-3},-1)$ は函数等式による。

**含意**: $m(1+x+y)$ は「単なる積分値」ではなく **Dirichlet $L$ 函数の特殊値**という数論的に意味のある量。零点集合 $\{1+x+y=0\}$（有理曲線, 種数 0）に対応する $L$ 函数（この場合 Dirichlet 指標の $L$）が現れる。曲線の種数が上がると（次ファイル 02）楕円曲線の $L$ 函数になる。

## 正則子（regulator）写像——なぜ $L$ 値が出るか

Mahler 測度が $L$ 値になる機構は**正則子**である。核は次の書き換え（$n=2$ の場合）。

$P\in\mathbb{Z}[x^{\pm},y^{\pm}]$、曲線 $C=\{P=0\}$（滑らかとする, $\mathbb{Q}$ 上定義）。Jensen 公式の 2 変数版（$y$ について先に積分）で
$$
m(P)=\frac1{2\pi}\int_{\gamma}\eta(x,y),\qquad \gamma=\{(x,y)\in C:|x|=1,\ |y|\ge1\}\subset C(\mathbb{C}),
$$
$$
\eta(x,y):=\log|x|\,d\arg y-\log|y|\,d\arg x
$$
（$\eta$ は $C(\mathbb{C})$ 上の実 1 次微分形式で、$d\eta=\mathrm{Im}(\tfrac{dx}{x}\wedge\tfrac{dy}{y})$）。この $\eta(x,y)$ は**関数対 $\{x,y\}$ に付随する正則子形式**であり、$\{x,y\}$ は曲線 $C$ の **$K_2$（Milnor $K$ 群）の元**を定める（$x,y\in\mathbb{Q}(C)^\times$ が生成する記号）。

$$
\boxed{\ m(P)=\frac1{2\pi}\langle \mathrm{reg}\{x,y\},[\gamma]\rangle\ }
$$
——Mahler 測度 ＝ **$K_2(C)$ の記号 $\{x,y\}$ の正則子 $\mathrm{reg}$ を、境界サイクル $[\gamma]$ に対して評価した値**。

正則子 $\mathrm{reg}:K_2(C)\to H^1(C(\mathbb{C}),\mathbb{R})$（Beilinson–Bloch 正則子）は動機的コホモロジー $H^2_{\mathcal M}(C,\mathbb{Q}(2))$ から Deligne コホモロジーへの写像。**Beilinson 予想**（次ファイル）が「この正則子の値 ＝ $C$ の $L$ 函数の特殊値（有理数倍）」を主張するため、$m(P)$ が $L$ 値になる。Smyth の $L(\chi_{-3},2)$ は種数 0 での、Boyd の $L'(E,0)$ は種数 1 での実現。

## まとめ

- $m(P)=\int_{\mathbb{T}^n}\log|P|$、$\mathbb{R}$ 値、$\mathbb{R}/\mathbb{C}$ を本質的に使う。
- 1 変数：Jensen で閉形式（単位円外根の対数和）。
- 多変数：正則子 $\mathrm{reg}\{x_1,\dots\}$ の値として書け、Beilinson 予想で $L$ 特殊値に一致。Smyth（種数 0 $\to$ Dirichlet $L$）が最初の例。
