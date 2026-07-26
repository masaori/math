# cycle 12 / T3 Pure: グラフの岩澤理論で $\mu_\ell>0$ となる具体例の構成

対象: **グラフの岩澤理論**（abelian $\ell$-tower における全域木数 $\kappa_n$ の $\ell$ 進付値）。
cycle 6 / cycle 11 で「$\mu_p$ は generic に 0（Ferrero–Washington 的）」と整理した、その**外側の実例**を計算で構成する。

- スクリプト / 出力（SageMath 10.6, `sage` で実行）:
  - `mu_search.sage` / `mu_search.out` — 小さな voltage 多重グラフの全探索（$\mu_\ell>0$ 候補の抽出）
  - `mu_verify.sage` / `mu_verify.out` — 候補を**判定基準を使わずに**直接 matrix-tree で検証（$\kappa_n$ の実計算とフィット）
  - `mu_large.sage` / `mu_large.out` — 探索範囲を広げて $\mu_2$ をどこまで大きくできるかを調べる

## 1. 設定（記号と定義をすべて明示）

- 底グラフ $X$: 有限連結**多重グラフ**（多重辺・ループ可）。頂点集合 $V$, $|V|=m$。
- voltage 割り当て $\alpha: E(X)\to\mathbb{Z}$（辺に向きを固定して整数を与える）。
- $N\in\mathbb{N}$ に対する**導来グラフ** $X_N$: 頂点集合 $V\times\mathbb{Z}/N$、
  底の辺 $e=(u,v,\alpha)$ は $N$ 本の辺 $(u,i)\,\text{—}\,(v,i+\alpha \bmod N)$ に持ち上がる。
- $N=\ell^n$ ($n=0,1,2,\dots$) の列 $X_1\subset X_\ell\subset X_{\ell^2}\subset\cdots$ が **abelian $\ell$-tower**（$\mathbb{Z}_\ell$-塔）。
- $\kappa_n := \kappa(X_{\ell^n}) \in \mathbb{Z}_{>0}$ は $X_{\ell^n}$ の全域木数（Kirchhoff の matrix-tree 定理で厳密整数）。
- **voltage ラプラシアン** $L(z)$ は $m\times m$ 行列、成分は $\mathbb{Z}[z,z^{-1}]$:
  - 非ループ辺 $(u,v,\alpha)$: $L_{uu}\mathrel{+}=1$, $L_{vv}\mathrel{+}=1$, $L_{uv}\mathrel{-}=z^{\alpha}$, $L_{vu}\mathrel{-}=z^{-\alpha}$
  - ループ $(u,u,\alpha)$: $L_{uu}\mathrel{+}= 2-z^{\alpha}-z^{-\alpha}$

すべて有限・整数係数・決定可能（$\mathbb{R}$ を使わない）。

## 2. 判定基準の導出

$X_N$ のラプラシアンは $\mathbb{Z}/N$ でブロック巡回なので、離散 Fourier 変換で
$\bigoplus_{\zeta^N=1} L(\zeta)$ にブロック対角化される。matrix-tree 定理（$\kappa=$ 非零固有値の積 / 頂点数）と
$\zeta=1$ 成分が $X$ 自身のラプラシアンであることから、$X_N$ が連結なら

$$\kappa(X_N) \;=\; \frac{\kappa(X)}{N}\prod_{\zeta^N=1,\ \zeta\neq1}\det L(\zeta). \tag{★}$$

$(★)$ はグラフ岩澤理論で標準的に使われる公式（Artin–Ihara $L$ 函数の特殊値の形）。
本ディレクトリでは $(★)$ を**計算には使わず**、$\kappa_n$ を導来グラフから直接 Kirchhoff 行列式で求め、
$(★)$ 由来の閉形式と一致するかを毎回照合している（`mu_verify.out`）。

$D(z):=\det L(z)$ を $z=1+T$ で $\mathbb{Z}_\ell[[T]]$ の元と見る。$z^{-1}=(1+T)^{-1}$ は $\mathbb{Z}_\ell[[T]]$ の単元、
$z\mapsto 1+T$ は $\mathbb{Z}$ 上可逆な変数変換なので、係数の $\ell$ 進 content は $z$ の Laurent 係数の content と一致する。
Weierstrass 準備定理 $D=\ell^{\mu}\cdot(\text{distinguished})\cdot(\text{unit})$ より、**予測**:

$$\mu_\ell \;=\; v_\ell\bigl(\mathrm{content}_z(\det L(z))\bigr). \tag{☆}$$

これが $\mathrm{ord}_\ell(\kappa_n)=\mu\,\ell^n+\lambda\,n+\nu$ の $\mu$ に当たる。
$(☆)$ は探索の**フィルタ**としてのみ使い、$\mu$ の値そのものは実計算 $\kappa_n$ から独立に確認する。

### なぜ bouquet では $\mu>0$ が自明例に限るか

底グラフが 1 頂点（bouquet）なら $\det L(z)=\sum_a m_a\,(2-z^{a}-z^{-a})$（$m_a$=voltage $a$ のループ本数）。
これの content が $\ell$ で割れるのは $\ell\mid m_a$ が全 $a$ で成り立つとき、すなわち
**グラフ自体が $\ell$ 重多重グラフ**という自明な場合に限る。
`mu_search.out` の探索 1（125 件全探索）で、content$\neq1$ の 25 件はすべて「辺重複度 gcd が content で割り切れる」自明例だった。

$m\ge2$ 頂点では $\det$ が真の行列式になり、**成分の content は 1 のまま行列式の content だけが $\ell$ で割れる**という
非自明な相殺が起こりうる。これが $\mu>0$ の源である。

## 3. 探索（範囲を一次情報として明示）

`mu_search.sage`:

| 探索 | 底グラフ | 範囲 | 検査数 | content≠1 |
|---|---|---|---|---|
| 1 | bouquet（1 頂点） | ループ voltage 多重集合 $\subset\{1..5\}$, 総ループ数 $\le4$ | 125 | 25（**全て自明**） |
| 2 | 2 頂点 | 平行辺 voltage $\subset\{0..3\}$（本数 $\le4$, 平行移動対称性で $\min=0$ に正規化）＋各頂点のループ voltage $\subset\{1..3\}$（$\le2$ 本） | 3496 | 559 |
| 3 | 3 頂点 | 各頂点対に voltage $0/1$ の辺を重複度 $0..2$（総数 $\le6$）＋各頂点に voltage 1 のループ $0/1$ 本 | 3208 | 1676 |

素数の上限は設けていない（content の素因数分解でそのまま判定）。

## 4. 結果: $\mu_\ell>0$ の具体例（`mu_verify.out` で直接検証済み）

いずれも **辺重複度 gcd $=1$**（＝$\ell$ 重多重グラフではない非自明例）であり、各段の $X_{\ell^n}$ は連結（$\kappa_n>0$ を確認）。

### 例 1（最小・きれい）

底グラフ: 2 頂点 $u,v$、$u$–$v$ 間に voltage $0,1,2$ の平行 3 重辺、$u$ と $v$ にそれぞれ voltage 1 のループ 1 本。

$$\det L(z) = -12z^{-1}+24-12z = -12\,z^{-1}(z-1)^2,\qquad \mathrm{content}=12=2^2\cdot3 .$$

$(★)$ から $\kappa(X_N)=\kappa(X)\cdot N\cdot 12^{\,N-1}=3N\cdot12^{N-1}$（$N\le64$ で直接計算と全一致）。したがって

| $\ell$ | 実測 $v_\ell(\kappa_n)$ | フィット | 予測 $(☆)$ |
|---|---|---|---|
| 2 | $n=0..6$: 0, 3, 8, 17, 34, 67, 132 | $\mu=2,\ \lambda=1,\ \nu=-2$（全 $n$ で一致） | $\mu_2=2$ ✓ |
| 3 | $n=0..4$: 1, 4, 11, 30, 85 | $\mu=1,\ \lambda=1,\ \nu=0$（全 $n$ で一致） | $\mu_3=1$ ✓ |
| 5 | $n=0..2$: 0, 1, 2 | $\mu=0,\ \lambda=1,\ \nu=0$ | $\mu_5=0$ ✓ |

**同一のグラフ塔で $\mu_2=2>0$ かつ $\mu_3=1>0$、$\mu_5=0$。** 求めていた「非自明な $\mu_p>0$」の実例。

$\mu_2>0$ の理由（$\bmod 2$ の直接計算・厳密）: $a(z)=1+z+z^2$（平行辺）、対角成分 $g(z)=5-z-z^{-1}$ とおくと
$\det L=g^2-a(z)a(z^{-1})$。$\bmod 2$ で $g\equiv 1+z+z^{-1}=z^{-1}a(z)$、$a(z^{-1})=z^{-2}a(z)$ だから
$g^2\equiv z^{-2}a(z)^2\equiv a(z)a(z^{-1})$、よって $\det L\equiv0 \pmod 2$。

### 例 2（$\mu_2=4$）

2 頂点、平行辺 voltage $\{0,1,1,2\}$、各頂点に voltage 1 のループ 1 本。
$\det L=-16z^{-1}(z-1)^2$、content $=2^4$。
実測 $v_2(\kappa_n)$（$n=0..6$）$=2,7,16,33,66,131,260$、フィット $\mu=4,\lambda=1,\nu=-2$（全 $n$ 一致）。$\mu_3=0$（実測も 0）。

### 例 3（奇素数 $\ell=23$）

2 頂点、平行辺 voltage $\{0,0,1,2\}$、loop@$u=\{1\}$、loop@$v=\{1,1\}$。
$\det L=-23z^{-1}(z-1)^2$、content $=23$。
$\kappa_0=4$、$\kappa_1=\kappa(X_{23})=83521871999391648137420131642268$、$v_{23}(\kappa_1)=23$。
閉形式 $\kappa_n=4\cdot23^n\cdot23^{23^n-1}$ と一致 → $v_{23}(\kappa_n)=23^n+n-1$、すなわち $\mu_{23}=1,\lambda=1,\nu=-1$。
（$n\le1$ しか直接計算していない。$n=2$ は 1058 頂点で計算していない — 正直に。）
同じグラフで $\ell=2$ は $\mu_2=0$（$n=0..4$ で $v_2=2,3,4,5,6$、$\lambda=1$）。

### 例 4（3 頂点）

3 頂点・8 辺（`mu_verify.out` 参照）。$\det L=-48z^{-1}(z-1)^2$、content $=2^4\cdot3$。
$\mu_2=4$（$n=0..5$ 一致）、$\mu_3=1$（$n=0..3$ 一致）。

### 例 5（$\lambda$ が 1 でない例、$\mu_3=2$）

2 頂点、平行辺 voltage $\{0,0,0,1\}$、各頂点に voltage 1 のループ 3 本。
$\det L=9z^{-2}-63z^{-1}+108-63z+9z^2$（$c\,z^{-1}(z-1)^2$ 型**ではない**ので閉形式は使えず、フィットのみ）、content $=3^2$。
実測 $v_3(\kappa_n)$（$n=0..3$）$=0,7,22,61$、フィット $\mu=2,\ \lambda=3,\ \nu=-2$（全 $n$ 一致、$(☆)$ の予測 $\mu_3=2$ と一致）。
同じグラフで $\ell=2$ は $\mu_2=0,\lambda=1$。

### 例 6（最小級の例、$\mu_5=1$）

2 頂点、平行辺 voltage $\{0,1\}$、頂点 $v$ に voltage 1 のループ 2 本（辺 4 本だけ）。
$\det L=-5z^{-1}(z-1)^2$、content $=5$。
実測 $v_5(\kappa_n)$（$n=0..2$）$=0,5,26$、フィット $\mu=1,\lambda=1,\nu=-1$。閉形式 $\kappa_n=2N\cdot5^{N-1}$ と一致。

### $\mu$ を大きくできるか

族 $A=\{0,1,\dots,k-1\}$（平行 $k$ 重辺）＋各頂点にループ voltage $\{1,\dots,\frac{k-1}{2}\}$ では
$\det L$ の content $=4k$（$k=3,5,7,9,11,13$ で確認）。よって $\mu_2=2$ で一定、$\mu_3$ は $3\mid k$ のとき増える（$k=9$ で $\mu_3=2$）。

広域探索 `mu_large.out`（2 頂点底、平行辺 voltage $\subset\{0..4\}$ 本数 $\le6$、各頂点ループ voltage $\subset\{1,2,3\}$ 本数 $\le3$、
**検査 100794 件**）における最大値:

| $\ell$ | 非自明（辺重複度 gcd $=1$） | 自明を含む |
|---|---|---|
| 2 | $\mu_2=4$（$A=\{0,0,1,1\}$, loop@$v=\{1,1,1\}$） | $\mu_2=5$ |
| 3 | $\mu_3=2$（$A=\{0,0,0,1\}$, 各頂点ループ $\{1,1,1\}$）＝上の例 5 | $\mu_3=3$ |
| 5 | $\mu_5=1$（$A=\{0,1\}$, loop@$v=\{1,1\}$）＝上の例 6 | $\mu_5=1$ |

これは**この有限探索範囲内での最大値**であって、$\mu$ が有界であることの根拠ではない。

## 5. 既知と未解決の区別（厳密に）

**既知**:
- 数体側 Ferrero–Washington 定理: $\mathbb{Q}$ のアーベル拡大の円分 $\mathbb{Z}_\ell$-拡大で $\mu=0$。
- グラフの岩澤理論の枠組み（abelian $\ell$-tower における $\mathrm{ord}_\ell\kappa_n$ の岩澤型漸近、Artin–Ihara $L$ 函数の特殊値）:
  Vallières / McGown–Vallières / Gonet 系列。今セッションで abstract を確認した文献:
  - arXiv:2006.14012 «On abelian $\ell$-towers of multigraphs»（bouquet の族で類数の $\ell$ 進付値と同様の挙動）
  - arXiv:2105.08661 (II)、arXiv:2107.07639 (III)（任意の連結多重グラフを底に拡張）
  - arXiv:2201.05186（$p\neq\ell$ の場合＝Washington–Sinnott 類似）
- 上記 $(★)$（ブロック巡回の対角化＋matrix-tree）は標準。

**今セッションで確認できなかったこと（既知と書かない）**:
- 「グラフ側で $\mu>0$ の明示例が文献に存在するか」。上記論文の abstract には $\mu>0$ の記述はなく、
  本文 PDF は本セッションのツールで機械可読なテキストとして取得できなかった。したがって
  **本ディレクトリの例が新しいのか既知の再現なのかは未確認**。新規性を主張しない。
  （bouquet 底では $\mu>0$ が自明例に限る、という §2 の観察は、上の (I) が bouquet を扱っていることと整合的。）

**証明していないこと（cycle 13 step 2 で解消済み）**:
- ~~$\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+\lambda n+\nu$ という漸近形そのもの（既知理論に依拠）。~~
  → **証明した**（`outputs/reports/cycle13_T3_mu_content_criterion_proof.md` 定理 2）。
  既知理論に依拠せず、$(★)$ と Weierstrass 準備定理から導出。仮定は「$X$ 連結かつ $X_\ell$ 連結」のみ。
- ~~$(★)$ の完全な厳密証明（導出の筋は上に書いたが、ここでは数値照合で担保している）。~~
  → **証明した**（同 定理 1）。しかも $X_N$ の連結性は不要で、$N\kappa(X_N)=\kappa(X)\prod_{\zeta\neq1}\det L(\zeta)$
  の形なら任意の有限 voltage 多重グラフ・任意の $N\ge1$ で成立する（退化ケースは両辺 0）。
- 判定式 $(☆)$ 自体も証明済み（同 定理 3）。**ただし新規性は主張しない**
  （McGown–Vallières III Theorem 6.1 と同じ内容の言い換えである。同 report §8）。

**cycle 13 step 2 で判明した適用範囲の限界**:
- $(☆)$ は **abelian $\ell$-tower（$N=\ell^n$）の $\mu$** についての主張であり、
  $\ell\nmid N$ の段では content は $v_\ell(\kappa(X_N))$ を支配しない（反例 6 件。同 report §9.4）。
- 本プロジェクトの $L\times L$ トーラスは $\mathbb{Z}_\ell^2$-塔（$d=2$）なので、
  $(☆)$ は**そのままでは適用できない**（$d\ge2$ では単一の $\mu$ で書けない。同 report §10-8）。

## 6. 正直な限界

- **数値一致は証明ではない。** $\kappa_n$ は Kirchhoff 行列式による厳密整数だが、確認したのは有限個の $n$（$\ell=2$ で $n\le6$、$\ell=3$ で $n\le4$、$\ell=5$ で $n\le2$、$\ell=23$ で $n\le1$）。
- ただし例 1,2,4 は $\det L(z)=-c\,z^{-1}(z-1)^2$ という**厳密な多項式恒等式**であり、$(★)$ を認めれば
  $\kappa(X_N)=\kappa(X)\cdot N\cdot c^{N-1}$ が全 $N$ で従う。この意味で $\mu_\ell=v_\ell(c)>0$ は
  「フィット」ではなく $(★)$ に条件付きの結論である。$(★)$ 自体を本ディレクトリで証明はしていない。
- 探索は §3 の範囲内の全探索であり、範囲外については何も言えない。
- $\det L=-c\,z^{-1}(z-1)^2$ 型の例（例 1,2,3,4,6）では $\lambda=1$ になる（$(z-1)^2$ の寄与から $(★)$ の $1/N$ が 1 個分を消すため）。
  例 5 は $\lambda=3$ で、$\lambda$ は $\det L$ の $(z-1)$ 進的な構造で決まる。
  ~~$\lambda$ の一般則は今回の対象外。~~ → cycle 13 step 2 で決定した:
  $\lambda=\min\{j:v_\ell(c_j)=\mu\}-1$（$\det L(1+T)=\sum_jc_jT^j$）で、常に $\lambda\ge1$
  （同 report 注 7.2、定理 3）。

## 7. cycle 6 / cycle 11 との関係（本プロジェクト内の整合）

- cycle 6: 「$\Lambda$ 側 = $p$ 進エントロピー = 岩澤 $\mu_p$」（Deninger, Besser–Deninger）に接地。検証した曲線では $\mu_p=0$。
- cycle 7: 最小モデル $z-c$ で「$\mu_p$ は generic に 0」。
- cycle 11 T3: 「$\Lambda$ 側の $\mu_p$ は整数値・離散・generic に 0 で決定可能、$\mathbb{R}$ 側 Mahler 測度のような Lehmer 型の難問はない」。
- **今回（cycle 12 T3）**: その「generic に 0」の**外側**を明示的に構成した。$\mu_p>0$ は例外的だが空ではなく、
  底グラフが 2 頂点以上で行列式の content に $\ell$ が入るときに起こる。$\mu_p$ が**離散・計算可能**であることは変わらず、
  むしろ $\mu_p=v_\ell(\mathrm{content}\det L)$ という**決定可能な判定式**として書けた（$(☆)$、本ディレクトリの例で全て的中）。
