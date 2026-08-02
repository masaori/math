# 06 関手的 QFT（Atiyah–Segal）

関手的定式化は、場の量子論を「時空の切り貼り」に関する代数的規則へ還元する。Atiyah の位相的場の理論（TQFT）は **コボルディズム圏 $\mathrm{Cob}_d$ からベクトル空間の圏 $\mathrm{Vect}_k$ への対称モノイダル関手**として完全に定義され、解析も完備化も現れない。低次元（$d=1,2$）では圏が**有限個の生成元と有限個の関係式で表示**され、TQFT の分類が純粋な図式の局所変形で完結する。$d=3$ ではモジュラーテンソル圏という有限データが入力になる。これに対し Segal の共形場理論（CFT）公理は射の集まりが**連続的な moduli をもつ**ため、位相ベクトル空間・無限次元 Lie 群という **［ℝ 脱出］** が定義の段階で不可避になる。

---

## 6.1 前提：対称モノイダル圏と対称モノイダル関手

以降で使う構造をすべて明示する。

**定義 6.1.1（モノイダル圏）** モノイダル圏とは、組 $(\mathcal C,\otimes_{\mathcal C},\mathbf 1_{\mathcal C},\alpha_{\mathcal C},\lambda_{\mathcal C},\rho_{\mathcal C})$ であって、

- $\mathcal C$ は圏（対象の類 $\mathrm{Ob}(\mathcal C)$、各 $X,Y\in\mathrm{Ob}(\mathcal C)$ に対する射の集合 $\mathrm{Hom}_{\mathcal C}(X,Y)$、合成 $\circ_{\mathcal C}$、恒等射 $\mathrm{id}_X\in\mathrm{Hom}_{\mathcal C}(X,X)$）、
- $\otimes_{\mathcal C}\colon\mathcal C\times\mathcal C\to\mathcal C$ は関手、$\mathbf 1_{\mathcal C}\in\mathrm{Ob}(\mathcal C)$ は**単位対象**、
- **結合子** $\alpha_{\mathcal C}$ は自然同型 $\alpha_{X,Y,Z}\colon (X\otimes_{\mathcal C}Y)\otimes_{\mathcal C}Z\xrightarrow{\ \sim\ }X\otimes_{\mathcal C}(Y\otimes_{\mathcal C}Z)$、
- **単位子** $\lambda_X\colon\mathbf 1_{\mathcal C}\otimes_{\mathcal C}X\xrightarrow{\sim}X$、$\rho_X\colon X\otimes_{\mathcal C}\mathbf 1_{\mathcal C}\xrightarrow{\sim}X$

であり、五角形公理（$\alpha$ の 4 重積に関する可換性）と三角形公理（$\alpha,\lambda,\rho$ の整合）を満たすものをいう。さらに自然同型 $\beta_{X,Y}\colon X\otimes_{\mathcal C}Y\xrightarrow{\sim}Y\otimes_{\mathcal C}X$ が六角形公理と $\beta_{Y,X}\circ\beta_{X,Y}=\mathrm{id}_{X\otimes_{\mathcal C}Y}$ を満たすとき、$(\mathcal C,\beta)$ を**対称モノイダル圏**という。

**定義 6.1.2（対称モノイダル関手）** 対称モノイダル圏 $\mathcal C,\mathcal D$ の間の対称モノイダル関手とは、組 $(Z,\zeta,\zeta_0)$ であって、$Z\colon\mathcal C\to\mathcal D$ は関手、$\zeta_{X,Y}\colon Z(X)\otimes_{\mathcal D}Z(Y)\xrightarrow{\sim}Z(X\otimes_{\mathcal C}Y)$ は自然同型、$\zeta_0\colon\mathbf 1_{\mathcal D}\xrightarrow{\sim}Z(\mathbf 1_{\mathcal C})$ は同型で、$\alpha,\lambda,\rho,\beta$ のすべてと可換なものをいう。

**定義 6.1.3（双対対象）** モノイダル圏 $\mathcal C$ の対象 $X$ が**双対可能**とは、対象 $X^\vee\in\mathrm{Ob}(\mathcal C)$ と射
$$
\mathrm{coev}_X\colon\mathbf 1_{\mathcal C}\to X\otimes_{\mathcal C}X^\vee,\qquad
\mathrm{ev}_X\colon X^\vee\otimes_{\mathcal C}X\to\mathbf 1_{\mathcal C}
$$
が存在し、2 本の**ジグザグ等式**（$(\mathrm{ev}_X\otimes\mathrm{id})\circ(\mathrm{id}\otimes\mathrm{coev}_X)$ 等が単位子を通じて恒等射になる）を満たすことをいう。

**命題 6.1.4** $(\mathrm{Vect}_k,\otimes_k,k)$ において、対象 $V$ が双対可能であることと $\dim_k V<\infty$ であることは同値。$\dim_k V=\infty$ のとき $\mathrm{coev}$ に対応する元は $V\otimes_k V^*$ に存在しない（無限和が必要になる）。**（確立した定理）**

---

## 6.2 コボルディズム圏 $\mathrm{Cob}_d$

$d\in\mathbb Z_{\ge1}$ を固定する。

**定義 6.2.1** 圏 $\mathrm{Cob}_d$ を次で定める。

- **対象**：閉（コンパクト・境界なし）向き付けられた滑らかな $(d-1)$ 次元多様体 $\Sigma$。空多様体 $\varnothing_{d-1}$ も対象とする。
- **射**：$\Sigma_0,\Sigma_1$ を対象とする。**コボルディズム**とは、コンパクト向き付き $d$ 次元多様体 $M$ と、向き付きを保つ微分同相 $\partial M\cong\overline{\Sigma_0}\sqcup\Sigma_1$（$\overline{\Sigma_0}$ は $\Sigma_0$ の向きを反転したもの）の組である。$\mathrm{Hom}_{\mathrm{Cob}_d}(\Sigma_0,\Sigma_1)$ は、境界同一視を保つ微分同相による同値類の集合とする。
- **合成**：$M\colon\Sigma_0\to\Sigma_1$、$N\colon\Sigma_1\to\Sigma_2$ に対し、$\Sigma_1$ の襟近傍（collar）に沿って貼り合わせた $N\circ M:=M\cup_{\Sigma_1}N$。襟の取り方の選択に依らず微分同相類は一意（**定理**：collar neighborhood theorem と一意性）。
- **恒等射**：円柱 $\Sigma\times[0,1]$。$(\Sigma\times[0,1])\cup_\Sigma(\Sigma\times[0,1])\cong\Sigma\times[0,1]$ により恒等律が成り立つ。

**モノイダル構造**：$\otimes:=\sqcup$（非交和）、単位対象 $\mathbf 1_{\mathrm{Cob}_d}=\varnothing_{d-1}$。結合子 $\alpha_{\Sigma_0,\Sigma_1,\Sigma_2}\colon(\Sigma_0\sqcup\Sigma_1)\sqcup\Sigma_2\to\Sigma_0\sqcup(\Sigma_1\sqcup\Sigma_2)$ は標準的微分同相の与える円柱コボルディズム、単位子 $\lambda_\Sigma\colon\varnothing\sqcup\Sigma\to\Sigma$ も同様。対称性 $\beta_{\Sigma_0,\Sigma_1}$ は $(\Sigma_0\sqcup\Sigma_1)\times[0,1]$ を、出口側で成分を入れ替えて $\Sigma_1\sqcup\Sigma_0$ と同一視したコボルディズム。$\beta\circ\beta=\mathrm{id}$ は貼り合わせた多様体が円柱に微分同相であることから従う。

**命題 6.2.2（射の集まりの大きさ）** 各 $\Sigma_0,\Sigma_1$ に対し $\mathrm{Hom}_{\mathrm{Cob}_d}(\Sigma_0,\Sigma_1)$ は**可算集合**である。理由：Whitehead の定理により任意の滑らかなコンパクト多様体は滑らかな三角形分割をもち、有限単体複体は同型を除いて可算個しかない。さらに一つの PL 多様体上の滑らか構造は（$d\ge5$ では Hirsch–Mazur により $[M,\mathrm{PL}/O]$ で分類されて可算、$d\le4$ では PL 構造ごとに一意）可算個。**（確立した定理の組合せ。文献確認を要する箇所）**

これは重要な性質である。$\mathrm{Cob}_d$ は**可算な組合せ的圏**であり、その中では極限も収束も語られない。$\mathbb R$ や $\mathbb C$ は、値域 $\mathrm{Vect}_k$ の係数体としてのみ現れる。

---

## 6.3 Atiyah の公理

$k$ を体とする（多くの場合 $k=\mathbb C$）。$\mathrm{Vect}_k$ は $k$ 上ベクトル空間と $k$-線型写像の圏、$\otimes_k$、単位対象 $k$、結合子・単位子は標準的なもの、対称性 $\tau_{V,W}(v\otimes w)=w\otimes v$。

**定義 6.3.1（$d$ 次元 TQFT）** $d$ 次元位相的場の理論とは、対称モノイダル関手
$$
Z\colon(\mathrm{Cob}_d,\sqcup,\varnothing)\longrightarrow(\mathrm{Vect}_k,\otimes_k,k)
$$
である。

Atiyah (1988) の公理はこの一文を展開したものであり、次と同値である。

1. **（多重性）** $\zeta_{\Sigma_0,\Sigma_1}\colon Z(\Sigma_0)\otimes_k Z(\Sigma_1)\xrightarrow{\sim}Z(\Sigma_0\sqcup\Sigma_1)$。
2. **（単位）** $\zeta_0\colon k\xrightarrow{\sim}Z(\varnothing_{d-1})$。
3. **（関手性）** $Z(N\circ M)=Z(N)\circ Z(M)$、$Z(\Sigma\times[0,1])=\mathrm{id}_{Z(\Sigma)}$。
4. **（双対）** $Z(\overline\Sigma)\cong Z(\Sigma)^*$。これは公理として課すこともできるが、$\Sigma$ が $\mathrm{Cob}_d$ で双対可能であること（6.4.2）から自動で従う。
5. **（対称性）** $Z(\beta_{\Sigma_0,\Sigma_1})=\tau_{Z(\Sigma_0),Z(\Sigma_1)}$。

**有限次元性を公理に入れるか**：Atiyah の原論文は $Z(\Sigma)$ が有限生成であることを要求している。定義 6.3.1 の形にすれば、これは要求でなく**帰結**になる（6.4.2）。

---

## 6.4 公理からの直接の帰結

**命題 6.4.1（閉多様体の不変量）** 閉向き付き $d$ 次元多様体 $M$ は $\varnothing_{d-1}\to\varnothing_{d-1}$ のコボルディズムであるから、$Z(M)\in\mathrm{Hom}_{\mathrm{Vect}_k}(k,k)=k$。すなわち $Z(M)$ は**体 $k$ の元**であり、$M$ の微分同相不変量。

**命題 6.4.2（有限次元性）** 任意の対象 $\Sigma$ は $\mathrm{Cob}_d$ において双対可能で、$\Sigma^\vee=\overline\Sigma$。実際
$$
\mathrm{coev}_\Sigma\colon\varnothing\to\Sigma\sqcup\overline\Sigma,\qquad
\mathrm{ev}_\Sigma\colon\overline\Sigma\sqcup\Sigma\to\varnothing
$$
をいずれも $\Sigma\times[0,1]$（境界の両成分を出口側／入口側に寄せたもの）で与えると、ジグザグ等式の両辺は $\Sigma\times[0,1]$ に微分同相になる。対称モノイダル関手は双対可能対象を双対可能対象へ写すから $Z(\Sigma)$ は $\mathrm{Vect}_k$ で双対可能、命題 6.1.4 により
$$
\dim_k Z(\Sigma)<\infty .
$$
**（確立した定理）**

**命題 6.4.3（円柱化＝トレース）** $\Sigma$ を閉 $(d-1)$ 多様体とすると $S^1\times\Sigma$ は閉 $d$ 多様体で、$\mathrm{Cob}_d$ の中で $\mathrm{ev}_\Sigma\circ\beta\circ\mathrm{coev}_\Sigma$ と等しい。よって
$$
Z(S^1\times\Sigma)=\mathrm{tr}_{Z(\Sigma)}(\mathrm{id}_{Z(\Sigma)})=\dim_k Z(\Sigma)\cdot 1_k\in k .
$$
一般に微分同相 $f\colon\Sigma\to\Sigma$ のマッピングトーラス $M_f$ に対し $Z(M_f)=\mathrm{tr}(Z(\Sigma\times_f[0,1]))$。**（確立した定理）**

**この節の要点（有限・代数的に閉じる）**：定義 6.3.1 に現れるのは、可算集合である射の集合、有限次元ベクトル空間、有限次元行列のトレースだけである。極限・収束・完備化は一切現れない。したがって TQFT は**完全に有限的・代数的な対象**であり、$\mathbb C$ は係数体としてのみ使われる（$k$ は任意の体でよく、$\mathbb Q$ や有限体でも定義される）。

---

## 6.5 $d=1$ の完全分類

**定理 6.5.1** 1 次元 TQFT $Z\colon\mathrm{Cob}_1\to\mathrm{Vect}_k$ の圏は、有限次元 $k$-ベクトル空間の圏と同値。対応は $Z\mapsto Z(\mathrm{pt}_+)$。**（確立した定理）**

証明の骨子：$\mathrm{Cob}_1$ の対象は符号付き点の有限列、射は有限個の区間の合併。生成元は $\mathrm{pt}_+,\mathrm{pt}_-$ と 2 種の「曲がった区間」$\mathrm{coev},\mathrm{ev}$、関係式はジグザグ 2 本のみ。$\mathrm{Cob}_1$ は**双対可能対象上の自由対称モノイダル圏**であり、関手を与えることは双対可能対象＝有限次元空間を 1 つ選ぶことに等しい。

---

## 6.6 $d=2$：可換 Frobenius 代数との同値

**定義 6.6.1（可換 Frobenius 代数）** $k$ 上の可換 Frobenius 代数とは、組 $(A,m,\eta,\varepsilon)$ であって、$A$ は $k$-ベクトル空間、$m\colon A\otimes_k A\to A$ は結合的・可換な積、$\eta\colon k\to A$ は単位、$\varepsilon\colon A\to k$ は線型形式で、双線型形式
$$
\langle\cdot,\cdot\rangle\colon A\times A\to k,\qquad \langle a,b\rangle:=\varepsilon(m(a\otimes b))
$$
が非退化なものをいう。非退化性から $\dim_k A<\infty$ が従う。余積 $\Delta\colon A\to A\otimes_k A$ が $\langle\cdot,\cdot\rangle$ の逆を用いて一意に定まり、**Frobenius 関係式**
$$
(m\otimes\mathrm{id}_A)\circ(\mathrm{id}_A\otimes\Delta)=\Delta\circ m=(\mathrm{id}_A\otimes m)\circ(\Delta\otimes\mathrm{id}_A)
$$
が成り立つ。

**定理 6.6.2（2d TQFT の分類）** 対称モノイダル関手の圏 $\mathrm{Fun}^{\otimes}(\mathrm{Cob}_2,\mathrm{Vect}_k)$ は、$k$ 上の可換 Frobenius 代数の圏と同値である。対応は $Z\mapsto A:=Z(S^1)$、積 $m=Z(P)$（$P$ は pair of pants、$S^1\sqcup S^1\to S^1$）、単位 $\eta=Z(D)$（$D$ は円板、$\varnothing\to S^1$）、余単位 $\varepsilon=Z(\overline D)$（$S^1\to\varnothing$）。**（確立した定理：Dijkgraaf 1989（学位論文）、Abrams 1996、Kock 2004）**

**証明の骨子（有限記号操作で閉じる部分）**

1. **分類**：コンパクト連結向き付き曲面で境界をもつものは、種数 $g\in\mathbb Z_{\ge0}$、入口境界数 $p\in\mathbb Z_{\ge0}$、出口境界数 $q\in\mathbb Z_{\ge0}$ の三つ組で微分同相を除いて決まる。すなわち $\mathrm{Hom}_{\mathrm{Cob}_2}$ の元は**有限個の整数**で完全に記述される。
2. **生成**：任意のコボルディズムに Morse 関数を取ると、指数 $0,1,2$ の臨界点に対応する初等コボルディズムの合成に分解する。初等片は
   $$
   \eta\ (\varnothing\to S^1),\quad \varepsilon\ (S^1\to\varnothing),\quad m\ (S^1\sqcup S^1\to S^1),\quad \Delta\ (S^1\to S^1\sqcup S^1),\quad \mathrm{id}_{S^1},\quad \beta_{S^1,S^1}
   $$
   の $\sqcup$ と $\circ$ による組合せに限られる。
3. **関係式**：同じコボルディズムの 2 つの Morse 分解は、Cerf 理論により**有限回の局所変形**（臨界点の生成消滅、臨界値の入れ替え、ハンドルスライド）で移り合う。各局所変形はちょうど、結合律・単位律・余結合律・余単位律・可換律・Frobenius 関係式のいずれか 1 本に対応する。
4. したがって $\mathrm{Cob}_2$ は**可換 Frobenius 対象上の自由対称モノイダル圏**であり、関手を与えることは可換 Frobenius 代数を 1 つ選ぶことに等しい。

**帰結 6.6.3** 閉種数 $g$ 曲面 $\Sigma_g$ に対し、**ハンドル元** $h:=m(\Delta(\eta(1_k)))\in A$ を用いて
$$
Z(\Sigma_g)=\varepsilon(h^{g})\in k \qquad (h^0:=\eta(1_k)) .
$$
$A$ が半単純（$k$ 代数閉、$\mathrm{char}\,k=0$）なら $A\cong k^{r}$、$\varepsilon(e_i)=\lambda_i\in k^\times$ として $Z(\Sigma_g)=\sum_{i=1}^r\lambda_i^{\,1-g}$。

**このリポジトリの関心との関係**：定理 6.6.2 は「有限個の生成元と有限個の関係式による圏の表示」から「代数構造の分類」を導く典型であり、証明の実体は**図式の局所変形の有限列**である（`docs/research/有限記号操作で証明可能な分野.md` の「低次元トポロジーの局所 move calculus」「Diagrammatic representation theory」に該当）。

**2 次元 Ising 模型との関係を正確に述べる**：格子 Ising 模型の分配関数 $Z_{\text{Ising}}$ は結合定数 $K\in\mathbb R$ と格子（辺の本数）に依存するから、**それ自体は 2d TQFT ではない**（位相的でない）。正確に言えるのは次の 2 点である。

- 有限群 $G$ の群環 $k[G]$ は可換 Frobenius 代数（$G$ アーベルのとき）であり、対応する 2d TQFT は $G$ ゲージ理論（Dijkgraaf–Witten）である。$G=\mathbb Z/2$、$\mathrm{char}\,k\ne2$ のとき $k[\mathbb Z/2]\cong k\times k$ という代数同型が、Ising 模型の $\mathbb Z/2$ 対称性の gauging と自己双対性（Kramers–Wannier）の代数的内容にあたる。
- 臨界点での連続極限は $c=1/2$ の共形場理論であり、その表現圏（Ising モジュラーテンソル圏、単純対象 $\mathbf 1,\sigma,\psi$）が §6.7 の意味で 3 次元 TQFT を定める。詳細は第 07 章。

---

## 6.7 $d=3$：Reshetikhin–Turaev と Turaev–Viro

**定義 6.7.1（モジュラーテンソル圏、概要）** $\mathbb C$ 上のモジュラーテンソル圏（MTC）$\mathcal C$ とは、半単純・$\mathbb C$-線型なリボン組紐テンソル圏で、単純対象の同型類の集合 $I=\{X_0=\mathbf 1,X_1,\dots,X_{r-1}\}$ が**有限集合**、各 $\mathrm{Hom}_{\mathcal C}(X,Y)$ が有限次元、かつ $S$ 行列 $S_{ij}\in\mathbb C$（Hopf link の不変量）が可逆なもの。融合係数 $N_{ij}^k:=\dim_{\mathbb C}\mathrm{Hom}(X_i\otimes X_j,X_k)\in\mathbb Z_{\ge0}$、$F$ 行列・$R$ 行列は有限個の複素数の族。

**定理 6.7.2（Reshetikhin–Turaev 構成）** MTC $\mathcal C$ から 3 次元 TQFT $Z_{\mathcal C}\colon\mathrm{Cob}_3\to\mathrm{Vect}_{\mathbb C}$ が構成される（正確には、枠付き 3 次元多様体または $p_1$-構造つきコボルディズムに対する関手、あるいは射影的関手として）。閉 3 次元多様体 $M$ に対する値は、$S^3$ 内の枠付き絡み目 $L$ による手術表示 $M=S^3_L$ を取り、$\mathcal C$ の色付き絡み目不変量の有限和として与えられる。**（確立した定理：Reshetikhin–Turaev 1991、Turaev 1994）**

**有限・代数的に閉じる点**：定理 6.7.2 の well-definedness は、2 つの手術表示が **Kirby move の有限列**で移り合う（Kirby 1978, Fenn–Rourke 1979）ことに帰着し、各 move の下での不変性が MTC の有限データ（$S,T,N_{ij}^k,F,R$）の有限個の等式に帰着する。入力も出力も有限。

**定理 6.7.3（Turaev–Viro 構成）** 球面融合圏 $\mathcal A$ から、3 次元多様体の三角形分割上の**状態和**として不変量 $\mathrm{TV}_{\mathcal A}(M)$ が定義され、これは Pachner move（三角形分割の有限個の局所変形）の下で不変であるから三角形分割に依らない。**（確立した定理：Turaev–Viro 1992、Barrett–Westbury 1996）**

**定理 6.7.4** $\mathrm{TV}_{\mathcal A}\cong\mathrm{RT}_{Z(\mathcal A)}$（$Z(\mathcal A)$ は Drinfeld 中心）。**（確立した定理：Turaev–Virelizier 2010、Balsam–Kirillov）**

**Chern–Simons と WRT 不変量**：Witten (1989) は、コンパクト単純 Lie 群 $G$ と $k\in\mathbb Z$ に対する Chern–Simons 作用の経路積分として 3 次元 TQFT を提示した。**経路積分自体は数学的に定義されていない**（無限次元の接続空間上の測度が構成されていない）。数学的に定義されているのは、$U_q(\mathfrak{sl}_2)$（$q=e^{2\pi i/(k+2)}$、1 の冪根）から得られる MTC への定理 6.7.2 の適用であり、これが Witten–Reshetikhin–Turaev 不変量 $\tau_k(M)\in\mathbb C$ である。値は円分体 $\mathbb Q(\zeta_{4(k+2)})$ の元として与えられる（**代数的**）。

**Jones 多項式との関係**：$S^3$ 内の絡み目 $L$ に対し、$\mathfrak{sl}_2$ の 2 次元表現で色付けした $\mathrm{RT}$ 不変量は Jones 多項式 $V_L(t)\in\mathbb Z[t^{\pm1/2}]$ に一致する。Jones 多項式は Kauffman bracket の**有限個のスケイン関係式**による帰納計算で定まる Laurent 多項式であり、係数は整数。**（確立した定理：Jones 1985、Kauffman 1987、Reshetikhin–Turaev 1990）**

---

## 6.8 拡張 TQFT と cobordism hypothesis

定義 6.3.1 は $d$ 次元多様体と $(d-1)$ 次元多様体しか見ない。**拡張 TQFT** は、$0,1,\dots,d$ 次元すべての多様体に値を割り当てる。

**定義 6.8.1（概要）** $\mathrm{Bord}_n$ を対称モノイダル $(\infty,n)$-圏とする：対象は $0$ 次元多様体、$1$-射は $1$ 次元コボルディズム、…、$n$-射は $n$ 次元コボルディズム、$n+1$ 次以上の射は微分同相とその間のイソトピー（$\infty$-亜群）。枠付き版を $\mathrm{Bord}_n^{\mathrm{fr}}$ と書く。**完全拡張 TQFT** とは、対称モノイダル $(\infty,n)$-圏 $\mathcal C$ への対称モノイダル関手 $Z\colon\mathrm{Bord}_n^{\mathrm{fr}}\to\mathcal C$。

**定義 6.8.2（完全双対可能）** $\mathcal C$ の対象 $X$ が**完全双対可能**（fully dualizable）とは、$X$ が双対可能で、$\mathrm{ev}_X,\mathrm{coev}_X$ が随伴をもち、その随伴の単位・余単位がまた随伴をもち…という条件が第 $n$ 段まで成り立つこと。

**定理／予想 6.8.3（cobordism hypothesis）** 評価関手
$$
\mathrm{Fun}^{\otimes}(\mathrm{Bord}_n^{\mathrm{fr}},\mathcal C)\longrightarrow \mathcal C^{\mathrm{fd},\sim},\qquad Z\mapsto Z(\mathrm{pt}_+)
$$
（右辺は完全双対可能対象のなす $\infty$-亜群）は $\infty$-亜群の同値である。すなわち完全拡張枠付き TQFT は、1 点への値である完全双対可能対象によって完全に決まる。

**現状（正直に）**：Baez–Dolan (1995) が予想として提出。Lurie (2009) が詳細な証明の**スケッチ**を与えた（"On the classification of topological field theories"）。このスケッチは広く受け入れられているが、**完全な書き下しは Lurie 自身によっては公刊されていない**。その後 Ayala–Francis、Grady–Pavlov らによる独立な証明が発表されているが、コミュニティ全体で完全に検証済みとして定着した単一の文献があるとは言い難い。**（要文献確認：本ノートの中でも最も状況の流動的な項目）** 定理 6.5.1 は $n=1$ の場合にあたり、これは完全に証明されている。

**有限性の観点**：cobordism hypothesis は、$\mathrm{Bord}_n^{\mathrm{fr}}$ が「1 個の完全双対可能対象の上の自由対称モノイダル $(\infty,n)$-圏」であるという主張であり、$d=1,2$ で見た「有限生成元・有限関係式による表示」の $n$ 次元版である。ただし $(\infty,n)$-圏の取り扱い自体はホモトピー論的で、有限記号操作には還元されていない。

---

## 6.9 Segal の共形場理論公理

**定義 6.9.1（Segal 圏、概要）** 圏 $\mathcal{CFT}$ を次で定める。

- **対象**：標準円 $S^1$ の有限個のコピー、すなわち $n\in\mathbb Z_{\ge0}$（$n$ 本の円）。
- **射**：$\mathrm{Hom}(n,m)$ は、コンパクトな Riemann 面 $\Sigma$（複素構造つき、境界つき）と、境界成分から標準円への解析的パラメータ付け（$n$ 本を入口、$m$ 本を出口として区別）の組の、双正則同値類全体。
- **合成**：出口境界と入口境界をパラメータ付けを介して貼り合わせる（sewing）。貼り合わせた曲面に複素構造が一意に入る（**定理**）。
- **モノイダル構造**：非交和、単位対象は $0$（空曲面）、結合子・単位子・対称性は 6.2 と同様に構成される。

**定義 6.9.2（Segal の CFT）** 弱い形では、$\mathcal{CFT}$ から位相ベクトル空間の圏への対称モノイダル関手 $Z$ であって、$Z(n)=H^{\widehat\otimes n}$（$H$ は 1 本の円に付随する位相ベクトル空間、$\widehat\otimes$ は完備化テンソル積）、かつ $\mathrm{Hom}(n,m)$ の**moduli 上で正則に依存**するもの。

**［ℝ 脱出］** ここで解析への移行が定義そのものに含まれる。列挙する。

1. $\mathrm{Hom}_{\mathcal{CFT}}(n,m)$ は**集合として非可算**である。種数 $g$、境界 $n+m$ 本の Riemann 面の moduli 空間 $\mathcal M_{g,n+m}$ は複素次元 $3g-3+n+m$ の（軌道体としての）複素多様体であり、さらに境界のパラメータ付けの選択が $\mathrm{Diff}^+(S^1)^{n+m}$ の分だけ加わる。$\mathrm{Diff}^+(S^1)$ は**無限次元 Fréchet Lie 群**。$\mathrm{Cob}_d$ の射が可算だった（命題 6.2.2）のと対照的である。
2. $H$ は一般に無限次元であり、位相ベクトル空間（多くの場合 Hilbert 空間）としてのみ意味をもつ。$Z$ が sewing と両立するには、貼り合わせに伴う無限和 $\sum_n q^{L_0}$ 型の**収束**が必要。
3. 「moduli 上で正則」という要求自体が実解析・複素解析の言語であり、有限記号操作には落ちない。

**中心拡大（関手の射影化）** sewing は一般に**射影的にしか**関手的でない。原因は、Riemann 面上の行列式直線束（determinant line bundle）$\mathrm{Det}\to\mathcal M$ が自明でないことである。正確な形は次のとおり。

**定理 6.9.3** Segal の意味の CFT は、$\mathcal{CFT}$ そのものではなく、行列式直線束の $c$ 乗（$c\in\mathbb C$ は**中心電荷**）で「装備された」（rigged）曲面の圏の上でのみ真に関手的になる。同値な言い方として、$Z$ は $\mathcal{CFT}$ から位相ベクトル空間の圏への**射影関手**であり、射影因子の測る中心拡大が $\mathrm{Diff}^+(S^1)$ の Lie 環 $\mathrm{Vect}(S^1)$ の中心拡大＝**Virasoro 代数**である。中心電荷 $c$ が拡大のクラスを決める。**（確立した枠組み：Segal 1988/2004。個々の模型に対する完全な構成は模型ごと）**

Virasoro 代数の代数的側面は第 07 章で扱う。強調すべき対比は次のとおり：**中心拡大の代数（Virasoro）は可算・組合せ的だが、それが現れる Segal 圏の側は非可算・解析的**である。

**現状**：Segal の公理を完全に満たす非自明な例の構成は模型ごとに大仕事であり、一般論として「有理的 CFT データ ⟹ Segal 関手」を与える定理は完成していない（Huang による頂点作用素代数からの部分的構成、Fiore–Kong–Runkel などの代数的再定式化がある）。**（要文献確認）**

---

## 6.10 関手的定式化が捉えるもの・捉えないもの

**捉えるもの：局所性＝切り貼り**。関手性 $Z(N\circ M)=Z(N)\circ Z(M)$ とモノイダル性 $Z(\Sigma_0\sqcup\Sigma_1)\cong Z(\Sigma_0)\otimes Z(\Sigma_1)$ は、「時空を切って計算し、貼り直しても同じ」という要請の完全な定式化である。

**捉えないもの：作用素とスペクトル**。Wightman 公理系（第 01–02 章）や Haag–Kastler の代数的場の量子論（第 03 章）は次を直接に含む。

- 場 $\varphi$ が作用素値超関数であること、
- Hilbert 空間 $\mathcal H$ 上のユニタリ表現 $U(a,\Lambda)$ と、その生成子の**スペクトル条件**（エネルギー正値性、質量ギャップ）、
- 因果的に離れた領域の作用素の可換性。

TQFT の関手 $Z$ は、これらのうち「$Z(\Sigma)$ というベクトル空間がある」以上のことを言わない。$Z(\Sigma)$ に内積・ハミルトニアン・スペクトルを与えるのは追加の構造（ユニタリ性、正値性、正エネルギー条件）である。

**両者の関係（部分的に確立）**

- **Hilbert 空間の再構成**：Segal 型の関手からは、円に付随する空間 $H=Z(S^1)$ と、円柱 $S^1\times[0,t]$ の像として半群 $e^{-tL_0}$ が得られる。ここから $L_0$ のスペクトル情報が読める。逆に、共形ネット（第 03 章）や頂点作用素代数（第 07 章）から $H$ と Virasoro 作用を構成できる。カイラル 2 次元の場合、この三者（Segal 関手・共形ネット・VOA）の関係は部分的に定理として確立している（第 07 章 §7.10）。
- **局所性の 2 通りの表現**：AQFT の局所性は「空間的に離れた領域の作用素環が可換」という**代数の可換性**として書かれ、関手的定式化の局所性は「貼り合わせと合成が両立」という**関手性**として書かれる。両者を一般次元で結ぶ定理は存在しない。カイラル共形場理論という特殊な状況でのみ、対応が定理として証明されている。
- **TQFT は AQFT の縮退した場合ではない**：TQFT は計量に依存しないので Hamiltonian が $0$、すなわち Wightman の意味では自明なスペクトルをもつ。TQFT が保持しているのは真空の縮退度と基底状態の間の位相的情報だけである。

---

## 6.11 数学的対象としての正体（まとめ）

| 定式化 | 数学的対象 | 有限性・可算性 | ℝ 脱出 |
|---|---|---|---|
| $d$ 次元 TQFT | 対称モノイダル関手 $\mathrm{Cob}_d\to\mathrm{Vect}_k$ | 射の集合は可算、$\dim_k Z(\Sigma)<\infty$（帰結） | なし（$k$ は任意の体） |
| 1d TQFT | 有限次元ベクトル空間 1 個 | 完全に有限 | なし |
| 2d TQFT | 可換 Frobenius 代数 $(A,m,\eta,\varepsilon)$ | $\dim_k A<\infty$、圏は有限表示 | なし |
| 3d TQFT (RT) | モジュラーテンソル圏（有限個の単純対象、$S,T,F,R$） | 入力・出力とも有限データ、値は円分体の元 | なし |
| 完全拡張 TQFT | $(\infty,n)$-圏の完全双対可能対象 | 有限的だが $\infty$-圏論を要する | なし（ホモトピー論的複雑さは別問題） |
| Segal CFT | 装備 Riemann 面の圏からの射影的関手 | 射の空間は非可算（$\mathcal M_{g,n}$、$\mathrm{Diff}^+(S^1)$） | **［ℝ 脱出］** 定義の段階で必須 |

**有限・代数的に閉じる部分の明示**（このリポジトリの関心に直結）

- $\mathrm{Cob}_d$ の射の集合は可算（命題 6.2.2）。
- $\mathrm{Cob}_1,\mathrm{Cob}_2$ は有限個の生成元と有限個の関係式で表示され、その証明は Morse 理論・Cerf 理論による**図式の有限回の局所変形**。
- 3d の RT／TV 構成の well-definedness は **Kirby move／Pachner move の有限列**への帰着。
- Jones 多項式・WRT 不変量の値は整数係数 Laurent 多項式／円分体の元であり、有限のスケイン計算で定まる。

**［ℝ 脱出］の所在**：TQFT の枠内には現れない。現れるのは (i) Segal 型 CFT の moduli と完備化、(ii) Chern–Simson の経路積分（そもそも未定義）、(iii) TQFT を物理的な場の理論の低エネルギー極限とみなす際の連続極限、の 3 箇所である。

---

## 6.12 未解決・限界

1. **cobordism hypothesis の完全な証明**：Lurie のスケッチ以降、複数の独立な証明が発表されているが、単一の完全に検証された書き下しの所在は流動的。**（要文献確認）**
2. **Segal 公理を満たす例の一般的構成**：頂点作用素代数のような代数的データから Segal 関手を系統的に作る一般定理は未完成。sewing の収束が模型ごとの解析的仕事として残る。
3. **$d=4$ 以上の TQFT の分類**：$d=4$ では非拡張 TQFT の分類も、拡張 TQFT に対応する 3-圏の分類も未完。Crane–Yetter、Donaldson–Witten 型の理論はあるが、$\mathrm{Cob}_4$ の有限表示は知られていない。$\mathrm{Cob}_4$ における微分同相類の可算性自体は成り立つ（命題 6.2.2）が、判定不能性がある（4 次元多様体の同相判定は $\pi_1$ の語の問題により決定不能）。
4. **非位相的な場の理論の関手的定式化**：計量に依存する理論（Yang–Mills 等）に対する関手的定式化（Stolz–Teichner の幾何的場の理論など）は進行中で、Wightman/AQFT との一般的な等価性は未証明。
5. **関手的定式化とスペクトル条件**：TQFT／CFT の関手から Hilbert 空間の正エネルギー表現を取り出す一般的手続きは、カイラル 2 次元を超えては確立していない。
6. **Chern–Simons 経路積分**：Witten の経路積分の数学的構成（無限次元測度）は未解決。RT 構成はその「答え」を与えるが、経路積分からの導出ではない。

---

## 主要文献

- M. F. Atiyah, "Topological quantum field theories", *Publications Mathématiques de l'IHÉS* **68** (1988), 175–186.
- G. B. Segal, "The definition of conformal field theory", 手稿 1988; *Topology, Geometry and Quantum Field Theory* (LMS Lecture Note Ser. 308), Cambridge (2004), 421–577.
- L. Abrams, "Two-dimensional topological quantum field theories and Frobenius algebras", *Journal of Knot Theory and Its Ramifications* **5** (1996), 569–587.
- J. Kock, *Frobenius Algebras and 2D Topological Quantum Field Theories*, Cambridge University Press (2004).
- R. Dijkgraaf, *A Geometrical Approach to Two-Dimensional Conformal Field Theory*, 学位論文, Utrecht (1989).
- N. Reshetikhin, V. G. Turaev, "Invariants of 3-manifolds via link polynomials and quantum groups", *Inventiones Mathematicae* **103** (1991), 547–597.
- V. G. Turaev, *Quantum Invariants of Knots and 3-Manifolds*, de Gruyter (1994; 3rd ed. 2016).
- V. G. Turaev, O. Y. Viro, "State sum invariants of 3-manifolds and quantum $6j$-symbols", *Topology* **31** (1992), 865–902.
- J. W. Barrett, B. W. Westbury, "Invariants of piecewise-linear 3-manifolds", *Transactions of the AMS* **348** (1996), 3997–4022.
- V. G. Turaev, A. Virelizier, "On two approaches to 3-dimensional TQFTs", *Advances in Mathematics* **230** (2012), 1859–1894.
- E. Witten, "Quantum field theory and the Jones polynomial", *Communications in Mathematical Physics* **121** (1989), 351–399.
- V. F. R. Jones, "A polynomial invariant for knots via von Neumann algebras", *Bulletin of the AMS* **12** (1985), 103–111.
- R. Kirby, "A calculus for framed links in $S^3$", *Inventiones Mathematicae* **45** (1978), 35–56.
- J. C. Baez, J. Dolan, "Higher-dimensional algebra and topological quantum field theory", *Journal of Mathematical Physics* **36** (1995), 6073–6105.
- J. Lurie, "On the classification of topological field theories", *Current Developments in Mathematics* **2008** (2009), 129–280.
- D. Ayala, J. Francis, "The cobordism hypothesis", arXiv:1705.02240.
- D. Grady, D. Pavlov, "Extended field theories are local and have classifying spaces", arXiv:2011.01208.
- J. H. C. Whitehead, "On $C^1$-complexes", *Annals of Mathematics* **41** (1940), 809–824（滑らかな三角形分割）.
- M. W. Hirsch, B. Mazur, *Smoothings of Piecewise Linear Manifolds*, Annals of Math. Studies 80, Princeton (1974).
- S. Stolz, P. Teichner, "Supersymmetric field theories and generalized cohomology", *Mathematical Foundations of Quantum Field Theory and Perturbative String Theory*, Proc. Sympos. Pure Math. 83, AMS (2011), 279–340.
