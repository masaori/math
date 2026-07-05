# 01 Beilinson 予想（正則子 ＝ $L$ 特殊値）

Mahler 測度が $L$ 値になる根拠。Beilinson 予想の一般形と、必要な特殊例（Borel, Bloch）をまとめる。

## 動機的コホモロジーと正則子

$X$ を $\mathbb{Q}$ 上の滑らかな射影多様体、$i,n\in\mathbb{Z}$。以下の二つのコホモロジーがある。

- **動機的コホモロジー** $H^{i+1}_{\mathcal M}(X,\mathbb{Q}(n))$（$\mathbb{Q}$ ベクトル空間）。代数的 $K$ 理論の重み付き部分 $\cong (K_{2n-i-1}(X)\otimes\mathbb{Q})^{(n)}$。**可算的・代数的**な対象（記号・$K$ 群の元）。
- **Deligne コホモロジー** $H^{i+1}_{\mathcal D}(X_{/\mathbb{R}},\mathbb{R}(n))$（$\mathbb{R}$ ベクトル空間）。解析的・**非可算**（微分形式・積分）。

両者を結ぶのが **Beilinson 正則子**
$$
\mathrm{reg}:H^{i+1}_{\mathcal M}(X,\mathbb{Q}(n))\longrightarrow H^{i+1}_{\mathcal D}(X_{/\mathbb{R}},\mathbb{R}(n)).
$$
これは代数的（可算）データを解析的（$\mathbb{R}$）不変量へ送る写像で、**「可算 $\to$ $\mathbb{R}$ 脱出」の数論的な正体**（R-Λ 双対の $\rho$ に相当する一般化）。

## Beilinson 予想（一般形, 予想）

$L(h^i(X),s)$ を $X$ の $i$ 次モチーフの $L$ 函数（Euler 積 $\prod_p L_p$、各 $L_p$ は $H^i_{\text{ét}}(X,\mathbb{Q}_\ell)$ 上の Frobenius 固有多項式から）とする。$n$ を**非臨界**な整数（$n>\frac{i}{2}+1$）とする。

**予想 (Beilinson 1985)**:
1. $\dim_{\mathbb{Q}}H^{i+1}_{\mathcal M}(X_{\mathbb{Z}},\mathbb{Q}(n))_{\mathbb{Z}}=\mathrm{ord}_{s=n}L(h^i(X),s)$ の反対側の値 ＝ 函数等式で移した $s=i+1-n$ での零位。
2. 正則子 $\mathrm{reg}$ は像の $\mathbb{R}$ 格子（Deligne コホモロジー内の $\mathbb{Q}$ 構造）と両立し、その**行列式（determinant, 高次正則子）**が
$$
L^*(h^i(X),n)\equiv \det(\mathrm{reg})\pmod{\mathbb{Q}^\times}
$$
（$L^*$ は主要係数）を与える。すなわち **$L$ 特殊値 ＝ 正則子行列式（有理数倍を除く）**。

ここで $H^{i+1}_{\mathcal M}(X_{\mathbb{Z}},\mathbb{Q}(n))_{\mathbb{Z}}$ は整モデル $X_{\mathbb{Z}}$ 上で「積分的」な部分（正しい格子を取るための整構造）。$\pmod{\mathbb{Q}^\times}$ は有理数倍の不定性。

**状態**: 一般には**予想**。次の特殊例のみ定理。

## 特殊例 1：Borel（数体の $\zeta$/Dedekind $\zeta$）

$X=\mathrm{Spec}\,F$（$F$ 数体, $i=0$）。$K_{2n-1}(F)\otimes\mathbb{Q}$（$n\ge2$）の **Borel 正則子** $\mathrm{reg}_B:K_{2n-1}(F)\to\mathbb{R}^{d_n}$ の共体積が Dedekind ゼータの特殊値を与える：
$$
\zeta_F(n)\sim_{\mathbb{Q}^\times}\pi^{?}\cdot\det(\mathrm{reg}_B)\quad(n\ge2).
$$
**定理（Borel 1977）**。$F=\mathbb{Q}$ で $\zeta(n)$（$n$ 奇 $\ge3$）が Borel 正則子で表される。Beilinson 予想の最初の確立例で、$K$ 理論の正則子が $\zeta$ 特殊値を出す原型。

## 特殊例 2：Bloch–Beilinson（楕円曲線の $K_2$）

$X=E$（$\mathbb{Q}$ 上の楕円曲線, $i=1$, $n=2$）。関与するのは $K_2(E)\otimes\mathbb{Q}\cong H^2_{\mathcal M}(E,\mathbb{Q}(2))$。正則子
$$
\mathrm{reg}:K_2(E)\longrightarrow H^1(E(\mathbb{C}),\mathbb{R})\cong\mathbb{R}
$$
（実 1 次元、$E(\mathbb{C})$ の実サイクルへの積分）。**予想（Bloch–Beilinson）**: 整な元 $\xi\in K_2(E)_{\mathbb{Z}}$ に対し
$$
\mathrm{reg}(\xi)\equiv r\cdot L'(E,0)\pmod{\mathbb{Q}^\times},\qquad r\in\mathbb{Q},
$$
函数等式で $L(E,2)\sim_{\mathbb{Q}^\times}\frac{(2\pi)^2}{\text{（周期）}}L'(E,0)$。**この予想が Boyd の Mahler 測度公式の背後**（ファイル 02）。$K_2(E)$ の元 $\{x,y\}$（曲線 $C\cong E$ 上の関数対）の正則子が、まさに Mahler 測度 $m(P)$ の $\frac1{2\pi}\int_\gamma\eta$ 表示（ファイル 00）と一致する。

**状態**: 一般には予想。特定の $E$・特定の記号で **Rogers–Zudilin ほかが証明**（02）。

## 正則子の明示核：ダイログ函数

正則子 $\mathrm{reg}\{x,y\}$ の被積分核は**（楕円）ダイログ**で書ける。

- 種数 0（$\mathbb{G}_m$ 上）: Bloch–Wigner ダイログ
$$
D(z)=\mathrm{Im}\,\mathrm{Li}_2(z)+\arg(1-z)\log|z|,\quad \mathrm{Li}_2(z)=\sum_{k\ge1}\frac{z^k}{k^2}.
$$
$D:\mathbb{C}\to\mathbb{R}$ は実解析的、$\mathrm{Li}_2$ の単一値化。Smyth の $L(\chi_{-3},2)$ は $D$ の特殊点値の和として出る。
- 種数 1（楕円曲線 $E$ 上）: **楕円ダイログ** $D_E(z)=\sum_{k\in\mathbb{Z}}D(q^k z)$（$q$＝$E$ の $\mathbb{C}^\times/q^{\mathbb{Z}}$ 表示のパラメータ）。$L'(E,0)$ は $D_E$ の記号 $\{x,y\}$ の台での値の重み付き和（Beilinson–Levin）。

これらダイログは $\mathbb{R}$ 値の超越函数で、**$\mathbb{R}$ 脱出の具体的な担い手**。可算な記号 $\{x,y\}$（$K_2$）を $\mathbb{R}$ 値へ送る正則子の明示公式が、まさにダイログの特殊値。

## まとめ（この理論が主張すること）

- 動機的コホモロジー（可算・代数的な $K$ 群）$\xrightarrow{\ \mathrm{reg}\ }$ Deligne コホモロジー（$\mathbb{R}$）。
- Beilinson 予想：正則子行列式 ＝ $L$ 函数の非臨界特殊値（$\bmod\ \mathbb{Q}^\times$）。
- Borel（数体, $\zeta$）と一部の楕円曲線（$K_2$, $L'(E,0)$）で定理、一般は予想。
- 正則子の核はダイログ（種数 0）・楕円ダイログ（種数 1）で、これが Mahler 測度＝$L$ 値の明示的橋（02）。
