# cycle 13 / T1: 観察 T の決着 — 奇 $L$ で $v_2(\tau(L))=2(L-1)$ の証明

対象: `outputs/paper-plans/002_R_Lambda_duality.md` §2「検証済みだが未証明の観察」に置かれていた**観察 T**。
$\tau(L)$ を $L\times L$ トーラス（周期境界の正方格子 $C_L\times C_L$）の全域木数とするとき、

$$\textbf{奇数 } L \text{ に対し } v_2(\tau(L))=2(L-1).$$

**決着の形: (a) 証明できた。** 以下 §3 に完全な証明を置く。
新規性は主張しない（§5）。数値検証は `sagemath/check/cycle13_T1_tau_v2/`（実行ログ `tau_v2_verify.out`）。

---

## 1. 数値の現状（一次情報）

`sagemath/check/cycle13_T1_tau_v2/tau_v2_verify.sage` で、$\tau(L)$ を Kirchhoff の matrix-tree 定理により
**厳密整数**（$L^2-1$ 次の整数行列式）として計算した。

| $L$ | 偶奇 | $v_2(\tau(L))$ | $2(L-1)$ | 一致 |
|---|---|---|---|---|
| 2 | 偶 | 5 | — | —（注: $L=2$ では $\pm e_i$ が一致して多重辺になる。値は辺を 2 重に数える規約に依存する。奇 $L$ の定理には無関係） |
| 3 | 奇 | 4 | 4 | ✓ |
| 4 | 偶 | 19 | — | — |
| 5 | 奇 | 8 | 8 | ✓ |
| 6 | 偶 | 29 | — | — |
| 7 | 奇 | 12 | 12 | ✓ |
| 8 | 偶 | 61 | — | — |
| 9 | 奇 | 16 | 16 | ✓ |
| 10 | 偶 | 53 | — | — |
| 11 | 奇 | 20 | 20 | ✓ |
| 12 | 偶 | 83 | — | — |
| 13 | 奇 | 24 | 24 | ✓ |
| 14 | 偶 | 77 | — | — |
| 15 | 奇 | 28 | 28 | ✓ |
| 17 | 奇 | 32 | 32 | ✓ |

**偶数 $L$ を今回はじめて計算した**。値は 5, 19, 29, 61, 53, 83, 77 と $2(L-1)$ から大きく外れ、単調でもない。
観察 T は**奇 $L$ 限定の主張**であることが一次情報から確認できる（§3 の証明は、なぜ偶 $L$ で崩れるかも説明する。§4）。

さらに **matrix-tree とは独立の経路**でも計算した（`tau_v2_verify.out` の (5)）。
$D(x):=s_L(4-x-x^{-1})-2$ を $\mathbb{Z}[x]/(x^L-1)$ 上で漸化式から構成し、
$\tau(L)=\prod_{j=1}^{L-1}D(\zeta^j)=\mathrm{Res}\bigl(\tfrac{x^L-1}{x-1},\,D(x)\bigr)$ を整数終結式として求める経路である。
これにより **$L=3,5,\dots,19,21,25,27,33,35$**（合成奇数 $9,15,21,25,27,33,35$ を含む）で $v_2(\tau(L))=2(L-1)$ を確認した。
とくに証明が $L$ の**素数性を使っていない**ことの確認になっている（$L=19$ もこの経路で計算した）。

**証明が付いた以上、標本の範囲は主張の根拠ではない。** 上記はいずれも証明との整合性確認である。

---

## 2. 記号と準備

- $L\ge3$ を奇数、$\zeta=\zeta_L=e^{2\pi i/L}$ を 1 の原始 $L$ 乗根、$K=\mathbb{Q}(\zeta_L)$。
- $C_L\times C_L$ は有限アーベル群 $(\mathbb{Z}/L)^2$ の Cayley グラフ（生成元 $\pm e_1,\pm e_2$）。$L\ge3$ なので単純グラフ。
- $\tau(L)$ はその全域木数。

### 補題 0（固有値）

$(\mathbb{Z}/L)^2$ 上の Cayley グラフのラプラシアン $\Delta$ は群の指標で対角化され、固有値は
$$\lambda_{j,k}=4-\zeta^{j}-\zeta^{-j}-\zeta^{k}-\zeta^{-k},\qquad (j,k)\in(\mathbb{Z}/L)^2 .$$

*証明.* 指標 $\chi_{j,k}(a,b)=\zeta^{ja+kb}$ は $\Delta$ の固有ベクトルで、
$(\Delta\chi_{j,k})(a,b)=\bigl(4-\zeta^{j}-\zeta^{-j}-\zeta^{k}-\zeta^{-k}\bigr)\chi_{j,k}(a,b)$。
指標は $L^2$ 個あり一次独立なので、これが全固有値。∎

Kirchhoff の matrix-tree 定理（連結グラフに適用可能。$C_L\times C_L$ は連結）より
$$\tau(L)=\frac{1}{L^2}\prod_{(j,k)\neq(0,0)}\lambda_{j,k}. \tag{2.1}$$

---

## 3. 証明

### Step 1（$k$ についての部分積）

$j$ を固定し $A_j:=4-\zeta^{j}-\zeta^{-j}\in\mathbb{Z}[\zeta_L]$ と置く。$w^2-A_jw+1=0$ の 2 根を $r_j,\ r_j^{-1}$
（根の積は定数項 $1$ なので互いに逆元）とする。**この段階では $r_j$ は $K$ の高々 2 次拡大の元**であり、
$(3.1)$ はそこでの等式である（左辺・および $r_j^L+r_j^{-L}$ は 2 根の対称式なので $K$ に属する）。
Step 5 で、$L$ 奇のときは $r_j$ が完備化 $K_P$ に属することを示す。このとき

$$\prod_{k=0}^{L-1}\bigl(A_j-\zeta^{k}-\zeta^{-k}\bigr)=r_j^{L}+r_j^{-L}-2. \tag{3.1}$$

*証明.* $w\neq0$ に対し
$A_j-w-w^{-1}=-\dfrac{w^2-A_jw+1}{w}=-\dfrac{(w-r_j)(w-r_j^{-1})}{w}$。
$w$ を $L$ 乗根全体にわたらせ、$\prod_{w^L=1}(x-w)=x^L-1$ より $\prod_{w^L=1}(w-r)=(-1)^L(r^L-1)$、
また $\prod_{w^L=1}w=(-1)^{L+1}$ を使うと

$$\prod_{w^L=1}\bigl(A_j-w-w^{-1}\bigr)
=\frac{(-1)^L\cdot(-1)^L(r_j^L-1)\cdot(-1)^L(r_j^{-L}-1)}{(-1)^{L+1}}
=-(r_j^L-1)(r_j^{-L}-1).$$

$-(r^L-1)(r^{-L}-1)=-(r^L-1)\dfrac{1-r^L}{r^L}=\dfrac{(r^L-1)^2}{r^L}=r^L+r^{-L}-2$。∎

### Step 2（$j=0$ の寄与）

$A_0=4-2=2$ であり、$k=0$ の項は $(2.1)$ から除かれているので
$$\prod_{k=1}^{L-1}\bigl(2-\zeta^k-\zeta^{-k}\bigr)=\prod_{k=1}^{L-1}(1-\zeta^k)(1-\zeta^{-k})=L\cdot L=L^2 .$$
（$2-\zeta^k-\zeta^{-k}=(1-\zeta^k)(1-\zeta^{-k})$ は展開すれば直ちに従う。
$\prod_{k=1}^{L-1}(1-\zeta^k)=L$ は $\frac{x^L-1}{x-1}=\prod_{k=1}^{L-1}(x-\zeta^k)$ に $x=1$ を代入して得る。
$\{\zeta^{-k}\}_{k=1}^{L-1}=\{\zeta^{k}\}_{k=1}^{L-1}$ なので 2 つ目の積も $L$。）

### Step 3（分解）

$D_j:=r_j^{L}+r_j^{-L}-2$ と置く。$(2.1)$ を $j=0$ とそれ以外に分け、Step 1・Step 2 を代入して

$$\boxed{\ \tau(L)=\prod_{j=1}^{L-1}D_j\ } \tag{3.2}$$

$D_j$ は $A_j$ の整数係数多項式である（$s_n:=r^n+r^{-n}$ は $s_0=2,\ s_1=A_j,\ s_n=A_js_{n-1}-s_{n-2}$ を満たすので
$s_L\in\mathbb{Z}[A_j]$、$D_j=s_L-2$）。とくに $D_j\in\mathbb{Z}[\zeta_L]$。

*（検証: `tau_v2_verify.out` の (2) で $L=3,4,5,6,7,9$ について $(3.2)$ を円分体上で厳密に確認した。）*

### Step 4（素点の固定）

$L$ は奇数なので $\gcd(2,L)=1$、したがって **2 は $K=\mathbb{Q}(\zeta_L)$ で不分岐**
（円分体で分岐する素数は $L$ の素因数に限る）。$P\mid 2$ を $\mathbb{Z}[\zeta_L]$ の素イデアルの 1 つに固定し、
完備化 $K_P$ 上の正規化付値を $v$（$v(2)=1$、値群は $\mathbb{Z}$）とする。

$L$ 奇より $v(L)=0$。また $m\not\equiv0\pmod L$ のとき
$\prod_{k=1}^{L-1}(1-\zeta^k)=L$ かつ $v(L)=0$ だから、**$v(1-\zeta^m)=0$**（各因子が非負付値で総和が 0）。 $\tag{3.3}$

### Step 5（$r_j$ は $\zeta^j$ に合同）

$A_j=4-\zeta^j-\zeta^{-j}\equiv \zeta^j+\zeta^{-j}\pmod P$（$4\equiv0$、$-1\equiv1$）。よって
$$w^2-A_jw+1\equiv w^2-(\zeta^j+\zeta^{-j})w+1=(w-\zeta^j)(w-\zeta^{-j})\pmod P .$$
$j\not\equiv0$ のとき $\zeta^j\not\equiv\zeta^{-j}\pmod P$ である。実際 $\zeta^j\equiv\zeta^{-j}$ なら
$P\mid(1-\zeta^{2j})$ となるが、$L$ 奇より $2j\not\equiv0\pmod L$ なので $(3.3)$ に反する。
2 根が $\bmod\,P$ で相異なるから、**Hensel の補題**（一変数モニック多項式が剰余体上で互いに素な因子に分解する場合に適用可）により
$w^2-A_jw+1$ は $K_P$ 上で 1 次式の積に分解する。すなわち $r_j\in K_P$ であり、
$$r_j\equiv\zeta^j\pmod P$$
となる根を選べる（以後この分岐を取る。もう一方は $r_j^{-1}\equiv\zeta^{-j}$）。

### Step 6（$v(m_j)=1$）

Step 5 により $r_j\in K_P$ なので $m_j:=\zeta^{-j}r_j-1\in K_P$ が定義でき（$\zeta^j$ は単数なので $\zeta^{-j}$ が取れる）、
Step 5 の合同 $r_j\equiv\zeta^j$ より $v(m_j)\ge1$。
$r_j=\zeta^j(1+m_j)$ を $r+r^{-1}=A_j$ に代入し、両辺に $(1+m_j)$ を掛けて整理すると

$$\zeta^{j}m^2+\bigl(3\zeta^{j}+\zeta^{-j}-4\bigr)m-2(1-\zeta^{j})(1-\zeta^{-j})=0. \tag{3.4}$$

*（導出: $\zeta^j(1+m)^2+\zeta^{-j}=(4-\zeta^j-\zeta^{-j})(1+m)$ を展開し、
定数項に $2\zeta^j+2\zeta^{-j}-4=-2(2-\zeta^j-\zeta^{-j})=-2(1-\zeta^j)(1-\zeta^{-j})$ を用いる。
両辺に $(1+m)$ を掛ける操作は偽根を生まない: $(3.4)$ に $m=-1$ を代入すると $\zeta^{j}-(3\zeta^j+\zeta^{-j}-4)-2(1-\zeta^j)(1-\zeta^{-j})=\zeta^{-j}\neq0$。
もっとも、以下で使うのは「$m_j$ が $(3.4)$ の根である」ことだけである。）*

$(3.4)$ の 3 つの係数の付値は次のとおり。

- 最高次係数 $\zeta^j$: 単数なので $v=0$。
- 1 次係数 $3\zeta^j+\zeta^{-j}-4\equiv\zeta^j+\zeta^{-j}\pmod P$。もし $v>0$ なら $\zeta^j+\zeta^{-j}\equiv0$、
  両辺に $\zeta^j$ を掛けて $\zeta^{2j}\equiv-1\equiv1\pmod P$、すなわち $P\mid(1-\zeta^{2j})$ となり $(3.3)$ に反する。よって $v=0$。
- 定数項 $-2(1-\zeta^{j})(1-\zeta^{-j})$: $(3.3)$ より $v(1-\zeta^{\pm j})=0$、$v(2)=1$。よって $v=1$。

Newton 多角形の頂点は $(0,1),(1,0),(2,0)$。下方凸包の傾きは $-1$（長さ 1）と $0$（長さ 1）なので、
**2 根の付値はちょうど $1$ と $0$**（根の積 $=$ 定数項/最高次係数 の付値が 1、根の和 $=-$1 次係数/最高次係数 の付値が 0 からも同じ）。
$v(m_j)\ge1$ は Step 5 から Newton 多角形とは独立に得られており、正の付値をもつ根は 1 つしかないから、循環論法にならずに

$$v(m_j)=1 .$$

*（検証: `tau_v2_verify.out` の (3) で $L=3,5,7,9,11,13$、全 $j=1,\dots,L-1$ について
$v(\text{最高次})=0,\ v(1\text{ 次})=0,\ v(\text{定数})=1$、および $e=1$（不分岐）を確認した。）*

### Step 7（LTE 段）

$\zeta^L=1$ より $r_j^{L}=\zeta^{jL}(1+m_j)^L=(1+m_j)^L$。二項展開して
$$r_j^{L}-1=(1+m_j)^L-1=\sum_{i=1}^{L}\binom{L}{i}m_j^{\,i}=L\,m_j+\sum_{i=2}^{L}\binom{L}{i}m_j^{\,i}.$$
$v(L\,m_j)=v(L)+v(m_j)=0+1=1$。$i\ge2$ の項は $v\ge v(m_j^{\,i})=i\ge2>1$。
付値が相異なる項の和の付値は最小値に等しいから
$$v\bigl(r_j^{L}-1\bigr)=1 .$$

### Step 8（総和）

$r_j$ はモニック整係数多項式 $w^2-A_jw+1$ の根なので代数的整数、かつ $r_j\cdot r_j^{-1}=1$ より単数。ゆえに $v(r_j)=0$。
Step 1 の計算中に得た等式 $D_j=(r_j^{L}-1)^2/r_j^{L}$ より

$$v(D_j)=2\,v\bigl(r_j^{L}-1\bigr)-L\,v(r_j)=2\cdot1-0=2\qquad(j=1,\dots,L-1).$$

$(3.2)$ の $\tau(L)$ は有理整数であり、$v$ は乗法的付値、かつ 2 は不分岐（$e=1$）なので $K$ 上の $v$ は
$\mathbb{Q}$ 上で $v_2$ に一致する。したがって

$$v_2(\tau(L))=v\Bigl(\prod_{j=1}^{L-1}D_j\Bigr)=\sum_{j=1}^{L-1}v(D_j)=2(L-1). \qquad\blacksquare$$

---

## 4. 偶数 $L$ で崩れる箇所（証明が奇 $L$ を要する理由）

証明が $L$ の奇数性を使ったのは次の **3 箇所**である。

1. **Step 4 の $(3.3)$**: 「2 が $K$ で不分岐」「$v(1-\zeta^m)=0$（$m\not\equiv0\bmod L$）」。どちらも $\gcd(2,L)=1$ に依存する。
2. **Step 5・Step 6 の $2j\not\equiv0\pmod L$**: $j\not\equiv0$ から $2j\not\equiv0$ が従うのは $L$ が奇数のときだけである。
   これは Step 5（Hensel の互いに素条件 $\zeta^j\not\equiv\zeta^{-j}$）と Step 6（1 次係数の付値が 0）の**両方で必要**で、
   $(3.3)$ からは出ない（$(3.3)$ は $m\not\equiv0$ を**仮定**しており、$m=2j$ に適用するには $2j\not\equiv0$ を別途知る必要がある）。
   偶 $L$ の $j=L/2$ では $\zeta^{2j}=1$ となり、$1-\zeta^{2j}=0$ なので $(3.3)$ が「破れる」のではなく**仮定が満たされない**。
3. **Step 7**: $v(L)=0$ ゆえに $L\,m_j$ が主要項になること。

偶 $L$ ではいずれも成立しない。`tau_v2_verify.out` の (4) で実測した:

| $L$ | 2 の分岐指数 $e$ | $v_P(1-\zeta^{L/2})$ | $v_2(L)$ |
|---|---|---|---|
| 4 | 2 | 2 | 2 |
| 6 | 1 | 1 | 1 |
| 8 | 4 | 4 | 3 |

$L=6$ は $e=1$（不分岐）だが $v_P(1-\zeta^{3})=1\neq0$ かつ $v_2(6)=1\neq0$ で、やはり 2 箇所とも破れる。
§1 の表が示すとおり、実際に結論も成立しない。**観察 T は奇 $L$ 限定の主張として正しい。**

---

## 5. 既知性・新規性（主張しない）

- **新規性は主張しない。** 本 step で検索したのは arXiv・出版社の検索と **abstract のみ**であり、
  以下 2 本については**本文を確認していない**。
  - Mednykh–Mednykh 系列「The number of spanning trees in circulant graphs, its arithmetic properties and asymptotic」
    (arXiv:1711.00175): abstract に「$\tau(n)=p\,n\,a(n)^2$（$p$ は $n$ の偶奇に依存する定数）」という
    **偶奇に依存する算術的分解**の主張がある。対象は循環グラフ $C_n(s_1,\dots,s_k)$ で、abstract には
    離散トーラス $C_n\times C_n$ の記載がない。~~**本文未確認。**~~
    → **本文確認済み（下記「§5.1 本文まで確認した一次情報」）。**
  - Mednykh–Mednykh「A formula for the number of spanning trees in circulant graphs with non-fixed generators
    and discrete tori」(arXiv:1312.4389): abstract に「離散トーラスの全域木数の公式も導く」とあるが、
    公式そのものと $p$ 進付値への言及は abstract には無い。**本文未確認**（ar5iv HTML 版が無く、
    本セッションのツールでは機械可読な本文を取得できなかった）。
- したがって「$v_2(\tau(L))=2(L-1)$（奇 $L$）が文献に既出かどうか」は**確認できていない**。
  検索で見つからなかったことを「新しい」の根拠にはしない（0 件は根拠にならない）。
- 証明に使った道具は Kirchhoff の matrix-tree 定理、円分体での 2 の不分岐性、Hensel の補題、
  Newton 多角形、二項展開（LTE 型）のみで、**すべて標準的**である。この種の主張が folklore として
  既知である可能性は高いと考えるべきである。

### 5.1 本文まで確認した一次情報（2026-07-31 追記）

上記の「本文未確認」のうち、次の 2 件は**本文・全文を取得して確認した**。確認方法（取得 URL）も記録する。

- **OEIS A212800**（"Number of spanning trees of the (n,n)-torus grid graph"）:
  `https://oeis.org/search?q=id:A212800&fmt=text` から raw text 記録（版 `#23 Feb 16 2025`）の
  全行（`%I` 〜 `%A`）を取得した。記載されているのは
  (a) 項 $a(1),\dots,a(11)$、(b) `%C`「Main diagonal of array in A212796」、
  (c) `%H` の Kreweras 1978（J. Combin. Theory B **24** (1978), p.210 Para.4）と MathWorld 2 件、
  (d) `%F` の漸近式 $a(n)\sim\Gamma(1/4)^4e^{4Gn^2/\pi}/(16\pi^3)$（Vaclav Kotesovec, 2021-02-14）、
  (e) `%t` の Mathematica コード（正弦積）、(f) `%Y` Cf. A212796, A340562。
  **2 進付値への言及も、$\tau=L^2R^4$ 型（あるいは $n^2a(n)^4$ 型）の分解も、記載が一切無い。**
  なお本 report の $\tau(L)$ が A212800 と同じ量であることは、`sagemath/check/cycle13_T1_tau_v2/`
  の (7) で $a(2),\dots,a(11)$ との厳密整数一致（10/10）として確認した
  （$L=2$ の多重辺規約 $a(2)=32$, $v_2=5$ も一致する。§1 の表の注はこの規約と同じ）。
- **arXiv:1711.00175**（Mednykh–Mednykh）: `https://ar5iv.labs.arxiv.org/html/1711.00175` の
  ar5iv 本文で確認した。対象は **1 次元の循環グラフのみ**（偶数次数 $C_n(s_1,\dots,s_k)$ と
  奇数次数 $C_{2n}(s_1,\dots,s_k,n)$。「the vertex $i$ is adjacent to the vertices
  $i\pm s_1,\dots,i\pm s_k \pmod n$」）で、**離散トーラス $C_n\times C_n$ は扱っていない**。
  分解 $\tau(n)=p\,n\,a(n)^2$ の $p$ は abstract の言葉どおり
  「a prescribed natural number depending on the parity of $n$」であり、**素点ではない**。
  **$p$ 進付値・2 進付値の計算や議論は本文に無い**（漸近評価は Mahler 測度による）。
  本 report の $\tau(L)=L^2R_L^4$ はこの 2 次元版に相当する形だが、同一の主張ではない。

したがって「観察 T が既出か」は依然として**確定していない**（arXiv:1312.4389 と Kreweras 1978 の
本文が未確認のまま残る）。上記は「この 2 本には無い」という否定的事実の確定であって、
新規性の根拠にはしない。

---

## 6. 002 への反映（本 report の結論）

`outputs/paper-plans/002_R_Lambda_duality.md` は観察 T を §2「検証済みだが未証明の観察」に置いていた。
**証明が付いたので、確定した部分命題の側へ移すべきである**（命題 T として §2 の「厳密に確定している部分命題」に追加）。
これは G1 の未達要因のうち「観察 T は未証明」の 1 つを解消する。
ただし G1 のもう一方の未達要因（中核の双対命題 D の ($p$) 側の一般性が文献に未特定。
`cycle13_T1_padic_entropy_generality.md` §4）は残るので、**G1 は引き続き未達**である。

なお本命題は $\Lambda$ 側の主張（$\mathbb{R}$ を一切使わない有限 $L$ の付値の等式）であり、
選別基準 (i)(ii) を満たす。$v_2(\tau(L))$ は Kirchhoff 行列式の素因数分解という有限手続きで決定可能、
証明の各段（Newton 多角形・二項展開）も有限組合せ的で、原理的に `decide`／witness に乗る（選別基準 (iii)）。
