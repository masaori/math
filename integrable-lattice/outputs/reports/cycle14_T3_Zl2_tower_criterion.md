# cycle 14 / T3 Pure: 判定式の $\mathbb{Z}_\ell^2$-塔（$d=2$）への拡張

> **本 report は 2 つの独立な導出のうちの第 2 経路である。**
> cycle 14 step 1 は起動事故により 2 回走り、同じ課題を**互いを参照せずに**解いた。
> もう一方は `cycle14_T3_two_variable_criterion.md`（第 1 経路）。
> 両者が一致した点: $(★_2)$ の証明、連結性の判定条件、**下界 $a\ge v_\ell(\mathrm{content})$ は自前で証明できるが
> 上界 $a\le v_\ell(\mathrm{content})$ は自前では証明できない**という境界、および新規性を主張しないこと。
> 相違点: 第 1 経路は非退化条件の下で完全な閉形式を出し、本経路は単項式還元の仮定の下で主要 2 項を出している。
> 独立に同じ境界へ到達したことは、境界の位置づけの信頼性を高める。


対象: `outputs/reports/cycle13_T3_mu_content_criterion_proof.md`（以下「cycle13 report」）で証明した
$d=1$ の機構を、**2 変数 voltage（$\mathbb{Z}^2$ 値）と $\mathbb{Z}_\ell^2$-塔**へ拡張する。
cycle13 report §10-8 が明記したとおり、$d=1$ の結果は本プロジェクトの $L\times L$ トーラスには適用できない。

前提: cycle13 report（定理 1・定理 2・定理 3、補題 A–E）、`cycle13_T1_padic_entropy_generality.md` §3.5。

---

## 0. 結論（先に置く）

| 主張 | 状態 |
|---|---|
| $(★_2)$ $\;N N'\,\kappa(X_{N,N'})=\kappa(X)\prod_{(\zeta,\xi)\neq(1,1)}\det L(\zeta,\xi)$ | **証明した**（§4 定理 1′）。cycle13 定理 1 の証明はそのまま通る。有限アーベル群 $A$ 一般で証明した（§4）。連結性の仮定は不要（退化ケースは両辺 $0$）。 |
| 連結性の判定 | **証明した**（§3 補題 C2）。$X_{N,N'}$ 連結 $\iff \Lambda_X+(N\mathbb{Z}\times N'\mathbb{Z})=\mathbb{Z}^2$（$\Lambda_X$ は基本閉路 voltage が生成する $\mathbb{Z}^2$ の部分群）。塔では all-or-nothing（系 C2′）。 |
| **下界** $\;\mathrm{ord}_\ell(\kappa_n)\ \ge\ \mu\,\ell^{2n}+v_\ell(\kappa(X))-\mu-2n$ | **証明した**（§6 定理 2′）。$\mu:=v_\ell(\mathrm{content}_{z,w}\det L(z,w))$。したがって Greenberg 多項式 $P(X,Y)$ が存在するなら、その $X^2$ の係数 $a$ は $a\ge\mu$。 |
| **上界** $a\le\mu$（＝主要項の係数が $\mu$ に一致すること） | **一般には証明できなかった。** どこまで行ってどこで詰まったかを §7 に完全に具体化した。詰まりは「$f_1$ の零点が $\ell$ 冪根に**どれだけ近づきうるか**の一様評価」の 1 点で、これは Monsky の定理 5.6 が担っている部分である。 |
| **単項式還元の場合の完全な漸近** | **証明した**（§8 定理 3′）。$f_1 \bmod \ell$ が $T^aS^b\times$ 単元 のとき $$\mathrm{ord}_\ell(\kappa_n)=\mu\,\ell^{2n}+(a+b)\,n\,\ell^{n}+O(\ell^{n}).$$ 主要項の係数が $\mu=v_\ell(\mathrm{content})$ であることが、この仮定の下では**証明済み**になる。 |
| 新規性 | **主張しない。** DuBose–Vallières, *On $\mathbb{Z}_\ell^d$-towers of graphs*, Algebraic Combinatorics **6** (2023) 1331–1346 の**本文を取得した**（§11）。Theorem A（=Theorem 6.2）が漸近形を述べ、さらに本文が「$X^d$ と $YX^{d-1}$ の係数には**明示公式が既にある**（Cuoco–Monsky, Definition 1.1 / 1.2）」と明記している。したがって主要項の係数の公式も既知である。 |
| 射程外 | $\ell\nmid N$ の段（§10）。$L\times L$ トーラス自身は §8 定理 3′ の仮定を**満たさない**（§9.3）。 |

**証明できなかったこと・未確認のことは §12 に分離して書いた。**

---

## 1. 設定（記号をすべて明示する）

$\mathbb{Z}$ は有理整数環、$\ell$ は素数。

### 1.1 底グラフと $\mathbb{Z}^2$ voltage

- $X$: **有限多重グラフ**。頂点集合 $V=\{1,\dots,m\}$（$m\ge1$）、辺の有限重複集合 $E$。多重辺・ループを許す。
- 各辺 $e\in E$ に向きを固定し、始点 $o(e)$・終点 $t(e)$ を定める。
- **voltage 割り当て** $\alpha: E\to\mathbb{Z}^2$。$\alpha_e=(a_e,b_e)$ と書く。辺を $(u,v,(a,b))$ と表記する。

辺の向きを反転して $\alpha_e\mapsto-\alpha_e$ としても、以下の $L(z,w)$ は不変である（§1.4 の定義から直接確認できる: 非対角成分 $(u,v)$ と $(v,u)$ が入れ替わり、対角のループ寄与は $2-\text{mon}-\text{mon}^{-1}$ で $\pm$ 対称）。

### 1.2 導来グラフ

$N,N'\in\mathbb{Z}_{\ge1}$ に対し、**導来グラフ** $X_{N,N'}$ を次で定める。

- 頂点集合 $V\times(\mathbb{Z}/N\times\mathbb{Z}/N')$。
- 各辺 $e=(u,v,(a,b))\in E$ と各 $(i,j)\in\mathbb{Z}/N\times\mathbb{Z}/N'$ に対し、$(u,(i,j))$ と $(v,(i+a,j+b))$ を結ぶ辺 $e_{i,j}$ を 1 本置く。

$X_{N,N'}$ は $mNN'$ 頂点・$|E|NN'$ 辺の有限多重グラフである。$X_{1,1}=X$。
$N=N'=\ell^n$ の列を **$\mathbb{Z}_\ell^2$-塔**と呼び、$\kappa_n:=\kappa(X_{\ell^n,\ell^n})$ と書く。

より一般に、有限アーベル群 $A$ と群準同型的なデータ $\alpha:E\to A$ に対して同じ構成 $X_A$（頂点 $V\times A$）が定義できる。**§3–§4 の証明は $A$ 一般で書く**（$A=\mathbb{Z}/N\times\mathbb{Z}/N'$、$\alpha$ は $\mathbb{Z}^2\to A$ との合成、が本レポートの場合）。

### 1.3 ラプラシアン

有限多重グラフ $G$（ループ可）に対し

$$(L_Gv)(x)=\sum_{\substack{\text{$x$ に接続する}\\ \text{辺の端 }(e,x)}}\bigl(v(x)-v(x'_e)\bigr) \tag{1.1}$$

（$x'_e$ は $e$ の $x$ と反対側の端点。ループなら $x'_e=x$ で項は $0$）。成分で書けば、対角がループでない辺の端の個数、非対角 $(x,y)$ が $-\#\{x\text{–}y \text{ 辺}\}$。

$\kappa(G)$ は $G$ の全域木の個数（非連結なら $0$、1 頂点なら $1$）。$c(G)$ は連結成分数。

### 1.4 2 変数 voltage ラプラシアン

$\mathbb{Z}[z^{\pm1},w^{\pm1}]$ 係数の $m\times m$ 行列 $L(z,w)$ を、辺ごとの寄与の和として定める。$e=(u,v,(a,b))$ に対し $\mathrm{mon}_e:=z^{a}w^{b}$ と置き、

- $u\neq v$: $L_{uu}\mathrel{+}=1$, $L_{vv}\mathrel{+}=1$, $L_{uv}\mathrel{-}=\mathrm{mon}_e$, $L_{vu}\mathrel{-}=\mathrm{mon}_e^{-1}$。
- $u=v$（ループ）: $L_{uu}\mathrel{+}=2-\mathrm{mon}_e-\mathrm{mon}_e^{-1}$。

$D(z,w):=\det L(z,w)\in\mathbb{Z}[z^{\pm1},w^{\pm1}]$。$L(1,1)=L_X$ である（ループの寄与 $2-1-1=0$）。

一般の有限アーベル群 $A$ と指標 $\chi\in\widehat{A}=\mathrm{Hom}(A,\mathbb{C}^\times)$ に対しては、$\mathrm{mon}_e$ を $\chi(\alpha_e)$ に置き換えた複素 $m\times m$ 行列を $L(\chi)$ と書く。$A=\mathbb{Z}/N\times\mathbb{Z}/N'$ で $\chi_{\zeta,\xi}(i,j)=\zeta^i\xi^j$（$\zeta^N=\xi^{N'}=1$）とすれば $L(\chi_{\zeta,\xi})=L(\zeta,\xi)$ である。

**補足 1.4.1（対称性）.** $L(z^{-1},w^{-1})=L(z,w)^{\mathsf T}$ が成分ごとに確認できる（非対角: $L_{uv}(z^{-1},w^{-1})=-\sum\mathrm{mon}_e^{-1}=L_{vu}(z,w)$、対角: $2-\mathrm{mon}-\mathrm{mon}^{-1}$ は $(z,w)\mapsto(z^{-1},w^{-1})$ で不変）。ゆえに

$$D(z^{-1},w^{-1})=D(z,w). \tag{1.2}$$

**補足 1.4.2（Hermite 性）.** $|\chi(g)|=1$ なので $L(\chi)^{*}=L(\chi)$、さらに任意の $x\in\mathbb{C}^V$ に対し

$$\langle L(\chi)x,x\rangle=\sum_{e\in E}\bigl|x_{o(e)}-\chi(\alpha_e)\,x_{t(e)}\bigr|^2\ \ge\ 0 \tag{1.3}$$

（非ループ辺は $|x_u|^2+|x_v|^2-\chi(\alpha_e)x_v\bar x_u-\overline{\chi(\alpha_e)}x_u\bar x_v=|x_u-\chi(\alpha_e)x_v|^2$、ループは $|x_u|^2|1-\chi(\alpha_e)|^2$）。以下では $(1.3)$ は使わないが、$\prod_{\chi\neq1}\det L(\chi)>0$（実で非負）であることの根拠になる。

### 1.5 content と付値

$0\neq F=\sum f_{ab}z^aw^b\in\mathbb{Z}[z^{\pm},w^{\pm}]$ に対し $\mathrm{content}_{z,w}(F):=\gcd\{f_{ab}\}\in\mathbb{Z}_{>0}$。
$v_\ell$ は $\mathbb{Q}$ 上の $\ell$ 進付値（$v_\ell(\ell)=1$）を $\overline{\mathbb{Q}}_\ell$・$\mathbb{C}_\ell$ へ一意に延長したもの。$\mathcal{O}=\mathcal{O}_{\mathbb{C}_\ell}$、$\mathfrak m=\{v_\ell>0\}$。慣例として $v_\ell(0)=+\infty$。

$$\Lambda_2:=\mathbb{Z}_\ell[[T,S]],\qquad \mu(F):=\min\{v_\ell(\text{$F$ の係数})\}\ \ (0\neq F\in\Lambda_2).$$

---

## 2. 使う既知定理と、その適用条件

**毎回、適用条件を満たすことを確認してから使う。**

### 定理 K（Kirchhoff の matrix-tree 定理）と系 K′

cycle13 report §2 と同一。$G$ を $n\ge1$ 頂点の有限多重グラフ（ループ可）とし、$L_G$ の固有値を $0=\lambda_1\le\lambda_2\le\dots\le\lambda_n$ とすると

$$\prod_{j=2}^{n}\lambda_j=n\,\kappa(G). \tag{2.1}$$

（$L_G$ の任意の $(n-1)$ 次主小行列式が $\kappa(G)$ に等しいこと＋$\det(xI-L_G)$ の $x^1$ の係数の 2 通りの表示。$G$ が非連結なら $\lambda_2=0$ で両辺 $0$。）

### 定理 W1（1 変数 $\ell$ 進 Weierstrass 準備定理）

$\mathcal{O}_K$ を有限次拡大 $K/\mathbb{Q}_\ell$ の整数環、$\pi$ を素元とする。$0\neq f=\sum_{j\ge0}c_jT^j\in\mathcal{O}_K[[T]]$ に対し $t:=\min_j v_\pi(c_j)<\infty$ と置くと

$$f=\pi^{t}\,g(T)\,U(T),\qquad g\ \text{は distinguished 多項式},\quad U\in\mathcal{O}_K[[T]]^{\times}$$

と一意に書け、$\deg g=\min\{j:v_\pi(c_j)=t\}$。**適用条件**: $\mathcal{O}_K$ が完備離散付値環、$f\neq0$。以下、使うたびに $f\neq0$ を確認する。
（$K=\mathbb{Q}_\ell$ の場合が cycle13 report 定理 W ＝ Washington, *Introduction to Cyclotomic Fields* 2nd ed., Theorem 7.3。一般の $\mathcal{O}_K$ でも証明は同一。）

**補足 W′.** $\Lambda_2/\ell\Lambda_2=\mathbb{F}_\ell[[T,S]]$ は整域（体上の有限変数形式冪級数環）なので、$\mu(\cdot)$ は $\Lambda_2\smallsetminus\{0\}$ 上の付値である:

$$\mu(F_1F_2)=\mu(F_1)+\mu(F_2),\qquad \mu(U)=0\ \ (U\in\Lambda_2^{\times}). \tag{2.2}$$

### 定理 W2（完備局所環上の Weierstrass 準備定理）— §7 でのみ使う

*$A$ を完備局所環、$\mathfrak m_A$ をその極大イデアル、$k=A/\mathfrak m_A$ とする。$f\in A[[S]]$ が **$S$ について正則位数 $s$**、すなわち $\bar f:=f\bmod\mathfrak m_A\in k[[S]]$ が $\bar f\neq0$ かつ $\mathrm{ord}_S(\bar f)=s$、を満たすとする。このとき*

$$f=P\cdot U,\qquad P=S^{s}+c_{s-1}S^{s-1}+\dots+c_0\in A[S],\ c_i\in\mathfrak m_A,\quad U\in A[[S]]^{\times}$$

*と一意に書ける。*

**適用条件は「$A$ が完備局所」と「$f$ が $S$ について正則（位数有限）」の 2 つ**であり、**この 2 つ目が 1 変数版との決定的な違い**である。1 変数（定理 W1）では $f\neq0$ だけでよいが、2 変数では正則性が要る。通常はここで座標変換（$S\mapsto S+T^k$ 等）を施して正則にするが、**本レポートの文脈ではその変換は使えない**（§7.1 で理由を述べる）。

本セッションで本定理の本文（Bourbaki *Algèbre commutative* VII、Zariski–Samuel、Lang *Algebra* 等）は取得していないので、命題番号は挙げない。以下では標準的事実として引用し、**使う箇所を §7 に限定する**（§4・§6・§8 の証明では使わない）。

### 定理 C（円分の初等的事実）

$N\ge2$ に対し $\prod_{\zeta^N=1,\zeta\neq1}(1-\zeta)=N$、とくに

$$\sum_{\zeta^{\ell^n}=1,\ \zeta\neq1}v_\ell(\zeta-1)=n,\qquad
v_\ell(\zeta-1)=\frac{1}{\varphi(\ell^{k})}\ \ (\zeta\ \text{は原始}\ \ell^{k}\ \text{乗根},\ k\ge1). \tag{2.3}$$

（後者は $\Phi_{\ell^k}(1)=\ell$ と、原始 $\ell^k$ 乗根が $\mathbb{Q}$ 上共役で $v_\ell$ が一意延長であることから。cycle13 report §6.2 と同一。）

---

## 3. 補題 A2・B2・C2（対角化と連結性）

### 補題 A2（有限アーベル群上の Fourier によるブロック対角化）

*$A$ を有限アーベル群、$\alpha:E\to A$ を voltage とする。$\mathbb{C}$ 上の線形写像として*

$$\det\bigl(xI_{mA}-L_{X_A}\bigr)=\prod_{\chi\in\widehat A}\det\bigl(xI_m-L(\chi)\bigr). \tag{3.1}$$

*とくに $L_{X_A}$ の固有値の重複集合は $\bigsqcup_{\chi\in\widehat A}\mathrm{Spec}\,L(\chi)$ である。*

**証明.** $\chi\in\widehat A$、$x\in\mathbb{C}^V$ に対し $v_{\chi,x}\in\mathbb{C}^{V\times A}$ を $v_{\chi,x}(u,g):=\chi(g)\,x_u$ で定める。$(1.1)$ で $L_{X_A}$ を計算する。頂点 $(u,g)$ に接続する $X_A$ の辺の端は、$X$ の辺ごとに次の 3 種で尽くされる。

1. $e=(u,v,\alpha_e)\in E$、$u\neq v$: 辺 $e_g$ が $(u,g)$—$(v,g+\alpha_e)$。寄与は $\chi(g)x_u-\chi(g+\alpha_e)x_v=\chi(g)\bigl(x_u-\chi(\alpha_e)x_v\bigr)$。
2. $e=(v,u,\alpha_e)\in E$、$u\neq v$: 辺 $e_{g-\alpha_e}$ が $(v,g-\alpha_e)$—$(u,g)$。寄与は $\chi(g)\bigl(x_u-\chi(\alpha_e)^{-1}x_v\bigr)$。
3. $e=(u,u,\alpha_e)\in E$: 辺 $e_g$ と辺 $e_{g-\alpha_e}$ の 2 つの端。寄与の和は $\chi(g)x_u\bigl(2-\chi(\alpha_e)-\chi(\alpha_e)^{-1}\bigr)$。（$\alpha_e=0$ ならこれらは $X_A$ でループになり寄与 $0$、右辺も $\chi(\alpha_e)=1$ より $0$。一致する。）

これらは §1.4 の $L(\chi)$ の定義の各項と項ごとに一致する（$\chi(\alpha_e)^{-1}=\chi(-\alpha_e)$）。したがって

$$L_{X_A}\,v_{\chi,x}=v_{\chi,\,L(\chi)x}. \tag{3.2}$$

$W_\chi:=\{v_{\chi,x}:x\in\mathbb{C}^V\}$ は $m$ 次元（$x\mapsto v_{\chi,x}$ は単射）で $L_{X_A}$ 不変、その上で $L_{X_A}$ は $L(\chi)$ と同型に作用する。
$\mathbb{C}^{V\times A}=\bigoplus_{\chi}W_\chi$: 次元はともに $m|A|$ なので和が全体を張ることを見ればよい。$u$ を固定すると $\{(\chi(g))_{g\in A}:\chi\in\widehat A\}$ は $\mathbb{C}^{A}$ の基底である（$\widehat A$ の指標は $|A|$ 個あり、指標の直交関係 $\sum_g\chi(g)\overline{\chi'(g)}=|A|\delta_{\chi\chi'}$ より一次独立）。$u$ を動かして全体を張る。ゆえに $(3.1)$。$\blacksquare$

> **機械検証**: Step 1。$A=\mathbb{Z}/N\times\mathbb{Z}/N'$、$(N,N')\in\{(1,1),(2,1),(1,2),(2,2),(2,3),(3,3),(4,2)\}$、例 45 件、計 **315 件で $\mathbb{Q}(\zeta_{\mathrm{lcm}(N,N')})[x]$ 上の厳密等式として照合、不一致 0 件**。

### 補題 B2（連結成分数の分解）

$$c(X_A)=\sum_{\chi\in\widehat A}\dim_{\mathbb{C}}\ker L(\chi). \tag{3.3}$$

**証明.** 有限多重グラフ $G$ について $\dim_\mathbb{C}\ker L_G=c(G)$ は標準（$L_G$ は実対称で、$(1.1)$ より $\langle L_Gv,v\rangle=\sum_{e\ \text{非ループ}}|v(o(e))-v(t(e))|^2$。$0$ になるのは $v$ が各成分上で定数のときに限る）。これを $G=X_A$ に適用し、補題 A2 の直和分解で核も分解する。$\blacksquare$

**系 B2′.** *$X$ が連結なら $\ker L(\chi_0)=\ker L_X$（$\chi_0$ は自明指標）は 1 次元なので*

$$X_A\ \text{連結}\iff \det L(\chi)\neq0\ \ (\forall\chi\neq\chi_0). \tag{3.4}$$

*$X$ が非連結なら $c(X_A)\ge c(X)\ge2$ で $X_A$ も非連結。*

> **機械検証**: Step 2、$(N,N')$ 9 通り、計 **405 件（うち非連結 143 件）、不一致 0 件**。

### 補題 C2（連結性の部分群判定 — 退化ケースの決定手続き）

*$X$ を連結とし、全域木 $T\subseteq E$ を 1 つ固定する。$T$ 上の potential $h:V\to\mathbb{Z}^2$ を $h(v_0)=0$ と「$T$ の辺 $(u,v,\alpha)$ について $h(v)=h(u)+\alpha$」で定める（$T$ が木なので一意）。非木辺 $e=(u,v,\alpha)$ の**基本閉路 voltage** を $\beta_e:=\alpha+h(u)-h(v)\in\mathbb{Z}^2$ とし、*

$$\Lambda_X:=\langle \beta_e : e\in E\smallsetminus T\rangle\subseteq\mathbb{Z}^2$$

*と置く。$A:=\mathbb{Z}^2/(N\mathbb{Z}\times N'\mathbb{Z})$、$H\subseteq A$ を $\Lambda_X$ の像とすると*

$$c(X_{N,N'})=[A:H],\qquad\text{とくに}\quad X_{N,N'}\ \text{連結}\iff \Lambda_X+(N\mathbb{Z}\times N'\mathbb{Z})=\mathbb{Z}^2. \tag{3.5}$$

**証明.** $X_{N,N'}$ の頂点 $(v,g)$（$g\in A$）に対し $\phi(v,g):=g-h(v)\bmod A$ と置く。辺 $e_g$（$e=(u,v,\alpha)$）は $(u,g)$ と $(v,g+\alpha)$ を結び、

$$\phi(v,g+\alpha)-\phi(u,g)=(g+\alpha-h(v))-(g-h(u))=\beta_e \bmod A .$$

とくに $e\in T$ なら $\beta_e=0$ で $\phi$ は保たれる。$X_{N,N'}$ の任意の辺は $\phi$ を $H$ の元だけずらすので、$\phi\bmod H$ は各連結成分上で一定。ゆえに $c\ge[A:H]$。
逆に、$T$ の辺は $\phi$ を保ち $T$ が $V$ を張るので、$\phi$ が同じ値をもつ頂点は連結（$\{(v,g):\phi(v,g)=c\}$ は $T$ の持ち上げで木をなす）。さらに非木辺 $e$ で $\phi$ の値を $\beta_e$ だけ動かせるので、$\phi$ の値が同じ $H$-剰余類にある頂点はすべて連結。ゆえに $c=[A:H]$。
$[A:H]=1\iff H=A\iff \Lambda_X+(N\mathbb{Z}\times N'\mathbb{Z})=\mathbb{Z}^2$。$\blacksquare$

**系 C2′（$\ell$-塔の all-or-nothing）.** *$X$ 連結のとき、次は同値:*
*(a) $X_{\ell,\ell}$ が連結; (b) $\Lambda_X+\ell\mathbb{Z}^2=\mathbb{Z}^2$; (c) すべての $n\ge0$ で $X_{\ell^n,\ell^n}$ が連結。*

**証明.** (a)$\iff$(b) は $(3.5)$。(c)$\Rightarrow$(a) は自明。(b)$\Rightarrow$(c): $k\ge1$ について $\Lambda_X+\ell^{k}\mathbb{Z}^2=\mathbb{Z}^2$ を仮定すると、両辺に $\ell^{k}$ を掛けて $\ell^{k}\mathbb{Z}^2=\ell^{k}\Lambda_X+\ell^{k+1}\mathbb{Z}^2\subseteq\Lambda_X+\ell^{k+1}\mathbb{Z}^2$、よって $\mathbb{Z}^2=\Lambda_X+\ell^{k}\mathbb{Z}^2\subseteq\Lambda_X+\ell^{k+1}\mathbb{Z}^2$。$k=1$ から帰納で全 $k$。$\blacksquare$

**注 3.1（決定可能性）.** $\Lambda_X$ の生成元は全域木を 1 つ取れば有限手続きで得られ、$(3.5)$ の判定は $2\times2$ 整数行列の Smith 標準形（または $\bmod\ \ell$ での階数）で済む。$\mathbb{R}$ も極限も使わない。

> **機械検証**: Step 2 の後半、同じ 405 件で $(3.5)$ を照合、**不一致 0 件**。

---

## 4. 定理 1′ $=(★_2)$

> **定理 1′.** *$(X,\alpha)$ を任意の有限 voltage 多重グラフ（voltage は任意の有限アーベル群 $A$ に値をとる）とする。このとき $\mathbb{Z}$ における等式*
> $$|A|\cdot\kappa(X_A)\;=\;\kappa(X)\cdot\prod_{\chi\in\widehat A,\ \chi\neq\chi_0}\det L(\chi) \tag{4.1}$$
> *が成り立つ。とくに $A=\mathbb{Z}/N\times\mathbb{Z}/N'$ のとき*
> $$N N'\,\kappa(X_{N,N'})=\kappa(X)\prod_{\substack{\zeta^N=1,\ \xi^{N'}=1\\ (\zeta,\xi)\neq(1,1)}}\det L(\zeta,\xi). \tag{4.2}$$

**証明.** 3 つの場合に分ける。

**(i) $X$ が非連結の場合.** $\kappa(X)=0$、系 B2′ より $X_A$ も非連結で $\kappa(X_A)=0$。$(4.1)$ は $0=0$。

**(ii) $X$ 連結、かつある $\chi_1\neq\chi_0$ で $\det L(\chi_1)=0$ の場合.** 右辺は $0$。系 B2′ $(3.4)$ より $X_A$ は非連結なので $\kappa(X_A)=0$、左辺も $0$。

**(iii) $X$ 連結、かつ全ての $\chi\neq\chi_0$ で $\det L(\chi)\neq0$ の場合.** このとき系 B2′ より $X_A$ は連結である。

$L_{X_A}$ は $m|A|$ 次の実対称行列で、固有値を $0=\Lambda_1\le\Lambda_2\le\dots\le\Lambda_{m|A|}$ とする。系 K′ $(2.1)$ を $G=X_A$（有限多重グラフ ✓）に適用して

$$\prod_{j=2}^{m|A|}\Lambda_j=m|A|\cdot\kappa(X_A). \tag{4.3}$$

補題 A2 より $L_{X_A}$ の固有値の重複集合は $\bigsqcup_{\chi}\mathrm{Spec}\,L(\chi)$ である。補題 B2 と $c(X_A)=1$ より、この重複集合に含まれる $0$ はちょうど 1 個で、それは $\chi=\chi_0$ の成分（$L(\chi_0)=L_X$）に属する。$L_X$ の固有値を $0=\lambda_1<\lambda_2\le\dots\le\lambda_m$ とすると

$$\prod_{j=2}^{m|A|}\Lambda_j=\Bigl(\prod_{i=2}^{m}\lambda_i\Bigr)\cdot\prod_{\chi\neq\chi_0}\det L(\chi) \tag{4.4}$$

（$\det L(\chi)$ はその成分の固有値の積）。再び系 K′ を $G=X$（$m$ 頂点）に適用して $\prod_{i\ge2}\lambda_i=m\,\kappa(X)$。$(4.3)$, $(4.4)$ を合わせ $m\ge1$ で割ると $(4.1)$ を得る。$\blacksquare$

**注 4.1（cycle13 定理 1 との関係）.** 証明は cycle13 report §4 と**構造が完全に同じ**である。$d=1$ から $d=2$ へ移るときに変わるのは、指標群が $\mu_N$ から $\mu_N\times\mu_{N'}$ になる点だけで、対角化（補題 A2）を有限アーベル群 $A$ 一般で書いておけば $d$ に依存しない。**ここは「素直に通る」ことを確認した箇所である。**

**注 4.2（右辺の厳密計算）.** $D(z,w)=z^{r}w^{s}F(z,w)$（$F\in\mathbb{Z}[z,w]$、$z\nmid F$、$w\nmid F$）と書くと、$\zeta,\xi$ が 1 の冪根なので $z^rw^s$ の寄与は絶対値 1 であり、

$$\prod_{(\zeta,\xi)\neq(1,1)}F(\zeta,\xi)
=\Bigl[\mathrm{Res}_z\bigl(\tfrac{z^N-1}{z-1},\,G(z)\bigr)\Bigr]\cdot\Bigl[\mathrm{Res}_w\bigl(\tfrac{w^{N'}-1}{w-1},\,F(1,w)\bigr)\Bigr],\qquad
G(z):=\mathrm{Res}_w\bigl(w^{N'}-1,\,F(z,w)\bigr)$$

で**終結式だけで厳密計算できる**（$w^{N'}-1$ と $\frac{z^N-1}{z-1}$ はモニックなので、終結式はそのまま値の積 $\prod_\xi F(z,\xi)$ / $\prod_{\zeta\neq1}G(\zeta)$ に等しい）。$\mathbb{R}$ も数値近似も使わない。機械検証はこの経路を使い、左辺（導来グラフの Kirchhoff 余因子）と**独立に**計算している。

> **機械検証**: Step 3。$(N,N')$ 10 通り、例 45 件、計 **450 件（うち両辺 $0$ の退化 142 件＝ケース (i)(ii) を実際に通っている）、不一致 0 件**。左辺は $mNN'$ 頂点の導来グラフを実際に構成して Kirchhoff 余因子で、右辺は上の終結式で計算した。

---

## 5. 補題 D2（content の不変性、2 変数）

> **補題 D2.** *$0\neq D\in\mathbb{Z}[z^{\pm},w^{\pm}]$ とし $D=z^{r}w^{s}F$（$F\in\mathbb{Z}[z,w]$、$z\nmid F$、$w\nmid F$）と書く。$f(T,S):=D(1+T,1+S)\in\Lambda_2$、$p(T,S):=F(1+T,1+S)\in\mathbb{Z}[T,S]$ と置くと*
> $$\mu(f)=v_\ell\bigl(\mathrm{content}_{T,S}(p)\bigr)=v_\ell\bigl(\mathrm{content}_{z,w}(D)\bigr). \tag{5.1}$$

**証明.** 3 段。

**(a) $f$ が well-defined で $\mu(f)=\mu(p)$.** $1+T$ と $1+S$ は $\mathbb{Z}[[T,S]]$ の単元（逆元 $\sum_k(-T)^k$ 等）なので $(1+T)^{r}(1+S)^{s}$ は $r,s\in\mathbb{Z}$ のいずれの符号でも $\Lambda_2$ の単元。$f=(1+T)^r(1+S)^s\,p$ であり、補足 W′ $(2.2)$ より $\mu(f)=0+\mu(p)$。

**(b) $\mu(p)=v_\ell(\mathrm{content}_{T,S}(p))$.** 係数が $\mathbb{Z}$ にあるので定義そのもの。

**(c) $\mathrm{content}_{T,S}(p)=\mathrm{content}_{z,w}(F)=\mathrm{content}_{z,w}(D)$.**
後半は $D$ と $F$ の係数の重複集合が一致することから明らか。前半: $\varphi:\mathbb{Z}[z,w]\to\mathbb{Z}[T,S]$, $Q\mapsto Q(1+T,1+S)$ は $\mathbb{Z}$-代数の同型（逆は $T\mapsto z-1$, $S\mapsto w-1$）だから、任意の整数 $M>0$ について $\varphi(M\mathbb{Z}[z,w])=M\mathbb{Z}[T,S]$、すなわち $Q\in M\mathbb{Z}[z,w]\iff\varphi(Q)\in M\mathbb{Z}[T,S]$。$\mathrm{content}$ は「$Q\in M\mathbb{Z}[\cdot]$ となる最大の $M>0$」なので両者は一致する。$\blacksquare$

以下、$X$ 連結・$X_{\ell,\ell}$ 連結の下で

$$\boxed{\ \mu:=v_\ell\bigl(\mathrm{content}_{z,w}\det L(z,w)\bigr)=\mu(f),\qquad f_1:=\ell^{-\mu}f\in\Lambda_2\smallsetminus\ell\Lambda_2\ }$$

と置く。

---

## 6. 定理 2′（下界 — 完全に証明する）

> **定理 2′.** *$X$ を有限連結多重グラフ、$\alpha:E\to\mathbb{Z}^2$ を voltage、$\ell$ を素数とし、**$X_{\ell,\ell}$ が連結**（$\iff\Lambda_X+\ell\mathbb{Z}^2=\mathbb{Z}^2$、補題 C2 で決定可能）と仮定する。このとき $D\neq0$ であり、すべての $n\ge0$ について $\kappa_n>0$ かつ*
> $$\mathrm{ord}_\ell(\kappa_n)\ \ge\ \mu\,\ell^{2n}\;-\;\mu\;+\;v_\ell(\kappa(X))\;-\;2n. \tag{6.1}$$
> *とくに $\displaystyle\liminf_{n\to\infty}\frac{\mathrm{ord}_\ell(\kappa_n)}{\ell^{2n}}\ \ge\ \mu$ であり、Greenberg 多項式 $P(X,Y)$（§11、DuBose–Vallières Theorem A）が存在するとき、その $X^2$ の係数 $a$ は $a\ge\mu$ を満たす。*

### 6.1 準備 1: $D\neq0$ と塔の連結性

系 C2′ より全ての $n$ で $X_{\ell^n,\ell^n}$ は連結、ゆえに $\kappa_n>0$。$\ell\ge2$ なので $(\zeta,\xi)\neq(1,1)$ かつ $\zeta^\ell=\xi^\ell=1$ なる組が存在し、系 B2′ $(3.4)$ より $D(\zeta,\xi)\neq0$、ゆえに $D\neq0$。よって $\mu<\infty$ で補題 D2 が使える。

### 6.2 準備 2: 2 変数の評価準同型

*$x,y\in\mathfrak m\subset\mathbb{C}_\ell$（$v_\ell(x)>0$, $v_\ell(y)>0$、$x=0$ や $y=0$ も許す）に対し、$\Lambda_2\to\mathcal{O}$, $F\mapsto F(x,y)$ は well-defined な環準同型である。*

**証明.** $F=\sum a_{ij}T^iS^j$（$a_{ij}\in\mathbb{Z}_\ell$、$v_\ell(a_{ij})\ge0$）に対し $v_\ell(a_{ij}x^iy^j)\ge i\,v_\ell(x)+j\,v_\ell(y)\ge(i+j)\delta$（$\delta:=\min(v_\ell(x),v_\ell(y))>0$）。したがって族 $(a_{ij}x^iy^j)$ は $\mathbb{C}_\ell$ で総和可能（各 $\varepsilon>0$ について $v_\ell<\varepsilon$ となる項は有限個）であり、$\mathbb{C}_\ell$ の完備性から和が収束する。非アルキメデス的総和可能族の積は自由に並べ替えられるので積を保つ。値は $v_\ell\ge0$ なので $\mathcal{O}$ に入る。$\blacksquare$

$\zeta$ が $\ell$ 冪位数の 1 の冪根なら $v_\ell(\zeta-1)>0$（$(2.3)$、$\zeta=1$ なら $+\infty$）。また $D=z^rw^sF$ に $z=1+T,\ w=1+S$ を代入した $f=(1+T)^r(1+S)^s p$ の $(T,S)=(\zeta-1,\xi-1)$ での値は $\zeta^r\xi^s F(\zeta,\xi)=D(\zeta,\xi)$ である。すなわち

$$D(\zeta,\xi)=f(\zeta-1,\xi-1)=\ell^{\mu}\,f_1(\zeta-1,\xi-1). \tag{6.2}$$

### 6.3 主計算

$n\ge0$ とする。定理 1′ $(4.2)$ で $N=N'=\ell^n$ とし、$\kappa_n>0$ より両辺の $v_\ell$ を取って

$$\mathrm{ord}_\ell(\kappa_n)=v_\ell(\kappa(X))-2n+\sum_{(\zeta,\xi)\neq(1,1)}v_\ell\bigl(D(\zeta,\xi)\bigr). \tag{6.3}$$

$(6.2)$ と $f_1\in\Lambda_2$（したがって $v_\ell(f_1(\zeta-1,\xi-1))\ge0$、§6.2）より、各項について $v_\ell(D(\zeta,\xi))\ge\mu$。$(\zeta,\xi)\neq(1,1)$ の組は $\ell^{2n}-1$ 個あるので $(6.1)$ を得る。$\blacksquare$

**定義（誤差項）.** 以下、

$$E_n:=\sum_{(\zeta,\xi)\neq(1,1)}v_\ell\bigl(f_1(\zeta-1,\xi-1)\bigr)\ \ (\ge0)
=\mathrm{ord}_\ell(\kappa_n)-v_\ell(\kappa(X))+2n-(\ell^{2n}-1)\mu \tag{6.4}$$

と置く。**主要項の係数が $\mu$ に一致することは、$E_n=o(\ell^{2n})$ と同値である。**

> **機械検証**: Step 4(i)。**86 塔すべてで $E_n\ge0$**（定理 2′ の主張そのもの）。Step 4(ii) では $E_n/\ell^{2n}$ が末尾 3 点で減少していることを **86 塔すべてで**確認した（$E_n=o(\ell^{2n})$ の数値的支持。証明ではない）。

---

## 7. 上界の試み — どこまで行き、どこで詰まったか

本節の目標は $E_n=O(n\,\ell^{n})$（$\Rightarrow E_n=o(\ell^{2n})$ $\Rightarrow$ 主要項の係数 $=\mu$）である。**一般には証明できなかった。** 以下、cycle13 の機構をどこまで持ち上げられたかを順に書き、詰まった 1 点を特定する。

### 7.1 第 1 段: Weierstrass 化と、1 変数との決定的な違い

$A:=\mathbb{Z}_\ell[[T]]$ は完備局所環（極大イデアル $\mathfrak m_A=(\ell,T)$、剰余体 $\mathbb{F}_\ell$）で、$\Lambda_2=A[[S]]$。定理 W2 を $f_1\in A[[S]]$ に適用したい。

**適用条件の確認.** $f_1$ が $S$ について正則位数 $s<\infty$ であること、すなわち

$$\bar f_1:=f_1\bmod\mathfrak m_A = \bigl(f_1(0,S)\bmod\ell\bigr)\in\mathbb{F}_\ell[[S]]\ \ \text{が}\ \neq0 . \tag{7.1}$$

$f_1(0,S)=\ell^{-\mu}D(1,1+S)\cdot(\text{単元})$ なので、$(7.1)$ は

$$v_\ell\bigl(\mathrm{content}_w D(1,w)\bigr)=\mu \tag{7.1'}$$

と同値である（補題 D2 の 1 変数版）。これは $\det L(z,w)$ から**有限手続きで判定できる条件**だが、**一般には成り立たない**。

**1 変数との違い（重要）.** cycle13 report の定理 W（1 変数）は $f\neq0$ だけを要求した。2 変数の定理 W2 は正則性 $(7.1)$ を要求する。通常の解決法は座標変換（$S\mapsto S+T^k$ 等の $\Lambda_2$ の自己同型で正則にする）だが、**本レポートでは使えない**。理由: 我々が評価したいのは特定の点集合 $\{(\zeta-1,\xi-1)\}$（$\ell$ 冪根から来る点）上の値の和であり、$S\mapsto S+T^k$ はこの点集合を保存しないからである（$(\zeta-1)+(\xi-1)^k$ は一般に $\ell$ 冪根 $-1$ の形ではない）。**この一点が、cycle13 の機構をそのまま持ち上げられない構造的理由である。**

$(7.1)$ が成り立つとき、定理 W2 より

$$f_1=P\cdot U,\qquad P=S^{s}+c_{s-1}(T)S^{s-1}+\dots+c_0(T)\in A[S],\ \ c_i\in(\ell,T)A,\ \ U\in A[[S]]^{\times}. \tag{7.2}$$

$v_\ell(x),v_\ell(y)>0$ の点で $v_\ell(U(x,y))=0$ である（$U\in A[[S]]^\times\iff u_0:=U(T,0)\in A^\times\iff u_0(0)\in\mathbb{Z}_\ell^\times$。$U(x,y)-u_0(x)=\sum_{j\ge1}u_j(x)y^j$ は $v_\ell\ge v_\ell(y)>0$、$u_0(x)-u_0(0)$ は $v_\ell\ge v_\ell(x)>0$）。ゆえに

$$E_n=\sum_{(\zeta,\xi)\neq(1,1)}v_\ell\bigl(P(\zeta-1,\xi-1)\bigr). \tag{7.3}$$

### 7.2 第 2 段: $v_\ell(\omega_n(\beta))$ の**一様**上界（補題 E2）

$\omega_n(T):=(1+T)^{\ell^{n}}-1=\prod_{\zeta^{\ell^n}=1}\bigl(T-(\zeta-1)\bigr)$ と置く。

> **補題 E2.** *$\beta\in\mathbb{C}_\ell$、$v_\ell(\beta)>0$ とし $e_j:=v_\ell(\omega_j(\beta))$（$e_0=v_\ell(\beta)$）と置く。$1+\beta$ が $\ell$ 冪位数の 1 の冪根でないとすると $e_j<\infty$ で、次が成り立つ。*
> $$e_j<\tfrac{1}{\ell-1}\ \Rightarrow\ e_{j+1}=\ell e_j;\qquad
> e_j>\tfrac{1}{\ell-1}\ \Rightarrow\ e_{j+1}=e_j+1;\qquad
> e_j=\tfrac{1}{\ell-1}\ \Rightarrow\ e_{j+1}\ge e_j+1 .$$
> *とくに、どの $j$ でも $e_j=\frac{1}{\ell-1}$ とならないならば*
> $$v_\ell(\omega_n(\beta))\ \le\ n+\max\Bigl(v_\ell(\beta),\ \tfrac{\ell}{\ell-1}\Bigr)\qquad(\forall n\ge0). \tag{7.4}$$

**証明.** $\beta_j:=\omega_j(\beta)$ と置く。$\omega_1(\beta_j)=(1+\beta_j)^{\ell}-1=\prod_{\eta^\ell=1}\bigl(\beta_j-(\eta-1)\bigr)$ で、$\eta=1$ の因子は $\beta_j$、$\eta\neq1$ の因子は $v_\ell(\eta-1)=\frac{1}{\ell-1}$（$(2.3)$）を満たす $\ell-1$ 個。よって

- $e_j<\frac1{\ell-1}$: 各因子 $v_\ell(\beta_j-(\eta-1))=\min(e_j,\frac1{\ell-1})=e_j$（強三角不等式の等号条件）。総和 $=\ell e_j$。
- $e_j>\frac1{\ell-1}$: 各非自明因子の $v_\ell=\frac1{\ell-1}$。総和 $=e_j+(\ell-1)\cdot\frac1{\ell-1}=e_j+1$。
- $e_j=\frac1{\ell-1}$: 各非自明因子の $v_\ell\ge\frac1{\ell-1}$。総和 $\ge e_j+1$。

$(7.4)$: $e_j<\frac1{\ell-1}$ である限り $e_j$ は $\ell$ 倍ずつ増えるので、$e_0>0$ より有限回で $\frac1{\ell-1}$ を超える。境界値を取らないという仮定の下で、$j_0:=\min\{j:e_j>\frac1{\ell-1}\}$ と置くと、$j_0\ge1$ なら $e_{j_0}=\ell e_{j_0-1}<\frac{\ell}{\ell-1}$、$j_0=0$ なら $e_{j_0}=v_\ell(\beta)$。いずれにせよ $e_{j_0}\le\max(v_\ell(\beta),\frac{\ell}{\ell-1})$。$j\ge j_0$ では $e_{j+1}=e_j+1$ が続くので $e_n=e_{j_0}+(n-j_0)\le n+e_{j_0}$。$n<j_0$ では $e_n<\frac1{\ell-1}\le n+e_{j_0}$。$\blacksquare$

**cycle13 の補題 E との違い.** cycle13 の補題 E は「各 $\beta$ ごとに $n\ge n_\beta$ で $v_\ell(\omega_n(\beta))=n+c_\beta$」という**漸近**であり、$n_\beta,c_\beta$ は $\beta$ ごとに異なってよかった（根は有限個なので十分だった）。$d=2$ では下記のとおり根の個数が $\ell^n$ のオーダーで増えるため、**$\beta$ に依らない一様上界 $(7.4)$ が必要**になる。補題 E2 はそれを与えるが、**境界値 $e_j=\frac1{\ell-1}$ を取る場合が除外されている**。

### 7.3 第 3 段: 終結式による 1 変数への還元

$(7.3)$ を $\zeta$ について先に潰す。$R_n(T):=\mathrm{Res}_S\bigl(P(T,S),\,\omega_n(S)\bigr)\in A=\mathbb{Z}_\ell[[T]]$ と置くと（$P$ は $S$ についてモニック、$\omega_n$ もモニック）

$$\prod_{\xi^{\ell^n}=1}P(T,\xi-1)=\pm R_n(T),\qquad
\sum_{(\zeta,\xi)}v_\ell\bigl(P(\zeta-1,\xi-1)\bigr)=\sum_{\zeta^{\ell^n}=1}v_\ell\bigl(R_n(\zeta-1)\bigr). \tag{7.5}$$

$\bmod\ \ell$ では $\omega_n(S)\equiv S^{\ell^n}$ なので

$$R_n\equiv\pm\,\mathrm{Res}_S\bigl(\bar P,\,S^{\ell^n}\bigr)=\pm\,\bar c_0(T)^{\ell^{n}}\pmod\ell,\qquad \bar c_0:=c_0\bmod\ell\in\mathbb{F}_\ell[[T]]. \tag{7.6}$$

$f_1(T,0)=c_0(T)\,U(T,0)$ で $U(T,0)\in A^\times$ だから、$\bar c_0\neq0$ は

$$f_1(T,0)\notin\ell A\iff v_\ell\bigl(\mathrm{content}_z D(z,1)\bigr)=\mu \tag{7.7}$$

と同値（$T$ についての正則性）。$(7.7)$ を仮定し $a:=\mathrm{ord}_T(\bar c_0)<\infty$ と置くと、$(7.6)$ より

$$\mu(R_n)=0,\qquad \lambda_{\mathrm W}(R_n)=\mathrm{ord}_T\bigl(R_n\bmod\ell\bigr)=a\,\ell^{n}. \tag{7.8}$$

定理 W1 を $R_n\in\mathbb{Z}_\ell[[T]]$（$\mu(R_n)=0$ より $R_n\neq0$ ✓）に適用して $R_n=g_n U_n$（$g_n$ は distinguished、$\deg g_n=a\ell^n$、$U_n\in A^\times$）。$v_\ell(U_n(\zeta-1))=0$ なので

$$\sum_{\zeta^{\ell^n}=1}v_\ell\bigl(R_n(\zeta-1)\bigr)=\sum_{\gamma:\ g_n(\gamma)=0}v_\ell\bigl(\omega_n(\gamma)\bigr) \tag{7.9}$$

（$\prod_{\zeta}g_n(\zeta-1)=\pm\prod_\gamma\omega_n(\gamma)$、根は重複込みで $a\ell^n$ 個。$g_n$ が distinguished なので全ての根は $v_\ell(\gamma)>0$）。

ここで補題 E2 $(7.4)$ を各 $\gamma$ に使えれば

$$E_n\ \le\ a\,\ell^{n}\Bigl(n+\max_\gamma\max\bigl(v_\ell(\gamma),\tfrac{\ell}{\ell-1}\bigr)\Bigr) \tag{7.10}$$

となり、$\max_\gamma v_\ell(\gamma)$ が $n$ に依らず有界であれば $E_n=O(n\ell^n)$、すなわち**主要項の係数 $=\mu$ が従う**。

### 7.4 詰まった点（具体化）

$(7.10)$ には 2 つの穴があり、どちらも同じ現象に由来する。

1. **補題 E2 の境界ケース.** $\gamma$ の軌道が $e_j=\frac1{\ell-1}$ をちょうど通ると $(7.4)$ は成立せず、超過分 $e_{j+1}-(e_j+1)=v_\ell\bigl(\beta_j-(\eta_0-1)\bigr)-\frac1{\ell-1}$（$\eta_0$ は原始 $\ell$ 乗根）が出る。これは「$1+\gamma$ が $\ell$ 冪位数の 1 の冪根に**どれだけ近いか**」そのものである。
2. **$\max_\gamma v_\ell(\gamma)$ の一様有界性.** $\gamma$ は $f_1(T,\xi-1)=0$ の根、すなわち曲線 $\{f_1=0\}$ の $\ell$ 冪ねじれ点 $\xi$ 上のファイバーである。個数は $a\ell^n$ で $n$ とともに増える。

$d=1$（cycle13）ではこの 2 つが**塔の連結性だけで**処理できた。根は有限個（$\deg h$ 個、$n$ に依らない）で、連結性から「どの根も $\zeta-1$ の形ではない」ことが言え、有限個の定数 $n_\beta,c_\beta$ を取れば済んだからである。

$d=2$ では根の個数が $\ell^n$ のオーダーで増えるので、「どの根もねじれ点でない」（＝連結性）だけでは不十分で、

> **必要な言明**: $f_1$ の零点が $\ell$ 冪ねじれ点にどれだけ近づきうるかの、$n$ に一様な下界。
> 具体的には、$\zeta,\xi$ が $\ell^n$ 乗根を走るとき $\sum_{(\zeta,\xi)}v_\ell(f_1(\zeta-1,\xi-1))=O(n\ell^n)$ そのもの。

が要る。これは Bogomolov 型／等分布型の量的言明であり、**本レポートでは証明できなかった**。文献ではこの部分がちょうど **Monsky, *On $p$-adic power series*, Math. Ann. 255 (1981) 217–227 の Theorem 5.6** が担っている（§11、DuBose–Vallières の証明もここを引用している）。同定理の本文は本セッションで取得していない。

**なお、$(7.1')$ と $(7.7)$ は本プロジェクトの $L\times L$ トーラスでは両方とも成立する**（§9.3）。したがってトーラスについては、§7 の還元は最後の 1 点を除いて完全に通っている。

---

## 8. 定理 3′（単項式還元の場合 — 完全に証明する）

$(7.1)$ より強い仮定を置くと、定理 W2 を経由せずに漸近を完全に決定できる。**以下の証明は定理 W2 を使わない**（使うのは定理 1′、定理 W1（1 変数）、cycle13 の補題 E、定理 C だけである）。

> **定理 3′.** *$X$ を有限連結多重グラフ、$\alpha:E\to\mathbb{Z}^2$、$\ell$ を素数とし $X_{\ell,\ell}$ 連結とする。$\mu=v_\ell(\mathrm{content}_{z,w}D)$、$f_1=\ell^{-\mu}D(1+T,1+S)\in\Lambda_2$ と置き、その $\bmod\ \ell$ 還元 $\bar f_1\in\mathbb{F}_\ell[[T,S]]$ が*
> $$\bar f_1=T^{a}S^{b}\cdot\bar U,\qquad \bar U\in\mathbb{F}_\ell[[T,S]]^{\times} \tag{8.1}$$
> *と書けると仮定する（$a,b\in\mathbb{Z}_{\ge0}$）。このとき $n$ に依らない定数 $C$ が存在して*
> $$\Bigl|\ \mathrm{ord}_\ell(\kappa_n)-\mu\,\ell^{2n}-(a+b)\,n\,\ell^{n}\ \Bigr|\ \le\ C\,\ell^{n}\qquad(n\ge1). \tag{8.2}$$
> *とくに $\mathrm{ord}_\ell(\kappa_n)$ の $\ell^{2n}$ の係数は $\mu=v_\ell(\mathrm{content}_{z,w}\det L(z,w))$、$n\ell^n$ の係数は $a+b$ である。*

**注 8.0.** $(8.1)$ は「$\bar f_1$ の非零単項式 $T^iS^j$ がすべて $i\ge a$ かつ $j\ge b$ を満たし、かつ $T^aS^b$ の係数が $0$ でない」ことと同値で、$\det L$ の係数から**有限手続きで判定できる**。また $f_1(0,0)=\ell^{-\mu}D(1,1)=\ell^{-\mu}\det L_X=0$（$X$ 連結より $\mathrm{rank}\,L_X=m-1$）なので $\bar f_1(0,0)=0$、ゆえに **$a+b\ge1$** が常に従う。さらに $\mu=0$ のときは $(1.2)$ より $f=f_1$ の定数項と 1 次の項が消える（$D(1,1)=0$ と、$(1.2)$ を微分して $z=w=1$ とおくと $\partial_zD(1,1)=\partial_wD(1,1)=0$）ので **$a+b\ge2$** となる。

**証明.**

**(0) 準備.** §6.1 より $D\neq0$、全段連結、$\kappa_n>0$。$(6.3)$, $(6.4)$ より

$$\mathrm{ord}_\ell(\kappa_n)=\mu\,\ell^{2n}+\bigl[v_\ell(\kappa(X))-\mu-2n\bigr]+E_n,\qquad
E_n=\sum_{(\zeta,\xi)\neq(1,1)}v_\ell\bigl(f_1(x_\zeta,y_\xi)\bigr)$$

（$x_\zeta:=\zeta-1$, $y_\xi:=\xi-1$）。角括弧は $O(n)=O(\ell^n)$ なので、$(8.2)$ は

$$\bigl|E_n-(a+b)n\ell^n\bigr|=O(\ell^n) \tag{8.3}$$

に帰着する。

**(1) 単元の持ち上げ.** $\bar U\in\mathbb{F}_\ell[[T,S]]^\times$ すなわち $\bar U(0,0)\neq0$。$\bar U$ の任意の持ち上げ $U\in\Lambda_2$ を取ると $U(0,0)\in\mathbb{Z}_\ell^\times$ であり、$\Lambda_2$ は極大イデアル $(\ell,T,S)$ をもつ完備局所環だから $U\in\Lambda_2^\times$。$(8.1)$ より $f_1-T^aS^bU\in\ell\Lambda_2$、すなわち

$$f_1=T^{a}S^{b}\,U+\ell\,G,\qquad G\in\Lambda_2. \tag{8.4}$$

**(2) 単元の値.** $v_\ell(x),v_\ell(y)>0$ のとき $v_\ell(U(x,y))=0$。実際 $U(x,y)-U(0,0)=\sum_{(i,j)\neq(0,0)}u_{ij}x^iy^j$ の各項は $v_\ell\ge\min(v_\ell(x),v_\ell(y))>0$ で、§6.2 の総和可能性より和も $v_\ell>0$。$v_\ell(U(0,0))=0$ だから強三角不等式で等号。

**(3) good/bad の分割.** $k\ge1$ に対し $\ell^k$ 位の $\zeta$ は $v_\ell(x_\zeta)=1/\varphi(\ell^k)$（$(2.3)$）。

$$K_a:=\Bigl\{k\ge1:\ \frac{a}{\varphi(\ell^{k})}\ge\frac12\Bigr\},\qquad
K_b:=\Bigl\{k\ge1:\ \frac{b}{\varphi(\ell^{k})}\ge\frac12\Bigr\}$$

と置く。$\varphi(\ell^k)\to\infty$ なので $K_a,K_b$ は**有限集合で、$n$ に依らない**。

$$\mathrm{Bad}_n:=\{(\zeta,\xi)\neq(1,1):\ \zeta=1\ \text{または}\ \xi=1\}
\ \cup\ \{\mathrm{ord}(\zeta)\in\ell^{K_a}\}\ \cup\ \{\mathrm{ord}(\xi)\in\ell^{K_b}\},$$

$\mathrm{Good}_n:=\{(\zeta,\xi)\neq(1,1)\}\smallsetminus\mathrm{Bad}_n$ と置く。$\mathrm{Bad}_n$ は、**$n$ に依らない個数の「行」（$\zeta$ を固定した $\ell^n$ 点の集合）と「列」（$\xi$ を固定した集合）の合併**である。実際、行の個数は $1+\sum_{k\in K_a}\varphi(\ell^k)=:c_a$、列の個数は $1+\sum_{k\in K_b}\varphi(\ell^k)=:c_b$ で押さえられ、$c_a,c_b$ は $a,b,\ell$ のみで決まる。とくに $\#\mathrm{Bad}_n\le(c_a+c_b)\ell^{n}$。

**(4) Good 上の値.** $(\zeta,\xi)\in\mathrm{Good}_n$ なら $\zeta,\xi\neq1$ かつ $a\,v_\ell(x_\zeta)<\frac12$, $b\,v_\ell(y_\xi)<\frac12$、よって

$$a\,v_\ell(x_\zeta)+b\,v_\ell(y_\xi)<1 .$$

$(8.4)$ と (2) より $v_\ell(T^aS^bU|_{(x,y)})=a\,v_\ell(x)+b\,v_\ell(y)<1\le v_\ell(\ell G(x,y))$ なので、強三角不等式の等号条件から

$$v_\ell\bigl(f_1(x_\zeta,y_\xi)\bigr)=a\,v_\ell(x_\zeta)+b\,v_\ell(y_\xi)\qquad\bigl((\zeta,\xi)\in\mathrm{Good}_n\bigr). \tag{8.5}$$

**(5) Good 上の和.** $(2.3)$ より $\sum_{\zeta\neq1}v_\ell(x_\zeta)=n$（$\ell^n$ 乗根について）。よって

$$\sum_{\substack{\zeta\neq1,\ \xi\neq1}}\bigl[a\,v_\ell(x_\zeta)+b\,v_\ell(y_\xi)\bigr]
=a(\ell^{n}-1)\,n+b(\ell^{n}-1)\,n=(a+b)\,n\,\ell^{n}-(a+b)n .$$

$\mathrm{Good}_n$ はここから $\mathrm{Bad}_n\cap\{\zeta\neq1,\xi\neq1\}$ を除いたもので、その各点での被加数は $a\,v_\ell(x_\zeta)+b\,v_\ell(y_\xi)\le\frac{a+b}{\ell-1}\le a+b$（$\zeta,\xi\neq1$ なら $v_\ell\le\frac1{\ell-1}$）。除く点は $(c_a+c_b)\ell^n$ 個以下なので

$$\Bigl|\sum_{\mathrm{Good}_n}v_\ell(f_1)\ -\ (a+b)n\ell^{n}\Bigr|\ \le\ (a+b)n+(a+b)(c_a+c_b)\ell^{n}=O(\ell^{n}). \tag{8.6}$$

**(6) Bad 上の和.** $\mathrm{Bad}_n$ は $c_a$ 本の行と $c_b$ 本の列で覆えるので、**1 本の行（列も同様）の寄与が $O(\ell^n)$ であることを、$n$ に依らない定数で示せばよい**。

$\zeta_0$ を固定する（$\zeta_0=1$ または $\mathrm{ord}(\zeta_0)=\ell^{k}$, $k\in K_a$）。$K_0:=\mathbb{Q}_\ell(\zeta_0)$ は $\mathbb{Q}_\ell$ の**有限次**拡大（$k$ は $K_a$ の有限集合に属し $n$ に依らない）、$\mathcal{O}_{K_0}$ をその整数環、$\pi$ を素元とする。$x_0:=\zeta_0-1$ と置き

$$F_{\zeta_0}(S):=f_1(x_0,S)\in\mathcal{O}_{K_0}[[S]]$$

（係数は $f_1$ の係数と $x_0$ の冪の総和可能な和で、$\mathcal{O}_{K_0}$ に入る）。

*$F_{\zeta_0}\neq0$ の確認*: もし $F_{\zeta_0}=0$ なら、任意の $\ell$ 冪根 $\xi$ で $f_1(x_0,y_\xi)=0$、すなわち $D(\zeta_0,\xi)=0$。$(\zeta_0,\xi)\neq(1,1)$ となる $\xi$（$\ell$ 乗根で $\xi\neq1$ を取ればよい）が存在するので、系 B2′ より $X_{\ell^{n_1},\ell^{n_1}}$ が非連結（$n_1=\max(k,1)$）。系 C2′ の仮定に反する。

定理 W1 を $\mathcal{O}_{K_0}[[S]]$ 上で $F_{\zeta_0}$ に適用し（適用条件: $\mathcal{O}_{K_0}$ 完備離散付値環 ✓、$F_{\zeta_0}\neq0$ ✓）、$F_{\zeta_0}=\pi^{t}\,g\,U'$（$g$ distinguished、$\deg g=:\lambda_0$、$U'$ 単元）とすると、$v_\ell(U'(y_\xi))=0$ より

$$\sum_{\xi^{\ell^n}=1}v_\ell\bigl(F_{\zeta_0}(y_\xi)\bigr)
=\ell^{n}\,v_\ell(\pi^{t})+\sum_{\beta:\ g(\beta)=0}v_\ell\bigl(\omega_n(\beta)\bigr). \tag{8.7}$$

$g$ は distinguished なので根 $\beta$ は $v_\ell(\beta)>0$ を満たす（cycle13 report §6.3 と同じ議論: $v_\ell(\beta)\le0$ とすると $\beta^{\lambda_0}=-\sum_{i<\lambda_0}g_i\beta^i$ の両辺の $v_\ell$ が矛盾する）。また $1+\beta$ は $\ell$ 冪位数の 1 の冪根ではない（もしそうなら $F_{\zeta_0}(\beta)=0$ より $D(\zeta_0,1+\beta)=0$ となり、上と同じく系 B2′・系 C2′ に反する）。よって cycle13 report の**補題 E**が各根に適用でき、$n\ge n_\beta$ で $v_\ell(\omega_n(\beta))=n+c_\beta$。根は $\lambda_0$ 個（$n$ に依らない）なので

$$\sum_{\xi^{\ell^n}=1}v_\ell\bigl(F_{\zeta_0}(y_\xi)\bigr)=v_\ell(\pi^t)\,\ell^{n}+\lambda_0\,n+O(1)=O(\ell^{n}). \tag{8.8}$$

ここで $t,\lambda_0,\{n_\beta\},\{c_\beta\}$ はすべて $\zeta_0$（有限個）にのみ依存し $n$ に依存しない。列についても $\xi_0$ を固定して同じ議論をする。行・列の本数 $c_a+c_b$ も $n$ に依らないので

$$\sum_{\mathrm{Bad}_n}v_\ell(f_1)=O(\ell^{n}). \tag{8.9}$$

**(7) 結論.** $(8.6)+(8.9)$ で $(8.3)$、したがって $(8.2)$。$\blacksquare$

**注 8.1（何が効いたか）.** $(8.1)$ は「$f_1$ の $\bmod\ \ell$ 還元が**単項式**」という仮定であり、これによって §7.4 の「零点がねじれ点にどれだけ近いか」という問題が消える: 実際 $\bar f_1$ の零点集合は $\{T=0\}\cup\{S=0\}$（座標軸）だけで、良い点では $v_\ell(f_1)$ が座標の付値だけで**厳密に**決まってしまう。悪い点は座標軸の近傍にしかなく、それは有限本の行・列に収まるので 1 変数の理論で処理できる。

> **機械検証**: Step 5 / Step 5b。$(8.1)$ を満たす塔を 5 件（うち $\mu>0$ が 1 件）検出し、$G_n:=(E_n-(a+b)n\ell^n)/\ell^n$ が有界に見える（増分が増大しない）ことを 5 件すべてで確認。さらに Step 7 の過剰決定フィットで、$\mu>0$ の例
> $$X:\ 2\ \text{頂点},\ \text{平行辺 voltage}\ \{(0,0),(2,0),(1,1),(1,1)\},\ \text{各頂点にループ}\ (1,0)$$
> について $\ell=2$、$\mu=1$、$(a,b)=(2,2)$ であり、$\mathrm{ord}_2(\kappa_n)=1\cdot4^{n}+4\,n\,2^{n}+9\cdot2^{n}-6n-8$ が $n=2,\dots,7$ で**厳密に成立**した（$n=0,1$ では成立しないので $n_0=2$）。定理 3′ の予測（$\ell^{2n}$ の係数 $=\mu=1$、$n\ell^n$ の係数 $=a+b=4$）と一致する。

---

## 9. 数値検証

`sagemath/check/cycle14_T3_Zl2_tower/`（SageMath 10.6、`sage zl2_tower.sage`）。例は明示 15 件＋乱択 30 件＝45 件。

| Step | 検証内容 | 対応する主張 | 結果 |
|---|---|---|---|
| 1 | $\det(xI-L_{X_{N,N'}})=\prod_{\zeta,\xi}\det(xI_m-L(\zeta,\xi))$（円分体上の厳密等式） | 補題 A2 | 315 件、不一致 0 |
| 2 | $c(X_{N,N'})=\sum_{\zeta,\xi}\dim\ker L(\zeta,\xi)$ と $\Lambda_X+(N\mathbb{Z}\times N'\mathbb{Z})=\mathbb{Z}^2$ 判定 | 補題 B2, C2 | 405 件（非連結 143 件）、不一致 0 |
| 3 | $NN'\kappa(X_{N,N'})=\kappa(X)\prod_{(\zeta,\xi)\neq(1,1)}\det L(\zeta,\xi)$（左辺 Kirchhoff、右辺 終結式、独立計算） | 定理 1′ | 450 件（両辺 0 の退化 142 件を含む）、不一致 0 |
| 4(i) | $E_n\ge0$ | 定理 2′ | 86 塔、違反 0 |
| 4(ii) | $E_n/\ell^{2n}$ が末尾 3 点で減少 | 主要項 $=\mu$ の支持 | 86 塔、例外 0 |
| 4(iii) | 6 点以上が $a\ell^{2n}+bn\ell^n+c\ell^n+dn+e$ に厳密に乗るか、乗るなら $a=\mu$ か | Greenberg 形＋主要項 | 14 塔で厳密に乗り、**14 塔すべてで $a=\mu$** |
| 4c | $\mathrm{ord}_\ell(\kappa_n)$ を導来グラフ直接（Kirchhoff）と終結式で独立計算し照合 | 定理 1′ の独立確認 | 299 件、不一致 0 |
| 5 / 5b | $(8.1)$ を満たす塔で $G_n=(E_n-(a+b)n\ell^n)/\ell^n$ が有界か | 定理 3′ | 5 塔（$\mu>0$ 1 件を含む）、増分の増大 0 |
| 6 | $\mu=0$ でも $\ell\nmid(N,N')$ の段で $v_\ell(\kappa(X_{N,N'}))>0$ になる witness | §10 の射程外 | 484 件中 **203 件** |
| 7 | 明示例の Greenberg 係数 $(a,b,c,d,e)$ の全出力 | — | 10 塔、すべて $a=\mu$ |

**探索・標本範囲（明示する）**: $\ell\in\{2,3,5\}$、塔の段は $\ell=2$ で $n\le7$、$\ell=3$ で $n\le4$、$\ell=5$ で $n\le3$。$(N,N')$ は Step 1–3 で $\{1,\dots,6\}^2$ の 10 通り以内、頂点数 $mNN'\le220$。乱択は頂点数 $\le3$、辺数 $2$–$5$、voltage 成分 $\in\{-2,\dots,2\}$、seed 固定（20260726）。Step 5b の探索は 2 頂点・平行辺 voltage $\subset\{(0,0),(1,0),(2,0),(0,1),(1,1)\}$（本数 3–4）＋各頂点ループ voltage $\in\{(1,0),(0,1),(1,1)\}$ の **945 件**で、$\mu>0$ かつ $(8.1)$ を満たす非自明例は **1 件**だった。

**これらは有限個の例での照合であって証明ではない。** 証明本体は §3–§6, §8 である。数値検証の役割は、証明の書き間違い（符号・添字・場合分けの取りこぼし）の検出と、**証明できていない §7 の部分について予想が破れていないかを見ること**に限られる。

### 9.1 Greenberg 係数の実測（Step 7、$\ell=2$）

$\mathrm{ord}_2(\kappa_n)=a\,4^{n}+b\,n\,2^{n}+c\,2^{n}+d\,n+e$（$n\le7$ の 8 点のうち、末尾から取った 6 点以上が厳密に乗った塔のみ。「$n\ge n_0$」欄はその式が実際に成立し始める段）:

| 底グラフ | $\mu$ | $(a,b,c,d,e)$ | $n\ge n_0$ | $a=\mu$ |
|---|---|---|---|---|
| $L\times L$ トーラス（1 頂点、ループ $(1,0),(0,1)$） | 0 | $(0,2,4,-6,-1)$ | $1$ | ✓ |
| 1 頂点、ループ $(1,0)$＋$(0,1)\times2$ | 0 | $(0,2,0,2,1)$ | $2$ | ✓ |
| 1 頂点、ループ $(1,0)$＋$(0,1)\times3$ | 0 | $(0,2,4,-2,-4)$ | $0$ | ✓ |
| 1 頂点、ループ $(1,0),(0,1),(1,1)$ | 0 | $(0,3,9,-8,-9)$ | $0$ | ✓ |
| 1 頂点、ループ $(1,0),(0,1),(1,-1)$ | 0 | $(0,3,9,-8,-9)$ | $0$ | ✓ |
| 2 頂点、平行辺 $(0,0),(1,0),(2,0)$＋ループ | 0 | $(0,4,6,-14,18)$ | $2$ | ✓ |
| 2 頂点、平行辺 $(0,0),(1,0),(1,1)$＋ループ | 0 | $(0,2,2,0,-2)$ | $0$ | ✓ |
| **2 頂点、平行辺 $(0,0),(2,0),(1,1),(1,1)$＋ループ $(1,0)$**（$\mu>0$） | **1** | $(1,4,9,-6,-8)$ | $2$ | ✓ |
| 2 頂点、平行辺 $(0,0),(1,0),(0,1),(1,1)$ | 0 | $(0,4,8,-6,-6)$ | $0$ | ✓ |
| 3 頂点サイクル＋voltage | 0 | $(0,0,9,-2,-6)$ | $0$ | ✓ |

### 9.2 $L\times L$ トーラス（本プロジェクトの対象）

底グラフ $=$ 1 頂点・ループ voltage $(1,0),(0,1)$。$X_{N,N}$ はちょうど $N\times N$ 離散トーラス、$\kappa(X_{N,N})=\tau(N)$（cycle 11 T1 の $\tau(L)$）。

$$D(z,w)=4-z-z^{-1}-w-w^{-1},\qquad \mathrm{content}=1,\ \ \mu_\ell=0\ (\forall\ell).$$

$\Lambda_X=\langle(1,0),(0,1)\rangle=\mathbb{Z}^2$ なので全ての $(N,N')$ で $X_{N,N'}$ は連結（補題 C2）。実測（$n=0,\dots,7$）:

$$\mathrm{ord}_2(\tau(2^{n}))=0,\ 5,\ 19,\ 61,\ 167,\ 417,\ 987,\ 2261 .$$

$n=1,\dots,7$ の 7 点が

$$\mathrm{ord}_2\bigl(\tau(2^{n})\bigr)=2\,n\,2^{n}+4\cdot2^{n}-6n-1 \tag{9.1}$$

に**厳密に乗る**（$n=0$ では乗らないので $n_0\le1$）。$\ell=3$ では $n\le4$ で $\mathrm{ord}_3=0,6,28,98,312$。

$(9.1)$ は $\ell^{2n}$ の項をもたない、すなわち主要項の係数 $=0=\mu$ であり、予想と整合する。**ただしこれは 7 点での一致であって証明ではない**（§12-1）。なお $(9.1)$ は cycle 11 T1 の観察「奇 $L$ で $v_2(\tau(L))=2(L-1)$」の $L=2^n$（偶数側）版に当たり、cycle13 report §10 が「観察 T の一般化」として残した課題に数値を与える。

### 9.3 トーラスは定理 3′ の仮定を満たさない（重要な限界）

$\ell=2$ で $\mu=0$、$f_1=f=D(1+T,1+S)$。$\bmod\ 2$ では $4\equiv0$, $-1\equiv1$ なので

$$D\equiv z+z^{-1}+w+w^{-1}=z^{-1}w^{-1}(z+w)(zw+1)\pmod 2$$

（$(z+w)(zw+1)=z^2w+z+zw^2+w$ を展開して確認）。$z=1+T$, $w=1+S$ を入れると $z+w\equiv T+S$、$zw+1\equiv T+S+TS$ なので

$$\bar f_1=(\text{単元})\cdot(T+S)\,(T+S+TS)\in\mathbb{F}_2[[T,S]] .$$

最低次部分は $(T+S)^2$ で、**単項式ではない**（$T^2$ と $S^2$ が両方現れるので $\min_i=\min_j=0$ だが $T^0S^0$ の係数は $0$）。したがって $(8.1)$ は成立せず、**定理 3′ はトーラスには適用できない**。

一方 §7 の仮定 $(7.1')$・$(7.7)$ は両方成立する: $D(1,w)=2-w-w^{-1}=-w^{-1}(w-1)^2$、$D(z,1)=-z^{-1}(z-1)^2$ でどちらも content $=1=\ell^{\mu}$。$(7.7)$ の $a=\mathrm{ord}_T$ は $2$。よって §7.3 の還元 $(7.10)$ が「$E_n\le2\cdot2^{n}(n+C)$」を与える形まで進むが、$(7.4)$ の境界ケースが実際に起きうる: $D(z,\xi)=0$ は $z+z^{-1}=4-\xi-\xi^{-1}$、すなわち $z^2-(4-\xi-\xi^{-1})z+1=0$ で、$\ell=2$ ではその根 $z$ が $z^2\equiv-1$（$v_2(z^2+1)=2v_2(\xi-1)>0$）を満たすため、$z$ は原始 4 乗根に近い。**すなわちトーラスでは「零点がねじれ点に近づく」現象が実際に起きており、§7.4 の穴は仮想的なものではない。**（数値上は $(9.1)$ のとおり $E_n=O(n2^n)$ で収まっている。）

---

## 10. 退化ケースの総覧（落とさずに扱う）

| ケース | 扱い | 根拠 |
|---|---|---|
| **$X$ が非連結** | $(★_2)$ は $0=0$。塔の不変量は定義されない（$\kappa_n=0$）。 | 定理 1′ (i)、系 B2′ |
| **ある $(\zeta,\xi)\neq(1,1)$ で $\det L(\zeta,\xi)=0$** | $X_{N,N'}$ 非連結と同値。$(★_2)$ は $0=0$。 | 系 B2′ $(3.4)$、定理 1′ (ii) |
| **$\det L(z,w)\equiv0$** | 全ての $(N,N')\neq(1,1)$ で $X_{N,N'}$ 非連結。content 未定義。定理 2′・3′ の仮定に反する。 | §6.1 |
| **$\Lambda_X$ の $\bmod\ \ell$ 階数 $\le1$** | $n\ge1$ の全段が非連結（all-or-nothing）。判定は $2\times2$ 行列の $\bmod\ \ell$ 階数 1 回。 | 補題 C2、系 C2′ |
| **$\Lambda_X\subsetneq\mathbb{Z}^2$ だが $\bmod\ \ell$ で全射** | $\ell$-塔は全段連結。$\ell$ と素な方向の段だけが非連結になりうる。 | 補題 C2 |
| **ループ** | $L(z,w)$ の対角に $2-\mathrm{mon}-\mathrm{mon}^{-1}$ として組み込み済み。$\alpha_e\equiv0$ のとき $X_A$ でループになり寄与 $0$、$L(\chi)$ 側も $\chi(\alpha_e)=1$ で $0$。整合。 | 補題 A2 の証明 case 3 |
| **多重辺** | 各成分が辺ごとの和になっているだけ。証明のどこでも単純性を使っていない。 | §1.4, 定理 K |
| **$\chi(X)=0$ / 次数 1 の頂点** | 定理 1′・2′・3′ の証明では使わない。DuBose–Vallières Theorem A はこの 2 つを仮定する（§11）。**[F] の仮定が冗長だとは主張しない**（[F] の証明のどこで使われるかは確認していない）。 | §4, §6, §8 |
| **$m=1$（bouquet）** | 特別扱い不要。$D=\sum_{(a,b)}m_{ab}\bigl(2-z^aw^b-z^{-a}w^{-b}\bigr)$。 | — |
| **非対角の段 $(N,N')=(\ell^{n},\ell^{n'})$, $n\neq n'$** | 定理 1′ は成立（$(N,N')$ 任意）。**塔の漸近（定理 2′・3′）は対角 $n=n'$ のみ**を扱った。 | §6, §8 |
| **$\ell\nmid N$ の段** | **射程外。**下記。 | — |

### 10.1 $\ell\nmid N$ との違い（$d=1$ と同じ限界が残る）

定理 2′・3′ の証明は $v_\ell(\zeta-1)>0$、すなわち $\zeta,\xi$ が $\ell$ **冪位数**であることを本質的に使う（§6.2 の収束、$(2.3)$、$(8.5)$）。位数が $\ell$ と素なら $\zeta-1$ は $\mathcal{O}$ の単元で、これらはすべて崩れる。

実際、**content は $\ell\nmid(N,N')$ の段を支配しない**。Step 6 の探索（$\mu_\ell=0$ の例と $\ell\nmid N,N'$ の段の組合せ **484 件**）で **203 件**の witness が出た。例:

- $L\times L$ トーラス、$\ell=2$、$(N,N')=(3,3)$: $\mathrm{content}=1$（$\mu_2=0$）だが $v_2(\kappa(X_{3,3}))=4$。
- 同、$\ell=2$、$(5,5)$: $v_2=8$。$(7,7)$: $v_2=12$。$\ell=3$, $(4,4)$: $v_3=4$。

したがって §6・§8 の結果は「$\mathbb{Z}_\ell^2$-塔 $N=N'=\ell^n$ の主要項」についての主張であって、一般の $\mathbb{Z}/N\times\mathbb{Z}/N'$-被覆の $\ell$ 進付値についての主張ではない。（$L\times L$ トーラスの奇 $L$ については cycle 13 step 3 の命題 T が別経路で $v_2(\tau(L))=2(L-1)$ を与えている。）

---

## 11. 新規性について（主張しない）

### 11.1 本セッションで**本文を取得した**文献

**[F] S. DuBose, D. Vallières, *On $\mathbb{Z}_\ell^d$-towers of graphs*, Algebraic Combinatorics 6 (2023) 1331–1346, DOI 10.5802/alco.304.**
`https://www.numdam.org/item/10.5802/alco.304.pdf` から PDF を取得しテキスト化して本文を読んだ。

> **Theorem A (Theorem 6.2).** *Let $X$ be a finite connected graph that has no vertex of degree one and for which its Euler characteristic $\chi(X)\neq0$. Let $X=X_0\leftarrow X_1\leftarrow\cdots$ be a $\mathbb{Z}_\ell^d$-tower of graphs. Then, there exists $P(X,Y)\in\mathbb{Q}[X,Y]$ of total degree at most $d$ and of degree at most 1 in $Y$ such that $\mathrm{ord}_\ell(\kappa_n)=P(\ell^n,n)$, for $n$ large enough, where $\kappa_n$ is the number of spanning trees of $X_n$.*

§6 の Theorem 6.2 の証明は、まさに本レポートの $(★_2)$ に当たる等式

$$\ell^{dn}\cdot\kappa_n=\kappa_X\prod_{\psi\neq\psi_0}h_X(1,\psi)$$

から出発し、$\mathrm{ord}_\ell(\kappa_n)=-dn+\mathrm{ord}_\ell(\kappa_X)+\sum_{\xi\in W^\ast}v_\ell(Q(1-\xi))$ と書き直したうえで、**Monsky [14, Theorem 5.6]** を引用して $\sum_{\xi\in W^\ast}v_\ell(Q(1-\xi))=E(\ell^n,n)$ を得ている。すなわち、

- 本レポート §4（定理 1′）＝ [F] の出発点の等式に対応する。
- 本レポート §7 で詰まった部分＝ [F] が Monsky Theorem 5.6 で処理している部分に、ちょうど対応する。

**さらに、[F] Theorem 6.1 の岩澤冪級数 $Q(T)$ の定義が本文で確認できた**（cycle13 report §10-1 が
「$Q(T)$ の定義そのものは確認していない」として保留していた点が、[F] については解消した）:

> $Q(T)=\det(D-A_\rho)\in\mathbb{Z}_\ell[[T]]$、$D$ は $X$ の次数行列、
> $(A_\rho)_{ij}=\sum_{s:\,\mathrm{inc}(s)=(v_i,v_j)}\rho(\alpha(s))+\sum_{s:\,\mathrm{inc}(s)=(v_j,v_i)}\rho(-\alpha(s))$、
> $\rho:\mathbb{Z}_\ell^d\to\mathbb{Z}_\ell[[T_1,\dots,T_d]]^\times$ は $\rho(a)=\prod_i(1+T_i)^{a_i}$。

これは本レポートの $L(z,w)$ に $z=1+T_1$, $w=1+T_2$ を代入したものと**成分ごとに一致する**。実際
対角成分は（ループ 1 本が次数に $2$、$A_\rho$ の対角に $\mathrm{mon}+\mathrm{mon}^{-1}$ を寄与するので）
$2-\mathrm{mon}-\mathrm{mon}^{-1}$、非対角成分は $-\sum\mathrm{mon}-\sum\mathrm{mon}^{-1}$ となり、§1.4 の定義と同じである。すなわち

$$Q(T_1,T_2)=\det L(1+T_1,\,1+T_2)=f(T_1,T_2)\quad(\text{本レポートの記法}).$$

したがって [F] の枠組みと本レポートの $f$ は**同一の冪級数**であり、[F] が引用する Greenberg 係数の
明示公式（下記）は、そのまま本レポートの $f$ についての公式である。

さらに [F] は Theorem 6.2 の直後に次を明記している。

> *"It is known that the coefficients of $X^d$ and of $Y\cdot X^{(d-1)}$ are nonnegative integers. See [14, Remark 2]. There are also explicit formulas for those two coefficients in terms of the power series in several variables. See [1, Definition 1.1] and [1, Definition 1.2]."*
> （[14] = P. Monsky, *On $p$-adic power series*, Math. Ann. 255 (1981) 217–227; [1] = A. Cuoco, P. Monsky, *Class numbers in $\mathbb{Z}_p^d$-extensions*, Math. Ann. 255 (1981) 235–258。）

**したがって、主要項（$X^d$ の係数）と第 2 項（$YX^{d-1}$ の係数）の明示公式は既に文献に存在し、しかも
上で確認したとおりそれは本レポートの $f=\det L(1+T_1,1+T_2)$ についての公式である。** 本レポートの
$\mu=v_\ell(\mathrm{content}_{z,w}\det L)=\mu(f)$ という形はその言い換えとみなすのが自然である
（ただし Cuoco–Monsky Definition 1.1 の本文は未取得なので、文字どおり同一の式かは照合していない。§11.2）。
**新規性は主張しない。**

### 11.2 本文を取得できなかった文献（内容は二次資料経由でしか確認していない）

| 文献 | 試した手段 | 結果 |
|---|---|---|
| P. Monsky, *On $p$-adic power series*, Math. Ann. 255 (1981) 217–227（Theorem 5.6, Remark 2） | Springer Link（購読制）、crossref 経由の PDF リンク（HTML が返る）、GDZ | **本文未取得** |
| A. Cuoco, P. Monsky, *Class numbers in $\mathbb{Z}_p^d$-extensions*, Math. Ann. 255 (1981) 235–258（Definition 1.1, 1.2） | 同上 | **本文未取得** |

二次資料としては、舘野荘平「Cuoco–Monsky 型公式」（研究集会「結び目の数理 VI」報告集、`https://www.math.twcu.ac.jp/~mathsciknot6/msk6_proc/32Tateno.pdf`、本文取得済み）が

- 定理 1.4 (Cuoco–Monsky, 1981) として $e(\mathrm{Cl}(k_{p^n}))=(\mu p^{n}+\lambda n+O(1))\,p^{(d-1)n}$、
- 命題 1.6 ([8, 定理 5.6] ＝ Monsky Theorem 5.6) として「半代数的集合 $S\subset W^d$ と $F\in\Lambda$ に対し、$\deg_V f\le1$・総次数 $\le d$ の $f(U,V)\in\mathbb{Q}[U,V]$ が唯一つ存在して十分大きい $n$ で $\sum_{\zeta\in S\cap W(n)^d}v(F(\zeta-1))=f(p^n,n)$」、
- 定理 3.5 (舘野–植木) として $e(H_1(X_{p^n}))=(\mu(\hat\Delta_\tau)p^{n}+\lambda(\hat\Delta_\tau)n+O(1))p^{(d-1)n}$

を述べている。これらは「主要項の係数が形式冪級数 $F\in\mathbb{Z}_p[[T_1,\dots,T_d]]$ の岩澤 $\mu$ 不変量である」ことを**強く示唆する**が、$\mu(F)$ の定義そのもの（Cuoco–Monsky Definition 1.1 の $m_0$）は**一次文献の本文で確認していない**。したがって

> 「主要項の係数 $=v_\ell(\mathrm{content}_{z,w}\det L)$ が既知の言い換えである」ことは、[F] の上記 remark により**強く裏づけられるが、$m_0$ の定義の本文照合は未了**である。

いずれにせよ **本レポートは新規性を主張しない。** 本レポートの寄与は、cycle13 report と同じ方針で「本プロジェクトの記法・仮定で、外部文献の本文を参照せずに読める証明を、証明できた範囲について与えたこと」と、「証明できなかった範囲を具体的に切り分けたこと」だけである。

### 11.3 [F] の仮定と本レポートの仮定の差

| | [F] Theorem A | 本レポート |
|---|---|---|
| $X$ 連結 | 要 | 要（定理 2′・3′）。定理 1′ は不要 |
| 次数 1 の頂点なし | 要 | 不要（使っていない） |
| $\chi(X)\neq0$ | 要 | 不要（使っていない） |
| 全ての導来グラフが連結 | 要 | 要。ただし補題 C2 により $\Lambda_X+\ell\mathbb{Z}^2=\mathbb{Z}^2$ の 1 回の判定に帰着（決定可能） |
| 結論 | $P(\ell^n,n)$ の存在（$d$ 一般） | 下界（一般）、完全な漸近（単項式還元の場合のみ、$d=2$） |

**[F] が次数 1 の頂点と $\chi(X)\neq0$ をどこで使うのかは確認していない。冗長だとは主張しない。**

---

## 12. 証明できなかったこと・未確認のこと（正直に）

1. **一般の場合の上界 $E_n=O(n\ell^{n})$（＝主要項の係数が $\mu$ に一致すること）は証明できなかった。** 詰まった点は §7.4 の 1 点、「$f_1$ の零点が $\ell$ 冪ねじれ点にどれだけ近づきうるかの、$n$ に一様な下界」である。これは [F] が Monsky Theorem 5.6 で処理している部分に対応する。数値（86 塔で $E_n/\ell^{2n}$ が減少、14 塔で厳密な Greenberg フィットが $a=\mu$）は**証明の代わりにならない**。
2. **定理 W2（完備局所環上の Weierstrass 準備定理）の本文は取得していない。** 標準的事実として §7 でのみ使い、命題番号は挙げていない。**§4・§6・§8 の証明は定理 W2 を使わない**ので、証明済みの結果はこの未確認に依存しない。
3. **Monsky Theorem 5.6 / Remark 2、Cuoco–Monsky Definition 1.1 / 1.2 の本文は取得できなかった**（§11.2）。したがって「主要項の係数の明示公式が既知である」ことは [F] の remark を通じてのみ確認しており、その公式が本レポートの $v_\ell(\mathrm{content})$ と同一かは照合していない。
4. **$n\ell^n$ の係数の一般公式は与えていない。** 単項式還元の場合に $a+b$ であることだけを証明した（定理 3′）。$(7.7)$ の下では §7.3 の $a=\mathrm{ord}_T(\bar c_0)$ が上界を与える形になるが、等式は示していない。
5. **低次の係数 $c,d,e$（$\ell^n$, $n$, 定数の係数）については何も証明していない。** 数値の実測値（§9.1）を挙げただけである。
6. **$n_0$（漸近が成立し始める段）の明示的な上界を与えていない。** 数値では §9.1 の 10 塔で $n_0\le2$（内訳: $n_0=0$ が 6 塔、$1$ が 1 塔、$2$ が 3 塔）だったが、これは証拠であって上界の証明ではない。
7. **非対角の段 $(\ell^{n},\ell^{n'})$（$n\neq n'$）の漸近は扱っていない。** 定理 1′ は任意の $(N,N')$ で成立するが、§6・§8 は対角のみ。
8. **$\ell\nmid N$ 方向は射程外**（§10.1、witness 203 件）。
9. **本プロジェクトの $L\times L$ トーラス自身は定理 3′ の仮定を満たさない**（§9.3）。トーラスについて証明できているのは定理 1′・定理 2′（$\mu=0$ なので下界は自明な $\ge0$）だけで、$(9.1)$ は $n=1,\dots,7$ での厳密一致にすぎない。**$L\times L$ トーラスの $\mathrm{ord}_\ell$ の主要項が $0$ であること自体、本レポートでは証明できていない。**
10. **$\mu$ の上界は何も分かっていない。** Step 5b の探索範囲（945 件）で $\mu>0$ かつ単項式還元の非自明例は 1 件（$\mu_2=1$）だけだったが、これは探索範囲内の事実にすぎない。

---

## 13. cycle 13 との関係、および次への引き継ぎ

- **cycle13 report §10-1（[E] Corollary 5.6 の岩澤冪級数 $Q(T)$ の定義が未確認）は、[F] については解消した。** [F] Theorem 6.1 の $Q(T)=\det(D-A_\rho)$ が本レポートの $\det L(1+T_1,1+T_2)$ と成分ごとに一致することを本文で確認した（§11.1）。
- **cycle13 report §10-8「$d\ge2$ の塔は扱っていない」に応答した。** $(★)$ の 2 変数版（定理 1′）と連結性判定（補題 C2）は完全に持ち上がり、**しかも証明は有限アーベル群一般で書ける**ことが分かった（$d$ に依存しない）。
- **持ち上がらなかったのは岩澤型漸近の上界だけである。** cycle13 の定理 2 は「Weierstrass で根を有限個に落とす」ことに依拠していたが、$d=2$ では (i) Weierstrass の適用に正則性が要り（§7.1）、(ii) 根の個数が $\ell^n$ で増えるため一様評価が要る（§7.2, §7.4）。この 2 点が構造的な差である。
- **判定式は、$\ell^{2n}$ の係数についての「下界」としては無条件に生き残り、単項式還元の下では「等号」として生き残る**（定理 2′・3′）。
### 13.1 同 cycle の T1（`cycle14_T1_vp_growth_two_variable.md`）との関係

同じ cycle 14 の T1 は、$a_L=\prod_{z^L=w^L=1}P(z,w)$（**$(1,1)$ を含む全ての組の積**）を対象に、
$v_p(a_{p^n})>0\iff p\mid P(1,1)$（命題 V）を証明している。**対象が異なる**ので、両者は矛盾しない。

- T1 の $a_L$ は $(1,1)$ の因子 $P(1,1)$ を含む。本レポートの $\kappa_n$ は定理 1′ により
  $(1,1)$ を除いた積であり、しかもラプラシアンでは $D(1,1)=\det L_X=0$ なので
  **T1 の枠組み（$P(1,1)\neq0$ のレジーム）とは排他的**である。T1 の README も
  「$P(1,1)=0$ のレジーム（離散ラプラシアン＝全域木数）は本ディレクトリの対象外」と明記している。
- T1 が「$\mathrm{content}=1$ でも $v_p(a_{p^n})$ が増大する例が 8 件あるので $(☆)$ は $d=2$ へ素朴に
  拡張できない」と述べている点は、本レポートと整合する。$d=2$ では
  $\mathrm{ord}=a\ell^{2n}+b\,n\ell^{n}+\dots$ であり、$\mathrm{content}$ が支配するのは**主要項 $a$ だけ**で、
  $\mathrm{content}=1$（$\mu=0$）でも $b\,n\ell^n$ の増大は残る。実際 T1 の $6-z-w$, $p=2$ の同定
  $n2^n+2^n+n+2$ は $\ell^{2n}$ の項をもたず $a=0=\mu$ である。また T1 の観察
  「$P\mapsto cP$ で $v_p$ にちょうど $v_p(c)p^{2n}$ が加わる」は、まさに主要項の係数が
  $v_p(\mathrm{content})$ であることの $1$ 例である。
- したがって **$d=1$ で「$\mu_\ell=v_\ell(\mathrm{content})$ が $v_\ell$ の増大を支配する」と読めた命題は、
  $d=2$ では「主要項の係数だけを支配する」に弱まる**、というのが両トラック共通の結論である。

- cycle 15 以降の候補:
  1. §7.4 の穴（一様な near-torsion 評価）を、Monsky Theorem 5.6 の本文を取得したうえで埋めるか、$L\times L$ トーラスという**具体的な $D$ に限って**直接評価する。§9.3 のとおりトーラスでは零点が原始 4 乗根に近づくことまで具体的に分かっている。
  2. $(9.1)$（$\mathrm{ord}_2(\tau(2^n))=2n2^n+4\cdot2^n-6n-1$、$n\le7$ で厳密）の証明。cycle 13 step 3 の命題 T（奇 $L$）と合わせると、$\tau(L)$ の $2$ 進付値が偶奇両側で決まることになる。
  3. `002_R_Lambda_duality.md` の $p$ 素点側の訂正に、本レポートの定理 2′（下界は無条件）と §11 の [F] Theorem A 本文を反映する。
