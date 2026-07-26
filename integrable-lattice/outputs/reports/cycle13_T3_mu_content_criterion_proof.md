# cycle 13 / T3 Pure: 判定式 $(★)$ $(☆)$ の証明

対象: cycle 12 T3（`sagemath/check/cycle12_T3_nonzero_mu_p/`）で**数値照合のみ**だった 2 つの主張

- $(★)$ $\;\kappa(X_N)=\dfrac{\kappa(X)}{N}\displaystyle\prod_{\zeta^N=1,\ \zeta\neq1}\det L(\zeta)$
- $(☆)$ $\;\mu_\ell=v_\ell\bigl(\mathrm{content}_z(\det L(z))\bigr)$

を証明する。前提知識として cycle 13 step 1 の文献調査 `cycle13_T1_padic_entropy_generality.md`（とくに §3.4 Ueki の $\mathrm{M}_p$、§3.5 McGown–Vallières III Theorem 6.1 / DuBose–Vallières Theorem A）を踏まえる。

---

## 0. 結論（先に置く）

| 主張 | 状態 |
|---|---|
| $(★)$ | **証明した**（§4 定理 1）。しかも cycle 12 README が課していた「$X_N$ が連結なら」という仮定は不要で、**全ての有限多重グラフ $X$ と全ての $N\ge1$ で成立する**（両辺が $0$ になる形で退化ケースを含む）。 |
| $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+\lambda n+\nu$（岩澤型漸近） | **既知理論に依拠せず、本レポートで証明した**（§6 定理 2）。cycle 12 README の「§5 証明していないこと」に挙がっていた項目が消える。仮定は「$X$ 連結、かつ $X_\ell$ が連結」のみ。$\chi(X)\neq0$ は**不要**（§6.6）。 |
| $(☆)$ | **証明した**（§7 定理 3）。$\mu_\ell=v_\ell(\mathrm{content}_z\det L(z))$、および $\lambda=\lambda_{\mathrm W}-1$（$\lambda_{\mathrm W}$ は $\det L(1+T)$ の Weierstrass 次数）。 |
| $(☆)$ の新規性 | **主張しない。既知の言い換えである。** §8 に理由を書く。McGown–Vallières III Theorem 6.1 が「$\mu=\min_j v_\ell(c_j)$」を述べており、$\mu$ は漸近式から一意に決まるので両者は同じ量である。本レポートの寄与は**本プロジェクトの記法で完全な証明を与えたこと**だけであって、新しい数学的結果ではない。 |
| 適用範囲外 | $\ell\nmid N$ の段（$\mathbb{Z}/N$-被覆で $N$ が $\ell$ と素）は content で支配され**ない**。反例 witness を §9.4 に置く。 |

**証明できなかったこと・未確認のこと**は §10 に分離して書いた。

---

## 1. 設定（記号をすべて明示する）

以下、$\mathbb{Z}$ は有理整数環、$\ell$ は素数とする。

### 1.1 底グラフと voltage

- $X$: **有限多重グラフ**。頂点集合 $V=\{1,\dots,m\}$（$m\ge1$）、辺の有限重複集合 $E$。多重辺・ループを許す。
- 各辺 $e\in E$ に**向きを固定**し、始点 $o(e)\in V$・終点 $t(e)\in V$ を定める（ループは $o(e)=t(e)$）。
- **voltage 割り当て** $\alpha: E\to\mathbb{Z}$。$e$ の voltage を $\alpha_e$ と書く。
- 辺 $e$ を $(o(e),t(e),\alpha_e)$ と表記する。

向きの取り方は結果に影響しない（$e$ の向きを反転して $\alpha_e\mapsto-\alpha_e$ とすると、以下の $L(z)$ は不変）。

### 1.2 導来グラフ

$N\in\mathbb{Z}_{\ge1}$ に対し、**導来グラフ** $X_N$ を次で定める。

- 頂点集合 $V\times(\mathbb{Z}/N)$。
- 各辺 $e=(u,v,\alpha)\in E$ と各 $i\in\mathbb{Z}/N$ に対し、$(u,i)$ と $(v,i+\alpha\bmod N)$ を結ぶ辺 $e_i$ を 1 本置く。

$X_N$ は $mN$ 頂点・$|E|\cdot N$ 辺の有限多重グラフである（$u=v$ かつ $\alpha\equiv0\pmod N$ のときに限り $e_i$ はループ）。$X_1=X$。

$N=\ell^n$（$n=0,1,2,\dots$）の列を **abelian $\ell$-tower** と呼び、$\kappa_n:=\kappa(X_{\ell^n})$ と書く。

### 1.3 ラプラシアン

有限多重グラフ $G$（ループ可）に対し、$G$ の**ラプラシアン** $L_G$ を

$$(L_G)_{xy}=\begin{cases}\#\{\text{$x$ に接続するループでない辺の端}\} & (x=y)\\[2pt] -\#\{\text{$x$ と $y$ を結ぶ辺}\} & (x\neq y)\end{cases}$$

で定める。すなわちループは $L_G$ に寄与しない。同値な言い方として、任意の $v\in\mathbb{C}^{V(G)}$ に対し

$$(L_Gv)(x)=\sum_{\substack{\text{$x$ に接続する}\\ \text{辺の端 }(e,x)}}\bigl(v(x)-v(x'_e)\bigr) \tag{1.1}$$

（$x'_e$ は $e$ の $x$ と反対側の端点。ループなら $x'_e=x$ で項は $0$）。この形を以下で使う。

### 1.4 voltage ラプラシアン

$\mathbb{Z}[z,z^{-1}]$ 係数の $m\times m$ 行列 $L(z)$ を、各辺 $e=(u,v,\alpha)\in E$ の寄与を足し上げて定める。

- $u\neq v$ のとき: $L_{uu}\mathrel{+}=1$, $L_{vv}\mathrel{+}=1$, $L_{uv}\mathrel{-}=z^{\alpha}$, $L_{vu}\mathrel{-}=z^{-\alpha}$。
- $u=v$（ループ）のとき: $L_{uu}\mathrel{+}=2-z^{\alpha}-z^{-\alpha}$。

$D(z):=\det L(z)\in\mathbb{Z}[z,z^{-1}]$ と置く。$L(1)=L_X$（$X$ 自身のラプラシアン）であることは定義から直ちに従う（ループの寄与 $2-1-1=0$）。

### 1.5 content と付値

$0\neq F=\sum_{a\in\mathbb{Z}}f_a z^a\in\mathbb{Z}[z,z^{-1}]$ に対し $\mathrm{content}_z(F):=\gcd\{f_a\}\in\mathbb{Z}_{>0}$。
$v_\ell$ は $\mathbb{Q}$ 上の $\ell$ 進付値（$v_\ell(\ell)=1$）を、代数閉包 $\overline{\mathbb{Q}}_\ell$ および完備化 $\mathbb{C}_\ell$ 上へ一意に延長したもの。$\mathcal{O}_{\mathbb{C}_\ell}=\{x: v_\ell(x)\ge0\}$、$\mathfrak{m}=\{x:v_\ell(x)>0\}$。

$\kappa(G)$ は $G$ の全域木の個数（$G$ が非連結なら $0$、$G$ が 1 頂点なら $1$）。

---

## 2. 使う既知定理と、その適用条件

以下の 3 つだけを外部から使う。**毎回、適用条件を満たすことを確認してから使う。**

### 定理 K（Kirchhoff の matrix-tree 定理）

*$G$ を $n\ge1$ 頂点の有限多重グラフ（ループ可）とする。$L_G$ の任意の 1 行 1 列（同じ番号）を除いた $(n-1)\times(n-1)$ 小行列式は、除いた番号によらず $\kappa(G)$ に等しい。*

（標準。R. Stanley, *Enumerative Combinatorics* vol. 2, Theorem 5.6.8 など。多重辺は行列成分の重複度、ループは $L_G$ に寄与しないので全域木に現れないことと整合する。）

**系 K′（固有値版）**: 上と同じ $G$ について、$L_G$ の固有値を $\lambda_1,\dots,\lambda_n$（重複込み）とすると

$$\prod_{i=1}^{n}\bigl(x-\lambda_i\bigr)\ \text{の}\ x^1\ \text{の係数}\ =\ (-1)^{n-1}\,n\,\kappa(G). \tag{2.1}$$

*証明*: $\det(xI-L_G)$ の $x^1$ の係数は、$(-1)^{n-1}\times$（$L_G$ の全ての $(n-1)$ 次主小行列式の和）である（行列式の多重線形展開の標準事実）。定理 K よりその和は $n\,\kappa(G)$。左辺の固有値表示から同じ係数は $(-1)^{n-1}\sum_{i}\prod_{j\neq i}\lambda_j$。よって

$$\sum_{i=1}^n\prod_{j\neq i}\lambda_j=n\,\kappa(G). \tag{2.2}$$

$L_G$ は半正定値対称で、全 $1$ ベクトルが核に入るので $\lambda_1=0$ とできる。このとき $(2.2)$ の左辺は $\prod_{j\ge2}\lambda_j$ に等しい（$i\ge2$ の項は因子 $\lambda_1=0$ を含む）。ゆえに

$$\prod_{j=2}^{n}\lambda_j=n\,\kappa(G).\qquad\blacksquare \tag{2.3}$$

（$G$ が非連結なら $\lambda_2=0$ でもあり、両辺 $0$。整合している。）

### 定理 W（$\ell$ 進 Weierstrass 準備定理）

*$\Lambda=\mathbb{Z}_\ell[[T]]$ とする。$0\neq f=\sum_{j\ge0}c_jT^j\in\Lambda$ に対し $\mu:=\min_j v_\ell(c_j)<\infty$ と置く。このとき*

$$f=\ell^{\mu}\,g(T)\,U(T),\qquad g\ \text{は distinguished 多項式},\quad U\in\Lambda^{\times}$$

*と一意に書ける。ここで distinguished とは $g(T)=T^{d}+b_{d-1}T^{d-1}+\dots+b_0$、$b_i\in\ell\mathbb{Z}_\ell$ のこと。さらに*

$$\lambda_{\mathrm W}:=\deg g=\min\{j: v_\ell(c_j)=\mu\}. \tag{2.4}$$

**適用条件**: $\Lambda$ が完備局所ネーター環で $\ell$ が極大イデアルに属すること、および $f\neq0$。以下で使うときは毎回 $f\neq0$ を確認する。

（本体は L. Washington, *Introduction to Cyclotomic Fields* 2nd ed., Theorem 7.3。$(2.4)$ は次で確認できる: $f_1:=\ell^{-\mu}f\in\Lambda\smallsetminus\ell\Lambda$ で $f_1=gU$。$\Lambda/\ell\Lambda=\mathbb{F}_\ell[[T]]$ で $\bar g=T^{d}$、$\bar U$ は単元だから $\bar f_1=T^{d}\bar U$、よって $d=\mathrm{ord}_T(\bar f_1)=\min\{j:\ell\nmid c_j/\ell^{\mu}\}=\min\{j:v_\ell(c_j)=\mu\}$。）

**補足 W′**: $\Lambda/\ell\Lambda=\mathbb{F}_\ell[[T]]$ は整域なので、$\mu(\cdot):=\min_j v_\ell(c_j)$ は $\Lambda\smallsetminus\{0\}$ 上の**付値**である:

$$\mu(f_1f_2)=\mu(f_1)+\mu(f_2),\qquad \mu(U)=0\ \ (U\in\Lambda^{\times}). \tag{2.5}$$

*証明*: $\ell^{-\mu(f_i)}f_i\notin\ell\Lambda$ で、$\mathbb{F}_\ell[[T]]$ が整域だから積も $\ell\Lambda$ に入らない。$\blacksquare$

### 定理 C（円分の初等的事実）

$N\ge2$ に対し $\dfrac{z^N-1}{z-1}=\prod_{\zeta^N=1,\zeta\neq1}(z-\zeta)$ を $z=1$ で評価して

$$\prod_{\zeta^N=1,\ \zeta\neq1}(1-\zeta)=N. \tag{2.6}$$

とくに $N=\ell^n$ で両辺の $v_\ell$ を取り

$$\sum_{\zeta^{\ell^n}=1,\ \zeta\neq1}v_\ell(\zeta-1)=n. \tag{2.7}$$

（$v_\ell(-1)=0$ なので符号は効かない。分岐理論は不要。）

---

## 3. 補題 A・B・C（対角化・連結性）

### 補題 A（離散 Fourier によるブロック対角化）

*任意の有限 voltage 多重グラフ $(X,\alpha)$ と $N\ge1$ に対し、$\mathbb{C}$ 上の線形写像として*

$$L_{X_N}\ \cong\ \bigoplus_{\zeta^N=1} L(\zeta).$$

*すなわち $L_{X_N}$ の固有値の重複集合は、$N$ 個の $m\times m$ 行列 $L(\zeta)$（$\zeta$ は全ての $N$ 乗根）の固有値の重複集合の合併である。とくに*

$$\det\bigl(xI-L_{X_N}\bigr)=\prod_{\zeta^N=1}\det\bigl(xI_m-L(\zeta)\bigr). \tag{3.1}$$

**証明.** $\zeta^N=1$ と $x\in\mathbb{C}^{V}$ に対し、$v_{\zeta,x}\in\mathbb{C}^{V\times(\mathbb{Z}/N)}$ を

$$v_{\zeta,x}(u,i):=\zeta^{\,i}x_u$$

で定める（$\zeta^N=1$ なので $i\in\mathbb{Z}/N$ に関して well-defined）。$(1.1)$ で $L_{X_N}$ を計算する。頂点 $(u,i)$ に接続する $X_N$ の辺の端は、$X$ の辺ごとに次の 3 種で尽くされる。

1. $e=(u,v,\alpha)\in E$、$u\neq v$: 辺 $e_i$ が $(u,i)$—$(v,i+\alpha)$。寄与は $v_{\zeta,x}(u,i)-v_{\zeta,x}(v,i+\alpha)=\zeta^i\bigl(x_u-\zeta^{\alpha}x_v\bigr)$。
2. $e=(v,u,\alpha)\in E$、$u\neq v$: 辺 $e_{i-\alpha}$ が $(v,i-\alpha)$—$(u,i)$。寄与は $\zeta^i\bigl(x_u-\zeta^{-\alpha}x_v\bigr)$。
3. $e=(u,u,\alpha)\in E$: 辺 $e_i$（$(u,i)$—$(u,i+\alpha)$）と辺 $e_{i-\alpha}$（$(u,i-\alpha)$—$(u,i)$）の 2 つの端。寄与の和は $\zeta^i x_u\bigl(2-\zeta^{\alpha}-\zeta^{-\alpha}\bigr)$。（$\alpha\equiv0\bmod N$ ならこれらはループで寄与 $0$、右辺も $\zeta^{\alpha}=1$ より $0$。一致する。）

これらは §1.4 の $L(z)$ の定義の各項に $z=\zeta$ を代入したものと項ごとに一致する。したがって

$$\bigl(L_{X_N}v_{\zeta,x}\bigr)(u,i)=\zeta^{\,i}\bigl(L(\zeta)x\bigr)_u,\qquad\text{すなわち}\quad L_{X_N}\,v_{\zeta,x}=v_{\zeta,\,L(\zeta)x}. \tag{3.2}$$

$W_\zeta:=\{v_{\zeta,x}: x\in\mathbb{C}^V\}$ は $\dim_{\mathbb{C}}W_\zeta=m$（$x\mapsto v_{\zeta,x}$ は単射）で、$(3.2)$ より $L_{X_N}$ 不変であり、その上で $L_{X_N}$ は $L(\zeta)$ と同型な作用をする。

$\mathbb{C}^{V\times(\mathbb{Z}/N)}=\bigoplus_{\zeta^N=1}W_\zeta$ を示す。両辺の次元はともに $mN$ なので、和が全体を張ることを見ればよい。固定した $u$ について、$\{(\zeta^{\,i})_{i\in\mathbb{Z}/N}: \zeta^N=1\}$ は $\mathbb{C}^{\mathbb{Z}/N}$ の基底である（Vandermonde 行列 $(\zeta_N^{jk})_{j,k}$ が可逆、$\zeta_N$ は原始 $N$ 乗根）。よって $u$ を固定した $mN$ 次元空間の $\mathbb{C}^{\mathbb{Z}/N}$ 成分がこれらで張られ、$u$ を動かして全体を張る。$\blacksquare$

> **機械検証**: `proof_steps.sage` Step 1。明示例 12 件＋乱択 40 件、$N=1,\dots,6$、計 312 件で $(3.1)$ を $\mathbb{Q}(\zeta_N)[x]$ 上の厳密等式として照合、不一致 0 件。

### 補題 B（連結成分数の分解）

*$c(G)$ を $G$ の連結成分数とすると、任意の $(X,\alpha)$, $N\ge1$ に対し*

$$c(X_N)=\sum_{\zeta^N=1}\dim_{\mathbb{C}}\ker L(\zeta). \tag{3.3}$$

**証明.** 有限多重グラフ $G$ について $\dim_{\mathbb{C}}\ker L_G=c(G)$ は標準（$L_G$ は半正定値対称で、$(1.1)$ より $\langle L_Gv,v\rangle=\sum_{e\ \text{非ループ}}|v(o(e))-v(t(e))|^2$。これが $0$ ⟺ $v$ が各連結成分上で定数。よって核は成分の指示関数が張る $c(G)$ 次元空間）。これを $G=X_N$ に適用し、補題 A の直和分解で核も分解することから $(3.3)$ を得る。$\blacksquare$

**系 B′.** *$X$ が連結なら $\ker L(1)=\ker L_X$ は $1$ 次元なので*

$$X_N\ \text{が連結}\iff \det L(\zeta)\neq0\ \ \text{(全ての $\zeta^N=1$, $\zeta\neq1$)}. \tag{3.4}$$

*$X$ が非連結なら $c(X_N)\ge c(X)\ge2$ で $X_N$ も非連結。*

> **機械検証**: Step 2、$N=1,\dots,8$、計 416 件、不一致 0 件。

### 補題 C（連結性の gcd 判定 — 退化ケースの決定手続き）

*$X$ を連結とし、全域木 $T\subseteq E$ を 1 つ固定する。$T$ 上の potential $h:V\to\mathbb{Z}$ を、$h(v_0)=0$（$v_0$ は基点）と「$T$ の辺 $(u,v,\alpha)$ について $h(v)=h(u)+\alpha$」で定める（$T$ が木なので一意に定まる）。非木辺 $e=(u,v,\alpha)$ の**基本閉路 voltage** を $\beta_e:=\alpha+h(u)-h(v)$ とし、$g_X:=\gcd\{\beta_e: e\in E\smallsetminus T\}\ \ (\ge0)$ と置く。このとき*

$$X_N\ \text{が連結}\iff \gcd(N,g_X)=1. \tag{3.5}$$

**証明.** $X_N$ の頂点 $(v,i)$ に対し $\phi(v,i):=i-h(v)\in\mathbb{Z}/N$ と置く。$X_N$ の辺 $e_i$（$e=(u,v,\alpha)$）は $(u,i)$ と $(v,i+\alpha)$ を結び、
$\phi(v,i+\alpha)-\phi(u,i)=(i+\alpha-h(v))-(i-h(u))=\beta_e\bmod N$。
とくに $e\in T$ なら $\beta_e=0$ で $\phi$ は保たれる。

$H:=\langle \beta_e \bmod N: e\notin T\rangle\subseteq\mathbb{Z}/N$ と置く。$X_N$ の任意の辺は $\phi$ を $H$ の元だけずらすので、$\phi$ の $H$-剰余類 $\phi\bmod H$ は各連結成分上で一定である。よって $c(X_N)\ge[\mathbb{Z}/N:H]$。

逆に、$T$ の辺は $\phi$ を保つので、$T$ が $V$ を張ることから $\phi$ が同じ値をもつ頂点どうしは連結（$\{(v,i):\phi(v,i)=c\}$ は $T$ の持ち上げで木をなす）。さらに非木辺 $e$ を使って $\phi$ の値を $\beta_e$ だけ動かせるので、$\phi$ の値が同じ $H$-剰余類に属する頂点はすべて連結。ゆえに $c(X_N)=[\mathbb{Z}/N:H]$。

$H=\langle g_X\bmod N\rangle$ であり、$\mathbb{Z}/N$ において $\langle g_X\rangle=\mathbb{Z}/N\iff\gcd(N,g_X)=1$。$\blacksquare$

**系 C′（$\ell$-塔の all-or-nothing）.** *$X$ 連結のとき、$\ell$-塔の各段について*

$$\text{ある } n\ge1 \text{ で } X_{\ell^n} \text{ 連結}\iff \ell\nmid g_X\iff \text{全ての } n\ge0 \text{ で } X_{\ell^n} \text{ 連結}. $$

*証明*: $\gcd(\ell^n,g_X)=1\iff\ell\nmid g_X$ で、$n\ge1$ に依らない。$\blacksquare$

> **機械検証**: Step 3、$N=1,\dots,12$、計 552 件、不一致 0 件。

---

## 4. 定理 1 $=(★)$

> **定理 1.** *$(X,\alpha)$ を任意の有限 voltage 多重グラフ、$N\ge1$ を任意とする。$D(z)=\det L(z)$ とすると $\mathbb{Z}$ における等式*
> $$N\cdot\kappa(X_N)\;=\;\kappa(X)\cdot\prod_{\zeta^N=1,\ \zeta\neq1}D(\zeta) \tag{4.1}$$
> *が成り立つ。とくに $X_N$ が連結なら $\kappa(X_N)=\dfrac{\kappa(X)}{N}\prod_{\zeta\neq1}D(\zeta)$ で、これが $(★)$ である。*

**証明.** 3 つの場合に分ける。

**(i) $X$ が非連結の場合.** $\kappa(X)=0$、また補題 B の系 B′ より $X_N$ も非連結で $\kappa(X_N)=0$。$(4.1)$ は $0=0$。

**(ii) $X$ 連結、かつある $\zeta_0^N=1$, $\zeta_0\neq1$ で $D(\zeta_0)=0$ の場合.** 右辺は $0$。系 B′ $(3.4)$ より $X_N$ は非連結なので $\kappa(X_N)=0$、左辺も $0$。

**(iii) $X$ 連結、かつ全ての $\zeta\neq1$ で $D(\zeta)\neq0$ の場合.** このとき系 B′ より $X_N$ は連結である。

$L_{X_N}$ は $mN$ 次の実対称半正定値行列で、その固有値を $0=\Lambda_1\le\Lambda_2\le\dots\le\Lambda_{mN}$ とする。$X_N$ 連結より $\Lambda_2>0$。系 K′ $(2.3)$ を $G=X_N$（$n=mN$ 頂点）に適用して（適用条件: $X_N$ は有限多重グラフ ✓）

$$\prod_{j=2}^{mN}\Lambda_j=mN\cdot\kappa(X_N). \tag{4.2}$$

補題 A より、$L_{X_N}$ の固有値の重複集合は $\bigsqcup_{\zeta^N=1}\mathrm{Spec}\,L(\zeta)$ である。$\zeta=1$ の成分は $L(1)=L_X$ で、$X$ 連結だからその固有値は $0=\lambda_1<\lambda_2\le\dots\le\lambda_m$。$\zeta\neq1$ の成分は仮定より $\det L(\zeta)\neq0$、すなわち固有値はすべて非零。よって $L_{X_N}$ の固有値のうち $0$ は $L_X$ 由来の $\lambda_1$ ただ 1 つであり、

$$\prod_{j=2}^{mN}\Lambda_j=\Bigl(\prod_{i=2}^{m}\lambda_i\Bigr)\cdot\prod_{\zeta\neq1}\det L(\zeta). \tag{4.3}$$

（$\det L(\zeta)$ はその成分の固有値の積。）再び系 K′ を $G=X$（$m$ 頂点）に適用して $\prod_{i\ge2}\lambda_i=m\,\kappa(X)$。$(4.2)$, $(4.3)$ を合わせて

$$mN\,\kappa(X_N)=m\,\kappa(X)\prod_{\zeta\neq1}D(\zeta),$$

$m\ge1$ で割って $(4.1)$ を得る。$\blacksquare$

**注 4.1（右辺が整数であること）.** $\prod_{\zeta\neq1}D(\zeta)$ は $\mathrm{Gal}(\mathbb{Q}(\zeta_N)/\mathbb{Q})$ で不変な代数的整数（整数行列の行列式の積）なので $\mathbb{Z}$ に属する。実際には終結式で
$$\prod_{\zeta^N=1,\zeta\neq1}D(\zeta)=\bigl((-1)^{N+1}\bigr)^{r}\cdot\mathrm{Res}_z\Bigl(\tfrac{z^N-1}{z-1},\,P(z)\Bigr),\qquad D(z)=z^{r}P(z),\ P\in\mathbb{Z}[z],\ P(0)\neq0$$
と**厳密計算できる**（$\frac{z^N-1}{z-1}$ はモニック、$\prod_{\zeta\neq1}\zeta=(-1)^{N+1}$）。決定可能性の観点でこの形が有用である。

**注 4.2（cycle 12 README との差分）.** README §2 は「$X_N$ が連結なら」という但し書き付きで $(★)$ を述べていたが、上の (i)(ii) により**連結性は不要**で、$(4.1)$ の形なら常に成立する。$\kappa(X)/N$ という書き方をすると (i)(ii) で $0/N$ になるだけで、内容は同じである。

> **機械検証**: Step 4。$N=1,\dots,12$、計 624 件（うち $X_N$ 非連結が 129 件＝ケース (i)(ii) を実際に通っている）、不一致 0 件。左辺は導来グラフを実際に構成して Kirchhoff 余因子で、右辺は終結式で、それぞれ独立に厳密計算した。

---

## 5. 補題 D（content の不変性）

> **補題 D.** *$0\neq D\in\mathbb{Z}[z,z^{-1}]$ とし、$D(z)=z^{r}P(z)$（$r\in\mathbb{Z}$, $P\in\mathbb{Z}[z]$, $P(0)\neq0$）と書く。$f(T):=D(1+T)\in\mathbb{Z}_\ell[[T]]$、$p(T):=P(1+T)\in\mathbb{Z}[T]$ と置く。このとき任意の素数 $\ell$ について*
> $$\mu(f)\;=\;v_\ell\bigl(\mathrm{content}_T(p)\bigr)\;=\;v_\ell\bigl(\mathrm{content}_z(D)\bigr), \tag{5.1}$$
> *ここで $\mu(f)=\min_j v_\ell(c_j)$（$f=\sum c_jT^j$）。*

**証明.** 3 段に分ける。

**(a) $f$ が well-defined で $\mu(f)=\mu(p)$ であること.** $1+T$ は $\mathbb{Z}[[T]]$ の単元（逆元 $\sum_{k\ge0}(-T)^k$）なので、$(1+T)^{r}$ は $r\in\mathbb{Z}$ のいずれの符号でも $\mathbb{Z}[[T]]\subseteq\Lambda=\mathbb{Z}_\ell[[T]]$ の単元である。$f=(1+T)^{r}\,p(T)$ であり（$D(z)=z^rP(z)$ に $z=1+T$ を代入）、補足 W′ の $(2.5)$ より $\mu(f)=\mu\bigl((1+T)^r\bigr)+\mu(p)=0+\mu(p)$。

**(b) $\mu(p)=v_\ell(\mathrm{content}_T(p))$.** $p\in\mathbb{Z}[T]$ の係数を $p_j\in\mathbb{Z}$ とすると $\mu(p)=\min_j v_\ell(p_j)=v_\ell(\gcd_j p_j)$。定義そのもの。

**(c) $\mathrm{content}_T(p)=\mathrm{content}_z(P)=\mathrm{content}_z(D)$.**
後半は $D$ と $P$ の係数の重複集合が一致することから明らか。前半: $\varphi:\mathbb{Z}[z]\to\mathbb{Z}[T]$, $Q(z)\mapsto Q(1+T)$ は環同型（逆は $T\mapsto z-1$）で、$\mathbb{Z}$ 上の代数としての同型だから、任意の $k\ge0$ と任意の整数 $M$ について

$$Q\in M\,\mathbb{Z}[z]\iff \varphi(Q)\in M\,\mathbb{Z}[T]$$

（$\varphi(M\mathbb{Z}[z])=M\varphi(\mathbb{Z}[z])=M\mathbb{Z}[T]$、$\varphi$ が全単射で $\mathbb{Z}$-線形だから）。$\mathrm{content}(Q)$ は「$Q\in M\mathbb{Z}[z]$ となる最大の $M>0$」なので、両者は一致する。$\blacksquare$

> **機械検証**: Step 5。$\det L\neq0$ の 45 件について $\mathrm{content}_z(D)=\mathrm{content}_z(P)=\mathrm{content}_T(p)$ を、さらに $\ell\in\{2,3,5,7,23\}$ について $\mu_{\text{Weierstrass}}=v_\ell(\mathrm{content})$ を照合、不一致 0 件。

---

## 6. 定理 2（岩澤型漸近そのものの証明）

cycle 12 README §5 は「$\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+\lambda n+\nu$ という漸近形そのもの」を**既知理論に依拠**（証明していない）と書いていた。ここではそれを $(★)$ と定理 W から証明する。

> **定理 2.** *$X$ を有限連結多重グラフ、$\alpha:E\to\mathbb{Z}$ を voltage、$\ell$ を素数とし、**$X_\ell$ が連結**であると仮定する（系 C′ よりこれは全ての $n\ge0$ で $X_{\ell^n}$ が連結であることと同値、また補題 C により $\ell\nmid g_X$ と同値で決定可能）。*
>
> *このとき $D(z)=\det L(z)\neq0$ であり、$f(T)=D(1+T)\in\Lambda=\mathbb{Z}_\ell[[T]]$ の定理 W による不変量を $\mu:=\mu(f)$, $\lambda_{\mathrm W}:=\deg g$ とすると、ある $n_0\ge0$ と $\nu\in\mathbb{Z}$ が存在して*
> $$\mathrm{ord}_\ell(\kappa_n)=\mu\,\ell^{n}+(\lambda_{\mathrm W}-1)\,n+\nu\qquad(n\ge n_0). \tag{6.1}$$
> *さらに $\lambda_{\mathrm W}\ge2$ なので $\lambda:=\lambda_{\mathrm W}-1\ge1$ である。*

### 6.1 準備 1: $D\neq0$ と $f$ の T 進位数

$\ell\ge2$ なので $\zeta_\ell\neq1$ なる $\ell$ 乗根が存在する。$X_\ell$ 連結と系 B′ $(3.4)$ より $D(\zeta_\ell)\neq0$、ゆえに $D\neq0$。よって定理 W の適用条件 $f\neq0$ が満たされる（$f=(1+T)^rp$、$p\neq0$）。

$s:=\mathrm{ord}_T(f)$ と置く。$f=\ell^\mu g U$、$U(0)\in\mathbb{Z}_\ell^\times$ より $s=\mathrm{ord}_T(g)$、すなわち $g(T)=T^{s}h(T)$、$h$ は distinguished で $h(0)\neq0$、$\deg h=\lambda_{\mathrm W}-s$。

**$s\ge2$ の証明**: $L(z^{-1})=L(z)^{\mathsf T}$（§1.4 の定義から成分ごとに確認: 非対角は $L_{uv}(z^{-1})=-\sum z^{-\alpha}=L_{vu}(z)$、対角は $z\leftrightarrow z^{-1}$ で不変）なので $D(z^{-1})=D(z)$。$\mathbb{Z}[z,z^{-1}]$ で微分して $-z^{-2}D'(z^{-1})=D'(z)$、$z=1$ で $D'(1)=-D'(1)$、ゆえに $D'(1)=0$。また $D(1)=\det L_X=0$（$X$ 連結なので $\mathrm{rank}\,L_X=m-1<m$）。$f(T)=D(1+T)$ より $f(0)=D(1)=0$, $f'(0)=D'(1)=0$、すなわち $s\ge2$。ゆえに $\lambda_{\mathrm W}\ge s\ge2$。

### 6.2 準備 2: 値としての Weierstrass 分解

$x\in\mathfrak{m}\subset\mathbb{C}_\ell$（$v_\ell(x)>0$）に対し、$\Lambda\to\mathcal{O}_{\mathbb{C}_\ell}$, $F\mapsto F(x)$ は well-defined な環準同型である。実際、$F=\sum a_jT^j$（$a_j\in\mathbb{Z}_\ell$、$|a_j|_\ell\le1$）に対し $|a_jx^j|_\ell\le|x|_\ell^{\,j}\to0$ なので $\mathbb{C}_\ell$ の完備性より収束し、非アルキメデス的絶対収束級数の Cauchy 積は自由に並べ替えられるので積を保つ。よって

$$f(x)=\ell^{\mu}\,g(x)\,U(x)\qquad(v_\ell(x)>0). \tag{6.2}$$

**$v_\ell(U(x))=0$**: $U\in\Lambda^\times$ ⟺ $U(0)\in\mathbb{Z}_\ell^\times$。$U(x)-U(0)=\sum_{j\ge1}u_jx^j$ は $v_\ell\ge v_\ell(x)>0$ なので $v_\ell(U(x))=v_\ell(U(0))=0$。

**$v_\ell(\zeta-1)>0$**: $\zeta$ を原始 $\ell^{k}$ 乗根（$k\ge1$）とする。$\Phi_{\ell^{k}}(x)=\Phi_\ell\bigl(x^{\ell^{k-1}}\bigr)=1+x^{\ell^{k-1}}+\dots+x^{(\ell-1)\ell^{k-1}}$ はモニックで、その根全体が原始 $\ell^k$ 乗根の全体だから

$$\prod_{\zeta:\ \text{原始}\ \ell^{k}\ \text{乗根}}(1-\zeta)=\Phi_{\ell^{k}}(1)=\ell .$$

原始 $\ell^k$ 乗根どうしは $\mathbb{Q}$ 上共役で、$v_\ell$ は $\overline{\mathbb{Q}}_\ell$ 上一意に延長されるから共役な元の付値は等しい。個数は $\varphi(\ell^k)$ 個なので

$$v_\ell(\zeta-1)=\frac{1}{\varphi(\ell^{k})}=\frac{1}{\ell^{k-1}(\ell-1)}>0. \tag{6.2'}$$

（$k=1,\dots,n$ で足し合わせると $\sum_{k}\varphi(\ell^k)\cdot\frac1{\varphi(\ell^k)}=n$ となり $(2.7)$ を再現する。整合。）

**$D(\zeta)=f(\zeta-1)$**: $(6.2')$ より $v_\ell(\zeta-1)>0$ なので $(6.2)$ が使え、$(1+T)^r$ の $T=\zeta-1$ での値が $\zeta^r$ であることから $f(\zeta-1)=\zeta^{r}P(\zeta)=D(\zeta)$。

### 6.3 準備 3: $\omega_n$ の付値の増大

$\omega_n(T):=(1+T)^{\ell^{n}}-1$ と置く。$\omega_n$ はモニックで次数 $\ell^n$、その根はちょうど $\{\zeta-1:\zeta^{\ell^n}=1\}$（$\ell^n$ 個の相異なる元）なので

$$\omega_n(T)=\prod_{\zeta^{\ell^n}=1}\bigl(T-(\zeta-1)\bigr). \tag{6.3}$$

> **補題 E.** *$\beta\in\mathbb{C}_\ell$ が $v_\ell(\beta)>0$ を満たし、かつ $1+\beta$ が $\ell$ 冪位数の $1$ の冪根で**ない**とする。このとき $n_\beta\ge0$ と $c_\beta\in\mathbb{Q}$ が存在して*
> $$v_\ell\bigl(\omega_n(\beta)\bigr)=n+c_\beta\qquad(n\ge n_\beta).$$

**証明.** $\beta_j:=(1+\beta)^{\ell^{j}}-1=\omega_j(\beta)$ と置く。仮定より $\beta_j\neq0$（$\beta_j=0$ なら $1+\beta$ が $\ell^j$ 乗根）。$e_j:=v_\ell(\beta_j)$、$e_0=v_\ell(\beta)>0$。二項展開

$$\beta_{j+1}=(1+\beta_j)^{\ell}-1=\sum_{k=1}^{\ell}\binom{\ell}{k}\beta_j^{\,k}$$

の各項の付値は、$k=1$: $1+e_j$、$2\le k\le\ell-1$: $\ge1+ke_j>1+e_j$、$k=\ell$: $\ell e_j$（$v_\ell\binom{\ell}{k}=1$ for $1\le k\le\ell-1$）。

- $e_j>\frac1{\ell-1}$ のとき $\ell e_j>1+e_j$ なので最小値は $k=1$ の項でのみ達成され、非アルキメデス的評価より $e_{j+1}=1+e_j$。とくに $e_{j+1}>\frac1{\ell-1}$ が保たれる。
- $e_j\le\frac1{\ell-1}$ のとき $\ell e_j\le 1+e_j$ なので $e_{j+1}\ge\min(1+e_j,\ell e_j)=\ell e_j$。

したがって $e_j\le\frac1{\ell-1}$ である限り $e_j$ は少なくとも $\ell$ 倍ずつ増えるので、$e_0>0$ より有限回で $e_{n_\beta}>\frac1{\ell-1}$ となる $n_\beta$ が存在する。以後は第 1 のケースが続き $e_n=(n-n_\beta)+e_{n_\beta}$、すなわち $c_\beta=e_{n_\beta}-n_\beta$。$\blacksquare$

**補題 E の仮定の確認（ここで塔の連結性を使う）**: 以下で補題 E を適用するのは $h$ の根 $\beta$ に対してである。

- $v_\ell(\beta)>0$: $h$ は distinguished（モニック、非最高次係数が $\ell\mathbb{Z}_\ell$）。もし $v_\ell(\beta)\le0$ なら、$\beta^{d}=-\sum_{i<d}h_i\beta^{i}$（$d=\deg h$）で左辺の付値は $d\,v_\ell(\beta)$、右辺の各項は $\ge1+i\,v_\ell(\beta)\ge1+(d-1)v_\ell(\beta)$（$v_\ell(\beta)\le0$ より $i$ が大きいほど小さい）。よって $d\,v_\ell(\beta)\ge1+(d-1)v_\ell(\beta)$、すなわち $v_\ell(\beta)\ge1>0$ で矛盾。
- $1+\beta$ が $\ell$ 冪位数の $1$ の冪根でないこと: もし $1+\beta=\zeta$（$\zeta^{\ell^k}=1$）なら、$h\mid g\mid \ell^{-\mu}f$ より $f(\beta)=0$、$(6.2)$ と $\zeta\neq1$（$\beta\neq0$、$h(0)\neq0$ だから）より $D(\zeta)=f(\zeta-1)=0$。系 B′ $(3.4)$ より $X_{\ell^k}$ が非連結となり、**定理 2 の仮定に反する**。

> この 1 点が「全ての層が連結」という仮定を本質的に使う唯一の箇所である。

### 6.4 主計算

$n\ge1$ とし、$\zeta$ は $\zeta^{\ell^n}=1$ を走るとする。定理 2 の仮定より $X_{\ell^n}$ は連結なので $\kappa_n>0$ で、定理 1 $(4.1)$ から

$$\mathrm{ord}_\ell(\kappa_n)=v_\ell(\kappa(X))-n+\sum_{\zeta\neq1}v_\ell\bigl(D(\zeta)\bigr). \tag{6.4}$$

$(6.2)$ と $v_\ell(U(\zeta-1))=0$ より、$\zeta\neq1$ の各項について $v_\ell(D(\zeta))=\mu+v_\ell\bigl(g(\zeta-1)\bigr)$。$\zeta\neq1$ は $\ell^n-1$ 個あるので

$$\sum_{\zeta\neq1}v_\ell(D(\zeta))=(\ell^{n}-1)\mu+\sum_{\zeta\neq1}v_\ell\bigl(g(\zeta-1)\bigr). \tag{6.5}$$

$g=T^{s}h$ より $g(\zeta-1)=(\zeta-1)^{s}h(\zeta-1)$、よって $(2.7)$ を使って

$$\sum_{\zeta\neq1}v_\ell(g(\zeta-1))=s\underbrace{\sum_{\zeta\neq1}v_\ell(\zeta-1)}_{=\,n}+\sum_{\zeta\neq1}v_\ell\bigl(h(\zeta-1)\bigr). \tag{6.6}$$

最後の和を評価する。$h$ はモニックで $d:=\deg h=\lambda_{\mathrm W}-s$、根を $\beta_1,\dots,\beta_d\in\overline{\mathbb{Q}}_\ell$（重複込み）とすると、$(6.3)$ より

$$\prod_{\zeta^{\ell^n}=1}h(\zeta-1)=\prod_{\zeta}\prod_{t=1}^{d}\bigl((\zeta-1)-\beta_t\bigr)=(-1)^{d\ell^{n}}\prod_{t=1}^{d}\omega_n(\beta_t).$$

各 $\beta_t$ は補題 E の仮定（§6.3 で確認済み）を満たすので、$n\ge n_0':=\max_t n_{\beta_t}$ で $v_\ell(\omega_n(\beta_t))=n+c_{\beta_t}$。ゆえに

$$\sum_{\zeta^{\ell^n}=1}v_\ell\bigl(h(\zeta-1)\bigr)=d\,n+C,\qquad C:=\sum_{t}c_{\beta_t}\quad(n\ge n_0'). \tag{6.7}$$

$\zeta=1$ の項は $v_\ell(h(0))$（定数、$h(0)\neq0$ より有限）なので

$$\sum_{\zeta\neq1}v_\ell(h(\zeta-1))=d\,n+C-v_\ell(h(0))\qquad(n\ge n_0'). \tag{6.8}$$

$(6.4)$–$(6.8)$ を合わせ、$s+d=\lambda_{\mathrm W}$ を使うと $n\ge n_0:=\max(1,n_0')$ で

$$\mathrm{ord}_\ell(\kappa_n)=v_\ell(\kappa(X))-n+(\ell^{n}-1)\mu+\lambda_{\mathrm W}\,n+C-v_\ell(h(0))
=\mu\,\ell^{n}+(\lambda_{\mathrm W}-1)\,n+\nu,$$

ただし $\nu:=v_\ell(\kappa(X))-\mu+C-v_\ell(h(0))$。左辺は整数、$\mu\ell^n+(\lambda_{\mathrm W}-1)n$ も整数だから $\nu\in\mathbb{Z}$。$\lambda_{\mathrm W}\ge2$ は §6.1 で示した。$\blacksquare$

### 6.5 $(\mu,\lambda,\nu)$ の一意性

*$\mu\ell^n+\lambda n+\nu=\mu'\ell^n+\lambda'n+\nu'$ が全ての $n\ge n_0$ で成り立てば $(\mu,\lambda,\nu)=(\mu',\lambda',\nu')$。*
実際 $(\mu-\mu')\ell^n+(\lambda-\lambda')n+(\nu-\nu')=0$ を $n=n_0,n_0+1,n_0+2$ で連立させると、係数行列 $\begin{pmatrix}\ell^{n_0}&n_0&1\\ \ell^{n_0+1}&n_0+1&1\\ \ell^{n_0+2}&n_0+2&1\end{pmatrix}$ の行列式は、第 1 行を第 2・第 3 行から引いて $2\times2$ に落とすと $-\ell^{n_0}(\ell-1)^2$ となり、$\ell\ge2$ より $\neq0$。よって解は自明のみ。**これにより「$\mu$」「$\lambda$」「$\nu$」は塔から一意に定まる不変量であり、どの証明経路で計算しても同じ値になる。** §8 でこれを使う。

### 6.6 $\chi(X)\neq0$ が不要であること

McGown–Vallières III Theorem 6.1（cycle13 step1 report §3.5）は $\chi(X)\neq0$ を仮定している。上の証明はこの仮定を使っていない。実例で確かめられる: $X=$ 1 頂点 1 ループ（voltage $1$）は $\chi(X)=1-1=0$ だが、$X_N=C_N$（$N$ 頂点閉路）で $\kappa(C_N)=N$、$D(z)=2-z-z^{-1}=-z^{-1}(z-1)^2$、$f(T)=-T^2/(1+T)$ より $\mu=0$, $\lambda_{\mathrm W}=2$, $\lambda=1$, $\nu=0$、$(6.1)$ は $\mathrm{ord}_\ell(N)=n$ を与えて正しい（Step 6 の表の「bouquet 1ループ(χ=0)」行がこれ）。

**ただし**、$\chi(X)\neq0$ が [E] のどこで必要なのかは本レポートでは確認していない（[E] の本文は本セッションで取得していない。§10 参照）。「[E] の仮定が冗長である」とは主張しない。

> **機械検証**: Step 6。8 個の底グラフ × 複数の $\ell$ について、$\mu,\lambda_{\mathrm W}$ を $D(1+T)$ の係数から（$\kappa_n$ を一切見ずに）決め、$\nu$ を最大の $n$ で 1 回だけ決めたうえで、全ての $n$ で $(6.1)$ を照合 → 全一致。さらに乱択 40 グラフ × $\ell\in\{2,3\}$ の 63 塔について $n_0$（漸近が成立し始める段）を測定し、分布は $n_0=0$: 51 件, $1$: 3 件, $2$: 4 件, $3$: 5 件で、$n_{\max}$ まで一致の証拠が得られなかったものは 0 件。$n_0>0$ の存在は $(6.1)$ が「$n\ge n_0$ で」という主張であることと整合する。

---

## 7. 定理 3 $=(☆)$

> **定理 3.** *定理 2 と同じ仮定（$X$ 有限連結多重グラフ、$X_\ell$ 連結）の下で、$\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+\lambda n+\nu$（$n\ge n_0$）の $\mu$ について*
> $$\boxed{\ \mu_\ell=v_\ell\bigl(\mathrm{content}_z(\det L(z))\bigr)\ } \tag{7.1}$$
> *が成り立つ。さらに $\lambda=\lambda_{\mathrm W}-1$ で、$\lambda_{\mathrm W}=\min\{j: v_\ell(c_j)=\mu\}$（$D(1+T)=\sum_j c_jT^j$）。*

**証明.** 定理 2 より $\mu_\ell=\mu(f)$（$f=D(1+T)$ の定理 W の $\mu$）。§6.5 の一意性により、$\mathrm{ord}_\ell(\kappa_n)$ の漸近式の $\mu$ は塔から一意に決まる量なので、これは定義の取り方に依らない。補題 D $(5.1)$ より $\mu(f)=v_\ell(\mathrm{content}_z(D))$。$\lambda$ については定理 W $(2.4)$ と定理 2 の $\lambda=\lambda_{\mathrm W}-1$。$\blacksquare$

**注 7.1（決定可能性）.** $(7.1)$ の右辺は
「$L(z)$ を組み立てる → $\det$ を $\mathbb{Z}[z,z^{-1}]$ で計算 → 係数の $\gcd$ を取る → $v_\ell$」
という**有限手続き**で、$\mathbb{R}$ も極限も使わない。仮定の検査（$X$ 連結、$X_\ell$ 連結）も補題 C により $\gcd(\ell,g_X)$ の計算だけで済む。本プロジェクトの梯子で言えば全体が $\mathbb{Z}$（$\subset\Lambda$）の中に収まっている。

**注 7.2（$\lambda$ について）.** cycle 12 README §6 は「$\lambda$ の一般則は今回の対象外」としていたが、定理 3 により $\lambda=\min\{j:v_\ell(c_j)=\mu\}-1$ として同じく決定可能である。README の観察「$\det L=-c\,z^{-1}(z-1)^2$ 型では $\lambda=1$」は、この型では $f(T)=-c\,T^2/(1+T)$ で $\lambda_{\mathrm W}=2$ となることから従う。また例 5（$\lambda=3$）は $\lambda_{\mathrm W}=4$ である（Step 6 の表）。**$\lambda\ge1$ が常に成り立つ**ことは §6.1 の $s\ge2$ から従う。

---

## 8. 新規性について（主張しない）

**$(☆)$ は既知の言い換えである。** 根拠:

1. cycle 13 step 1 report §3.5 が本文確認済みとして挙げる **McGown–Vallières III, Theorem 6.1** は、$X$ 連結多重グラフ・$\chi(X)\neq0$・全ての導来多重グラフが連結、という仮定の下で、岩澤冪級数 $Q(T)=c_1T+c_2T^2+\dots\in\mathbb{Z}_\ell[[T]]$ に対し
   $$\mu=\min_j v_\ell(c_j),\qquad \lambda=\min\{j:v_\ell(c_j)=\mu\}-1,\qquad \mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+\lambda n+\nu$$
   を述べている。これは形式上、本レポートの定理 2・定理 3 と同じ内容である（$\mu$ が「冪級数の係数の付値の最小値」であること、$\lambda$ がそれを達成する最小添字 $-1$ であること、まで一致する）。
2. §6.5 の一意性により、$\mu$ は塔から一意に決まる。したがって [E] Theorem 6.1 の $\mu$ と本レポートの $\mu$ は（両者の仮定を共に満たす $X$ について）**同じ数**である。$(☆)$ はその $\mu$ を $\mathrm{content}_z\det L(z)$ という形で書き直しただけである。
3. 1 変数 Alexander 多項式の場合の類似（**Ueki, Prop 2.7 + Prop 3.7 + Remark 3.8**、step1 report §3.4 で本文確認済み）は、$\mathrm{M}_p(f)=\max_i|a_i|_p$（Gauss ノルム＝ content の付値）と $\log\mathrm{M}_p=-\mu_p\log p$ を述べており、Remark 3.8 は「$|z|_p=1$ 上に零点が無ければ Jensen の公式・Gauss ノルム・$p$ 進 Weierstrass 準備定理から直ちに従う」と明記している。**本レポート §6 の証明はこの筋（Weierstrass ＋ 係数の content）をグラフの $\det L(z)$ に対して実行したものであり、機構として新しくない。**

**したがって本レポートの寄与は「本プロジェクトの記法・仮定で、外部文献の本文を参照せずに読める完全な証明を与えたこと」だけである。数学的な新規性は主張しない。**

一方、cycle 12 README §5 が「文献に $\mu>0$ の明示例があるか未確認」と書いた点については、本レポートでも**変わらず未確認**である（本セッションで [E][G] の本文は取得していない）。

---

## 9. 退化ケースの総覧（落とさずに扱う）

| ケース | 扱い | 根拠 |
|---|---|---|
| **$X$ が非連結** | $(★)$ は $0=0$ で成立。岩澤漸近は $\kappa_n=0$ なので $\mathrm{ord}_\ell(\kappa_n)=\infty$、不変量は定義されない。 | 定理 1 (i)、系 B′ |
| **ある $\zeta\neq1$ で $\det L(\zeta)=0$** | $X_N$ が非連結であることと同値。$(★)$ は $0=0$ で成立。 | 系 B′ $(3.4)$、定理 1 (ii) |
| **$\det L(z)\equiv0$** | 全ての $N\ge2$ で $X_N$ 非連結。content が定義されず $\mu=\infty$。定理 2・3 の仮定（$X_\ell$ 連結）に反するので対象外。 | §6.1 |
| **$\ell$-塔のどこかの段が非連結** | 系 C′ により all-or-nothing: $\ell\mid g_X$ なら $n\ge1$ の全段が非連結、$\ell\nmid g_X$ なら全段が連結。判定は $\gcd$ 計算 1 回。 | 補題 C、系 C′ |
| **ループ** | $L(z)$ の対角に $2-z^{\alpha}-z^{-\alpha}$ として最初から組み込み済み。$\alpha\equiv0\bmod N$ のとき $X_N$ でループになり寄与 $0$、$L(\zeta)$ 側も $\zeta^\alpha=1$ で $0$。整合。 | 補題 A の証明 case 3 |
| **多重辺** | $L(z)$ の各成分が辺ごとの和になっているだけ。証明のどこでも単純性を使っていない。 | §1.4, 定理 K |
| **$\chi(X)=0$** | 定理 2・3 の証明では使わない。実例（1 頂点 1 ループ）で成立を確認。 | §6.6 |
| **$m=1$（bouquet）** | 特別扱い不要。$D(z)=\sum_a m_a(2-z^a-z^{-a})$。 | — |
| **$\ell\nmid N$ の段** | **定理 3 の射程外。**下記 §9.4。 | — |

### 9.4 $\ell\nmid N$ との違い（重要な限界）

定理 2 の証明は $v_\ell(\zeta-1)>0$、すなわち $\zeta$ が $\ell$ **冪位数**であることを 3 箇所で本質的に使っている: $(6.2)$ の収束、$v_\ell(U(\zeta-1))=0$、$(2.7)$。$\zeta$ の位数が $\ell$ と素なら $\zeta-1$ は $\mathcal{O}_{\mathbb{C}_\ell}$ の単元（$v_\ell(\zeta-1)=0$）で、これらはすべて崩れる。

実際、**content は $\ell\nmid N$ の段を支配しない**。反例（Step 7 の witness、いずれも $v_\ell(\mathrm{content}_z\det L)=0$）:

- $X=$ 1 頂点・voltage $1,2$ の 2 ループ、$\ell=3$、$N=4$: $\mathrm{content}=1$ だが $\kappa(X_4)=36$、$v_3=2>0$。
- $X=$ 2 頂点・voltage $\{0,2\}$ の平行 2 重辺、$\ell=2$、$N=3$: $\mathrm{content}=1$ だが $\kappa(X_3)=6$、$v_2=1>0$。

したがって $(☆)$ は「**abelian $\ell$-tower $N=\ell^n$ の $\mu$**」についての主張であって、一般の $\mathbb{Z}/N$-被覆の $\ell$ 進付値についての主張ではない。$\ell\nmid N$ 方向（Washington–Sinnott 類似）は cycle 12 README が挙げる arXiv:2201.05186 の領域だが、**その本文は本プロジェクトで未取得なので内容は引用しない**。

---

## 10. 証明できなかったこと・未確認のこと（正直に）

1. **[E] McGown–Vallières III および [G] Vallières の本文を本セッションで取得していない。** §8 の記述は cycle 13 step 1 report が「本文確認済み」として引用した Theorem 6.1 の文言に依拠している。とくに **[E] Corollary 5.6 の岩澤冪級数 $Q(T)$ の定義そのものは確認していない**ので、「$Q(T)$ が $\det L(1+T)$ と単元倍を除いて一致する」とは主張しない。§8 の同値性の議論は、その代わりに §6.5 の一意性（漸近式の係数は塔から一意に決まる）だけに依拠しており、$Q(T)$ の定義を知らなくても成立する。
2. **[E] が $\chi(X)\neq0$ をどこで使うのかは未確認**（§6.6）。本レポートの証明に不要であることは示したが、[E] の仮定が冗長だとは主張しない。
3. **Besser–Deninger 1999 と Cuoco–Monsky 1981 の本文は依然未取得**（cycle 13 step 1 report §1 の表と同じ状態）。本レポートはこれらの内容を使っていない。
4. **文献に $\mu>0$ のグラフの明示例があるかは未確認のまま。** cycle 12 README §5 の状態から変わっていない。したがって cycle 12 の例 1–6 の新規性も引き続き主張しない。
5. **$\mu$ の上界は何も分かっていない。** cycle 12 の広域探索で得た「$\mu_2\le4$（非自明例）」等は探索範囲内の最大値にすぎず、定理 3 は $\mu$ が有界であることを何も言わない（$\mathrm{content}$ はいくらでも大きくできる可能性が残る）。
6. **$\nu$ の閉形式は与えていない。** 定理 2 の証明は $\nu=v_\ell(\kappa(X))-\mu+\sum_t c_{\beta_t}-v_\ell(h(0))$ という表示を与えるが、$c_{\beta_t}$（補題 E の定数）は根 $\beta_t$ ごとの $\ell$ 進的なデータで、$\det L$ の係数から直接読む手続きは書いていない。
7. **$n_0$ の明示的な上界を与えていない。** 補題 E の $n_\beta$ は「$e_j$ が $\frac1{\ell-1}$ を超えるまでの回数」で押さえられるが、根の付値の下界を $\det L$ の係数から出す評価は書いていない。数値的には Step 6 の 63 塔で $n_0\le3$ だったが、これは証拠であって上界の証明ではない。
8. **$d\ge2$ の塔（$\mathbb{Z}_\ell^d$-塔）は扱っていない。** cycle 13 step 1 report §3.5 の [F] DuBose–Vallières Theorem A によれば $d\ge2$ では $\mathrm{ord}_\ell(\kappa_n)=P(\ell^n,n)$（総次数 $\le d$）となり、単一の $\mu$ では書けない。本レポートは $d=1$ のみ。本プロジェクトの $L\times L$ トーラス（$\mathbb{Z}_\ell^2$-塔）には**そのままでは適用できない**。

---

## 11. 数値検証

`sagemath/check/cycle13_T3_criterion_proof/`（SageMath 10.6、`sage proof_steps.sage`）。

| Step | 検証内容 | 対応する主張 | 結果 |
|---|---|---|---|
| 1 | $\det(xI-L_{X_N})=\prod_\zeta\det(xI-L(\zeta))$（$\mathbb{Q}(\zeta_N)[x]$ 上の厳密等式） | 補題 A | 312 件、不一致 0 |
| 2 | $c(X_N)=\sum_\zeta\dim\ker L(\zeta)$ | 補題 B | 416 件、不一致 0 |
| 3 | $X_N$ 連結 $\iff\gcd(N,g_X)=1$ | 補題 C | 552 件、不一致 0 |
| 4 | $N\kappa(X_N)=\kappa(X)\prod_{\zeta\neq1}D(\zeta)$（左辺 Kirchhoff、右辺 終結式、独立計算） | 定理 1 | 624 件（非連結 129 件を含む）、不一致 0 |
| 5 | $\mathrm{content}_z(D)=\mathrm{content}_z(P)=\mathrm{content}_T(P(1+T))$ と $\mu_{\mathrm W}=v_\ell(\mathrm{content})$ | 補題 D, 定理 3 | 45 グラフ × 5 素数、不一致 0 |
| 6 | $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+(\lambda_{\mathrm W}-1)n+\nu$（$\mu,\lambda_{\mathrm W}$ は $\kappa_n$ を見ずに決定） | 定理 2, 定理 3 | 明示 8 グラフの 22 塔で全 $n$ 一致、乱択 63 塔で $n_0\le3$ |
| 7 | $\mu=0$ でも $\ell\nmid N$ の段で $v_\ell(\kappa(X_N))>0$ になる witness | §9.4 の限界 | 6 件提示 |

対象グラフは cycle 12 の例 1–6 に加え、$\chi=0$ の bouquet、$\det L\equiv0$ の退化例、$\ell$-塔が非連結になる退化例、乱択 40 件。

**これらは有限個の例での照合であって証明ではない。**証明本体は §3–§7 である。数値検証の役割は、証明の書き間違い（符号・添字・場合分けの取りこぼし）を検出することに限られる。

---

## 12. cycle 12 / cycle 13 step 1 との関係

- **cycle 12 T3 README §5「証明していないこと」の 2 項目が両方とも解消した**: $(★)$ の完全な厳密証明（→ 定理 1）、$\mathrm{ord}_\ell(\kappa_n)$ の漸近形そのもの（→ 定理 2）。
- **cycle 12 T3 README §6「$\lambda$ の一般則は今回の対象外」も解消した**（→ 注 7.2、$\lambda=\lambda_{\mathrm W}-1\ge1$）。
- **cycle 13 step 1 report §7 の「同値性の証明は cycle 13 step 2 の課題」に応答した**: Ueki の $\mathrm{M}_p$（1 変数 Alexander 多項式、Gauss ノルム）と cycle 12 の $\mathrm{content}_z\det L(z)$ は**対象が異なる別の命題**であり、直接の同値ではない。共通なのは証明機構（Weierstrass 準備定理で $\mu$＝係数の付値の最小値）であって、グラフ側の対応する既知命題は [E] Theorem 6.1 の方である（§8）。
- **cycle 13 step 1 report §3.5 の警告（$d\ge2$ では単一の $\mu$ で書けない）は本レポートでも有効**であり、本レポートの射程を $d=1$ に限定した（§10-8）。
