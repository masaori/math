# 01 Mahler 測度の厳密な定義

$\mathbb{R}$ 脱出分類の土台となる Mahler 測度を、CLAUDE.md の厳密性原則どおり、各記号の所属集合と、どこで $\mathbb{R}/\mathbb{C}$（非可算・解析）へ出るかを明示して定義する。

---

## 1. 定義（対数版と乗法版、測度と所属集合）

$P\in\mathbb{C}[z_1^{\pm1},\dots,z_d^{\pm1}]$ を非零 Laurent 多項式（我々の文脈では係数環 $\mathbb{Z}$）。$d$ 次元トーラス
$$
\mathbb{T}^d=\{(z_1,\dots,z_d)\in\mathbb{C}^d:|z_k|=1\ \forall k\}=(S^1)^d
$$
上の**正規化 Haar 測度**
$$
d\mu=\prod_{k=1}^d\frac{dz_k}{2\pi i\,z_k}=\prod_{k=1}^d\frac{d\theta_k}{2\pi}\quad(z_k=e^{i\theta_k}),\qquad \mu(\mathbb{T}^d)=1
$$
に対し、**対数 Mahler 測度**と**乗法 Mahler 測度**を
$$
\boxed{\,m(P):=\int_{\mathbb{T}^d}\log\bigl|P(z_1,\dots,z_d)\bigr|\,d\mu\ \in\mathbb{R}\cup\{-\infty\},\qquad M(P):=e^{m(P)}\,}
$$
で定める。$|P|:\mathbb{T}^d\to\mathbb{R}_{\ge0}$ は連続、$\log|P|:\mathbb{T}^d\to[-\infty,\infty)$ は零点集合 $\{P=0\}\cap\mathbb{T}^d$ で $-\infty$ に発散しうる。積分の収束が第一の論点（§3）。

**所属の明示**：$P$ は可算集合 $\mathbb{Z}[z_i^\pm]$ に住むが、$m(P)$ の定義は非可算 $\mathbb{T}^d$ 上の積分＝$\mathbb{R}$ への脱出を**定義段階で**含む。これが RΛ 双対で「$m(P)$ が唯一の $\mathbb{R}$ 側」と呼ぶ根拠。

---

## 2. $d=1$：代数的公式と Jensen 同値（可算で閉じる場合）

$d=1$ では**解析を経ずに**定義できる。$P(x)=a_n\prod_{i=1}^n(x-\alpha_i)\in\mathbb{Z}[x]$（$a_n\ne0$, $\alpha_i\in\overline{\mathbb{Q}}$）に対し
$$
\boxed{\,M(P)=|a_n|\prod_{i=1}^n\max(1,|\alpha_i|)\ \in\overline{\mathbb{Q}}\cap\mathbb{R}_{>0}\,}\tag{$\ast$}
$$
は**代数的数**（代数的数の有限積、monic なら代数的整数）。すなわち $m(P)=\log_\mathbb{R} M(P)$ は「代数的数の対数」——$d=1$ 全体が型Ⅱ（[`02`](02_型I_II_脱出なしと代数的log.md)）。

**$(\ast)$ と積分定義の同値（Jensen）**：鍵は次の補題。

> **補題**：$\alpha\in\mathbb{C}$ に対し $\displaystyle\frac{1}{2\pi}\int_0^{2\pi}\log\bigl|e^{i\theta}-\alpha\bigr|\,d\theta=\log^+|\alpha|:=\max(0,\log|\alpha|)$。

*証明*：$w\mapsto\log|w-\alpha|$ は $\mathbb{C}\setminus\{\alpha\}$ 上調和。
- $|\alpha|>1$（$\alpha$ が閉単位円板の外）：$\log|w-\alpha|$ は $|w|\le1$ で調和ゆえ、円周平均＝中心値 $\log|0-\alpha|=\log|\alpha|$。
- $|\alpha|<1$：$|e^{i\theta}-\alpha|=|1-\alpha e^{-i\theta}|$（$|e^{i\theta}|=1$ ゆえ）、$w\mapsto\log|1-\alpha w|$ は $|w|\le1$ で調和（零点 $1/\alpha$ が外）、平均＝中心値 $\log|1|=0$。
- $|\alpha|=1$：$\log|e^{i\theta}-\alpha|$ は可積分特異点1つのみで、極限として $0=\log^+|\alpha|$。∎

$\log|P(e^{i\theta})|=\log|a_n|+\sum_i\log|e^{i\theta}-\alpha_i|$ に代入・積分して
$$
m(P)=\log|a_n|+\sum_{i=1}^n\log^+|\alpha_i|=\log|a_n|+\sum_{|\alpha_i|>1}\log|\alpha_i|=\log M(P).
$$
これが Jensen の公式（複素解析の平均値性）の帰結。**$d=1$ では積分（$\mathbb{R}$）と代数的公式（$\overline{\mathbb{Q}}$）が一致し値は代数的**——脱出は最終の $\log_\mathbb{R}$ 一つだけ。

---

## 3. $d\ge2$：収束の厳密性と代数的公式の消失

**収束定理**：$P\in\mathbb{C}[z_i^\pm]$ が恒等的に零でなければ $\log|P|\in L^1(\mathbb{T}^d,\mu)$、ゆえ $m(P)\in\mathbb{R}$（有限）。

*証明（変数についての帰納・Jensen 反復）*：$z_d$ について $P=c(z')\prod_j(z_d-\beta_j(z'))$（$z'=(z_1,\dots,z_{d-1})$、$c,\beta_j$ は $z'$ の代数関数）と因数分解し、内側積分に §2 の補題を適用：
$$
\int_{S^1}\log|P|\,\frac{dz_d}{2\pi i z_d}=\log|c(z')|+\sum_j\log^+|\beta_j(z')|.
$$
右辺各項は $z'\in\mathbb{T}^{d-1}$ の関数として $L^1$（$\log^+$ は増大を抑え、$\log|c|$ は $d-1$ 変数で帰納法の仮定により可積分）。Fubini で二重に可積分ゆえ $m(P)$ 有限。特異点 $\{P=0\}\cap\mathbb{T}^d$ は測度零で、$\log$ の特異性は可積分（$\int_0\log t\,dt$ 収束と同型）。∎

**本質的な違い**：$d\ge2$ では $(\ast)$ に相当する**有限代数的公式が一般に存在しない**。$m(P)$ は $\mathbb{T}^d$ 上の真の積分値で、一般に超越数。これが「$d=1$ は型Ⅱ（代数的）、$d\ge2$ は型Ⅲ/Ⅳ（特殊値・一般超越）」の根本理由（[`README §1`](README.md) の梯子）。

---

## 4. 基本性質（証明つき）

1. **加法性**：$m(PQ)=m(P)+m(Q)$。$\log|PQ|=\log|P|+\log|Q|$ から即座。$m$ は積を対数化する準同型。
2. **単項式不変**：$|z^k|=1$ on $\mathbb{T}^d$ ゆえ $m(z^k)=0$。$m$ は単項式（$\mathbb{Z}[z_i^\pm]^\times$）を法に well-defined。
3. **非負性**：$P\in\mathbb{Z}[z_i^\pm]$ が単項式で割り切れないなら $m(P)\ge0$。$d=1$ は $(\ast)$ より $M(P)\ge1$。
4. **Kronecker（$d=1$）**：$P\in\mathbb{Z}[x]$ monic 既約に対し $m(P)=0\iff P$ 円分（全根が1の冪根）。
5. **Lehmer 問題（未解決）**：$\inf\{m(P):P\in\mathbb{Z}[x],\ m(P)>0\}>0$ か。最小既知値は Lehmer 数 $0.1623\ldots$。非回文的には Smyth の下限 $\log(1.3247)$（プラスチック数、$x^3-x-1$）が守り、難所は回文＝Salem 型のみ。
6. **Boyd–Lawton の極限定理**：$d$ 変数 Mahler 測度は **1 変数の極限**：
$$
m\bigl(P(x,x^{k_2},\dots,x^{k_d})\bigr)\xrightarrow[\ k_2,\dots,k_d\to\infty\ \text{(適切に)}\ ]{}m\bigl(P(z_1,\dots,z_d)\bigr)
$$
（Lawton 1983 が Boyd 予想を証明）。多変数（型Ⅲ/Ⅳ）が1変数（各項型Ⅱ・代数的 $\log$）の可算列の極限として生成される。[`../R-Lambda-duality §8.6`](../R-Lambda-duality/README.md) の「$\Lambda$-閉形式列 → $\mathbb{R}$-閉形式」の Mahler 版。

---

## 5. RΛ 双対での位置（どこが脱出か）

- **同一 $P\in\mathbb{Z}[z_i^\pm]$** を二素点で読む。$\infty$ で $m(P)=\int_{\mathbb{T}^d}\log|P|$（**唯一の $\mathbb{R}$ 脱出**）。各 $p$ で $P\bmod p$ の点数・$p$ 進 Newton 多角形 $\to\mu_{\min}(p)$（$\Lambda$-native、決定可能、積分なし）。
- **LSW 定理**：$m(P)=$ $P$ が定める $\mathbb{Z}^d$-代数力学系の位相的エントロピー（Lind–Schmidt–Ward 1990）。ゆえ Mahler 測度は「自由エネルギー＝エントロピー」の数学的本体（[`../数え上げエントロピーと特殊値/05_スペクトル曲線の定義.md`](../数え上げエントロピーと特殊値/05_スペクトル曲線の定義.md)）。
- **脱出の型**（[`README §0`](README.md)）：$d=1$ は $(\ast)$ で常に型Ⅱ。$d\ge2$ は $\{P=0\}$ の数論型で型Ⅲ（$L$ 値・周期）か型Ⅳ（一般超越）に分かれる。積分 $\int_{\mathbb{T}^d}\log|P|$ が Beilinson 正則子・$L$ 値になるのが型Ⅲ、ならないのが型Ⅳ。

## 参考文献
Mahler (1962); Jensen（平均値公式）; Smyth (1971, 1981); Boyd (1998) Exp. Math. 7; Lawton (1983) J. Number Theory 16; Lind–Schmidt–Ward (1990) Invent. 101; Everest–Ward *Heights of Polynomials and Entropy in Algebraic Dynamics* (1999); Brunault–Zudilin (2020) *Many Variations of Mahler Measures*.
