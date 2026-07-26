# cycle 14 / T1: 命題 T の一般化 — $v_p(\tau_d(L))$ はどこまで clean か

対象: cycle 13 で証明した**命題 T**（`outputs/reports/cycle13_T1_observation_T_settlement.md`）

$$\textbf{奇数 } L \text{ に対し } v_2(\tau(L))=2(L-1),\qquad \tau(L)=\tau_2(L)=C_L\times C_L \text{ の全域木数}$$

を、(1) 奇素数 $p$、(2) $d$ 次元トーラス $C_L^d$ へ一般化できるかを調べた。

数値検証は `sagemath/check/cycle14_T1_tau_general/`（実行ログ `tau_general_verify.out`）。

---

## 0. 結論の要約（先に述べる）

**証明できたもの（§3–§6）:**

- **定理 A（判定条件）**: $p\nmid L$ のとき $p\mid\tau_d(L)$ $\iff$ $\overline{\mathbb F}_p$ の中で
  $\sum_{i=1}^d(\varepsilon_i+\varepsilon_i^{-1})=2d$ を満たす $(\varepsilon_1,\dots,\varepsilon_d)\in\mu_L(\overline{\mathbb F}_p)^d\setminus\{(1,\dots,1)\}$ が存在すること。
- **定理 B（次元についての漸化式）**: $L$ 奇、$p\nmid L$ のとき、明示的な $G_L\in\mathbb{Z}[A]$ により
  $v_p(\tau_d(L))=v_p(\tau_{d-1}(L))+2\sum_{\mathbf j'\neq0}v_P\bigl(G_L(A_{\mathbf j'})\bigr)$。
  **命題 T はこの公式の「$d=2$, $p=2$ では全項がちょうど 1」という場合にすぎない。**
- **定理 C（偶奇）**: $p\nmid L$ で $L$ が奇数なら、**任意の $d$ について** $4\mid v_p(\tau_d(L))$。
  $L$ が偶数なら $v_p(\tau_d(L))\equiv\sum_{b=1}^{d}\binom{d}{b}v_p(b)\pmod2$
  （$d=3,p=3$ や $d=5,p=5$ では**奇数**になる。実測と一致）。
- **定理 D（命題 T の短縮証明）**: 命題 T は Hensel・Newton 多角形・LTE を使わずに、
  $\mathbb{Z}[x,y]$ の恒等式 $(x+x^{-1}+y+y^{-1})xy=(x+y)(xy+1)$ と $v_P(1\pm\zeta^m)$ の評価だけで 10 行で証明できる。
  **主張は cycle 13 と同一で、新しい定理ではない。証明が短くなり、一般化の機構が見えるようになったことが成果である。**
- **定理 E（部分トーラス下界）**: $\{1,\dots,d\}$ の部分集合を **サイズが $p$ の倍数のブロック**に分割して
  変数を同一視し、残りを $1$ に固定した部分トーラス上で $\lambda\equiv0\pmod P$ となる。これにより
  $p\nmid L$ のとき $v_p(\tau_d(L))\ \ge\ L^{\lfloor d/p\rfloor}-1$。さらに明示族から
  $v_2(\tau_3(L))\ge6(L-1)$（$L$ 奇）、$v_3(\tau_3(L))\ge4(L-1)-3\cdot[2\mid L]$（$3\nmid L$）。
- **定理 F（$p=2,d=2$ が特別な理由）**: $d=2$ のとき、$\bmod\,2$ では
  $4-x-x^{-1}-y-y^{-1}$ の零点集合は**2 つの部分トーラス $x=y$ と $xy=1$ の合併**である。
  一方 **$p$ が奇素数なら、$d=2$ の零点集合は正次元の部分トーラスの剰余類を一切含まない**。
  これが「$p=2$ でだけ $L$ について一様な法則が立つ」ことの正確な理由である。

**見つからなかったもの（正直に記す。§7）:**

- **奇素数 $p$ に対する clean な法則は無い。** 定理 A の判定条件は完全（かつ決定可能）だが、
  $(p,L)$ の合同条件などの閉じた形にはならない。標本（$L=3..40$, $p<200$）の中で
  $p\equiv\pm1\pmod L$ という素朴な予想には**反例が複数ある**（$L=13,p=5$ など。§7.1）。
- **$d\ge3$ では等号（clean な法則）が成り立たない。** 定理 E の下界は標本全体で成立するが、
  $d=3,p=2$ では $L=9,15,17,21,27$ で下界より真に大きく（散発的な追加解がある）、
  $c\,(L^{d-1}-1)$ 型の式には**ならなかった**。
- $c\,(L^{d-1}-1)$ 型（作業指示の予想）は成り立たない。正しい増大の指数は $L^{\lfloor d/p\rfloor}$ である。

**新規性は主張しない（§8）。** 文献本文を取得できたのは 1 本のみで、それは $\mathbb{Z}$-被覆（階数 1）の結果である。

---

## 1. 記号と基本事実

$L\ge3$、$d\ge2$、$\zeta=\zeta_L$、$K=\mathbb{Q}(\zeta_L)$。
$C_L^d$ は有限アーベル群 $(\mathbb{Z}/L)^d$ の Cayley グラフ（生成元 $\pm e_1,\dots,\pm e_d$）で、$L\ge3$ なら単純 $2d$ 正則グラフ。
指標 $\chi_{\mathbf j}(\mathbf a)=\zeta^{\mathbf j\cdot\mathbf a}$ はラプラシアン $\Delta$ の固有ベクトルで（cycle 13 補題 0 と同じ計算）、

$$\lambda_{\mathbf j}=2d-\sum_{i=1}^{d}\bigl(\zeta^{j_i}+\zeta^{-j_i}\bigr),\qquad \mathbf j\in(\mathbb{Z}/L)^d .$$

Kirchhoff の matrix-tree 定理より

$$\tau_d(L)=\frac{1}{L^{d}}\prod_{\mathbf j\neq\mathbf 0}\lambda_{\mathbf j}. \tag{1.1}$$

**補題 1（不分岐化）.** $p\nmid L$ とする。$p$ は $K$ で不分岐だから、$P\mid p$ を取り正規化付値 $v_P$（$v_P(p)=1$、値群 $\mathbb{Z}$）を固定できる。このとき

$$v_p\bigl(\tau_d(L)\bigr)=\sum_{\mathbf j\neq\mathbf 0}v_P(\lambda_{\mathbf j}). \tag{1.2}$$

*証明.* $(1.1)$ より $L^d\tau_d(L)=\prod_{\mathbf j\neq0}\lambda_{\mathbf j}\in\mathbb{Z}$。$e=1$ なので $v_P$ は $\mathbb{Q}$ 上で $v_p$ に一致し、$p\nmid L$ より $v_P(L^d)=0$。∎

さらに cycle 13 の $(3.3)$ と同じ議論で、**$p\nmid L$、$m\not\equiv0\pmod L$ なら $v_P(1-\zeta^m)=0$**
（$\prod_{k=1}^{L-1}(1-\zeta^k)=L$ かつ $v_P(L)=0$、各因子の付値は非負）。 $\tag{1.3}$

---

## 2. 命題 T の短縮証明（定理 D）

**定理 D.** $L$ を奇数とすると $v_2(\tau_2(L))=2(L-1)$。

*証明.* $\mathbb{Z}[x,y]$ での恒等式

$$\bigl(x+x^{-1}+y+y^{-1}\bigr)xy=y(x^2+1)+x(y^2+1)=(x+y)(xy+1) \tag{2.1}$$

（両辺を展開すれば $x^2y+x+xy^2+y$）に $x=\zeta^j,\ y=\zeta^k$ を代入すると、$\zeta$ は単数なので

$$\lambda_{j,k}=4-\bigl(\zeta^{j}+\zeta^{k}\bigr)\bigl(\zeta^{j+k}+1\bigr)\zeta^{-(j+k)} . \tag{2.2}$$

$L$ 奇より $p=2$ は $K$ で不分岐。$v:=v_P$（$P\mid2$）とする。$m\not\equiv0\pmod L$ のとき $L$ が奇数なので $2m\not\equiv0$ であり、

$$1+\zeta^{m}=\frac{1-\zeta^{2m}}{1-\zeta^{m}}\ \Longrightarrow\ v(1+\zeta^m)=v(1-\zeta^{2m})-v(1-\zeta^m)=0-0=0$$

（$(1.3)$ を $m$ と $2m$ に適用）。$m\equiv0$ のときは $1+\zeta^m=2$ で $v=1$。$\zeta^j+\zeta^k=\zeta^j(1+\zeta^{k-j})$ だから

$$v\Bigl(\bigl(\zeta^{j}+\zeta^{k}\bigr)\bigl(\zeta^{j+k}+1\bigr)\Bigr)=[\,k\equiv j\,]+[\,k\equiv-j\,]\in\{0,1,2\}. \tag{2.3}$$

$(j,k)\neq(0,0)$ のとき $k\equiv j$ と $k\equiv-j$ が同時に成り立つことはない（両立すれば $2j\equiv0$、$L$ 奇より $j\equiv0$、よって $k\equiv0$ で矛盾）。ゆえに $(2.3)$ の値は $0$ か $1$。$v(4)=2$ なので、付値の異なる 2 項の和の付値は小さい方に等しく

$$v(\lambda_{j,k})=\begin{cases}1,& k\equiv\pm j \pmod L,\\ 0,&\text{それ以外.}\end{cases}$$

$k\equiv\pm j$ かつ $(j,k)\neq(0,0)$ となる $\mathbf j$ は $j\neq0$ かつ $k=j$（$L-1$ 個）または $k=-j$（$L-1$ 個）で、$L$ 奇よりこの 2 つは交わらない（交われば $2j\equiv0$）。$j=0$ なら $k\equiv\pm0=0$ で除外。よって全部で $2(L-1)$ 個。補題 1 より

$$v_2(\tau_2(L))=\sum_{\mathbf j\neq0}v(\lambda_{\mathbf j})=2(L-1). \qquad\blacksquare$$

**cycle 13 の証明との関係。** 主張は同一である（新定理ではない）。cycle 13 は Step 1–8（分解 → 不分岐性 → Hensel → Newton 多角形 → LTE）を要したが、本証明は $(2.1)$ と $(1.3)$ だけを使う。
重要なのは短さではなく、**$(2.1)$ が $\bmod\,2$ での零点集合の構造を露わにする**ことである（§6）。

*（検証: `tau_general_verify.out` の (0) で $(2.1)$ を `ZZ[x,y]` 上で記号的に確認した。）*

---

## 3. 判定条件（定理 A）

**定理 A.** $p\nmid L$ とする。次は同値。

1. $p\mid\tau_d(L)$、すなわち $v_p(\tau_d(L))>0$。
2. $\sum_{i=1}^d(\varepsilon_i+\varepsilon_i^{-1})=2d$ を満たす $(\varepsilon_1,\dots,\varepsilon_d)\in\mu_L(\overline{\mathbb F}_p)^d$、$\neq(1,\dots,1)$、が存在する。

*証明.* $p\nmid L$ より $X^L-1$ は $\mathbb{F}_p$ 上分離的だから、剰余体 $k_P=\mathbb{Z}[\zeta_L]/P$ への還元は $\mu_L(K)\xrightarrow{\ \sim\ }\mu_L(k_P)$ を与える（$k_P=\mathbb{F}_{p^f}$、$f=\mathrm{ord}_L(p)$、$\mu_L(\overline{\mathbb F}_p)=\mu_L(k_P)$）。補題 1 より $v_p(\tau_d(L))>0$ $\iff$ ある $\mathbf j\neq0$ で $v_P(\lambda_{\mathbf j})>0$ $\iff$ $\overline{\lambda_{\mathbf j}}=0$ in $k_P$ $\iff$ $\varepsilon_i:=\overline{\zeta^{j_i}}$ が 2 を満たす。逆向きは上の全単射で $\varepsilon_i$ から $\mathbf j$ を復元すればよい。∎

**注（決定可能性）.** 条件 2 は $\mathbb{F}_{p^f}$ での $L^d$ 個の有限判定であり、選別基準 (iii)（決定可能・witness 付き）を満たす。$v_p$ の値そのものも、$\mathbb{Z}_p$ の不分岐拡大での有限精度計算で決定できる（本 step の計算経路）。

---

## 4. 次元についての漸化式（定理 B）と偶数性・4 の倍数性（定理 C）

$s_k\in\mathbb{Z}[A]$ を $s_0=2$, $s_1=A$, $s_k=A\,s_{k-1}-s_{k-2}$ で定める（$z+z^{-1}=A$ のとき $s_k=z^k+z^{-k}$）。

**補題 2（多項式恒等式）.** $L$ が奇数のとき、$G_L:=1+\sum_{k=1}^{(L-1)/2}s_k\in\mathbb{Z}[A]$（次数 $(L-1)/2$）に対し

$$s_L(A)-2=(A-2)\,G_L(A)^2 . \tag{4.1}$$

*証明.* $z+z^{-1}=A$ とすると $s_L-2=z^{L}+z^{-L}-2=(z^{L}-1)^2/z^{L}$、$A-2=(z-1)^2/z$。よって

$$\frac{s_L-2}{A-2}=\Bigl(\frac{z^{L}-1}{z^{(L-1)/2}(z-1)}\Bigr)^{2}
=\Bigl(\sum_{i=0}^{L-1}z^{\,i-\frac{L-1}{2}}\Bigr)^{2}
=\Bigl(1+\sum_{k=1}^{(L-1)/2}(z^{k}+z^{-k})\Bigr)^{2}=G_L(A)^2 ,$$

$L$ が奇数なので指数 $i-\frac{L-1}{2}$ は $-\frac{L-1}{2},\dots,\frac{L-1}{2}$ を渡り、和は $z\leftrightarrow z^{-1}$ 対称。ゆえに $\mathbb{Z}[A]$ の元。∎

**定理 B（漸化式）.** $L$ を奇数、$p\nmid L$、$d\ge2$ とする。$\mathbf j'=(j_2,\dots,j_d)$ に対し
$A_{\mathbf j'}:=2d-\sum_{i\ge2}(\zeta^{j_i}+\zeta^{-j_i})$ と置くと

$$v_p\bigl(\tau_d(L)\bigr)=v_p\bigl(\tau_{d-1}(L)\bigr)+2\sum_{\mathbf j'\neq\mathbf 0}v_P\bigl(G_L(A_{\mathbf j'})\bigr),
\qquad \tau_1(L)=L. \tag{4.2}$$

*証明.* cycle 13 Step 1 の計算（標数に依らない代数的恒等式）より、任意の $A$ に対し
$\prod_{j_1\in\mathbb{Z}/L}\bigl(A-\zeta^{j_1}-\zeta^{-j_1}\bigr)=s_L(A)-2$。
$(1.1)$ の積を $\mathbf j'=\mathbf0$ かどうかで分ける。$\mathbf j'=\mathbf0$ の部分（$j_1\neq0$）は
$\prod_{j_1\neq0}(2-\zeta^{j_1}-\zeta^{-j_1})=L^2$（cycle 13 Step 2）。$\mathbf j'\neq\mathbf0$ の部分は $j_1$ 全体の積なので
$\prod_{\mathbf j'\neq0}\bigl(s_L(A_{\mathbf j'})-2\bigr)$。よって $L^d\tau_d(L)=L^2\prod_{\mathbf j'\neq0}(s_L(A_{\mathbf j'})-2)$。
補題 2 を代入し $v_P$（$v_P(L)=0$）を取ると

$$v_p(\tau_d(L))=\sum_{\mathbf j'\neq0}v_P\bigl(A_{\mathbf j'}-2\bigr)+2\sum_{\mathbf j'\neq0}v_P\bigl(G_L(A_{\mathbf j'})\bigr).$$

ここで $A_{\mathbf j'}-2=2(d-1)-\sum_{i\ge2}(\zeta^{j_i}+\zeta^{-j_i})=\lambda^{(d-1)}_{\mathbf j'}$ は
**$(d-1)$ 次元トーラス $C_L^{d-1}$ の固有値そのもの**なので、補題 1 を次元 $d-1$ に適用して
第 1 項 $=v_p(\tau_{d-1}(L))$。$d-1=1$ のときも $\prod_{j\neq0}(2-\zeta^j-\zeta^{-j})=L^2$、$\tau_1(L)=L^2/L=L$ で整合する。∎

**定理 C.** $p\nmid L$、$d\ge1$ とする。

1. $L$ が**奇数**なら $4\mid v_p(\tau_d(L))$。
2. $L$ が**偶数**なら（このとき $p$ は奇素数）
   $$v_p\bigl(\tau_d(L)\bigr)\ \equiv\ \sum_{b=1}^{d}\binom{d}{b}\,v_p(b)\pmod 2 .$$
   とくに $d=2$ では偶数、$d=3$ では $p=3$ のときに限り**奇数**、$d=5$ では $p=5$ のときに限り奇数である。

*証明.* 1: $d=1$ では $v_p(\tau_1(L))=v_p(L)=0$。$d\ge2$ では、対合 $\sigma:\mathbf j'\mapsto-\mathbf j'$ は $A_{\mathbf j'}$ を変えず、$L$ 奇なので
$(\mathbb{Z}/L)^{d-1}\setminus\{\mathbf 0\}$ 上で不動点をもたない（$2j_i\equiv0\ \forall i$ なら $\mathbf j'=\mathbf0$）。
よって $(4.2)$ の和 $\sum_{\mathbf j'\neq0}v_P(G_L(A_{\mathbf j'}))$ は長さ 2 の軌道に分かれて偶数であり、
$v_p(\tau_d(L))\equiv v_p(\tau_{d-1}(L))\pmod 4$。$d$ についての帰納法で結論。

2: 補題 1 の和 $\sum_{\chi\neq0}v_P(\lambda_\chi)$ に対合 $\chi\mapsto-\chi$（$\lambda_\chi$ を保つ）を適用する。
長さ 2 の軌道の寄与は偶数。不動点は $2\chi=0$、すなわち $j_i\in\{0,L/2\}$ を満たす $\chi\neq0$。
$\zeta^{L/2}=-1$ なので $\zeta^{j_i}+\zeta^{-j_i}$ は $j_i=0$ で $2$、$j_i=L/2$ で $-2$。
$b:=\#\{i:j_i=L/2\}\ (\ge1)$ と置くと
$$\lambda_\chi=2d-\bigl(2(d-b)-2b\bigr)=4b .$$
$p$ は奇素数なので $v_P(4b)=v_p(b)$。$b$ を与える不動点は $\binom{d}{b}$ 個。よって主張を得る。∎

*（$d=3,p=3$: $\sum_b\binom3b v_3(b)=3\cdot0+3\cdot0+1\cdot1=1$ で奇数。実測（(5c)）でも
$L=4,8,10,14,16,20,22,26$ の $v_3(\tau_3(L))$ は $21,85,105,49,213,349,81,721$ ですべて奇数であり、一致する。）*

**注（素朴な議論が壊れる箇所。重要）.** $s_L(A)-2=(r^L-1)^2/r^L$（$r+r^{-1}=A$）だから
「$r$ は単数なので $v_P$ は偶数」と言いたくなるが、**これは $d\ge3$ で偽である**。
$r$ は $K_P$ の 2 次拡大の元でありうるが、その拡大は**分岐しうる**ので $v_P(r^L-1)$ は半整数になりうる。
実測（`tau_general_verify.out` (2c)）: $d=2$ では奇数項は 0 件（$A-2=(1-\zeta^{j})(1-\zeta^{-j})$ が $p\nmid L$ で単数だから）だが、
$d=3,L=5,p=2$ では 24 項中 8 項、$d=4,L=5,p=2$ では 124 項中 24 項が奇数である。
**偶数性は補題 2 の因数分解を経由してのみ証明できる。**

*（検証: (2a) で補題 2 を $\mathbb{Z}[A]$ 上で記号的に $L\le15$ で確認、(2b) で $(4.2)$ を $d=2,3,4$ の標本で確認、
(2c) で上の注の反例、(2d) で定理 C.1 を $d=2,3,4$ の標本で、(2e) で定理 C.2 を $d=2,\dots,5$ の標本で確認した。）*

**命題 T の位置づけ.** $d=2$、$L$ 奇のとき $(4.2)$ は $v_p(\tau_2(L))=2\sum_{j\neq0}v_P(G_L(A_j))$。
定理 D は $p=2$ のときこの各項がちょうど $1$ だと言っている。
**「$L$ に依らず全項が同じ値」という現象が、clean な閉形の唯一の源である。**

---

## 5. 部分トーラスによる下界（定理 E）

**定理 E.** $p$ を素数、$p\nmid L$、$d\ge2$ とする。$S\subseteq\{1,\dots,d\}$ とその分割 $S=B_1\sqcup\cdots\sqcup B_k$（各 $p\mid|B_a|$）、および符号 $\epsilon_i\in\{\pm1\}\ (i\in S)$ を取る。$\mathbf t=(t_1,\dots,t_k)\in\mu_L^k$ に対し $\mathbf x(\mathbf t)\in\mu_L^d$ を

$$x_i=\begin{cases}t_{a(i)}^{\ \epsilon_i}, & i\in B_a,\\ 1,& i\notin S\end{cases}$$

で定めると（$a(i)$ は $i$ の属するブロック番号）、対応する指標の固有値は

$$\lambda=2d-\sum_i (x_i+x_i^{-1})=2|S|-\sum_{a=1}^{k}|B_a|\bigl(t_a+t_a^{-1}\bigr)=\sum_{a=1}^{k}|B_a|\,\bigl(1-t_a\bigr)\bigl(1-t_a^{-1}\bigr) \tag{5.1}$$

を満たす。$p\mid|B_a|$ より $v_P(\lambda)\ge1$。したがって、$W$ を（許される全ての選び方にわたる）$\mathbf x(\mathbf t)$ の集合とすると

$$v_p\bigl(\tau_d(L)\bigr)\ \ge\ \#\bigl(W\setminus\{(1,\dots,1)\}\bigr). \tag{5.2}$$

*証明.* $x_i+x_i^{-1}=t_a+t_a^{-1}$（$\epsilon_i=\pm1$ に依らない）と $2-t-t^{-1}=(1-t)(1-t^{-1})$ から $(5.1)$。
$|B_a|\equiv0\pmod p$ なので各項の付値は $\ge1$。補題 1 と $v_P(\lambda)\ge1$ の指標を数えれば $(5.2)$。∎

**系 E1（増大の指数）.** $p\le d$ なら、$k=\lfloor d/p\rfloor$ 個のサイズ $p$ のブロック（$\epsilon\equiv+1$）を取ると $\mathbf t\mapsto\mathbf x(\mathbf t)$ は単射なので

$$v_p\bigl(\tau_d(L)\bigr)\ \ge\ L^{\lfloor d/p\rfloor}-1\qquad(p\nmid L). $$

**系 E2（明示族と正確な重複度）.** $(5.1)$ の右辺は、ブロックが 1 個で $|B|=p$ のとき $p\,(1-t)(1-t^{-1})$ であり、$p\nmid L$ と $(1.3)$ から $t\neq1$ なら $v_P=v_P(p)=1$ **ちょうど**。これから

- $d=2,\ p=2,\ L$ 奇: $W\setminus\{1\}=\{(\zeta^j,\zeta^{\pm j}):j\neq0\}$、$|W\setminus\{1\}|=2(L-1)$、各点で $v_P(\lambda)=1$
  $\Rightarrow v_2\ge2(L-1)$（定理 D により**等号**）。
- $d=3,\ p=2,\ L$ 奇: 1 座標を $1$ に固定し残り 2 座標を $t,t^{\pm1}$ とする $6$ 本の 1 次元部分トーラス。
  $\lambda=2(1-t)(1-t^{-1})$、$v_P=1$、点は相異なり $6(L-1)$ 個 $\Rightarrow \boxed{v_2(\tau_3(L))\ge6(L-1)}$。
- $d=3,\ p=3,\ 3\nmid L$: 対角型 $(t,t,t),(t,t,t^{-1}),(t,t^{-1},t),(t^{-1},t,t)$ の 4 本。$\lambda=3(1-t)(1-t^{-1})$、$v_P=1$。
  相異なる非自明点は $L$ 奇なら $4(L-1)$、$L$ 偶なら $t=-1$ で 4 本が 1 点に潰れるので $4(L-1)-3$
  $\Rightarrow \boxed{v_3(\tau_3(L))\ge4(L-1)-3\cdot[\,2\mid L\,]}$。

*（点の相異なることの確認: $d=3,p=2$ では非自明点はちょうど 1 座標が $1$ なのでその位置が決まり、$L$ 奇より $t\neq t^{-1}$。
$d=3,p=3$ では $L$ 奇なら同様、$L$ 偶では $t=-1$ のときのみ 4 本が交わる。）*

*（検証: (5b)(5c)(5d) で下界を標本全体で確認した。$d=3,p=3,L=14$ で実測 $v_3=49=4\cdot13-3$ となり、
$L$ 偶での $-3$ 補正が**必要**であることが数値からも確認できる（補正しなければ下界 $52>49$ で偽になる）。）*

---

## 6. なぜ $p=2$・$d=2$ だけが一様なのか（定理 F）

作業指示の見立ては「グラフの次数 $4=2\cdot2$ が $p=2$ で消えること」だったが、より正確な理由は**零点集合の構造**である。

**定理 F.** $F_2(x,y):=4-x-x^{-1}-y-y^{-1}$ とし、$\mathbb{G}_m^2$ の中でその零点集合を考える。

1. $\overline{\mathbb F}_2$ 上では $F_2\cdot xy=(x+y)(xy+1)$ であり、零点集合は **2 つの部分トーラス $\{x=y\}$ と $\{xy=1\}$ の合併**である。
2. $p$ が**奇素数**なら、$\overline{\mathbb F}_p$ 上の零点集合は**正次元の部分トーラスの剰余類を 1 つも含まない**。

*証明.* 1 は $(2.1)$ を $\bmod\,2$ で読めばよい（$4\equiv0$）。
2: 正次元の部分トーラスの剰余類は、ある $(a,b)\in\mathbb{Z}^2\setminus\{(0,0)\}$ と $\alpha,\beta\in\overline{\mathbb F}_p^{\times}$ により
$\{(\alpha s^{a},\beta s^{b}):s\in\mathbb{G}_m\}$ の像を含む。その上で
$g(s)=4-\alpha s^{a}-\alpha^{-1}s^{-a}-\beta s^{b}-\beta^{-1}s^{-b}$ が Laurent 多項式として恒等的に $0$ でなければならない。

- $a=b=0$ は 1 点であり正次元でない。
- ちょうど一方が $0$（$b=0$ とする）なら、$s^{a}$ の係数は $-\alpha\neq0$ で、他に指数 $a$（$\neq0,\ \neq -a$）の項が無いから $g\not\equiv0$。
- $a\neq0$ かつ $b\neq0$ なら、指数 $0$ の項は定数 $4$ のみ（$\pm a,\pm b$ はすべて $0$ でない）。よって $4\equiv0$、すなわち $p=2$。∎

**帰結（作業指示の問 1 への答え）.** $d=2$ では、$p$ が奇素数のとき「$\bmod\,p$ で恒等的に消える部分トーラス」が存在しない。
$\lambda_{\mathbf j}\equiv0$ となる指標は**構造的に強制されず散発的**にしか現れないので、$L$ について一様な法則は原理的に立たない。
一方 $p=2$ では零点集合が部分トーラスの合併なので、**すべての $L$ に対して $2(L-1)$ 個の指標が自動的に消える**。これが命題 T の源である。

**$d\ge3$ ではどうなるか.** 定理 E は、$p\le d$ なら $\bmod\,p$ で消える部分トーラスが**存在する**ことを示す
（$d=3$ で $p=2$: $\{x_3=1,\ x_1=x_2^{\pm1}\}$ 等、$p=3$: 対角 $\{x_1=x_2=x_3\}$ 等）。
すなわち「特別な素数」は作業指示の見立てどおり小さい素数だが、条件は $p\mid 2d$ ではなく
**$p\le d$（より正確には $\{1..d\}$ をサイズ $p$ の倍数のブロックに部分分割できること）**である。
増大の指数も $L^{d-1}$ ではなく $L^{\lfloor d/p\rfloor}$ である。

`tau_general_verify.out` の (0) では、$d=3$ の分子 $yz(x^2+1)+xz(y^2+1)+xy(z^2+1)$ が $\mathbb{F}_2$ 上で
**既約**であることを確認した。すなわち $d=3$ の $\bmod\,2$ 零点集合は既約な曲面であり、
その中に定理 E の 1 次元部分トーラスが入っている（曲面全体は部分トーラスの合併ではない）。
**この差が、$d=3$ で下界が等号にならない理由である**（§7.2）。

---

## 7. 見つからなかったもの（clean な法則の不在）

### 7.1 奇素数 $p$、$d=2$

標本: $L=3,\dots,40$、$p<200$、$p\nmid L$（全 $(L,p)$ 組を網羅的に走査。`tau_general_verify.out` の (3)）。

$v_p(\tau_2(L))>0$ となる $(L,p)$ は散在する。素朴な予想「$p\equiv\pm1\pmod L$」には**標本内に反例がある**:

| $L$ | $p$ | $p\bmod L$ | $v_p$ |
|---|---|---|---|
| 13 | 5 | 5 | 8 |
| 21 | 13 | 13 | 8 |
| 25 | 7 | 7 | 16 |
| 27 | 37 | 10 | 8 |
| 33 | 89 | 23 | 8 |
| 35 | 13 | 13 | 8 |
| 39 | 5 | 5 | 8 |

したがって $(p,L)$ の合同条件では書けない。**定理 A/B が与える判定条件**

$$v_p(\tau_2(L))>0\iff \exists j\neq0:\ \bar r_j\in\overline{\mathbb F}_p^\times \text{ の位数が } L \text{ を割る}$$

（$\bar r_j+\bar r_j^{-1}=4-\bar\zeta^{j}-\bar\zeta^{-j}$）**が、得られた「条件」のすべてである**。
これは決定可能で完全だが、閉形の法則ではない。**閉形の法則は見つからなかった。**

観察（法則としては主張しない）: $d=2$ の標本内で $v_p$ はつねに 4 の倍数だった（$L$ 奇では定理 C.1 で証明済み。
$L$ 偶では定理 C.2 が偶数性しか与えず、4 の倍数性は**証明していない**）。
また $v_p=n$（$v_P(\lambda_\chi)>0$ となる指標の個数）となる場合が大半だが、
$(L,p)=(14,13),(28,13),(28,29),(29,17),(30,31)$ では $v_p>n$ であり、**重複度 1 は一般には成り立たない**。

### 7.2 $d=3$

標本: $L=3,\dots,27$（$p=2$ は奇 $L$）、$p\in\{2,3\}$、$p\nmid L$。

$p=2$（$L$ 奇）: 下界 $6(L-1)$（系 E2）は全標本で成立。**等号**は $L=3,5,7,11,13,19,23,25$ で成立し、
$L=9,15,17,21,27$ では成立しない（$L=17$: 下界 $96$ に対し $v_2=288$、$L=15$: 下界 $84$ に対し $v_2=324$、
$L=27$: 下界 $156$ に対し $v_2=348$）。
$p=3$（$3\nmid L$）: 下界 $4(L-1)-3[2\mid L]$ は全標本で成立。等号は $L=5,7,11,14,17,19,22,23,25$ で成立し、
$L=4,8,10,13,16,20,26$ では成立しない。

**したがって $d=3$ には clean な法則が無い。** 下界を超える分は「部分トーラス上に無い散発的な解」であり、
その個数は $\mathrm{ord}_L(p)$ に強く依存する（等号が破れる $L$ はいずれも $\mathrm{ord}_L(p)$ が小さく
$L^d/p^{\mathrm{ord}_L(p)}$ が大きい）。**この観察は説明であって証明ではない。** 散発解の個数の閉形は得ていない。

### 7.3 作業指示の予想 $v_p(\tau_d(L))=c\,(L^{d-1}-1)$ について

**成り立たない。** 系 E1 の指数は $\lfloor d/p\rfloor$ であり、$d-1$ ではない。
実測（$d=4$, $p=2$、`tau_general_verify.out` の (5d)）: $L=5$ で $v_2=208$、$L=7$ で $456$、$L=11$ で $1240$、$L=13$ で $1776$。
$L^{d-1}-1=L^3-1$ は $L=13$ で $2196$ であり、$v_2=1776$ はその定数倍になっていない。
一方 $L^{\lfloor4/2\rfloor}-1=L^2-1$ は $L=13$ で $168$ で、下界として正しい（$1776\ge168$）。

### 7.4 $p\mid L$（分岐）の場合

本 step の定理はすべて $p\nmid L$ を仮定する（補題 1 が破れるため）。
$p\mid L$ では $p$ は $K$ で分岐し、$v_P(1-\zeta^m)>0$ となって $(1.3)$ が使えない。
数値のみ (6) に記録した（$d=2$, $L\le15$）。$L$ が素数のとき $v_L(\tau_2(L))$ は $L=3,5,7,11,13$ で
$6,14,14,22,30$、$L$ が合成数のときは例えば $v_3(\tau_2(9))=28$、$v_3(\tau_2(6))=6$、$v_3(\tau_2(12))=30$、$v_3(\tau_2(15))=6$。
$2L$ や $L$ の関数として単純には書けない。**標本が小さく、法則は主張しない。** 次サイクル以降の課題である。

---

## 8. 既知性・新規性（主張しない）

- **新規性は一切主張しない。**
- 本文を取得できた文献は 1 本のみ:
  **R. Pengo, D. Vallières, "Spanning trees in $\mathbb{Z}$-covers of a finite graph and Mahler measures",
  J. Aust. Math. Soc. 118 (2025), no. 1**（arXiv:2310.15619）。
  abstract を本文（arXiv abstract ページ）から取得して確認した: 「We also express the $p$-adic valuation of the
  number of spanning trees of the finite intermediate graphs in terms of the $p$-adic Mahler measure of the Ihara polynomial.」
  **対象は $\mathbb{Z}$-被覆（階数 1）であり、本 step の $\mathbb{Z}^d$-被覆（$d\ge2$）ではない。**
  また cycle 13（`cycle13_T1_padic_entropy_generality.md`）で確認したとおり、$p$ 進 Mahler 測度は岩澤対数を使うため
  付値部分の情報を落とす。両者の関係は**本 step では確認していない**（論文本文は未読）。
- 検索したが本文を取得できなかった領域（**0 件は根拠にしない。単に未確認と記す**）:
  - 離散トーラス $C_n\times C_n$ の critical group / sandpile group の Sylow $p$ 部分構造。
  - グラフの岩澤理論（Gonet–Vallières、McGown–Vallières、Gambheera–Vallières 系列）における $\mathbb{Z}_p^d$-塔。
    これらは $L=p^n$ の塔であり、本 step の $p\nmid L$ の設定とは**設定が異なる**。
  - Lind–Schmidt–Ward / Everest–Ward 系列の代数的 $\mathbb{Z}^d$-作用の周期点数。$(\infty)$ 側（エントロピー）の結果であり、
    $p$ 進付値の増大則を本文で確認できていない。
- 使った道具（matrix-tree 定理、円分体での不分岐性、$\mathbb{G}_m^d$ の部分トーラス、Laurent 多項式の係数比較）は
  **すべて標準的**である。とくに「$\bmod\,p$ で Laurent 多項式が部分トーラス上で消えることが $p$ 進付値の線型増大を生む」
  という機構は、代数的力学系の $\mu$ 不変量の文脈で **folklore として既知である可能性が高い**と考えるべきである。

---

## 9. 002 への反映と次サイクル

- 命題 T（`002_R_Lambda_duality.md` の確定部分命題）は**変更不要**。本 step はその一般化の射程を定めただけである。
- 追加できる確定部分命題の候補: 定理 A（判定条件・決定可能）、定理 B（主公式）、定理 C（$4\mid v_p$）、
  定理 E（部分トーラス下界）、定理 F（$d=2$・奇 $p$ で部分トーラスなし）。
  いずれも $\Lambda$ 側（有限 $L$ の付値の等式・不等式）で、$\mathbb{R}$ を使わず、決定可能である（選別基準 (i)(ii)(iii)）。
  **002 への反映は本 step では行っていない**（`outputs/paper-plans/` は編集禁止のため）。
- 未解決として次サイクルへ渡す:
  1. $p\mid L$（分岐）の場合の $v_p(\tau_d(L))$。
     同 cycle の `cycle14_T1_vp_growth_two_variable.md`（命題 V）は $L=p^n$ の塔を扱うが、
     $P(1,1)\neq0$ を仮定している。本 step の $P=2d-\sum(x_i+x_i^{-1})$ は $P(1,\dots,1)=0$ なので
     **命題 V はそのままでは適用できない**。両者は設定が排他的で、重複はしていない。
  2. $d\ge3$ の散発解の個数（定理 E の下界と実測の差）の上界。
  3. 定理 E の逆（$p>d$ かつ $p\nmid L$ なら正次元の部分トーラスは存在しないこと）の一般 $d$ での証明。
     $d=2$ は定理 F で証明済みだが、一般 $d$ は**未証明**である。
