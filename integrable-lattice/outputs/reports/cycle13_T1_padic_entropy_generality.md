# cycle 13 / T1: 双対命題 D の一般性 — 文献本文で確認できたこと・できなかったこと

対象: `outputs/paper-plans/002_R_Lambda_duality.md` §2 の双対命題 D、§8-1 の未確定事項（G1 のボトルネック）。
目的: 「$\infty$ 素点の $\frac1{L^d}\log|a_L|\to m(P)$」と「$p$ 素点の $v_p(a_{p^n})$ の線形成長 ＝ Deninger の $p$ 進エントロピー ＝ Besser–Deninger の $p$ 進 Mahler 測度 ＝ 岩澤 $\mu_p$」が、**どのクラスの整数 Laurent 多項式 $P$ で成立するか**を、文献の該当命題番号・仮定の文言まで特定する。

**結論（先に置く）**:

1. **$\infty$ 素点側の一般性は特定できた**（本文で命題番号・仮定まで確認）。エントロピー＝Mahler 測度は無条件、周期点の増大率＝エントロピーは **expansive（$P$ がトーラス上に零点をもたない）** または **unitary variety が有限**、より一般に **$\dim \mathsf{U}(P)\le d-2$（＝atoral）** の下で成立する。離散ラプラシアン $4-(z+z^{-1})-(w+w^{-1})$ は $\mathsf{U}=\{(1,1)\}$（有限）なのでカバーされる。
2. **$p$ 素点側は、002 が書いている同一視が誤りであることが本文で判明した。** Deninger の $p$ 進エントロピー $\hbar_p$ と Besser–Deninger の $p$ 進 Mahler 測度 $m_p$ は **$p$ 進対数 $\log_p$（岩澤分岐, $\log_p p=0$）** で定義され、その成立条件は **$P$ が $p$ 進トーラス $\mathbb{T}_p^d$ 上に零点をもたないこと**である。この条件下では（下記 §3.3 の導出により）$v_p(a_L)$ は $L^d\cdot v_p(\mathrm{cont}(P))$ で**線形成長率が自明に決まってしまう**。すなわち $\hbar_p$ は $v_p$ の増大を測る量では**ない**。$v_p$ の増大を測るのは Ueki の $\mathrm{M}_p$（$\log|\cdot|_p$ で定義）であって、Ueki 自身が「ours は BD99 のものと異なる」と本文で明記している。
3. **本プロジェクトの設定（2 変数 $P\in\mathbb{Z}[z^{\pm},w^{\pm}]$、$L=p^n$ の $\mathbb{Z}_p^2$ 塔）に対する $v_p(a_{p^n})$ の増大則を述べた文献命題は、本調査では見つけられなかった。** 見つかったのは (a) 1 変数（$\mathbb{Z}$-被覆／$\mathbb{Z}_\ell$ 塔）の場合、(b) グラフの $\mathbb{Z}_\ell^d$ 塔の全域木数の場合、の 2 つで、いずれも本プロジェクトの $a_L$ そのものを対象としていない。
4. ⇒ **命題 D の一般性は特定できなかった。したがって 002 は編集せず、G1 は `未達` のまま**とする（cycle 13 step 1 の指示に従う）。ただし **002 §1 の表と §2 に書かれている同一視は、文献本文と矛盾するので訂正が必要**である（§6 に訂正案を置く）。

---

## 1. 調査した文献（本文を取得できたもの）

| # | 文献 | 取得元 | 取得の可否 |
|---|---|---|---|
| A | D. Lind, K. Schmidt, T. Ward, *Mahler measure and entropy for commuting automorphisms of compact groups*, Invent. math. **101** (1990) 593–629 | UEA リポジトリの出版版 PDF `https://ueaeprints.uea.ac.uk/id/eprint/18590/1/mahlerentropy.pdf` | **本文取得（Summary・§1 Introduction）** |
| B | D. Lind, K. Schmidt, E. Verbitskiy, *Homoclinic points, atoral polynomials, and periodic points of algebraic $\mathbb{Z}^d$-actions*, Ergodic Theory Dynam. Systems **33** (2013) 1060–1081, arXiv:1108.4989v2 | `https://arxiv.org/pdf/1108.4989` | **本文取得（§1–§2）** |
| C | C. Deninger, *$p$-adic entropy and a $p$-adic Fuglede–Kadison determinant*, arXiv:math/0608539v2（Birkhäuser, Manin 記念論文集 2009 所収） | `https://arxiv.org/pdf/math/0608539` | **本文取得（§1–§3）** |
| D | J. Ueki, *$p$-adic Mahler measure and $\mathbb{Z}$-covers of links*, arXiv:1702.03819v3（ETDS） | `https://arxiv.org/pdf/1702.03819` | **本文取得（§1–§5）** |
| E | K. McGown, D. Vallières, *On abelian $\ell$-towers of multigraphs III*, arXiv:2107.07639v1（Ann. math. Québec） | `https://arxiv.org/pdf/2107.07639` | **本文取得（§1–§7）** |
| F | S. DuBose, D. Vallières, *On $\mathbb{Z}_\ell^d$-towers of graphs*, Algebraic Combinatorics **6** (2023) 1331–1346, DOI 10.5802/alco.304 | `https://www.numdam.org/item/10.5802/alco.304.pdf` | **本文取得（Abstract・§1・Theorem A）** |
| G | D. Vallières, *On abelian $\ell$-towers of multigraphs*, arXiv:2006.14012v1（Ann. math. Québec） | `https://arxiv.org/pdf/2006.14012` | **本文取得（§1–§2）** |

**本文を取得できなかったもの**:

| 文献 | 試した URL / 手段 | 結果 |
|---|---|---|
| A. Besser, C. Deninger, *$p$-adic Mahler measures*, J. reine angew. Math. **517** (1999) 19–50, DOI 10.1515/crll.1999.093 | WebSearch（Crelle / De Gruyter / Semantic Scholar）→ `https://www.degruyterbrill.com/document/doi/10.1515/crll.1999.093/html` は購読制で本文へ到達せず。arXiv 版は存在を確認できず | **本文未取得。** 代替として、(i) 著者 Besser 自身の講演スライド `https://www.math.bgu.ac.il/~bessera/lectures/mahler.pdf`（本文ではない）、(ii) Deninger [C] 本文が BD99 Proposition 1.5 を引用した箇所、(iii) Ueki [D] §4.1 が BD99 を Definition 4.1 / Proposition 4.2 として再掲した箇所、の 3 つで仮定を確認した（§3.2） |
| Cuoco–Monsky, *Class numbers in $\mathbb{Z}_p^d$-extensions*, Math. Ann. **255** (1981) 235–258 | WebSearch のみ。本文 PDF に到達せず | **本文未取得。** DuBose–Vallières [F] の本文が「$d\ge2$ では Cuoco と Monsky が数体の場合を調べた」と参照していることのみ確認。**内容（増大公式の形）は本調査では確認していないので引用しない** |

検索・取得に使った手段: WebSearch（arXiv・出版社・著者ページ）、WebFetch（arXiv PDF・numdam PDF・大学リポジトリ PDF）。arXiv/numdam の PDF は WebFetch のテキスト変換では読めず、**ダウンロードした PDF をページ単位で読み出して本文を確認した**。

---

## 2. $\infty$ 素点側で確認できたこと（一般性は確定した）

### 2.1 エントロピー ＝ Mahler 測度（仮定なし）

[A] の Summary と §1 より、$R_d=\mathbb{Z}[u_1^{\pm1},\dots,u_d^{\pm1}]$、$f\in R_d$、$\mathfrak{f}=\langle f\rangle$ に対し（[A] Theorem 3.1、論文中の式 (1-1)）

$$h(\alpha_{R_d/\mathfrak f})=\log \mathrm{M}(f)=\int_0^1\!\!\cdots\!\int_0^1\log|f(e^{2\pi i t_1},\dots,e^{2\pi i t_d})|\,dt_1\cdots dt_d .$$

**$f$ に零点条件は課されていない。** [B] の (1.1) も同じ式を $\mathfrak a=\langle f\rangle$（$f\neq0$）に対して無条件に掲げ、$\mathfrak a$ が非主イデアルなら $h=0$、$\mathfrak a=\{0\}$ なら $h=\infty$ と場合分けしている。

### 2.2 周期点の増大率 ＝ エントロピー（ここに仮定が要る）

[A] §1 末尾の本文（p.595）:
> "In certain situations the growth rate of the number of periodic points gives the topological entropy. Although examples show that this fails to hold in general, we show in Theorem 7.1 that it holds for all expansive actions."

すなわち **一般には成立せず、expansive な作用でのみ成立する**（[A] Theorem 7.1）。expansive の特徴づけは [B] §1（Schmidt の本 Thm 6.5 を引用）:

$$\mathsf{V}(\mathfrak a)=\{z\in(\mathbb{C}^\times)^d: g(z)=0\ \forall g\in\mathfrak a\},\qquad
\mathsf{U}(\mathfrak a)=\mathsf{V}(\mathfrak a)\cap\mathbb{S}^d ,$$
$$\alpha_{R_d/\mathfrak a}\ \text{is expansive}\iff \mathsf{U}(\mathfrak a)=\varnothing .$$

$\mathsf{U}$ は **unitary variety**（複素トーラス $\mathbb{S}^d=\{|z_1|=\dots=|z_d|=1\}$ 上の零点集合）。

### 2.3 トーラス上に零点をもつ場合（本プロジェクトの離散ラプラシアンはここ）

[B] の主結果:

- **[B] Theorem 1.2**（先行論文の結果として再掲）: "Let $d\geqslant2$ and $\mathfrak a$ be an ideal in $R_d$ whose unitary variety $\mathsf{U}(\mathfrak a)$ is a *finite set*. Then (1.3) holds." ここで (1.3) は
  $$\lim_{\langle\Gamma\rangle\to\infty}\frac{1}{|\mathbb{Z}^d/\Gamma|}\log \mathsf{P}_\Gamma(\alpha_{R_d/\mathfrak a})=\mathsf h(\alpha_{R_d/\mathfrak a}).$$
- **[B] Theorem 1.3**（本論文の主結果）: "Let $d\geqslant2$ and let $\mathfrak a$ be an ideal in $R_d$. If the dimension of $\mathsf{U}(\mathfrak a)$ is at most $d-2$, then (1.3) holds."
- **[B] Definition 2.1 / Proposition 2.2**: 既約 $f\in R_d$ が *atoral* $\iff \dim\mathsf{U}(f)\le d-2$。一般の $f$ は既約因子がすべて atoral なとき atoral。

**注意（[B] §1 の訂正記述）**: $\mathsf{P}_\Gamma$ は $\mathrm{Fix}_\Gamma/\mathrm{Fix}_\Gamma^{\circ}$ の位数（**周期成分**の個数）であり、周期点の個数そのものではない。さらに [B] は先行論文の
$\mathsf{P}_\Gamma(\alpha_f)=\prod_{\omega\in\Omega_\Gamma\smallsetminus\mathsf{U}(f)}|f(\omega)|$
という等式が**誤りで、右辺を $c_\Gamma(f)$ で割る必要がある**と明記し、ただし $\frac{1}{|\mathbb{Z}^d/\Gamma|}\log c_\Gamma(f)\to0$ なので漸近的には正しいと述べている。**本プロジェクトの $a_L=\prod_{z^L=w^L=1}P$（トーラス零点を除く規約）は、この「漸近的には正しい」積の側**であり、$\mathsf{P}_\Gamma$ と厳密に一致するわけではない。002 で命題 D を書くときはこの差（$c_\Gamma$ 因子）を明示する必要がある。

### 2.4 本プロジェクトの 2 例への適用（結論）

- $P=5-(z+z^{-1})-(w+w^{-1})$: $|z|=|w|=1$ で $z+z^{-1},w+w^{-1}\in[-2,2]$ ゆえ $P\ge1>0$、$\mathsf U(P)=\varnothing$。**expansive** なので [A] Theorem 7.1 が直接適用でき、$\frac1{L^2}\log|a_L|\to m(P)$ は既知定理から従う。
- $P=4-(z+z^{-1})-(w+w^{-1})$（離散ラプラシアン）: トーラス上の零点は $z=w=1$ の 1 点のみ（$\mathsf U(P)=\{(1,1)\}$、$\dim=0\le d-2=0$）。expansive では**ない**が、$\mathsf U$ が**有限**なので **[B] Theorem 1.2**（$d=2$）が適用でき、$\dim\mathsf U\le d-2$ より **[B] Theorem 1.3** でもカバーされる（＝atoral）。

⇒ **$\infty$ 側は「$\mathsf U(P)=\varnothing$（expansive）」「$\mathsf U(P)$ 有限」「$\dim\mathsf U(P)\le d-2$（atoral）」という 3 段の一般性が文献命題として確定している。** 本プロジェクトが扱う 2 例はどちらも最後の条件を満たす。

---

## 3. $p$ 素点側で確認できたこと（002 の同一視は誤り）

### 3.1 Deninger の $p$ 進エントロピー: 定義と仮定

[C] §1 より。$\log_p:\mathbb{Q}_p^\ast\to\mathbb{Z}_p$ は **$\log_p(p)=0$ で正規化した分岐**（岩澤対数）。$\Gamma$ の余有限正規部分群列 $\Gamma_n\to e$ に対し

$$h_p:=\lim_{n\to\infty}\frac{1}{(\Gamma:\Gamma_n)}\log_p|\mathrm{Fix}_{\Gamma_n}(X)| \tag{[C] (1.3)}$$

を $p$ 進エントロピーと呼ぶ。主定理:

> **[C] Theorem 1.1** *Assume that $f\in\mathbb{Z}[\mathbb{Z}^d]=\mathbb{Z}[t_1^{\pm1},\dots,t_d^{\pm1}]$ does not vanish in any point of the $p$-adic $d$-torus $T_p^d$. Then the $p$-adic entropy $h_p(f)$ of the $\Gamma=\mathbb{Z}^d$-action on $X_f$ in the sense of (1.3) exists for all $\Gamma_n\to0$ and we have $h_p(f)=m_p(f)$.*

ここで $T_p^d=\{z\in\mathbb{C}_p^d:|z_i|_p=1\}$、$m_p$ は Besser–Deninger の $p$ 進 Mahler 測度（[C] (1.5)、Shnirel'man 積分 $m_p(f)=\int_{T_p^d}\log_p f(z)$）。

**この仮定は極めて強い。** [C] Proposition 2.4 が同値条件を与えている:

> **[C] Proposition 2.4** *For $f$ in $\mathbb{Q}_p[\mathbb{Z}^d]$ the following properties are equivalent:
> a) We have $f(z)\neq0$ for every $z$ in $T_p^d$;
> b) $f$ is a unit in $c_0(\mathbb{Z}^d)^\ast$;
> c) $f$ has the form $f(t)=ct^\nu(1+pg(t))$ for some $c\in\mathbb{Q}_p^\ast$, $\nu\in\mathbb{Z}^d$ and $g(t)\in c_0(\mathbb{Z}^d,\mathbb{Z}_p)$.*

すなわち **$f\bmod p$ が（定数×）単項式であること**と同値。

### 3.2 Besser–Deninger の $m_p$ の仮定（本文未取得のため 3 経路で確認）

- [C] §1（Deninger 本人の本文）: "It can only be defined if $f$ does not vanish in any point of the $p$-adic $d$-torus $T_p^d$ ... In this case $m_p(f)$ is given by the convergent Snirelman integral $m_p(f)=\int_{T_p^d}\log_p f(z)$"、および $d=1$ の閉形式（[C] (1.6)、"according to [BD99] Proposition 1.5"）。
- [D] §4.1（Ueki による再掲）: **Definition 4.1** "For $p$-adic analytic functions $f(z)$ with no zero on $|z|_p=1$, we put $m_p(f(z)):=\int_{|z|_p=1}\log_p f(z)\frac{dz}{z}$"、**Proposition 4.2 (Jensen's formula)**。さらに Remark 4.3 直前に "Since $\log_p(z)$ does not vanish on $|z|_p=1$, we have **no natural generalization of $m_p$ for $f(z)$ with zeros on $|z|_p=1$**."
- Besser 自身の講演スライド（**論文本文ではない**）p.32: "Assume $P\in\mathbb{C}_p[z_1^\pm,\dots,z_n^\pm]$ does not vanish on $\mathbb{T}_p^n$"。

3 経路とも仮定は一致する: **$p$ 進単位トーラス上に零点をもたないこと**。BD99 の本文そのものは未取得なので、命題番号は Deninger が引用した "Proposition 1.5"（$d=1$ の Jensen 型公式）のみが確認済みである。

### 3.3 帰結: Deninger の $\hbar_p$ は $v_p(a_L)$ の増大を測る量ではない（本レポートの導出）

以下は上記の**引用済み命題からの演繹**であり、文献の主張として引用しているのではない。

$\Gamma=\mathbb{Z}^d$、$\Gamma_L=(L\mathbb{Z})^d$ とすると [C] Proposition 3.1 より $|\mathrm{Fix}_{\Gamma_L}(X_f)|=\pm\prod_{\omega}f(\omega)$（$\omega$ は $\Omega_{\Gamma_L}$ の指標＝$L$ 乗根の組）。[C] Proposition 2.4 c) により $f=ct^{\nu}(1+pg)$ と書けるので、任意の 1 の冪根 $\omega$（$|\omega_i|_p=1$）で $|pg(\omega)|_p<1$、したがって

$$v_p(f(\omega))=v_p(c)\quad\text{(全ての }\omega\text{ で一定)},\qquad
v_p(a_L)=L^d\,v_p(c).$$

つまり **Deninger の定理の仮定が満たされる範囲では、$v_p(a_L)$ は $L^d\cdot v_p(\mathrm{cont})$ という自明な形に決まってしまう**。特に $f\in\mathbb{Z}[\mathbb{Z}^d]$ が原始的（content が $p$ で割れない）なら $v_p(a_L)\equiv0$。
さらに (1.3) の $\log_p$ は $\log_p p=0$ で正規化されているから、$\hbar_p$ は $|\mathrm{Fix}|$ の **$p$ 冪部分を最初から捨てている**。

⇒ **「Deninger の $p$ 進エントロピー ＝ $v_p(a_{p^n})$ の線形成長率 ＝ 岩澤 $\mu_p$」という 002 §2 の同一視は成り立たない。** $\hbar_p$（と $m_p$）は単数部分の岩澤対数を測る $\mathbb{C}_p$ 値の量であり、$\mu_p$（$\mathbb{Z}_{\ge0}$ 値、付値の増大率）とは別物である。しかも両者は仮定の面でも**排他的**に近い: $\mu_p$ が非自明になるのは $f$ が $p$ 進トーラス上に零点をもつ場合で、そこは $\hbar_p,m_p$ が定義されない領域である。

### 3.4 $v_p$ の増大を測る正しい量は Ueki の $\mathrm{M}_p$（1 変数）

[D] は 2 つの $p$ 進 Mahler 測度を明確に区別している。

- **[D] Definition 2.2**: $f(t)\in\mathbb{C}_p[t^{\pm1}]$ が $|z|_p=1$ 上に零点をもたないとき $\log \mathrm{M}_p(f):=\lim_n\frac1n\sum_{\zeta^n=1}\log|f(\zeta)|_p$（**$\log|\cdot|_p$、すなわち付値**）。
- **[D] Remark 2.4**: "Besser and Deninger defined the *purely $p$-adic* Mahler measure with use of the $p$-adic log, **which is different from ours**."
- **[D] Theorem 2.3 (Jensen's formula)**、**[D] Theorem 2.5**: 定義を $\log \mathrm{M}_p(f)=\lim_n\frac1n\sum_{\zeta^n=1,f(\zeta)\neq0}\log|f(\zeta)|_p$ と修正すれば、**$|z|_p=1$ 上に零点があっても** Jensen の公式が保たれる（$\gcd(n,p)=1$ の条件も外せる）。
- **[D] Proposition 2.7（§1 で言及）**: $\mathrm{M}_p(f)=\max\{|a_i|_p\}$、すなわち **Gauss ノルム＝ content の付値**。
- **[D] Theorem 3.3**: $\mathbb{Z}$-被覆 $M_n$ に対し $\lim_{n}\|H_1(M_n)\|_p^{1/n}=\mathrm{M}_p(A_L(t))$（$\|\cdot\|_p$ は位数の $p$ 進ノルム）。
- **[D] Proposition 3.6（岩澤型公式）**: $\|H_1(M_{p^r})\|_p^{-1}=p^{\lambda_p r+\mu_p p^r+\nu_p}$（$r\gg0$）。
- **[D] Proposition 3.7**: $\log \mathrm{M}_p(A_L(t))=-\mu_p\log p$。
- **[D] Remark 3.8**: "if $A_L(t)$ has no root on $|z|_p=1$, then $\log \mathrm{M}_p=-\mu_p\log p$ immediately follows [from Jensen's formula, $\mathrm{M}_p=\max\{|\text{coefficients}|_p\}$, and the $p$-adic Weierstrass preparation theorem]. **We removed the assumption on $A_L(t)$ by extending the definition of $\mathrm{M}_p$.**"

⇒ **1 変数（$\mathbb{Z}$-被覆・$\mathbb{Z}_p$ 塔）では、$v_p$ の線形成長率＝岩澤 $\mu_p$＝$-\log_p\mathrm{M}_p$＝係数の content の $p$ 進付値、という同一視が本文で確立している**（[D] Prop 2.7 + Prop 3.7）。これは cycle 12 T3 が数値的に得た判定式 $\mu_\ell=v_\ell(\mathrm{content})$ と**同型の主張**である（ただし [D] は 1 変数 Alexander 多項式についての命題であり、cycle 12 T3 の $\mathrm{content}_z\det L(z)$ とは対象が異なる。同値性の証明は cycle 13 step 2 の課題）。

### 3.5 グラフ側（全域木数）で確認できた一般性

- **[E] McGown–Vallières III, Theorem 6.1**: $X$ を $\chi(X)\neq0$ の連結多重グラフ、$\alpha:S\to\mathbb{Z}_\ell$ を **すべての導来多重グラフ $X(\mathbb{Z}/\ell^n\mathbb{Z},S,\alpha_n)$ が連結**になる関数とする。$Q(T)=c_1T+c_2T^2+\dots\in\mathbb{Z}_\ell[[T]]$（Corollary 5.6 の整数係数多項式 $P$ から作る岩澤冪級数）に対し
  $$\mu=\min\{v_\ell(c_j)\},\qquad \lambda=\min\{j: v_\ell(c_j)=\mu\}-1$$
  と置くと、$\kappa_n$（第 $n$ 層の全域木数）について $n\ge n_0$ で
  $$\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+\lambda n+\nu .$$
  （[E] §1 によれば、bouquet の場合が [10]＝Vallières [G]、単純グラフの場合が Gonet、本論文が任意の連結多重グラフへの拡張。）
- **[F] DuBose–Vallières, Theorem A (= Theorem 6.2)**: $X$ を **次数 1 の頂点をもたない有限連結グラフで $\chi(X)\neq0$** とし、$X=X_0\leftarrow X_1\leftarrow\cdots$ を $\mathbb{Z}_\ell^d$-塔とする。このとき **$X$ について総次数 $\le d$、$Y$ について次数 $\le1$ の $P(X,Y)\in\mathbb{Q}[X,Y]$** が存在して、$n$ が十分大きいとき
  $$\mathrm{ord}_\ell(\kappa_n)=P(\ell^n,n).$$
  （$d=1$ では $P(X,Y)=\mu X+\lambda Y+\nu$ で岩澤の公式に一致する、と [F] §1 に明記。）

⇒ **$d\ge2$ では「線形成長率 $\mu_p$」という 1 個の不変量では記述できず、$\ell^n$ と $n$ の 2 変数多項式（総次数 $\le d$）になる。** 本プロジェクトの $L\times L$ トーラス（$L=\ell^n$）は 2 個のループをもつ bouquet（$\chi=1-2=-1\neq0$、次数 1 の頂点なし）の $\mathbb{Z}_\ell^2$-塔なので [F] Theorem A の適用範囲に入る。**したがって 002 §2 の「塔 $L=p^n$ 上で線形成長率 $\mu_p$ をもつ」という書き方は、$d=2$ では誤り**（主要項は $\ell^{2n}$ のオーダー）。

---

## 4. 確認できなかったこと（G1 が未達である理由）

1. **一般の $P\in\mathbb{Z}[z^{\pm},w^{\pm}]$ と $a_L=\prod_{z^L=w^L=1}P(z,w)$ について、$v_p(a_{p^n})$ の増大則を述べた文献命題を特定できなかった。** [F] はグラフの全域木数（＝ラプラシアン型 $P$ に対応）についての命題であり、任意の $P$ を扱っていない。[D] は 1 変数。[C] は $p$ 進トーラス上に零点をもたない場合のみ、しかも測っている量が違う（§3.3）。
2. **Besser–Deninger 1999 の本文は取得できていない**（§1 の表）。仮定は 3 経路で一致確認したが、命題番号まで押さえたのは Deninger が引用する Proposition 1.5 だけである。
3. **Cuoco–Monsky の本文は取得しておらず、その増大公式の形は確認していない**ので、$d\ge2$ の数体側の類似として引用しない。
4. **観察 T（奇 $L$ で $v_2(\tau(L))=2(L-1)$）は本調査の射程外**。奇 $L$ は $\ell=2$ 塔の層ではないので [F] Theorem A は直接には効かない（cycle 13 step 3 の課題）。

---

## 5. 002 に対して確定した事実（編集はしない）

cycle 13 step 1 の指示「一般性が特定できなかった場合は 002 を編集しない」に従い、`002_R_Lambda_duality.md` は本 step では**編集していない**。以下は次 step 以降で反映すべき事項。

- **G1 は `未達` のまま。** $\infty$ 側の一般性は確定したが（§2）、$p$ 側は 002 が書いている同一視自体が誤りであることが判明し、正しい形での一般性（2 変数・$\mathbb{Z}_p^2$ 塔）は文献に特定できていない。G1 は「仮定・結論・成立する一般性の範囲まで確定した命題文」を要求するので、片側だけでは満たさない。
- 他ゲートの判定も変えない。G2・G4・G6 は README の G1 前提ルールにより `評価不能` のまま、G3 は `達成`、G5 は `達成`、最終ゲートは未取得。

---

## 6. 次 step 用の訂正案（002 のどこをどう直すか）

**002 §1 の表の該当行**（現状: 「$p$ 進エントロピー ＝ $p$ 進 Mahler 測度 ＝ 岩澤 $\mu_p$ / **既知** / Besser–Deninger; Deninger; arXiv:1702.03819」）は、**文献本文と矛盾する**ので次のように分割する必要がある。

| 訂正後の主張 | 位置づけ | 根拠 |
|---|---|---|
| $p$ 進トーラス上に零点をもたない $f$ について、Deninger の $p$ 進エントロピー $\hbar_p$ ＝ Besser–Deninger の $p$ 進 Mahler 測度 $m_p$ | 既知 | [C] Theorem 1.1（仮定: $f$ が $T_p^d$ 上に零点をもたない ⟺ [C] Prop 2.4 c) $f=ct^\nu(1+pg)$） |
| その $\hbar_p,m_p$ は $\log_p$（$\log_p p=0$）で定義される $\mathbb{C}_p$ 値の量であり、**岩澤 $\mu_p$（付値の増大率）ではない** | 既知（[D] Remark 2.4 が明記） | [C] (1.2)(1.3)(1.5)、[D] Remark 2.4, §4.1 |
| 1 変数では、付値の増大率 $\mu_p$ ＝ $-\log_p\mathrm{M}_p(f)$ ＝ 係数の content の $p$ 進付値 | 既知 | [D] Prop 2.7, Thm 3.3, Prop 3.6, Prop 3.7, Remark 3.8 |
| グラフの $\mathbb{Z}_\ell$-塔では $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+\lambda n+\nu$、$\mu,\lambda$ は岩澤冪級数の係数付値から決まる | 既知 | [E] Theorem 6.1（仮定: $\chi(X)\neq0$、全ての導来グラフが連結） |
| グラフの $\mathbb{Z}_\ell^d$-塔（$d\ge2$）では単一の線形成長率では書けず、$\mathrm{ord}_\ell(\kappa_n)=P(\ell^n,n)$（総次数 $\le d$、$n$ について次数 $\le1$） | 既知 | [F] Theorem A（仮定: 次数 1 の頂点なし、$\chi(X)\neq0$） |
| 一般の $P\in\mathbb{Z}[z^\pm,w^\pm]$ の $v_p(a_{p^n})$ の増大則 | **未特定**（本調査で文献に見つけられず） | — |

**§2 の双対命題 D の ($p$ 素点) 項**は「塔 $L=p^n$ 上で線形成長率 $\mu_p$ をもつ」という形を捨て、少なくとも (i) $d=1$ と $d\ge2$ を分ける、(ii) $d=2$ では $\ell^{2n}$ 項を含む多項式形になる、(iii) Deninger の $\hbar_p$ とは別の量である、の 3 点を反映しなければならない。

**§2 の ($\infty$ 素点) 項**は逆に**強められる**: 「トーラス零点は除く規約」という曖昧な但し書きを、[A] Thm 7.1 / [B] Thm 1.2 / [B] Thm 1.3（atoral）という 3 段の仮定に置き換えられる。ただし $\mathsf{P}_\Gamma$（周期成分の個数）と $a_L$（トーラス零点を除いた積）の差＝[B] の $c_\Gamma(f)$ 因子を明示すること。

---

## 7. 正直な限界

- 本レポートで「既知」と書いたのは、上表 A–G の**本文で命題番号・仮定の文言まで確認できたもの**だけである。Besser–Deninger 1999 と Cuoco–Monsky 1981 は本文未取得で、前者は仮定のみを 3 経路で照合し、後者は内容を一切引用していない。
- §3.3 の帰結（$\hbar_p$ が $v_p$ の増大を測らないこと）は、引用済みの [C] Prop 2.4 / Prop 3.1 からの**本レポートの演繹**であって、文献がその形で述べている主張ではない。演繹の各段は初等的だが、文献の裏づけがある主張と混同しないこと。
- 数値一致は証明ではない。cycle 12 T3 の判定式 $\mu_\ell=v_\ell(\mathrm{content}_z\det L(z))$ と [D] Prop 2.7 の $\mathrm{M}_p=\max|a_i|_p$ は**形が似ているだけ**で、対象（1 変数 Alexander 多項式 vs. グラフのラプラシアン行列式）も設定も異なる。同値性の証明は cycle 13 step 2 の課題である。
