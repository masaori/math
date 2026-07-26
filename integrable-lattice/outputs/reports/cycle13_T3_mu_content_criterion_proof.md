# cycle 13 / T3 Pure: 判定式 $\mu_\ell = v_\ell(\mathrm{content}_z \det L(z))$ と公式 $(★)$ の証明

対象: cycle 12 / T3（`sagemath/check/cycle12_T3_nonzero_mu_p/`）で**数値照合のみ**だった 2 つの主張

- $(★)$ 導来グラフの全域木数の公式 $\kappa(X_N) = \dfrac{\kappa(X)}{N}\displaystyle\prod_{\zeta^N=1,\ \zeta\neq1}\det L(\zeta)$
- $(☆)$ 岩澤 $\mu$ の判定式 $\mu_\ell = v_\ell(\mathrm{content}_z(\det L(z)))$

を証明する。証明は完全に書く（「同様に」で飛ばさない）。使用する既知定理は
**Kirchhoff の matrix-tree 定理**と **Weierstrass 準備定理**の 2 つだけであり、
いずれも適用条件を満たすことを使用箇所ごとに明示的に確認する。

## 0. 結論の要約と、新規性についての位置づけ（先に述べる）

**証明できたこと**:

1. $(★)$ を、**連結性の仮定なしに**、任意の有限多重グラフ $X$（ループ・多重辺可、非連結可）と
   任意の $N\ge1$ に対して証明した（定理 3.4）。退化ケース（$X_N$ 非連結、$\det L(\zeta)=0$ となる
   $\zeta$ が存在、$X$ 自身が非連結、$\det L\equiv0$）は**両辺が 0 になる**形で式に含まれる。
2. $X_N$ の連結成分数が $\gcd(d,N)$（$d$ は後述の voltage 指数）であること、および
   「$X_N$ 連結 $\iff$ 全ての $\zeta\in\mu_N\setminus\{1\}$ で $\det L(\zeta)\neq0$」を証明した（命題 4.3）。
3. $\mathrm{ord}_\ell(\kappa_n) = \mu\,\ell^n+\lambda n+\nu$（$n\gg0$）という**岩澤型漸近そのものを、
   既知理論に依拠せず証明した**（定理 6.1）。依拠したのは Weierstrass 準備定理と matrix-tree 定理のみ。
4. その $\mu$ が $(☆)$ で与えられること、さらに $\lambda$ も
   $\lambda = \lambda_{\mathrm{W}}(\det L(1+T))-1$ で与えられることを証明した（定理 6.1）。
   $\lambda$ は cycle 12 の課題対象外だったが、同じ証明から落ちる。
5. $\mu_\ell>0 \iff \det L(z)\bmod\ell$ が $\mathbb{F}_\ell(z)$ 上で $0$（命題 7.1）。
6. bouquet（1 頂点）では $\mathrm{content}_z\det L$ がループ重複度の $\gcd$ に一致し、
   したがって $\mu_\ell>0$ は「$\ell$ 重多重グラフ」という自明例に限る（命題 7.2）。
   これは cycle 12 README §2 の観察の証明である。

**証明できなかったこと**（§9 に詳述）: $p\neq\ell$ のときの $v_p(\kappa_n)$ の漸近形。
下界 $v_p(\kappa_n)\ge \mu_p\ell^n + (v_p(\kappa_0)-\mu_p)$ は証明したが、
残差が有界かどうか（Washington–Sinnott 型の問題）は証明していない。

**新規性は主張しない。** 上記 1・3・4 は、文献に**同等以上の命題が既に存在することを本文で確認した**。

- $(★)$ に相当する式 $|G|\cdot\kappa_Y = \kappa_X\prod_{\Psi\neq\Psi_0} h_X(1,\Psi)$ は
  McGown–Vallières, *On abelian $\ell$-towers of multigraphs III*（arXiv:2107.07639）§5 の
  式 (7) の直前で、Vallières (I)（arXiv:2006.14012）の式 (7) として引用されている（$\chi(X)\neq0$ を仮定）。
  さらに Hammer–Mattman–Sands–Vallières, *The special value $u=1$ of Artin–Ihara $L$-functions*
  の Theorem 2.11 ＋ Theorem 3.1 ＋ Corollary 3.5（$L^*_{Y/X}(1,\chi)=(-2)^{r_X-1}\det(D-A_\chi)$）を
  組み合わせると $(★)$ が直ちに従う。**本文 PDF を取得して確認した。**
- 定理 6.1（岩澤型漸近＋$\mu,\lambda$ の決定）は、McGown–Vallières III の **Theorem 6.1 そのもの**である。
  同定理は $\mu=\min\{v_\ell(c_j)\}$, $\lambda=\min\{j: v_\ell(c_j)=\mu\}-1$（$Q(T)=c_1T+c_2T^2+\cdots$）
  と述べており、その $Q(T)$ は Corollary 5.6 の構成から $\det L(1+T)$ に一致する。
  つまり本稿の $\mu,\lambda$ の式は同定理と**完全に一致する**（$\lambda$ の $-1$ のずれ方まで一致）。
  **本文 PDF を取得して確認した**（引用は §10 に逐語で置く）。
- $(☆)$ は、上記 Theorem 6.1 の $\mu$ に「$z\mapsto1+T$ が content を保つ」（補題 5.3）を合わせたもので、
  新しい命題ではない。

したがって本稿の位置づけは「**既知定理の、より初等的で仮定の少ない自己完結証明**」である。
本プロジェクト固有の寄与があるとすれば次の 2 点だけで、これも新規性の主張ではない。

- $(★)$ を Artin–Ihara $L$ 函数を経由せず Kirchhoff の微分形だけで示したため、
  文献側の仮定（$\chi(X)\neq0$、次数 1 の頂点を持たない、連結）が**すべて不要**になった。
- $\mu$ を content として書くと、$\mu_\ell>0$ が「$\mathbb{F}_\ell(z)$ 上で $L$ が特異」という
  **有限体上の 1 個の行列式判定**になる（命題 7.1）。決定可能性の梯子（本プロジェクトの選別軸）では
  これは $\Lambda$ 側の量が $\mathbb{F}_\ell$ 上の計算に落ちることを意味する。

---

## 1. 設定：記号と定義をすべて明示する

以下すべて有限・離散・整数係数であり、$\mathbb{R}$ は一切使わない。使う体は
$\mathbb{Q}$ の円分拡大 $\mathbb{Q}(\zeta_N)$、$\mathbb{Q}_\ell$ の代数拡大、有限体 $\mathbb{F}_\ell$ のみ
（すべて代数的）。

**定義 1.1（多重グラフ）.**
$X$ を有限多重グラフとする。頂点集合 $V=\{0,1,\dots,m-1\}$（$m\ge1$）、
辺集合 $E$ は $V\times V$ の元の**有限多重集合**として与える。各辺 $e$ には向きを 1 つ固定し、
$e=(u,v)$（$u$ が始点、$v$ が終点）と書く。$u=v$ の辺を**ループ**と呼ぶ。
同じ $(u,v)$ が複数回現れてよい（多重辺）。

**定義 1.2（ラプラシアン）.**
$\Delta_X\in M_m(\mathbb{Z})$ を
$$(\Delta_X)_{uv} = \begin{cases} \#\{e\in E : e \text{ は } u \text{ に接続する非ループ辺}\} & u=v\\ -\#\{e\in E: e=(u,v)\ \text{または}\ e=(v,u)\} & u\neq v\end{cases}$$
で定める。**ループは $\Delta_X$ に寄与しない**（これが標準的な規約であり、
ループはどの全域木にも属さないので matrix-tree 定理と整合する）。
$\Delta_X\mathbf{1}=0$（$\mathbf 1$ は全成分 1 のベクトル）であるから $\Delta_X$ は特異である。

**定義 1.3（全域木数）.** $\kappa(X)$ = $X$ の全域木の個数。$X$ が非連結なら $\kappa(X)=0$。
$m=1$ のとき $\kappa(X)=1$（頂点 1 個だけの木）。

**定義 1.4（voltage 割り当てと導来グラフ）.**
$\alpha: E\to\mathbb{Z}$ を写像とし、辺 $e=(u,v)$ に対し $\alpha(e)=a$ を **voltage** と呼ぶ。
$e$ を三つ組 $(u,v,a)$ と書く。$N\in\mathbb{Z}_{\ge1}$ に対し**導来グラフ** $X_N$ を次で定める。

- 頂点集合 $V\times\mathbb{Z}/N$
- 各辺 $(u,v,a)\in E$ に対し、$N$ 本の辺 $\{(u,i),\ (v,\overline{i+a})\}$（$i\in\mathbb{Z}/N$）

$X_N$ も有限多重グラフである（ループが生じうる：$u=v$ かつ $a\equiv0\bmod N$ のとき）。
$X_1=X$。射影 $X_N\to X$, $(u,i)\mapsto u$ は全射なグラフ射なので、
**$X_N$ が連結なら $X$ も連結**である。

**定義 1.5（voltage ラプラシアン）.**
$\mathbb{Z}[z,z^{-1}]$ を Laurent 多項式環とし、$L(z)\in M_m(\mathbb{Z}[z,z^{-1}])$ を
各辺の寄与の和として定める。

- 非ループ辺 $(u,v,a)$（$u\neq v$）: $L_{uu}\mathrel{+}=1$, $L_{vv}\mathrel{+}=1$,
  $L_{uv}\mathrel{-}=z^{a}$, $L_{vu}\mathrel{-}=z^{-a}$
- ループ $(u,u,a)$: $L_{uu}\mathrel{+}=2-z^{a}-z^{-a}$

$D(z):=\det L(z)\in\mathbb{Z}[z,z^{-1}]$ と書く。

**補題 1.6.** $L(1)=\Delta_X$。したがって $D(1)=\det\Delta_X=0$。

*証明.* $z=1$ で非ループ辺の寄与は $L_{uu}+{=}1,L_{vv}+{=}1,L_{uv}-{=}1,L_{vu}-{=}1$ となり
定義 1.2 と一致する。ループの寄与は $2-1-1=0$ で、これも定義 1.2（ループは寄与しない）と一致する。
$\Delta_X\mathbf1=0$ より $\det\Delta_X=0$。∎

**補題 1.7.** $L(z)^{\mathsf T}=L(z^{-1})$、したがって $D(z)=D(z^{-1})$（$D$ は回文的）。

*証明.* 非ループ辺の寄与について $(L_{uv},L_{vu})=(-z^a,-z^{-a})$ は転置と $z\mapsto z^{-1}$ で
入れ替わり、対角成分 $1,1$ は不変。ループの寄与 $2-z^a-z^{-a}$ は $z\mapsto z^{-1}$ で不変。
よって $L(z)^{\mathsf T}=L(z^{-1})$。$\det$ は転置で不変なので $D(z)=\det L(z^{-1})=D(z^{-1})$。∎

**定義 1.8（content）.** $0\neq F=\sum_{k}c_kz^k\in\mathbb{Z}[z,z^{-1}]$ に対し
$\mathrm{content}_z(F):=\gcd_k c_k\in\mathbb{Z}_{>0}$。$F=0$ のときは定義しない。

---

## 2. 予備補題 1：Kirchhoff の matrix-tree 定理（適用条件を確認して使う）

**定理 2.1（Kirchhoff の matrix-tree 定理）.**
$Y$ を頂点数 $n\ge1$ の有限多重グラフ、$\Delta_Y$ をそのラプラシアン（定義 1.2）とする。
各 $i$ に対し $\Delta_Y^{(i)}$ を $\Delta_Y$ から第 $i$ 行と第 $i$ 列を除いた $(n-1)\times(n-1)$ 行列とすると、
$$\det \Delta_Y^{(i)} = \kappa(Y)\qquad (i=1,\dots,n).$$
（$n=1$ のときは空行列の行列式 $=1=\kappa(Y)$ と読む。）

**適用条件の確認.** この定理は「有限多重グラフ（ループ・多重辺を許す）」に対して成立する。
根拠: ループは $\Delta_Y$ に寄与せず、かつどの全域木にも含まれないので、
ループを除去しても両辺は変わらない。多重辺は Cauchy–Binet による標準証明がそのまま通る
（接続行列の列を辺ごとに立てるだけで、重複列があっても構わない）。
連結性は**不要**である（非連結なら両辺 0；$\Delta_Y$ の階数が $n-2$ 以下になるので左辺 0、
全域木は存在しないので右辺 0）。
文献での多重グラフ版の明示: Hammer–Mattman–Sands–Vallières, *The special value $u=1$ of
Artin–Ihara $L$-functions*, Theorem 2.5（$\mathrm{adj}(Q)=\kappa_X\cdot J$、連結多重グラフに対して）。
本稿では非連結の場合も使うので、上の注意により補う。

**補題 2.2（Kirchhoff の微分形）.**
$Y$ を頂点数 $n\ge1$ の有限多重グラフ、$\psi_Y(t):=\det(tI_n-\Delta_Y)\in\mathbb{Z}[t]$ とすると
$$\psi_Y'(0) = (-1)^{n-1}\,n\,\kappa(Y).$$

*証明.* まず一般の $A\in M_n(R)$（$R$ 可換環）について、$\det(tI-A)$ の $t^1$ の係数を求める。
$tI-A$ の第 $j$ 列は $t\mathbf e_j - \mathbf a_j$（$\mathbf a_j$ は $A$ の第 $j$ 列）である。
行列式の列に関する多重線型性で展開すると
$$\det(tI-A)=\sum_{S\subseteq\{1,\dots,n\}}\det\bigl(B_S\bigr),$$
ここで $B_S$ は第 $j$ 列が $j\in S$ のとき $t\mathbf e_j$、$j\notin S$ のとき $-\mathbf a_j$ の行列。
$j\in S$ の列は $t\mathbf e_j$ なので、それらの列に沿って余因子展開すると
$$\det B_S = t^{|S|}\cdot\det\bigl((-A)_{S^c,S^c}\bigr)=t^{|S|}(-1)^{n-|S|}\det\bigl(A_{S^c,S^c}\bigr),$$
ここで $A_{S^c,S^c}$ は $S^c$ の行・列からなる主小行列。
$t^1$ の係数は $|S|=1$、すなわち $S=\{i\}$ の項の和であり
$$[t^1]\det(tI-A)=(-1)^{n-1}\sum_{i=1}^n\det\bigl(A^{(i)}\bigr).$$
$A=\Delta_Y$ とし、定理 2.1 を各 $i$ に適用すると $\sum_i\det\Delta_Y^{(i)}=n\kappa(Y)$。
$\psi_Y'(0)=[t^1]\psi_Y(t)$ だから主張を得る。
（$n=1$: $\psi_Y(t)=t$、$\psi_Y'(0)=1=(-1)^0\cdot1\cdot1$ ✓。）∎

**注意 2.3.** 補題 2.2 は $Y$ の連結性を仮定していない。非連結なら右辺は 0 であり、
実際 $\Delta_Y$ は固有値 0 を重複度 $\ge2$ で持つので $\psi_Y(t)$ は $t^2$ で割れ $\psi_Y'(0)=0$。整合する。

---

## 3. $(★)$ の証明

### 3.1 ブロック巡回構造

**補題 3.1.** $L(z)=\sum_{k\in\mathbb{Z}}A_kz^k$（$A_k\in M_m(\mathbb{Z})$、有限和）と書く。
$N\ge1$ に対し $M_k:=\sum_{k'\equiv k\ (N)}A_{k'}\in M_m(\mathbb{Z})$（$k\in\mathbb{Z}/N$）とおくと、
$X_N$ のラプラシアンは
$$(\Delta_{X_N})_{(u,i),(v,j)} = (M_{j-i})_{uv}\qquad (u,v\in V,\ i,j\in\mathbb{Z}/N)$$
を満たす。

*証明.* 辺ごとに両辺の寄与を照合する。

(a) 非ループ辺 $e=(u,v,a)$, $u\neq v$。$X_N$ での寄与は $N$ 本の辺 $\{(u,i),(v,\overline{i+a})\}$。
これらは $u\ne v$ より $X_N$ でも非ループ辺である。定義 1.2 より $\Delta_{X_N}$ への寄与は、
各 $i$ について 対角に $+1$（$(u,i)$）と $+1$（$(v,\overline{i+a})$）、
非対角に $-1$（$((u,i),(v,\overline{i+a}))$ と対称位置）。
これを $(M_k)$ の言葉に直すと、$M_0$ に $E_{uu}+E_{vv}$、$M_{\bar a}$ に $-E_{uv}$、
$M_{-\bar a}$ に $-E_{vu}$（$E_{uv}$ は行列単位）。
一方 $L(z)$ 側の寄与は $A_0\ni E_{uu}+E_{vv}$, $A_a\ni-E_{uv}$, $A_{-a}\ni-E_{vu}$ で、
$M_k=\sum_{k'\equiv k}A_{k'}$ に集約すると一致する。
（$\bar a=-\bar a$、すなわち $2a\equiv0\bmod N$ かつ $a\not\equiv0$ の場合、
$M_{\bar a}$ には $-E_{uv}-E_{vu}$ が入る。$X_N$ 側でも $(v,\overline{i+a})=(v,\overline{i-a})$ なので
非対角成分に $-1$ が 2 回入り、一致する。）

(b) ループ $e=(u,u,a)$。$X_N$ での持ち上げは $N$ 本の辺 $\{(u,i),(u,\overline{i+a})\}$。
- $a\equiv0\bmod N$ のとき、これらは $X_N$ でもループなので $\Delta_{X_N}$ に寄与しない。
  $L$ 側は $M_0$ への寄与 $\sum_{k'\equiv0}(A_{k'})_{uu}=2-1-1=0$（$a\equiv-a\equiv0$）。一致。
- $a\not\equiv0\bmod N$ のとき、頂点 $(u,j)$ は $i=j$ の辺と $i=j-a$ の辺の 2 本に接続するので
  対角に $+2$。非対角は $((u,j),(u,\overline{j+a}))$ に $-1$、$((u,j),(u,\overline{j-a}))$ に $-1$。
  $L$ 側は $M_0\ni 2E_{uu}$, $M_{\bar a}\ni -E_{uu}$, $M_{-\bar a}\ni -E_{uu}$。一致
  （$2a\equiv0$ のときは $M_{\bar a}$ に $-2E_{uu}$ が入り、$X_N$ 側でも
  $(u,\overline{j+a})=(u,\overline{j-a})$ で $-1$ が 2 回入る。一致）。

全辺の寄与を足せば主張を得る。∎

### 3.2 離散 Fourier 対角化

$N\ge1$ を固定し、$\zeta_N\in\overline{\mathbb{Q}}$ を 1 の原始 $N$ 乗根、
$K:=\mathbb{Q}(\zeta_N)$、$\mu_N:=\{\zeta\in K:\zeta^N=1\}$ とおく。

**適用条件の確認**: $K$ は標数 0 なので $z^N-1$ は $K[z]$ で重根を持たず
（$\gcd(z^N-1,Nz^{N-1})=1$、$N\in K^\times$）、$\mu_N$ はちょうど $N$ 個の相異なる元からなる。

**補題 3.2.** $Q\in M_{mN}(K)$ を、行を $(u,i)\in V\times\mathbb{Z}/N$、列を $(w,\zeta)\in V\times\mu_N$ で
添字づけて $Q_{(u,i),(w,\zeta)}:=\delta_{uw}\,\zeta^{i}$ と定める。このとき $Q$ は可逆であり
$$Q^{-1}\,\Delta_{X_N}\,Q = \bigoplus_{\zeta\in\mu_N}L(\zeta),$$
すなわち $\Delta_{X_N}$ は $K$ 上 $\bigoplus_{\zeta\in\mu_N}L(\zeta)$ に相似である。

*証明.* まず $Q$ の可逆性。適当に行・列を並べ替えると $Q=F\otimes I_m$ で、
$F_{i,\zeta}=\zeta^i$（$i=0,\dots,N-1$, $\zeta\in\mu_N$）は Vandermonde 行列である。
$\mu_N$ の元を $\zeta_1,\dots,\zeta_N$ と番号づけると
$\det F=\prod_{1\le i<j\le N}(\zeta_j-\zeta_i)$ で、$\mu_N$ の元は相異なるのでこれは $\neq0$。
よって $\det Q=(\det F)^m\neq0$ で $Q\in GL_{mN}(K)$。

次に $\Delta_{X_N}Q = Q\bigl(\bigoplus_\zeta L(\zeta)\bigr)$ を成分で確かめる。補題 3.1 より
$$(\Delta_{X_N}Q)_{(u,i),(w,\zeta)}=\sum_{v\in V}\sum_{j\in\mathbb{Z}/N}(M_{j-i})_{uv}\,\delta_{vw}\zeta^{j}
=\sum_{j\in\mathbb{Z}/N}(M_{j-i})_{uw}\zeta^{j}
=\zeta^{i}\sum_{k\in\mathbb{Z}/N}(M_{k})_{uw}\zeta^{k}.$$
ここで $\zeta^N=1$ より
$\sum_{k\in\mathbb{Z}/N}M_k\zeta^k=\sum_{k\in\mathbb{Z}/N}\sum_{k'\equiv k}A_{k'}\zeta^{k'}=\sum_{k'\in\mathbb{Z}}A_{k'}\zeta^{k'}=L(\zeta)$
（$\zeta\in\mu_N\subseteq K^\times$ なので負冪も定義される）。よって
$(\Delta_{X_N}Q)_{(u,i),(w,\zeta)}=\zeta^i L(\zeta)_{uw}$。
他方、$\bigoplus_\zeta L(\zeta)$ は $\mu_N$ でブロック対角なので
$$\Bigl(Q\bigoplus_\xi L(\xi)\Bigr)_{(u,i),(w,\zeta)}=\sum_{v,\xi}\delta_{uv}\xi^{i}\cdot\bigl[\xi=\zeta\bigr]L(\zeta)_{vw}=\zeta^{i}L(\zeta)_{uw}.$$
両者は一致する。∎

**系 3.3.** $\displaystyle\det(tI_{mN}-\Delta_{X_N})=\prod_{\zeta\in\mu_N}\det\bigl(tI_m-L(\zeta)\bigr)$（$K[t]$ の等式）。

### 3.3 公式 $(★)$

**定理 3.4（$(★)$、退化ケース込み）.**
$X$ を任意の有限多重グラフ（頂点数 $m\ge1$、ループ・多重辺可、連結性を仮定しない）、
$\alpha$ を任意の voltage 割り当て、$N\ge1$ を任意とする。このとき
$$\boxed{\;N\cdot\kappa(X_N)\;=\;\kappa(X)\prod_{\zeta\in\mu_N\setminus\{1\}}\det L(\zeta)\;}\tag{★}$$
が $\mathbb{Z}$ の等式として成り立つ。とくに $\kappa(X)\neq0$（$X$ 連結）のとき
$\kappa(X_N)=\dfrac{\kappa(X)}{N}\prod_{\zeta\neq1}\det L(\zeta)$。

*証明.* $\chi_\zeta(t):=\det(tI_m-L(\zeta))\in K[t]$、$\Psi(t):=\prod_{\zeta\in\mu_N}\chi_\zeta(t)$ とおく。
系 3.3 より $\Psi(t)=\det(tI_{mN}-\Delta_{X_N})=\psi_{X_N}(t)$。

補題 2.2 を $Y=X_N$（頂点数 $mN$）に適用すると
$$\Psi'(0)=\psi_{X_N}'(0)=(-1)^{mN-1}\,mN\,\kappa(X_N).\tag{3.1}$$

他方、積の微分則より
$$\Psi'(0)=\sum_{\xi\in\mu_N}\chi_\xi'(0)\prod_{\zeta\in\mu_N,\ \zeta\neq\xi}\chi_\zeta(0).\tag{3.2}$$
ここで $\chi_\zeta(0)=\det(-L(\zeta))=(-1)^m\det L(\zeta)=(-1)^mD(\zeta)$。
とくに $\zeta=1$ では補題 1.6 より $\chi_1(0)=(-1)^mD(1)=0$。
また $L(1)=\Delta_X$ なので $\chi_1(t)=\psi_X(t)$ であり、補題 2.2 を $Y=X$ に適用して
$\chi_1'(0)=(-1)^{m-1}m\,\kappa(X)$。

$(3.2)$ の各項を評価する。

- **場合 (i): ある $\zeta_0\in\mu_N\setminus\{1\}$ で $D(\zeta_0)=0$。**
  このとき $\chi_1(0)=\chi_{\zeta_0}(0)=0$ で、$1\neq\zeta_0$ は $\mu_N$ の相異なる 2 元。
  $(3.2)$ の各項 $\xi$ について、$\xi$ は $1$ と $\zeta_0$ の高々一方にしか等しくないので、
  積 $\prod_{\zeta\neq\xi}\chi_\zeta(0)$ は $\chi_1(0)$ か $\chi_{\zeta_0}(0)$ の少なくとも一方を因子に含み、
  したがって 0。ゆえに $\Psi'(0)=0$、$(3.1)$ より $\kappa(X_N)=0$。
  右辺も $\prod_{\zeta\neq1}D(\zeta)=0$ なので $(★)$ は $0=0$ で成立。
- **場合 (ii): 全ての $\zeta\in\mu_N\setminus\{1\}$ で $D(\zeta)\neq0$。**
  このとき $\chi_\zeta(0)\neq0$（$\zeta\neq1$）で、$\chi_1(0)=0$ だから、
  $(3.2)$ で $\xi\neq1$ の項はすべて因子 $\chi_1(0)=0$ を含み消える。残るのは $\xi=1$ の項のみ:
  $$\Psi'(0)=\chi_1'(0)\prod_{\zeta\neq1}\chi_\zeta(0)
  =(-1)^{m-1}m\,\kappa(X)\cdot\bigl((-1)^m\bigr)^{N-1}\prod_{\zeta\neq1}D(\zeta).$$
  $(3.1)$ と等置して
  $$(-1)^{mN-1}mN\kappa(X_N)=(-1)^{m-1+m(N-1)}m\,\kappa(X)\prod_{\zeta\neq1}D(\zeta).$$
  符号は $m-1+m(N-1)=mN-1$ なので両辺で一致し、$m\ (\ge1)$ で割って
  $N\kappa(X_N)=\kappa(X)\prod_{\zeta\neq1}D(\zeta)$。

いずれの場合も $(★)$ が成立する。∎

**注意 3.5（$X$ が非連結の場合）.** 上の証明は $X$ の連結性を使っていない。
$X$ が非連結なら $\kappa(X)=0$ で右辺 0、また $X_N$ も非連結（射影 $X_N\to X$ が全射）なので左辺 0。
実際、この場合 $\psi_X(t)$ は $t^2$ で割れるので $\chi_1(0)=\chi_1'(0)=0$ となり、
$(3.2)$ の全項が消えることからも直接従う。

**注意 3.6（右辺は有理整数）.** $D(z)=z^{-M}P(z)$（$P\in\mathbb{Z}[z]$, $P(0)\neq0$）と書くと、
$q_N(z):=(z^N-1)/(z-1)\in\mathbb{Z}[z]$ は monic で、その根の集合が $\mu_N\setminus\{1\}$ だから
$$\prod_{\zeta\neq1}P(\zeta)=\mathrm{Res}(q_N,P)\in\mathbb{Z},\qquad
\prod_{\zeta\neq1}\zeta = (-1)^{N+1},$$
（後者は $\prod_{\zeta\in\mu_N}\zeta=(-1)^{N+1}$ から従う）ゆえに
$\prod_{\zeta\neq1}D(\zeta)=(-1)^{M(N+1)}\mathrm{Res}(q_N,P)\in\mathbb{Z}$。
したがって $(★)$ の右辺は**どの代数閉包で計算しても同じ有理整数**であり、
後で $\overline{\mathbb{Q}_\ell}$ に埋め込んで $\ell$ 進付値を取るときに曖昧さは生じない。
（この式が数値検証 `verify_star.sage` の右辺の計算法であり、浮動小数点を使わない。）

---

## 4. 連結性の判定（退化ケースの完全な場合分け）

**定義 4.1（voltage 指数）.** $X$ を**連結**とする。全域木 $T\subseteq E$ を 1 つ取り、
$\phi:V\to\mathbb{Z}$ を $\phi(v_0)=0$（$v_0$ は根）と、木の辺 $(u,v,a)\in T$ に対する
$\phi(v)=\phi(u)+a$ で定める（木なので一意に定まる）。非木辺 $e=(u,v,a)\notin T$ に対し
$$\alpha(C_e):=\phi(u)+a-\phi(v)\in\mathbb{Z}$$
（$e$ が定める基本サイクルの voltage）とおき、
$$\Gamma:=\langle \alpha(C_e) : e\in E\setminus T\rangle \le \mathbb{Z},\qquad \Gamma=d\mathbb{Z}\ (d\ge0)$$
と定める。$d$ を $X$ の **voltage 指数**と呼ぶ。

**補題 4.2（$d$ の well-defined 性）.** $d$ は全域木 $T$ と根 $v_0$ の取り方に依らない。

*証明.* $\Gamma$ は「$X$ のサイクル空間 $H_1(X,\mathbb{Z})$ の元 $C$ に対する $\alpha(C)$ の全体」に等しい。
実際、$\{C_e\}_{e\notin T}$ は $H_1(X,\mathbb{Z})$ の $\mathbb{Z}$ 基底であり（標準事実：
連結グラフの全域木の非木辺は基本サイクル基底を与える）、$C\mapsto\alpha(C)$ は
$H_1(X,\mathbb{Z})\to\mathbb{Z}$ の群準同型（$\alpha$ を辺の 1-コチェインとみて評価するだけ）だから、
その像は基底の像で生成される。像は $T$ にも $v_0$ にも依らない。∎

**命題 4.3（連結性の完全な判定）.** $X$ を連結、$d$ を voltage 指数とする。任意の $N\ge1$ に対し
1. $X_N$ の連結成分の個数は $\gcd(d,N)$ である（$d=0$ のときは $\gcd(0,N)=N$ と読む）。
2. $X_N$ が連結 $\iff$ $\gcd(d,N)=1$ $\iff$ 全ての $\zeta\in\mu_N\setminus\{1\}$ で $D(\zeta)\neq0$。

*証明.* **(1)** まず **switching** で正規化する。$\psi:V\to\mathbb{Z}$ を任意に取り、
$\alpha'(u,v,a):=a+\psi(u)-\psi(v)$ とおくと、写像
$$\Theta:(u,i)\mapsto (u,\ \overline{i-\psi(u)})$$
は $X_N$（voltage $\alpha$）から $X_N$（voltage $\alpha'$）へのグラフ同型である。実際、
$\alpha$ の辺 $\{(u,i),(v,\overline{i+a})\}$ は $\Theta$ で
$\{(u,\overline{i-\psi(u)}),(v,\overline{i+a-\psi(v)})\}$ に写り、
$i':=\overline{i-\psi(u)}$ とおくと $\overline{i+a-\psi(v)}=\overline{i'+(a+\psi(u)-\psi(v))}=\overline{i'+\alpha'(e)}$
なので、これは $\alpha'$ の辺の 1 本。逆写像も同型を与える（$\Theta$ は頂点上の全単射で辺を辺に双射する）。

$\psi:=\phi$（定義 4.1 の $\phi$）と取ると、木の辺 $(u,v,a)\in T$ では
$\alpha'=a+\phi(u)-\phi(v)=0$、非木辺 $e$ では $\alpha'(e)=\alpha(C_e)\in\Gamma$。
よって一般性を失わず **$T$ 上の voltage は 0、非木辺の voltage は $\Gamma=d\mathbb{Z}$ に属する**としてよい。

この状況で写像 $\pi: V\times\mathbb{Z}/N\to (\mathbb{Z}/N)\big/\overline{\Gamma}$,
$(u,i)\mapsto i+\overline\Gamma$（$\overline\Gamma$ は $\Gamma$ の $\mathbb{Z}/N$ での像）を考える。
すべての辺の voltage が $\Gamma$ に属する（木の辺は 0、非木辺は $\Gamma$）ので、
辺の両端の $\pi$ 値は等しい。ゆえに $\pi$ は $X_N$ の各連結成分上で定数であり、
連結成分の個数 $\ge |(\mathbb{Z}/N)/\overline\Gamma|$。

逆に、$\pi$ の同じ値を持つ 2 頂点が連結であることを示す。木の辺 voltage が 0 なので、
各 $i$ に対し $\{(v,i):v\in V\}$ は木の持ち上げで連結（$T$ が $V$ を張る木だから）。
また非木辺 $e=(u,v,a')$（$a'\in\Gamma$）は $(u,i)$ と $(v,\overline{i+a'})$ を結ぶので、
$(u,i)$ と $(u,\overline{i+a'})$ は（木の連結性を経由して）連結。
$\Gamma$ は $\{\alpha(C_e)\}$ で生成されるから、$(u,i)$ と $(u,\overline{i+g})$ は全ての $g\in\overline\Gamma$ で連結。
よって連結成分はちょうど $\pi$ のファイバーであり、個数は
$$\bigl|(\mathbb{Z}/N)/\overline{d\mathbb{Z}}\bigr| = \bigl|\mathbb{Z}/(dN\mathbb{Z}+N\mathbb{Z})\cdots\bigr| = \gcd(d,N).$$
（最後の等号: $\overline{d\mathbb{Z}}=(d\mathbb{Z}+N\mathbb{Z})/N\mathbb{Z}=\gcd(d,N)\mathbb{Z}/N\mathbb{Z}$ なので
指数は $\gcd(d,N)$。$d=0$ なら $\overline\Gamma=0$ で指数 $N$。）

**(2)** 第 1 の同値は (1) から直ちに従う。第 2 の同値を示す。
$X$ は連結なので $\kappa(X)\ge1$。定理 3.4 の証明の場合分けを見ると、
- 場合 (ii)（全ての $\zeta\neq1$ で $D(\zeta)\neq0$）では
  $\Psi'(0)=\chi_1'(0)\prod_{\zeta\neq1}\chi_\zeta(0)\neq0$（$\chi_1'(0)=(-1)^{m-1}m\kappa(X)\neq0$）。
  $(3.1)$ より $\kappa(X_N)\neq0$、すなわち $X_N$ は連結。
- 場合 (i)（ある $\zeta_0\neq1$ で $D(\zeta_0)=0$）では $\kappa(X_N)=0$、すなわち $X_N$ は非連結。

よって「$X_N$ 連結 $\iff$ 全ての $\zeta\in\mu_N\setminus\{1\}$ で $D(\zeta)\neq0$」。∎

**系 4.4（退化ケースの一覧）.** $X$ を連結、$\ell$ を素数とする。塔
$X=X_1\leftarrow X_\ell\leftarrow X_{\ell^2}\leftarrow\cdots$ について次が同値。

(a) すべての $n\ge0$ で $X_{\ell^n}$ が連結。
(b) $\ell\nmid d$。
(c) すべての $\zeta\in\mu_{\ell^\infty}\setminus\{1\}$ で $D(\zeta)\neq0$
    （$\mu_{\ell^\infty}=\bigcup_n\mu_{\ell^n}$）。

$\ell\mid d$ のときは全ての $n\ge1$ で $\kappa_n=0$ となり $\mathrm{ord}_\ell(\kappa_n)$ は定義されない
（塔として意味をなさない）。とくに $d=0$ のときは $L(z)$ が $\Delta_X$ に相似（下の補題 4.5）で
$D\equiv0$ となり、$X_N$ は $X$ の $N$ 個のコピーの直和になる。

*証明.* (a)$\iff$(b): 命題 4.3 (1) より $X_{\ell^n}$ 連結 $\iff\gcd(d,\ell^n)=1$。
これが全 $n$ で成り立つのは $\ell\nmid d$ のとき、かつそのときに限る。
(a)$\iff$(c): 命題 4.3 (2) を各 $N=\ell^n$ に適用し、$n$ について合わせる。∎

**補題 4.5（$d=0$ の構造）.** $X$ 連結で $d=0$ ならば、ある $\phi:V\to\mathbb{Z}$ と
$S(z)=\mathrm{diag}(z^{\phi(u)})_{u\in V}$ が存在して $L(z)=S(z)^{-1}\Delta_X S(z)$、
とくに $D(z)=\det\Delta_X=0$（恒等的に）。

*証明.* $d=0$ とは全ての基本サイクル voltage が 0、すなわち補題 4.2 の準同型
$H_1(X,\mathbb{Z})\to\mathbb{Z}$ が 0 写像であること。定義 4.1 の $\phi$ を取ると、
木の辺では $a=\phi(v)-\phi(u)$（定義から）、非木辺でも $\alpha(C_e)=\phi(u)+a-\phi(v)=0$ より
$a=\phi(v)-\phi(u)$。よって**全ての辺**で $a=\phi(v)-\phi(u)$。
このとき非ループ辺 $(u,v,a)$ の $L$ への寄与は
$L_{uv}\mathrel{-}=z^{\phi(v)-\phi(u)}$, $L_{vu}\mathrel{-}=z^{\phi(u)-\phi(v)}$, 対角に $+1,+1$。
これは $(S^{-1}\Delta_X S)_{uv}=z^{-\phi(u)}(\Delta_X)_{uv}z^{\phi(v)}$ の形と一致する。
ループは $a=\phi(u)-\phi(u)=0$ なので寄与 $2-1-1=0$ で、$\Delta_X$ 側の寄与 0 と一致。
ゆえに $L(z)=S(z)^{-1}\Delta_XS(z)$、$D(z)=\det\Delta_X=0$。∎

---

## 5. Iwasawa 代数と content 補題

以下 $\ell$ を素数、$\mathbb{Z}_\ell$ を $\ell$ 進整数環、$\Lambda:=\mathbb{Z}_\ell[[T]]$ とする。
$v_\ell$ は $v_\ell(\ell)=1$ と正規化した付値で、$\overline{\mathbb{Q}_\ell}$ 上へ一意に延長する
（$\mathbb{Q}_\ell$ の各有限拡大は完備離散付値体で、付値の延長は一意。標準事実）。

**定理 5.1（Weierstrass 準備定理）.**
$0\neq f\in\Lambda$ とする。このとき一意的に
$$f = \ell^{\mu}\cdot g(T)\cdot U(T)$$
と書ける。ここで $\mu\in\mathbb{Z}_{\ge0}$、$g\in\mathbb{Z}_\ell[T]$ は **distinguished**
（monic かつ最高次以外の係数が $\ell\mathbb{Z}_\ell$ に属する）、$U\in\Lambda^\times$。
$\lambda:=\deg g$ とおく。

**適用条件の確認**: $\Lambda=\mathbb{Z}_\ell[[T]]$ は完備局所環（極大イデアル $(\ell,T)$）であり、
必要な仮定は「$f\neq0$」のみ。本稿で適用する $f$ については毎回 $f\neq0$ を確認する。
文献: Washington, *Introduction to Cyclotomic Fields*, 2nd ed., Theorem 7.3。

**補題 5.2（$\mu,\lambda$ の係数による特徴づけ）.**
$f=\sum_{k\ge0}a_kT^k\in\Lambda$, $f\neq0$ に対し、定理 5.1 の $\mu,\lambda$ は
$$\mu=\min_{k}v_\ell(a_k),\qquad \lambda=\min\{k : v_\ell(a_k)=\mu\}.$$
とくに $U\in\Lambda^\times$ に対し $\mu(Uf)=\mu(f)$, $\lambda(Uf)=\lambda(f)$。

*証明.* $\mu(f):=\min_k v_\ell(a_k)$ は「$\ell^j\mid f$ を満たす最大の $j$」に等しい
（$\ell^j\mid f\iff$ 全 $k$ で $\ell^j\mid a_k$）。単元倍は割り切れ関係を保つので
$\mu(Uf)=\mu(f)$。定理 5.1 の分解で $\mu(g)=0$（$g$ は monic なので最高次係数が単元）だから
$\mu(f)=\mu(\ell^\mu)+\mu(gU)=\mu$。
$\lambda$ について: $f/\ell^{\mu}=gU$ の係数を $b_k$ とすると、$\min_k v_\ell(b_k)=0$。
$\Lambda/\ell\Lambda\cong\mathbb{F}_\ell[[T]]$ で $\overline{gU}=\overline g\,\overline U$、
$\overline g=T^{\lambda}$（$g$ distinguished なので低次係数は $\ell$ で割れる、最高次は 1）、
$\overline U$ は $\mathbb{F}_\ell[[T]]^\times$（定数項が単元）。
よって $\overline{gU}=T^\lambda\cdot(\text{単元})$ の最低次数は $\lambda$、
すなわち $\min\{k:\ell\nmid b_k\}=\lambda$。これは $\min\{k:v_\ell(a_k)=\mu\}=\lambda$ と同値。∎

**補題 5.3（content 保存）.** $0\neq D\in\mathbb{Z}[z,z^{-1}]$ とし、$D(z)=z^{-M}P(z)$
（$M\in\mathbb{Z}_{\ge0}$, $P\in\mathbb{Z}[z]$, $P(0)\neq0$）と書く。$f(T):=D(1+T)$ とおくと
$f\in\Lambda$（$f\neq0$）であり、
$$\mu(f)=v_\ell\bigl(\mathrm{content}_z(D)\bigr).$$

*証明.* まず $f\in\Lambda$ であること: $1+T\in\Lambda^\times$（定数項 $1\in\mathbb{Z}_\ell^\times$）なので
$(1+T)^{-M}\in\Lambda^\times$ が定義され、$f(T)=(1+T)^{-M}P(1+T)\in\Lambda$。
$P(1+T)\neq0$（$T\mapsto z-1$ が逆写像なので $P\neq0$ から従う）なので $f\neq0$。

補題 5.2 より $\mu(f)=\mu\bigl(P(1+T)\bigr)$（単元 $(1+T)^{-M}$ 倍は $\mu$ を変えない）。
$P(1+T)\in\mathbb{Z}[T]$ は有限次多項式なので、$\mu(P(1+T))=v_\ell(\mathrm{content}_T(P(1+T)))$。

残るは $\mathrm{content}_T(P(1+T))=\mathrm{content}_z(P(z))$。
$\sigma:\mathbb{Z}[z]\to\mathbb{Z}[T]$, $z\mapsto 1+T$ は $\mathbb{Z}$ 代数の同型で、
逆は $\tau:T\mapsto z-1$。$c:=\mathrm{content}_z(P)$ とおくと $P=cP_0$（$P_0\in\mathbb{Z}[z]$）だから
$\sigma(P)=c\,\sigma(P_0)$ で $\sigma(P_0)\in\mathbb{Z}[T]$、よって
$c\mid\mathrm{content}_T(\sigma P)$。同じ議論を $\tau$ と $\sigma P$ に適用して
$\mathrm{content}_T(\sigma P)\mid\mathrm{content}_z(\tau\sigma P)=\mathrm{content}_z(P)=c$。
両者は正なので一致する。

最後に $\mathrm{content}_z(D)=\mathrm{content}_z(P)$（$z^{-M}$ 倍は Laurent 係数の集合を平行移動するだけ）。∎

**補題 5.4（$\mathbb{Z}[z,z^{-1}]$ 側の記述）.** $D\ne0$ のとき、$f=D(1+T)$ の $T$ 進位数
$r:=\min\{k:a_k\neq0\}$ は、$D$ の $z=1$ における零点の位数に等しく、$r\ge1$。

*証明.* $f(T)=D(1+T)$ の $T=0$ での零点位数は、$D(z)$ の $z=1$ での零点位数そのもの
（$\mathbb{Q}$ 上の有理関数として $z=1+T$ は解析的同型、あるいは $P(1+T)$ の $T$ 進位数 $=P$ の $(z-1)$ 進位数）。
補題 1.6 より $D(1)=0$ なので $r\ge1$。∎

---

## 6. 主定理：岩澤型漸近と $(☆)$ の証明

まず $\ell$ 進成長の中核補題を証明する。これは Iwasawa の類数公式の証明に使われる標準補題だが、
**本稿では既知理論に依拠せず完全に証明する**（これが「$\mathrm{ord}_\ell(\kappa_n)$ が岩澤型漸近を
もつこと自体を自分で示す」という要求への回答である）。

**補題 6.0（$\ell$ 進主単数の冪の付値）.**
$\beta\in\overline{\mathbb{Q}_\ell}$、$w_0:=v_\ell(\beta)$ が $0<w_0<\infty$ を満たすとする。
$\eta:=1+\beta$、$w_n:=v_\ell(\eta^{\ell^n}-1)$ とおく。このとき $(w_n)_{n\ge0}$ は
狭義単調増加で、ある $n_0\ge0$ と定数 $c_\beta\in\mathbb{Q}$ が存在して
$$w_n = n + c_\beta\qquad (n\ge n_0).$$

*証明.* $w_0=v_\ell(\beta)\in(0,\infty)$。帰納的に、$y:=\eta^{\ell^n}-1$（$v_\ell(y)=w_n>0$）に対し
$$\eta^{\ell^{n+1}}-1=(1+y)^{\ell}-1=\sum_{j=1}^{\ell}\binom{\ell}{j}y^{j}.$$
各項の付値は、$1\le j\le \ell-1$ で $v_\ell\binom{\ell}{j}=1$ なので $1+jw_n$、$j=\ell$ で $\ell w_n$。
- $1\le j\le\ell-1$ の中では $j=1$ が最小で $1+w_n$。
- $j=\ell$ の項 $\ell w_n$ と $1+w_n$ の比較: $\ell w_n>1+w_n\iff w_n>\frac1{\ell-1}$。

したがって
1. $w_n<\frac1{\ell-1}$ のとき、最小値は $j=\ell$ の項のみで**一意に**達成されるので
   $w_{n+1}=\ell w_n$。$w_n>0$ より $w_{n+1}>w_n$。
2. $w_n>\frac1{\ell-1}$ のとき、最小値は $j=1$ の項のみで一意に達成されるので
   $w_{n+1}=1+w_n>w_n$。
3. $w_n=\frac1{\ell-1}$ のとき、$j=1$ と $j=\ell$ の項が同じ付値 $1+w_n$ を持つので
   $w_{n+1}\ge 1+w_n>w_n$（等号でない可能性があるが下界で十分）。
   いずれにせよ $w_{n+1}>\frac1{\ell-1}$。

（付値の超距離不等式: 最小付値が一意に達成されるなら和の付値はその最小値に等しい。標準事実。）

場合 1 では $w_{n+1}=\ell w_n$ なので、$w$ が $\frac1{\ell-1}$ 未満に留まり続けることはできない
（$w_0>0$ から $\ell$ 倍が繰り返され有限回で超える）。よってある最小の $n_0$ で
$w_{n_0}>\frac1{\ell-1}$ となり、以後は場合 2 が適用されて $w_{n+1}=w_n+1$（$n\ge n_0$）。
$c_\beta:=w_{n_0}-n_0$ とおけば $w_n=n+c_\beta$（$n\ge n_0$）。∎

**補題 6.0'（1 の $\ell$ 冪根の性質）.** $\zeta\in\mu_{\ell^n}$ に対し $v_\ell(\zeta-1)>0$
（$\zeta=1$ のときは $+\infty$）。また
$$\prod_{\zeta\in\mu_{\ell^n}\setminus\{1\}}(\zeta-1)=(-1)^{\ell^n-1}\ell^n,\qquad
v_\ell\Bigl(\prod_{\zeta\neq1}(\zeta-1)\Bigr)=n.$$

*証明.* $\frac{z^{\ell^n}-1}{z-1}=\prod_{\zeta\in\mu_{\ell^n}\setminus\{1\}}(z-\zeta)$（両辺 monic で根が一致）。
$z=1$ を代入すると左辺は $\ell^n$（$\frac{z^{\ell^n}-1}{z-1}=1+z+\cdots+z^{\ell^n-1}$ に $z=1$）、
右辺は $\prod_{\zeta\neq1}(1-\zeta)=(-1)^{\ell^n-1}\prod_{\zeta\neq1}(\zeta-1)$。よって等式を得る。
付値を取れば $\sum_{\zeta\neq1}v_\ell(\zeta-1)=n$。各項は $\ge0$（$\zeta$ は $\overline{\mathbb{Z}_\ell}$ の元
で $\zeta-1$ も整）かつ和が有限なので、各 $v_\ell(\zeta-1)$ は有限。
正であることは: $\zeta\neq1$ が原始 $\ell^k$ 乗根なら $\Phi_{\ell^k}(1)=\ell$ と
$\Phi_{\ell^k}(z)=\prod(z-\zeta')$（$\zeta'$ は原始 $\ell^k$ 乗根、個数 $\varphi(\ell^k)$）から
$v_\ell(\zeta-1)=\frac{1}{\varphi(\ell^k)}=\frac{1}{\ell^{k-1}(\ell-1)}>0$
（$\mathbb{Q}_\ell(\zeta)/\mathbb{Q}_\ell$ は完全分岐でガロア共役はすべて同じ付値を持つ）。∎

**補題 6.0''（Iwasawa の成長補題）.**
$0\neq f\in\Lambda$ とし、$\mu=\mu(f)$, $\lambda=\lambda(f)$ を Weierstrass 不変量とする。
さらに**全ての $\zeta\in\mu_{\ell^\infty}$ で $f(\zeta-1)\neq0$** と仮定する。このとき
$$\Pi_n:=\prod_{\zeta\in\mu_{\ell^n}}f(\zeta-1)$$
は $\overline{\mathbb{Q}_\ell}$ の 0 でない元であり、ある $n_1\ge0$ と $c\in\mathbb{Q}$ が存在して
$$v_\ell(\Pi_n)=\mu\,\ell^{n}+\lambda\,n+c\qquad(n\ge n_1).$$

*証明.* 定理 5.1 で $f=\ell^\mu g U$（$g$ distinguished, $\deg g=\lambda$, $U\in\Lambda^\times$）と書く。
$\zeta\in\mu_{\ell^n}$ に対し $x:=\zeta-1$ は $v_\ell(x)>0$（補題 6.0'）または $x=0$（$\zeta=1$）。
$\Lambda$ の元は $\mathbb{Z}_\ell$ 係数（有界）なので $v_\ell(x)>0$ で収束し、代入が定義される。

**(a) 単元部分.** $U=\sum u_kT^k$、$u_0\in\mathbb{Z}_\ell^\times$。$v_\ell(x)>0$ なら
$v_\ell(U(x)-u_0)\ge v_\ell(x)>0$ なので $v_\ell(U(x))=v_\ell(u_0)=0$。$x=0$ でも $U(0)=u_0$ で $0$。
よって $\sum_{\zeta\in\mu_{\ell^n}}v_\ell(U(\zeta-1))=0$。

**(b) $\ell^\mu$ 部分.** $|\mu_{\ell^n}|=\ell^n$ なので寄与は $\mu\ell^n$。

**(c) distinguished 部分.** $g$ は monic なので
$g(T)=\prod_{i=1}^{\lambda}(T-\beta_i)$（$\beta_i\in\overline{\mathbb{Q}_\ell}$、重複込み）。
$\omega_n(T):=(1+T)^{\ell^n}-1=\prod_{\zeta\in\mu_{\ell^n}}(T-(\zeta-1))$
（両辺 monic 次数 $\ell^n$、根が一致し重根なし）。よって
$$\prod_{\zeta\in\mu_{\ell^n}}g(\zeta-1)=\prod_{\zeta}\prod_i\bigl((\zeta-1)-\beta_i\bigr)
=(-1)^{\lambda\ell^n}\prod_i\prod_\zeta\bigl(\beta_i-(\zeta-1)\bigr)
=(-1)^{\lambda\ell^n}\prod_{i}\omega_n(\beta_i).$$
$g$ の根 $\beta_i$ は $v_\ell(\beta_i)>0$ を満たす（distinguished 多項式の Newton 多角形：
最高次係数の付値 0、他の係数の付値 $\ge1$ なので全ての根の付値 $>0$。
具体的には $\beta_i^\lambda=-\sum_{k<\lambda}g_k\beta_i^k$ で $v_\ell(g_k)\ge1$ だから、
もし $v_\ell(\beta_i)\le0$ なら左辺の付値 $\le0$、右辺の付値 $\ge1+\min_k kv_\ell(\beta_i)$
$\ge 1+\lambda v_\ell(\beta_i)$ ... より直接には、$v_\ell(\beta_i)\le 0$ とすると
$v_\ell(\beta_i^\lambda)=\lambda v_\ell(\beta_i)$ に対し各 $k<\lambda$ の項は
$v_\ell(g_k\beta_i^k)\ge 1+kv_\ell(\beta_i)>\lambda v_\ell(\beta_i)$
（$1>(\lambda-k)v_\ell(\beta_i)$ は $v_\ell(\beta_i)\le0$ から明らか）なので
右辺の付値は左辺より真に大きく矛盾）。
また $\beta_i\neq0$: もし $\beta_i=0$ なら $g(0)=0$ で $f(0)=\ell^\mu g(0)U(0)=0$、
これは仮定「$\zeta=1$ で $f(\zeta-1)=f(0)\neq0$」に反する。よって $0<v_\ell(\beta_i)<\infty$。

補題 6.0 を各 $\beta_i$ に適用すると、$v_\ell(\omega_n(\beta_i))=n+c_{\beta_i}$（$n\ge n_0(\beta_i)$）。
$n_1:=\max_i n_0(\beta_i)$、$c':=\sum_i c_{\beta_i}$ とおくと、$n\ge n_1$ で
$$\sum_{\zeta\in\mu_{\ell^n}}v_\ell(g(\zeta-1))=\sum_{i=1}^{\lambda}v_\ell(\omega_n(\beta_i))=\lambda n+c'.$$

**(d) 合成.** $v_\ell(\Pi_n)=\mu\ell^n+(\lambda n+c')+0$。$c:=c'$ とおけばよい。
$\Pi_n\neq0$ は仮定から。∎

**定理 6.1（主定理：$(☆)$ と $\lambda$）.**
$X$ を有限**連結**多重グラフ（$m\ge1$ 頂点、ループ・多重辺可）、$\alpha:E\to\mathbb{Z}$ を voltage 割り当て、
$d$ を voltage 指数（定義 4.1）、$\ell$ を素数とし、
$$\ell\nmid d$$
を仮定する（系 4.4 により、これは全ての $X_{\ell^n}$ が連結であることと同値）。
$D(z)=\det L(z)$、$f(T):=D(1+T)\in\Lambda$ とおき（$d\neq0$ なので $D\neq0$、$f\neq0$）、
$\mu:=\mu(f)$、$\lambda_{\mathrm W}:=\lambda(f)$ を Weierstrass 不変量とする。
$\kappa_n:=\kappa(X_{\ell^n})$ とおくと $\kappa_n\ge1$ であり、ある $n_1\ge0$ と $\nu\in\mathbb{Z}$ が存在して
$$\boxed{\ \mathrm{ord}_\ell(\kappa_n)=\mu\,\ell^{n}+(\lambda_{\mathrm W}-1)\,n+\nu\qquad(n\ge n_1)\ }$$
が成り立つ。さらに
$$\boxed{\ \mu=v_\ell\bigl(\mathrm{content}_z(\det L(z))\bigr)\ }\tag{☆}$$
が成り立つ。（$\lambda_{\mathrm W}\ge1$ なので塔の $\lambda:=\lambda_{\mathrm W}-1\ge0$。）

*証明.*

**Step 0（$D\neq0$ と $\kappa_n\ge1$）.** $\ell\nmid d$ より $d\neq0$。
もし $D\equiv0$ なら、命題 4.3 (2) により全ての $N\ge2$ で $X_N$ は非連結、
とくに $\gcd(d,N)>1$ が全 $N\ge2$ で成り立つが、$N$ を $d$ と互いに素な素数に取れば矛盾。
（あるいは補題 4.5 の対偶。）よって $D\neq0$、補題 5.3 より $f\neq0$ で定理 5.1 が適用できる。
系 4.4 より全ての $n$ で $X_{\ell^n}$ は連結、すなわち $\kappa_n\ge1$。

**Step 1（$(★)$ の適用）.** $X$ は連結なので定理 3.4 より、$N=\ell^n$ に対し
$$\ell^{n}\kappa_n=\kappa_0\prod_{\zeta\in\mu_{\ell^n}\setminus\{1\}}D(\zeta),\qquad \kappa_0=\kappa(X)\ge1.$$
注意 3.6 より右辺の積は有理整数なので、$\overline{\mathbb{Q}}\hookrightarrow\overline{\mathbb{Q}_\ell}$ の
埋め込みを 1 つ固定して $\mu_{\ell^n}\subset\overline{\mathbb{Q}_\ell}$ とみなしてよい。$v_\ell$ を取ると
$$\mathrm{ord}_\ell(\kappa_n)=v_\ell(\kappa_0)-n+\sum_{\zeta\in\mu_{\ell^n}\setminus\{1\}}v_\ell\bigl(D(\zeta)\bigr).
\tag{6.1}$$
ここで $D(\zeta)=f(\zeta-1)$（$\zeta\in\mu_{\ell^n}$、$\zeta$ は $\overline{\mathbb{Z}_\ell}$ の元で
$v_\ell(\zeta-1)>0$ なので $f$ の代入が定義され、$D$ の Laurent 展開との一致は
$(1+T)^{-M}$ が $\zeta$ で $\zeta^{-M}$ に評価されることによる）。

**Step 2（$T$ 進位数の分離）.** 補題 5.4 の $r\ge1$ に対し $f=T^{r}\tilde h$、$\tilde h\in\Lambda$、
$\tilde h(0)\neq0$ と書ける（$f=\sum_{k\ge r}a_kT^k$、$\tilde h=\sum_{k\ge0}a_{r+k}T^k$、$\tilde h(0)=a_r\neq0$）。
このとき $\zeta\in\mu_{\ell^n}\setminus\{1\}$ に対し $D(\zeta)=(\zeta-1)^r\,\tilde h(\zeta-1)$ で、
$$\sum_{\zeta\neq1}v_\ell(D(\zeta))=r\sum_{\zeta\neq1}v_\ell(\zeta-1)+\sum_{\zeta\neq1}v_\ell(\tilde h(\zeta-1))
= rn+\Bigl[v_\ell(\Pi_n^{\tilde h})-v_\ell(\tilde h(0))\Bigr],\tag{6.2}$$
ここで補題 6.0' を使い、$\Pi_n^{\tilde h}:=\prod_{\zeta\in\mu_{\ell^n}}\tilde h(\zeta-1)$ とおいた
（$\zeta=1$ の因子 $\tilde h(0)$ を割って戻した）。

**Step 3（補題 6.0'' の適用条件の確認）.** $\tilde h\neq0$（$f\neq0$）。
また全ての $\zeta\in\mu_{\ell^\infty}$ で $\tilde h(\zeta-1)\neq0$ であることを確認する。
- $\zeta=1$: $\tilde h(0)=a_r\neq0$。✓
- $\zeta\neq1$: 系 4.4 (c)（$\ell\nmid d$ より成立）から $D(\zeta)\neq0$。
  $D(\zeta)=(\zeta-1)^r\tilde h(\zeta-1)$ かつ $\zeta-1\neq0$ なので $\tilde h(\zeta-1)\neq0$。✓

よって補題 6.0'' が $\tilde h$ に適用でき、ある $n_1,c$ に対し $n\ge n_1$ で
$$v_\ell(\Pi_n^{\tilde h})=\mu(\tilde h)\,\ell^n+\lambda(\tilde h)\,n+c.\tag{6.3}$$

**Step 4（$\mu(\tilde h),\lambda(\tilde h)$ と $\mu,\lambda_{\mathrm W}$ の関係）.**
$f=T^r\tilde h$ で、$T^r$ は distinguished（monic、低次係数 0）。
$\tilde h=\ell^{\mu(\tilde h)}g_1U$（Weierstrass 分解）とすると
$f=\ell^{\mu(\tilde h)}\,(T^rg_1)\,U$ で、$T^rg_1$ は distinguished（distinguished 多項式の積は
distinguished: monic は明らか、低次係数は $\bmod\ \ell$ で $T^r\cdot T^{\deg g_1}$ の展開が
最高次のみになることから従う）。定理 5.1 の一意性より
$$\mu=\mu(\tilde h),\qquad \lambda_{\mathrm W}=r+\lambda(\tilde h).\tag{6.4}$$

**Step 5（合成）.** $(6.1)(6.2)(6.3)(6.4)$ を合わせて、$n\ge n_1$ で
$$\mathrm{ord}_\ell(\kappa_n)=v_\ell(\kappa_0)-n+rn-v_\ell(\tilde h(0))+\mu\ell^n+(\lambda_{\mathrm W}-r)n+c$$
$$=\mu\,\ell^n+(\lambda_{\mathrm W}-1)\,n+\underbrace{\bigl[v_\ell(\kappa_0)-v_\ell(\tilde h(0))+c\bigr]}_{=: \nu}.$$
左辺は整数、$\mu\ell^n+(\lambda_{\mathrm W}-1)n$ も整数なので $\nu\in\mathbb{Z}$。

**Step 6（$(☆)$）.** 補題 5.3 より $\mu=\mu(f)=v_\ell(\mathrm{content}_z(D))$。

**Step 7（$\lambda_{\mathrm W}\ge1$）.** 補題 5.4 より $r\ge1$ で、$(6.4)$ と $\lambda(\tilde h)\ge0$ から
$\lambda_{\mathrm W}\ge r\ge1$。∎

**系 6.2（決定可能性）.** 定理 6.1 の $\mu$ と $\lambda=\lambda_{\mathrm W}-1$ は、
$X,\alpha,\ell$ から**有限手続きで**計算できる。
実際 $D(z)=z^{-M}P(z)$ を $M_m(\mathbb{Z}[z,z^{-1}])$ の行列式として求め、
$P(1+T)=\sum a_kT^k\in\mathbb{Z}[T]$ の係数を展開して
$$\mu=\min_kv_\ell(a_k)=v_\ell(\gcd_k a_k),\qquad \lambda_{\mathrm W}=\min\{k: v_\ell(a_k)=\mu\}$$
とすればよい（補題 5.2 と補題 5.3）。$\nu$ と $n_1$ はこの手続きでは決まらない
（$\nu$ は $c=\sum_i c_{\beta_i}$ を含み、根 $\beta_i$ の $\ell$ 進的な位置に依存する）。

---

## 7. $\mu>0$ の構造（cycle 12 の観察の証明）

**命題 7.1（$\mu_\ell>0$ の有限体判定）.**
$D\neq0$ とする。$\mathbb{F}_\ell[z,z^{-1}]$ 上で $\overline L(z):=L(z)\bmod\ell$ を考えると
$$\mu_\ell>0 \iff \det\overline L(z)=0\ \text{in }\mathbb{F}_\ell[z,z^{-1}]
\iff \overline L(z)\ \text{が}\ \mathbb{F}_\ell(z)\ \text{上で特異}.$$
より一般に、$\mu_\ell=\max\{k : D(z)\equiv0 \bmod \ell^k\}$。

*証明.* $\det$ は係数環の準同型 $\mathbb{Z}\to\mathbb{Z}/\ell^k$ と可換なので
$\det\bigl(L\bmod \ell^k\bigr)=D\bmod\ell^k$。よって
$D\equiv0\bmod\ell^k\iff \ell^k\mid\mathrm{content}_z(D)\iff v_\ell(\mathrm{content}_z D)\ge k$。
$(☆)$ より $\mu_\ell=v_\ell(\mathrm{content}_z D)$ だから主張を得る。
$k=1$ の場合が第 1 の同値であり、$\mathbb{F}_\ell[z,z^{-1}]$ は整域なので
$\det\overline L=0$ はその分数体 $\mathbb{F}_\ell(z)$ 上の特異性と同値。∎

**命題 7.2（bouquet では $\mu>0$ は自明例のみ）.**
$m=1$（1 頂点、辺は全てループ）とし、各 $a\ge1$ に対し $m_a:=\#\{$ voltage $\pm a$ のループ $\}$ とおく
（voltage 0 のループは $L$ に寄与しないので無視してよい）。少なくとも 1 つの $m_a>0$ とすると
$$\mathrm{content}_z(D)=\gcd_{a\ge1} m_a .$$
したがって $\mu_\ell>0$ となるのは「全ての $a$ で $\ell\mid m_a$」、すなわち
**$X$ が（voltage 0 のループを除いて）$\ell$ 重多重グラフである**ときに限る。

*証明.* $m=1$ なので $D(z)=L_{00}(z)=\sum_{a\ge1}m_a\,(2-z^{a}-z^{-a})$。
（voltage $a$ と $-a$ のループは同じ寄与 $2-z^a-z^{-a}$ を与えるので $m_a$ にまとめてよい。）
$z^{a}$（$a\ge1$）の係数は $-m_a$、$z^{-a}$ の係数も $-m_a$、定数項は $2\sum_a m_a$。
よって
$$\mathrm{content}_z(D)=\gcd\Bigl(\{m_a\}_{a\ge1},\ 2\textstyle\sum_a m_a\Bigr)=\gcd_a m_a,$$
最後の等号は $\gcd_a m_a$ が $2\sum_a m_a$ を割ることから。∎

**注意 7.3（$m\ge2$ での非自明な相殺）.** $m\ge2$ では $D$ は真の行列式なので、
$L$ の各成分の content が 1 でも $\det$ の content が $\ell$ で割れることがある。
cycle 12 の例 1（2 頂点、$u$–$v$ 間に voltage $0,1,2$ の平行 3 重辺、各頂点に voltage 1 のループ 1 本）
では、$a(z)=1+z+z^2$、$g(z)=5-z-z^{-1}$ とおくと $\det L=g^2-a(z)a(z^{-1})$ で、
$\bmod\,2$ では $g\equiv1+z+z^{-1}=z^{-1}a(z)$、$a(z^{-1})=z^{-2}a(z)$ より
$g^2\equiv z^{-2}a(z)^2\equiv a(z)a(z^{-1})$、よって $\det L\equiv0\pmod 2$、
命題 7.1 より $\mu_2\ge1$（実際 $\mathrm{content}=12$ より $\mu_2=2$）。
これは cycle 12 README の議論をそのまま命題 7.1 の枠に乗せたものである。

---

## 8. $\ell\mid N$ と $\ell\nmid N$ の違い

**(a) 公式 $(★)$ には区別が無い.** 定理 3.4 は任意の $N\ge1$ で成り立ち、
$\ell$ にも $N$ の素因数分解にも依存しない。塔では $N=\ell^n$ を取るだけである。

**(b) 塔の中の $\zeta$ の位数.** $N=\ell^n$ のとき $\mu_N=\mu_{\ell^n}$ で、
$\zeta$ の位数は $\ell^k$（$0\le k\le n$）。補題 6.0'' の証明は
$\omega_n(T)=(1+T)^{\ell^n}-1$ の根全体を一括して扱うので、位数ごとの場合分けは不要である。
位数が効くのは補題 6.0' の $v_\ell(\zeta-1)=\ell^{-(k-1)}(\ell-1)^{-1}$ の形だけで、
これも和 $\sum_{\zeta\neq1}v_\ell(\zeta-1)=n$ の形でしか使わない。

**(c) $p\neq\ell$ の付値（Washington–Sinnott 型の問題）.**
$\ell$ 塔の中で**別の**素数 $p\neq\ell$ における $v_p(\kappa_n)$ を見ると状況が変わる。
証明できるのは次だけである。

**命題 8.1.** 定理 6.1 の仮定の下、$p$ を任意の素数（$p=\ell$ でもよい）とし、
$c:=\mathrm{content}_z(D)$、$\mu_p:=v_p(c)$、$D=c\,D_0$（$D_0\in\mathbb{Z}[z,z^{-1}]$ は原始的）とおく。
このとき $R_n:=\prod_{\zeta\in\mu_{\ell^n}\setminus\{1\}}D_0(\zeta)\in\mathbb{Z}$ であり、
$$v_p(\kappa_n)=v_p(\kappa_0)-v_p(\ell^n)+\mu_p\,(\ell^n-1)+v_p(R_n).$$
とくに $p\neq\ell$ のとき $v_p(\ell^n)=0$ かつ $v_p(R_n)\ge0$ なので
$$v_p(\kappa_n)\ \ge\ \mu_p\,\ell^{n}+\bigl(v_p(\kappa_0)-\mu_p\bigr).$$

*証明.* $(★)$ より $\ell^n\kappa_n=\kappa_0\prod_{\zeta\neq1}D(\zeta)
=\kappa_0\,c^{\,\ell^n-1}\prod_{\zeta\neq1}D_0(\zeta)$（因子の個数は $\ell^n-1$）。
注意 3.6 と同じ議論で $\prod_{\zeta\neq1}D_0(\zeta)=R_n\in\mathbb{Z}$。$v_p$ を取れば第 1 式。
$R_n\in\mathbb{Z}$ かつ $R_n\neq0$（$X_{\ell^n}$ 連結より $\prod_{\zeta\ne1}D(\zeta)\ne0$）なので $v_p(R_n)\ge0$。∎

**証明できなかったこと**: $p\neq\ell$ のとき $v_p(R_n)$ が $n$ について有界かどうか。
有界なら $v_p(\kappa_n)=\mu_p\ell^n+O(1)$ という「$\lambda=0$ の岩澤型」になるが、
本セッションでは証明していない。これは数体側の Washington–Sinnott の定理
（円分 $\mathbb{Z}_\ell$ 拡大で $p\neq\ell$ の類数 $p$ 部分が有界）の類似であり、
グラフ側では arXiv:2201.05186 が扱っていると思われるが、**本文を確認していない**ので
どの命題がこれに当たるかは特定していない（§10 参照）。
数値的には $R_n$ の $p$ 部分が増える例が実際にある
（`verify_criterion.out` の G 節、例 5 で $\ell=2,p=5$: $v_5(\kappa_n)$ が $0,0,2,2,2$ と
途中で増えてから止まる）ので、「常に 0」ではない。

---

## 9. 退化ケースの完全な場合分け（落とさずに列挙する）

$X$ を有限多重グラフ、$\alpha$ を voltage 割り当て、$\ell$ を素数とする。

| ケース | 判定 | $(★)$ | 塔の岩澤型漸近 |
|---|---|---|---|
| $X$ が非連結 | $\kappa(X)=0$ | 成立（両辺 0、注意 3.5） | $\kappa_n=0$、$\mathrm{ord}_\ell$ 未定義 |
| $X$ 連結・$d=0$（voltage が potential） | $D\equiv0$（補題 4.5） | 成立（$N\ge2$ で両辺 0） | $\kappa_n=0$（$n\ge1$）、未定義 |
| $X$ 連結・$\ell\mid d$（$d\neq0$） | $\gcd(d,\ell^n)>1$ | 成立（$n\ge1$ で両辺 0） | $\kappa_n=0$（$n\ge1$）、未定義 |
| $X$ 連結・$\ell\nmid d$ | 全 $n$ で $X_{\ell^n}$ 連結 | 成立（非退化形） | **定理 6.1 が適用可** |
| ある $\zeta\in\mu_N\setminus\{1\}$ で $\det L(\zeta)=0$ | $X_N$ 非連結（命題 4.3） | 成立（両辺 0、場合 (i)） | その $N=\ell^n$ で $\kappa_n=0$ |
| ループ（voltage $a\neq0$） | $L_{uu}\mathrel{+}=2-z^a-z^{-a}$ | 補題 3.1 (b) で処理済 | 制限なし |
| ループ（voltage $a=0$） | $L$ にも $\Delta_X$ にも寄与せず | 補題 3.1 (b) で処理済 | 制限なし（削除してよい） |
| 多重辺 | 寄与を単純に加算 | 補題 3.1 (a)、定理 2.1 の多重グラフ版 | 制限なし |
| $m=1$（bouquet） | 命題 7.2 | 成立 | 適用可（$\mu>0$ は自明例のみ） |
| $\lambda_{\mathrm W}-1=0$（塔の $\lambda=0$） | $\lambda_{\mathrm W}=1$ | 成立 | 適用可 |
| $n_1>0$（小さい $n$ で式が破れる） | 補題 6.0 の $n_0$ に起因 | — | 定理は $n\ge n_1$ のみ主張 |

**最後の行の実例**（`verify_criterion.out` E 節）: 4 頂点、辺
$(0,1,0),(1,2,0),(2,3,0),(3,0,1),(0,2,1),(1,3,2)$、$\ell=2$。
$\mu=0$, $\lambda_{\mathrm W}=6$ で予測式 $v_2(\kappa_n)=5n+3$ は $n\ge1$ で成立するが
$n=0$ では実測 4、予測 3 で**破れる**。定理 6.1 が「$n\ge n_1$」としか主張しないことの実例であり、
cycle 12 の全例で $n_1=0$ が取れていたのは偶然（$\lambda_{\mathrm W}$ が小さい例ばかりだったため）である。

---

## 10. 既知性の確認（文献本文を取得して確認した範囲）

以下は本セッションで **PDF 本文を取得して読んだ**結果である。abstract のみの確認は
その旨を明記する。

### 10.1 McGown–Vallières, *On abelian $\ell$-towers of multigraphs III*（arXiv:2107.07639）

本文（arXiv 版 PDF）から逐語:

> **Theorem 6.1.** Let $X$ be a connected multigraph satisfying $\chi(X)\neq0$ and let
> $\alpha:S\longrightarrow\mathbb{Z}_\ell$ be a function for which all multigraphs
> $X(\mathbb{Z}/\ell^n\mathbb{Z},S,\alpha_n)$ are connected. […] define the $\ell$-adic integers $c_j$ via
> $Q(T)=P(Q_{b_1}(T),\dots)=c_1T+c_2T^2+\dots\in\mathbb{Z}_\ell[[T]]$ […] Let
> $\mu=\min\{v_\ell(c_j)\mid j=1,2,\dots\}$, and $\lambda=\min\{j\mid j\in\mathbb{N}\text{ and }v_\ell(c_j)=\mu\}-1$.
> If $\kappa_n$ denotes the number of spanning trees of $X(\mathbb{Z}/\ell^n\mathbb{Z},S,\alpha_n)$, then there exist
> a nonnegative integer $n_0$ and a constant $\nu\in\mathbb{Z}$ […] such that
> $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+\lambda n+\nu$, when $n\ge n_0$.

同論文 Corollary 5.6 により、$P(X_1,\dots,X_t,Y_1,\dots,Y_t)=\det M$、
$M=(d_{ij}-B_{ij}-C_{ij}+P_{ij}(X,Y))$ であり、$X_y\mapsto\rho_{\ell^k}(b_y)=\zeta^{b_y}-1$、
$Y_y\mapsto\zeta^{-b_y}-1$ の代入で $\det(D-A_{\psi_k})$ に一致する。
すなわち $\mathbb{Z}$ 値 voltage の場合 $Q_b(T)=(1+T)^b-1$ で、$Q(T)=\det L(1+T)=f(T)$。
したがって同定理の $\mu,\lambda$ は本稿の $\mu(f),\lambda(f)-1$ に**そのまま一致する**。

**結論: 定理 6.1（本稿）は既知**（McGown–Vallières III, Theorem 6.1）。
$(☆)$ は同定理の $\mu$ に補題 5.3（content 保存）を合わせただけで、新しい命題ではない。

本稿の証明は同論文と経路が異なる（同論文は Artin–Ihara $L$ 函数の $u=1$ 特殊値と
整数値多項式の $\ell$ 進補間を使う。本稿は Kirchhoff の微分形と Weierstrass 準備定理だけを使う）が、
これは**新規性ではなく単に別証明**である。仮定については本稿の方が弱い
（$\chi(X)\neq0$ を要しない）が、同論文は $\alpha$ を $\mathbb{Z}_\ell$ 値まで許す点で本稿より広い。

### 10.2 $(★)$ の出典

同論文 §5 に:

> Assuming $\chi(X)\neq0$, equation (7) in [17] shows that
> $|G|\cdot\kappa_Y=\kappa_X\prod_{\Psi\neq\Psi_0}h_X(1,\Psi)$

（[17] = Daniel Vallières, *On abelian $\ell$-towers of multigraphs*, Annales Mathématiques du Québec）。
また同論文 (6) で $h_X(1,\psi)=\det(D-A_\psi)$。巡回被覆 $G=\mathbb{Z}/N$ で
$A_\psi$ は $\psi(\bar1)=\zeta$ に対する voltage 隣接行列であり $D-A_\psi=L(\zeta)$。
よってこれは $(★)$ そのものである。

独立の経路として、Hammer–Mattman–Sands–Vallières, *The special value $u=1$ of Artin–Ihara
$L$-functions* の本文から:

> **Theorem 2.11.** […] $\mathrm{ord}_{u=1}(\zeta_X(u)^{-1})=r$ and
> $\zeta_X^*(1)=(-1)^{r+1}\cdot2^r\cdot(r-1)\cdot\kappa_X$ […]
>
> **Corollary 3.5.** […] If $\chi\neq\chi_1$, then $L^*_{Y/X}(1,\chi)=(-2)^{r_X-1}\cdot\det(D-A_\chi)$.

Theorem 3.1（$\zeta_Y(u)=\zeta_X(u)\prod_{\chi\neq\chi_1}L_{Y/X}(u,\chi)$）と合わせて
$u=1$ の主要項を比較すると、$r_Y-1=N(r_X-1)$ と 2 冪
$r_Y=N(r_X-1)+1$ vs $r_X+(r_X-1)(N-1)=N(r_X-1)+1$ が一致するので、
$r_X\neq1$（$=\chi(X)\neq0$）のとき $N\kappa_Y=\kappa_X\prod_{\zeta\neq1}\det L(\zeta)$ が従う。
**結論: $(★)$ は既知。** 本稿の定理 3.4 は仮定（連結性・$\chi(X)\neq0$・次数 1 の頂点なし）を
外した形だが、これは新規性の主張ではなく証明経路の副産物である。

### 10.3 確認できなかったこと

- **グラフ側で $\mu>0$ の明示例が文献にあるか**は、cycle 12 と同様、依然として未確認。
  arXiv:2006.14012 / 2105.08661 / 2201.05186 の**本文は本セッションでも取得していない**
  （2105.08661 は abstract のみ確認: bouquet 族の一般化）。
  cycle 12 の例が新しいのか既知の再現なのかは未確定のままであり、**新規性は主張しない**。
- **arXiv:2201.05186（$p\neq\ell$ の場合）**は本セッションで本文を取得していない。
  §8 (c) の「$v_p(R_n)$ が有界か」がこの論文で解決されているかどうかは**特定できていない**。
  推測は書かない。
- Gonet の学位論文（*Jacobians of Finite and Infinite Voltage Covers of Graphs*, Univ. of Vermont, 2021）
  の Theorem 27 が「底グラフが単純グラフのとき $\mu,\lambda$ の存在」を与えることは、
  McGown–Vallières III §8 の記述で**間接的に**確認した（Gonet 本文は未取得）。

---

## 11. 数値検証（SageMath）

`integrable-lattice/sagemath/check/cycle13_T3_criterion_proof/` に置いた。実行ログ付き。

| ファイル | 内容 | 結果 |
|---|---|---|
| `lib_voltage.sage` | 共通定義（$L(z)$, 導来グラフ, 終結式による $\prod_{\zeta\neq1}D(\zeta)$, voltage 指数 $d$, Weierstrass 不変量） | — |
| `verify_star.sage` / `.out` | A: $(★)$ を 19 種のグラフ × $N=1..12$（退化ケース込み）／B: 命題 4.3（成分数 $=\gcd(d,N)$、$\det L(\zeta)\neq0$ との同値）／C: 補題 5.3（content 保存）／D: 命題 7.2（bouquet） | FAIL 0 |
| `verify_criterion.sage` / `.out` | E: 定理 6.1（cycle 12 の全例＋追加例、$\mu$ と $\lambda=\lambda_{\mathrm W}-1$ の両方）／F: 命題 7.1（$\mathbb{F}_\ell$ 判定）／G: 命題 8.1 の下界 | FAIL 0 |

**検証の性格について（正直に）**: これらは証明の代用ではない。
$(★)$・命題 4.3・補題 5.3・命題 7.1・命題 7.2 は有限個の対象で完全に確認できる形の主張なので
「証明の各ステップが実際に主張どおりであること」の確認になるが、
定理 6.1 の漸近式は有限個の $n$ でしか確認できない（$\ell=2$ で $n\le6$、$\ell=23$ で $n\le1$）。
定理 6.1 が成り立つ根拠は §6 の証明であって、E 節の一致ではない。

**新しく分かったこと**（cycle 12 に無かった点）:

1. $\lambda$ も content 側から決まる（$\lambda=\lambda_{\mathrm W}-1$）。
   cycle 12 の例 5 の $\lambda=3$ は、$\det L/9=z^{-2}(z^4-7z^3+12z^2-7z+1)$ の
   $z=1$ での挙動から $\lambda_{\mathrm W}=4$ が出て、$4-1=3$ として**説明される**
   （cycle 12 ではフィットで得ただけだった）。
2. $n_1>0$ の実例を得た（§9 最終行）。cycle 12 の全例は $n_1=0$ だったので、
   「常に $n=0$ から成り立つ」という誤った一般化を排除できる。
3. $\mu_\ell>0$ の判定が $\mathbb{F}_\ell(z)$ 上の 1 個の行列式に落ちる（命題 7.1）。

---

## 12. 本プロジェクト（$\mathbb{R}/\Lambda$ 双対）への位置づけ

- $\Lambda$ 側の量 $\mu_\ell$ は、**有限体 $\mathbb{F}_\ell$ 上の行列式が 0 かどうか**という
  完全に決定可能・機械検証可能な条件に落ちた（命題 7.1、系 6.2）。
  cycle 11 T3 の「$\Lambda$ 側には Lehmer 型の連続的難問はない」という整理と整合する。
- 本稿で $\mathbb{R}$ は一度も使っていない。使った体は
  $\mathbb{Q}(\zeta_N)$、$\overline{\mathbb{Q}_\ell}$（の有限部分）、$\mathbb{F}_\ell$、
  および $\Lambda=\mathbb{Z}_\ell[[T]]$ のみ。
  $\Lambda$ は非可算だが、実際に使うのは「有限個の $\mathbb{Z}_\ell$ 係数」と
  「代数的な根 $\beta_i$」だけで、$\mathbb{R}$ 特有の完備性・連続性は使っていない。
  唯一 $\mathbb{Z}_\ell$ の完備性を使うのは Weierstrass 準備定理（定理 5.1）である
  ＝**$\mathbb{R}$ ならぬ「$\ell$ 進脱出」はこの 1 点に隔離されている**。
- なお $\mu,\lambda$ の**値**は $\mathbb{Z}[z]$ の有限データ（$P(1+T)$ の係数）だけで決まるので、
  定理 5.1 を使わない定式化（系 6.2）では完備性すら不要である。
  完備性が要るのは「その $\mu,\lambda$ が $\kappa_n$ の漸近を支配する」という部分のみ。

## 13. 残った課題

1. $p\neq\ell$ の $v_p(\kappa_n)$（§8 (c)）。arXiv:2201.05186 の本文確認から。
2. $\nu$ と $n_1$ の明示的決定。§6 の証明では $\nu=v_\ell(\kappa_0)-v_\ell(\tilde h(0))+\sum_i c_{\beta_i}$、
   $n_1=\max_i n_0(\beta_i)$ で、いずれも $g$ の根 $\beta_i$ の $\ell$ 進位置に依存する。
   $\beta_i$ の Newton 多角形から $n_1$ の上界を出すことは原理的に可能なはずだが、本稿ではやっていない。
3. $\mu_\ell$ の上界。cycle 12 の広域探索は範囲内の最大値を出しただけで、
   命題 7.1 は $\mu$ が有界かどうかについて何も言わない。
   $L$ の成分が $\bmod\ \ell^k$ で退化する条件を調べれば、$\mu\ge k$ の族を構成できる可能性がある。
