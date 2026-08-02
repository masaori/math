# 02 Wightman 公理系と再構成定理

Wightman の定式化は「場の量子論とは何か」への最も直接的な答えの一つを与える。すなわち **QFT とは、正定値性・Poincaré 不変性・スペクトル台条件・局所可換性・クラスター性を満たす緩増加超関数の族 $(W_n)_{n\ge0}$ のことである**。再構成定理はこの言い換えが可逆であること（超関数の族から Hilbert 空間・表現・真空・場が同型を除いて一意に復元されること）を主張する。本章では前提となる関数解析の道具（非有界作用素の定義域、Gårding 領域、作用素値超関数）を厳密に置いたのち、公理 W0–W5 を一つずつ述べ、再構成定理とその帰結（Reeh–Schlieder、PCT、スピン統計、Haag の定理）を整理する。可算・非可算の分別は **［ℝ 脱出］** の印で追跡する。

---

## 1. 前提となる道具

### 1.1 Hilbert 空間と可分性

複素 Hilbert 空間 $\mathcal{H}$ とは、複素ベクトル空間で内積 $\langle\cdot,\cdot\rangle\colon\mathcal{H}\times\mathcal{H}\to\mathbb{C}$（第一変数に反線形）をもち、ノルム $\lVert\Psi\rVert=\langle\Psi,\Psi\rangle^{1/2}\in\mathbb{R}_{\ge0}$ について完備なもの。

**［ℝ 脱出］** 完備性はすでに $\mathbb{R}$ の完備性（非可算）を要求する。前 Hilbert 空間（内積つき $\mathbb{C}$-ベクトル空間）は可算次元でありうるが、完備化 $\overline{\mathcal{H}_0}$ を取った時点で濃度は $2^{\aleph_0}$ 以上になる。

$\mathcal{H}$ が**可分**（separable）とは、可算稠密部分集合をもつこと。同値に、可算正規直交基底 $(e_n)_{n\in\mathbb{N}}$ をもつこと。Wightman 公理では $\mathcal{H}$ の可分性を要請する（あるいは後述のとおり公理の他の部分から従う）。可分性は、後述の Wigner 分類・直積分分解・von Neumann 環の分類（→ 03）のほとんどすべてで前提として効く。

### 1.2 非有界作用素と定義域

線形作用素 $A$ とは、**組** $(\mathcal{D}(A),A)$ のこと。ここで $\mathcal{D}(A)\subseteq\mathcal{H}$ は線形部分空間（**定義域**）、$A\colon\mathcal{D}(A)\to\mathcal{H}$ は線形写像。定義域を指定しない「作用素」は数学的対象として未定義である。

- $A$ が**稠密定義**とは $\overline{\mathcal{D}(A)}=\mathcal{H}$。
- 稠密定義の $A$ に対し**共役作用素** $A^*$ を、$\mathcal{D}(A^*)=\{\Phi\in\mathcal{H}\mid \exists\Xi\in\mathcal{H},\ \forall\Psi\in\mathcal{D}(A):\langle\Phi,A\Psi\rangle=\langle\Xi,\Psi\rangle\}$、$A^*\Phi:=\Xi$ で定める（$\Xi$ は稠密性より一意）。
- $A$ が**対称**とは $A\subseteq A^*$（すなわち $\mathcal{D}(A)\subseteq\mathcal{D}(A^*)$ かつ両者が $\mathcal{D}(A)$ 上一致）。$A$ が**自己共役**とは $A=A^*$（**定義域まで込めて一致**）。
- **対称と自己共役は別物である。** 対称作用素はスペクトル分解をもたず、$e^{itA}$（$t\in\mathbb{R}$）を定義できない。Stone の定理が使えるのは自己共役の場合に限る。QFT で「エネルギー作用素」「場の作用素」と呼ばれるものについては、常に定義域と自己共役性（あるいは本質的自己共役性）の議論が要る。

**［ℝ 脱出］** スペクトル定理：自己共役 $A$ に対し $\mathbb{R}$ の Borel 集合上の射影値測度 $E^A$ が一意に存在し $A=\int_{\mathbb{R}}\lambda\,dE^A(\lambda)$。ここで Borel 測度・非可算な $\mathbb{R}$ 上の積分が本質的に使われる。

### 1.3 共通稠密不変部分空間（Gårding 領域）

QFT では複数の非有界作用素の積 $\phi(f_1)\phi(f_2)\cdots\phi(f_n)$ を扱う。積が意味をもつためには、各作用素が共通の定義域を保つ必要がある。そこで線形部分空間 $\mathcal{D}\subseteq\mathcal{H}$ で

1. $\overline{\mathcal{D}}=\mathcal{H}$（稠密）、
2. すべての場 $\phi_j$・すべての試験関数 $f$ に対し $\phi_j(f)\mathcal{D}\subseteq\mathcal{D}$、
3. 真空 $\Omega\in\mathcal{D}$、
4. Poincaré 表現で不変 $U(a,A)\mathcal{D}=\mathcal{D}$

を満たすものを固定する。歴史的経緯から **Gårding 領域**（Gårding domain）と呼ばれる。自由場では $\mathcal{D}$ として有限粒子数かつ滑らかな波動関数からなる部分空間が取れる。

### 1.4 Schwartz 空間と緩増加超関数

$d=s+1$ を時空次元とし、$\mathbb{R}^d$ に Minkowski 計量 $\eta=\operatorname{diag}(+1,-1,\dots,-1)$、内積 $x\cdot y=\eta_{\mu\nu}x^\mu y^\nu\in\mathbb{R}$ を入れる。

**Schwartz 空間**
$$
\mathcal{S}(\mathbb{R}^d)=\Bigl\{f\in C^\infty(\mathbb{R}^d,\mathbb{C})\ \Bigm|\ \forall\alpha,\beta\in\mathbb{Z}_{\ge0}^d:\ p_{\alpha\beta}(f):=\sup_{x\in\mathbb{R}^d}\bigl|x^\alpha\partial^\beta f(x)\bigr|<\infty\Bigr\}.
$$
可算族 $(p_{\alpha\beta})_{\alpha,\beta}$ を半ノルムとする Fréchet 空間で、さらに**核型**（nuclear）である。

**緩増加超関数** $\mathcal{S}'(\mathbb{R}^d)$ は $\mathcal{S}(\mathbb{R}^d)$ の連続双対（連続線形汎関数 $T\colon\mathcal{S}(\mathbb{R}^d)\to\mathbb{C}$ の全体）。$T$ が連続であることは、ある $N\in\mathbb{Z}_{\ge0}$ と $C\in\mathbb{R}_{>0}$ が存在して $|T(f)|\le C\sum_{|\alpha|,|\beta|\le N}p_{\alpha\beta}(f)$ が全 $f$ で成り立つことと同値。

**可算性についての注意（重要）**：Hermite 関数系 $(h_\alpha)_{\alpha\in\mathbb{Z}_{\ge0}^d}$（可算個）により、位相同型
$$
\mathcal{S}(\mathbb{R}^d)\ \cong\ s:=\Bigl\{(a_\alpha)_{\alpha\in\mathbb{Z}_{\ge0}^d}\in\mathbb{C}^{\mathbb{Z}_{\ge0}^d}\ \Bigm|\ \forall k\in\mathbb{Z}_{\ge0}:\ \sup_\alpha (1+|\alpha|)^k|a_\alpha|<\infty\Bigr\}
$$
が成り立つ（$f\mapsto(\langle h_\alpha,f\rangle_{L^2})_\alpha$）。対応して $\mathcal{S}'(\mathbb{R}^d)\cong s'$（多項式増大列の空間）。したがって **1 つの緩増加超関数は可算個の複素数（Hermite 係数）で完全に決まり**、その係数は多項式増大という可算個の不等式で特徴づけられる。$\mathcal{S}(\mathbb{R}^d)$ は可分である。

**［ℝ 脱出］** ただし $\mathcal{S}(\mathbb{R}^d)$ の元は $\mathbb{R}^d$（非可算）上の関数であり、半ノルムは非可算個の点にわたる上限、Hermite 展開の収束は $\mathbb{R}$ 上の位相での収束である。「係数が可算」は表示の話であり、位相・完備性は $\mathbb{R}$ に依存する。

**核定理（Schwartz kernel theorem）**：$\mathcal{S}(\mathbb{R}^{d})\hat\otimes\cdots\hat\otimes\mathcal{S}(\mathbb{R}^{d})\cong\mathcal{S}(\mathbb{R}^{dn})$（核型性から従う）。ゆえに $n$ 変数の分離連続な汎関数は $\mathcal{S}'(\mathbb{R}^{dn})$ の元へ一意に延長される。Wightman 関数を「$dn$ 変数の 1 つの超関数」として扱えるのはこの定理による。

### 1.5 作用素値超関数の厳密な定義

**定義**：$\mathcal{H}$、稠密部分空間 $\mathcal{D}\subseteq\mathcal{H}$ が与えられているとする。写像
$$
\phi\colon\mathcal{S}(\mathbb{R}^d)\longrightarrow\{\text{$\mathcal{H}$ 上の線形作用素で定義域が }\mathcal{D}\text{ を含むもの}\},\qquad f\mapsto\phi(f)
$$
が **$\mathcal{D}$ 上の作用素値超関数**であるとは、

1. （定義域）すべての $f\in\mathcal{S}(\mathbb{R}^d)$ について $\mathcal{D}\subseteq\mathcal{D}(\phi(f))$ かつ $\phi(f)\mathcal{D}\subseteq\mathcal{D}$、
2. （線形性）$f\mapsto\phi(f)\Psi\in\mathcal{H}$ が各 $\Psi\in\mathcal{D}$ について線形（$\phi(\lambda f+g)\Psi=\lambda\phi(f)\Psi+\phi(g)\Psi$、$\lambda\in\mathbb{C}$）、
3. （連続性）すべての $\Psi,\Phi\in\mathcal{D}$ について汎関数
$$
\mathcal{S}(\mathbb{R}^d)\ni f\ \longmapsto\ \langle\Psi,\phi(f)\Phi\rangle\in\mathbb{C}
$$
が連続、すなわち $\mathcal{S}'(\mathbb{R}^d)$ の元であること。

**重要な注意**：「点 $x\in\mathbb{R}^d$ における場 $\phi(x)$」は上の定義では**存在しない**。$\phi(x)$ は記号 $\phi(f)=\int_{\mathbb{R}^d}\phi(x)f(x)\,d^dx$ という書き方のための記法にすぎず、数学的対象は $\phi(f)$ の方である（$\phi(x)$ を作用素として定義しようとすると、たとえば $\langle\Omega,\phi(x)^2\Omega\rangle$ が発散する。物理側の慣用表現「場は点で定義されず、smear して初めて作用素になる」は、正確にはこの定義のことを指す）。

なお $\phi(f)$ は一般に非有界であり、$f$ が実数値でも $\phi(f)$ が自己共役であることは公理からは従わない（対称性までしか出ない）。本質的自己共役性は追加の仮定・定理（例：Nelson の解析ベクトル定理）を要する。

---

## 2. Poincaré 群と Wigner 分類

### 2.1 群

- **Lorentz 群** $O(1,s)=\{\Lambda\in GL(d,\mathbb{R})\mid \Lambda^{T}\eta\Lambda=\eta\}$。
- **固有正規直交 Lorentz 群** $\mathcal{L}^\uparrow_+=SO(1,s)^\uparrow$：$\det\Lambda=1$ かつ $\Lambda^0{}_0\ge1$ の連結成分。
- **Poincaré 群** $\mathcal{P}^\uparrow_+=\mathbb{R}^d\rtimes\mathcal{L}^\uparrow_+$、積は $(a_1,\Lambda_1)(a_2,\Lambda_2)=(a_1+\Lambda_1a_2,\Lambda_1\Lambda_2)$。

$d=4$ では $\mathcal{L}^\uparrow_+$ の普遍被覆は $SL(2,\mathbb{C})$ で、被覆写像 $\Lambda\colon SL(2,\mathbb{C})\to\mathcal{L}^\uparrow_+$ は 2 対 1（核 $\{\pm 1\}$）。対応して $\widetilde{\mathcal{P}^\uparrow_+}=\mathrm{ISL}(2,\mathbb{C})=\mathbb{R}^4\rtimes SL(2,\mathbb{C})$。半整数スピン（フェルミオン）を扱うため、公理では $\mathcal{P}^\uparrow_+$ ではなく被覆群 $\mathrm{ISL}(2,\mathbb{C})$ の表現を要請する。

**［ℝ 脱出］** これらの群は非可算（Lie 群）であり、位相・連続性・Haar 測度を用いる。表現の連続性の要請は非可算な群の位相に依存する。ただし連続性を仮定する限り、可算稠密部分群での挙動が全体を決める。

### 2.2 Wigner の分類（確立した定理、Wigner 1939；Mackey による厳密化）

$\mathrm{ISL}(2,\mathbb{C})$ の可分 Hilbert 空間上の既約ユニタリ表現は、Mackey の誘導表現の理論により小群（little group）によって分類される。$d=4$ での分類（スペクトル条件 $\operatorname{spec}P\subseteq\overline{V}_+$ を課した場合）：

| 軌道 | 小群 | ラベル |
|---|---|---|
| $p\cdot p=m^2>0,\ p^0>0$ | $SU(2)$ | 質量 $m\in\mathbb{R}_{>0}$、スピン $s\in\tfrac12\mathbb{Z}_{\ge0}$ |
| $p\cdot p=0,\ p\ne0,\ p^0>0$ | $\widetilde{E(2)}$ | ヘリシティ $h\in\tfrac12\mathbb{Z}$（有限次元表現）／連続スピン（無限次元表現） |
| $p=0$ | $SL(2,\mathbb{C})$ | 真空（自明表現）ほか |

**［ℝ 脱出］** 質量ラベル $m\in\mathbb{R}_{>0}$ は**非可算**な連続パラメータであり、既約表現の同型類の集合そのものが非可算になる。一方スピン／ヘリシティは可算（$\tfrac12\mathbb{Z}$）である。可分性を落とすと Mackey の理論は破綻する。

---

## 3. Wightman 公理 W0–W5

以下、$d=s+1$、場は有限個 $\phi_1,\dots,\phi_N$（Lorentz 添字・スピノル添字をまとめて $j\in\{1,\dots,N\}$ と書く）とする。

### (W0) Hilbert 空間と Poincaré 表現

可分複素 Hilbert 空間 $\mathcal{H}$ と、その上の強連続ユニタリ表現
$$
U\colon \mathrm{ISL}(2,\mathbb{C})\longrightarrow \mathcal{U}(\mathcal{H}),\qquad (a,A)\mapsto U(a,A)
$$
が与えられている（$\mathcal{U}(\mathcal{H})$ はユニタリ作用素の群）。強連続とは、各 $\Psi\in\mathcal{H}$ について $(a,A)\mapsto U(a,A)\Psi\in\mathcal{H}$ がノルム連続なこと。

### (W1) スペクトル条件

平行移動部分群 $\{U(a,1)\mid a\in\mathbb{R}^d\}$ は $d$ 個の互いに可換な自己共役作用素 $P^0,\dots,P^{d-1}$（**エネルギー運動量作用素**）を生成する。すなわち SNAG 定理（Stone–Naimark–Ambrose–Godement）により $\mathbb{R}^d$ の Borel 集合上の射影値測度 $E$ が一意に存在して
$$
U(a,1)=\int_{\mathbb{R}^d}e^{i\,a\cdot p}\,dE(p),\qquad a\in\mathbb{R}^d .
$$
**スペクトル条件**とは、$E$ の台が閉前方光錐
$$
\overline{V}_+=\{p\in\mathbb{R}^d\mid p\cdot p\ge0,\ p^0\ge0\}
$$
に含まれること：$\operatorname{supp}E\subseteq\overline{V}_+$。同値に、$E(\mathbb{R}^d\setminus\overline{V}_+)=0$。

**［ℝ 脱出］** 射影値測度・Borel 集合・台という概念はすべて $\mathbb{R}^d$ の位相と測度論に依存する。スペクトル条件は「非可算集合 $\mathbb{R}^d$ の閉部分集合への台の局在」という形でしか述べられない。ただし後述のとおり、$W_n$ の Fourier 変換が錐の外の試験関数を消すという形に書き直すと、可算稠密族での検証に帰着する。

### (W2) 真空

$U$ 不変なベクトル $\Omega\in\mathcal{H}$、$\lVert\Omega\rVert=1$ が存在する：
$$
U(a,A)\Omega=\Omega\qquad\text{for all }(a,A)\in \mathrm{ISL}(2,\mathbb{C}).
$$
さらに $\Omega$ は**位相を除いて一意**、すなわち $\{\Psi\in\mathcal{H}\mid U(a,1)\Psi=\Psi\ \forall a\}=\mathbb{C}\Omega$（1 次元）。同値に $E(\{0\})$ は 1 次元射影。

一意性はクラスター分解性（§4 の (P6)）と同値であり、「真空が一意でない」場合はその分解＝相の分解に対応する。

### (W3) 場が作用素値超関数であり共通稠密領域をもつ

稠密線形部分空間 $\mathcal{D}\subseteq\mathcal{H}$（Gårding 領域、§1.3）と、$j=1,\dots,N$ に対する作用素値超関数
$$
\phi_j\colon\mathcal{S}(\mathbb{R}^d)\to\{\text{作用素}\},\qquad \mathcal{D}\subseteq\mathcal{D}(\phi_j(f)),\quad \phi_j(f)\mathcal{D}\subseteq\mathcal{D}
$$
が与えられ、$\Omega\in\mathcal{D}$、$U(a,A)\mathcal{D}=\mathcal{D}$。**共役**については、各 $j$ に対し $j^*$ が定まって
$$
\langle\phi_j(f)\Psi,\Phi\rangle=\langle\Psi,\phi_{j^*}(\bar f)\Phi\rangle\qquad(\Psi,\Phi\in\mathcal{D})
$$
が成り立つ。さらに**真空の巡回性**：
$$
\mathcal{D}_0:=\operatorname{span}_{\mathbb{C}}\bigl\{\phi_{j_1}(f_1)\cdots\phi_{j_n}(f_n)\Omega\ \bigm|\ n\in\mathbb{Z}_{\ge0},\ j_k,\ f_k\in\mathcal{S}(\mathbb{R}^d)\bigr\}
$$
が $\mathcal{H}$ で稠密（$n=0$ の項は $\Omega$）。しばしば $\mathcal{D}=\mathcal{D}_0$ と取る。

**可分性の由来**：$\mathcal{S}(\mathbb{R}^d)$ は可分（§1.4）だから、可算稠密集合 $\{f^{(m)}\}_{m\in\mathbb{N}}$ の有限個の積からなる可算集合が $\mathcal{D}_0$ で稠密。ゆえに **(W3) の巡回性から $\mathcal{H}$ の可分性が従う**。(W0) で可分性を独立に課さなくてよいのはこのためである。

### (W4) 共変性

すべての $(a,A)\in \mathrm{ISL}(2,\mathbb{C})$、$f\in\mathcal{S}(\mathbb{R}^d)$、$\Psi\in\mathcal{D}$ に対し
$$
U(a,A)\,\phi_j(f)\,U(a,A)^{-1}\Psi=\sum_{k=1}^{N}S_{jk}\bigl(A^{-1}\bigr)\,\phi_k\bigl(\{a,A\}f\bigr)\Psi,
$$
ここで $\bigl(\{a,A\}f\bigr)(x)=f\bigl(\Lambda(A)^{-1}(x-a)\bigr)$、$S\colon SL(2,\mathbb{C})\to GL(N,\mathbb{C})$ は有限次元表現（場の多重項の Lorentz 変換則）。$S$ は**ユニタリでなくてよい**（$SL(2,\mathbb{C})$ は非コンパクトなので有限次元ユニタリ既約表現は自明のみ）。ここが「場」と「状態」の非対称性の出所である。

### (W5) 局所可換性（Einstein 因果性）

$f,g\in\mathcal{S}(\mathbb{R}^d)$ の台が互いに**空間的に分離**している、すなわち
$$
\forall x\in\operatorname{supp}f,\ \forall y\in\operatorname{supp}g:\quad (x-y)\cdot(x-y)<0
$$
のとき、$\mathcal{D}$ 上で
$$
\bigl[\phi_j(f),\phi_k(g)\bigr]_{\mp}:=\phi_j(f)\phi_k(g)\mp\phi_k(g)\phi_j(f)=0 .
$$
符号は場の対（Bose 型なら交換子 $-$、Fermi 型なら反交換子 $+$）ごとに定める。どちらを取るかは公理としては選択だが、スピン統計定理（§6）により $S$ が整数スピンなら交換子、半整数スピンなら反交換子でなければならないことが従う。

---

## 4. Wightman 関数とその性質

### 4.1 定義

$n\in\mathbb{Z}_{\ge1}$、添字 $j_1,\dots,j_n$ に対し
$$
\mathcal{W}^{(n)}_{j_1\cdots j_n}(f_1,\dots,f_n):=\bigl\langle\Omega,\ \phi_{j_1}(f_1)\cdots\phi_{j_n}(f_n)\Omega\bigr\rangle\in\mathbb{C}.
$$
これは各変数について分離連続な多重線形汎関数だから、核定理（§1.4）により一意に
$$
W^{(n)}_{j_1\cdots j_n}\in\mathcal{S}'(\mathbb{R}^{dn})
$$
へ延長される。$W^{(0)}:=1$。以下、添字を省略して $W_n$ と書く。

### 4.2 満たす性質（公理 W0–W5 の帰結）

- **(P1) 超関数性**：$W_n\in\mathcal{S}'(\mathbb{R}^{dn})$。
- **(P2) Poincaré 共変性**：$W_n(\{a,A\}x_1,\dots)=\sum S(A)\cdots W_n(x_1,\dots)$（(W4) より）。特にスカラー場では $W_n$ は平行移動不変で、差変数
$$
\xi_k:=x_k-x_{k+1}\in\mathbb{R}^d\quad(k=1,\dots,n-1)
$$
のみの関数 $\widehat{W}_{n-1}\in\mathcal{S}'(\mathbb{R}^{d(n-1)})$ に落ちる。
- **(P3) エルミート性**：$\overline{W_n(x_1,\dots,x_n)}=W_n(x_n,\dots,x_1)$（適切な添字の共役つき）。
- **(P4) スペクトル条件（台条件）**：$\widehat{W}_{n-1}$ の Fourier 変換 $\widetilde{W}_{n-1}(q_1,\dots,q_{n-1})$ の台が
$$
\operatorname{supp}\widetilde{W}_{n-1}\subseteq\overline{V}_+\times\cdots\times\overline{V}_+\quad((n-1)\text{ 個})
$$
に含まれる。これは (W1) の射影値測度の台条件を、超関数の言葉に翻訳したもの。**スペクトル条件が「作用素の話」から「超関数の台の話」へ完全に移し替えられる点が、Wightman 定式化の要である。**
- **(P5) 正定値性**：終端有限列 $\underline f=(f_0,f_1,f_2,\dots)$（$f_0\in\mathbb{C}$、$f_n\in\mathcal{S}(\mathbb{R}^{dn})$、有限個を除き $0$）に対し
$$
\sum_{n,m\ge0} W_{n+m}\bigl(\overline{f_n}^{\,\theta}\otimes f_m\bigr)\ \ge\ 0,
$$
ここで $\overline{f_n}^{\,\theta}(x_1,\dots,x_n):=\overline{f_n(x_n,\dots,x_1)}$。これは $\bigl\lVert\sum_n\phi(f_n)\Omega\bigr\rVert^2\ge0$ の言い換えである。
- **(P6) 局所可換性**：$(x_k-x_{k+1})^2<0$ なる領域上で
$$
W_n(\dots,x_k,x_{k+1},\dots)=\pm\,W_n(\dots,x_{k+1},x_k,\dots).
$$
- **(P7) クラスター分解**：空間的ベクトル $a\in\mathbb{R}^d$（$a\cdot a<0$）と $\lambda\in\mathbb{R}$、$\lambda\to\infty$ で
$$
W_n(x_1,\dots,x_k,\ x_{k+1}+\lambda a,\dots,x_n+\lambda a)\ \longrightarrow\ W_k(x_1,\dots,x_k)\,W_{n-k}(x_{k+1},\dots,x_n)
$$
（$\mathcal{S}'$ の意味で）。真空の一意性 (W2) と同値。

**［ℝ 脱出］** (P7) の極限、(P4) の台条件、(P5) の実数不等式はいずれも $\mathbb{R}$ 上の解析を使う。

### 4.3 可算性についての観察（本ノートの整理であって定理ではない）

Hermite 展開（§1.4）により $W_n$ は可算個の複素数
$$
c^{(n)}_{\alpha_1\cdots\alpha_n}:=W_n(h_{\alpha_1}\otimes\cdots\otimes h_{\alpha_n})\in\mathbb{C},\qquad \alpha_i\in\mathbb{Z}_{\ge0}^d
$$
で完全に決まり、(P1) は $|c^{(n)}_{\vec\alpha}|\le C_n(1+|\vec\alpha|)^{N_n}$ という**可算個の不等式**、(P5) は可算添字集合 $\coprod_n(\mathbb{Z}_{\ge0}^d)^n$ 上の Hermite 行列 $(c^{(n+m)})$ の半正定値性（＝すべての有限主小行列式が $\ge0$、これも可算個の条件）、(P4)・(P6) は $\mathcal{S}$ の可分性により可算稠密族に対する消滅条件、(P2) は $\mathrm{ISL}(2,\mathbb{C})$ の可算稠密部分群での不変性＋連続性、と書き直せる。

したがって **「Wightman QFT のデータ」自体は可算個の複素数である**。しかし条件の意味づけ（連続性・台・極限・半正定値性の実数不等式）は $\mathbb{R}$ の完備性に依存しており、可算データだけで閉じた理論にはならない。この境界がどこにあるかは、本リポジトリの中心的関心（可算／非可算の分別）から見て 04 章の Euclid 化・05 章の構成的手法と併せて追うべき点である。

---

## 5. Wightman 再構成定理

> **定理（Wightman 再構成定理、Wightman 1956；確立した定理）**
> $(W_n)_{n\ge0}$、$W_n\in\mathcal{S}'(\mathbb{R}^{dn})$、$W_0=1$ が (P1)–(P7) を満たすとする。このとき Wightman 公理 W0–W5 を満たす四つ組
> $$(\mathcal{H},\ U,\ \Omega,\ (\phi_j)_j)$$
> が存在し、その Wightman 関数がちょうど与えられた $(W_n)$ に一致する。さらにこの四つ組は**ユニタリ同値を除いて一意**：もう一つの四つ組 $(\mathcal{H}',U',\Omega',\phi')$ が同じ $(W_n)$ を与えるなら、ユニタリ $V\colon\mathcal{H}\to\mathcal{H}'$ が存在して $V\Omega=\Omega'$、$VU(a,A)V^{-1}=U'(a,A)$、$V\phi_j(f)V^{-1}=\phi'_j(f)$（$\mathcal{D}_0$ 上）。

**構成（GNS 型）**：

1. **Borchers–Uhlmann 代数**（テンソル代数）
$$
\underline{\mathcal{S}}:=\bigoplus_{n\ge0}^{\text{代数的}}\mathcal{S}(\mathbb{R}^{dn})
$$
（代数的直和＝有限個を除き $0$ の列全体。**この直和は可算個の成分にわたる代数的直和であり、完備化は取らない**）。積はテンソル積 $(\underline f\,\underline g)_n=\sum_{k}f_k\otimes g_{n-k}$、対合は $(\underline f^*)_n(x_1,\dots,x_n)=\overline{f_n(x_n,\dots,x_1)}$。これは単位的 $*$-代数。
2. $(W_n)$ は線形汎関数 $\omega\colon\underline{\mathcal{S}}\to\mathbb{C}$, $\omega(\underline f)=\sum_n W_n(f_n)$ を定める。(P5) は $\omega(\underline f^*\underline f)\ge0$、すなわち $\omega$ が**状態**（正値汎関数）であることに他ならない。
3. 半内積 $\langle\underline f,\underline g\rangle:=\omega(\underline f^*\underline g)\in\mathbb{C}$ を入れ、零空間 $\mathcal{N}=\{\underline f\mid\omega(\underline f^*\underline f)=0\}$（Cauchy–Schwarz より左イデアル）で商をとり、**完備化**して $\mathcal{H}:=\overline{\underline{\mathcal{S}}/\mathcal{N}}$。
   **［ℝ 脱出］** ここで初めて完備化（非可算集合の生成）が起きる。商までは可算生成の $\mathbb{C}$-ベクトル空間で済む。
4. $\Omega:=[(1,0,0,\dots)]$、$\phi_j(f)[\underline g]:=[(0,f,0,\dots)\cdot\underline g]$（左乗法）。$\mathcal{D}_0:=\underline{\mathcal{S}}/\mathcal{N}$ が Gårding 領域。
5. $U(a,A)$ は $\underline{\mathcal{S}}$ 上の Poincaré 作用から誘導。(P2) が内積を保つことを保証し、$\mathcal{H}$ 上のユニタリへ延長される。強連続性は $W_n$ の超関数としての連続性から従う。
6. (P4) から (W1)、(P7) から (W2)、(P6) から (W5) が出る。

**この定理の意味**：Wightman 公理系は「Hilbert 空間・作用素」という装置を要求しているように見えるが、再構成定理により、**装置は超関数の族から自動的に生成される付随物**であることが分かる。したがって次のように言い切ってよい。

> **QFT（Wightman 流）とは、(P1)–(P7) を満たす緩増加超関数の族 $(W_n)_{n\ge0}$ のことである。**

Hilbert 空間・場の作用素・真空は、この族の GNS 表現として一意に決まる二次的な対象である。

---

## 6. 公理からの帰結

すべて**確立した定理**である（証明は Streater–Wightman、Jost、Bogoliubov らによる）。

### 6.1 Reeh–Schlieder 定理（Reeh–Schlieder 1961）

$\mathcal{O}\subseteq\mathbb{R}^d$ を空でない開集合とする。$\phi_j(f)$（$\operatorname{supp}f\subseteq\mathcal{O}$）の多項式を $\Omega$ に作用させて得るベクトルの張る空間は $\mathcal{H}$ で**稠密**。

証明の要点：スペクトル条件から $\mathbb{R}^d\ni a\mapsto\langle\Psi,\phi(f_1)U(a,1)\phi(f_2)\cdots\Omega\rangle$ が管状領域へ正則に延び、実軸上の開集合で消えれば一致の定理により全体で消える。**［ℝ 脱出］** 正則関数の一致の定理＝複素解析（非可算）に本質的に依存する。可算的な議論では置き換えられない。

帰結として、$\Omega$ は任意の局所領域の代数に対し巡回的かつ分離的（→ 03 章、Tomita–Takesaki の適用条件）。真空は任意の有限領域に対して「純粋でない」ことになり、物理側の慣用表現「真空は絡み合っている」はこの分離性・後述の型 III 性を指す。

### 6.2 PCT 定理（Jost 1957）

$d$ が偶数（特に $d=4$）のとき、W0–W5 を満たす理論には反ユニタリ作用素 $\Theta\colon\mathcal{H}\to\mathcal{H}$ が存在して $\Theta\Omega=\Omega$、$\Theta U(a,A)\Theta^{-1}=U(-a,\bar A)$、および場に対する適切な変換則が成り立つ。Jost による定式化では、$\Theta$ の存在は**弱局所可換性**（Jost 点における $W_n$ の順序反転対称性）と同値。

鍵は $L_+(\mathbb{C})$（複素 Lorentz 群）が**連結**で $-\mathbf{1}\in L_+(\mathbb{C})$ を含むこと（§7）。

### 6.3 スピン統計定理（Lüders–Zumino 1958、Burgoyne 1958）

$d=4$、W0–W5 のもとで、整数スピン場が反交換関係を課されると $\phi=0$、半整数スピン場が交換関係を課されると $\phi=0$。したがって非自明な理論では「整数スピン＝交換子、半整数スピン＝反交換子」以外あり得ない。

### 6.4 Haag の定理（Haag 1955、Hall–Wightman 1957）

二つの Wightman 場 $\phi^{(1)},\phi^{(2)}$（それぞれ一意な真空をもつ）が、ある時刻 $t$ での場と共役運動量においてユニタリ $V$ で結ばれ、$V$ が空間並進・回転の表現を intertwine するとする。このとき $n\le4$ の Wightman 関数が一致する。特に $\phi^{(2)}$ が質量 $m$ の自由場なら、$\phi^{(1)}$ の 2 点・4 点関数は自由場のそれに一致する。

**意味**：摂動論で用いられる「相互作用描像」（自由場と相互作用場を同一 Hilbert 空間上のユニタリで結ぶ）は、無限体積の Wightman 理論では**存在しない**。摂動計算が形式的級数としてしか意味をもたない構造的理由の一つ。

### 6.5 Jost–Lehmann–Dyson 表現（Jost–Lehmann 1957、Dyson 1958）

局所可換性とスペクトル条件のみから、交換子の行列要素の Fourier 変換が、ある補助的な測度による積分表示をもつ。分散関係（散乱振幅の解析性）の証明の出発点であり、Bros–Epstein–Glaser による散乱振幅の解析性の厳密証明に用いられる。

### 6.6 Haag–Ruelle 散乱理論（Haag 1958、Ruelle 1962）

質量スペクトルに孤立した固有値（質量殻）があれば、W0–W5 から漸近状態 $\Psi^{\mathrm{in}},\Psi^{\mathrm{out}}$ と Møller 作用素が構成でき、$S$ 行列が定義される。漸近完全性（$\mathcal{H}^{\mathrm{in}}=\mathcal{H}^{\mathrm{out}}=\mathcal{H}$）は公理からは従わず、**追加の仮定**である。

---

## 7. 解析接続：管状領域から Euclid 点へ

### 7.1 前方管状領域

(P4) の台条件と Laplace 変換により、$\widehat{W}_{n-1}$ は
$$
\mathcal{T}_{n-1}:=\bigl\{\zeta=(\zeta_1,\dots,\zeta_{n-1})\in\mathbb{C}^{d(n-1)}\ \bigm|\ \operatorname{Im}\zeta_k\in V_+\ (k=1,\dots,n-1)\bigr\}
$$
（**前方管状領域**）上の正則関数 $\mathbf{W}_{n-1}$ の境界値（$\operatorname{Im}\zeta\to0$、$\mathcal{S}'$ の意味）として表される。

### 7.2 Bargmann–Hall–Wightman 定理（確立した定理、1957）

$\mathbf{W}_{n-1}$ は Lorentz 不変性により**拡大管状領域**
$$
\mathcal{T}'_{n-1}:=\bigcup_{\Lambda\in L_+(\mathbb{C})}\Lambda\,\mathcal{T}_{n-1}
$$
（$L_+(\mathbb{C})=\{\Lambda\in SO(d,\mathbb{C})\mid\det\Lambda=1\}$、これは**連結**）へ一意正則に延長される。

**Jost 点**：$\mathcal{T}'_{n-1}$ に含まれる実点の全体は
$$
\Bigl\{(\xi_1,\dots,\xi_{n-1})\in\mathbb{R}^{d(n-1)}\ \Bigm|\ \sum_k\lambda_k\xi_k\ \text{が空間的}\ \ \forall\lambda_k\ge0,\ \textstyle\sum\lambda_k>0\Bigr\}
$$
（Jost 1957）。$-\mathbf{1}\in L_+(\mathbb{C})$ が連結成分に入ることが PCT 定理（§6.2）の源泉である。

### 7.3 Euclid 点への到達

局所可換性 (P6) により、変数の置換で得られる管状領域どうしが Jost 点の実近傍で貼り合わさり（edge-of-the-wedge 定理、Epstein）、正則領域は「置換された拡大管状領域」の和集合＋その正則包へ広がる。この領域は**Euclid 点**
$$
\zeta_k=(i\tau_k,\ \vec{x}_k),\qquad \tau_k\in\mathbb{R},\ \tau_1>\tau_2>\dots>\tau_n
$$
を含む。そこでの値が **Schwinger 関数** $S_n$ であり、Osterwalder–Schrader 公理系とその逆写像（→ 04 章）へ接続する。

**［ℝ 脱出］** 本節はすべて多変数複素解析（正則性・一致の定理・正則包）であり、$\mathbb{C}^{d(n-1)}$（非可算）上の議論に完全に依存する。Wightman 定式化の技術的核心はここに集中しており、可算的な代替は知られていない。

---

## 8. 数学的対象としての正体（まとめ）

- **Wightman QFT の正体** ＝ 緩増加超関数の族 $(W_n)_{n\ge0}$, $W_n\in\mathcal{S}'(\mathbb{R}^{dn})$ で、(P1) 超関数性・(P2) Poincaré 共変性・(P3) エルミート性・(P4) Fourier 台の前方光錐条件・(P5) 正定値性・(P6) 局所置換対称性・(P7) クラスター分解を満たすもの。再構成定理により、これと $(\mathcal{H},U,\Omega,\phi)$ の同型類とは 1 対 1 に対応する。
- **その族の集合としての位置**：$(W_n)$ の全体は $\prod_{n\ge0}\mathcal{S}'(\mathbb{R}^{dn})$ の部分集合。各 $W_n$ は Hermite 係数により可算個の複素数で表示できるので、1 つの理論のデータは可算である。しかし条件 (P1)–(P7) の意味づけと再構成の完備化は $\mathbb{R}$ の完備性・複素解析に依存する。
- **場の作用素は二次的**：$\phi(f)$ は非有界かつ定義域つきの作用素であり、公理からは自己共役性すら出ない。作用素論的な扱いにくさは、$C^*$ 代数へ移る動機（→ 03 章）となる。
- **可算・非可算の分別（本リポジトリの関心に沿って）**：
  - 可算側：試験関数空間の Hermite 表示、Borchers 代数の代数的直和、正定値性の有限主小行列式条件、$\mathcal{H}$ の可分性。
  - 非可算側 **［ℝ 脱出］**：Hilbert 空間の完備化、スペクトル定理と射影値測度、Wigner 分類の質量パラメータ $m\in\mathbb{R}_{>0}$、管状領域への解析接続と一致の定理（Reeh–Schlieder・PCT の証明の核）、クラスター極限。

---

## 9. 未解決・限界

1. **4 次元での非自明な例が存在しない（未解決）**：$d=4$ で W0–W5 を満たし、$S$ 行列が自明でない模型は 1 つも構成されていない。既知の例は自由場・一般化自由場・その多項式に限られる。
2. **Yang–Mills 質量ギャップ問題（未解決、Clay 懸賞問題）**：$\mathbb{R}^4$ 上のコンパクト単純ゲージ群 $G$ に対する量子 Yang–Mills 理論を、Wightman 公理（もしくは Osterwalder–Schrader／Haag–Kastler 公理）を満たすものとして構成し、$\operatorname{spec}(P)\cap\overline{V}_+\setminus\{0\}\subseteq\{p\mid p\cdot p\ge\Delta^2\}$ なる $\Delta\in\mathbb{R}_{>0}$ の存在を示せ、という形の問題。すなわち「Wightman 理論の存在」がそのまま懸賞問題になっている。
3. **低次元の成功例**：$P(\phi)_2$（Glimm–Jaffe、Nelson、Guerra–Rosen–Simon）、$\phi^4_3$（Glimm–Jaffe、Feldman–Osterwalder、Magnen–Sénéor）、Yukawa$_2$、Sine-Gordon$_2$ などは Wightman 公理（すべてではないが主要部分）を満たすことが証明されている。構成は Euclid 側（→ 04 章）で行い、Osterwalder–Schrader により Minkowski へ戻す。
4. **ゲージ理論には不向き（構造的限界）**：ゲージ固定した場（例：共変ゲージの光子場 $A_\mu$）は正定値な内積をもつ Hilbert 空間上に実現できない。Gupta–Bleuler／BRST の枠組みは不定計量（Krein 空間）を用い、物理的部分空間は BRST コホモロジーとして取り出される。この操作は (W0) の正定値性そのものを一時的に放棄するので、Wightman 公理系の枠外である。可観測量だけに限れば正定値性が回復するというのが期待だが、非摂動的な一般定理はない（未解決）。
5. **漸近完全性**：公理から導けない（§6.6）。
6. **場の自己共役性・可換性の技術的問題**：$\phi(f)$ の本質的自己共役性、異なる時刻の場の可換性（time-slice 性質）は公理には含まれず、模型ごとに示す必要がある。
7. **本ノートで文献確認を要する点**：Haag の定理の「$n\le4$ で一致」という形の主張は文献によって仮定の置き方（時刻固定の共役運動量の扱い、$V$ が intertwine する部分群の指定）が異なる。Streater–Wightman の定式化に合わせて記述したが、精密な仮定は原典で確認すべきである。

---

## 主要文献

- A. S. Wightman, "Quantum field theory in terms of vacuum expectation values", *Phys. Rev.* **101** (1956) 860. — 再構成定理の原典。
- R. F. Streater, A. S. Wightman, *PCT, Spin and Statistics, and All That*, Benjamin (1964); Princeton (2000). — 標準教科書。公理・再構成・PCT・スピン統計・Haag の定理。
- N. N. Bogoliubov, A. A. Logunov, A. I. Oksak, I. T. Todorov, *General Principles of Quantum Field Theory*, Kluwer (1990). — 解析接続・管状領域の詳細。
- R. Jost, *The General Theory of Quantized Fields*, AMS (1965). — Jost 点、PCT。
- E. P. Wigner, "On unitary representations of the inhomogeneous Lorentz group", *Ann. Math.* **40** (1939) 149. — 既約表現の分類。
- G. W. Mackey, *Induced Representations of Groups and Quantum Mechanics*, Benjamin (1968). — Wigner 分類の厳密化。
- H. Reeh, S. Schlieder, "Bemerkungen zur Unitäräquivalenz von Lorentzinvarianten Feldern", *Nuovo Cimento* **22** (1961) 1051.
- R. Haag, "On quantum field theories", *Danske Vid. Selsk. Mat.-Fys. Medd.* **29** (1955) 12. — Haag の定理。
- D. Hall, A. S. Wightman, "A theorem on invariant analytic functions with applications to relativistic quantum field theory", *Danske Vid. Selsk. Mat.-Fys. Medd.* **31** (1957) 5. — BHW 定理。
- R. Jost, "Eine Bemerkung zum CTP-Theorem", *Helv. Phys. Acta* **30** (1957) 409.
- N. Burgoyne, "On the connection of spin with statistics", *Nuovo Cimento* **8** (1958) 607; G. Lüders, B. Zumino, *Phys. Rev.* **110** (1958) 1450.
- M. Jost, H. Lehmann, *Nuovo Cimento* **5** (1957) 1598; F. J. Dyson, *Phys. Rev.* **110** (1958) 1460. — JLD 表現。
- J. Glimm, A. Jaffe, *Quantum Physics: A Functional Integral Point of View*, 2nd ed., Springer (1987). — 低次元での構成、Wightman/OS 公理の検証。
- M. Reed, B. Simon, *Methods of Modern Mathematical Physics* I–II, Academic Press (1975/1980). — 非有界作用素・スペクトル定理・Schwartz 空間・核定理。
- A. Jaffe, E. Witten, "Quantum Yang–Mills theory", Clay Mathematics Institute Millennium Problem description (2000).
