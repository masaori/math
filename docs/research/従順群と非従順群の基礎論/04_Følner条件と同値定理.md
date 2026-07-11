# 04 Følner 条件と同値定理

[`00`](00_記法と集合論的規約.md)–[`03`](03_従順性の定義.md) に従う。本章は従順性の**組合せ的特徴づけ**（Følner 条件）と、不変平均・Følner・Reiter の同値を厳密に述べる。整数の濃度と実数の比を [`00 §0.5`](00_記法と集合論的規約.md) の規約で峻別する。

---

## 4.1 Følner 比・Følner ネット

$s\in G$, $F\in\mathcal P_{\mathrm{fin}}(G)$ に対し、$s\cdot_G F:=\{s\cdot_G x:x\in F\}\in\mathcal P_{\mathrm{fin}}(G)$、対称差 $s\cdot_G F\mathbin{\triangle}F:=(s\cdot_G F\setminus F)\cup(F\setminus s\cdot_G F)\in\mathcal P_{\mathrm{fin}}(G)$。

**定義 4.1（Følner 比）.** $F\in\mathcal P_{\mathrm{fin}}(G)$, $F\ne\varnothing$, $s\in G$ に対し
$$
r_G(s,F):=\frac{\iota_{\mathbb Z\hookrightarrow\mathbb R}\bigl(\#(s\cdot_G F\mathbin{\triangle}F)\bigr)}{\iota_{\mathbb Z\hookrightarrow\mathbb R}(\#F)}\ \in\ \mathbb R_{\ge0}.
$$
分子・分母は整数 $\#(\cdot)\in\mathbb Z_{\ge0}$ を $\iota_{\mathbb Z\hookrightarrow\mathbb R}$ で実数へ埋め込んだもの、比は $\mathbb R$ の商（§0.5）。**この量が実数になるのが、有限集合の組合せから $\mathbb R$ へ移る点**。

**定義 4.2（Følner ネット）.** 有向集合 $(I,\preceq_I)$ を添字とするネット $(F_i)_{i\in I}$（各 $F_i\in\mathcal P_{\mathrm{fin}}(G)$, $F_i\ne\varnothing$）が**左 Følner ネット**であるとは、任意の $s\in G$ に対し
$$
r_G(s,F_i)\ \xrightarrow[i\in I]{\ \mathbb R\ }\ 0_{\mathbb R},
$$
すなわち任意の $\varepsilon\in\mathbb R_{>0}$ に対しある $i_0\in I$ が存在し、$i_0\preceq_I i$ なる全 $i\in I$ で $r_G(s,F_i)\le_{\mathbb R}\varepsilon$。

**定義 4.3（Følner 条件）.** $G$ が**左 Følner 条件**を満たすとは、左 Følner ネットが存在すること。

**注意 4.4（列で足りる場合）.** $G$ が可算生成なら、有限生成部分の増大列を使い添字 $I=\mathbb Z_{\ge0}$ の**列** $(F_n)_{n\in\mathbb Z_{\ge0}}$ が取れる。非可算生成群では一般にネットが必要（$G$ の有限部分集合の有向系を添字にする）。

**補題 4.5（同値な定式化：$\bigl|\cdot\bigr|$ 内部版）.** $r_G(s,F)$ の代わりに $\dfrac{\iota(\#(s\cdot_G F\setminus F))}{\iota(\#F)}$ を用いても Følner ネットの定義は同値。実際 $\#(s\cdot_G F\mathbin{\triangle}F)=2\cdot_{\mathbb Z}\#(s\cdot_G F\setminus F)$（左移動が全単射で $\#(s\cdot_G F)=\#F$ ゆえ $\#(s\cdot_G F\setminus F)=\#(F\setminus s\cdot_G F)$）だから、実数比は $2_{\mathbb R}$ 倍の差で、$\to0_{\mathbb R}$ は同値。

---

## 4.2 Følner ⟹ 不変平均

**定理 4.6（Følner ⟹ 従順）.** $G$ が左 Følner 条件（定義 4.3）を満たすなら、$G$ は従順（左不変平均をもつ）。
*証明.* 左 Følner ネット $(F_i)_{i\in I}$ を取る。各 $i\in I$ に対し「$F_i$ 上の計数平均」
$$
m_i\colon\ell^\infty(G,\mathbb R)\to\mathbb R,\qquad m_i(f):=\frac{1}{\iota(\#F_i)}\cdot_{\mathbb R}\sum_{g\in F_i}f(g)\ \in\mathbb R
$$
を定める（$F_i$ 有限ゆえ和は $\mathbb R$ 内有限和）。各 $m_i$ は平均（命題 3.3 と同様に (M1)(M2)(M3)）。
評価：$s\in G,\ f\in\ell^\infty(G,\mathbb R)$ に対し
$$
m_i(L_s f)-_{\mathbb R}m_i(f)=\frac{1}{\iota(\#F_i)}\cdot_{\mathbb R}\Bigl(\sum_{g\in F_i}f(s^{-1_G}\cdot_G g)-_{\mathbb R}\sum_{g\in F_i}f(g)\Bigr).
$$
第一の和は $g'=s^{-1_G}\cdot_G g$ と置換して $\sum_{g'\in s^{-1_G}\cdot_G F_i}f(g')$。ゆえ二つの和の差は $s^{-1_G}\cdot_G F_i$ と $F_i$ の対称差上の項のみに寄与し、各項は $|f(g')|_{\mathbb R}\le_{\mathbb R}\lVert f\rVert_\infty$ で抑えられるから
$$
\bigl|m_i(L_s f)-_{\mathbb R}m_i(f)\bigr|_{\mathbb R}\ \le_{\mathbb R}\ \lVert f\rVert_\infty\cdot_{\mathbb R}\frac{\iota\bigl(\#(s^{-1_G}\cdot_G F_i\mathbin{\triangle}F_i)\bigr)}{\iota(\#F_i)}=\lVert f\rVert_\infty\cdot_{\mathbb R}r_G(s^{-1_G},F_i)\ \xrightarrow[i]{\mathbb R}\ 0_{\mathbb R}.
$$
（最後は $(F_i)$ が Følner ネットで、$s^{-1_G}\in G$ に対しても比が $0_{\mathbb R}$ へ収束することによる。）
極限をとるために、$\ell^\infty(G,\mathbb R)^{*}$ の単位球は弱$^*$位相でコンパクト（**Banach–Alaoglu 定理、選択公理を使用**）。ネット $(m_i)_{i\in I}$ はこの球に入るので、弱$^*$収束する部分ネット $(m_{i_j})_{j\in J}$ とその極限 $m\in\ell^\infty(G,\mathbb R)^{*}$ が存在。$m$ は各 $f$ で $m(f)=\lim_j m_{i_j}(f)\in\mathbb R$。平均の3公理は各 $m_{i_j}$ から極限に遺伝（(M2) は閉条件、(M3) は $m(\mathbf 1_G)=\lim 1_{\mathbb R}=1_{\mathbb R}$）。左不変性は上の評価から $m(L_s f)-_{\mathbb R}m(f)=\lim_j\bigl(m_{i_j}(L_s f)-_{\mathbb R}m_{i_j}(f)\bigr)=0_{\mathbb R}$。ゆえ $m$ は左不変平均。∎

**注意 4.7（$\mathbb R$ 脱出点）.** この証明で非可算・選択公理を使うのは (i) $\ell^\infty(G,\mathbb R)$ が非可算次元 Banach 空間である点、(ii) Banach–Alaoglu（弱$^*$コンパクト性、選択公理）で極限平均を取り出す点。**Følner ネット自体（有限集合と実数比 $r_G(s,F_i)$）は組合せ的だが、そこから不変平均へ渡る段で非可算構造へ脱出する**（[`02 注意 2.13`](02_関数空間ℓ∞と平均.md) と整合）。

---

## 4.3 不変平均 ⟹ Følner

**定理 4.8（従順 ⟹ Følner）.** $G$ が従順なら左 Følner 条件を満たす。
*証明の構成（Namioka の議論）.* 左不変平均 $m$ の存在から出発する。まず $m$ は $\ell^1(G,\mathbb R)$（総和可能関数、$\lVert\cdot\rVert_1$ ノルム）の確率ベクトルによって弱$^*$近似できる：確率単体
$$
\mathrm{Prob}_{\mathrm{fin}}(G):=\Bigl\{\varphi\colon G\to\mathbb R_{\ge0}\ \Big|\ \#\{g:\varphi(g)\ne0_{\mathbb R}\}\in\mathbb Z_{\ge0},\ \sum_{g\in G}\varphi(g)=1_{\mathbb R}\Bigr\}\subseteq\ell^1(G,\mathbb R)
$$
（有限台の確率ベクトル）を考える。$\ell^1(G,\mathbb R)$ は $\ell^\infty(G,\mathbb R)^{*}$ の中で弱$^*$稠密に埋め込まれ、左不変平均 $m$ の存在は、任意の有限 $S\subseteq G$ と $\varepsilon\in\mathbb R_{>0}$ に対し、ある $\varphi\in\mathrm{Prob}_{\mathrm{fin}}(G)$ が存在して
$$
\forall s\in S:\ \lVert s\ast_G\varphi-_{\ell^1}\varphi\rVert_1\ \le_{\mathbb R}\ \varepsilon
$$
を満たすこと（**Reiter 条件**、§4.4）と同値になる。ここで $(s\ast_G\varphi)(g):=\varphi(s^{-1_G}\cdot_G g)\in\mathbb R$（左移動の $\ell^1$ 版）、$\lVert\psi\rVert_1:=\sum_{g\in G}|\psi(g)|_{\mathbb R}\in\mathbb R_{\ge0}$。
（この同値は凸集合の分離定理＝Hahn–Banach による。$m$ から凸結合近似が取れ、逆に Reiter から $m$ が構成できる。）
つづいて **Namioka の補題**：$\ell^1$ の $\varepsilon$-不変確率ベクトル $\varphi$ から、そのレベル集合を用いて Følner 集合を構成する。$\varphi\in\mathrm{Prob}_{\mathrm{fin}}(G)$ と閾値 $t\in\mathbb R_{>0}$ に対し $F_t:=\{g\in G:\varphi(g)>_{\mathbb R}t\}\in\mathcal P_{\mathrm{fin}}(G)$ とおくと、**層積分公式**
$$
\lVert s\ast_G\varphi-_{\ell^1}\varphi\rVert_1=\int_{0_{\mathbb R}}^{\infty}\iota\bigl(\#(s\cdot_G F_t\mathbin{\triangle}F_t)\bigr)\,dt,\qquad 1_{\mathbb R}=\lVert\varphi\rVert_1=\int_{0_{\mathbb R}}^{\infty}\iota(\#F_t)\,dt
$$
が成り立つ（各 $g$ で $\varphi(g)=\int_{0}^{\infty}\chi_{\{\varphi>t\}}(g)\,dt$ を代入し和と積分を交換）。平均値の議論により、ある閾値 $t\in\mathbb R_{>0}$ で
$$
\frac{\iota\bigl(\#(s\cdot_G F_t\mathbin{\triangle}F_t)\bigr)}{\iota(\#F_t)}\ \le_{\mathbb R}\ \lVert s\ast_G\varphi-_{\ell^1}\varphi\rVert_1\quad(\text{をすべての }s\in S\text{ で同時に})
$$
を満たす $F_t\ne\varnothing$ が取れる。$S\subseteq G$ 有限と $\varepsilon\in\mathbb R_{>0}$ を有向系で走らせ、対応する $F_{S,\varepsilon}$ をネットに組めば左 Følner ネットを得る。∎

**注意 4.9.** 定理 4.8 の証明も Hahn–Banach（分離定理）を使う。従順 ⟺ Følner の同値は、両向きとも $\mathbb R$／選択公理を巻き込む（§4.2 注意 4.7）。**Følner ネットの存在という「結論」は有限集合と整数比の言葉だが、その存在証明・不変平均との往復は非可算構造を要する。**

---

## 4.4 Reiter 条件（まとめて明示）

**定義 4.10（Reiter 条件 $(P_1)$）.** $G$ が Reiter 条件を満たすとは、任意の有限 $S\subseteq G$ と $\varepsilon\in\mathbb R_{>0}$ に対しある $\varphi\in\mathrm{Prob}_{\mathrm{fin}}(G)$ が存在して、任意の $s\in S$ で $\lVert s\ast_G\varphi-_{\ell^1}\varphi\rVert_1\le_{\mathbb R}\varepsilon$。

**定理 4.11（同値定理）.** 群 $G$ について次は同値：
1. $G$ は従順（左不変平均をもつ、定義 3.1）。
2. $G$ は左 Følner 条件を満たす（定義 4.3）。
3. $G$ は Reiter 条件を満たす（定義 4.10）。
*証明.* (1)⟹(2) 定理 4.8、(2)⟹(1) 定理 4.6。(1)⟺(3) は §4.3 冒頭の凸分離の議論、(2)⟺(3) は Namioka の層積分公式（§4.3）。∎

**系 4.12（Day の漸近不変性）.** これらはさらに「$\ell^2$ 版 Reiter」（$\lVert s\ast_G\xi-_{\ell^2}\xi\rVert_2\to0_{\mathbb R}$ となる単位ベクトル $\xi\in\ell^2(G,\mathbb R)$ のネット）とも同値（$\varphi\mapsto\xi=\sqrt{\varphi}$ で移行、$\lVert\cdot\rVert_2$ は $\ell^2$ ノルム）。これは正定値関数・弱包含（trivial 表現が正則表現に弱包含される）による特徴づけ（Hulanicki–Reiter）へ繋がる。詳細は文献（Paterson 1988, Runde 2002）。

---

## 4.5 本章の要点（可算／非可算の境界）

- **Følner 条件は「有限集合の組合せ＋実数比の極限」**で書ける。個々の $r_G(s,F)\in\mathbb R_{\ge0}$ は整数濃度から作る実数で、比較的組合せ的。
- **しかし不変平均への往復は非可算構造（Banach–Alaoglu／Hahn–Banach／選択公理）を要する**。ゆえ従順性は $\mathbb R$ 脱出を巻き込む概念（[`../数え上げエントロピーと特殊値/06 §1a`](../数え上げエントロピーと特殊値/06_非周期グラフと双曲格子.md)）。
- この境界の精密化が RΛ 双対で効く：Følner 平均化はエントロピー（$\mathbb R$）を計算する道具で、従順群では「エントロピー＝FK 行列式＝$L^2$-torsion」が清潔に成立（第07章、[`../数え上げエントロピーと特殊値/06 §1`](../数え上げエントロピーと特殊値/06_非周期グラフと双曲格子.md)）。
