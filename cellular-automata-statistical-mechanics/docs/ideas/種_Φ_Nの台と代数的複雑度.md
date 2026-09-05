# 種「Φ_N の台と代数的複雑度」 — $\Phi_N$ の台の大きさが CA の代数的性質を測る

**最優先の種。** 検算が数分で終わり、リポジトリの既存定理（`R-Lambda-duality` の定理 P）が
そのまま適用でき、$\mathbb{R}$ 脱出がゼロである。

## 設定（すべて可算）

$L\in\mathbb{N}_{>0}$、状態集合 $A=\{0,1\}$、周期境界条件。配位空間 $A^{\mathbb{Z}/L}$（$2^L$ 個）。
CA の局所規則 $f$ から大域写像 $F:A^{\mathbb{Z}/L}\to A^{\mathbb{Z}/L}$ が決まる。

転送行列を

$$
T\in M_{2^L}(\{0,1\}),\qquad T_{xy}:=\begin{cases}1&(x=F(y))\\0&(\text{otherwise})\end{cases}
$$

で定める。$T$ の各列はちょうど 1 つの 1 を持つ（$F$ が写像だから）。

**基本等式**（証明: $(T^N)_{xy}=1\iff x=F^N(y)$、対角を数える）

$$
Z_N:=\operatorname{Tr}T^N=\#\{x\in A^{\mathbb{Z}/L}\ :\ F^N(x)=x\}\ \in\mathbb{N}.
$$

$Z_N\ge1$ のとき（不動点が存在するとき）Massieu 自由エントロピー

$$
\Phi_N:=\log Z_N=\sum_p v_p(Z_N)\,\ell_p\ \in\Lambda .
$$

**帰属**: $T\in M_{2^L}(\mathbb{Z})$、$Z_N\in\mathbb{N}$、$\Phi_N\in\Lambda$。**$\mathbb{R}$ 脱出はゼロ。**
`R-Lambda-duality/README.md` の定理 P・主張 1・主張 2 がそのまま適用できる。

定義（本種の中心）:

$$
\operatorname{supp}(\Phi_N):=\{p\in\mathcal{P}\ :\ v_p(Z_N)>0\}\ \subset\mathcal{P}\quad(\text{有限集合}).
$$

## 確立できる 2 つの命題（証明つき）

### 命題「線形 CA では台が 1 点に潰れる」

$F$ が $\mathbb{F}_p$ 上**線形**（$p=2$ が主対象）、すなわち $F(x)=Ax$（$A\in M_L(\mathbb{F}_p)$）とする。
このとき各 $N\ge1$ で

$$
Z_N=p^{\,d_N},\qquad d_N:=\dim_{\mathbb{F}_p}\ker(A^N-I),
$$

したがって

$$
\Phi_N=d_N\,\ell_p\ \in\mathbb{Z}\ell_p\subset\Lambda,\qquad
\operatorname{supp}(\Phi_N)\subseteq\{p\}\ \ (\forall N).
$$

*証明*: $F^N$ は線形なので不動点集合 $\{x:A^Nx=x\}=\ker(A^N-I)$ は $\mathbb{F}_p$-部分空間。
有限体上の $d$ 次元部分空間の元数は $p^d$。∎

**含意**: 線形 CA の $\Phi_N$ は $\Lambda$ の**ただ 1 つの座標**にしか乗らない。
$\Lambda$ 値の量として最も退化した形である。

### 命題「可逆 CA では傾きが消える」

$F$ が可逆なら $T$ は置換行列。$T$ の位数は有限（$T^m=I$）なので固有値はすべて 1 の冪根、
すなわち代数的**単数**であり、全素点 $p$ で $v_p(\lambda_i)=0$。したがって

$$
\mu_{\min}(p)=\min_i v_p(\lambda_i)=0\quad(\forall p),\qquad M=\sum_p\mu_{\min}(p)\ell_p=0 .
$$

すなわち `R-Lambda-duality` 主張 2 の分解 $\Phi_N=N\cdot M+R(N)$ は
$$\Phi_N=R(N)$$
に退化し、**全情報が残差項に入る**。

*別証（主張 1′ 経由）*: $\chi_T(x)=\prod_c(x^c-1)^{m_c}$（$c$ はサイクル長、$m_c$ はその本数）で、
非主係数の $\gcd$ は $g=1$。主張 1′ より $\{p:\mu_{\min}(p)>0\}=\{p\mid g\}=\emptyset$。∎

**含意**: 可逆 CA は「傾きゼロ・残差のみ」の模型として、
`R-Lambda-duality` §8.1 の蜂の巣 dimer 例（$M=0$ だが恒久残差素点あり）と同じクラスに入る。
**$M=0$ は「重みの自明な乗法的含量がゼロ」を意味する**（同 §8.2 観察 7）。

### 系（可逆 CA の $Z_N$ は約数和）

$$
Z_N=\sum_{c\,\mid\,N}c\,m_c\in\mathbb{N},
$$
$m_c$ は長さ $c$ のサイクルの本数。したがって $v_p(Z_N)$ は**サイクル長の分布の数論的な影**である。

## 手計算で検証できる例（Rule 90, $L=3$）

Rule 90: $x_i'=x_{i-1}+x_{i+1}\ (\mathrm{mod}\ 2)$。$L=3$、状態空間 $\mathbb{F}_2[x]/(x^3+1)$、
$A=$「$a=x+x^2$ 倍」写像。

$\mathbb{F}_2[x]/(x^3+1)\cong\mathbb{F}_2[x]/(x+1)\times\mathbb{F}_2[x]/(x^2+x+1)\cong\mathbb{F}_2\times\mathbb{F}_4$。

- 第 1 成分（$x\mapsto1$）: $a\mapsto1\cdot(1+1)=0$。
- 第 2 成分（$x\mapsto\omega$, $\omega^2=\omega+1$）: $a\mapsto\omega+\omega^2=\omega+\omega+1=1$。

よって $A$ は $(0,1)$ 倍、$A^N=(0,1)$、$A^N-I=(1,0)$（標数 2）、
$\ker(A^N-I)=\{0\}\times\mathbb{F}_4$、$d_N=2$。したがって

$$
Z_N=4,\qquad \Phi_N=2\,\ell_2,\qquad\operatorname{supp}(\Phi_N)=\{2\}\quad(\forall N\ge1).
$$

**直接確認**: $L=3$ の 8 配位のうち $F$ の不動点は $000,011,101,110$ の 4 個
（例: $F(011)_0=x_2+x_1=1+1=0$, $F(011)_1=x_0+x_2=0+1=1$, $F(011)_2=x_1+x_0=1+0=1$ ⇒ $011$）。
$Z_1=4=2^2$ で命題「線形 CA では台が 1 点に潰れる」と一致する。✓

## 仮説（ここからが未確定）

### 固定した有限舞台での増大仮説は採用しない（2026-09-05）

以下の仮説・探索案は履歴として残す。今回の構造化記述
[有限舞台の反復不動点数の上界](../../structured-latex/content/binary-ca-positive-count-domain.ts)
（`claim_binary_ca_fixed_point_count_bound`）は、固定した有限舞台では全ての正の反復回数で
$0\le Z_N\le2^{|V|}$ を与える。したがって、下記の「一般の CA では反復回数とともに状態数や
素因数が増え続ける」という想定は、この舞台には適用できない。正の個数だけを入力とする場合も、
その素因数は $2^{|V|}$ 以下に限られるので、台の有界性だけでは線形性を識別できない。
零個となる入力を含む元の $\limsup$ の式も、そのままでは定義されていない。

これは上界を用いた LLM による検証の記録である。新しい構造化記述の SageMath・Lean は未着手。
舞台サイズを変える族の比較は別の問いであり、この不成立からその場合の結論は出さない。


> **仮説 種「Φ_N の台と代数的複雑度」**: $\operatorname{supp}(\Phi_N)$ の増大の仕方は、CA 規則の**代数的特殊性**を測る。
> より精密には、$|\operatorname{supp}(\Phi_N)|$ が $N$ について有界であることは、
> $F$ が何らかの有限環上の線形写像に共役であることと（ほぼ）同値ではないか。

**定義（算術的複雑度）**:
$$
\mathcal{A}_L(F):=\limsup_{N\to\infty}\big|\operatorname{supp}(\Phi_N)\big|\ \in\mathbb{N}\cup\{\infty\}.
$$

- 線形 CA: $\mathcal{A}_L=1$（命題「線形 CA では台が 1 点に潰れる」）。
- 一般の CA: $Z_N$ は $\lambda_{\max}^N$ 程度に増大するので、素因数は典型的には増え続けるはず。

**問い**:
1. $\mathcal{A}_L(F)$ が有界な非線形 CA は存在するか。存在するならそれは何か。
2. $\mathcal{A}_L$ は $L$ にどう依存するか。$L$ 一様な不変量に整形できるか。
3. $\mathcal{A}_L$ は位相共役で不変か（不変なら CA の分類不変量になる）。

## 最初の検算（`sagemath/check/phi_support/` に置く）

```text
入力: 初等 CA 規則番号 r ∈ {0,...,255}、L ∈ {3,...,14}、N ∈ {1,...,24}
手順:
  1. 大域写像 F を構成（2^L 個の配位への作用）。
  2. Z_N = #{x : F^N(x) = x} を数える（サイクル分解を一度取れば全 N が O(1)）。
  3. Z_N を素因数分解し supp(Φ_N) と v_p(Z_N) を記録。
  4. 表: 規則 × L × (台の大きさ、台の元、d_N（線形なら））
検証すべきこと:
  - 加法的規則（0, 60, 90, 102, 150, 170, 204, 240 …）で台 ⊆ {2} が成り立つか（命題「線形 CA では台が 1 点に潰れる」）。
  - 可逆規則（second-order CA / ERCA）で M = 0 が成り立つか（命題「可逆 CA では傾きが消える」）。
  - 台が有界な非加法的規則が存在するか（仮説 種「Φ_N の台と代数的複雑度」の反例探索）。
出力: overview.md に対象ラベルと結果を記録。
```

**注意**: $Z_N=0$ になる規則（不動点なし）では $\Phi_N=\log0$ が未定義。
その場合を除外するか、$\Phi_N$ を $Z_N\ge1$ の $N$ のみで定義する旨を明記する
（`R-Lambda-duality` audit (3) と同じ注意）。

## 潰れ方（リスク）

| リスク | 内容 | 対処 |
|---|---|---|
| 自明化 | 台の大きさが単に $\log Z_N$ の大きさを測っているだけ | $|\operatorname{supp}|/\log Z_N$ で規格化して比較する |
| 既知 | Martin–Odlyzko–Wolfram が線形の場合を尽くしている | **上の 2 命題 は既知に近い。新規性は仮説 種「Φ_N の台と代数的複雑度」の側にしかない** |
| 反例即死 | 台が有界な非線形 CA がすぐ見つかる | それも結果。「台は線形性でなく○○を測る」に主張を修正 |
| $L$ 依存 | $\mathcal{A}_L$ が $L$ ごとにばらついて不変量にならない | $L\to\infty$ の漸近か、$L$ を渡る族として扱う |
