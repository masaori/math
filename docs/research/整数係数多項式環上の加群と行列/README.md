# 整数係数多項式環上の加群と行列

この文書は、有限個の不定元をもつ整数係数多項式環上の加群と行列について、定義、成立する定理、成立しない分類、有限計算法、本リポジトリの可算数学との接続を分けて記録する調査ノートである。証明論文ではなく、引用した既存数学の適用範囲を確定するための基礎資料である。

## 対象と記号

- $n\in\mathbb Z_{\ge 0}$ を固定し、$R_n:=\mathbb Z[x_1,\ldots,x_n]$ と書く。$R_0=\mathbb Z$、$R_1=\mathbb Z[x]$ である。不定元は有限個に限る。
- $R_n$ は可換単位的環であり、加群は単位的左 $R_n$ 加群を指す。可換なので右加群との違いは本稿では生じない。
- $R_n^q$ は階数 $q\in\mathbb Z_{\ge0}$ の自由加群、$\operatorname{Mat}_{p\times q}(R_n)$ は $p$ 行 $q$ 列行列全体である。
- 有限表示加群とは、ある $p,q\in\mathbb Z_{\ge0}$ と $A\in\operatorname{Mat}_{p\times q}(R_n)$ により
  $$R_n^p\xrightarrow{A}R_n^q\longrightarrow M\longrightarrow0$$
  という完全列をもつ $R_n$ 加群 $M$ である。列ベクトル規約では $A$ の大きさを $q\times p$ とする流儀もあるため、実装では写像の始域・終域を行列サイズと一緒に固定しなければならない。
- 生成元 $m_1,\ldots,m_q\in M$ の関係加群、すなわち全射 $R_n^q\to M$ の核を第一 syzygy 加群と呼ぶ。表示を変えると具体的な核の埋め込みは変わる。

$R_n$ と Laurent 多項式環 $\mathbb Z[x_1^{\pm1},\ldots,x_n^{\pm1}]$ は別の環である。後者は $x_1\cdots x_n$ による局所化であり、単元には $\pm x_1^{a_1}\cdots x_n^{a_n}$ が現れる。以下の $R_n$ の単元が $\pm1$ だけであるという記述を Laurent 多項式環へ移してはならない。

## 環として成立すること

### 可算性と決定可能な等号

$R_n$ の各元は有限個の整数係数と有限個の指数ベクトルで表される。したがって $R_n$ は可算集合であり、正規化した疎表現では等号、加法、乗法を有限手続きで決定できる。これは「任意のイデアル所属問題や加群同型問題が容易」という意味ではない。

### 整域、一意分解、単元

$R_n$ は整域であり一意分解整域である。単元は $1$ と $-1$ だけである。整域性は整数環から有限回の多項式環構成で保存され、一意分解性は Gauss の補題を有限回適用して得られる。[Stacks Project の多項式環に関する UFD 補題](https://stacks.math.columbia.edu/tag/0BC1) は「UFD 上の多項式環は UFD」を明記している。

### Noether 性

$\mathbb Z$ は Noether 環であり、Hilbert の基底定理を有限回適用すると $R_n$ は Noether 環になる。したがって次が成立する。

- $R_n$ のすべてのイデアルは有限生成である。
- 有限生成 $R_n$ 加群の部分加群は有限生成である。
- 有限生成 $R_n$ 加群は有限表示である。
- 有限表示の関係加群を取り続けても各段は有限生成である。

最後の三点は Noether 環上の有限加群に関する標準補題の直接の特殊化である。[Stacks Project「More Noetherian rings」](https://stacks.math.columbia.edu/tag/00IJ) は、有限加群の部分加群が有限であり、有限加群が有限表示であることを同じ補題で示している。

### Krull 次元と有限自由分解

$R_n$ は Krull 次元 $n+1$ の正則 Noether 環である。[Stacks Project「Regular rings and global dimension」](https://stacks.math.columbia.edu/tag/065U) により大域次元は $n+1$ であり、有限生成加群は長さ高々 $n+1$ の有限生成射影分解をもつ。後述する $R_n$ 上の有限生成射影加群の自由性を組み合わせると、有限生成自由加群からなる同じ長さ以下の自由分解を得る。この主張は、不定元が有限個であることと基礎環 $\mathbb Z$ が次元 $1$ の正則 Noether 環であることを使う。無限変数多項式環へは移せない。

## PID でないことが壊す分類

### $R_n$ は $n\ge1$ で PID ではない

$R_1$ のイデアル $(2,x)$ は単項ではない。実際、これが $(f)$ なら $f$ は $2$ と $x$ の共通約元である。一意分解性から共通約元は単元なので $(f)=R_1$ となるが、評価と剰余を組み合わせた環準同型
$$R_1\longrightarrow\mathbb F_2,\qquad g(x)\longmapsto g(0)\bmod2$$
の核は $(2,x)$ であり、$(2,x)\ne R_1$ である。矛盾する。$n>1$ でも $(2,x_1)$ に同じ議論を適用できる。

### PID 上の有限生成加群の構造定理は使えない

PID 上では有限生成加群を自由部分と巡回ねじれ部分の直和へ不変因子で分類できる。しかし $R_n$ は $n\ge1$ で PID でないため、この定理の仮定を満たさない。有限表示行列が存在することと、その行列が Smith 標準形をもつことは別である。

具体的に $R_1$ 加群
$$M:=R_1/(2,x)$$
は二つの関係をもつ一生成有限表示加群である。$M\cong\mathbb F_2$ は加法群として有限だが、表示イデアル $(2,x)$ は単項でない。この加群を PID の一変数の不変因子だけで表すことはできない。

### Smith 標準形は一般には存在しない

環上の行列に左右から可逆行列を掛ける操作は、成分全体が生成するイデアルを保存する。行列
$$A=\begin{bmatrix}2&x\end{bmatrix}\in\operatorname{Mat}_{1\times2}(R_1)$$
が Smith 型の対角行列 $[d\ 0]$ と同値なら、成分イデアルは $(2,x)=(d)$ となる。しかし $(2,x)$ は単項でないので、そのような $d\in R_1$ は存在しない。

したがって「整数行列に Smith 標準形がある」から「整数係数多項式行列にもある」と推論してはならない。$R_0=\mathbb Z$ では成立し、$R_1$ ですでに一般には失敗する。

### 有限生成、有限表示、自由、射影を区別する

- 有限生成は、有限個の元から $R_n$ 線形結合で全体が得られることだけをいう。
- 有限表示は、生成元と関係式がともに有限個であることをいう。$R_n$ では Noether 性により有限生成なら有限表示である。
- 自由は、ある集合を基底として一意な有限線形結合表示をもつことをいう。
- 射影は、全射に対する持ち上げ性をもつことと同値であり、自由加群の直和因子である。

$M=R_1/(2,x)$ は有限表示だが自由でなく射影でもない。有限表示性から自由性や射影性は従わない。

## 自由加群と有限生成射影加群

### 基底が存在するための必要十分条件

$S$ を可換単位的環、$M$ を $S$ 加群とする。部分集合 $B\subseteq M$ が基底であるとは、各 $m\in M$ が有限個の $b\in B$ と一意な係数 $a_b\in S$ により
$$m=\sum_{b\in B}a_bb$$
と表されることをいう。したがって次は定義から同値である。

- $M$ に基底が存在する。
- ある集合 $B$ に対して $M\cong\bigoplus_{b\in B}S$ である。
- $M$ は自由 $S$ 加群である。

これは判定条件を別の言葉へ移しただけなので、有限表示加群に対しては次の段階に分ける。

### 局所基底と大域基底

有限表示 $S$ 加群 $M$ が階数 $r\in\mathbb Z_{\ge0}$ の有限生成射影加群であることは、各素イデアル $\mathfrak p\subset S$ で局所化した $M_{\mathfrak p}$ が自由 $S_{\mathfrak p}$ 加群であり、その階数が $r$ で一定であることと同値である。Fitting ideal では
$$\operatorname{Fitt}_{r-1}(M)=0,qquad \operatorname{Fitt}_r(M)=S$$
と表せる。[Stacks Project の Fitting ideal による局所自由性判定](https://stacks.math.columbia.edu/tag/07ZD) がこの同値を与える。

しかし、各 $M_{\mathfrak p}$ に基底があることから $M$ 全体の基底が自動的に得られるわけではない。局所自由加群は有限生成射影加群に対応し、大域基底の存在は、その射影加群が自由であること、すなわち局所基底を一つの大域基底へ貼り合わせられることを追加で要求する。一般の環では非自由な有限生成射影加群が存在する。

### よく使える十分条件

- $S$ が体なら、選択公理を用いる通常の集合論ではすべての $S$ ベクトル空間に基底がある。
- $S$ が局所環なら、有限生成射影 $S$ 加群は有限階数自由である。
- $S$ が PID なら、有限生成 torsion-free $S$ 加群は自由である。特に有限生成射影加群は自由である。
- $S=\mathbb Z[x_1,\ldots,x_n]$ なら、有限生成射影加群は Quillen の結果により自由である。
- $S=\mathbb Z[x_1^{\pm1},\ldots,x_n^{\pm1}]$ なら、有限生成射影加群は Swan の結果により自由である。

したがって本稿の二つの整数係数環では、有限表示加群について
$$\text{一定階数で局所自由}\quad\Longleftrightarrow\quad\text{有限生成射影}\quad\Longrightarrow\quad\text{自由}\quad\Longleftrightarrow\quad\text{基底が存在}$$
と進める。最後の含意に使う定理は通常多項式環と Laurent 多項式環で異なる。

### 必要条件だけでは足りない例

整域上の自由加群は torsion-free なので、torsion-free 性は必要条件である。しかし十分ではない。$R_1=\mathbb Z[x]$ のイデアル
$$I:=(2,x)\subset R_1$$
は整域 $R_1$ の部分加群なので torsion-free であり、分数体上へ係数拡大した rank は $1$ である。それでも $I$ が rank $1$ の自由加群なら一元生成イデアルになるため、非単項性に矛盾する。よって $I$ は torsion-free rank $1$ だが基底をもたない。

同様に、有限生成であること、有限表示であること、一定の generic rank をもつことだけから基底の存在は従わない。射影性も一般の環では自由性を含意せず、係数環固有の自由化定理が必要である。

### 有限生成射影加群は自由である

$R_n=\mathbb Z[x_1,\ldots,x_n]$ 上の有限生成射影加群は自由である。ここで使うのは、体上の多項式環だけを扱う通常の Quillen--Suslin の標語を無条件に拡張したものではない。Quillen の局所化・貼り合わせの結果を Dedekind 環である $\mathbb Z$ に適用すると、有限生成射影 $R_n$ 加群は $\mathbb Z$ 上の有限生成射影加群から拡大されたものになる。$\mathbb Z$ 上の有限生成射影加群は自由なので、$R_n$ 上でも自由になる。

一次資料は Daniel Quillen, [“Projective modules over polynomial rings”](https://doi.org/10.1007/BF01390008), *Inventiones Mathematicae* 36 (1976), 167--171 である。Quillen の結果の係数環に関する帰結を明記した同時代の一次資料として Moshe Roitman, [“A note on Quillen's paper ‘Projective modules over polynomial rings’”](https://doi.org/10.1090/S0002-9939-1977-0444638-1), *Proceedings of the AMS* 64 (1977), 231--232 も参照した。体上の自由性を独立に証明した一次資料は A. A. Suslin, [“Projective modules over a polynomial ring are free”](https://www.mathnet.ru/eng/dan40545), *Doklady Akademii Nauk SSSR* 229 (1976), 1063--1066 である。Suslin 論文の表題だけを根拠に係数環を $\mathbb Z$ へ変更せず、$\mathbb Z$ の場合は Quillen の係数環に関する形を使う。

### 仮定の限界

- 「有限生成」は外せないまま上の定理を引用する。任意の巨大な射影加群に同じ有限ランクの主張を自動適用しない。
- 「射影」は外せない。有限生成加群一般は、前節の $R_1/(2,x)$ のように自由でない。
- 「多項式環」を Laurent 多項式環、形式冪級数環、商環へ置き換えない。それぞれ別の定理が必要である。
- 自由であることは、入力された有限表示から基底を直ちに計算できることを意味しない。存在定理と具体的な基底抽出アルゴリズムを区別する。

### 基底を構成する問題の入力と証明書

有限生成射影加群 $P$ を計算機へ渡すには、単に「$P$ は射影」と宣言するのではなく有限データが要る。代表的な入力は次のいずれかである。

- 冪等行列 $E\in\operatorname{Mat}_{q\times q}(R_n)$ と恒等式 $E^2=E$。このとき $P:=\operatorname{im}(E)\subseteq R_n^q$ は射影である。
- 多項式行列の像、核、余核としての表示と、その加群が一定階数の射影加群であることを示す計算可能な条件。
- 最大小行列式が単位イデアルを生成する unimodular 行列 $U$。このとき unimodular completion は、$U$ を恒等行列のブロックへ変える可逆行列を求める問題である。

Alessandro Logar と Bernd Sturmfels の一次資料 [“Algorithms for the Quillen--Suslin theorem”](https://doi.org/10.1016/0021-8693(92)90189-S) は、体 $\mathbb C$ 上で多項式行列の像・核・余核として表示された射影加群の自由基底を Gröbner 基底により構成する。係数環を $\mathbb Z$ へ拡張した実装については、Brett Barwick と Branden Stone の [Macaulay2 `QuillenSuslin` 公式文書](https://macaulay2.com/doc/Macaulay2-1.25.11/share/doc/Macaulay2/QuillenSuslin/html/index.html) が、$\mathbb Q$、$\mathbb Z$、有限体上の通常多項式環を対応対象として明記する。

同公式文書の各操作は役割が異なる。

- `isProjective` は、Noether 環上の入力加群が一定階数の射影加群かを判定する。
- `computeFreeBasis` は、射影性が成立する入力加群の自由基底を列として返す。
- `qsIsomorphism` は、自由加群と入力射影加群の間の同型を返す。
- `qsAlgorithm` は、unimodular 行列 $U$ に対して $UM=[I\ 0]$ またはその転置型となる正方可逆行列 $M$ を返す。
- `completeMatrix` は、unimodular 行列を正方可逆行列へ補完する。

したがって計算結果の検証は「基底が返った」という表示だけで終えず、出力行列 $B$ の列が $P$ を生成すること、$\ker(B)=0$ であること、または自由加群との往復写像の合成が両側の恒等写像になることを厳密に再計算する。unimodular completion なら、$UM$ のブロック恒等式と $\det(M)$ が係数環の単元であることが独立な証明書になる。

この環境には調査時点で Macaulay2 実行ファイルが存在しなかったため、公式文書と査読済み実装論文の仕様確認までを行い、ローカル実行結果が得られたとは記していない。

## 整数係数 Laurent 多項式環

### 定義と通常多項式環との差

有限個の不定元について
$$L_n:=\mathbb Z[x_1^{\pm1},\ldots,x_n^{\pm1}]\cong\mathbb Z[\mathbb Z^n]$$
と置く。右辺は有限生成自由アーベル群 $\mathbb Z^n$ の群環である。$L_n$ は $R_n$ の積 $x_1\cdots x_n$ による局所化なので、Noether 性、正則性、整域性、一意分解性は保存される。一方、単元群は
$$L_n^\times=\{\pm x_1^{a_1}\cdots x_n^{a_n}\mid(a_1,\ldots,a_n)\in\mathbb Z^n\}$$
であり、$R_n^\times=\{\pm1\}$ より大きい。

$L_n$ も $n\ge1$ では PID でない。例えば $L_1$ のイデアル $(2,x-1)$ は、環準同型
$$L_1\longrightarrow\mathbb F_2,\qquad f(x)\longmapsto f(1)\bmod2$$
の核である。これが単項なら、その生成元は UFD $L_1$ で $2$ と $x-1$ の共通約元なので単元となり、真のイデアルであることに矛盾する。したがって PID 型の有限生成加群分類と一般の Smith 標準形は Laurent 化しても復活しない。反例行列は $[2\ x-1]$ である。

### 有限生成射影加群の分類

Richard G. Swan の一次資料 [“Projective modules over Laurent polynomial rings”](https://doi.org/10.1090/S0002-9947-1978-0469906-4), *Transactions of the AMS* 237 (1978), 111--120 は、$G$ が有限生成自由アーベル群、$A$ が体または PID なら、群環 $A[G]$ 上の有限生成射影加群が自由であることを述べる。$A=\mathbb Z$、$G=\mathbb Z^n$ と特殊化すると、有限生成射影 $L_n$ 加群はすべて自由である。

この結論は「局所化は射影加群をすべて多項式環から降ろす」という一般原理から推測したものではない。Swan 論文は、一般の正則係数環では Laurent 多項式加群の局所・大域原理が多項式環と同じ形では成立しない反例も与える。したがって、ここでの自由性は係数環が PID であるという仮定を保って引用する。

### Laurent 環での構成アルゴリズム

H. Park の一次資料 [“A Computational Theory of Laurent Polynomial Rings and Multidimensional FIR Systems”](https://www2.eecs.berkeley.edu/Pubs/TechRpts/1995/2775.html) は、多項式環上の completion を Laurent 多項式環へ移すアルゴリズムを構成し、Singular による例を示す。Joseph Gubeladze の [“An algorithm for the Quillen--Suslin theorem for monoid rings”](https://doi.org/10.1016/S0022-4049(97)00020-0) は、体 $k$ と一定の有限生成可換モノイド $M$ に対する $k[M]$ 上の自由基底アルゴリズムを与え、多項式環・Laurent 多項式環を応用として含む。

係数環の仮定は実装ごとに異なる。Macaulay2 の公式 `QuillenSuslin` 文書は、通常多項式環では $\mathbb Z$ を対応対象に含める一方、Laurent 多項式環の completion は $\mathbb Q$ または有限体についてのみ対応すると明記する。よって Swan の定理が保証する $\mathbb Z[x_1^{\pm1},\ldots,x_n^{\pm1}]$ 上の自由性と、同パッケージで利用できる Laurent completion の係数範囲は一致しない。本調査で確認した公式実装資料からは、整数係数 Laurent 環の任意の射影加群表示を直接受け取り自由基底を返す検証済み経路を確定できなかった。

## 行列について成立すること

以下では $S$ を可換単位的環とし、特に $S=R_n$ として使う。一般環について述べるのは、各主張の証明が可換性と単位元だけを使い、$R_n$ がその仮定を満たすことを明示するためである。

### 行列式と可逆性

$B\in\operatorname{Mat}_{q\times q}(S)$ に対し、Leibniz 公式で $\det(B)\in S$ を定義できる。余因子行列により
$$B\operatorname{adj}(B)=\operatorname{adj}(B)B=\det(B)I_q$$
が成立する。したがって
$$B\in\operatorname{GL}_q(S)\quad\Longleftrightarrow\quad\det(B)\in S^\times.$$

$S=R_n$ では $R_n^\times=\{1,-1\}$ なので、正方行列が可逆であることは行列式が $1$ または $-1$ であることと同値である。逆行列は $\det(B)^{-1}\operatorname{adj}(B)$ で再び $R_n$ 成分になる。

Laurent 多項式環では単元が増えるため、「行列式が $\pm1$」という最後の特殊化は成立しない。

### Cayley--Hamilton と特性多項式

$B\in\operatorname{Mat}_{q\times q}(R_n)$ の特性多項式
$$\chi_B(t):=\det(tI_q-B)\in R_n[t]$$
を定義でき、Cayley--Hamilton の定理 $\chi_B(B)=0$ が成立する。固有値や代数閉包へ移らず、整数係数多項式環内の有限な恒等式として完結する。

### 左右同値変形

$A,C\in\operatorname{Mat}_{p\times q}(R_n)$ について、ある $P\in\operatorname{GL}_p(R_n)$ と $Q\in\operatorname{GL}_q(R_n)$ が存在して $C=PAQ$ となるとき、$A$ と $C$ は左右同値である。この操作は表示の生成元と関係生成元の基底変更に対応し、余核加群を同型の範囲で保存する。

「可逆行列による変形」と「基本行列だけによる変形」は同義とは限らない。特に一般環上の特殊線形群が基本行列で生成されるかは別問題であり、Smith 標準形の失敗を基本変形の選び方で回避することはできない。

### 小行列式イデアル

$A\in\operatorname{Mat}_{p\times q}(R_n)$ の $r$ 次小行列式全体が生成するイデアルを $I_r(A)\subseteq R_n$ とする。左右から可逆行列を掛けても $I_r(A)$ は変わらない。体上の rank 一個だけでなく、小行列式イデアルの列が退化の情報を保持する。

## 有限表示加群の不変量と計算法

### Fitting ideal

有限表示
$$R_n^p\xrightarrow{A}R_n^q\longrightarrow M\longrightarrow0$$
に対し
$$\operatorname{Fitt}_i(M):=I_{q-i}(A)$$
と定義する。ただし存在しない大きさの小行列式については $I_r(A)=0$、$r\le0$ では $I_r(A)=R_n$ という規約を置く。このイデアルは表示の選択に依存せず、環準同型による基底変換と両立する。[Stacks Project「Fitting ideals」](https://stacks.math.columbia.edu/tag/07Z6) は定義と表示独立性、基底変換をまとめている。

例 $M=R_1/(2,x)$ では $\operatorname{Fitt}_0(M)=(2,x)$ である。この非単項イデアルが、単一の Smith 不変因子で置き換えられない障害をそのまま記録する。

Fitting ideal は有用な同型不変量だが、一般に有限表示加群の完全分類不変量ではない。同じ Fitting ideal をもつ非同型加群がありうるため、「一致すれば同型」とは結論できない。

### syzygy と自由分解

表示行列 $A$ の列の syzygy は $\ker(A)$ の有限生成元を求める問題である。$R_n$ の Noether 性は有限生成性を保証する。さらに $R_n$ の正則性は、syzygy を反復して有限自由分解に到達できるという存在論的上限を与える。

ただし、選んだ生成系、項順序、簡約規則により出力される syzygy の具体形は変わる。自由分解も最小性を指定しなければ一意でない。$\mathbb Z$ は体ではないため、体上の次数付き最小自由分解の一意性をそのまま引用しない。

### Gröbner 基底と係数環の注意

有限個の多項式または加群ベクトルに項順序を固定し、先頭項が生成するイデアルまたは部分加群を有限生成する標準基底を計算すれば、次を有限手続きへ落とせる。

- イデアル・部分加群への所属判定
- 消去と核の計算
- syzygy 生成系の計算
- 商加群の表示変換
- 小行列式からの Fitting ideal の生成

しかし $R_n$ の係数環は体でない。先頭係数を常に割れる体上の Buchberger 法を無変更で使うことはできず、係数の gcd、強 Gröbner 基底、または整数係数に対応した標準基底アルゴリズムが必要である。

[Singular 公式マニュアル](https://www.singular.uni-kl.de/index.php/singular.pdf) は `std` による標準基底、`syz` による第一 syzygy、自由分解関連コマンドを定義している。実計算では環宣言の係数領域と項順序を成果物に記録し、`QQ` 上へ勝手に係数拡大しない。$\mathbb Z[x_1,\ldots,x_n]$ から $\mathbb Q[x_1,\ldots,x_n]$ へ移すと整数 torsion の情報が消える。

### 計算量について確定できること

一般入力に対する Gröbner 基底計算を「常に現実的」と評価する根拠はない。Ernst Mayr と Albert Meyer の一次資料 [“The complexity of the word problems for commutative semigroups and polynomial ideals”](https://doi.org/10.1016/0001-8708(82)90048-2) は、多項式イデアル所属問題に本質的に大きな記憶量を要求する族を構成した。David Bayer と Michael Stillman の [“On the complexity of computing syzygies”](https://doi.org/10.1016/S0747-7171(88)80039-7) は Mayr--Meyer 型の例を整理し、最小 syzygy の次数が変数数に対して二重指数的に増大する族を与える。

Logar--Sturmfels 型の基底構成は Gröbner 基底を部分手続きとして用いるため、この障害を無視できない。ただし、Mayr--Meyer の下界は一般のイデアル所属・syzygy 入力に対するものであり、「射影性が既知のすべての Quillen--Suslin 入力」に同じ下界がそのまま成立するとは本調査から結論できない。

したがってアルゴリズムの比較は次の軸を混ぜずに行う。

| 経路 | 確認した係数環 | 主な出力 | 確定した制約 |
|---|---|---|---|
| Logar--Sturmfels | 原論文は $\mathbb C[x_1,\ldots,x_n]$ | 像・核・余核で与えた射影加群の自由基底 | Gröbner 基底を使用 |
| Macaulay2 `QuillenSuslin` | 通常多項式環は $\mathbb Q,\mathbb Z,\mathbb F_p$ | 射影性判定、自由基底、同型、unimodular completion | 公式文書の対応範囲。実行環境には本体なし |
| Park の Laurent 化 | Laurent 多項式環 | unimodular completion と安定性計算 | 多項式環の結果を Laurent 環へ移す構成 |
| Gubeladze のモノイド環算法 | 体上の所定のモノイド環 | 有限生成射影加群の自由基底 | 係数環を $\mathbb Z$ へ変更できない |

この表は実測速度の順位ではない。入力次数、変数数、係数のビット長、項順序、出力基底の次数と係数成長を固定した共通ベンチマークを実行していないため、どの実装が速いかという比較はしていない。

### 計算の再現可能な流れ

有限表示行列 $A$ から調べる場合、次の順序なら各出力の意味が分離される。

- 係数環を $R_n$、不定元、項順序、行列が表す写像の向きを宣言する。
- 標準基底で $\operatorname{im}(A)$ と $\ker(A)$ の有限生成系を求める。
- 必要な次数の小行列式を厳密に計算し、Fitting ideal の標準基底を求める。
- 射影性を主張する場合は、局所自由性、分裂、冪等行列などの証拠を別途示す。
- 射影性が確立した場合に限り、$R_n$ 上の有限生成射影加群の自由性定理を適用する。
- Smith 標準形が得られなければ失敗として扱い、$R_n$ 一般で存在しない標準形を仮定しない。

## 具体例

### 非単項 Fitting ideal をもつ余核

$A=[2\ x]$ を写像 $R_1^2\to R_1$ と解釈すると、
$$\operatorname{coker}(A)=R_1/(2,x)\cong\mathbb F_2.$$
この例は同時に、有限表示性、Smith 標準形の不在、$\operatorname{Fitt}_0=(2,x)$、係数を $\mathbb Q$ へ拡大したとき $2$ が単元となり余核が消えることを示す。係数拡大が情報を落とす最小例である。

### 行列式が非定数の正方行列

$$B=\begin{bmatrix}1&x\\0&2\end{bmatrix}\in\operatorname{Mat}_{2\times2}(R_1)$$
では $\det(B)=2$ は単元でないため、$B$ は $R_1$ 上可逆でない。$\mathbb Q[x]$ へ係数拡大すると $2$ は単元になり、同じ成分式から得る行列は可逆になる。可逆性は行列の記号列だけでなく係数環に依存する。

### 自明でない表示をもつ自由加群

$$C=\begin{bmatrix}1&x\\0&1\end{bmatrix}\in\operatorname{GL}_2(R_1),\qquad \det(C)=1.$$
この行列の余核は零加群であり、逆行列は
$$C^{-1}=\begin{bmatrix}1&-x\\0&1\end{bmatrix}$$
である。多項式成分が非定数でも可逆性を妨げず、決定条件は行列式が $R_1$ の単元かどうかである。

## 本リポジトリの可算数学との接続

### 確立した代数的帰結

- 有限格子から得る分配多項式 $Z_L(x)\in\mathbb Z[x]$、整数係数の転送行列、有限グラフの接続行列は、有限データとして厳密に保持できる。
- それらの加減乗算、行列式、特性多項式、Fitting ideal、有限表示加群の syzygy は $R_n$ 内で扱え、$\mathbb R$ または $\mathbb C$ への移行を必要としない。
- 係数環を $\mathbb Q$ や $\mathbb C$ へ拡大する操作は、整数 torsion や素数ごとの情報を失いうる。したがって係数拡大は単なる表記変更ではなく環準同型に沿う基底変換として記録すべきである。
- 多項式に複素数を代入して零点を幾何学的に描く操作、係数列の極限、スペクトルの解析的評価は、ここで述べた整数係数多項式環内の有限代数とは別の段階である。

### 方法論上の位置づけ

$R_n$ が可算で等号が決定可能であることは、本リポジトリの「決定可能な可算コア」の候補になる根拠である。ただし可算性だけから、計算量の小ささ、閉形式、加群同型の単純な完全分類は従わない。

したがって可算側で保持すべき情報は、無理に固有値や Smith 不変因子一列へ圧縮せず、有限表示行列、syzygy、Fitting ideal、標準基底、自由分解として残すのが正確である。これは哲学的前提ではなく、$R_n$ が Noether だが $n\ge1$ では PID でないという代数的事実から従う。

### 応用上の仮説との境界

上記から「特定の格子模型の物理量が Fitting ideal で完全分類される」「整数係数行列の加群表示が相分類を与える」とはまだ従わない。そのような対応には、物理側の対象から有限表示加群への写像、同値関係が加群同型へ移ること、逆に必要な物理情報が失われないことの証明が必要である。本稿はその入力となる代数を確定しただけであり、応用上の完全性は主張しない。

## 成立範囲の早見表

| 主張 | $\mathbb Z$ | $\mathbb Z[x]$ | $\mathbb Z[x_1,\ldots,x_n]$（有限 $n$） | 注意 |
|---|---:|---:|---:|---|
| 可算、等号が決定可能 | 成立 | 成立 | 成立 | 無限変数でも可算だが Noether 性は別 |
| Noether 環 | 成立 | 成立 | 成立 | 有限変数という仮定を使う |
| PID | 成立 | 不成立 | $n\ge1$ で不成立 | $(2,x_1)$ が反例 |
| UFD | 成立 | 成立 | 成立 | PID であることは従わない |
| 有限生成加群の PID 型分類 | 成立 | 一般には不成立 | 一般には不成立 | 有限表示・Fitting ideal 等を使う |
| 任意の行列の Smith 標準形 | 成立 | 一般には不成立 | 一般には不成立 | $[2\ x_1]$ が反例 |
| 有限生成加群は有限表示 | 成立 | 成立 | 成立 | Noether 性による |
| 有限生成射影加群は自由 | 成立 | 成立 | 成立 | Quillen の係数環に関する定理を使用 |
| 正方行列が可逆 iff 行列式が $\pm1$ | 成立 | 成立 | 成立 | Laurent 環では単元が増える |

Laurent 多項式環 $L_n$ については、Noether・UFD・有限生成射影加群の自由性が成立する一方、PID、PID 型加群分類、一般の Smith 標準形は成立しない。正方行列の可逆条件は、行列式が $\pm x_1^{a_1}\cdots x_n^{a_n}$ の形の単元であることへ変わる。

## 出典と確認範囲

### 一次資料・継続的標準資料

- Daniel Quillen, [“Projective modules over polynomial rings”](https://doi.org/10.1007/BF01390008), *Inventiones Mathematicae* 36 (1976), 167--171. 係数環からの射影加群の拡大に関する局所化原理と、$\mathbb Z$ を含む場合の根拠。
- Moshe Roitman, [“A note on Quillen's paper ‘Projective modules over polynomial rings’”](https://doi.org/10.1090/S0002-9939-1977-0444638-1), *Proceedings of the AMS* 64 (1977), 231--232. 大域次元 $1$ 以下の可換 Noether 係数環に対する Quillen の帰結を明記する同時代の論文。
- A. A. Suslin, [“Projective modules over a polynomial ring are free”](https://www.mathnet.ru/eng/dan40545), *Doklady Akademii Nauk SSSR* 229 (1976), 1063--1066. 体上の多項式環に対する独立証明。書誌ページから原文 PDF へ到達できる。
- [Stacks Project, “Factorization”, polynomial rings over UFDs](https://stacks.math.columbia.edu/tag/0BC1). 多項式環での一意分解性。
- [Stacks Project, “More Noetherian rings”](https://stacks.math.columbia.edu/tag/00IJ). Noether 環上の有限加群、部分加群、有限表示の関係。
- [Stacks Project, “Regular rings and global dimension”](https://stacks.math.columbia.edu/tag/065U). 正則 Noether 環の大域次元と有限射影分解。
- [Stacks Project, “Fitting ideals”](https://stacks.math.columbia.edu/tag/07Z6). 表示行列による Fitting ideal の定義、表示独立性、基底変換。
- [Stacks Project, Fitting ideal による有限局所自由性判定](https://stacks.math.columbia.edu/tag/07ZD). 一定階数の局所基底が存在するための必要十分条件。
- [Singular 公式マニュアル](https://www.singular.uni-kl.de/index.php/singular.pdf). 標準基底、syzygy、加群、自由分解の計算コマンドと係数環・項順序の仕様。
- Richard G. Swan, [“Projective modules over Laurent polynomial rings”](https://doi.org/10.1090/S0002-9947-1978-0469906-4), *Transactions of the AMS* 237 (1978), 111--120. 体または PID の有限生成自由アーベル群環上の有限生成射影加群の自由性、および一般係数環での Laurent 型局所・大域原理の限界。
- Alessandro Logar and Bernd Sturmfels, [“Algorithms for the Quillen--Suslin theorem”](https://doi.org/10.1016/0021-8693(92)90189-S), *Journal of Algebra* 145 (1992), 231--239. 多項式行列で表示された射影加群の自由基底構成。
- Ernst Mayr and Albert Meyer, [“The complexity of the word problems for commutative semigroups and polynomial ideals”](https://doi.org/10.1016/0001-8708(82)90048-2), *Advances in Mathematics* 46 (1982), 305--329. 一般の多項式イデアル所属問題の複雑性下界。
- David Bayer and Michael Stillman, [“On the complexity of computing syzygies”](https://doi.org/10.1016/S0747-7171(88)80039-7), *Journal of Symbolic Computation* 6 (1988), 135--147. 二重指数次数をもつ最小 syzygy の例。
- H. Park, [“A Computational Theory of Laurent Polynomial Rings and Multidimensional FIR Systems”](https://www2.eecs.berkeley.edu/Pubs/TechRpts/1995/2775.html), Berkeley technical report UCB/ERL M95/39. Laurent 多項式行列の構成アルゴリズムと Singular 実装例。
- Joseph Gubeladze, [“An algorithm for the Quillen--Suslin theorem for monoid rings”](https://doi.org/10.1016/S0022-4049(97)00020-0), *Journal of Pure and Applied Algebra* 117--118 (1997), 395--429. 体上のモノイド環に対する自由基底アルゴリズム。
- [Macaulay2 `QuillenSuslin` 公式文書](https://macaulay2.com/doc/Macaulay2-1.25.11/share/doc/Macaulay2/QuillenSuslin/html/index.html). 対応係数環、射影性判定、自由基底、同型、unimodular completion の実装仕様。

### 標準参考文献

- David Eisenbud, *Commutative Algebra with a View Toward Algebraic Geometry*, Springer, 1995. Noether 加群、自由分解、Fitting ideal、Gröbner 基底の標準的整理。二次資料であり、上の一次資料・継続的標準資料と区別する。
- T. Y. Lam, *Serre's Problem on Projective Modules*, Springer, 2006. Quillen--Suslin と係数環を拡張した諸定理の標準的整理。二次資料である。

### この調査の限界

- Macaulay2 がこの環境にインストールされていないため、整数係数通常多項式環上の公式 `QuillenSuslin` 実装は仕様と査読済み論文まで確認し、ローカル再実行はしていない。
- 整数係数 Laurent 多項式環上の有限生成射影加群が自由であることは確定したが、任意の表示から基底を返す検証済み実装経路は、確認した公式資料の範囲では確定できなかった。
- 複雑性の一般下界と各アルゴリズムの入力・出力は確認したが、共通ベンチマークによる実測比較は行っていない。したがって実装間の速度順位は主張しない。
- Fitting ideal は計算可能な不変量として扱ったが、有限表示加群の完全分類を与えるとは主張しない。
