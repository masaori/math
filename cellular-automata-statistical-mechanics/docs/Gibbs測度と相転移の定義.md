# Gibbs 測度と相転移の定義

## この文書の書き方の規律（先に読む）

**この文書は定義と定理だけを書く。解釈・見通し・「示唆的である」の類を書かない。**
仮説を書きたくなったら [`ideas/`](ideas/) へ置き、この文書からは参照しない。

理由を明記しておく。**このリポジトリは物理を論じる場ではない。**
可算の立場から、物理に役立つ可能性のある数学を探すのが目的である。
したがって、**物理学者になら通じる程度の抽象度で書かれた文章には、ここでは価値がない。**
「相転移とは秩序が生じることである」「臨界点では相関長が発散する」といった言い方は、
物理の文脈では正しく機能するが、ここでは何も定めていないのと同じである。
記号がどの集合の元か、演算がどう定義されるか、極限がどの位相での収束か、
$\mathbb{R}$ をどこで使ったかが書かれていない主張は、**このリポジトリでは主張として成立しない。**

**未確認のものは「要一次文献確認」と明記し、確認済みのように書かない。**
以下の定理はすべて二次情報（教科書・レビュー・検索）に基づく。原論文で確認したものはない。

---

## 舞台と配位空間

**定義（頂点集合）** $V:=\mathbb{Z}^d$（$d\in\mathbb{N}_{>0}$ は固定）。$V$ は**可算集合**である。
辺集合 $E_V:=\{\{i,j\}\subset V: |i-j|_1=1\}$ を入れてグラフと見る。

**定義（1 点の状態集合）** $S:=\{-1,+1\}$。**有限集合**である。

**定義（配位空間）**
$$\Omega:=S^{V}=\{\sigma\mid \sigma:V\to S\ \text{は写像}\}.$$

> **$\mathbb{R}$ 脱出（その 1・濃度）** $|\Omega|=2^{\aleph_0}$ であり、$\Omega$ は**非可算**である。
> これは有限箱上の配位の**逆極限** $\Omega=\varprojlim_{\Lambda}S^{\Lambda}$（$\Lambda$ は有限部分集合）を
> 取ったことの帰結である。有限台配位に制限すれば可算に留まるが、以下の理論は $\Omega$ 全体を使う。
> 舞台のカタログの中心原理（順極限側か逆極限側か）で言えば、**ここで逆極限側を選んでいる。**

**定義（位相）** $S$ に離散位相を入れ、$\Omega$ に直積位相を入れる。
Tychonoff の定理により $\Omega$ はコンパクト。可算積なので距離化可能で、全不連結。

**定義（筒集合）** 有限部分集合 $\Lambda\subset V$ と $\zeta\in S^{\Lambda}$ に対し
$$[\zeta]:=\{\sigma\in\Omega\mid \sigma|_{\Lambda}=\zeta\}.$$
筒集合の全体 $\mathcal{C}:=\{[\zeta]\mid \Lambda\subset V\ \text{有限},\ \zeta\in S^{\Lambda}\}$ は
**可算集合**である（$V$ の有限部分集合は可算個、各 $S^\Lambda$ は有限）。

**定義（$\sigma$ 加法族）** $\mathcal{F}:=\sigma(\mathcal{C})$。これは直積 $\sigma$ 加法族であり、
上の位相の Borel $\sigma$ 加法族と一致する。
部分集合 $\Delta\subseteq V$ に対し $\mathcal{F}_{\Delta}:=\sigma(\{\sigma\mapsto\sigma_i\mid i\in\Delta\})$。
$\Delta$ が有限なら $\mathcal{F}_\Delta$ は**有限**な $\sigma$ 加法族である。

**命題（測度を決めるデータは可算個）** $\mathcal{C}$ は $\pi$ 系で $\sigma(\mathcal{C})=\mathcal{F}$ だから、
Dynkin の一意性定理により、$(\Omega,\mathcal{F})$ 上の確率測度は
**$\mathcal{C}$ 上の値によって一意に定まる**。$\mathcal{C}$ は可算集合である。

> **$\mathbb{R}$ 脱出（その 2・値域）** 上の命題により、確率測度は
> **可算集合 $\mathcal{C}$ から $[0,1]$ への写像**として表せる。
> **添字集合は可算であり、非可算なのは値域 $[0,1]\subset\mathbb{R}$ の側だけである。**
> これは事実の記述であって、可算側で扱えるという主張ではない。

---

## 相互作用と有限体積の Gibbs 分布

**定義（相互作用）** 相互作用とは、$V$ の有限部分集合 $A$ で添字づけられた族
$\Phi=(\Phi_A)_A$ であって、各 $\Phi_A:\Omega\to\mathbb{R}$ が $\mathcal{F}_A$ 可測なもの。
以下 **Ising 相互作用**を固定する。$J,h\in\mathbb{R}$ を定数として
$$\Phi_{\{i,j\}}(\sigma)=-J\,\sigma_i\sigma_j\ (\{i,j\}\in E_V),\qquad
\Phi_{\{i\}}(\sigma)=-h\,\sigma_i,\qquad \text{他の }A\text{ では }\Phi_A=0.$$
これは**有限レンジ**（$\Phi_A\ne0$ なら $\mathrm{diam}(A)\le1$）である。

> **$\mathbb{R}$ 脱出（その 3・パラメータ）** $J,h$ および逆温度 $\beta$ を $\mathbb{R}$ の元として置いた。
> $\mathbb{Q}$ に制限することはできるが、次に現れる Boltzmann 重み $e^{-\beta H}$ は
> $\beta,J\in\mathbb{Q}\setminus\{0\}$ でも超越数である。
> 姉妹プロジェクト `exact-solution-of-2d-ising-model-lambda/` が
> $x=e^{-2\beta J}$ を**不定元**として扱い代入を後回しにするのは、この脱出を隔離するためである。

**定義（有限体積の Hamiltonian）** 有限 $\Lambda\subset V$ と $\sigma\in\Omega$ に対し
$$H_\Lambda(\sigma):=\sum_{A:\,A\cap\Lambda\ne\emptyset}\Phi_A(\sigma).$$
有限レンジなので**和は有限項**であり、収束の議論を要しない。
$H_\Lambda(\sigma)$ は $\Lambda$ の内部だけでなく境界の外側の値にも依存する。

**記法（貼り合わせ）** $\zeta\in S^{\Lambda}$、$\eta\in\Omega$ に対し、$\zeta\eta_{\Lambda^c}\in\Omega$ を
$\Lambda$ 上で $\zeta$、$\Lambda^c:=V\setminus\Lambda$ 上で $\eta$ に一致する配位とする。

**定義（有限体積 Gibbs 分布）** 有限 $\Lambda$、境界条件 $\eta\in\Omega$、$\beta\in\mathbb{R}_{>0}$ に対し
$$Z_\Lambda^\eta:=\sum_{\zeta\in S^\Lambda}e^{-\beta H_\Lambda(\zeta\eta_{\Lambda^c})}\in\mathbb{R}_{>0},
\qquad
\mu_\Lambda^\eta:=\frac{1}{Z_\Lambda^\eta}\sum_{\zeta\in S^\Lambda}
e^{-\beta H_\Lambda(\zeta\eta_{\Lambda^c})}\,\delta_{\zeta\eta_{\Lambda^c}} .$$
$S^\Lambda$ は有限集合で各項は正なので $Z_\Lambda^\eta>0$ であり、
$\mu_\Lambda^\eta$ は $(\Omega,\mathcal{F})$ 上の確率測度として**式によって一意に定まる**。

> **有限体積では一意性の問題は存在しない。**
> $(\Lambda,\eta)$ を与えるごとに測度が一つ定まる。一意性が問題になるのは以下の無限体積だけである。

**定義（Gibbs 仕様）** $\gamma=(\gamma_\Lambda)_{\Lambda\text{ 有限}}$ を
$\gamma_\Lambda(B\mid\eta):=\mu_\Lambda^\eta(B)$（$B\in\mathcal{F}$、$\eta\in\Omega$）で定める。
これは次を満たす（確認は有限和の計算である）。

1. 各 $\eta$ について $\gamma_\Lambda(\cdot\mid\eta)$ は確率測度。
2. 各 $B$ について $\eta\mapsto\gamma_\Lambda(B\mid\eta)$ は $\mathcal{F}_{\Lambda^c}$ 可測。
3. $\Lambda\subseteq\Delta$（ともに有限）なら $\gamma_\Delta\gamma_\Lambda=\gamma_\Delta$。

---

## 無限体積 Gibbs 測度

無限格子 $V$ 上では $\sum_{\sigma\in\Omega}e^{-\beta H(\sigma)}$ が定義できない
（$\Omega$ が非可算で $H$ も定義されない）。したがって上の式に相当するものは書けない。
代わりに次で定義する。

**定義（DLR 方程式・無限体積 Gibbs 測度）**
$(\Omega,\mathcal{F})$ 上の確率測度 $\mu$ が $(\beta,\Phi)$ に対する**無限体積 Gibbs 測度**であるとは、
任意の有限 $\Lambda\subset V$ と任意の $B\in\mathcal{F}$ に対し
$$\mu\bigl(B\mid\mathcal{F}_{\Lambda^c}\bigr)(\eta)=\gamma_\Lambda(B\mid\eta)
\qquad \mu\text{-a.e. }\eta$$
が成り立つこと。同値な書き方は $\mu\gamma_\Lambda=\mu$（すべての有限 $\Lambda$）。
この $\mu$ 全体の集合を $\mathcal{G}(\beta,h)$ と書く。

> **用語**: 「平衡状態」「無限体積 Gibbs 測度」「DLR 測度」は同じものを指す。

**定理 G1（存在）** $S$ が有限で $\Phi$ が絶対総和可能なら $\mathcal{G}(\beta,h)\ne\emptyset$。

**定理 G2（凸性）** $\mathcal{G}(\beta,h)$ は凸であり、弱位相でコンパクト。さらに Choquet 単体をなす。

**定義（純粋相）** $\mathcal{G}(\beta,h)$ の**端点**を純粋相という。

**定理 G3（端点の特徴づけ）** $\mu\in\mathcal{G}$ が端点 $\iff$ $\mu$ は末尾 $\sigma$ 加法族
$\mathcal{T}:=\bigcap_{\Lambda\text{ 有限}}\mathcal{F}_{\Lambda^c}$ 上で自明（値が $0$ か $1$）。

**定理 G4（端点分解）** 任意の $\mu\in\mathcal{G}$ は端点全体の上の確率測度の重心として一意に表せる。
すなわち**端点でない元は純粋相の混合であり、新しい対象ではない。**

**定理 G5（極限は Gibbs 測度）** 有限箱の増大列 $\Lambda_n\uparrow V$ と境界条件の列 $\eta_n$ について、
$(\mu_{\Lambda_n}^{\eta_n})$ の弱収束部分列の極限は $\mathcal{G}(\beta,h)$ に属する。

> 弱収束とは、$\mathcal{C}$ の各元（有限個の座標にしか依存しない事象）の確率が収束することである。

**出典**: G1–G5 は Georgii, *Gibbs Measures and Phase Transitions* の標準的内容。**原論文未確認。**

---

## 一意性と単調性（強磁性 Ising に固有の構造）

以下 $J>0$（強磁性）とする。$\Omega$ に半順序 $\sigma\le\sigma'\iff\forall i,\ \sigma_i\le\sigma'_i$ を入れ、
確率測度の**確率的順序** $\mu\preceq\nu$ を「すべての増加有界可測関数 $f$ について
$\int f\,d\mu\le\int f\,d\nu$」で定める。

**定理 F1（最大・最小の Gibbs 測度）** 全て $+1$ の境界条件 $\eta\equiv+1$ による極限
$\mu^{+}:=\lim_{\Lambda\uparrow V}\mu_\Lambda^{+}$ と、全て $-1$ による極限 $\mu^{-}$ が
（弱位相で、単調性により部分列を取らずに）存在し、任意の $\mu\in\mathcal{G}(\beta,h)$ に対し
$$\mu^{-}\preceq\mu\preceq\mu^{+}.$$

**系 F2** $|\mathcal{G}(\beta,h)|=1\iff\mu^{+}=\mu^{-}$。

> **これが「非一意性」の正確な内容である。** $\mu_\Lambda^{+}$ の列も $\mu_\Lambda^{-}$ の列も
> それぞれ収束する（定理 F1）。**極限が存在しないのではなく、二つの極限が異なりうる。**

**定義（自発磁化）** $h=0$ のとき $m^{*}(\beta):=\int\sigma_0\,d\mu^{+}\in[0,1]$。

**定理 F3** $h=0$ において $|\mathcal{G}(\beta,0)|=1\iff m^{*}(\beta)=0$。**要一次文献確認。**

---

## 相転移の二つの定義と、その関係

**ここで重要なのは、相転移に少なくとも二つの異なる定義があり、同値ではないことである。**

**定義 P1（相共存・DLR の意味の相転移）** $(\beta,h)$ で $|\mathcal{G}(\beta,h)|>1$。

**定義 P2（熱力学的な意味の相転移）** 圧力 $p$ が $(\beta,h)$ で実解析的でない。ここで
$$p(\beta,h):=\lim_{n\to\infty}\frac{1}{|\Lambda_n|}\log Z_{\Lambda_n}^{\eta}$$
であり、$\Lambda_n$ は van Hove 列（$|\partial\Lambda_n|/|\Lambda_n|\to0$）。

**定理 T1（$p$ の存在と境界条件独立性）** 上の極限は存在し、$\eta$ にも列の取り方にも依らない。
$p$ は $(\beta,\beta h)$ について凸。
**この定理は $V=\mathbb{Z}^d$ の従順性（van Hove 列の存在）を使う。**

> **$\mathbb{R}$ 脱出（その 4・極限）** 有限 $\Lambda$ では $Z_\Lambda^\eta$ は有限和である。
> $\mathbb{R}$ の完備性を使うのは、この極限を取る一点である。

**定理 T2（凸性から従うこと）** $p$ は $h$ について凸なので、各 $h$ で左右微分が存在し、
$$\partial_h^{-}p(\beta,h)=\beta\int\sigma_0\,d\mu^{-},\qquad
\partial_h^{+}p(\beta,h)=\beta\int\sigma_0\,d\mu^{+}.$$
したがって**左右微分の差は二つの純粋相の磁化の差に $\beta$ を掛けたものである。**
さらに凸関数の一般論により、**$p(\beta,\cdot)$ が微分不可能な $h$ は高々可算個**である。

**定理 T3（Lebowitz–Martin-Löf, Comm. Math. Phys. 25 (1972) 276–282）**
強磁性 Ising 系について、$|\mathcal{G}(\beta,h)|=1\iff p(\beta,\cdot)$ が $h$ で微分可能。
**要一次文献確認。**

> **系: P1 と「$p$ が $h$ について微分不可能」は同値である。**
> P1 は P2 の**部分**であって、P2 と同値ではない。以下がその分離を与える。

**定理 T4（臨界点での一意性）** $h=0$、$d\ge2$ とする。$m^{*}(\beta_c)=0$ であり、
定理 F3 により $|\mathcal{G}(\beta_c,0)|=1$。
出典: $d=2$ は Onsager (1944) / Yang (1952)、$d\ge4$ は Aizenman–Fernández、
$d=3$ は Aizenman–Duminil-Copin–Sidoravicius (2015)。**要一次文献確認。**

**定理 T5（臨界点での非解析性）** $\chi(\beta):=\partial_h^2p(\beta,h)|_{h=0}$ は $\beta=\beta_c$ で発散する。
したがって $p$ は $(\beta_c,0)$ で $C^2$ でなく、実解析的でない。
出典: Aizenman–Barsky–Fernández。**要一次文献確認。**

> **したがって $(\beta_c,0)$ は P2 の意味で相転移点だが、P1 の意味では相転移点ではない。**
> **P1 $\subsetneq$ P2 であり、二つの定義は同値でない。**

---

## 相関の減衰

**定義（切断 2 点関数）** $\mu\in\mathcal{G}$ に対し
$$\langle\sigma_i;\sigma_j\rangle_\mu:=\int\sigma_i\sigma_j\,d\mu-\Bigl(\int\sigma_i\,d\mu\Bigr)\Bigl(\int\sigma_j\,d\mu\Bigr).$$

**定義（指数減衰）** $\mu$ の切断 2 点関数が指数減衰するとは、
$\exists c>0\ \exists C>0\ \forall i,j:\ |\langle\sigma_i;\sigma_j\rangle_\mu|\le Ce^{-c|i-j|}$。

**定理 D1** $h=0$ とする。$\beta\ne\beta_c$ ならば、純粋相の切断 2 点関数は指数減衰する。
$\beta=\beta_c$ では指数減衰しない。
出典: 任意次元での結果として Duminil-Copin らの一連の仕事。**要一次文献確認。**

> **注意（この文書では結論を書かないが、事実として記録する）**
> 定義中の $c,C$ は $\mathbb{R}$ の元として書いたが、
> $c\in\mathbb{Q}_{>0}$、$C\in\mathbb{Q}_{>0}$ に取り替えても定義は同値である
> （$c$ を小さく $C$ を大きくすればよい）。
> したがって「指数減衰する」は $\exists c,C\in\mathbb{Q}_{>0}\,\forall i,j$ の形の言明に書ける。
> ただし内側の不等式は実数 $\langle\sigma_i;\sigma_j\rangle_\mu$ の比較であり、
> **そこに $\mathbb{R}$ が残る。** 全体を算術の文へ落とせるかは未検討である。

---

## 三つの領域における状況（定理のまとめ）

$h=0$、$d\ge2$、強磁性。

| | $|\mathcal{G}|$ | 純粋相の切断 2 点関数 | $p$ |
|---|---|---|---|
| $\beta<\beta_c$ | $1$（$m^{*}=0$） | 指数減衰 | 実解析的 |
| $\beta=\beta_c$ | $1$（定理 T4） | 指数減衰しない（定理 D1） | $C^2$ でない（定理 T5） |
| $\beta>\beta_c$ | $>1$（$m^{*}>0$） | 指数減衰 | $h$ で微分不可能（定理 T3） |

**$\beta<\beta_c$ での一意性と指数減衰、$\beta>\beta_c$ での $m^{*}>0$ は、
いずれも標準的な結果だが本文書では出典を確認していない。要一次文献確認。**

---

## $\mathbb{R}$ 脱出の一覧

| 箇所 | 何を使ったか | 回避可能か |
|---|---|---|
| 配位空間 $\Omega=S^V$ | 逆極限を取った。$|\Omega|=2^{\aleph_0}$ | 有限台配位なら可算だが、この理論は使わない |
| パラメータ $\beta,J,h$ | $\mathbb{R}$ の元 | $\mathbb{Q}$ に制限可能 |
| Boltzmann 重み $e^{-\beta H}$ | 有理パラメータでも超越数 | 不定元として扱えば延期できる（姉妹プロジェクト） |
| 測度の値 | $[0,1]\subset\mathbb{R}$。添字集合 $\mathcal{C}$ は可算 | 未検討 |
| 圧力 $p$ の定義 | 極限。$\mathbb{R}$ の完備性 | 未検討 |
| 定義 P2 | 実解析性 | — |
| 指数減衰の定義 | 定数は $\mathbb{Q}$ に取れるが、比較する量が実数 | 部分的 |

---

## この文書が答えていないこと

- 出典はすべて二次情報である。**定理 F3, T3, T4, T5, D1 は原論文未確認。**
- $\beta_c$ の定義を与えていない（$m^{*}$ が正になる閾値、$\chi$ が発散する閾値、
  相関の指数減衰が破れる閾値が一致することは定理だが、ここでは述べていない）。
- CA との関係を一切述べていない。この文書は用語と定理の確定のみを目的とする。
- 可算側で何ができるかを述べていない。それは仮説であり [`ideas/`](ideas/) の管轄である。
