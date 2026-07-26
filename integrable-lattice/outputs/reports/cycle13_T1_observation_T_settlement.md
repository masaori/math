# cycle 13 / T1 Reframe step 3: 観察 T の決着

対象: $\tau(L)$ ＝ $L\times L$ トーラス（周期境界の正方格子 $C_L\,\square\,C_L$）の全域木数。

**観察 T**: 奇数 $L$ に対し $v_2(\tau(L))=2(L-1)$（cycle 10 で $L\le11$、cycle 11 で $L\le19$ を確認、未証明のまま `outputs/paper-plans/002_R_Lambda_duality.md` §2 に「検証済みだが未証明の観察」として置かれていた）。

## 決着の形

**(a) 証明できた。**

奇数 $L\ge3$ に対する $v_2(\tau(L))=2(L-1)$ を、円分整数環 $\mathbb{Z}[\zeta_L]$・終結式・$\mathbb{F}_2[x]$ の分離性だけを使って証明した（§3）。
証明は初等的で、$\mathbb{R}$ も $\mathbb{Q}_p$ も使わず、グラフの岩澤理論も使わない。

副産物として:

- 恒等式 $\tau(L)=L^2R_L^4$（奇数 $L$、$R_L\in\mathbb{Z}$ は明示的な終結式）。
- **偶数 $L$ の観察 T'**（新たに得た規則、**未証明**）: $s:=v_2(L)$ として $v_2(\tau(L))=(2s+4)L-(6s+1)$。$L=2,4,\dots,128$ の 64 例で一致。

新規性については §5 のとおり **主張しない**（文献本文で「既出でない」ことを確認できていない）。

---

## 1. 標本の拡大（厳密整数計算）

スクリプト `sagemath/check/cycle13_T1_tau_v2/tau_v2_evidence.sage`、出力 `tau_v2_evidence.out`（SageMath 10.6）。

計算法は Kirchhoff の matrix-tree 定理と等価な標準の積公式

$$\tau(L)=\frac1{L^2}\prod_{(j,k)\neq(0,0)}\Bigl(4-2\cos\tfrac{2\pi j}{L}-2\cos\tfrac{2\pi k}{L}\Bigr)$$

を $\mathbb{Z}[x]$ 上の終結式へ書き直したもの（導出は §2 の Lemma 1・Proposition 4 の途中）:

$$\tau(L)=\operatorname{Res}_x\bigl(f_L(x)/(x-2),\ f_L(4-x)\bigr),\qquad f_L(x)=\prod_{k=0}^{L-1}\bigl(x-(\zeta_L^k+\zeta_L^{-k})\bigr)\in\mathbb{Z}[x].$$

整数演算のみで浮動小数を使わない。$f_L$ は漸化式 $p_n=xp_{n-1}-p_{n-2}$（$p_0=2,p_1=x$）で構成する。

**方法の照合**: $L=3,\dots,12$ で、この終結式と Sage の `spanning_trees_count`（実グラフ $C_L\,\square\,C_L$ 上の Kirchhoff 行列式）が**全て一致**した。

### 奇数 $L$

| 検査範囲 | 個数 | $v_2(\tau(L))\ne 2(L-1)$ となった $L$ |
|---|---|---|
| $L=3,5,\dots,301$（全て） | 150 | なし |
| $L=311,321,\dots,501$ | 20 | なし |

合計 **170 例で全一致**（cycle 11 時点の 9 例から拡大）。所要 233 秒。

**この 170 例は証明ではない。** 証明は §3 にある。ここでの標本拡大の役割は、証明を書く前に主張が壊れていないことを確認することと、証明の各段（§4）を機械照合する土台を作ることである。

### 偶数 $L$（奇偶の違いの記録）

$L=2,4,\dots,128$ の 64 例を計算した。$s:=v_2(L)$ とおく。

| $L$ | 2 | 4 | 6 | 8 | 10 | 12 | 16 | 24 | 32 | 64 | 128 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| $s$ | 1 | 2 | 1 | 3 | 1 | 2 | 4 | 3 | 5 | 6 | 7 |
| $v_2(\tau(L))$ | 5 | 19 | 29 | 61 | 53 | 83 | 167 | 221 | 417 | 987 | 2261 |
| $2(L-1)$ | 2 | 6 | 10 | 14 | 18 | 22 | 30 | 46 | 62 | 126 | 254 |

奇数則 $2(L-1)$ から系統的に大きく外れる。**奇数則は偶数へ延びない。**

**観察 T'（未証明）**: 偶数 $L$ に対し

$$v_2(\tau(L)) \;=\; (2s+4)\,L-(6s+1),\qquad s=v_2(L).$$

$L=2,4,\dots,128$ の **64 例すべてで一致**（`tau_v2_evidence.out` §C）。$s$ が同じなら $L$ の奇部分に依らない。$s=0$（奇数）を代入すると $4L-1$ となり実測 $2L-2$ と食い違うので、この式は奇数へ延びない（＝奇偶で本当に別のレジームである）。

偶数 $L$ については §3 の証明の途中まで平行に走る（`tau_v2_proof_check.sage` 末尾で確認）:

$$f_L(x)=(x-2)(x+2)\,n_L(x)^2,\qquad
\tau(L)=\frac{L^2P_L^4}{2}\,S_L^4,\quad S_L=\operatorname{Res}\bigl(n_L(x),n_L(4-x)\bigr),$$

ここで $P_L$ は Pell 数（$P_0=0,P_1=1,P_{n}=2P_{n-1}+P_{n-2}$）。$L=2,\dots,40$ の偶数で恒等式を確認済み。また $v_2(P_L)=v_2(L)$（$L$ 偶数、$L\le28$ で確認）。これらを認めると

$$v_2(\tau(L))=6s-1+4\,v_2(S_L)$$

なので、観察 T' は $v_2(S_L)=\frac{(s+2)L}{2}-3s$ と同値（$L\le40$ の偶数で確認）。
**この最後の等式は証明していない。** 奇数の場合に効いた「$m_L(4-a)$ の 2 進的相殺がちょうど 1 回で止まる」（§3 Lemma 5 + Lemma 6）が偶数では成り立たず、相殺が $s$ に依存して何度も起きるためである。観察 T' は cycle 14 以降の課題。

---

## 2. cycle 12 T3 の判定式 $(☆)$ はこの族に適用できるか

スクリプト `sagemath/check/cycle13_T1_tau_v2/content_criterion_torus.sage`、出力 `content_criterion_torus.out`。

cycle 12 T3（`sagemath/check/cycle12_T3_nonzero_mu_p/README.md`）で得たのは、**1 変数 voltage** $\alpha:E(X)\to\mathbb{Z}$ をもつ有限連結多重グラフ $X$ の abelian $\ell$-tower $\{X_{\ell^n}\}$ について

$$(★)\quad \kappa(X_N)=\frac{\kappa(X)}{N}\prod_{\zeta^N=1,\ \zeta\ne1}\det L(\zeta),
\qquad
(☆)\quad \mu_\ell=v_\ell\bigl(\mathrm{content}_z\det L(z)\bigr)$$

である。$(☆)$ は $\mathbb{Z}_\ell[[T]]$（$z=1+T$）上の Weierstrass 準備定理に依る。

### 結論: 観察 T にはそのまま適用できない。理由は 2 つ、どちらも致命的。

1. **変数の数**。$L\times L$ トーラスは 1 頂点＋2 ループの底グラフの $\mathbb{Z}^2$-voltage 被覆であり、voltage ラプラシアンは 2 変数
   $$\det L(z,w)=4-z-z^{-1}-w-w^{-1}.$$
   $(☆)$ の導出（1 変数の Weierstrass 準備定理）はここには直接乗らない。

2. **塔の向き**。観察 T は $L$ を**奇数**で動かす。$\ell=2$ に対して $N=L$ は $\ell$ と互いに素であり、$\{L\times L\}_{L\ \text{odd}}$ は $2$-tower ではない。これは $p\ne\ell$ の状況（Washington–Sinnott 型、arXiv:2201.05186 系）であって、$\mu_\ell$ の定義自体が当てはまらない。

**使ってから気づいたのではなく、使う前に確認した**（本プロジェクトの規約）。

### では $(☆)$ が実際に使える部分族はどこか（確認して記録する）

幅 $W$ を固定した $W\times N$ トーラスの族は 1 変数である。底グラフ $X_W$ ＝ サイクル $C_W$ の各頂点に voltage $1$ のループを 1 本、その $\mathbb{Z}/N$ 導来グラフが $W\times N$ トーラス。$N=2^n$ が abelian $2$-tower なので $(☆)$ の設定にそのまま乗る。

$W=2,\dots,9$ で計算した結果:

- どの $W$ でも $\mathrm{content}_z\det L_W(z)=1$、したがって $(☆)$ の予測は $\mu_2=0$。
- 実測 $v_2\bigl(\tau(W\times 2^n)\bigr)$（$n=1..7$）は、$n$ が十分大きいところで**$n$ の 1 次**（差分が一定）。すなわち $\mu\cdot2^n$ の項が無く $\mu_2=0$。$(☆)$ の予測と一致する。
  - 例: $W=3$: $v_2=1,2,3,4,5,6,7$（差分 $1$）。$W=4$: $8,19,26,33,40,47,54$（差分 $11,7,7,7,7,7$）。$W=8$: $11,26,61,76,91,106,121$（差分 $15,35,15,15,15,15$）。最初の 1–2 段は $\nu$ の効果でずれるが、以降は線形。
- $\tau(W\times N)$ の計算式（$\frac{N}{W}\operatorname{Res}(f_W/(x-2),f_N(4-x))$）は $W\times N$ の実グラフの `spanning_trees_count` と 6 例で照合済み。

**ただしこれは $N=2^n$（偶数方向）の話であり、観察 T（$L$ 奇数）とは別方向である。** $(☆)$ は観察 T の証明には寄与しない。

### 整合性の注記（証明ではない）

2 変数 $\det L(z,w)=4-z-z^{-1}-w-w^{-1}$ の content は $1$。2 変数岩澤理論の類推で「$\mu=0$」と読むなら、$v_2(\tau(L))$ は頂点数 $L^2$ に比例して伸びてはいけない。実際 $2(L-1)$ は $L$ の 1 次で $L^2$ に対し劣線形であり、整合する。**これは整合であって導出ではない。** $2(L-1)$ という具体値は出てこない。

---

## 3. 証明

以下、$L\ge3$ は**奇数**、$h:=\frac{L-1}{2}$、$\zeta$ は $1$ の原始 $L$ 乗根、$a_k:=\zeta^k+\zeta^{-k}\in\mathbb{Z}[\zeta]$（$k=0,\dots,L-1$）とする。$a_k=2\cos\frac{2\pi k}{L}$ だが、以下 $\mathbb{R}$ は一切使わない（$\mathbb{Z}[\zeta]$ の元として扱う）。

出発点は標準の積公式（Kirchhoff の matrix-tree 定理を、$(\mathbb{Z}/L)^2$ の指標によるラプラシアンの対角化と併せたもの）:

$$\tau(L)=\frac1{L^2}\prod_{(j,k)\ne(0,0)}\bigl(4-a_j-a_k\bigr). \tag{3.0}$$

### Lemma 1

$$f_L(x):=\prod_{k=0}^{L-1}(x-a_k)$$
は $\mathbb{Z}[x]$ のモニックな $L$ 次多項式で、$p_0=2,\ p_1=x,\ p_n=x\,p_{n-1}-p_{n-2}$ で定まる $p_n\in\mathbb{Z}[x]$ により $f_L=p_L-2$ と書ける。

*証明.* 環準同型 $\iota:\mathbb{Z}[x]\to\mathbb{Z}[t,t^{-1}]$, $x\mapsto t+t^{-1}$ を考える。$\iota$ は単射である（$\deg_x g=n$ なら $\iota(g)$ の $t^n$ の係数は $g$ の主係数で、$\iota(g)$ の $t$ 次数はちょうど $n$）。
帰納法で $\iota(p_n)=t^n+t^{-n}$: $n=0,1$ は定義。$\iota(p_n)=(t+t^{-1})(t^{n-1}+t^{-(n-1)})-(t^{n-2}+t^{-(n-2)})=t^n+t^{-n}$。
一方
$$\iota(f_L)=\prod_{k=0}^{L-1}\bigl(t+t^{-1}-\zeta^k-\zeta^{-k}\bigr)
=\prod_{k=0}^{L-1}t^{-1}(t-\zeta^k)(t-\zeta^{-k})
=t^{-L}(t^L-1)^2=t^L-2+t^{-L},$$
ここで $\{\zeta^k\}_k=\{\zeta^{-k}\}_k$ を使った。よって $\iota(f_L)=\iota(p_L-2)$ となり、$\iota$ の単射性から $f_L=p_L-2\in\mathbb{Z}[x]$。$\square$

### Lemma 2

$$m_L(x):=\prod_{j=1}^{h}(x-a_j)$$
は $\mathbb{Z}[x]$ のモニックな $h$ 次多項式で、
$$f_L(x)=(x-2)\,m_L(x)^2 .$$

*証明.* $a_0=2$。$j\mapsto L-j$ は $\{1,\dots,L-1\}$ 上の involution で、$L$ が奇数だから $j=L-j$ となる $j$ は無い（固定点なし）。かつ $a_j=a_{L-j}$。よって重複度込みの多重集合として $\{a_k\}_{k=0}^{L-1}=\{2\}\uplus 2\cdot\{a_1,\dots,a_h\}$ であり、$f_L(x)=(x-2)\prod_{j=1}^h(x-a_j)^2$。
$m_L$ の係数は $a_1,\dots,a_h$ の基本対称式（符号込み）で、代数的整数である。$\mathrm{Gal}(\mathbb{Q}(\zeta)/\mathbb{Q})$ の元 $\sigma_c:\zeta\mapsto\zeta^c$（$\gcd(c,L)=1$）は $a_j\mapsto a_{cj\bmod L}$ を与え、$a_{cj}=a_{L-cj}$ だから、$\{1,\dots,h\}$ を $\pm$ 類の代表系とみて $\sigma_c$ は多重集合 $\{a_1,\dots,a_h\}$ を保つ。よって係数は Galois 不変な代数的整数、すなわち $\mathbb{Z}$ の元。$\square$

### Lemma 3

$$m_L(2)^2=L^2,\qquad m_L(0)^2=1 .$$
特に $m_L(0)$ は奇数。

*証明.* Lemma 2 の対応より
$$m_L(2)^2=\prod_{j=1}^h(2-a_j)^2=\prod_{k=1}^{L-1}(2-a_k)
=\prod_{k=1}^{L-1}\bigl(2-\zeta^k-\zeta^{-k}\bigr)
=\prod_{k=1}^{L-1}\bigl(-\zeta^{-k}\bigr)(\zeta^k-1)^2 .$$
$\prod_{k=1}^{L-1}(-\zeta^{-k})=(-1)^{L-1}\zeta^{-L(L-1)/2}$。$L$ 奇数より $(-1)^{L-1}=1$、また $\frac{L-1}{2}\in\mathbb{Z}$ なので $L\mid \frac{L(L-1)}{2}$、よって $\zeta^{-L(L-1)/2}=1$。
$\prod_{k=1}^{L-1}(x-\zeta^k)=\frac{x^L-1}{x-1}=1+x+\cdots+x^{L-1}$ を $x=1$ で評価して $\prod_{k=1}^{L-1}(1-\zeta^k)=L$、よって $\prod_{k=1}^{L-1}(\zeta^k-1)=(-1)^{L-1}L=L$。以上より $m_L(2)^2=L^2$。

同様に
$$m_L(0)^2=\prod_{k=1}^{L-1}(-a_k)=\prod_{k=1}^{L-1}\bigl(-\zeta^{-k}\bigr)\bigl(\zeta^{2k}+1\bigr)=\prod_{k=1}^{L-1}\bigl(1+\zeta^{2k}\bigr).$$
$L$ 奇数より $2$ は $\bmod L$ 可逆で $k\mapsto 2k$ は $\{1,\dots,L-1\}$ の置換、よって $=\prod_{k=1}^{L-1}(1+\zeta^{k})$。
$\prod_{k=0}^{L-1}(x-\zeta^k)=x^L-1$ を $x=-1$ で評価すると $(-1)^L-1=-2$ かつ左辺 $=(-1)^L\prod_{k=0}^{L-1}(1+\zeta^k)=-\prod_{k=0}^{L-1}(1+\zeta^k)$。よって $\prod_{k=0}^{L-1}(1+\zeta^k)=2$、$k=0$ の因子 $2$ を除いて $\prod_{k=1}^{L-1}(1+\zeta^k)=1$。$\square$

（$m_L(2)=+L$ も真だが、以下では $m_L(2)^2=L^2$ しか使わない。符号の決定には $\mathbb{R}$ 上の正値性が要るので、使わないでおく。）

### Proposition 4

$$\tau(L)=L^2\,R_L^4,\qquad R_L:=\operatorname{Res}_x\bigl(m_L(x),\,m_L(4-x)\bigr)=\prod_{j=1}^{h}m_L(4-a_j)\in\mathbb{Z}.$$

*証明.* (3.0) の積を $j=0$ と $j\ge1$ に分ける。
$j=0$ の寄与は $\prod_{k=1}^{L-1}(4-a_0-a_k)=\prod_{k=1}^{L-1}(2-a_k)=L^2$（Lemma 3 の計算そのもの）。
$j\ge1$ の寄与は $\prod_{k=0}^{L-1}(4-a_j-a_k)=f_L(4-a_j)$。
よって $L^2\tau(L)=L^2\prod_{j=1}^{L-1}f_L(4-a_j)$、すなわち
$$\tau(L)=\prod_{j=1}^{L-1}f_L(4-a_j)=\Bigl[\prod_{j=1}^{h}f_L(4-a_j)\Bigr]^2$$
（$a_j=a_{L-j}$ による対合、Lemma 2 と同じ）。Lemma 2 より
$$f_L(4-a_j)=\bigl((4-a_j)-2\bigr)\,m_L(4-a_j)^2=(2-a_j)\,m_L(4-a_j)^2 ,$$
したがって
$$\tau(L)=\Bigl[\prod_{j=1}^h(2-a_j)\Bigr]^2\cdot\Bigl[\prod_{j=1}^h m_L(4-a_j)\Bigr]^4=m_L(2)^2\,R_L^4=L^2R_L^4 .$$
$m_L$ はモニックだから $\operatorname{Res}(m_L,g)=\prod_{m_L(\beta)=0}g(\beta)$ であり、整数係数多項式の終結式として $R_L\in\mathbb{Z}$。$\square$

### Lemma 5

$$D_L(x):=\frac{m_L(4-x)-m_L(x)}{2}\ \in\ \mathbb{Z}[x],$$
かつ $\mathbb{F}_2[x]$ において $\overline{D_L}=x\cdot\overline{m_L}'$（$\overline{\ \cdot\ }$ は $\bmod\,2$ 還元、$'$ は $x$ による微分）。

*証明.* $m_L=\sum_i c_ix^i$（$c_i\in\mathbb{Z}$）と書く。各 $i$ について
$$(4-x)^i=\sum_{r=0}^{i}\binom{i}{r}4^r(-x)^{i-r}\equiv(-x)^i \pmod 4$$
（$r\ge1$ の項は $4$ で割れる）。よって $m_L(4-x)\equiv m_L(-x)\pmod 4$（$\mathbb{Z}[x]$ 内）。したがって
$$D_L=\underbrace{\frac{m_L(-x)-m_L(x)}{2}}_{=:E}+\underbrace{\frac{m_L(4-x)-m_L(-x)}{2}}_{\in\,2\mathbb{Z}[x]} .$$
$E=\sum_i c_i\frac{(-1)^i-1}{2}x^i=-\sum_{i\ \text{odd}}c_ix^i\in\mathbb{Z}[x]$。よって $D_L\in\mathbb{Z}[x]$ かつ
$$\overline{D_L}=\overline{E}=\sum_{i\ \text{odd}}\overline{c_i}\,x^i=x\sum_{i\ \text{odd}}\overline{c_i}\,x^{i-1}=x\cdot\overline{m_L}'$$
（$\mathbb{F}_2$ 上 $\overline{m_L}'=\sum_i i\,\overline{c_i}x^{i-1}=\sum_{i\ \text{odd}}\overline{c_i}x^{i-1}$）。$\square$

### Lemma 6

$\operatorname{disc}(m_L)$ は奇数。同値に、$\overline{m_L}\in\mathbb{F}_2[x]$ は分離的、すなわち $\gcd(\overline{m_L},\overline{m_L}')=1$。

*証明.* $a_1,\dots,a_h$ は相異なる（$a_i=a_j$ ⟺ $\zeta^i\in\{\zeta^j,\zeta^{-j}\}$ ⟺ $i\equiv\pm j$、$1\le i,j\le h<L/2$ では $i=j$ のみ）。$m_L$ はモニックなので
$$\operatorname{disc}(m_L)=\prod_{1\le i<j\le h}(a_i-a_j)^2 .$$
直接展開により
$$(\zeta^i-\zeta^j)(1-\zeta^{-(i+j)})=\zeta^i-\zeta^{-j}-\zeta^j+\zeta^{-i}=a_i-a_j .$$
$1\le i<j\le h$ のとき $0<|i-j|<L$ かつ $0<i+j\le L-1<L$ だから、
$\zeta^i-\zeta^j=\zeta^j(\zeta^{i-j}-1)$ と $1-\zeta^{-(i+j)}$ はいずれも $\zeta^{\bullet}$（単元）と $1-\zeta^{k}$（$1\le k\le L-1$）の形の因子の積である。
Lemma 3 の計算より $\prod_{k=1}^{L-1}(1-\zeta^k)=L$ なので、各 $1-\zeta^k$ は $\mathbb{Z}[\zeta]$ で $L$ を割る。$L$ は奇数だから、$2$ の上にあるどの素イデアル $\mathfrak{p}\subset\mathbb{Z}[\zeta]$ についても $1-\zeta^k\notin\mathfrak{p}$（もし入れば $L\in\mathfrak{p}$ となり $\mathfrak{p}\cap\mathbb{Z}=2\mathbb{Z}$ に矛盾）。単元 $\zeta^j$ も $\mathfrak{p}$ に入らない。$\mathfrak{p}$ は素イデアルだから、これらの積である $a_i-a_j$ も $\mathfrak{p}$ に入らず、さらにその総積 $\operatorname{disc}(m_L)$ も $\mathfrak{p}$ に入らない。
$\operatorname{disc}(m_L)\in\mathbb{Z}$ なので、もし $2\mid\operatorname{disc}(m_L)$ なら $\operatorname{disc}(m_L)\in\mathfrak{p}$ となり矛盾。よって $\operatorname{disc}(m_L)$ は奇数。

$m_L$ はモニックなので $\operatorname{disc}(\overline{m_L})=\overline{\operatorname{disc}(m_L)}\ne0$（次数が落ちないので判別式は還元と可換）。よって $\overline{m_L}$ は $\overline{\mathbb{F}_2}$ 上重根をもたない、すなわち分離的。分離的なら $\gcd(\overline{m_L},\overline{m_L}')=1$: 実際、既約 $\pi$ が $\overline{m_L}$ と $\overline{m_L}'$ を共に割るとする。$\overline{m_L}=\pi g$ と書くと分離性から $\pi\nmid g$、$\overline{m_L}'=\pi'g+\pi g'$ より $\pi\mid\pi'g$、よって $\pi\mid\pi'$。$\deg\pi'<\deg\pi$ だから $\pi'=0$、これは $\pi\in\mathbb{F}_2[x^2]$ を意味し、$\mathbb{F}_2$ が完全体なので $\pi$ は $\mathbb{F}_2[x]$ で平方、$\deg\pi\ge1$ の既約性に矛盾。$\square$

### 定理（観察 T）

**任意の奇数 $L\ge3$ に対し $v_2(\tau(L))=2(L-1)$。**

*証明.* Lemma 5 より $\mathbb{Z}[x]$ において $m_L(4-x)=m_L(x)+2D_L(x)$。$m_L$ の根 $a_j$（$1\le j\le h$）で評価すると $m_L(a_j)=0$ なので
$$m_L(4-a_j)=2\,D_L(a_j).$$
よって Proposition 4 の $R_L$ について
$$R_L=\prod_{j=1}^{h}m_L(4-a_j)=2^{h}\prod_{j=1}^{h}D_L(a_j)=2^{h}\operatorname{Res}(m_L,D_L).$$
$m_L$ はモニックなので $\operatorname{Res}(m_L,D_L)\in\mathbb{Z}$ であり、その $\bmod\,2$ 還元は $\prod_{\overline{m_L}(\beta)=0}\overline{D_L}(\beta)$（$\overline{\mathbb{F}_2}$ 内、重複度込み）に等しい。これが $0$ でないことは $\gcd(\overline{m_L},\overline{D_L})=1$ と同値。
Lemma 5 より $\overline{D_L}=x\cdot\overline{m_L}'$。Lemma 3 より $\overline{m_L}(0)=\overline{m_L(0)}=1\ne0$ なので $\gcd(\overline{m_L},x)=1$。Lemma 6 より $\gcd(\overline{m_L},\overline{m_L}')=1$。よって $\gcd(\overline{m_L},\overline{D_L})=1$、すなわち $\operatorname{Res}(m_L,D_L)$ は奇数。
したがって $v_2(R_L)=h=\frac{L-1}{2}$。Proposition 4 と $L$ が奇数（$v_2(L^2)=0$）より
$$v_2(\tau(L))=v_2(L^2)+4\,v_2(R_L)=0+4\cdot\tfrac{L-1}{2}=2(L-1). \qquad\blacksquare$$

### $L$ が奇数であることを使った箇所（＝偶数で崩れる箇所）

1. Lemma 2: $j\mapsto L-j$ が固定点をもたない。偶数では $j=L/2$ が固定点（$a_{L/2}=-2$）で、$f_L=(x-2)(x+2)n_L^2$ となり因子が 1 つ増える。
2. Lemma 3: $\zeta^{-L(L-1)/2}=1$（偶数では $=-1$）、および $2$ が $\bmod L$ 可逆（偶数では不可逆）。
3. Lemma 6: $1-\zeta^k$ が $L\mid$ より $2$ と互いに素（偶数では $2$ を割りうる ⇒ $\operatorname{disc}$ が偶数になりうる ⇒ $\overline{m_L}$ が非分離 ⇒ 相殺が 1 回で止まらない）。
4. 最後の $v_2(L^2)=0$。

この 4 箇所がすべて偶数では成り立たず、実測（§1）でも別レジームになっていることと整合する。

### 使った道具の水準（本プロジェクトの選別基準との対応）

- $\mathbb{Z}[\zeta_L]$（円分整数環）、$\mathbb{Z}[x]$ の終結式、$\mathbb{F}_2[x]$ の分離性。すべて可算・有限手続き。
- $\mathbb{R}$ を使わない。$\mathbb{Q}_p$ も $\mathbb{Z}_\ell[[T]]$ も使わない（グラフの岩澤理論を経由しない）。
- $\mathbb{Q}_p$ を使わずに $v_2$ を扱うという 002 の方針（`outputs/paper-plans/002_R_Lambda_duality.md` §3）とそのまま整合する。
- 原理的に形式検証可能: 各 Lemma は「$\mathbb{Z}[x]$ の等式」「$\mathbb{F}_2[x]$ の gcd」「$\mathbb{Z}[\zeta]$ の素イデアルに関する非所属」に還元される。ただし $L$ について一様な形式化には円分体の基本事実（$\prod(1-\zeta^k)=L$、判別式の還元）が要り、**本サイクルでは Lean 化していない**。

---

## 4. 証明の機械照合

スクリプト `sagemath/check/cycle13_T1_tau_v2/tau_v2_proof_check.sage`、出力 `tau_v2_proof_check.out`。

$L=3,5,\dots,81$（40 例）について、§3 の各段が主張どおりであることを実際に計算して `assert` した。

| 段 | 照合内容 | 結果 |
|---|---|---|
| Lemma 1–2 | $f_L=(x-2)m_L^2$、$m_L$ がモニック $h$ 次で $\mathbb{Z}[x]$ の元 | 40/40 |
| Lemma 3 | $m_L(2)=L$、$m_L(0)=\pm1$ | 40/40 |
| Proposition 4 | $\tau(L)=L^2R_L^4$（$\tau$ は §1 の独立計算） | 40/40 |
| Lemma 5 前半 | $m_L(4-x)-m_L(x)$ の全係数が偶数 | 40/40 |
| Lemma 5 後半 | $\overline{D_L}=x\cdot\overline{m_L}'$ | 40/40 |
| Lemma 6 | $\operatorname{disc}(m_L)$ が奇数、かつ $\gcd(\overline{m_L},\overline{m_L}')=1$ | 40/40 |
| 定理 | $v_2(R_L)=h$ かつ $v_2(\tau(L))=2(L-1)$ | 40/40 |

補助的に、Lemma 3 で使った $\prod_{k=1}^{L-1}(2-\zeta^k-\zeta^{-k})=L^2$ と $\prod_{k=1}^{L-1}(1+\zeta^k)=1$ を `CyclotomicField` 上で直接確認（$L=3,5,7,9,15,21,25$）。

**これは証明の代用ではなく、証明の書き写しミスを検出するための照合である。** §3 の議論は $L$ について一様な演繹であり、有限個の $L$ での確認に依存していない。

---

## 5. 文献確認（新規性の扱い）

証明できたので文献確認の目的は「既出かどうか」の判定に変わる。本セッションで確認できたこと・できなかったことを分ける。

### 確認できたこと

- **OEIS A212800**（$(n,n)$-トーラス格子グラフの全域木数）: $\tau(L)$ の値そのものは登録済み。コメント・数式欄には **$2$ 進付値についても $\tau=L^2R^4$ 型の分解についても記述が無い**（本セッションで全文取得・確認）。漸近式（Kotesovec, 2021）と Kreweras 1978 への参照があるのみ。
- **arXiv:1711.00175**「The number of spanning trees in circulant graphs, its arithmetic properties and asymptotic」: 「$\tau(n)=p\,n\,a(n)^2$」という**構造的に近い分解**を証明している。ただし ar5iv 版本文で確認したところ、**対象は 1 次元の circulant graph $C_n(s_1,\dots,s_k)$ のみで 2 次元トーラスを扱っておらず、$p$ 進付値も計算していない**（$p$ は「$n$ の偶奇で決まる自然数」であって素点ではない）。本稿の $\tau(L)=L^2R_L^4$ はその 2 次元版に相当するが、同一の主張ではない。
- **arXiv:2310.15619**「Spanning trees in $\mathbb{Z}$-covers of a finite graph and Mahler measures」: 全域木数の $p$ 進付値を $p$ 進 Mahler 測度で表す。ただし abstract で確認した限り **$\mathbb{Z}$-被覆（1 変数）のみ**で、$\mathbb{Z}^2$-被覆・離散トーラスは対象外。
- **グラフの岩澤理論**（Vallières / McGown–Vallières / Gonet 系、および $\mathbb{Z}_p^d$・重み付きグラフへの拡張 arXiv:2412.01612, 2606.03579 等）: 塔の添字が $\ell$ 冪の場合を扱う。観察 T は $\ell=2$ に対し添字 $L$ が奇数（$\ell$ と互いに素）なので、この枠組みの直接の対象ではない（§2 と同じ理由）。

### 確認できなかったこと（既知と書かない／新規とも書かない）

- 「奇数 $L$ で $v_2(\tau(L))=2(L-1)$」および「$\tau(L)=L^2R_L^4$」が、離散トーラスの全域木数を扱う文献（Kreweras 1978, arXiv:1312.4389 等）の**本文に既出かどうか**。本セッションのツールでは arXiv の PDF 本文を機械可読テキストとして取得できたのは ar5iv HTML がある 1711.00175 のみで、他は abstract 止まりである。
- したがって **本稿は新規性を主張しない。** 主張するのは「$L\le19$ の数値観察だった命題を、$L$ について一様な証明に置き換えた」というプロジェクト内の状態変化だけである。

---

## 6. 002（paper-plan）への影響

`outputs/paper-plans/002_R_Lambda_duality.md` は他エージェントが編集中のため**本セッションでは編集しない**。反映すべき内容を以下に記す。

- §2「検証済みだが未証明の観察」の**観察 T は解消**。$\Lambda$ 側の確定命題（A/B/C/N/L の列）に「命題 T」として移してよい:
  > **命題 T.** $\tau(L)$ を $L\times L$ トーラスの全域木数とする。奇数 $L\ge3$ に対し $\tau(L)=L^2R_L^4$（$R_L=\operatorname{Res}(m_L(x),m_L(4-x))\in\mathbb{Z}$、$m_L$ は $f_L=(x-2)m_L^2$ で定まるモニック整多項式）であり、$v_2(\tau(L))=2(L-1)$。
  証明は $\mathbb{Z}[\zeta_L]$・終結式・$\mathbb{F}_2[x]$ の分離性のみを使い、$\mathbb{R}$ も $\mathbb{Q}_p$ も使わない。
- §5 の構成案 8「スコープと限界」の「観察 T は未証明」は**削除**してよい。代わりに**観察 T'（偶数 $L$）が未証明**として残る。
- §7 `resolved_risk` の「観察 T が既に文献にある可能性は高く、未確認」は**そのまま残す**（§5 のとおり既出性は未確認）。証明が付いたことは既出性リスクを下げない。
- §6 の検証対応表に `sagemath/check/cycle13_T1_tau_v2/`（3 スクリプト＋`README.md`＋`.out`）を追加。
- G1（双対命題 D の一般性）は**本 step では動いていない**。観察 T の決着は G1 のボトルネックではない（G1 は cycle 13 step 1 の担当）。

## 7. 限界（正直に）

- **証明したのは奇数 $L$ の場合のみ。** 偶数 $L$ の観察 T' は未証明（§1）。
- **既出性は未確認**（§5）。新規性を主張しない。
- 一般の $v_p(\tau(L))$（$p$ 奇素数）は依然として円分的で per-prime（cycle 10 の整理のまま）。本証明は $p=2$ に特有の議論（$4\equiv0$、$\overline{D_L}=x\overline{m_L}'$）を使っており、奇素数へはそのまま延びない。
- Lean 等での形式検証はしていない（§3 末尾）。
- §1 の数値は有限標本（奇 170 例・偶 64 例）であり、それ自体は根拠にしていない。奇数側の根拠は §3 の証明、偶数側（観察 T'）は**根拠が標本しかない＝未証明**である。
