# cycle 14 / T3 Pure: 判定式の $\mathbb{Z}_\ell^2$-塔（$d=2$）への拡張

> **本 report は 2 つの独立な導出のうちの第 1 経路である。**
> cycle 14 step 1 は起動事故により 2 回走り、同じ課題を**互いを参照せずに**解いた。
> もう一方は `cycle14_T3_Zl2_tower_criterion.md`（第 2 経路）。
> 両者が一致した点: $(★_2)$ の証明、連結性の判定条件、**下界 $a\ge v_\ell(\mathrm{content})$ は自前で証明できるが
> 上界 $a\le v_\ell(\mathrm{content})$ は自前では証明できない**という境界、および新規性を主張しないこと。
> 相違点: 本経路は非退化条件（$H$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたない）の下で
> **完全な閉形式**（定理 5）を出し、第 2 経路は単項式還元の仮定の下で主要 2 項を出している。
> 独立に同じ境界へ到達したことは、境界の位置づけの信頼性を高める。


対象: cycle 13 step 2（`cycle13_T3_mu_content_criterion_proof.md`）の証明機構を $d=2$ へ拡張する。
cycle 13 の結果は $d=1$ 限定で、本プロジェクトの $L\times L$ トーラスには適用できなかった（同 report §10-8）。

前提として読んでいる一次情報:
`cycle13_T3_mu_content_criterion_proof.md`（$d=1$ の定理 1–3、補題 A–E）、
`cycle13_T1_padic_entropy_generality.md` §3.5、
`cycle14_T1_vp_growth_two_variable.md`（命題 V、$d=2$ での content 判定式の反例、レジームの三分法）。

---

## 0. 結論（先に置く）

| 主張 | 状態 |
|---|---|
| $(★_2)$ $\;N N'\,\kappa(X_{N,N'})=\kappa(X)\prod_{(\zeta,\xi)\neq(1,1)}\det L(\zeta,\xi)$ | **証明した**（§4 定理 1）。cycle 13 定理 1 の証明が 2 重の離散 Fourier に置き換わるだけで通る。連結性の仮定は不要（退化ケースは両辺 $0$）。 |
| 退化ケースの決定手続き（$X_{N,N'}$ の連結性） | **証明した**（§3 補題 C2）。$d=1$ の $\gcd$ 判定は、$d=2$ では**基本閉路 voltage が生成する $\mathbb{Z}^2$ の部分格子 $B$ について $B+(N\mathbb{Z}\oplus N'\mathbb{Z})=\mathbb{Z}^2$** に置き換わる（Smith 標準形で決定可能）。$\ell$-塔での all-or-nothing も成立（系 C2′）。 |
| $\ell^{2n}$ の係数 $a$ について $a\ge v_\ell(\mathrm{content}_{z,w}\det L)$ | **証明した**（§6 定理 3）。外部定理は「$\mathrm{ord}_\ell(\kappa_n)$ が $(\ell^n,n)$ の多項式で書ける」ことだけに使う。 |
| $a=v_\ell(\mathrm{content}_{z,w}\det L)$ | **成立する。ただし本レポートの証明ではなく、既知定理の帰結である**（§7 定理 4）。Cuoco–Monsky の $m_0$-不変量の定理そのもの。**下から抑える向き（定理 3）は自前で証明したが、上から抑える向きは証明できなかった**（§9-1 に詰まった箇所を具体化した）。 |
| **非退化な塔での完全な閉形式** $\;\mathrm{ord}_\ell(\kappa_n)=\mu\,\ell^{2n}+\dfrac{k(\ell+1)}{\ell-1}\,\ell^{n}-2n+\nu$ | **証明した**（§8 定理 5）。非退化条件は「$f=\det L(1+T,1+S)$ の $\bmod\,\ell$ 還元の最低次斉次部分 $H$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたない」で、**係数の有限計算で判定できる**。$k=\mathrm{ord}(\bar f)$。 |
| $d=1$ の判定式 $(☆)$ の素朴な移植 | **誤り**。$d=1$ では content が $\mathrm{ord}_\ell(\kappa_n)$ の**線形項**（唯一の主要項）の係数だったが、$d=2$ では content が与えるのは $\ell^{2n}$ の係数であって、その下に $n\ell^n$ 項と $\ell^n$ 項が独立に存在する。cycle14 step 1（命題 V の report）§4 の警告を、グラフの場合に確定させた（§7.3）。 |
| $L\times L$ トーラスの $\ell=2$ 塔（本プロジェクトの主対象） | **定理 5 の射程外**。$H=-(T^2+S^2)\equiv-(T+S)^2\ (\bmod 2)$ が $\mathbb{P}^1(\mathbb{F}_2)$ 有理零点をもつので退化ケースであり、実際 $n2^n$ 項が現れる（注 8.7、注 8.9）。$\ell=3,7$ など $-1$ が非平方な素数では定理 5 が完全な答えを与える。 |
| 命題 V との関係 | グラフの場合は $\det L(1,1)=0$ なので**命題 V の仮定 $P(1,1)\neq0$ の外側**（トーラス零点レジーム）。§7.4 で確認した。 |
| 新規性 | **主張しない**（§10）。漸近形は DuBose–Vallières Theorem A（本文取得済み・引用）、$\ell^{2n}$ 係数の明示公式は Cuoco–Monsky Definition 1.1 / Theorem 1.7（Kataoka arXiv:2606.03579 の本文で命題番号・定義まで確認）。$\ell^n$ 係数の明示公式（定理 5）は文献で見つけられなかったが、網羅調査ではないので新規性は主張しない。 |

---

## 1. 設定（記号をすべて明示する）

cycle 13 §1 の 1 変数版を、voltage の値域を $\mathbb{Z}$ から $\mathbb{Z}^2$ に替えて書き下す。

### 1.1 底グラフと voltage

- $X$: **有限多重グラフ**。頂点集合 $V=\{1,\dots,m\}$（$m\ge1$）、辺の有限重複集合 $E$。多重辺・ループを許す。
- 各辺 $e\in E$ に**向きを固定**し、始点 $o(e)$・終点 $t(e)$ を定める。
- **voltage 割り当て** $\alpha:E\to\mathbb{Z}^2$。$\alpha_e=(\alpha_e^{(1)},\alpha_e^{(2)})$ と書き、辺を $(o(e),t(e),\alpha_e)$ と表記する。
- 向きの反転（$\alpha_e\mapsto-\alpha_e$）で以下の $L(z,w)$ は不変である（§1.4 の定義から直ちに従う）。

### 1.2 導来グラフ

$N,N'\in\mathbb{Z}_{\ge1}$ に対し**導来グラフ** $X_{N,N'}$ を次で定める。

- 頂点集合 $V\times(\mathbb{Z}/N)\times(\mathbb{Z}/N')$。
- 各辺 $e=(u,v,(a,b))\in E$ と各 $(i,j)\in(\mathbb{Z}/N)\times(\mathbb{Z}/N')$ に対し、
  $(u,i,j)$ と $(v,\,i+a\bmod N,\,j+b\bmod N')$ を結ぶ辺 $e_{i,j}$ を 1 本置く。

$X_{N,N'}$ は $mNN'$ 頂点・$|E|NN'$ 辺の有限多重グラフである（$u=v$ かつ $a\equiv0\ (N)$ かつ $b\equiv0\ (N')$ のときに限り $e_{i,j}$ はループ）。$X_{1,1}=X$。

$N=N'=\ell^n$（$n=0,1,2,\dots$）の列を **$\mathbb{Z}_\ell^2$-塔**と呼び、$\kappa_n:=\kappa(X_{\ell^n,\ell^n})$ と書く。
これは DuBose–Vallières の定義（[F] Definition 4.1: $\mathrm{Gal}(X_n/X)\simeq(\mathbb{Z}/\ell^n\mathbb{Z})^d$）で $d=2$ とした場合そのものである（§2.3）。

### 1.3 ラプラシアン

有限多重グラフ $G$（ループ可）のラプラシアン $L_G$ は cycle 13 §1.3 と同じ:

$$(L_Gv)(x)=\sum_{\substack{\text{$x$ に接続する}\\ \text{辺の端 }(e,x)}}\bigl(v(x)-v(x'_e)\bigr) \tag{1.1}$$

（$x'_e$ は $e$ の $x$ と反対側の端点。ループなら $x'_e=x$ で項は $0$、すなわちループは寄与しない。）

### 1.4 2 変数 voltage ラプラシアン

$\mathbb{Z}[z^{\pm1},w^{\pm1}]$ 係数の $m\times m$ 行列 $L(z,w)$ を、各辺の寄与を足し上げて定める。$e=(u,v,(a,b))$ に対し $\mathbf m_e:=z^{a}w^{b}$ と置き、

- $u\neq v$ のとき: $L_{uu}\mathrel{+}=1$, $L_{vv}\mathrel{+}=1$, $L_{uv}\mathrel{-}=\mathbf m_e$, $L_{vu}\mathrel{-}=\mathbf m_e^{-1}$。
- $u=v$（ループ）のとき: $L_{uu}\mathrel{+}=2-\mathbf m_e-\mathbf m_e^{-1}$。

$D(z,w):=\det L(z,w)\in\mathbb{Z}[z^{\pm1},w^{\pm1}]$ と置く。定義から直ちに $L(1,1)=L_X$（ループの寄与は $2-1-1=0$）であり、
$X$ が連結なら $\mathrm{rank}\,L_X=m-1$ なので

$$D(1,1)=\det L_X=0 \tag{1.2}$$

が**常に**成り立つ（$m=1$ なら $L_X$ は $1\times1$ の零行列で $\det=0$）。この $(1.2)$ が、本レポートが cycle14 step 1 の命題 V の外側にあることの理由である（§7.4）。

### 1.5 content・付値・冪級数環

- $0\neq F\in\mathbb{Z}[z^{\pm1},w^{\pm1}]$ に対し $\mathrm{content}_{z,w}(F):=\gcd\{\text{$F$ の係数}\}\in\mathbb{Z}_{>0}$。
- $v_\ell$ は $\mathbb{Q}$ 上の $\ell$ 進付値（$v_\ell(\ell)=1$）を $\overline{\mathbb{Q}}_\ell$・$\mathbb{C}_\ell$ 上へ一意に延長したもの。$\mathcal O=\{x:v_\ell(x)\ge0\}$、$\mathfrak m=\{x:v_\ell(x)>0\}$、剰余体 $\mathcal O/\mathfrak m=\overline{\mathbb{F}}_\ell$。
- $\Lambda_2:=\mathbb{Z}_\ell[[T,S]]$。$0\neq f=\sum_{i,j}c_{ij}T^iS^j\in\Lambda_2$ に対し $\mu(f):=\min_{i,j}v_\ell(c_{ij})$。
- $\kappa(G)$ は $G$ の全域木の個数（非連結なら $0$、1 頂点なら $1$）。
- $\varphi$ は Euler の $\varphi$ 関数。

---

## 2. 使う既知定理と、その適用条件

外部から使うのは以下の 5 つだけである。**毎回、適用条件を満たすことを確認してから使う。**

### 定理 K（Kirchhoff の matrix-tree 定理）と系 K′

cycle 13 §2 と同一。$G$ を $n\ge1$ 頂点の有限多重グラフ（ループ可）とすると、$L_G$ の固有値を $0=\lambda_1\le\lambda_2\le\dots\le\lambda_n$ として

$$\prod_{j=2}^{n}\lambda_j=n\,\kappa(G). \tag{2.1}$$

（証明は cycle 13 §2 に完全に書いてある: $\det(xI-L_G)$ の $x^1$ の係数を 2 通りに展開し、定理 K で全ての $(n-1)$ 次主小行列式の和 $=n\kappa(G)$ を使う。$L_G$ は半正定値対称で全 1 ベクトルが核に入るので $\lambda_1=0$ と取れる。$G$ が非連結なら $\lambda_2=0$ で両辺 $0$。）

### 定理 W（$\ell$ 進 Weierstrass 準備定理、1 変数）

$0\neq f=\sum_{j\ge0}c_jT^j\in\Lambda_1=\mathbb{Z}_\ell[[T]]$、$\mu:=\min_jv_\ell(c_j)$ に対し
$f=\ell^\mu g U$（$g$ は distinguished 多項式、$U\in\Lambda_1^\times$）と一意に書け、
$\lambda_{\mathrm W}:=\deg g=\min\{j:v_\ell(c_j)=\mu\}$。
（L. Washington, *Introduction to Cyclotomic Fields* 2nd ed., Theorem 7.3。$\lambda_{\mathrm W}$ の式の確認は cycle 13 §2 に書いてある。）**適用条件は $f\neq0$。**

### 補足 W′（$\mu$ は付値である）

$\Lambda_d/\ell\Lambda_d=\mathbb{F}_\ell[[T_1,\dots,T_d]]$ は整域なので、$\mu(f_1f_2)=\mu(f_1)+\mu(f_2)$、$\mu(U)=0$（$U\in\Lambda_d^\times$）。
**これは $d=2$ でもそのまま成立する**（$\ell^{-\mu(f_i)}f_i\notin\ell\Lambda_2$ で、$\mathbb{F}_\ell[[T,S]]$ が整域だから積も $\ell\Lambda_2$ に入らない）。§5 で使う。

### 定理 M（Monsky の $\ell$ 進冪級数補題）と定理 CM（Cuoco–Monsky の主要係数）

$\Gamma\simeq\mathbb{Z}_\ell^d$、$\Gamma_n=\Gamma/\Gamma^{\ell^n}$、$\widehat\Gamma$ を $\Gamma$ の（$\overline{\mathbb{Q}}_\ell^\times$ 値）有限指標の群、$\widehat{\Gamma_n}\subset\widehat\Gamma$ を $\Gamma_n$ の指標のなす部分群とする。Serre の同型 $\mathbb{Z}_\ell[[\Gamma]]\simeq\Lambda_d$（$\sigma_i\mapsto1+T_i$）で $f\in\mathbb{Z}_\ell[[\Gamma]]$ を冪級数と同一視する。

> **定理 M**（Monsky, *On $p$-adic power series*, Math. Ann. **255** (1981) 217–227, Theorem 5.6）
> *$f\in\mathbb{Z}_\ell[[\Gamma]]$、$S\subset\widehat\Gamma$ を semi-algebraic 部分集合とする。このとき有理数 $\lambda,\mu,\lambda_1,\mu_1,\dots,\lambda_{d-1},\mu_{d-1},\nu$ が存在して、$n\gg0$ で*
> $$\sum_{\substack{\chi\in S\cap\widehat{\Gamma_n}\\ \chi(f)\neq0}}\mathrm{ord}_\ell(\chi(f))
> =(\lambda n+\mu\ell^{n})\ell^{(d-1)n}+\sum_{i=1}^{d-1}(\lambda_i n+\mu_i\ell^{n})\ell^{(d-1-i)n}+\nu .$$

> **定理 CM**（Cuoco–Monsky, *Class numbers in $\mathbf{Z}_p^d$-extensions*, Math. Ann. **255** (1981) 235–258, Theorem 1.7）
> *$0\neq f\in\mathbb{Z}_\ell[[\Gamma]]$ とする。定理 M で $S=\widehat\Gamma$ のとき*
> $$\lambda=l_0(f),\qquad \mu=m_0(f),$$
> *であり、とくにこれらは非負整数である。ここで（[1] Definitions 1.1, 1.2）$m_0(f)$ は $\ell^{-m_0(f)}f\in\mathbb{Z}_\ell[[\Gamma]]\smallsetminus\ell\,\mathbb{Z}_\ell[[\Gamma]]$ で定まる非負整数、$l_0(f):=l_0(\overline{\ell^{-m_0(f)}f})$、$0\neq \bar h\in\mathbb{F}_\ell[[\Gamma]]$ に対し $l_0(\bar h)=\sum_P\mathrm{ord}_P(\bar h)$（$P$ は $\mathbb{F}_\ell[[\Gamma]]$ の $(\gamma-1)$（$\gamma\in\Gamma\smallsetminus\Gamma^{\ell}$）の形の素イデアルを走る）。*

**取得状況（重要）**: Monsky と Cuoco–Monsky の**原論文本文は取得できなかった**（Springer 購読制、GDZ / EUDML も本文へ到達せず。試した URL は §10 に記録）。上の 2 つの文言は、**T. Kataoka, *An Iwasawa-type asymptotic formula for multiple $\mathbb{Z}_p$-coverings of graphs*, arXiv:2606.03579v1（2026-06-02）の本文で確認した**（同 Theorem 2.1 = Monsky Thm 5.6、Definition 2.2 = CM Definitions 1.1/1.2、Theorem 2.3 = CM Theorem 1.7）。すなわち**孫引きではなく、再掲している論文の本文で命題番号・定義の文言まで確認した**が、原論文本文そのものは未確認である。

**$m_0$ の意味の確認**: 定義 $\ell^{-m_0(f)}f\notin\ell\mathbb{Z}_\ell[[\Gamma]]$ は、Serre の同型で冪級数に移すと「$\ell^{-m_0(f)}f$ の係数のどれかが $\ell$ で割れない」ことなので

$$m_0(f)=\mu(f)=\min_{i,j}v_\ell(c_{ij})\qquad (f=\textstyle\sum c_{ij}T^iS^j). \tag{2.2}$$

### 定理 DV（DuBose–Vallières）

> **定理 DV**（S. DuBose, D. Vallières, *On $\mathbb{Z}_\ell^d$-towers of graphs*, Algebraic Combinatorics **6** (2023) 1331–1346, DOI 10.5802/alco.304, Theorem A = Theorem 6.2）
> *$X$ を**次数 1 の頂点をもたない**有限連結グラフで **$\chi(X)\neq0$** とし、$X=X_0\leftarrow X_1\leftarrow\cdots$ を $\mathbb{Z}_\ell^d$-塔（$\mathrm{Gal}(X_n/X)\simeq(\mathbb{Z}/\ell^n\mathbb{Z})^d$、全ての層が連結）とする。このとき $X$ について総次数 $\le d$、$Y$ について次数 $\le1$ の $P(X,Y)\in\mathbb{Q}[X,Y]$ が存在して、$n$ が十分大きいとき $\mathrm{ord}_\ell(\kappa_n)=P(\ell^n,n)$。*

**本文取得済み**（`https://www.numdam.org/item/10.5802/alco.304.pdf` から PDF を取得し、Theorem A（p.1332）・Theorem 6.1・Theorem 6.2（p.1339–1340）・§7 の数値例（p.1341–1344）を読んだ）。証明は Ihara ゼータ／Artin–Ihara $L$ 函数の $u=1$ での特殊値（同 (12): $|G|\kappa_Y=\kappa_X\prod_{\psi\neq\psi_0}h_X(1,\psi)$、$\chi(X)\neq0$ を仮定）と定理 M を組み合わせるもの。

**同 Theorem 6.2 直後の Remark（本文 p.1341、原文）**:
"It is known that the coefficients of $X^d$ and of $Y\cdot X^{(d-1)}$ are nonnegative integers. See [14, Remark 2]. There are also explicit formulas for those two coefficients in terms of the power series in several variables. See [1, Definition 1.1] and [1, Definition 1.2]."
（[14] = Monsky, [1] = Cuoco–Monsky。）**すなわち $X^d$ と $YX^{d-1}$ の係数の明示公式が既知であることは、DuBose–Vallières 自身が本文で明言している。**

### 定理 It1（$d=1$ の和の公式・本プロジェクト内で証明済み）

> **定理 It1.** *$0\neq f\in\Lambda_1$、$\mu_1:=\mu(f)$、$\lambda_{\mathrm W}:=$ 定理 W の $\deg g$ とする。さらに**任意の $\ell$ 冪位数の $1$ の冪根 $\zeta\neq1$ で $f(\zeta-1)\neq0$** を仮定する。このとき $n_0\ge1$ と $C\in\mathbb{Q}$ が存在して*
> $$\sum_{\zeta^{\ell^n}=1,\ \zeta\neq1}v_\ell\bigl(f(\zeta-1)\bigr)=(\ell^{n}-1)\mu_1+\lambda_{\mathrm W}\,n+C\qquad(n\ge n_0). \tag{2.3}$$

これは cycle 13 report §6.2–§6.4 で完全に証明されている内容そのものである（同 $(6.5)$–$(6.8)$）。骨子だけ再掲する（cycle 13 の証明は $f=D(1+T)$ という出自を一切使っておらず、上の形の一般の $f$ に対する主張として読める）:
$f=\ell^{\mu_1}gU$、$g=T^sh$（$h$ は distinguished、$h(0)\neq0$、$\deg h=\lambda_{\mathrm W}-s$）と分解し、
$v_\ell(\zeta-1)=1/\varphi(\ell^k)>0$（$\zeta$ が原始 $\ell^k$ 乗根）と $\sum_{\zeta\neq1}v_\ell(\zeta-1)=n$、
$v_\ell(U(\zeta-1))=0$、$\prod_{\zeta^{\ell^n}=1}h(\zeta-1)=\pm\prod_t\omega_n(\beta_t)$（$\omega_n(T)=(1+T)^{\ell^n}-1$、$\beta_t$ は $h$ の根）
を使い、最後に補題 E を各 $\beta_t$ に適用する。

> **補題 E**（cycle 13 §6.3 で証明済み）. *$\beta\in\mathbb{C}_\ell$ が $v_\ell(\beta)>0$ かつ $1+\beta$ が $\ell$ 冪位数の $1$ の冪根でないなら、$n_\beta\ge0$, $c_\beta\in\mathbb{Q}$ が存在して $v_\ell(\omega_n(\beta))=n+c_\beta$（$n\ge n_\beta$）。*

補題 E の適用条件（$h$ の根 $\beta$ が $v_\ell(\beta)>0$ を満たし、$1+\beta$ が $\ell$ 冪根でないこと）は cycle 13 §6.3 末尾で確認されている。前者は $h$ が distinguished であることから、後者は上の「$f(\zeta-1)\neq0$」の仮定から従う。

---

## 3. 補題 A2・B2・C2（対角化・連結性・退化ケースの決定手続き）

### 補題 A2（2 重離散 Fourier によるブロック対角化）

> *任意の有限 voltage 多重グラフ $(X,\alpha)$（$\alpha:E\to\mathbb{Z}^2$）と $N,N'\ge1$ に対し、$\mathbb{C}$ 上の線形写像として*
> $$L_{X_{N,N'}}\ \cong\ \bigoplus_{\zeta^N=1}\ \bigoplus_{\xi^{N'}=1} L(\zeta,\xi),$$
> *すなわち*
> $$\det\bigl(xI-L_{X_{N,N'}}\bigr)=\prod_{\zeta^N=1}\prod_{\xi^{N'}=1}\det\bigl(xI_m-L(\zeta,\xi)\bigr). \tag{3.1}$$

**証明.** $\zeta^N=1$, $\xi^{N'}=1$, $x\in\mathbb{C}^V$ に対し $v_{\zeta,\xi,x}\in\mathbb{C}^{V\times(\mathbb{Z}/N)\times(\mathbb{Z}/N')}$ を

$$v_{\zeta,\xi,x}(u,i,j):=\zeta^{\,i}\xi^{\,j}x_u$$

で定める（$\zeta^N=\xi^{N'}=1$ より $(i,j)\in(\mathbb{Z}/N)\times(\mathbb{Z}/N')$ に関して well-defined）。$(1.1)$ で $L_{X_{N,N'}}$ を計算する。頂点 $(u,i,j)$ に接続する $X_{N,N'}$ の辺の端は、$X$ の辺ごとに次の 3 種で尽くされる（$X_{N,N'}$ の辺の定義から、$(u,i,j)$ を端点にもつ辺は「始点が $(u,i,j)$ であるもの」と「終点が $(u,i,j)$ であるもの」に分かれる）。

1. $e=(u,v,(a,b))\in E$、$u\neq v$: 辺 $e_{i,j}$ が $(u,i,j)$—$(v,i+a,j+b)$。寄与は
   $v_{\zeta,\xi,x}(u,i,j)-v_{\zeta,\xi,x}(v,i+a,j+b)=\zeta^i\xi^j\bigl(x_u-\zeta^{a}\xi^{b}x_v\bigr)$。
2. $e=(v,u,(a,b))\in E$、$u\neq v$: 辺 $e_{i-a,j-b}$ が $(v,i-a,j-b)$—$(u,i,j)$。寄与は
   $\zeta^i\xi^j\bigl(x_u-\zeta^{-a}\xi^{-b}x_v\bigr)$。
3. $e=(u,u,(a,b))\in E$: 辺 $e_{i,j}$（$(u,i,j)$—$(u,i+a,j+b)$）と辺 $e_{i-a,j-b}$（$(u,i-a,j-b)$—$(u,i,j)$）の 2 つの端。寄与の和は $\zeta^i\xi^jx_u\bigl(2-\zeta^{a}\xi^{b}-\zeta^{-a}\xi^{-b}\bigr)$。
   （$a\equiv0\ (N)$ かつ $b\equiv0\ (N')$ のときこれらはループで寄与 $0$、右辺も $\zeta^a\xi^b=1$ より $0$。一致する。$a\equiv0$ だが $b\not\equiv0$ のような混合の場合もループではなく、上の式がそのまま正しい。）

これらは §1.4 の $L(z,w)$ の定義の各項に $(z,w)=(\zeta,\xi)$ を代入したものと**項ごとに**一致する。したがって

$$L_{X_{N,N'}}\,v_{\zeta,\xi,x}=v_{\zeta,\xi,\,L(\zeta,\xi)x}. \tag{3.2}$$

$W_{\zeta,\xi}:=\{v_{\zeta,\xi,x}:x\in\mathbb{C}^V\}$ は $\dim_{\mathbb{C}}=m$（$x\mapsto v_{\zeta,\xi,x}$ は単射）で、$(3.2)$ より $L_{X_{N,N'}}$ 不変、その上で $L(\zeta,\xi)$ と同型に作用する。

$\mathbb{C}^{V\times(\mathbb{Z}/N)\times(\mathbb{Z}/N')}=\bigoplus_{\zeta,\xi}W_{\zeta,\xi}$ を示す。両辺の次元はともに $mNN'$ なので、和が全体を張ることを見ればよい。$u$ を固定すると、$\{(\zeta^i\xi^j)_{i,j}:\zeta^N=1,\xi^{N'}=1\}$ は $\mathbb{C}^{(\mathbb{Z}/N)\times(\mathbb{Z}/N')}$ の基底である（$\mathbb{C}^{\mathbb{Z}/N}$ の基底 $\{(\zeta^i)_i\}$ と $\mathbb{C}^{\mathbb{Z}/N'}$ の基底 $\{(\xi^j)_j\}$ の Kronecker 積で、可逆行列 2 個の Kronecker 積は可逆）。$u$ を動かして全体を張る。$\blacksquare$

> **機械検証**: `two_var.sage` Step 1（$N,N'\le3$、明示例 12 件＋乱択 8 件）。

### 補題 B2（連結成分数の分解）

> $$c(X_{N,N'})=\sum_{\zeta^N=1}\sum_{\xi^{N'}=1}\dim_{\mathbb{C}}\ker L(\zeta,\xi). \tag{3.3}$$

**証明.** 有限多重グラフ $G$ について $\dim_{\mathbb{C}}\ker L_G=c(G)$ は標準（$(1.1)$ より $\langle L_Gv,v\rangle=\sum_{e\ \text{非ループ}}|v(o(e))-v(t(e))|^2$、これが $0$ ⟺ $v$ が各連結成分上で定数）。これを $G=X_{N,N'}$ に適用し、補題 A2 の直和分解で核も分解する。$\blacksquare$

**系 B2′.** *$X$ が連結なら $\ker L(1,1)=\ker L_X$ は 1 次元なので*

$$X_{N,N'}\ \text{が連結}\iff \det L(\zeta,\xi)\neq0\quad\text{（全ての }(\zeta,\xi)\neq(1,1)\text{、}\zeta^N=\xi^{N'}=1). \tag{3.4}$$

*$X$ が非連結なら $c(X_{N,N'})\ge c(X)\ge2$ で $X_{N,N'}$ も非連結*（各成分の持ち上げが別々の成分を含むため。$(3.3)$ で $\zeta=\xi=1$ の項が既に $\ge2$）。

### 補題 C2（連結性の格子判定 — $d=1$ の $\gcd$ 判定の置き換え）

> *$X$ を連結とし、全域木 $T\subseteq E$ を 1 つ固定する。$T$ 上の potential $h:V\to\mathbb{Z}^2$ を、$h(v_0)=0$（$v_0$ は基点）と「$T$ の辺 $(u,v,\alpha)$ について $h(v)=h(u)+\alpha$」で定める（$T$ が木なので一意）。非木辺 $e=(u,v,\alpha)$ の**基本閉路 voltage** を $\beta_e:=\alpha+h(u)-h(v)\in\mathbb{Z}^2$ とし、*
> $$B:=\langle \beta_e: e\in E\smallsetminus T\rangle\subseteq\mathbb{Z}^2$$
> *（生成される部分格子）と置く。このとき*
> $$X_{N,N'}\ \text{が連結}\iff B+(N\mathbb{Z}\oplus N'\mathbb{Z})=\mathbb{Z}^2. \tag{3.5}$$

**証明.** $A:=(\mathbb{Z}/N)\times(\mathbb{Z}/N')=\mathbb{Z}^2/(N\mathbb{Z}\oplus N'\mathbb{Z})$ と書き、$X_{N,N'}$ の頂点 $(v,i,j)$ に対し $\phi(v,i,j):=(i,j)-h(v)\bmod (N\mathbb{Z}\oplus N'\mathbb{Z})\in A$ と置く。辺 $e_{i,j}$（$e=(u,v,\alpha)$）は $(u,i,j)$ と $(v,(i,j)+\alpha)$ を結び、

$$\phi(v,(i,j)+\alpha)-\phi(u,i,j)=\bigl((i,j)+\alpha-h(v)\bigr)-\bigl((i,j)-h(u)\bigr)=\beta_e\bmod(N\mathbb{Z}\oplus N'\mathbb{Z}).$$

とくに $e\in T$ なら $\beta_e=0$ で $\phi$ は保たれる。

$H:=$（$B$ の $A$ における像）$\subseteq A$ と置く。$X_{N,N'}$ の任意の辺は $\phi$ を $H$ の元だけずらすので、$\phi\bmod H$ は各連結成分上で一定であり $c(X_{N,N'})\ge[A:H]$。
逆に、$T$ の辺は $\phi$ を保ち、$T$ は $V$ を張るので、$\phi$ が同じ値をもつ頂点どうしは連結（$\{(v,i,j):\phi(v,i,j)=c\}$ は $T$ の持ち上げで木をなす）。さらに非木辺 $e$ で $\phi$ の値を $\beta_e$ だけ動かせるので、$\phi$ の値が同じ $H$-剰余類に属する頂点はすべて連結。ゆえに $c(X_{N,N'})=[A:H]$。

$[A:H]=1\iff B+(N\mathbb{Z}\oplus N'\mathbb{Z})=\mathbb{Z}^2$。$\blacksquare$

**注 3.1（決定可能性）.** $(3.5)$ の右辺は、行に $\beta_e$（$e\notin T$）と $(N,0)$, $(0,N')$ を並べた整数行列の **Smith 標準形の elementary divisors が $(1,1)$ か**を見れば判定できる。有限手続きであり $\mathbb{R}$ を使わない。$d=1$ での「$\gcd(N,g_X)=1$」（cycle 13 補題 C）の直接の一般化である。

**系 C2′（$\ell$-塔の all-or-nothing）.** *$X$ 連結とする。$B$ の $\bmod\ \ell$ での像を $\bar B\subseteq\mathbb{F}_\ell^2$ とすると*

$$\exists n\ge1:\ X_{\ell^n,\ell^n}\ \text{連結}\iff \bar B=\mathbb{F}_\ell^2\iff \forall n\ge0:\ X_{\ell^n,\ell^n}\ \text{連結}.$$

**証明.** $(3.5)$ で $N=N'=\ell^n$ とすると条件は $B+\ell^n\mathbb{Z}^2=\mathbb{Z}^2$。
$n\ge1$ なら $\ell^n\mathbb{Z}^2\subseteq\ell\mathbb{Z}^2$ なので $B+\ell^n\mathbb{Z}^2=\mathbb{Z}^2\Rightarrow B+\ell\mathbb{Z}^2=\mathbb{Z}^2\iff\bar B=\mathbb{F}_\ell^2$。
逆に $B+\ell\mathbb{Z}^2=\mathbb{Z}^2$ とすると、両辺に $\ell$ を掛けて $\ell\mathbb{Z}^2=\ell B+\ell^2\mathbb{Z}^2\subseteq B+\ell^2\mathbb{Z}^2$ なので
$\mathbb{Z}^2=B+\ell\mathbb{Z}^2\subseteq B+\ell^2\mathbb{Z}^2$、帰納法で全ての $k\ge1$ で $B+\ell^k\mathbb{Z}^2=\mathbb{Z}^2$。$n=0$ は $X$ 連結そのもの。$\blacksquare$

> **機械検証**: Step 2（補題 B2、$N,N'\le4$）、Step 3（補題 C2、$N,N'\le6$、非連結ケースを多数含む）。

### 3.4 中間被覆の連結性（後で使う）

**補題 Q.** *$X_{N,N'}$ が連結なら $X_{N,1}$ と $X_{1,N'}$ も連結である。*

**証明.** 写像 $p:(v,i,j)\mapsto(v,j)$、$e_{i,j}\mapsto e_j$ は $X_{N,N'}\to X_{1,N'}$ の全射グラフ射である（$X_{1,N'}$ の辺 $e_j$ は $(u,j)$ と $(v,j+b)$ を結び、$p$ は $e_{i,j}$ の端点を正しく写す）。連結グラフの全射グラフ射による像は連結。$X_{N,1}$ も同様（$(v,i,j)\mapsto(v,i)$）。$\blacksquare$

**系 Q′.** *$X$ 連結、$X_{\ell^n,\ell^n}$ が全ての $n$ で連結とすると、$\zeta\neq1$ が $\ell$ 冪位数の $1$ の冪根なら $D(\zeta,1)\neq0$、$\xi\neq1$ が $\ell$ 冪位数なら $D(1,\xi)\neq0$。また $(\zeta,\xi)\neq(1,1)$ がともに $\ell$ 冪位数なら $D(\zeta,\xi)\neq0$。*

**証明.** 補題 Q と系 B2′ $(3.4)$（$X_{N,1}$ の voltage ラプラシアンは $L(z,1)$、$X_{1,N'}$ のは $L(1,w)$）。$\blacksquare$

---

## 4. 定理 1 $=(★_2)$

> **定理 1.** *$(X,\alpha)$ を任意の有限 voltage 多重グラフ（$\alpha:E\to\mathbb{Z}^2$）、$N,N'\ge1$ を任意とする。$D=\det L$ とすると $\mathbb{Z}$ における等式*
> $$N N'\cdot\kappa(X_{N,N'})\;=\;\kappa(X)\cdot\prod_{\substack{\zeta^N=1,\ \xi^{N'}=1\\ (\zeta,\xi)\neq(1,1)}}D(\zeta,\xi) \tag{4.1}$$
> *が成り立つ。とくに $X_{N,N'}$ が連結なら $\kappa(X_{N,N'})=\dfrac{\kappa(X)}{NN'}\prod_{(\zeta,\xi)\neq(1,1)}D(\zeta,\xi)$。*

**証明.** 3 つの場合に分ける（cycle 13 定理 1 の証明が、$\zeta$ 1 個から $(\zeta,\xi)$ 1 組に置き換わるだけで通る。**通らない箇所は無い**）。

**(i) $X$ が非連結の場合.** $\kappa(X)=0$、また系 B2′ の後半より $X_{N,N'}$ も非連結で $\kappa(X_{N,N'})=0$。$(4.1)$ は $0=0$。

**(ii) $X$ 連結、かつある $(\zeta_0,\xi_0)\neq(1,1)$ で $D(\zeta_0,\xi_0)=0$ の場合.** 右辺は $0$。系 B2′ $(3.4)$ より $X_{N,N'}$ は非連結なので $\kappa(X_{N,N'})=0$、左辺も $0$。

**(iii) $X$ 連結、かつ全ての $(\zeta,\xi)\neq(1,1)$ で $D(\zeta,\xi)\neq0$ の場合.** 系 B2′ より $X_{N,N'}$ は連結である。

$L_{X_{N,N'}}$ は $mNN'$ 次の実対称半正定値行列（$(1.1)$ より）で、固有値を $0=\Lambda_1\le\Lambda_2\le\dots\le\Lambda_{mNN'}$ とする。$X_{N,N'}$ 連結より $\Lambda_2>0$。系 K′ $(2.1)$ を $G=X_{N,N'}$（$mNN'$ 頂点の有限多重グラフ ✓）に適用して

$$\prod_{j=2}^{mNN'}\Lambda_j=mNN'\cdot\kappa(X_{N,N'}). \tag{4.2}$$

補題 A2 より $L_{X_{N,N'}}$ の固有値の重複集合は $\bigsqcup_{\zeta,\xi}\mathrm{Spec}\,L(\zeta,\xi)$。$(\zeta,\xi)=(1,1)$ の成分は $L(1,1)=L_X$ で、$X$ 連結だから固有値は $0=\lambda_1<\lambda_2\le\dots\le\lambda_m$。$(\zeta,\xi)\neq(1,1)$ の成分は仮定より $\det L(\zeta,\xi)\neq0$、すなわち固有値はすべて非零。よって $L_{X_{N,N'}}$ の固有値のうち $0$ は $\lambda_1$ ただ 1 つで

$$\prod_{j=2}^{mNN'}\Lambda_j=\Bigl(\prod_{i=2}^{m}\lambda_i\Bigr)\cdot\prod_{(\zeta,\xi)\neq(1,1)}\det L(\zeta,\xi). \tag{4.3}$$

再び系 K′ を $G=X$（$m$ 頂点）に適用して $\prod_{i\ge2}\lambda_i=m\,\kappa(X)$。$(4.2)$, $(4.3)$ を合わせ $m\ge1$ で割ると $(4.1)$。$\blacksquare$

**注 4.1（右辺が整数であること・厳密計算法）.** $\prod_{(\zeta,\xi)\neq(1,1)}D(\zeta,\xi)$ は Galois 不変な代数的整数なので $\mathbb{Z}$ に属する。実際には 2 段の終結式で $\mathbb{Z}$ 上厳密に計算できる: $D=z^{r}w^{s}P$（$P\in\mathbb{Z}[z,w]$）と書き、

$$\prod_{(\zeta,\xi)\neq(1,1)}D(\zeta,\xi)
=\underbrace{\prod_{\zeta^N=1,\zeta\neq1}\ \prod_{\xi^{N'}=1}D(\zeta,\xi)}_{\text{（外側）}}\ \cdot\ \underbrace{\prod_{\xi^{N'}=1,\xi\neq1}D(1,\xi)}_{\text{（内側の $\zeta=1$ の行）}}$$

と分け、$A(z):=\prod_{\xi^{N'}=1}P(z,\xi)=\mathrm{Res}_w\bigl(w^{N'}-1,\,P(z,w)\bigr)$（$w^{N'}-1$ はモニック）、
$\prod_{\zeta\neq1}A(\zeta)=\mathrm{Res}_z\bigl(\frac{z^N-1}{z-1},A(z)\bigr)$（同じくモニック）を使う。単項式因子 $z^rw^s$ の寄与は $\prod_{\zeta^N=1}\zeta=(-1)^{N+1}$ 等で符号だけである。
**この形は決定可能性の観点で有用で、実際 §11 の全計算はこの経路で行った。**

**注 4.2（cycle 13 との差分）.** cycle 13 定理 1 の証明で $d=1$ 固有だったのは補題 A（1 重の離散 Fourier）だけであり、それを補題 A2 に差し替えれば以降は変わらない。$\chi(X)\neq0$ や「次数 1 の頂点をもたない」という定理 DV の仮定は、この経路では**不要**である（$(4.1)$ は任意の有限多重グラフで成立する）。ただし定理 DV がその仮定をどこで使っているかは、Artin–Ihara $L$ 函数を経由するという証明方針の違いによるもので（同 (8) $h_X'(1)=-2\chi(X)\kappa_X$ に $\chi(X)\neq0$ が必要、Remark 2.1 で次数 1 の頂点は一般性を失わないと述べている）、**「仮定が冗長である」とは主張しない**。

> **機械検証**: Step 4。左辺は導来グラフを実際に構成して Kirchhoff 余因子で、右辺は (a) 円分体上の直接積と (b) 注 4.1 の 2 段終結式の 2 通りで、いずれも独立に厳密計算した。退化ケース（両辺 $0$）も含む。

---

## 5. 補題 D2（content の不変性、2 変数版）

> **補題 D2.** *$0\neq D\in\mathbb{Z}[z^{\pm1},w^{\pm1}]$ とし、$D=z^{r}w^{s}P(z,w)$（$r,s\in\mathbb{Z}$、$P\in\mathbb{Z}[z,w]$、$z\nmid P$、$w\nmid P$）と書く。$f(T,S):=P(1+T,1+S)\in\mathbb{Z}[T,S]\subset\Lambda_2$ と置くと、任意の素数 $\ell$ について*
> $$\mu(f)=v_\ell\bigl(\mathrm{content}_{T,S}(f)\bigr)=v_\ell\bigl(\mathrm{content}_{z,w}(D)\bigr). \tag{5.1}$$
> *さらに $\tilde f:=D(1+T,1+S)$ を $\Lambda_2$ の元と見たときも（単項式因子を落とさなくても）$\mu(\tilde f)=\mu(f)$。*

**証明.** 3 段に分ける。

**(a) 単項式因子は $\mu$ を変えない.** $1+T$ は $\mathbb{Z}[[T]]\subseteq\Lambda_2$ の単元（逆元 $\sum_{k\ge0}(-T)^k$）、同様に $1+S$ も単元なので、$(1+T)^r(1+S)^s$ は $r,s\in\mathbb{Z}$ のいずれの符号でも $\Lambda_2^\times$ に属する。$\tilde f=(1+T)^r(1+S)^s f$ であり、補足 W′ より $\mu(\tilde f)=0+\mu(f)$。

**(b) $\mu(f)=v_\ell(\mathrm{content}_{T,S}(f))$.** $f\in\mathbb{Z}[T,S]$ の係数を $c_{ij}\in\mathbb{Z}$ とすると $\mu(f)=\min_{ij}v_\ell(c_{ij})=v_\ell(\gcd_{ij}c_{ij})$。定義そのもの。

**(c) $\mathrm{content}_{T,S}(f)=\mathrm{content}_{z,w}(P)=\mathrm{content}_{z,w}(D)$.**
後半は $D$ と $P$ の係数の重複集合が一致することから明らか。前半: $\varphi:\mathbb{Z}[z,w]\to\mathbb{Z}[T,S]$, $Q(z,w)\mapsto Q(1+T,1+S)$ は $\mathbb{Z}$-代数としての同型（逆は $T\mapsto z-1$, $S\mapsto w-1$）である。$\mathbb{Z}$-線形な全単射なので、任意の整数 $M>0$ について $\varphi(M\mathbb{Z}[z,w])=M\mathbb{Z}[T,S]$、したがって

$$Q\in M\mathbb{Z}[z,w]\iff\varphi(Q)\in M\mathbb{Z}[T,S].$$

$\mathrm{content}(Q)$ は「$Q\in M\mathbb{Z}[\cdot]$ となる最大の $M>0$」なので両者は一致する。$\blacksquare$

**定義 5.1（本レポートの主要な不変量）.** 以下 $D\neq0$ とし

$$\mu:=v_\ell\bigl(\mathrm{content}_{z,w}\det L(z,w)\bigr)\in\mathbb{Z}_{\ge0},\qquad E:=\ell^{-\mu}D\in\mathbb{Z}[z^{\pm},w^{\pm}]$$

と置く（$\ell\nmid\mathrm{content}(E)$）。さらに $g:=E(1+T,1+S)$（単項式因子を除いて $\Lambda_2$ の元と見る）に対し

$$k:=\mathrm{ord}(\bar g)\in\mathbb{Z}_{\ge0}\quad(\bar g=g\bmod\ell\in\mathbb{F}_\ell[[T,S]]\smallsetminus\{0\}),$$

$H\in\mathbb{F}_\ell[T,S]$ を $\bar g$ の**最低次斉次部分**（次数 $k$、$H\neq0$）と置く。

**補題 5.2（$k\ge2$）.** *$X$ が連結なら $k\ge2$。*

**証明.** §1.4 の定義から成分ごとに $L(z^{-1},w^{-1})=L(z,w)^{\mathsf T}$ が確認できる（非対角: $L_{uv}(z^{-1},w^{-1})=-\sum\mathbf m_e^{-1}=L_{vu}(z,w)$、対角: $\mathbf m_e\leftrightarrow\mathbf m_e^{-1}$ で不変）。よって

$$D(z^{-1},w^{-1})=\det L(z,w)^{\mathsf T}=D(z,w). \tag{5.2}$$

$(5.2)$ を $\mathbb{Z}[z^{\pm},w^{\pm}]$ で $z$ について微分すると $-z^{-2}(\partial_zD)(z^{-1},w^{-1})=(\partial_zD)(z,w)$、$(z,w)=(1,1)$ で $(\partial_zD)(1,1)=-(\partial_zD)(1,1)$、すなわち

$$(\partial_zD)(1,1)=(\partial_wD)(1,1)=0. \tag{5.3}$$

いま $D=z^rw^sP$ と書くと $\partial_zD=rz^{r-1}w^sP+z^rw^s\partial_zP$ で、$P(1,1)=D(1,1)=0$（$(1.2)$）なので $(\partial_zP)(1,1)=(\partial_zD)(1,1)=0$、同様に $(\partial_wP)(1,1)=0$。

$f:=P(1+T,1+S)$ の定数項は $P(1,1)=0$、1 次係数は $(\partial_zP)(1,1)$, $(\partial_wP)(1,1)$ でともに $0$。$g=\ell^{-\mu}f$（$\times$単元）なので $g$ の定数項・1 次係数も $0$、すなわち $g$ は $\mathrm{ord}\ge2$、したがって $\bar g$ も $\mathrm{ord}\ge2$（$\bar g\neq0$ は $\mu$ の定義から）、すなわち $k\ge2$。$\blacksquare$

> **機械検証**: Step 5（補題 D2、$\ell\in\{2,3,5,7,23\}$、単項式因子を掛けた別正規化との一致も確認）。

---

## 6. 基本分解と定理 3（$a\ge\mu$）

以下 **$X$ は有限連結多重グラフ、$\alpha:E\to\mathbb{Z}^2$、$\ell$ は素数、そして $\bar B=\mathbb{F}_\ell^2$（$\iff$ 全ての $n$ で $X_{\ell^n,\ell^n}$ が連結、系 C2′）を仮定する。** この仮定を **(H)** と呼ぶ。

**(H) の下で $D\neq0$**: $\ell\ge2$ なので $(\zeta,\xi)=(\zeta_\ell,1)\neq(1,1)$ が取れ、系 Q′ より $D(\zeta_\ell,1)\neq0$。

定理 1 (iii) が適用でき、$\kappa_n>0$ なので

$$\boxed{\ \mathrm{ord}_\ell(\kappa_n)=v_\ell(\kappa(X))-2n+\mu\,(\ell^{2n}-1)+\Sigma_n,\qquad
\Sigma_n:=\sum_{\substack{\zeta^{\ell^n}=\xi^{\ell^n}=1\\ (\zeta,\xi)\neq(1,1)}}v_\ell\bigl(E(\zeta,\xi)\bigr)\ } \tag{6.1}$$

（$D=\ell^\mu E$、$(\zeta,\xi)\neq(1,1)$ の個数は $\ell^{2n}-1$）。$\Sigma_n$ の各項は $\ge0$ である（$E$ は整係数で $\zeta,\xi$ は代数的整数なので $E(\zeta,\xi)\in\mathcal O$）。

> **定理 3（$\ell^{2n}$ の係数の下界、自前の証明）.** *(H) を仮定する。$\mathrm{ord}_\ell(\kappa_n)=a\ell^{2n}+bn\ell^n+c\ell^n+dn+e$（$n\gg0$、$a,\dots,e\in\mathbb{Q}$）と書けるならば*
> $$a\ \ge\ \mu=v_\ell\bigl(\mathrm{content}_{z,w}\det L(z,w)\bigr).$$

**証明.** $\Sigma_n\ge0$ なので $(6.1)$ より $\mathrm{ord}_\ell(\kappa_n)\ge\mu\ell^{2n}-2n+\bigl(v_\ell(\kappa(X))-\mu\bigr)$。仮定の形と比べて

$$(a-\mu)\ell^{2n}+bn\ell^{n}+c\ell^{n}+(d+2)n+\bigl(e-v_\ell(\kappa(X))+\mu\bigr)\ \ge\ 0\qquad(n\gg0).$$

もし $a<\mu$ なら左辺は $n\to\infty$ で $-\infty$（$\ell\ge2$ より $\ell^{2n}$ が $n\ell^n,\ell^n,n,1$ を漸近的に支配する）となり矛盾。$\blacksquare$

**注 6.1.** 定理 3 は「多項式形で書ける」ことしか外部から借りていない。多項式形は §7 の定理 M（$d=2$）から従い、あるいは定理 DV（仮定を満たす場合）から従う。多項式形を仮定しない形でも $\liminf_n\ell^{-2n}\mathrm{ord}_\ell(\kappa_n)\ge\mu$ が同じ計算で言える。

---

## 7. 定理 4（$\ell^{2n}$ の係数 $=\mu$、既知定理の帰結）

### 7.1 定理 M の適用条件の確認

$\Gamma=\mathbb{Z}_\ell^2$、$f:=\tilde D=D(1+T,1+S)\in\Lambda_2\simeq\mathbb{Z}_\ell[[\Gamma]]$ と置く（Serre の同型 $\sigma_1\mapsto1+T$, $\sigma_2\mapsto1+S$）。

- $f\neq0$: (H) の下で示した。✓
- $S=\widehat\Gamma$ は semi-algebraic: Kataoka arXiv:2606.03579 §2.1 が「任意の閉部分群 $H\subset\Gamma$ に対し $\widehat{\Gamma/H}$ は semi-algebraic」と述べており、$H=\{1\}$ で $\widehat\Gamma$ 自身。✓
- $\widehat{\Gamma_n}$ の元 $\chi$ と $(\zeta,\xi)$（$\zeta^{\ell^n}=\xi^{\ell^n}=1$）の対応: $\chi\mapsto(\chi(\sigma_1),\chi(\sigma_2))$ は全単射で、$\chi(f)=f(\chi(\sigma_1)-1,\chi(\sigma_2)-1)=D(\zeta,\xi)$。✓
- $\{\chi\in\widehat{\Gamma_n}:\chi(f)\neq0\}=\widehat{\Gamma_n}\smallsetminus\{\chi_0\}$: 自明指標では $\chi_0(f)=D(1,1)=0$（$(1.2)$）なので自動的に除かれ、それ以外では系 Q′ より $D(\zeta,\xi)\neq0$。**ここで (H) を使う。** ✓

したがって定理 M（$d=2$）と定理 CM より、$n\gg0$ で

$$\sum_{(\zeta,\xi)\neq(1,1)}v_\ell\bigl(D(\zeta,\xi)\bigr)
=\bigl(l_0(f)\,n+m_0(f)\,\ell^{n}\bigr)\ell^{n}+\bigl(\lambda_1n+\mu_1\ell^{n}\bigr)+\nu_0 \tag{7.1}$$

（$\lambda_1,\mu_1,\nu_0\in\mathbb{Q}$）。$(6.1)$ とあわせて（$\mu(\ell^{2n}-1)+\Sigma_n$ が左辺そのものであることに注意）:

> **定理 4.** *(H) を仮定する。$Q:=\det L(1+T,1+S)\in\Lambda_2$ と置く。このとき $\mu_1,\lambda_1\in\mathbb{Q}$, $\nu\in\mathbb{Q}$ が存在して、$n\gg0$ で*
> $$\mathrm{ord}_\ell(\kappa_n)=m_0(Q)\,\ell^{2n}+l_0(\bar Q_\ast)\,n\,\ell^{n}+\mu_1\ell^{n}+(\lambda_1-2)\,n+\nu, \tag{7.2}$$
> *であり、$\ell^{2n}$ の係数は*
> $$\boxed{\ a=m_0(Q)=v_\ell\bigl(\mathrm{content}_{z,w}\det L(z,w)\bigr)\ } \tag{7.3}$$
> *（$\bar Q_\ast:=\overline{\ell^{-m_0(Q)}Q}$）。*

**証明.** $(7.1)$ を $(6.1)$ に代入し、$(2.2)$（$m_0=\mu$）と補題 D2 $(5.1)$（$\mu(Q)=v_\ell(\mathrm{content}_{z,w}D)$）を使う。$\blacksquare$

**注 7.1（何が自前で、何が借り物か）.** $(7.3)$ の**下からの不等式は定理 3 として自前で証明した**。**上からの不等式（$a\le\mu$）は定理 CM に依拠しており、本レポートでは証明できていない**（§9-1）。

**注 7.2（$\chi(X)\neq0$ と次数 1 の頂点が不要であること）.** 定理 4 の導出は定理 1（任意の有限多重グラフで成立）と定理 M を直接組み合わせており、定理 DV の仮定（$\chi(X)\neq0$、次数 1 の頂点なし）を使わない。cycle 13 §6.6 が $d=1$ で観察したのと同じ構造である。ただし §4 注 4.2 のとおり「定理 DV の仮定が冗長」とは主張しない。

### 7.2 $l_0$ の意味（$n\ell^n$ 項が消える条件）

定理 CM の $l_0(\bar h)=\sum_P\mathrm{ord}_P(\bar h)$ は、$P=(\gamma-1)$（$\gamma\in\Gamma\smallsetminus\Gamma^\ell$）の形の素イデアルについての重複度の総和である。$\gamma=\sigma_1^{a}\sigma_2^{b}$（$(a,b)\in\mathbb{Z}_\ell^2\smallsetminus\ell\mathbb{Z}_\ell^2$）に対し $\mathbb{F}_\ell[[T,S]]$ の中で

$$\gamma-1=(1+T)^{a}(1+S)^{b}-1=aT+bS+(\text{次数}\ge2), \tag{7.5}$$

すなわち $\gamma-1$ の最低次斉次部分は $\mathbb{F}_\ell$ 上の**非零な 1 次形式** $aT+bS$ である。したがって:

**補題 7.3.** *$H$（定義 5.1）が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたなければ $l_0(\bar Q_\ast)=0$、すなわち $(7.2)$ の $n\ell^n$ 項は消える。*

**証明.** $(\gamma-1)\mid\bar Q_\ast$ と仮定する。$\bar Q_\ast=(\gamma-1)\cdot\bar h$ と書くと、$\mathbb{F}_\ell[[T,S]]$ で最低次斉次部分は積について乗法的（$\mathbb{F}_\ell[T,S]$ が整域だから、$\mathrm{ord}$ は加法的で最低次部分の積は消えない）なので、$H=(aT+bS)\cdot H_{\bar h}$。$aT+bS\neq0$ なのでその零点 $(b:-a)\in\mathbb{P}^1(\mathbb{F}_\ell)$ は $H$ の零点。対偶を取れば主張。$\blacksquare$

（$\ell\nmid(a,b)$ より $(a,b)\bmod\ell\neq(0,0)$ で、$aT+bS$ は $\mathbb{F}_\ell$ 上の非零 1 次形式。$\mathbb{Z}_\ell$ 係数の指数 $a$ による $(1+T)^a$ は $\mathbb{F}_\ell[[T]]$ の元として well-defined である（Kataoka §2.1 が引用する連続性）。）

これは §8 の定理 5 と整合する（定理 5 の結論には $n\ell^n$ 項が無い）。

### 7.3 $d=1$ との違い（判定式の素朴な移植は誤り）

cycle 13 の判定式 $(☆)$ は $d=1$ で $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+\lambda n+\nu$ の**唯一の主要項**の係数が content で与えられる、という主張だった。$d=2$ では $(7.2)$ のとおり

- $\ell^{2n}$ の係数 $=v_\ell(\mathrm{content})$（定理 4）、
- その下に $n\ell^{n}$ 項（係数 $l_0$）と $\ell^{n}$ 項（係数 $\mu_1$）が**独立に**存在する

ので、「content が増大を支配する」という言い方は $d=2$ では正しくない。とくに $\mu=0$（content が $\ell$ で割れない）でも $\mathrm{ord}_\ell(\kappa_n)$ は $\ell^n$ のオーダーで増大しうる。実例: $\ell^n\times\ell^n$ トーラス（bouquet 2 ループ、voltage $(1,0),(0,1)$）は $\mathrm{content}_{z,w}(4-z-z^{-1}-w-w^{-1})=1$ なので $\mu=0$ だが、$\ell=2$ で $\mathrm{ord}_2(\kappa_n)=5,19,61,167,417,987,\dots$（§11 Step 6 で再現、DuBose–Vallières の表と一致）。

これは cycle14 step 1 の report §4 が一般の $P$ について挙げた警告（content$=1$ でも $v_p(a_{p^n})$ が増大する）の、グラフ版の確定形である。ただし対応関係には注意が必要で、cycle14 step 1 の $a_L=\prod_{z^L=w^L=1}P$ は $(1,1)$ を**含む**積なのでグラフの場合は恒等的に $0$ であり、$\kappa_n$ は $(1,1)$ を**除いた**積を $\ell^{2n}$ で割ったものである。§7.4 で述べたとおり両者は別レジームである。

### 7.4 命題 V との関係（レジームの確認）

cycle14 step 1 の命題 V は「$P(1,1)\neq0$ のとき $v_p(a_{p^n})>0\iff p\mid P(1,1)$」であった。本レポートの $P=D=\det L$ は $(1.2)$ より **常に $D(1,1)=0$** なので、命題 V の仮定の外側、同 report §6.2 の三分法でいう**第 3 レジーム（トーラス零点）**に属する。したがって

- 命題 V は本レポートの $\kappa_n$ について何も言わない（$a_L\equiv0$）。
- 逆に本レポートの結果は一般の $P$ について何も言わない（$\det L$ 型に限る）。
- 両者に共通するのは「$\bmod\,\ell$ に落として $\ell^n$ 乗根が $1$ に潰れる」という機構（cycle14 step 1 §2）だけである。§8 の証明はその機構を $\mathfrak m$-進の 1 段の吹き上げとして精密化したものになっている。

---

## 8. 定理 5（非退化な塔での完全な閉形式、自前の証明）

### 8.1 非退化条件

**定義 8.1.** 定義 5.1 の $H\in\mathbb{F}_\ell[T,S]$（次数 $k$ の非零斉次形式）について、
$H$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたないとき、塔 $(X,\alpha,\ell)$ は**非退化**であるという。明示的には

$$H(0,1)\neq0\quad\text{かつ}\quad H(1,c)\neq0\ \ (\forall c\in\mathbb{F}_\ell). \tag{8.1}$$

（$H(1,0)\neq0$ が $c=0$ の場合。）これは $D$ の係数からの**有限計算**で判定できる。

### 8.2 準備: 冪根の比の剰余

**補題 8.2.** *$\zeta_n$ を原始 $\ell^n$ 乗根、$a,b\in\mathbb{Z}$ を $\ell\nmid a$, $\ell\nmid b$ とし $\zeta=\zeta_n^a$, $\xi=\zeta_n^b$ と置く（ともに位数 $\ell^n$）。このとき $v_\ell(\zeta-1)=v_\ell(\xi-1)=1/\varphi(\ell^n)$ で、$u:=(\xi-1)/(\zeta-1)$ は $v_\ell(u)=0$ を満たし、その剰余は*

$$u\bmod\mathfrak m=\ b\,a^{-1}\bmod\ell\ \in\mathbb{F}_\ell^\times. \tag{8.2}$$

**証明.** $v_\ell(\zeta-1)=1/\varphi(\ell^n)$ は cycle 13 $(6.2')$（$\prod_{\zeta:\text{原始}\ \ell^n}(1-\zeta)=\Phi_{\ell^n}(1)=\ell$ と共役性）。
$\dfrac{\zeta_n^a-1}{\zeta_n-1}=1+\zeta_n+\dots+\zeta_n^{a-1}\equiv a\pmod{(\zeta_n-1)}$、同様に $\dfrac{\zeta_n^b-1}{\zeta_n-1}\equiv b$。
$(\zeta_n-1)\subset\mathfrak m$ なので、$u=\dfrac{(\zeta_n^b-1)/(\zeta_n-1)}{(\zeta_n^a-1)/(\zeta_n-1)}$ の剰余は $b a^{-1}\bmod\ell$（$\ell\nmid a$ より分母の剰余 $a$ は $\mathbb{F}_\ell^\times$ の元で可逆）。$\blacksquare$

**注 8.3（なぜ $\mathbb{F}_\ell$ だけを見ればよいか）.** $(8.2)$ より、同じ位数の $(\zeta,\xi)$ について実現される比の剰余は $\mathbb{F}_\ell^\times$ の元**だけ**であって、$\overline{\mathbb{F}}_\ell$ 全体ではない。これが非退化条件 $(8.1)$ が $\mathbb{F}_\ell$ 有理点のみを問題にする理由である。

### 8.3 中心となる補題（点ごとの付値）

**補題 8.4.** *$\ell$、$E$、$k$、$H$ を定義 5.1 のとおりとする。$\zeta,\xi$ をそれぞれ位数 $\ell^{i}$, $\ell^{j}$（$i,j\ge1$）の $1$ の冪根とし、$M:=\max(i,j)$ と置く。$\varphi(\ell^{M})>k$ かつ**非退化**を仮定すると*

$$v_\ell\bigl(E(\zeta,\xi)\bigr)=\frac{k}{\varphi(\ell^{M})}. \tag{8.3}$$

**証明.** $t:=\zeta-1$, $s:=\xi-1$ と置く。$v_\ell(t)=1/\varphi(\ell^i)=:\alpha>0$、$v_\ell(s)=1/\varphi(\ell^j)=:\beta>0$（補題 8.2 の第 1 主張）。$\min(\alpha,\beta)=1/\varphi(\ell^M)$。

$g=E(1+T,1+S)$ を $\Lambda_2$ の元と見る（補題 D2 (a) により単項式単元は落としてよい。$1+t$, $1+s$ は $v_\ell(t),v_\ell(s)>0$ より $\mathcal O^\times$ なので、値としても付値を変えない）。$g=\sum_{p,q}c_{pq}T^pS^q$、$v_\ell(c_{pq})\ge0$ で、$k=\mathrm{ord}(\bar g)$ の定義より

- $p+q<k$ なら $v_\ell(c_{pq})\ge1$、
- $p+q=k$ の項の係数のうち少なくとも 1 つは $v_\ell=0$（それが $H$ の非零係数）。

各項の付値を評価する（$\mathbb{C}_\ell$ での収束は cycle 13 §6.2 と同じ: $v_\ell(t),v_\ell(s)>0$ で係数が $\mathcal O$ に入るので絶対収束し、積・和を保つ）。

1. **$p+q<k$ の項**: $v_\ell\ge1+p\alpha+q\beta\ge1$。
2. **$p+q>k$ の項**: $v_\ell\ge p\alpha+q\beta\ge(p+q)\min(\alpha,\beta)\ge(k+1)/\varphi(\ell^M)$。
3. **$p+q=k$ の項の和**: $\Theta:=\sum_{p+q=k}c_{pq}t^ps^q$。

仮定 $\varphi(\ell^M)>k$ より $k/\varphi(\ell^M)<1$、また $(k+1)/\varphi(\ell^M)>k/\varphi(\ell^M)$。したがって
**$v_\ell(\Theta)=k/\varphi(\ell^M)$ を示せば、非アルキメデス的評価（最小値がただ 1 箇所で達成されるときは等号）から $(8.3)$ が従う。**

$\Theta$ を評価する。$i=j$ と $i\neq j$ に分ける。

**(A) $i=j$（$\alpha=\beta=1/\varphi(\ell^i)=1/\varphi(\ell^M)$）.** $u:=s/t$ と置くと $v_\ell(u)=0$、$\Theta=t^{k}\sum_{p+q=k}c_{pq}u^{q}$。
$\Psi:=\sum_{p+q=k}c_{pq}u^q\in\mathcal O$ の剰余は、$H=\sum_{p+q=k}\bar c_{pq}T^pS^q$ の記号で

$$\Psi\bmod\mathfrak m=H\bigl(1,\ u\bmod\mathfrak m\bigr).$$

補題 8.2 より $u\bmod\mathfrak m\in\mathbb{F}_\ell^\times$、非退化条件 $(8.1)$ より $H(1,u\bmod\mathfrak m)\neq0$、ゆえに $v_\ell(\Psi)=0$ で $v_\ell(\Theta)=k\alpha=k/\varphi(\ell^M)$。

**(B) $i<j$（したがって $\varphi(\ell^i)<\varphi(\ell^j)$、$\beta<\alpha$、$M=j$）.** $p+q=k$ の項のうち $p\alpha+q\beta$ を最小にするのは $q=k$（$p=0$）ただ 1 つで、その値は $k\beta$。他の $p\ge1$ の項は $p\alpha+q\beta>k\beta$（$\alpha>\beta$ より）。よって

$$v_\ell(\Theta)=v_\ell(c_{0k}s^k)=v_\ell(c_{0k})+k\beta.$$

非退化条件の $H(0,1)=\bar c_{0k}\neq0$ より $v_\ell(c_{0k})=0$、ゆえに $v_\ell(\Theta)=k\beta=k/\varphi(\ell^M)$。

**(C) $i>j$.** (B) と対称（$H(1,0)=\bar c_{k0}\neq0$ を使う。$(8.1)$ の $c=0$ の場合）。

以上で $(8.3)$。$\blacksquare$

### 8.4 レベルごとの数え上げ

**補題 8.5.** *$n\ge1$ に対し*
$$S_n:=\sum_{i=1}^{n}\sum_{j=1}^{n}\varphi(\ell^i)\varphi(\ell^j)\cdot\frac{1}{\varphi(\ell^{\max(i,j)})}
=\frac{\ell+1}{\ell-1}\,\ell^{n}-2n+\Bigl(1-\frac{2\ell}{\ell-1}\Bigr).$$

**証明.** 被和は $\varphi(\ell^{\min(i,j)})$。
$\displaystyle S_n=\sum_{i=1}^n\varphi(\ell^i)+2\sum_{j=2}^{n}\sum_{i=1}^{j-1}\varphi(\ell^i)
=(\ell^n-1)+2\sum_{j=2}^{n}(\ell^{j-1}-1)$
（$\sum_{i=1}^{J}\varphi(\ell^i)=\ell^{J}-1$）。
$\sum_{j=2}^n\ell^{j-1}=\dfrac{\ell^{n}-\ell}{\ell-1}$ なので
$S_n=(\ell^n-1)+2\dfrac{\ell^n-\ell}{\ell-1}-2(n-1)
=\ell^n\Bigl(1+\dfrac{2}{\ell-1}\Bigr)-2n+\Bigl(1-\dfrac{2\ell}{\ell-1}\Bigr)$、
$1+\frac{2}{\ell-1}=\frac{\ell+1}{\ell-1}$。$\blacksquare$

### 8.5 定理 5

> **定理 5.** *(H) を仮定し、さらに塔が**非退化**（定義 8.1）であるとする。このとき $n_0\ge1$ と $\nu\in\mathbb{Q}$ が存在して*
> $$\mathrm{ord}_\ell(\kappa_n)=\mu\,\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\,\ell^{n}-2\,n+\nu\qquad(n\ge n_0). \tag{8.4}$$
> *とくに $(7.2)$ の係数は $a=\mu$、$b=l_0=0$、$c=\dfrac{k(\ell+1)}{\ell-1}$、$d=-2$ と完全に決まる。*

**証明.** $(6.1)$ の $\Sigma_n$ を 3 つに分ける:

$$\Sigma_n=\underbrace{\sum_{\zeta\neq1}v_\ell(E(\zeta,1))}_{\Sigma_n^{(z)}}
+\underbrace{\sum_{\xi\neq1}v_\ell(E(1,\xi))}_{\Sigma_n^{(w)}}
+\underbrace{\sum_{\zeta\neq1,\ \xi\neq1}v_\ell(E(\zeta,\xi))}_{\Sigma_n^{(zw)}}$$

（和はすべて $\ell^n$ 乗根の上。$(\zeta,\xi)\neq(1,1)$ の全体はこの 3 つの直和）。

**(1) $\Sigma_n^{(zw)}$.** $J_0:=\min\{J\ge1:\varphi(\ell^{J})>k\}$ と置く。$\zeta$ の位数を $\ell^i$、$\xi$ の位数を $\ell^j$（$1\le i,j\le n$）とすると、位数がその値になる冪根の個数はそれぞれ $\varphi(\ell^i)$, $\varphi(\ell^j)$ 個。

- $\max(i,j)\ge J_0$ の組: 補題 8.4 より $v_\ell(E(\zeta,\xi))=k/\varphi(\ell^{\max(i,j)})$。
- $\max(i,j)<J_0$ の組: 個数は $\le\ell^{2(J_0-1)}$ で **$n$ に依らない有限個**であり、各項は有限値（系 Q′ より $E(\zeta,\xi)\neq0$）。この部分の総和を $R$ と書くと $R$ は $n\ge J_0-1$ で $n$ に依らない定数。

したがって $n\ge J_0$ で

$$\Sigma_n^{(zw)}=k\,S_n-k\!\!\sum_{\max(i,j)<J_0}\!\!\frac{\varphi(\ell^i)\varphi(\ell^j)}{\varphi(\ell^{\max(i,j)})}+R
=\frac{k(\ell+1)}{\ell-1}\ell^{n}-2kn+C_1$$

（補題 8.5 を使い、差の分は $n$ に依らない定数 $C_1$ にまとめた）。

**(2) $\Sigma_n^{(z)}$.** $f_z(T):=E(1+T,1)$（単項式単元を除いて $\Lambda_1$ の元と見る）。
$\bar f_z(T)=\bar g(T,0)$ であり、$\bar g$ の総次数 $<k$ の項は $0$、総次数 $k$ で $S$ を含まない項の係数は $H(1,0)=\bar c_{k0}\neq0$（非退化）なので

$$\bar f_z\neq0,\qquad \mu(f_z)=0,\qquad \lambda_{\mathrm W}(f_z)=\mathrm{ord}_T(\bar f_z)=k. \tag{8.5}$$

（$\mu(f_z)=0$ は $\bar f_z\neq0$ から。$\lambda_{\mathrm W}=\min\{p:v_\ell(\text{$T^p$ の係数})=\mu\}=\mathrm{ord}_T(\bar f_z)$ は定理 W $(2.4)$。$\mathrm{ord}_T(\bar f_z)=k$ は、$\bar g$ の $S^0$ 部分の最低次数がちょうど $k$ であることから。）

定理 It1 の適用条件: $f_z\neq0$ ✓、$\ell$ 冪位数の $\zeta\neq1$ で $f_z(\zeta-1)=E(\zeta,1)\neq0$ ✓（系 Q′）。よって

$$\Sigma_n^{(z)}=(\ell^n-1)\cdot0+k\,n+C_2=k\,n+C_2\qquad(n\ge n_z).$$

**(3) $\Sigma_n^{(w)}$.** (2) と対称（$H(0,1)\neq0$ を使って $\mu(f_w)=0$, $\lambda_{\mathrm W}(f_w)=k$）:
$\Sigma_n^{(w)}=k\,n+C_3$（$n\ge n_w$）。

**(4) 合成.** $n\ge n_0:=\max(J_0,n_z,n_w)$ で

$$\Sigma_n=\frac{k(\ell+1)}{\ell-1}\ell^{n}-2kn+kn+kn+(C_1+C_2+C_3)
=\frac{k(\ell+1)}{\ell-1}\ell^{n}+C,$$

$C:=C_1+C_2+C_3$。$(6.1)$ に代入して

$$\mathrm{ord}_\ell(\kappa_n)=\mu\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\ell^{n}-2n+\underbrace{\bigl(v_\ell(\kappa(X))-\mu+C\bigr)}_{=:\nu}. \qquad\blacksquare$$

**注 8.6（$-2n$ の出所）.** $n$ の係数は、$(6.1)$ の $-2n$（$=-dn$、$d=2$、定理 1 の左辺の $NN'=\ell^{2n}$ から来る）と、$\Sigma^{(zw)}$ の $-2kn$（補題 8.5 の $-2n$ 由来）と、2 本の 1 変数行の $+2kn$ がちょうど打ち消し合って残るものである。$k$ が消えるのは偶然ではなく、$\Sigma^{(zw)}$ の $n$ 項が「$\min(i,j)$ による数え上げ」から出る $-2kn$ であり、行の側の $\lambda_{\mathrm W}=k$ と一致するためである。

**注 8.7（例）.** $\ell^n\times\ell^n$ トーラス（bouquet、voltage $(1,0),(0,1)$）では
$D=4-z-z^{-1}-w-w^{-1}$、$\mu=0$、$g=-\bigl(T^2(1+S)+S^2(1+T)\bigr)$（単元倍）、
$H=-(T^2+S^2)$、$k=2$。非退化 $\iff$ $-1$ が $\mathbb{F}_\ell$ の平方でない（かつ $H(1,0)=H(0,1)=-1\neq0$ は常に成立）。

- $\ell=3$: $-1$ は $\bmod 3$ で平方でない → **非退化**。$(8.4)$ は $\mathrm{ord}_3(\kappa_n)=4\cdot3^n-2n+\nu$。
  DuBose–Vallières §7 例 (4) の実測 $\mathrm{ord}_3(\kappa_n)=4\cdot3^n-2n-4$（$1\le n\le7$）と**係数まで一致**する（$\nu=-4$）。
- $\ell=7$: $-1$ は $\bmod 7$ で平方でない → **非退化**。$(8.4)$ は $\dfrac{2\cdot8}{6}\ell^n=\dfrac83\cdot7^n$。§11 Step 8 で $n\le2$ について確認（$\nu=-8/3$）。
- $\ell=2$: $T^2+S^2=(T+S)^2$ で $H(1,1)=0$ → **退化**。定理 5 の射程外。実際 $\mathrm{ord}_2(\kappa_n)$ には $n2^n$ 項がある（DuBose–Vallières 例 (1) の $2n2^n+4\cdot2^n-6n-1$）。
- $\ell=5$: $-1\equiv4=2^2$ は平方 → **退化**。§11 Step 8 で退化と判定された（$H$ の有理零点は $(1:2),(1:3)$）。
  ただし $\ell=5$ で計算した段数は $n\le3$ なので、**$n5^n$ 項が実際に存在するかどうかは確認していない**（5 係数を決めるには 5 段必要）。

**注 8.8（本プロジェクトの主対象への含意）.** 本プロジェクトが狙う $L\times L$ トーラスの $\ell=2$ 塔は**まさに退化ケース**である。したがって定理 5 は $\mathrm{ord}_2(\tau(2^n\times2^n))$ を与えない。退化ケースの一般論は §9-2 のとおり未解決である。

**注 8.9（$\ell=2$ の bouquet は多くの場合必ず退化する）.**

> *bouquet（$m=1$、辺の voltage を $(a_i,b_i)_{i}$）について、$Q(T,S):=-\sum_i(a_iT+b_iS)^2$ が $\bmod\,2$ で $0$ でないならば、$\ell=2$ の塔は退化する。*

**証明.** $\mathbf m_i=z^{a_i}w^{b_i}$ に対し $D=-\sum_i(\mathbf m_i-1)^2/\mathbf m_i$（§1.4 のループの寄与 $2-\mathbf m-\mathbf m^{-1}$ をまとめたもの）で、$\mathbf m_i(1+T,1+S)-1=(a_iT+b_iS)+(\text{次数}\ge2)$、$\mathbf m_i^{-1}$ は定数項 $1$ の単元。よって $D(1+T,1+S)$ の 2 次斉次部分は $Q$ である（1 次以下は $0$、補題 5.2）。
$Q\not\equiv0\bmod2$ なら $D(1+T,1+S)$ の係数のどれかが奇数なので $\mu=v_2(\mathrm{content}\,D)=0$、したがって $E=D$、$k=2$、$H=\bar Q$。
$\bmod\,2$ では $2a_ib_iTS\equiv0$ なので
$$H=\bar Q=\Bigl(\sum_ia_i^2\Bigr)T^2+\Bigl(\sum_ib_i^2\Bigr)S^2\pmod2,$$
$\mathbb{F}_2$ では $\alpha T^2+\beta S^2=(\alpha T+\beta S)^2$（$\alpha,\beta\in\{0,1\}$、$\mathbb{F}_2$ で $\alpha^2=\alpha$）と平方に書けるので、$H\neq0$ なら $\mathbb{P}^1(\mathbb{F}_2)=\{(1:0),(0:1),(1:1)\}$ の有理零点をもつ。$\blacksquare$

$Q\equiv0\bmod2$ の場合（$\sum a_i^2$ と $\sum b_i^2$ がともに偶数）は $k>2$ になりうるので上の議論は使えず、**判定していない**。
§11 Step 8 の標本 30 件では $\ell=2$ の非退化例は 1 件も現れなかったが、**これは 0 件の観察であって「$\ell=2$ では常に退化する」ことの根拠にはならない**。
いずれにせよ $\ell=2$ が定理 5 にとって不利な素数であることは確かで、**本プロジェクトの主対象（$L\times L$ トーラスの $\ell=2$ 塔）がちょうどそこにある**。

> **機械検証**: Step 8（非退化判定と $(8.4)$ の照合）、Step 9（補題 8.4 $(8.3)$ を円分体の素イデアルで点ごとに直接確認）。

---

## 9. 証明できなかったこと・詰まった箇所（正直に）

### 9-1. $a\le\mu$（定理 4 の上からの不等式）を自前で証明できなかった

$(6.1)$ より $a\le\mu$ は

$$\Sigma_n=\sum_{(\zeta,\xi)\neq(1,1)}v_\ell\bigl(E(\zeta,\xi)\bigr)=O(n\,\ell^{n})\qquad(\ell\nmid\mathrm{content}(E)) \tag{9.1}$$

と同値である。**$(9.1)$ を証明できなかった。**どこで詰まったかを具体化する。

1 変数の技法（1 個の $\xi$ を固定して $\zeta$ について定理 It1 を使う）を試みると、次の厳密な等式までは進める。$\xi\neq1$ を固定し、$K=\mathbb{Q}_\ell(\xi)$、$E(z,\xi)=z^{-r}G_\xi(z)$（$G_\xi\in\mathcal O_K[z]$、$G_\xi(0)\neq0$）と書くと、$\prod_{\zeta^{L}=1}(x-\zeta)=x^L-1$ から

$$\sum_{\zeta^{\ell^n}=1}v_\ell\bigl(E(\zeta,\xi)\bigr)
=\ell^{n}\,\mu_\xi+\sum_{\substack{\gamma:\ G_\xi(\gamma)=0\\ v_\ell(\gamma)=0}}v_\ell\bigl(\gamma^{\ell^{n}}-1\bigr),
\qquad \mu_\xi:=\min_i v_\ell\bigl(\text{$G_\xi$ の第 $i$ 係数}\bigr) \tag{9.2}$$

（$v_\ell(\gamma)<0$ の根は $v_\ell(\gamma^{\ell^n}-1)=\ell^nv_\ell(\gamma)$ を与え、Newton 多角形の等式
$v_\ell(\mathrm{lc}\,G_\xi)+\sum_{v_\ell(\gamma)<0}v_\ell(\gamma)=\mu_\xi$ で $\ell^n$ の項がまとまる。$v_\ell(\gamma)>0$ の根は寄与 $0$）。

- $\sum_{\xi\neq1}\mu_\xi=O(n)$ は示せる。概略: $E(z,w)=\sum_iA_i(w)z^i$ と展開すると $\mu_\xi\le v_\ell(A_{i}(\xi))$（任意の $i$）で、$\ell\nmid\mathrm{content}(E)$ より $\ell\nmid\mathrm{content}(A_{i_0})$ となる $i_0$ が存在する。$A_{i_0}$ に $(9.2)$ と同じ Newton 多角形の等式を適用すると $\sum_{\xi^{\ell^n}=1}v_\ell(A_{i_0}(\xi))=\ell^{n}\cdot0+\sum_{\delta}v_\ell(\delta^{\ell^n}-1)$（$\delta$ は $A_{i_0}$ の根で $v_\ell(\delta)=0$ のもの、有限個）となり、下の一様離散性の評価から $O(n)$。$A_{i_0}(\xi)=0$ となる $\xi$ は $A_{i_0}$ の次数以下の有限個で、その各々では $E(z,\xi)\not\equiv0$（系 Q′）より $\mu_\xi<\infty$ が $n$ に依らない定数として押さえられる。
- **詰まったのは第 2 項である。** $v_\ell(\gamma^{\ell^n}-1)=\sum_{\zeta^{\ell^n}=1}v_\ell(\gamma-\zeta)$ であり、$\mu_{\ell^\infty}$ が $\mathbb{C}_\ell$ の中で一様離散（相異なる $\ell$ 冪根 $\zeta\neq\zeta'$ で $v_\ell(\zeta-\zeta')\le1/(\ell-1)$）であることから、固定した $\gamma\notin\mu_{\ell^\infty}$ については
  $$v_\ell(\gamma^{\ell^n}-1)\le n+c_\gamma,\qquad c_\gamma:=\sup_{\zeta\in\mu_{\ell^\infty}}v_\ell(\gamma-\zeta)<\infty$$
  が言える。しかし $\gamma$ は $\xi$ に依存するので、$(9.1)$ には
  $$\sup_{\xi\in\mu_{\ell^\infty}\smallsetminus\{1\}}\ \max_{\gamma}\ c_\gamma\ <\ \infty$$
  という **$\xi$ に関する一様性**が必要である。これは「$\det L(z,\xi)$ の根が $\ell$ 冪根の $1$ にどれだけ近づけるか」を $\xi$ について一様に押さえる主張であり、まさに $(9.1)$ が主張していることと同じ内容なので、この経路は循環する。

$\mathfrak m$-進の吹き上げ（§8 の補題 8.4 の議論）で代わりに攻めると、非退化なら 1 段で終わるが、退化（$H$ が $\mathbb{F}_\ell$ 有理な零点をもつ）だと**その方向の帯（$b\equiv ca\bmod\ell$、点の個数は $\ell^{2n}$ の正の割合）で吹き上げを繰り返す必要がある**。実例として $\ell=2$ のトーラスでは $H=-(T+S)^2$ なので位数 $(n,n)$ の点は**全部**が退化帯に入る（$\ell=2$ では $\mathbb{F}_2^\times=\{1\}$）。この反復が Monsky の定理 5.6 / Cuoco–Monsky の証明の本体だと理解しており、**本レポートでは実行できなかった。**

**したがって定理 4 の $(7.3)$ は既知定理（定理 CM）の帰結として述べており、本レポートの証明ではない。** 自前に証明できたのは下界（定理 3）だけである。

### 9-2. 退化ケースの $\ell^n$ 係数・$n\ell^n$ 係数を決めていない

- $n\ell^n$ の係数は定理 CM により $l_0(\bar Q_\ast)$ と**既知**だが、$l_0$（素因子 $(\gamma-1)$ の重複度の総和）を $\det L$ の係数から読む有限手続きは本レポートでは書いていない。補題 7.3 は「$H$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたない $\Rightarrow l_0=0$」という**片側**だけである（逆は偽: §11 Step 7 の DV 例 (5) は $H=-S(2T+S)$ で有理零点をもつが $b=0$）。
- $\ell^n$ の係数 $\mu_1$ は、非退化なら定理 5 で $k(\ell+1)/(\ell-1)$ と決まるが、**退化ケースでは決めていない**。DV 例 (1) では $4$、例 (3) では $33/4$、例 (5) では $20/3$ と、$k(\ell+1)/(\ell-1)$（それぞれ $6,6,4$）と一致しない。
- $\nu$ の閉形式は与えていない（定理 5 の証明は $C_1,C_2,C_3$ という表示を与えるが、$C_2,C_3$ は定理 It1 の定数、$C_1$ は低レベルの寄与で、$\det L$ の係数から直接読む手続きは書いていない）。
- **非退化な塔が $\ell=2$ で存在するかを決めていない**（注 8.9）。$Q\equiv0\bmod2$ の bouquet や $m\ge2$ の場合を尽くしていない。§11 の標本 30 件で $\ell=2$ の非退化例が 0 件だったのは 0 件の観察であって、非存在の証明ではない。
- $n_0$（漸近が成立し始める段）の明示的上界を与えていない。定理 5 の証明では $n_0=\max(J_0,n_z,n_w)$ で $J_0$ は $\varphi(\ell^{J})>k$ から明示的だが、$n_z,n_w$ は定理 It1（補題 E）の $n_\beta$ 由来で、根の付値の下界を係数から出す評価を書いていない。

### 9-3. 文献の未取得・未確認

1. **Monsky, Math. Ann. 255 (1981) 217–227 と Cuoco–Monsky, Math. Ann. 255 (1981) 235–258 の原論文本文は取得できなかった。** 試した経路: Springer（`https://link.springer.com/article/10.1007/BF01450674`、`.../BF01450672`、購読制）、EUDML（`https://eudml.org/doc/182837`、HTTP 403）、GDZ（`https://gdz.sub.uni-goettingen.de/id/PPN235181684_0255` は JS 依存で本文一覧に到達せず、`/mets/...` は 404）。したがって §2 の定理 M・定理 CM の文言は**Kataoka arXiv:2606.03579v1 の本文（Theorem 2.1 / Definition 2.2 / Theorem 2.3）で確認したもの**であり、原論文の本文で確認したものではない。
2. **Cuoco–Monsky の $l_0$ の「明示公式」がどこまで計算可能な形なのかは確認していない。** DuBose–Vallières の Remark（§2）が「explicit formulas」と述べていることと、Kataoka Definition 2.2 の定義式までは確認したが、$\det L$ から $l_0$ を計算する手続きの有無は未確認。
3. **定理 5 の $\ell^n$ 係数 $k(\ell+1)/(\ell-1)$ が既出かどうかは確認できなかった。** 文献で明示公式が与えられているのは $X^d$ と $YX^{d-1}$ の係数のみ（DuBose–Vallières の Remark、Kataoka Theorem 1.1 の「explicit leading coefficients $\lambda$ and $\mu$」）で、$\mu_1$（$X^{d-1}$ の係数）の明示公式には言及がない。しかし網羅的な文献調査はしていないので**新規性は主張しない**（§10）。
4. Besser–Deninger 1999 の本文は依然未取得（cycle 13 step 1 report §1 と同じ状態）。本レポートはその内容を使っていない。

---

## 10. 新規性について（主張しない）

1. **漸近形（$\mathrm{ord}_\ell(\kappa_n)=P(\ell^n,n)$、総次数 $\le d$、$Y$ について次数 $\le1$）は既知である。** DuBose–Vallières Theorem A（= Theorem 6.2、本文取得済み、§2）。
2. **$\ell^{2n}$ の係数が $m_0$（＝係数の付値の最小値＝ content の付値）で与えられることも既知である。** Cuoco–Monsky Theorem 1.7（Kataoka の本文で確認、§2）。DuBose–Vallières 自身が Theorem 6.2 の直後の Remark で「$X^d$ と $YX^{d-1}$ の係数の明示公式が [1] Definition 1.1, 1.2 にある」と述べている。したがって定理 4 $(7.3)$ は**既知結果の言い換え**である。
3. **$n\ell^n$ の係数（$l_0$）も既知である**（同上）。さらに Kataoka arXiv:2606.03579 Theorem 1.1 は分岐を許す $\mathbb{Z}_\ell^d$-被覆で $\lambda=l_0(\mathrm{Jac}_{\mathbb{Z}_\ell}X_\infty)$, $\mu=m_0(\mathrm{Jac}_{\mathbb{Z}_\ell}X_\infty)$ と主要係数を明示している。
4. **$(★_2)$（定理 1）も本質的に既知である。** DuBose–Vallières は Artin–Ihara $L$ 函数の特殊値 (12) $|G|\kappa_Y=\kappa_X\prod_{\psi\neq\psi_0}h_X(1,\psi)$ を使っており、$h_X(1,\psi)=\det(D-A_\psi)$ は本レポートの $\det L(\zeta,\xi)$ と同じ量である（同 Theorem 6.1）。本レポートの寄与は**離散 Fourier と Kirchhoff だけで、ゼータ函数を経由せずに、$\chi(X)\neq0$ 等の仮定なしに証明したこと**だけである。
5. **定理 5（非退化な塔での $\ell^n$ 係数まで込みの閉形式）だけは、文献で既出を確認できなかった。**それでも新規性は主張しない: (i) 文献調査は網羅的でない、(ii) 証明は $\mathfrak m$-進の 1 段の吹き上げという初等的な議論で、Monsky/Cuoco–Monsky の技法の最も易しい特別ケースにあたる可能性が高い、(iii) 原論文本文が未取得（§9-3-1）なので、そこに含まれているかどうかを判定できない。
6. cycle 13 step 2 と同様、**本レポートの寄与は「本プロジェクトの記法・仮定で、外部文献の本文を参照せずに読める証明を、$d=2$ について与えたこと」**である。

---

## 11. 数値検証

`sagemath/check/cycle14_T3_two_var/`（SageMath 10.6、`sage two_var.sage`、ログ `two_var.out`）。

| Step | 検証内容 | 対応する主張 | 結果 |
|---|---|---|---|
| 1 | $\det(xI-L_{X_{N,N'}})=\prod_{\zeta,\xi}\det(xI-L(\zeta,\xi))$（円分体上の厳密等式、$N,N'\le3$） | 補題 A2 | 180 件、不一致 0 |
| 2 | $c(X_{N,N'})=\sum_{\zeta,\xi}\dim\ker L(\zeta,\xi)$（$N,N'\le4$） | 補題 B2 | 576 件、不一致 0 |
| 3 | $X_{N,N'}$ 連結 $\iff B+(N\mathbb{Z}\oplus N'\mathbb{Z})=\mathbb{Z}^2$（Smith 標準形、$N,N'\le6$） | 補題 C2 | 1296 件（うち非連結 549 件）、不一致 0 |
| 4 | $NN'\kappa(X_{N,N'})=\kappa(X)\prod_{(\zeta,\xi)\neq(1,1)}D(\zeta,\xi)$（左辺 Kirchhoff、右辺は円分体直積と 2 段終結式の 2 通りで独立計算） | 定理 1 | 563 件（うち両辺 $0$ の退化ケース 222 件）、不一致 0 |
| 5 | $v_\ell(\mathrm{content}_{z,w}D)=\min_{ij}v_\ell(c_{ij})$、単項式正規化の非依存性（$\ell\in\{2,3,5,7,23\}$） | 補題 D2 | 155 件、不一致 0 |
| 6 | DuBose–Vallières §7 の 5 例の表と公式の再現（外部照合） | 定理 1 の外部検証 | **5 例すべて一致** |
| 7 | $\mathrm{ord}_\ell(\kappa_n)$ を $[\ell^{2n},n\ell^n,\ell^n,n,1]$ で fit し $a$ と $v_\ell(\mathrm{content})$ を比較（$\ell=2$、$n\le6$） | 定理 3, 定理 4 | 13 件のうち fit が out-of-sample 検算を通った 8 件で $a=v_2(\mathrm{content})$（不一致 0）。残り 5 件は検算が失敗＝ fit 窓が漸近域に未到達で無効（下記） |
| 8 | 非退化判定と閉形式 $(8.4)$ の照合（$\ell\in\{2,3,5,7\}$） | 定理 5 | 判定 30 件、うち**非退化 9 件はすべて $(8.4)$ が全段で成立**（破れ 0）。退化 21 件は定理の射程外 |
| 9 | $v_\ell(\det L(\zeta,\xi))=\mu+k/\varphi(\ell^{\max(i,j)})$ を円分体の素イデアルで点ごとに確認 | 補題 8.4 | 472 件、不一致 0（$\varphi(\ell^{\max})\le k$ で対象外 56 件） |

計算はすべて整数・円分体上の厳密演算（終結式・Smith 標準形・素イデアル付値）で、浮動小数点を使わない。

### 11.1 Step 6 の外部照合（もっとも重要な検証）

`two_var.out` より（$\ell$、$n$ の範囲、本計算値、論文の公式）:

| DV §7 の例 | $\ell$ | 本計算 $\mathrm{ord}_\ell(\kappa_n)$ | 論文の公式 | $\mu=v_\ell(\mathrm{content})$ | $\ell^{2n}$ 係数 |
|---|---|---|---|---|---|
| (1) bouquet $(1,0),(0,1)$（$=\ell^n\times\ell^n$ トーラス） | 2 | $5,19,61,167,417,987$ | $2n2^n+4\cdot2^n-6n-1$ | $0$ | $0$ ✓ |
| (2) 同じものを 2 重化（content $2$） | 2 | $8,34,124,422,1440,5082$ | $2^{2n}+2n2^n+4\cdot2^n-6n-2$ | $1$ | $1$ ✓ |
| (3) $(1,5),(0,3),(1,2),(0,1)$ | 2 | $5,19,65,179,403,887$ | $n2^n+\frac{33}{4}2^n-4n-1$（$n\ge4$） | $0$ | $0$ ✓ |
| (4) bouquet $(1,0),(0,1)$ | 3 | $6,28,98,312$ | $4\cdot3^n-2n-4$ | $0$ | $0$ ✓ |
| (5) $(1,0),(2,3),(1,1)$ | 3 | $10,48,166,524$ | $\frac{20}{3}3^n-2n-8$ | $0$ | $0$ ✓ |

**すべて論文の表と一致した。**（本計算は $(★_2)$ ＋ 2 段終結式、論文は Artin–Ihara $L$ 函数の特殊値と $\mathbb{C}$ 上の高精度数値計算＋整数への丸め、という**独立な経路**である。）
例 (4) は**定理 5 の予言 $\mathrm{ord}_3(\kappa_n)=0\cdot3^{2n}+\frac{2\cdot4}{2}3^n-2n+\nu=4\cdot3^n-2n-4$ と係数まで一致する**（$k=2$、非退化）。
例 (1)(2) の $\ell=2$ と例 (3)(5) は退化ケースで、$n\ell^n$ 項が現れている（定理 5 の非退化仮定が効いていることの確認）。

### 11.2 Step 7 で fit が無効になった 5 件について（重要な注意）

$n$ の範囲が $n\le6$（$\ell=2$）なので fit 窓は $n=2,\dots,6$ である。**$n_0>2$ の例では fit 窓が漸近域に入っておらず、係数は意味をもたない。**
実際、DV 例 (3)（論文自身が「$4\le n\le10$ で成立」と書いている＝$n_0=4$）では fit が $a=23/144$ という**非整数**を返した。
文献（Monsky [14, Remark 2]、Cuoco–Monsky Definition 1.1）は $\ell^{2n}$ の係数が**非負整数**であると述べているので、
この非整数性は「定理 4 の反例」ではなく「fit 窓が漸近域に未到達である」ことの徴候である。
`two_var.sage` はこの 5 件を **fit 無効**として分類し、$a$ と $\mu$ の比較対象から外している。
**したがって Step 7 が支持しているのは「out-of-sample 検算を通った 8 件で $a=\mu$」であり、13 件全部ではない。**

**これらは有限個の例での照合であって証明ではない。**証明本体は §3–§8 である。数値検証の役割は、証明の書き間違い（符号・添字・場合分けの取りこぼし）を検出することに限られる。とくに **Step 7 の fit は 5 点から 5 係数を解いたものであって、それ自体は何も証明しない**（cycle14 step 1 report §6.1-1 と同じ注意）。

---

## 12. 並行して書かれた `cycle14_T3_Zl2_tower_criterion.md` との関係（重複と差分）

本レポートを書いている間に、**同じ課題（cycle 14 step 1 の T3: $\mathbb{Z}_\ell^2$-塔への拡張）が別セッションでも実行され**、
`outputs/reports/cycle14_T3_Zl2_tower_criterion.md` と `sagemath/check/cycle14_T3_Zl2_tower/` が main に入っている。
両者は独立に書かれたもので、次のように重複と差分がある。**読者はまず重複部分を 1 度だけ読めばよい。**

**重複している（両方が独立に同じ結論に達した）部分**:

- $(★_2)$（本レポート定理 1 / 向こうの定理 1′）。証明の骨格（離散 Fourier ＋ Kirchhoff、退化ケースは両辺 $0$）も同じ。
  向こうは有限アーベル群 $A$ 一般で書いており、その点は本レポートより一般である。
- 連結性の格子判定（本レポート補題 C2 / 向こうの補題 C2）と塔での all-or-nothing。
- 下界 $a\ge\mu=v_\ell(\mathrm{content}_{z,w}\det L)$（本レポート定理 3 / 向こうの定理 2′）。
- **上界 $a\le\mu$ を自前では証明できなかったこと、および詰まった箇所が「$\ell$ 冪根への近づき方の一様評価」であること。**
  2 つの独立な試行が同じ 1 点で詰まった、という事実自体が情報である。
- DuBose–Vallières の本文取得と、「$X^d$, $YX^{d-1}$ の係数の明示公式が Cuoco–Monsky にある」ことの確認。新規性を主張しないこと。

**本レポートにしかない部分**:

1. **定理 4**: $a=\mu$ が既知定理の帰結であることを、**Cuoco–Monsky Theorem 1.7 の主張（$\lambda=l_0(f)$, $\mu=m_0(f)$）と $m_0$ の定義まで押さえて**確定させた（§2、§7）。向こうは DuBose–Vallières の Remark から「明示公式が既知」までで止まっており、その公式が何かは特定していない。本レポートは Kataoka arXiv:2606.03579v1 の本文（Theorem 2.1 / Definition 2.2 / Theorem 2.3）で確認した。
2. **定理 5**: 非退化条件（$H$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたない）の下での**完全な閉形式**
   $\mu\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\ell^n-2n+\nu$（$\ell^n$ の係数と $n$ の係数まで決定）。
   向こうの定理 3′ は「$\bar f_1$ が単項式×単元」という**別の仮定**の下で $\mu\ell^{2n}+(a+b)n\ell^n+O(\ell^n)$ までであり、$\ell^n$ 係数を決めていない。
   **2 つの特別ケースは互いに排他的である**: 向こうの仮定が成立すると $H$ は $c\,T^aS^b$（$a+b=k\ge2$、補題 5.2）になり $\mathbb{P}^1(\mathbb{F}_\ell)$ 有理零点をもつので本レポートの意味で退化する。逆に本レポートの非退化条件が成立すると $H$ は単項式でないので向こうの仮定は成立しない。すなわち本レポートは $n\ell^n$ 項が**消える**場合、向こうは $n\ell^n$ 項が**残る**場合を扱っており、両者は相補的である。
3. **補題 7.3**（$H$ に $\mathbb{F}_\ell$ 有理零点がなければ $l_0=0$、すなわち $n\ell^n$ 項が消える）。
4. **注 8.9**（$\ell=2$ の bouquet が多くの場合必ず退化すること）。
5. **DuBose–Vallières §7 の 5 例すべてを $(★_2)$ 経由で再現した外部照合**（§11.1）。向こうの検証は自前の例が中心である。

**矛盾はない。**両者の共通部分の結論（$(★_2)$、連結性判定、$a\ge\mu$、$a\le\mu$ が未証明）は一致している。

---

## 13. cycle 13 / cycle 14 step 1 との関係

- **cycle 13 report §10-8「$d\ge2$ の塔は扱っていない。$L\times L$ トーラスにはそのままでは適用できない」に応答した。** $(★)$ は $d=2$ へそのまま拡張でき（定理 1）、退化ケースの決定手続きも拡張できた（補題 C2）。判定式 $(☆)$ は「content が $\ell^{2n}$ の係数を与える」という形に**変わる**（定理 4、§7.3）。
- **cycle 13 の $d=1$ の結果は $d=2$ の特別な断面として現れる。** 定理 5 の証明の $\Sigma^{(z)},\Sigma^{(w)}$ は、$w=1$（あるいは $z=1$）に制限した 1 変数の塔についての cycle 13 定理 2 そのものである。
- **cycle14 step 1（命題 V）との住み分けを確定した**（§7.4）。命題 V は $P(1,1)\neq0$ のレジーム、本レポートは $\det L(1,1)=0$ のレジーム。両者は交わらない。
- **002（`outputs/paper-plans/002_R_Lambda_duality.md`）への含意**: 002 §2 の双対命題 D の ($p$ 素点) 側について、**グラフ（$\det L$ 型）の場合には $d=2$ での正しい形が確定した**（$(7.2)$、$\ell^{2n}$ 係数 $=v_\ell(\mathrm{content})$、$n\ell^n$ 係数 $=l_0$）。ただし 002 が対象とする**一般の $P\in\mathbb{Z}[z^\pm,w^\pm]$ の $a_L$** については依然として未確定であり（cycle14 step 1 §6.1）、**G1 は未達のまま**である。本レポートでは 002 を編集していない。
