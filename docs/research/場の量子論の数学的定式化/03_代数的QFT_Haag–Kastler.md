# 03 代数的 QFT（Haag–Kastler）

代数的 QFT は、Wightman 流の「非有界作用素値超関数の族」（→ 02 章）を捨て、**時空の開領域 $\mathcal{O}$ に有界作用素の $C^*$ 代数 $\mathfrak{A}(\mathcal{O})$ を対応させる関手（ネット）**を基本対象に据える。場そのものは理論の同一性に関与せず、代数のネットとその上の状態だけが物理的内容を担う、という立場である。この枠組みでは超選択則が Doplicher–Haag–Roberts のテンソル圏として、粒子統計が統計次元として、真空の局所構造が von Neumann 環の型（ほぼ常に hyperfinite type III$_1$ factor）として現れる。可算・非可算の分別は **［ℝ 脱出］** の印で追跡する。とくに「型 III$_1$ 因子は最小射影をもたないが、有限次元代数の可算増大列の弱閉包（hyperfiniteness）である」という二重性が、本リポジトリの関心から見た本章の核心である。

---

## 1. 作用素環の必要最小限

### 1.1 $C^*$ 代数

**定義**：$\mathfrak{A}$ が **$C^*$ 代数**であるとは、複素代数であって

1. ノルム $\lVert\cdot\rVert\colon\mathfrak{A}\to\mathbb{R}_{\ge0}$ をもち、そのノルムについて完備（Banach 代数：$\lVert ab\rVert\le\lVert a\rVert\lVert b\rVert$）、
2. 対合 $*\colon\mathfrak{A}\to\mathfrak{A}$（反線形、$(ab)^*=b^*a^*$、$a^{**}=a$）をもち、
3. **$C^*$ 恒等式** $\lVert a^*a\rVert=\lVert a\rVert^2$（$a\in\mathfrak{A}$）

を満たすもの。単位元 $\mathbf{1}\in\mathfrak{A}$ をもつとき単位的という（本章では常に単位的とする）。

**［ℝ 脱出］** ノルムの値域が $\mathbb{R}_{\ge0}$ であること、完備性を要求すること、この 2 点で $C^*$ 代数は定義の段階で非可算集合に依拠する。有限次元 $C^*$ 代数（$\bigoplus_k M_{n_k}(\mathbb{C})$）は $\mathbb{C}$ 上の有限次元代数だが、無限次元の場合、ノルム完備化は不可欠である。$C^*$ 恒等式は代数構造からノルムを一意に決める（$C^*$ 代数のノルムは代数構造の関数であって追加データではない）という強い性質をもつ点は注意に値する。

**Gelfand–Naimark 定理（確立した定理、1943）**：任意の $C^*$ 代数は、ある Hilbert 空間 $\mathcal{H}$ 上の有界作用素環 $B(\mathcal{H})$ の閉 $*$-部分代数に等長 $*$-同型。可換な場合は $\mathfrak{A}\cong C_0(X)$（$X$ は局所コンパクト Hausdorff）。

### 1.2 状態と GNS 構成

**状態**：線形汎関数 $\omega\colon\mathfrak{A}\to\mathbb{C}$ で、$\omega(a^*a)\ge0$（正値）かつ $\omega(\mathbf{1})=1$（規格化）なるもの。状態全体 $\mathcal{S}(\mathfrak{A})$ は弱$*$位相でコンパクト凸集合（Banach–Alaoglu）。**［ℝ 脱出］** コンパクト性は弱$*$位相＝非可算な位相であり、Tychonoff（選択公理）を使う。

**GNS 構成（Gelfand–Naimark–Segal）**：状態 $\omega$ に対し、三つ組 $(\mathcal{H}_\omega,\pi_\omega,\Omega_\omega)$ がユニタリ同値を除いて一意に存在する。

1. 半内積 $\langle a,b\rangle_\omega:=\omega(a^*b)$、零空間 $\mathcal{N}_\omega=\{a\mid\omega(a^*a)=0\}$（左イデアル）、
2. $\mathcal{H}_\omega:=\overline{\mathfrak{A}/\mathcal{N}_\omega}$（**［ℝ 脱出］** 完備化）、
3. $\pi_\omega(a)[b]:=[ab]$（$*$-表現）、$\Omega_\omega:=[\mathbf{1}]$（巡回ベクトル）、$\omega(a)=\langle\Omega_\omega,\pi_\omega(a)\Omega_\omega\rangle$。

$\omega$ が純粋状態 $\iff$ $\pi_\omega$ が既約。02 章の Wightman 再構成定理は、Borchers 代数上の状態に対する GNS 構成そのものであった。

### 1.3 von Neumann 環と可換子定理

$\mathcal{M}\subseteq B(\mathcal{H})$ に対し **可換子** $\mathcal{M}':=\{b\in B(\mathcal{H})\mid ab=ba\ \forall a\in\mathcal{M}\}$。

**定義**：単位元を含む $*$-部分代数 $\mathcal{M}\subseteq B(\mathcal{H})$ が **von Neumann 環**とは $\mathcal{M}=\mathcal{M}''$。

**二重可換子定理（von Neumann 1930；確立した定理）**：単位的 $*$-部分代数 $\mathcal{M}\subseteq B(\mathcal{H})$ について
$$
\mathcal{M}=\mathcal{M}''\iff \mathcal{M}\text{ が弱作用素位相で閉}\iff\mathcal{M}\text{ が強作用素位相で閉}.
$$
すなわち**純代数的条件（可換子）と位相的条件（弱閉性）が一致する**。**［ℝ 脱出］** 弱作用素位相は $\mathcal{H}$ のベクトル対で添字づけられた半ノルム族による位相で、非可算個の半ノルムを使う（$\mathcal{H}$ 可分なら可算個の稠密族で足りる）。この定理は「非可算な位相的閉包が代数的に特徴づけられる」例であり、可算性の議論では珍しく都合がよい。

**因子（factor）**：$\mathcal{M}\cap\mathcal{M}'=\mathbb{C}\mathbf{1}$ なる von Neumann 環。

**前双対**：von Neumann 環 $\mathcal{M}$ は Banach 空間として一意な前双対 $\mathcal{M}_*$ をもつ（$\mathcal{M}=(\mathcal{M}_*)^*$）。$\mathcal{M}$ が**可分前双対**をもつ $\iff$ ある可分 Hilbert 空間上に忠実に表現できる。Connes の分類理論（§4.6）はこの**可算性仮定（可分前双対）を本質的に使う**。

**型の分類（Murray–von Neumann）**：因子 $\mathcal{M}$ は射影の同値類の構造により
- **型 I$_n$**（$n\in\mathbb{N}\cup\{\infty\}$）：$\mathcal{M}\cong B(\mathcal{K})$、$\dim\mathcal{K}=n$。最小射影が存在。
- **型 II$_1$**：有限トレース $\tau$（$\tau(\mathbf{1})=1$）をもつが最小射影なし。射影の「次元」が $[0,1]\subseteq\mathbb{R}$ 全体を動く。
- **型 II$_\infty$**：$\cong$ II$_1\ \bar\otimes\ B(\ell^2)$。半有限トレースあり。
- **型 III**：正規半有限忠実トレースが存在しない。すべての非零射影が互いに同値（properly infinite）。最小射影なし。

### 1.4 KMS 条件

$\mathcal{M}$ 上の 1 径数自己同型群 $(\sigma_t)_{t\in\mathbb{R}}$ と状態 $\omega$ について、$\omega$ が **逆温度 $\beta\in\mathbb{R}$ の KMS 状態**であるとは、各 $a,b\in\mathcal{M}$ に対し帯領域 $\{z\in\mathbb{C}\mid 0<\operatorname{Im}z<\beta\}$ 上有界正則で境界まで連続な関数 $F_{a,b}$ が存在して
$$
F_{a,b}(t)=\omega\bigl(a\,\sigma_t(b)\bigr),\qquad F_{a,b}(t+i\beta)=\omega\bigl(\sigma_t(b)\,a\bigr)\qquad(t\in\mathbb{R}).
$$
**［ℝ 脱出］** 定義そのものが複素帯領域上の正則関数を要求する。

---

## 2. Haag–Kastler 公理

### 2.1 領域の族と前順序集合

時空を $M=\mathbb{R}^d$（Minkowski、計量 $\eta=\operatorname{diag}(+1,-1,\dots,-1)$）とする。**二重錐**
$$
\mathcal{O}_{x,y}:=\bigl(x+V_+\bigr)\cap\bigl(y+V_-\bigr)\qquad(y-x\in V_+)
$$
（$V_\pm$ は開前方／後方光錐）全体の集合を $\mathcal{K}$ と書く。$\mathcal{K}$ は包含 $\subseteq$ について**有向前順序集合**：任意の $\mathcal{O}_1,\mathcal{O}_2\in\mathcal{K}$ に対し両者を含む $\mathcal{O}_3\in\mathcal{K}$ が存在する。

領域 $\mathcal{O}\subseteq M$ の**因果補**を
$$
\mathcal{O}':=\{y\in M\mid (y-x)\cdot(y-x)<0\ \ \forall x\in\mathcal{O}\}
$$
（$\mathcal{O}$ のすべての点と空間的に分離した点の全体）とする。

### 2.2 ネット＝関手（圏論的定式化）

前順序集合 $(\mathcal{K},\subseteq)$ を圏とみなす：対象は $\mathcal{K}$ の元、射は $\mathcal{O}_1\subseteq\mathcal{O}_2$ のとき唯一の射 $\iota_{12}\colon\mathcal{O}_1\to\mathcal{O}_2$、それ以外は射なし。

$\mathbf{C^*Alg}_1^{\mathrm{mono}}$ を「単位的 $C^*$ 代数を対象、単位的単射 $*$-準同型を射」とする圏とする。

> **定義（局所代数のネット）**：**関手**
> $$\mathfrak{A}\colon(\mathcal{K},\subseteq)\longrightarrow\mathbf{C^*Alg}_1^{\mathrm{mono}}$$
> のこと。関手性 $\mathfrak{A}(\iota_{12})\colon\mathfrak{A}(\mathcal{O}_1)\hookrightarrow\mathfrak{A}(\mathcal{O}_2)$ がそのまま **isotony（等方性）** の公理である。

すなわち Haag–Kastler の第一公理は「関手であること」に他ならない。以下、$\mathfrak{A}(\iota_{12})$ を包含とみなして $\mathfrak{A}(\mathcal{O}_1)\subseteq\mathfrak{A}(\mathcal{O}_2)$ と書く。

**準局所代数**：$\mathcal{K}$ の有向性より帰納極限
$$
\mathfrak{A}:=\overline{\bigcup_{\mathcal{O}\in\mathcal{K}}\mathfrak{A}(\mathcal{O})}^{\ \lVert\cdot\rVert}
$$
が単位的 $C^*$ 代数として定まる（圏 $\mathbf{C^*Alg}_1$ における有向余極限）。**［ℝ 脱出］** ここでノルム閉包を取る。代数的合併 $\bigcup_\mathcal{O}\mathfrak{A}(\mathcal{O})$ までなら「領域の可算増大列」で汲み尽くせるが（$\mathcal{K}$ は共終な可算部分族をもつ：有理座標の二重錐の増大列）、完備化で非可算へ出る。

### 2.3 公理

ネット $\mathfrak{A}$ が **Haag–Kastler ネット**であるとは、以下を満たすこと。

- **(HK1) Isotony**：上記の関手性。
- **(HK2) 局所性（Einstein 因果性）**：$\mathcal{O}_1\subseteq\mathcal{O}_2'$ ならば
$$
[\mathfrak{A}(\mathcal{O}_1),\mathfrak{A}(\mathcal{O}_2)]=\{0\}\quad\text{（}\mathfrak{A}\text{ の中で）}.
$$
- **(HK3) Poincaré 共変性**：群準同型 $\alpha\colon\mathcal{P}^\uparrow_+\to\operatorname{Aut}(\mathfrak{A})$ が存在して
$$
\alpha_g\bigl(\mathfrak{A}(\mathcal{O})\bigr)=\mathfrak{A}(g\mathcal{O})\qquad(g\in\mathcal{P}^\uparrow_+,\ \mathcal{O}\in\mathcal{K}).
$$
圏論的には、$\mathcal{P}^\uparrow_+$ が $\mathcal{K}$ に作用し、関手 $\mathfrak{A}$ がその作用に同変（$\alpha$ は自然同型の族）であること。
- **(HK4) 真空状態とスペクトル条件**：$\alpha$ 不変な状態 $\omega_0$（真空状態）が存在し、その GNS 表現 $(\mathcal{H}_0,\pi_0,\Omega_0)$ において $\alpha$ を実装する強連続ユニタリ表現 $U\colon\mathcal{P}^\uparrow_+\to\mathcal{U}(\mathcal{H}_0)$（$U(g)\pi_0(a)U(g)^{-1}=\pi_0(\alpha_g(a))$、$U(g)\Omega_0=\Omega_0$）が存在して、平行移動部分群の生成子 $P=(P^\mu)$ の同時スペクトルが $\overline{V}_+$ に含まれる。さらに $\Omega_0$ は $U(\mathbb{R}^d)$ 不変ベクトルとして一意（真空の一意性）。
- **(HK5) 加法性**：$\mathcal{O}=\bigcup_{i\in I}\mathcal{O}_i$（$\mathcal{O},\mathcal{O}_i\in\mathcal{K}$）ならば $\mathfrak{A}(\mathcal{O})=\bigvee_{i\in I}\mathfrak{A}(\mathcal{O}_i)$（生成される $C^*$ 部分代数）。「大域は局所から生成される」ことの要求。
- **(HK6) Haag 双対性**：真空表現において局所 von Neumann 環を $\mathcal{M}(\mathcal{O}):=\pi_0(\mathfrak{A}(\mathcal{O}))''\subseteq B(\mathcal{H}_0)$ と置く。このとき
$$
\mathcal{M}(\mathcal{O})'=\mathcal{M}(\mathcal{O}')\qquad(\mathcal{O}\in\mathcal{K}),
$$
ここで $\mathcal{M}(\mathcal{O}'):=\bigvee_{\mathcal{O}_1\subseteq\mathcal{O}'}\mathcal{M}(\mathcal{O}_1)$。

**(HK6) の位置づけ**：局所性 (HK2) は $\mathcal{M}(\mathcal{O})\subseteq\mathcal{M}(\mathcal{O}')'$ を与える（**弱い形＝これは常に成り立つ**）。Haag 双対性はその逆包含を要求する追加条件であり、**公理というより性質**である。自由場では成立（Araki 1964）、楔（wedge）領域については Bisognano–Wichmann から一般に従う（§4.5）。一方、超選択構造がある理論では二重錐に対して破れうる（破れの度合いが DHR 解析の対象となる）。

**局所可換 von Neumann 環のネット**：以後、真空表現に移して $\mathcal{O}\mapsto\mathcal{M}(\mathcal{O})$ を考えることが多い。この段階で対象は「$B(\mathcal{H}_0)$ の von Neumann 部分環の族」であり、**［ℝ 脱出］** 弱閉包を経由している。

### 2.4 局所共変 QFT（一般時空への拡張）

Brunetti–Fredenhagen–Verch (2003) は、Minkowski に限らない定式化を与えた：$\mathbf{Loc}$ を「大域的双曲的時空を対象、向きと因果構造を保つ等長埋め込みを射」とする圏、$\mathbf{Alg}$ を単位的 $C^*$ 代数と単射準同型の圏として、**関手** $\mathscr{A}\colon\mathbf{Loc}\to\mathbf{Alg}$ で因果性（因果的に分離した部分時空の像が可換）と time-slice（Cauchy 面の近傍が全体を決める）を満たすもの。Haag–Kastler ネットはこの関手を 1 つの時空へ制限して得られる。**ここでも QFT の正体は「関手」である。**

---

## 3. 観測可能量代数・場の代数・超選択則

### 3.1 二つの代数の区別

- **観測可能量代数** $\mathfrak{A}$：局所性 (HK2) が**交換子**で成り立ち、ゲージ変換で不変な量だけからなる。物理的に測定可能なものの代数。
- **場の代数** $\mathfrak{F}$：荷電場（フェルミオン等）を含み、局所性は交換子／反交換子の混合（graded locality）でしか成り立たない。コンパクト群 $G$（**大域ゲージ群**）が $\mathfrak{F}$ に作用し、$\mathfrak{A}=\mathfrak{F}^G$（不変部分代数）。

真空表現 $\pi_0$ は $\mathfrak{A}$ の**一つ**の表現にすぎない。物理的に興味ある状態（荷電粒子を含む状態）は $\pi_0$ とユニタリ同値でない表現に住む。この同値類が**超選択セクター**である。

### 3.2 DHR 判定条件（Doplicher–Haag–Roberts 1969, 1971, 1974）

$\mathfrak{A}$ の表現 $\pi$（可分 Hilbert 空間上）が **DHR 条件**を満たすとは、任意の二重錐 $\mathcal{O}\in\mathcal{K}$ に対し
$$
\pi\bigl|_{\mathfrak{A}(\mathcal{O}')}\ \cong\ \pi_0\bigl|_{\mathfrak{A}(\mathcal{O}')}\qquad(\text{ユニタリ同値}).
$$
物理側の慣用表現「電荷は有限領域に局在している」は、数学的にはこの条件（十分遠方では真空表現と区別できない）を指す。

**局所自己準同型への翻訳**：Haag 双対性 (HK6) のもとで、DHR 表現は $\mathfrak{A}$ の**局在化された輸送可能な自己準同型** $\rho\colon\mathfrak{A}\to\mathfrak{A}$（ある $\mathcal{O}$ について $\rho|_{\mathfrak{A}(\mathcal{O}')}=\mathrm{id}$、かつ任意の二重錐へ「移動」できる）と 1 対 1 に対応し、$\pi\cong\pi_0\circ\rho$。

### 3.3 テンソル圏の構造

局所自己準同型の全体は圏 $\mathrm{DHR}(\mathfrak{A})$ をなす：
- **対象**：局在化・輸送可能な自己準同型 $\rho$。
- **射**：$\operatorname{Hom}(\rho,\sigma)=\{t\in\mathfrak{A}\mid t\rho(a)=\sigma(a)t\ \forall a\in\mathfrak{A}\}$（**intertwiner が代数の元として実現される**点が肝）。
- **テンソル積**：自己準同型の合成 $\rho\otimes\sigma:=\rho\circ\sigma$、射の積 $t\times s:=t\,\rho(s)$。
- **直和・部分対象**：$\mathfrak{A}$ の局所環が型 III（§4）で無限の等長系をもつことから存在（この点で型 III 性が圏構造の存在に効く）。
- **統計作用素（対称性／組紐）**：$\rho,\sigma$ を空間的に離れた領域に局在させ交換して得るユニタリ $\varepsilon(\rho,\sigma)\in\operatorname{Hom}(\rho\sigma,\sigma\rho)$。

**次元による分岐（確立した定理）**：
- **時空次元 $d\ge3$**：二重錐の因果補 $\mathcal{O}'$ が**連結**なので、$\varepsilon$ の作り方が局在領域の取り方によらず、$\varepsilon(\rho,\sigma)\varepsilon(\sigma,\rho)=\mathbf{1}$（**対称テンソル圏**）。統計次元 $d(\rho)$ は**正整数または $\infty$**（Bose/Fermi 統計とパラ統計）。
- **時空次元 $d=2$（および $S^1$ 上の chiral 理論）**：$\mathcal{O}'$ が非連結（左右の 2 成分）なので、$\varepsilon$ は左右で異なり **組紐（braiding）** にしかならない。統計次元は非整数値を取りうる：Longo の指数定理により
$$
d(\rho)^2=\bigl[\mathcal{M}(\mathcal{O}):\rho\bigl(\mathcal{M}(\mathcal{O})\bigr)\bigr]\qquad(\text{Jones 指数}),
$$
Jones の指数定理から $d(\rho)\in\{1\}\cup\bigl\{2\cos(\pi/n)\mid n\in\mathbb{Z}_{\ge3}\bigr\}\cup[2,\infty]$。これが「エニオン統計」（物理側の慣用表現）の数学的内容であり、組紐テンソル圏・モジュラーテンソル圏を通じて共形場理論・頂点作用素代数（→ 07 章）へ接続する。

**［ℝ 脱出］** Jones 指数は $[1,\infty]\subseteq\mathbb{R}\cup\{\infty\}$ に値をとる実数量だが、その**値域が離散的な部分（$[1,4)$ の範囲）をもつ**ことが Jones の定理の内容である。すなわち「連続パラメータに見えるものが可算集合に落ちる」現象で、本リポジトリの関心（どこまで可算で閉じるか）から見て重要な例である。

### 3.4 Doplicher–Roberts 再構成定理

> **定理（Doplicher–Roberts 1989, 1990；確立した定理）**
> $d\ge3$ の Haag–Kastler ネット $\mathfrak{A}$（Haag 双対性・真空の一意性・Bose/Fermi 統計を仮定）に対し、**コンパクト群** $G$ と場のネット $\mathfrak{F}$（$G$ が作用、graded locality を満たす）が同型を除いて一意に存在して
> $$\mathfrak{A}(\mathcal{O})=\mathfrak{F}(\mathcal{O})^G,\qquad \mathrm{DHR}(\mathfrak{A})\ \simeq\ \mathrm{Rep}_{\mathrm{fin}}(G)$$
> （テンソル圏としての同値）。さらに $\mathcal{H}_0$ 上のすべての DHR セクターの直和が $\mathfrak{F}$ の真空表現を与える。

**抽象版（DR 双対性）**：単位対象の自己準同型が $\mathbb{C}$ で、共役をもち、置換対称性が「正常な統計」をもつ対称テンソル $C^*$ 圏は、あるコンパクト群 $G$ の有限次元ユニタリ表現の圏 $\mathrm{Rep}_{\mathrm{fin}}(G)$ に同値であり、$G$ は同型を除き一意。これは Tannaka–Krein 双対性の非可換版（前もって forgetful functor を与えない形）である。

**意味**：**内部対称性の群 $G$ とその表現論は、観測可能量のネットから完全に復元される。** 「ゲージ群」は理論の入力ではなく、ネットの局所構造の帰結である。02 章の再構成定理（超関数 → Hilbert 空間・場）に対応する、代数的 QFT 側の再構成定理といえる。

**［ℝ 脱出］** $G$ はコンパクト位相群で一般に非可算（例：$SU(N)$）。しかしその表現圏は可算個の既約対象しかもたない（コンパクト群の既約ユニタリ表現の同型類は可算とは限らないが、$G$ が可分コンパクトなら可算）。DHR 圏の側は「可算個の対象 ＋ 有限次元の射空間」という組合せ的データで、群の非可算性はそこから再構成される。

---

## 4. 局所環の型：hyperfinite type III$_1$ factor

### 4.1 主定理

> **定理（Araki 1964；Longo 1979；Fredenhagen 1985；Buchholz–D'Antoni–Fredenhagen 1987）**
> 真空表現における二重錐の局所 von Neumann 環 $\mathcal{M}(\mathcal{O})=\pi_0(\mathfrak{A}(\mathcal{O}))''$ は、自由場をはじめとする既知のほぼすべての模型において、**一意な hyperfinite 型 III$_1$ 因子**（Araki–Woods–Connes–Haagerup の因子 $R_\infty$）に $*$-同型である。Buchholz–D'Antoni–Fredenhagen は、適切なスケーリング（短距離での漸近的スケール不変性）の仮定のもとでこれが一般的に成り立つことを示した。

対照的に、**大域代数** $\mathcal{M}(M)=B(\mathcal{H}_0)$ は型 I である。すなわち「型 I は大域、型 III は局所」という分離がある。

**hyperfinite**（近似有限次元）とは：有限次元 $*$-部分代数の**可算増大列** $\mathcal{M}_1\subseteq\mathcal{M}_2\subseteq\cdots\subseteq\mathcal{M}$ が存在して $\overline{\bigcup_n\mathcal{M}_n}^{\ \mathrm{w}}=\mathcal{M}$。

### 4.2 型 III$_1$ の帰結：最小射影がない

型 III 因子 $\mathcal{M}$ では：
- 非零の**有限射影**が存在しない。したがって**最小射影も存在しない**。
- 正規半有限忠実トレースが存在しない。
- すべての非零射影 $p,q\in\mathcal{M}$ は Murray–von Neumann 同値（$\exists v\in\mathcal{M}:v^*v=p,\ vv^*=q$）。

**帰結（素朴な操作が不可能になる）**：
1. **テンソル分解がない**：$\mathcal{H}_0\cong\mathcal{H}_\mathcal{O}\otimes\mathcal{H}_{\mathcal{O}'}$ と書いて $\mathcal{M}(\mathcal{O})=B(\mathcal{H}_\mathcal{O})\otimes\mathbf{1}$ とする分解は存在しない（型 I ならできる）。
2. **密度行列がない**：状態 $\omega|_{\mathcal{M}(\mathcal{O})}$ をトレースクラス作用素 $\rho_\mathcal{O}$ で $\omega(a)=\operatorname{Tr}(\rho_\mathcal{O}\,a)$ と表す表示は存在しない。
3. **von Neumann エントロピー $-\operatorname{Tr}(\rho\log\rho)$ が定義されない**。代わりに **Araki の相対エントロピー**
$$
S(\omega\Vert\varphi)=-\bigl\langle\Omega_\omega,\ \log\Delta_{\varphi|\omega}\,\Omega_\omega\bigr\rangle\in[0,\infty]
$$
（相対モジュラー作用素 $\Delta_{\varphi|\omega}$ による）が型に依らず定義される。
4. **局所的な「粒子数」がない**：$\mathfrak{A}(\mathcal{O})$ 内に自明でない有限次元スペクトル射影の族が取れない。

「有限領域から状態を局所的に取り出す」という素朴な操作は、この段階で数学的に不可能である。**分裂性（split property）** がその代替を与える：$\overline{\mathcal{O}_1}\subseteq\mathcal{O}_2$ なら型 I 因子 $\mathcal{N}$ が存在して $\mathcal{M}(\mathcal{O}_1)\subseteq\mathcal{N}\subseteq\mathcal{M}(\mathcal{O}_2)$（Buchholz、Doplicher–Longo）。分裂性は Buchholz–Wichmann の核性条件（nuclearity；「有限エネルギー・有限体積の状態空間が核型的に小さい」という**近似的な有限次元性**の条件）から従う（Buchholz–D'Antoni–Longo 1990）。

### 4.3 Reeh–Schlieder と真空

02 章 §6.1 の Reeh–Schlieder 定理は、代数的定式化では次の形になる：任意の $\mathcal{O}\in\mathcal{K}$ に対し $\Omega_0$ は $\mathcal{M}(\mathcal{O})$ について**巡回的**（$\overline{\mathcal{M}(\mathcal{O})\Omega_0}=\mathcal{H}_0$）かつ**分離的**（$a\in\mathcal{M}(\mathcal{O})$, $a\Omega_0=0\Rightarrow a=0$；局所性と $\mathcal{O}'$ に対する巡回性から従う）。

**これが決定的である**：巡回的かつ分離的なベクトルの存在は Tomita–Takesaki 理論の適用条件そのものであり、したがって **AQFT ではすべての局所領域についてモジュラー理論が使える**。

### 4.4 Tomita–Takesaki 理論

$\mathcal{M}\subseteq B(\mathcal{H})$ を von Neumann 環、$\Omega\in\mathcal{H}$ を巡回的かつ分離的なベクトルとする。

1. 反線形作用素 $S_0\colon\mathcal{M}\Omega\to\mathcal{M}\Omega$, $S_0(a\Omega):=a^*\Omega$ を定める（分離性より well-defined、巡回性より稠密定義）。
2. $S_0$ は可閉。閉包 $S=\overline{S_0}$ の**極分解** $S=J\Delta^{1/2}$。ここで $\Delta=S^*S$ は正の自己共役作用素（**モジュラー作用素**、一般に非有界）、$J$ は反ユニタリ対合（**モジュラー共役**）。
3. **Tomita–Takesaki 定理（確立した定理、Tomita 1967, Takesaki 1970）**：
$$
J\mathcal{M}J=\mathcal{M}',\qquad \Delta^{it}\mathcal{M}\Delta^{-it}=\mathcal{M}\quad(t\in\mathbb{R}).
$$
4. **モジュラー自己同型群** $\sigma^\omega_t:=\operatorname{Ad}(\Delta^{it})|_\mathcal{M}$（$\omega=\langle\Omega,\cdot\,\Omega\rangle$）。$\omega$ は $(\sigma^\omega_t)$ に関する逆温度 $-1$（規約により $\beta=1$）の KMS 状態。
5. **Connes のコサイクル**：二つの忠実正規状態 $\omega,\varphi$ について $(D\varphi:D\omega)_t\in\mathcal{M}$ がユニタリで $\sigma^\varphi_t=\operatorname{Ad}((D\varphi:D\omega)_t)\circ\sigma^\omega_t$。したがって**モジュラー流は状態に依らず、外部自己同型群 $\operatorname{Out}(\mathcal{M})=\operatorname{Aut}(\mathcal{M})/\operatorname{Inn}(\mathcal{M})$ の中では正準的**（Connes 1973）。von Neumann 環は「正準的な時間発展」を内蔵している。

**［ℝ 脱出］** $\Delta$ は非有界正作用素で、$\Delta^{it}$ はスペクトル定理による関数計算（$\mathbb{R}_{>0}$ 上の Borel 測度を使う）で定義される。パラメータ $t\in\mathbb{R}$ は非可算、流れの連続性は $\mathbb{R}$ の位相に依存し、KMS 条件は複素帯領域上の正則性を要求する。**この理論を可算的な枠組みへ落とす方法は知られていない。**

### 4.5 Bisognano–Wichmann 定理

**楔領域** $W_R:=\{x\in\mathbb{R}^d\mid x^1>|x^0|\}$、$\mathcal{M}(W_R)$ を対応する von Neumann 環とする。

> **定理（Bisognano–Wichmann 1975, 1976；確立した定理）**
> Wightman 場から構成されたネットにおいて、$(\mathcal{M}(W_R),\Omega_0)$ のモジュラー対象は
> $$\Delta_{W_R}^{it}=U\bigl(\Lambda_{W_R}(-2\pi t)\bigr),\qquad J_{W_R}=\Theta\,U\bigl(R_1(\pi)\bigr)$$
> で与えられる。ここで $\Lambda_{W_R}(s)$ は $W_R$ を保つ 1 径数 boost 群、$R_1(\pi)$ は $x^1$ 軸まわりの $\pi$ 回転、$\Theta$ は PCT 作用素。

**意味**：抽象的に定義されたモジュラー流が、時空の幾何学的変換（Lorentz boost）と一致する。特に真空 $\omega_0$ は boost 群に関して逆温度 $2\pi$ の KMS 状態（物理側の慣用表現では Unruh 効果）。$J_{W_R}$ と Haag 双対性 $\mathcal{M}(W_R)'=\mathcal{M}(W_R')$ も同時に得られ、**楔領域については Haag 双対性が定理として従う**。

**注意（仮定の位置）**：Bisognano–Wichmann は Wightman 場の存在を仮定した定理である。純粋に Haag–Kastler の公理だけからは従わず、一般には「モジュラー共変性」として**追加の仮定**に置かれる。質量ギャップと漸近完全性のもとでの証明は Mund (2001) による。この差は文献確認を要する点である。

### 4.6 Connes の分類

$\mathcal{M}$ を**可分前双対をもつ**因子とする。Connes 不変量
$$
S(\mathcal{M}):=\bigcap_{\varphi}\operatorname{Spec}(\Delta_\varphi)\subseteq[0,\infty)
$$
（$\varphi$ は忠実正規半有限重みを走る）により型 III をさらに細分：
$$
S(\mathcal{M})=\{1\}\ \Rightarrow\ \text{III}_1,\qquad S(\mathcal{M})=\{0\}\cup\lambda^{\mathbb{Z}}\ \Rightarrow\ \text{III}_\lambda\ (0<\lambda<1),\qquad S(\mathcal{M})=\{0,1\}\ \Rightarrow\ \text{III}_0 .
$$

**一意性定理**：
- Connes (1976)：hyperfinite 因子で型 II$_1$、II$_\infty$、III$_\lambda$（$0<\lambda<1$）のものはそれぞれ同型を除いて一意。
- Krieger (1976)：hyperfinite 型 III$_0$ は付随するエルゴード流により分類。
- **Haagerup (1987)**：hyperfinite 型 III$_1$ 因子は同型を除いて**一意**。

したがって「局所環は hyperfinite 型 III$_1$」という §4.1 の主張は、**局所環は模型に依らず同一の対象である**ことを意味する。ネットの物理的内容は個々の代数ではなく、**代数どうしの相対位置（部分環の包含関係の族）**にすべて含まれている。

**［ℝ 脱出］・可算性の注意**：Connes の分類理論は「可分前双対」＝可分 Hilbert 空間上での表現可能性という**可算性の仮定**を全面的に使う。可分性を落とすと分類は破綻する（非可分な場合、hyperfinite III$_1$ の一意性は成り立たない）。すなわち **AQFT の局所環の一意性は、可算性の仮定の上に立っている。**

---

## 5. 型 III の出現がなぜ本質か（可算性の観点から）

本リポジトリの関心（どこまで可算で閉じ、どこで $\mathbb{R}$ へ出るか）に沿って整理する。

**(a) 型 III は「可算データ＋非トレース状態」から自然に出る。** Powers (1967)・Araki–Woods (1968) の構成：$\lambda\in(0,1)$ を固定し、$M_2(\mathbb{C})$ 上の状態 $\varphi_\lambda(a)=\operatorname{Tr}(\rho_\lambda a)$、$\rho_\lambda=\operatorname{diag}\bigl(\tfrac{1}{1+\lambda},\tfrac{\lambda}{1+\lambda}\bigr)$ を取り、
$$
\mathcal{M}_\lambda:=\pi_{\varphi}\Bigl(\bigotimes_{n\in\mathbb{N}}M_2(\mathbb{C})\Bigr)'',\qquad \varphi=\bigotimes_{n\in\mathbb{N}}\varphi_\lambda
$$
（GNS 表現の弱閉包）とすると $\mathcal{M}_\lambda$ は hyperfinite 型 III$_\lambda$ 因子。**入力は「$M_2(\mathbb{C})$ の可算個のコピー」と「$\lambda$」だけ**であり、組合せ的・可算的に指定できる。型 III$_1$ は $\lambda_1,\lambda_2$ の比が無理数となる 2 種類のテンソル積などで得られる。

**［ℝ 脱出］はどこか**：
1. 無限テンソル積の Hilbert 空間。von Neumann (1938) の完全無限テンソル積 $\bigotimes_{n}\mathbb{C}^2$ は**非可分**（濃度 $2^{2^{\aleph_0}}$ 以上の正規直交基底をもつ）。可分な理論を得るには、参照列（ここでは $\varphi$）を選んで「不完全テンソル積」の可分成分だけを取る必要がある。**状態の選択が可分性を生む。**
2. 弱閉包。
3. パラメータ $\lambda\in(0,1)\subseteq\mathbb{R}$ が非可算個の非同型な因子を与える（$\mathcal{M}_\lambda\cong\mathcal{M}_{\lambda'}\iff\lambda=\lambda'$）。

**(b) hyperfiniteness ＝ 近似的な可算性。** 型 III$_1$ 因子は最小射影をもたず、有限次元代数から最も遠いように見える。しかし hyperfinite であるとは、有限次元代数の**可算増大列の弱閉包**であるということ。すなわち

> 代数の「骨格」は可算（有限次元代数の可算列とその埋め込み）であり、型 III$_1$ という性質は**弱閉包を取る操作（＝ ℝ 脱出）から生じる**。

有限次元代数の列だけを見ていても型は見えない。型は極限操作の副産物である。この構図は、02 章の「Wightman 関数は可算個の Hermite 係数だが、条件の意味づけは $\mathbb{R}$」という構図と同型である。

**(c) 核性条件（nuclearity）は「近似的有限次元性」の定量化。** Buchholz–Wichmann の核性条件は、写像 $\Theta_{\beta,\mathcal{O}}\colon\mathfrak{A}(\mathcal{O})\to\mathcal{H}_0$, $a\mapsto e^{-\beta H}a\Omega_0$ が核型作用素であり、その核ノルムがエネルギーと体積について適切な増大度をもつことを要求する。これは「有限エネルギー・有限体積の自由度の個数が実質的に有限である」ことの表現で、分裂性・熱力学的性質・粒子解釈を導く。**格子模型・可算模型との接点はここにある。**

**(d) 格子模型との比較**：量子スピン鎖（$\bigotimes_{n\in\mathbb{Z}}M_2(\mathbb{C})$ の準局所代数）では、有限領域の代数は**有限次元**（型 I$_{2^N}$）であり、型 III は現れない。型 III は連続時空の「任意に小さいスケールにも自由度がある」ことの帰結である。したがって、**QFT を格子で近似する（＝可算化する）と型 III 性は消え、連続極限で復活する**。どこで型が変わるかを追跡することが、本リポジトリの「可算／非可算の分別」の QFT 版にあたる。

---

## 6. 到達点と限界

### 6.1 厳密な例が存在するもの（確立した構成）

1. **自由場**：スカラー（Weyl 代数／CCR）、Dirac（CAR）。Araki (1963, 1964)、Segal。局所環は型 III$_1$。すべての Haag–Kastler 公理（Haag 双対性を含む）を満たす。
2. **一般化自由場・Wick 多項式のネット**。
3. **共形ネット**（$S^1$ 上のカイラル共形場理論）：$\mathrm{Diff}(S^1)$ 共変な von Neumann 環のネット。Virasoro ネット、loop 群ネット（Wassermann 1998、Toledano-Laredo 1999）、格子ネット、余次元有限の部分ネット（Longo–Xu）など多数。**中心電荷 $c<1$ の共形ネットの完全分類**（Kawahigashi–Longo 2004）は、$A$-$D$-$E$ 型のモジュラー不変量による分類として完結している。→ 07 章。
4. **1+1 次元可積分模型**（Lechner 2008 ほか）：因子化 $S$ 行列（2 体 $S$ 行列 $S_2$ が Yang–Baxter と交叉対称性を満たす）から、まず**楔代数**を polarization-free generator により構成し、**モジュラー核性**（modular nuclearity）を検証して二重錐代数
$$
\mathcal{M}(\mathcal{O})=\mathcal{M}(W_1)\cap\mathcal{M}(W_2)
$$
が非自明（$\Omega_0$ について巡回的）であることを証明する。これにより、**相互作用する（$S\ne\mathbf{1}$）相対論的 QFT が Haag–Kastler 公理を完全に満たす形で構成された**（1+1 次元、質量つき、Buchholz–Lechner–Summers らによる拡張あり）。可積分格子模型の Yang–Baxter 構造が QFT の存在証明に直接使われる例であり、本リポジトリの `integrable-lattice/` プロジェクトと接続する点である。
5. **摂動的代数的 QFT**（Brunetti–Fredenhagen、Hollands–Wald）：曲がった時空を含む一般の場合に、形式的べき級数のレベルで局所共変な代数を構成。**収束は示されておらず、$\hbar$ や結合定数についての形式級数にとどまる。**

### 6.2 限界・未解決

1. **4 次元の相互作用模型は未構成（未解決）**：$d=4$ で自由でない Haag–Kastler ネットは一つも構成されていない。02 章 §9 と同じ壁である。
2. **Haag 双対性の破れ**：ソリトンセクター、位相的欠陥のある理論、$d=2$ では二重錐に対して破れうる。破れの度合いは Roberts の「双対性の破れの指数」で測られる。
3. **DHR 解析の適用範囲**：長距離の電荷（Gauss 則をもつゲージ電荷、電磁場の電荷）は DHR 条件を満たさない。massive な場合の拡張として Buchholz–Fredenhagen (1982) の**錐状局在**（spacelike cone localization）があり、$d\ge4$ で置換統計が回復する。massless の場合（赤外問題、infraparticle）は一般論が未確立（**未解決**）。
4. **モジュラー共変性の公理化**：Bisognano–Wichmann が純代数的公理から従うか（§4.5）。一般には未解決。
5. **局所環の型の一般証明**：「二重錐の局所環は必ず hyperfinite III$_1$」は、スケーリングや核性の仮定なしには証明されていない（**限定的な定理であり、無条件の定理ではない**）。
6. **エントロピー**：型 III$_1$ ゆえ局所エントロピーは発散する。相対エントロピー・相対モジュラー理論による定式化（Araki、Longo、Casini–Huerta）が代替を与えるが、「領域の絡み合いエントロピー」の直接的な数学的定義は存在しない。
7. **本ノートで文献確認を要する点**：(i) 局所環の型 III$_1$ 性についての Fredenhagen (1985) と Buchholz–D'Antoni–Fredenhagen (1987) の仮定の正確な形。(ii) DHR 圏における統計次元の値域と Jones 指数の対応（Longo の指数定理の適用条件）。(iii) 低次元での組紐圏がモジュラーになるための条件（完全有理性、Kawahigashi–Longo–Müger）。

---

## 7. 数学的対象としての正体（まとめ）

- **AQFT の正体**：前順序集合 $(\mathcal{K},\subseteq)$（時空の開領域）から単位的 $C^*$ 代数の圏への**関手** $\mathfrak{A}$ で、局所性・Poincaré 同変性・加法性を満たし、真空状態 $\omega_0$（スペクトル条件つき）を伴うもの。一般時空版では $\mathbf{Loc}\to\mathbf{Alg}$ の関手。**QFT ＝ 関手 ＋ 状態。**
- **場は不要**：Wightman の $\phi(f)$ は AQFT では現れない。同一のネットを与える場は無数にあり（Borchers 類）、場の選び方は理論の同一性に関与しない。**理論の同一性を担うのはネットの同型類。**
- **局所代数そのものには情報がない**：局所環はほぼ常に一意な hyperfinite 型 III$_1$ 因子。したがって物理的情報は**包含関係の族**（相対位置）と真空状態にのみ宿る。
- **超選択則＝テンソル圏**：DHR 圏。$d\ge3$ では対称テンソル圏であり、DR 再構成定理によりコンパクト群 $G$ とその表現圏に一致する（Tannaka–Krein 型）。$d\le2$ では組紐テンソル圏で、統計次元は非整数（Jones 指数の平方根）。
- **可算・非可算の分別**：
  - 可算側：DHR 圏の対象（可算個）と有限次元の射空間、hyperfinite 因子を与える有限次元代数の可算増大列、Powers–Araki–Woods 構成の入力データ、Jones 指数の離散スペクトル $\{4\cos^2(\pi/n)\}$、格子近似における有限次元局所代数。
  - 非可算側 **［ℝ 脱出］**：$C^*$ ノルム完備化、GNS 完備化、弱閉包（二重可換子）、無限テンソル積 Hilbert 空間の非可分性、モジュラー作用素 $\Delta$ の非有界性と連続流 $\Delta^{it}$（$t\in\mathbb{R}$）、KMS 条件の複素解析、Connes 不変量 $S(\mathcal{M})\subseteq[0,\infty)$、型 III$_\lambda$ の非可算族。
  - **一意性が可算性に依存する**：hyperfinite 型 III$_1$ 因子の一意性（Haagerup）も Connes 分類も「可分前双対」を仮定する。

---

## 主要文献

- R. Haag, D. Kastler, "An algebraic approach to quantum field theory", *J. Math. Phys.* **5** (1964) 848. — 公理の原典。
- R. Haag, *Local Quantum Physics: Fields, Particles, Algebras*, 2nd ed., Springer (1996). — 標準教科書。
- H. Araki, *Mathematical Theory of Quantum Fields*, Oxford (1999).
- O. Bratteli, D. W. Robinson, *Operator Algebras and Quantum Statistical Mechanics* I, II, Springer (1987/1997). — $C^*$/von Neumann 環、GNS、KMS、Tomita–Takesaki。
- M. Takesaki, *Theory of Operator Algebras* I–III, Springer (1979/2003). — モジュラー理論・型の分類の標準参考書。
- J. von Neumann, "On rings of operators", *Math. Ann.* **102** (1930) 370; "On infinite direct products", *Compositio Math.* **6** (1938) 1. — 二重可換子定理、無限テンソル積の非可分性。
- M. Tomita (1967, 未公刊); M. Takesaki, *Tomita's Theory of Modular Hilbert Algebras and its Applications*, Lecture Notes in Math. 128, Springer (1970).
- A. Connes, "Une classification des facteurs de type III", *Ann. Sci. ÉNS* **6** (1973) 133; "Classification of injective factors", *Ann. Math.* **104** (1976) 73.
- U. Haagerup, "Connes' bicentralizer problem and uniqueness of the injective factor of type III$_1$", *Acta Math.* **158** (1987) 95.
- H. Araki, E. J. Woods, "A classification of factors", *Publ. RIMS Kyoto* **4** (1968) 51; R. T. Powers, *Ann. Math.* **86** (1967) 138.
- H. Araki, "Von Neumann algebras of local observables for free scalar field", *J. Math. Phys.* **5** (1964) 1.
- K. Fredenhagen, "On the modular structure of local algebras of observables", *Commun. Math. Phys.* **97** (1985) 79.
- D. Buchholz, C. D'Antoni, K. Fredenhagen, "The universal structure of local algebras", *Commun. Math. Phys.* **111** (1987) 123.
- J. J. Bisognano, E. H. Wichmann, "On the duality condition for a Hermitian scalar field", *J. Math. Phys.* **16** (1975) 985; **17** (1976) 303.
- S. Doplicher, R. Haag, J. E. Roberts, "Local observables and particle statistics I, II", *Commun. Math. Phys.* **23** (1971) 199; **35** (1974) 49.
- S. Doplicher, J. E. Roberts, "A new duality theory for compact groups", *Invent. Math.* **98** (1989) 157; "Why there is a field algebra with a compact gauge group describing the superselection structure in particle physics", *Commun. Math. Phys.* **131** (1990) 51.
- D. Buchholz, K. Fredenhagen, "Locality and the structure of particle states", *Commun. Math. Phys.* **84** (1982) 1.
- R. Longo, "Index of subfactors and statistics of quantum fields I, II", *Commun. Math. Phys.* **126** (1989) 217; **130** (1990) 285.
- V. F. R. Jones, "Index for subfactors", *Invent. Math.* **72** (1983) 1.
- D. Buchholz, C. D'Antoni, R. Longo, "Nuclear maps and modular structures", *J. Funct. Anal.* **88** (1990) 233.
- G. Lechner, "Construction of quantum field theories with factorizing S-matrices", *Commun. Math. Phys.* **277** (2008) 821.
- Y. Kawahigashi, R. Longo, "Classification of local conformal nets. Case $c<1$", *Ann. Math.* **160** (2004) 493.
- R. Brunetti, K. Fredenhagen, R. Verch, "The generally covariant locality principle — a new paradigm for local quantum field theory", *Commun. Math. Phys.* **237** (2003) 31.
- J. Mund, "The Bisognano–Wichmann theorem for massive theories", *Ann. Henri Poincaré* **2** (2001) 907.
