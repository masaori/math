# 06 非従順性・パラドキシカル分解・Tarski の定理

[`00`](00_記法と集合論的規約.md)–[`05`](05_従順群の例と閉包性質.md) に従う。非従順性の決定的判定＝パラドキシカル分解を厳密化し、自由群 $F_2$ の非従順性を証明する。

---

## 6.1 自由群の厳密な定義

**定義 6.1（階数 $2$ の自由群）.** アルファベット $A:=\{a,b,a^{-1},b^{-1}\}$（$4$ 元集合、$a^{-1},b^{-1}$ は形式的記号）。$A$ 上の**語**とは有限列 $w=(x_1,\dots,x_n)$（$n\in\mathbb Z_{\ge0}$, 各 $x_k\in A$）。語が**被約**とは、隣接する $x_k,x_{k+1}$ が互いに逆（$a$ と $a^{-1}$、$b$ と $b^{-1}$）である箇所が無いこと。空語（$n=0$）を $\epsilon$ とする。
$$
F_2:=\{w\mid w\ \text{は $A$ 上の被約語}\}.
$$
演算 $\cdot_{F_2}\colon F_2\times F_2\to F_2$ は連接後に被約化（隣接逆対を消す簡約を停止まで反復；結果は一意）。単位元 $e_{F_2}:=\epsilon\in F_2$。逆元 $\mathrm{inv}_{F_2}(x_1,\dots,x_n):=(\bar x_n,\dots,\bar x_1)\in F_2$（$\bar{(\cdot)}$ は $a\leftrightarrow a^{-1},b\leftrightarrow b^{-1}$）。これは群（自由群の普遍性・被約語の一意性は標準）。$\operatorname{card}(F_2)=\aleph_0$（可算）。

**記法.** $g\in F_2$ の被約語表示の先頭文字（最左 $x_1\in A$）を $\mathrm{first}(g)\in A$ とする（$g\ne e_{F_2}$ のとき）。

---

## 6.2 パラドキシカル分解の定義

**定義 6.2（$G$-パラドキシカル集合）.** 群 $G$ が集合 $X$ に作用 $\alpha\colon G\times X\to X$ するとする。$X$ の部分集合 $E\subseteq X$ が**$G$-パラドキシカル**であるとは、次を満たす自然数 $p\in\mathbb Z_{\ge1},\ q\in\mathbb Z_{\ge1}$、互いに素な部分集合 $A_1,\dots,A_p\subseteq E$ および $B_1,\dots,B_q\subseteq E$（すべて互いに素、$A_i\cap A_j=\varnothing\ (i\ne j)$, $B_k\cap B_l=\varnothing\ (k\ne l)$, $A_i\cap B_k=\varnothing$）、および群元 $g_1,\dots,g_p\in G,\ h_1,\dots,h_q\in G$ が存在して：
$$
E=\bigsqcup_{i=1}^{p}g_i\cdot_\alpha A_i\qquad\text{かつ}\qquad E=\bigsqcup_{k=1}^{q}h_k\cdot_\alpha B_k,
$$
ここで $g_i\cdot_\alpha A_i:=\{g_i\cdot_\alpha x:x\in A_i\}\subseteq X$、$\bigsqcup$ は互いに素な合併（分割）。

**定義 6.3（パラドキシカル群）.** 群 $G$ が**パラドキシカル**であるとは、$G$ が自身への左移動作用 $\alpha_{\mathrm{left}}$（例 1.9）に関して $E=G$ がパラドキシカルであること。すなわち $G$ を有限個の部分に分け、各部分を左移動して**$G$ の二つのコピー**を復元できる。

**直観.** パラドキシカルとは「有限片への分割＋剛体運動（群移動）で自分自身の 2 個分を作れる」——質量保存（不変平均）と両立しない。

---

## 6.3 Tarski の定理

**定理 6.4（Tarski 1929）.** 群 $G$ について、次は同値：
1. $G$ は従順（左不変平均が存在、定義 3.1）。
2. $G$ はパラドキシカルでない（定義 6.3 の分解が存在しない）。
*証明の要点（両含意）.*
- **(1)⟹(2)（従順ならパラドキシカルでない）.** 左不変平均 $m$ とその測度像 $\nu_m\colon\mathcal P(G)\to\mathbb R_{\ge0}$（補題 2.8、有限加法的・左不変・$\nu_m(G)=1_{\mathbb R}$）を取る。もしパラドキシカル分解 $G=\bigsqcup_i g_i\cdot_G A_i=\bigsqcup_k h_k\cdot_G B_k$ があれば、$\nu_m$ の有限加法性と左不変性（$\nu_m(g\cdot_G S)=\nu_m(S)$）から
$$
1_{\mathbb R}=\nu_m(G)=\sum_{i}\nu_m(g_i\cdot_G A_i)=\sum_i\nu_m(A_i),\qquad 1_{\mathbb R}=\sum_k\nu_m(B_k),
$$
かつ $A_i,B_k$ すべて互いに素で $G$ に含まれるから $\sum_i\nu_m(A_i)+_{\mathbb R}\sum_k\nu_m(B_k)\le_{\mathbb R}\nu_m(G)=1_{\mathbb R}$。ゆえ $1_{\mathbb R}+_{\mathbb R}1_{\mathbb R}\le_{\mathbb R}1_{\mathbb R}$、すなわち $2_{\mathbb R}\le_{\mathbb R}1_{\mathbb R}$、矛盾。よってパラドキシカルでない。
- **(2)⟹(1)（非パラドキシカルなら従順）.** 対偶ではなく直接、**Tarski の定理**（有限加法的不変測度の存在 ⟺ 非パラドキシカル）を用いる。非パラドキシカルなら、$G$ 上に左不変な有限加法的確率測度 $\nu\colon\mathcal P(G)\to\mathbb R_{\ge0}$（$\nu(G)=1_{\mathbb R}$）が存在する（Tarski の元定理、証明は Hall の結婚定理型のマッチング論法による；Wagon 1985 §9–10）。$\nu$ から補題 2.8 で左不変平均 $m_\nu$ を得る。∎

**系 6.5.** 非従順 $\iff$ パラドキシカル。パラドキシカル分解は非従順性の**構成的証拠**（有限片と有限個の群元）。

---

## 6.4 自由群 $F_2$ はパラドキシカル（したがって非従順）

**定理 6.6.** $F_2$（定義 6.1）は自身の左移動作用に関しパラドキシカルであり、ゆえに非従順（定理 6.4）。
*証明.* $F_2$ の非単位元を先頭文字で分類する。$x\in A=\{a,b,a^{-1},b^{-1}\}$ に対し
$$
W(x):=\{g\in F_2:g\ne e_{F_2},\ \mathrm{first}(g)=x\}\subseteq F_2.
$$
被約語の一意性から、$F_2$ は互いに素な合併
$$
F_2=\{e_{F_2}\}\ \sqcup\ W(a)\ \sqcup\ W(a^{-1})\ \sqcup\ W(b)\ \sqcup\ W(b^{-1})\tag{分割}
$$
に分かれる（各非単位元 $g$ は先頭文字 $\mathrm{first}(g)\in A$ でちょうど一つの $W(\cdot)$ に属す）。

**鍵の恒等式.** 主張：$a\cdot_{F_2}W(a^{-1})=F_2\setminus W(a)$。
- ($\subseteq$) $g\in W(a^{-1})$ は $g=(a^{-1},x_2,\dots,x_n)$（被約、$x_2\ne a$）と書ける。$a\cdot_{F_2}g$ は先頭 $a^{-1}$ が打ち消され $(x_2,\dots,x_n)\in F_2$（$n=1$ なら $e_{F_2}$）。この語の先頭 $x_2\ne a$、かつ $e_{F_2}$ も先頭 $a$ でないから $a\cdot_{F_2}g\in F_2\setminus W(a)$。
- ($\supseteq$) $h\in F_2\setminus W(a)$（すなわち $\mathrm{first}(h)\ne a$ か $h=e_{F_2}$）に対し $a^{-1}\cdot_{F_2}h$ は先頭に $a^{-1}$ が付き打ち消し無しで被約、ゆえ $a^{-1}\cdot_{F_2}h\in W(a^{-1})$、かつ $a\cdot_{F_2}(a^{-1}\cdot_{F_2}h)=h$。

同様に $b\cdot_{F_2}W(b^{-1})=F_2\setminus W(b)$。これらから**二つの分解**を得る：
$$
F_2=W(a)\ \sqcup\ a\cdot_{F_2}W(a^{-1}),\tag{$\ast a$}
$$
$$
F_2=W(b)\ \sqcup\ b\cdot_{F_2}W(b^{-1}).\tag{$\ast b$}
$$
（$(\ast a)$ は $F_2=W(a)\sqcup(F_2\setminus W(a))=W(a)\sqcup a\cdot_{F_2}W(a^{-1})$。$(\ast b)$ も同様。）

**パラドキシカル分解.** $E:=F_2$ とし、$p=q=2$、素片と移動元を
$$
A_1:=W(a),\quad A_2:=W(a^{-1}),\quad g_1:=e_{F_2}\in F_2,\quad g_2:=a\in F_2;
$$
$$
B_1:=W(b),\quad B_2:=W(b^{-1}),\quad h_1:=e_{F_2}\in F_2,\quad h_2:=b\in F_2
$$
と定める。四つの素片 $A_1=W(a),\ A_2=W(a^{-1}),\ B_1=W(b),\ B_2=W(b^{-1})$ は（分割）より**互いに素**で、すべて $E=F_2$ の部分集合。そして
$$
E=g_1\cdot_{F_2}A_1\ \sqcup\ g_2\cdot_{F_2}A_2=W(a)\ \sqcup\ a\cdot_{F_2}W(a^{-1})\quad(\text{by }(\ast a)),
$$
$$
E=h_1\cdot_{F_2}B_1\ \sqcup\ h_2\cdot_{F_2}B_2=W(b)\ \sqcup\ b\cdot_{F_2}W(b^{-1})\quad(\text{by }(\ast b)).
$$
これはまさに定義 6.2 の条件（$E$ を互いに素な $A_i,B_k$ に分け、各々を移動して $E$ を二度復元）。ゆえ $F_2$ はパラドキシカル。∎

**注意 6.7（$e_{F_2}$ の帰属と「片が $E$ を被覆しない」こと）.** 上の四素片 $A_1=W(a),\,A_2=W(a^{-1}),\,B_1=W(b),\,B_2=W(b^{-1})$ は単位元 $e_{F_2}$ を含まない（（分割）で $e_{F_2}$ は独立成分 $\{e_{F_2}\}$）。ここで**定義 6.2 は素片 $A_i,B_k$ が $E$ を被覆すること（$\bigcup_iA_i\cup\bigcup_kB_k=E$）を要求していない**——要求は「$A_i,B_k$ が互いに素で $E$ に含まれ、**移動後の合併** $\bigsqcup_i g_i\cdot_{F_2}A_i$ と $\bigsqcup_k h_k\cdot_{F_2}B_k$ がそれぞれ $E$ を被覆する」ことのみ。ゆえ $e_{F_2}$ がどの素片にも属さなくてよく、実際に $e_{F_2}$ は移動後に両分解で回収される：第一分解では $(\ast a)$ 右辺 $a\cdot_{F_2}W(a^{-1})=F_2\setminus W(a)\ni e_{F_2}$（$e_{F_2}=a\cdot_{F_2}a^{-1_{F_2}}$, $a^{-1_{F_2}}\in W(a^{-1})=A_2$）、第二分解でも $b\cdot_{F_2}W(b^{-1})=F_2\setminus W(b)\ni e_{F_2}$（$e_{F_2}=b\cdot_{F_2}b^{-1_{F_2}}$, $b^{-1_{F_2}}\in W(b^{-1})=B_2$）。したがって**本文の4素片による分解はそのままで定義 6.2 を完全に満たし、追加の再配分は不要**である。

**注意 6.7′（片が $E$ を被覆する強い流儀を採る場合）.** もし「素片が $E$ を分割する」（$E=\bigsqcup_iA_i\sqcup\bigsqcup_kB_k$）というより強い条件を課す流儀（一部の教科書の定式化）を採るなら、上の4素片は $e_{F_2}$ を落とすため被覆に足りない。その場合は $W(a^{-1})$ を「$a^{-n_{F_2}}$（$n\in\mathbb Z_{\ge1}$）の形の語」とそれ以外に細分し $e_{F_2}$ を吸収する（Wagon 1985 §5.3 の整理）ことで、$E$ を分割する互いに素な素片と移動元が取れる。結論（$F_2$ パラドキシカル）は流儀に依らず不変。厳密な逐語版は Wagon *The Banach–Tarski Paradox* 定理 5.2 を参照。

**別証（Følner の不存在）.** $F_2$ が Følner 列 $(F_n)$ をもつと仮定すると、$a,b\in F_2$ に対し $r_{F_2}(a,F_n)\to0_{\mathbb R}$ かつ $r_{F_2}(b,F_n)\to0_{\mathbb R}$。だが $F_2$ の Cayley グラフは $4$-正則木で**等周定数（Cheeger 定数）が正**：任意の $F\in\mathcal P_{\mathrm{fin}}(F_2)$, $F\ne\varnothing$ に対し $\#\partial F\ge_{\mathbb Z}2\cdot_{\mathbb Z}\#F$（境界が体積に比例、木の指数増大）、ゆえ $r_{F_2}(s,F)\ge_{\mathbb R}c$（ある $c\in\mathbb R_{>0}$、$s\in\{a,b\}$）で $0_{\mathbb R}$ に収束できず矛盾。∎

---

## 6.5 $F_2$ を含む群・Tits 交代律

**命題 6.8.** $F_2\le G$（部分群として含む）なら $G$ は非従順。
*証明.* 対偶：$G$ 従順なら部分群 $F_2$ も従順（命題 5.5）。だが $F_2$ は非従順（定理 6.6）。矛盾。∎

**定理 6.9（Tits 交代律、主張のみ）.** $K$ を体、$G\le\mathrm{GL}_n(K)$（$n\in\mathbb Z_{\ge1}$）を有限生成線型群とする。このとき次のいずれか一方が成立：(i) $G$ は可解部分群を有限指数で含む（従って従順）、または (ii) $G$ は $F_2$ に同型な部分群を含む（従って非従順）。
*出典.* J. Tits, *Free subgroups in linear groups*, J. Algebra 20 (1972) 250–270。証明は本書の範囲を超える。**含意**：線型群では「従順 ⟺ $F_2$ を含まない」。双曲格子・Fuchsian 群（[`../曲面群スペクトル曲線_球面とトーラス/`](../曲面群スペクトル曲線_球面とトーラス/README.md), [`../数え上げエントロピーと特殊値/06`](../数え上げエントロピーと特殊値/06_非周期グラフと双曲格子.md)）は線型かつ $F_2$ を含むので非従順。

---

## 6.6 Banach–Tarski への接続（注記）

$F_2$ のパラドキシカル性を、$\mathrm{SO}(3)$ 内の $F_2$（回転による自由群）へ移し、$\mathbb R^3$ の球面 $S^2$ の作用へ持ち上げると、**Banach–Tarski のパラドックス**（球を有限片に分け剛体運動で二つの同じ球にする）が得られる。これは $\mathrm{SO}(3)$ が $F_2$ を含み**非従順**であることの幾何的帰結。厳密には選択公理（非可測な片）を要し、$\mathbb R$／非可算構造が本質的（Wagon 1985）。RΛ 双対の文脈では、非従順群で「不変平均＝清潔な不変量」が壊れる根源がこのパラドキシカル性であり、代替として sofic entropy（近似列依存）へ移る（第07章）。
