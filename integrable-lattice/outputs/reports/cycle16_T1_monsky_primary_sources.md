# cycle 16 / T1: Monsky / Cuoco–Monsky 原論文の一次確認と、Kataoka 引用との突合

対象: `outputs/papers/001_R_Lambda_duality/notes.md` の「未解決リスク」3・4。

- リスク 3: Monsky / Cuoco–Monsky の**原論文本文が未取得**で、Kataoka arXiv:2606.03579 の
  引用が正確であることを前提にしていた。
- リスク 4: Kataoka の **§4–§6（主定理の証明）を読んでいない**。

## 0. 結論（先に置く）

| 項目 | 結果 |
|---|---|
| Monsky / Cuoco–Monsky の**原論文本文の取得** | **成功**。GDZ（Göttinger Digitalisierungszentrum）の IIIF で Math. Ann. 255 (1981) のページ画像を取得し、該当ページを直読した（§1）。 |
| Kataoka の引用（Thm 2.1 / Def 2.2 / Thm 2.3）の正確性 | **すべて原典と一致**。仮定・結論とも改変なし（§3 の突合表）。 |
| **本プロジェクト側の文献同定の誤り** | **1 件発見。** Kataoka の `[14]`（＝ Theorem 5.6 の出典）は Monsky **“On p-adic power series”, Math. Ann. 255, 217–227** であって、本プロジェクトが cycle 15 以来そう思い込んでいた **“Some invariants of $\mathbb{Z}_p^d$-extensions”, Math. Ann. 255, 229–233 ではない**。後者には **Theorem 5.6 は存在しない**（§2）。 |
| Kataoka §4–§6 の読了 | **完了**（§4）。本プロジェクトの用途（不分岐・一般の $P$・$d=2$）に**追加の仮定は要求されない**。ただし「グラフの $\kappa$ として実現できる $P$」には別途の形の制約がある（§4.3）。 |
| **論文 001 本文の数式の誤り** | **1 件発見・確定。** `005_duality.ts` の「規約の注意」にある $-\mathrm{ord}_p(\#V_X)$ の項は**誤り**。Kataoka Proposition 4.4 の原文、独立な数値検証（$d=1$/$d=2$ 計 39 例）、および自前の 3 行の導出の 3 経路が一致して否定する（§5）。 |

**新規性は一切主張しない。** 本 step でやったのは、既知定理の原典を取得し、引用と本文の記述を
一項目ずつ突き合わせ、ずれを 2 件特定したことだけである。

---

## 1. 文献の取得状況（取得できた／できなかったを明示する）

| 文献 | 取得 | 経路 | 読んだ範囲 |
|---|---|---|---|
| P. Monsky, *On p-adic power series*, Math. Ann. **255**, 217–227 (1981) | **本文取得** | GDZ IIIF（下記） | Definition 3.1（半代数的集合）、Theorem 3.4、Theorem 5.5、**Theorem 5.6**、Remark 1・2、References（p.222, 226, 227）。§1–§2, §4 は**未読**。 |
| A. A. Cuoco, P. Monsky, *Class Numbers in $Z_p^d$-Extensions*, Math. Ann. **255**, 235–258 (1981) | **本文取得** | GDZ IIIF | Introduction（pp.235–236）、§1 The Fundamental Estimate 全体（pp.237–238）＝ **Definition 1.1, 1.2, 1.3, Lemma 1.4, 1.5, 1.6, Theorem 1.7, Remark**、§2 冒頭。§3–§7 は**未読**。 |
| P. Monsky, *Some Invariants of $Z_p^d$-Extensions*, Math. Ann. **255**, 229–233 (1981) | **本文取得** | GDZ IIIF | **全 5 ページ全文**（§1–§4、Theorem I–IV、References）。 |
| T. Kataoka, arXiv:2606.03579v1 | **本文取得** | arXiv PDF | **全 28 ページ**。今回 §4（Iwasawa 型漸近公式）・§5（Kida 型公式）・§6（$\lambda,\mu$ の可能な値）・References を読んだ。 |

取得経路（再現手順）:

```
# Math. Ann. 255 (1981) の IIIF マニフェスト（構造＝目次つき）
curl https://gdz.sub.uni-goettingen.de/iiif/presentation/PPN235181684_0255/manifest
# 該当ページ画像（例: p.226 = Monsky Thm 5.6）
curl "https://images.sub.uni-goettingen.de/iiif/image/gdz:PPN235181684_0255:00000230/full/full/0/default.jpg"
```

- **DigiZeitschriften は使えない**: 2025-12-31 でサービス終了（サイト告知を確認）。
  「無料公開分は SUB Göttingen が 2026 年半ばに OA で提供予定」とある。実際、上記 GDZ の
  IIIF で公開されており、そこから取得した。
- **EuDML は 403**（`eudml.org/doc/182837` 等）。Springer は購読要。いずれも使っていない。
- Kataoka PDF は `pdftotext -layout` でテキスト抽出できた。
  （cycle 15 の報告は「テキスト変換では読めなかった」と書いているが、**これは誤り**。
  同じ PDF に対し `pdftotext -layout` は 92KB の可読テキストを出す。以後この手順を使うこと。）

---

## 2. 【重要】Kataoka `[14]` の同定を本プロジェクトが誤っていた

Kataoka の References（PDF p.28）を原文から書き写す:

> `[14]` P. Monsky. **On p-adic power series**. Math. Ann., **255**(2):217–227, 1981.

一方、本プロジェクトの cycle 15 報告・`auto-loop-state.md`・notes.md・および本 step の
タスク記述はいずれも、`[14]` を Monsky *“Some invariants of $\mathbb{Z}_p^d$-extensions”*
(Math. Ann. 255, 229–233) だと想定していた。**これは誤りである。**

根拠（一次情報）: “Some Invariants of $Z_p^d$-Extensions” の**全文を読んだ**。構成は
§1, §2, §3, §4 の 4 節で、命題は Definition 1.1–1.3、Lemma 2.1–2.3、Theorem 3.1–3.3、
そして最終ページの **Theorem I, II, III, IV** だけである。**§5 も Theorem 5.6 も存在しない。**
（同論文の References `[5]` が “Monsky, P.: On p-adic power series. Math. Ann. 255, 217–227 (1981)”
であり、Lemma 2.1 の証明が「This is just Theorem 2.3 of [5]」と書いている。つまり Theorem 5.6 を
含むのは一貫して「On p-adic power series」の側である。）

さらに Cuoco–Monsky の §1 も、Lemma 1.4/1.5/1.6 の証明で `[4]` の Theorem 2.1, 2.2, 2.3, 2.5, 2.9
を引いており、この `[4]` が “On p-adic power series” である（Monsky 論文 p.227 の References `[2]`
が Cuoco–Monsky を指す相互引用と整合する）。

**帰結**: 論文 001 で `refs.bib` を整備するとき（cycle 16 step 4）、Monsky の Theorem 5.6 の出典は
**“On p-adic power series”, Math. Ann. 255(2):217–227, 1981** と書かねばならない。
現状の本文は書誌を明示していないので**本文の数式・主張には誤りは無い**が、
`notes.md`・`auto-loop-state.md`・cycle 15 報告に残る同定は誤りとして訂正が要る。

---

## 3. 原文の仮定と結論、および Kataoka の引用との突合

### 3.1 Monsky, *On p-adic power series*, p.226

原文（書き写し）:

> **Theorem 5.6.** *Let $X\subset W^d$ be semi-algebraic and $F\in\mathcal{O}[[X_1,\dots,X_d]]$ where
> $\mathcal{O}\subset\Omega$ is a discrete valuation ring finite over $Z_p$. Then for $n$ large,
> $\sum \mathrm{ord}\,F(\zeta-1)$, the sum extending over all $\zeta\in X$ with $\zeta^{p^n}=1$, is a
> polynomial with rational coefficients in $n$ and $p^n$, having degree $\le1$ in $n$, and total degree $\le d$.*

同 p.222、原文:

> **Definition 3.1.** *$X\subset W^d$ is “semi-algebraic” if it is a finite union of subsets each of which is
> defined by finitely many conditions of the following 3 types:*
> (a) $\tau_i(\zeta)=\varepsilon_i$, (b) $\tau_i'(\zeta)\neq\varepsilon_i'$, (c) $o(\varphi_i(\zeta))\ge o(\psi_i(\zeta))+r_i$,
> *where $\tau_i,\tau_i',\varphi_i,\psi_i\in E_d$, $\varepsilon_i,\varepsilon_i'\in W$ and $r_i\in Z$.*
>
> *Note that the class of semi-algebraic sets is closed under finite unions and intersections, and that the
> complement of a semi-algebraic set is semi-algebraic. **Furthermore all closed sets are semi-algebraic.***

同 p.227、原文（Remark 2 の末尾）:

> *Using Theorem 2.7(b) one shows readily that the coefficient $m_0$ of $(p^n)^d$ is just the power to which
> $p$ divides $F$. In [2] it is shown that the coefficient of $n\cdot(p^n)^{d-1}$ is also a non-negative integer
> $l_0$, and an explicit interpretation of $l_0$ is given. The other coefficients remain mysterious.*

### 3.2 Cuoco–Monsky, pp.237–238

原文（書き写し）:

> **Definition 1.1.** *$m_0(F)$ is the power to which $p$ divides $F$.*
>
> **Definition 1.2.** *Write $F=p^{m_0}\cdot F_0$ with $\bar F_0\neq0$. Then $l_0(F)=\sum\mathrm{ord}_P(\bar F_0)$,
> the sum extending over all $P$ of the form $(\bar\sigma-1)$, $\sigma\in E-E^p$. [In other words, $l_0(F)$ is the
> number of irreducible factors of $\bar F_0$ of the form $\bar\sigma-1$, $\sigma\in E-E^p$, counted with multiplicity.]*
>
> **Definition 1.3.** *$\Sigma_n(F)=\sum\mathrm{ord}\,F(\zeta-1)$, the sum extending over all $\zeta\in W^d$ with $\zeta^{p^n}=1$.*
>
> **Theorem 1.7.** *Suppose $F\neq0$. $\Sigma_n(F)=(m_0p^n+l_0n+O(1))p^{(d-1)n}$ where $m_0=m_0(F)$, $l_0=l_0(F)$.*
>
> **Remark.** *$\Sigma_n(F)$ is actually given exactly by a polynomial of degree $\le d$ in $n$ and $p^n$ for all
> large $n$ (see [4]). Theorem 1.7 explicitly determines two coefficients of that polynomial.*

規約（p.237、重要）: *“Let ord be the order function … normalized so that $\mathrm{ord}\,p=1$. It is convenient
to make the unusual convention that $\mathrm{ord}\,0=0$.”*

### 3.3 突合表（Kataoka の引用 ↔ 原文）

| Kataoka の記述 | 原文 | 判定 |
|---|---|---|
| Thm 2.1 の出典を「Monsky [14, Theorem 5.6]」とする | Monsky *On p-adic power series* p.226 に Theorem 5.6 が実在 | **一致**（本プロジェクト側が [14] を取り違えていただけ） |
| Thm 2.1 の仮定「$f\in\mathbb{Z}_p[[\Gamma]]$, $S\subset\widehat\Gamma$ semi-algebraic」 | 原文は $F\in\mathcal{O}[[X_1..X_d]]$（$\mathcal{O}$ は $Z_p$ 上有限な DVR）、$X\subset W^d$ semi-algebraic | **一致**（Kataoka は $\mathcal{O}=\mathbb{Z}_p$ に**特殊化**した弱い形。$\widehat\Gamma\leftrightarrow W^d$、$\chi(f)\leftrightarrow F(\zeta-1)$） |
| Thm 2.1 の結論の形 $(\lambda n+\mu p^n)p^{(d-1)n}+\sum_{i=1}^{d-1}(\lambda_i n+\mu_i p^n)p^{(d-1-i)n}+\nu$ | 原文「$n$ と $p^n$ の有理係数多項式で、$n$ について次数 $\le1$、総次数 $\le d$」 | **一致**（展開すると Kataoka の形は「$n$ に 1 次・総次数 $\le d$」の一般形そのもの。$p^{dn},\dots,p^{n},1$ の項が $\mu,\mu_i,\nu$、$np^{(d-1)n},\dots,n$ の項が $\lambda,\lambda_i$） |
| Thm 2.1 の左辺で $\chi(f)\neq0$ の項に限る | 原文は全 $\zeta$ にわたる和だが、**$\mathrm{ord}\,0=0$ 規約**（Cuoco–Monsky p.237）により消える項は寄与 0 | **一致**（規約の言い換え） |
| 「$\widehat{\Gamma/H}$ は semi-algebraic」「有限和・有限交叉・補集合で閉じる」 | Monsky Def 3.1 直後に「閉集合はすべて semi-algebraic」「有限和・交叉・補集合で閉じる」と明記 | **一致**（$\widehat{\Gamma/H}$ は $W^d$ の閉集合） |
| Def 2.2 の出典を「[2, Definitions 1.1 and 1.2]」とする | Cuoco–Monsky Def 1.1, 1.2 が実在し内容一致 | **一致** |
| Def 2.2「$p^{-m_0(f)}f\in\mathbb{Z}_p[[\Gamma]]\setminus p\mathbb{Z}_p[[\Gamma]]$」 | Def 1.1「the power to which $p$ divides $F$」 | **一致**（同値な言い換え） |
| Def 2.2「$l_0(f)=\sum_P\mathrm{ord}_P(f)$、$P=(\gamma-1)$, $\gamma\in\Gamma\setminus\Gamma^p$」 | Def 1.2「$P=(\bar\sigma-1)$, $\sigma\in E-E^p$」＝「$\bar F_0$ の $\bar\sigma-1$ 型既約因子の重複込みの個数」 | **一致** |
| Def 2.2「$d=1$ のとき $l_0,m_0$ は通常の $\lambda,\mu$」 | Monsky *Some invariants* p.230 に同旨（「$d=1$ のとき $m_0(F)$ は Iwasawa の $\mu(F)$、$l_0(F)$ は $\bar G$ を割る $T$ の冪＝ $\lambda(F)$」） | **一致** |
| Thm 2.3 の出典を「Cuoco–Monsky [2, Theorem 1.7]」とする | Cuoco–Monsky Theorem 1.7 が実在し内容一致 | **一致** |
| Thm 2.3「$S=\widehat\Gamma$ のとき $\lambda=l_0(f)$, $\mu=m_0(f)$」 | Thm 1.7「$\Sigma_n(F)=(m_0p^n+l_0n+O(1))p^{(d-1)n}$」。$\Sigma_n$（Def 1.3）は**全** $\zeta$ の和＝ $S=\widehat\Gamma$ | **一致**（Kataoka の下位項 $\sum_{i\ge1}(\lambda_in+\mu_ip^n)p^{(d-1-i)n}+\nu$ はちょうど $O(1)\cdot p^{(d-1)n}$） |
| Thm 2.3「$\lambda,\mu$ は非負整数」 | Monsky p.227 Remark 2 が「$m_0$ は $F$ を割る $p$ の冪」「$l_0$ は非負整数（[2] による）」と明記 | **一致** |

**ずれは 1 件も無い。** Kataoka の引用は仮定・結論とも原典に忠実である。
したがって論文 001 の命題 D が依拠する外部定理の内容自体は、**原典で確認済み**になった
（notes.md のリスク 3 は、文献同定の訂正を伴ったうえで閉じてよい）。

**なお、原典を読んで初めて分かった規約上の要点**（本文に書く価値がある）:
Cuoco–Monsky は $\mathrm{ord}\,0=0$ という**特異な規約**を明示的に採用しており、
Kataoka の「$\chi(f)\neq0$ の項のみ和をとる」形はその言い換えである。
論文 001 の $v_p(a^{\mathrm{red}}_{p^n})=\sum_{\chi(f)\neq0}\mathrm{ord}_p(\chi(f))$ という定義は
この規約と整合しており、**$a^{\mathrm{red}}$（退化因子を落とした積）を使う流儀は原典の規約そのもの**である。

---

## 4. Kataoka §4–§6 を読んだ結果（リスク 4）

### 4.1 §4（Iwasawa 型漸近公式・Theorem 1.1 の証明）

Theorem 4.1 の仮定は「$X$ はグラフ、$\Gamma\simeq\mathbb{Z}_p^d$、voltage $\alpha:E_X\to\Gamma$、
各頂点の閉部分群の族 $I=(I_v)$、**各 $X_n$ が連結**」だけである。不分岐（$I_v=\{1\}$）なら
$V^{\mathrm{unr}}=V_X$ で $\lambda=l_0(\det L_\alpha)-\delta_{d,1}$, $\mu=m_0(\det L_\alpha)$。

証明の構造は「Proposition 4.2（有限被覆の $\kappa_Y/\kappa_X$ 公式）→ Proposition 4.4 →
$\{\chi\in\widehat\Gamma\setminus\{1\}\mid V^\chi=V\}$ が semi-algebraic だから Monsky Thm 2.1 が使える →
主要係数は $V=V^{\mathrm{unr}}$ の項から来て Thm 2.3 で決まる」というもので、
**本プロジェクトが使う部分（Monsky Thm 5.6 + Cuoco–Monsky Thm 1.7 の直接適用）に追加仮定を課さない。**
論文 001 は Kataoka Theorem 4.1 ではなく $S=\widehat\Gamma$ の Thm 2.1/2.3 を直接使っているので、
$X_n$ の連結性さえ不要である（連結性が要るのは $\kappa$ の言葉に翻訳するときだけ）。

### 4.2 §5（Kida 型公式）

$\widetilde\Gamma=\Gamma\times G$（$G$ は有限 $p$ 群）という**分岐・$G$ 被覆つき**の設定であり、
「中間グラフがすべて連結」を仮定する。本プロジェクトの $d=2$ 不分岐塔には**関係しない**。

### 4.3 §6（$\lambda,\mu$ の可能な値）— ここだけ本プロジェクトに効く

§6.1 は**まさに本プロジェクトの設定（bouquet・不分岐・$d\ge2$）**を扱う。原文の要点:

- 導来グラフが連結であるために「$\alpha$ の像が $\Gamma$ の真の閉部分群に含まれない」を仮定する。
- bouquet では $L_\alpha$ はスカラーで、$L_\alpha=h_\alpha+\iota(h_\alpha)$ と書ける
  （$\iota$ は群元を逆元にする対合、$h_\alpha=\sum_i(1-\alpha(e_i))$）。
- Definition 6.1: $h\in\mathbb{Z}[\Gamma]$ が **admissible** とは (a) $\mathrm{aug}(h)=0$、
  (b) 非単位元の係数がすべて非正、(c) $h\notin\mathbb{Z}[\Gamma']$（真の部分群 $\Gamma'$）。
- Proposition 6.2: $d\ge2$ なら任意の $\lambda\ge0$ が $l_0(h+\iota(h))$ として実現できる。
  **$d=1$ では実現できず、$l_0(h+\iota(h))$ は必ず正の偶数**。

**本プロジェクトへの含意（本文に書く価値がある）**: 論文 001 は「Monsky の定理はグラフに
限定されないので**一般の $P$** に適用できる」と述べており、これは
$v_p(a^{\mathrm{red}}_{p^n})$ の漸近については**正しい**。しかし
「その $P$ が**グラフの全域木数 $\kappa$ として実現できる**」ことは別問題で、
$P=h+\iota(h)$（$h$ admissible）という形の制約がかかる。
論文 001 は $\kappa$ を「規約の注意」で 1 段落だけ触れているので、
**$\kappa$ 解釈が使えるのは $P$ がこの形のときだけ**である旨を書いておくのが正確である。
（なお、Kataoka Prop 6.2 の「$d=1$ では $l_0(h+\iota(h))$ は正の偶数」は、
本 step の $d=1$ 数値検証の bouquet 例（$l_0=2$、$S_n=2n$）と整合する。）

---

## 5. 【重要】論文 001 の「規約の注意」の数式が誤っている

### 5.1 現状の記述と、原文が言っていること

`structured-latex/content/005_duality.ts` の `paper_remark_D_limits` 直後の段落（現行）:

> **規約の注意**: グラフの全域木数 $\kappa_{X_n}$ は上式から
> $-dn+\mathrm{ord}_p(\kappa(X))-\mathrm{ord}_p(\#V_X)$ だけずれる（$\#V_{X_n}=\#V_X\cdot p^{dn}$ で割るため）。

Kataoka Proposition 4.4 の原文（PDF p.15、書き写し）:

> **Proposition 4.4.** *Let $Y=X(\Gamma,\alpha,I)$ be the derived graph with $\Gamma$ a finite abelian group.
> We assume that $Y$ is connected. Then we have*
> $$\mathrm{ord}_p(\kappa_Y)=\sum_{\chi\in\widehat\Gamma\setminus\{1\}}\mathrm{ord}_p(\chi(\det L_{\alpha,V^\chi}))
> +\sum_{\chi\in\widehat\Gamma}\sum_{v\in V^\chi}\mathrm{ord}_p(\#I_v)-\mathrm{ord}_p(\#\Gamma)+\mathrm{ord}_p(\kappa_X).$$

不分岐（$I_v=\{1\}$ for all $v$）なら $V^\chi=V_X$、第 2 項 $=0$、$\mathrm{ord}_p(\#\Gamma_n)=dn$ なので

$$\mathrm{ord}_p(\kappa_{X_n})=S_n-dn+\mathrm{ord}_p(\kappa_X),\qquad
S_n:=\sum_{\chi\in\widehat{\Gamma_n}\setminus\{1\}}\mathrm{ord}_p(\chi(\det L_\alpha)).$$

**$-\mathrm{ord}_p(\#V_X)$ の項は原文に無い。**

### 5.2 自前の導出（なぜ $\#V_X$ が消えるか）

Matrix-Tree より、連結グラフ $G$ の全域木数は $\kappa_G=\dfrac{1}{\#V_G}\prod_{\lambda\neq0}\lambda$
（$\lambda$ はラプラシアン固有値）。$X_n$ のラプラシアンは $\bigoplus_{\chi\in\widehat{\Gamma_n}}L_\alpha(\chi)$ と分解し、
$\chi=1$ の成分は $X$ の通常のラプラシアン $L_X$ そのものだから、その非零固有値の積は
$\kappa_X\cdot\#V_X$。よって

$$\kappa_{X_n}=\frac{(\kappa_X\cdot\#V_X)\cdot\prod_{\chi\neq1}\det L_\alpha(\chi)}{\#V_X\cdot p^{dn}}
=\frac{\kappa_X\cdot\prod_{\chi\neq1}\det L_\alpha(\chi)}{p^{dn}}.$$

$\#V_X$ は**分子・分母で相殺する**。現行記述は「$\#V_{X_n}$ で割る」ことだけを見て、
$\chi=1$ 成分が $\kappa_X$ ではなく $\kappa_X\cdot\#V_X$ を与えることを見落としている。
これが誤りの原因である。

### 5.3 数値検証（厳密整数計算のみ。$\mathbb{R}$ にも $\mathbb{Q}_p$ にも出ない）

`sagemath/check/cycle16_T1_kappa_offset/`（SageMath 10.6 で実行、ログ同梱）。

- `kappa_offset.sage` / `kappa_offset.out` — **$d=1$**、基底グラフ 5 例 × $n=0..4$ の **25 例**。
  $\kappa$ は導来グラフの整数ラプラシアンの既約行列式、$S_n$ は
  $\mathrm{Res}_x\bigl((x^N-1)/(x-1),\det L_\alpha(x)\bigr)$ の $p$ 進付値として厳密整数計算。
- `kappa_offset_d2.sage` / `kappa_offset_d2.out` — **$d=2$**（本プロジェクトの実際の設定）、
  3 例 × $n\le3$ の **14 例**。$S_n$ は導来グラフを一切使わず、円分体 $\mathbb{Q}(\zeta_N)$ 内で
  $\prod_{(j,k)\neq(0,0)}\det L_\alpha(\zeta^j,\zeta^k)$ を厳密に積んで有理整数へ落として計算した
  （$\kappa$ の計算経路と独立にするため）。

結果:

| | (K) Kataoka Prop 4.4 形 | (P) 論文 001 現行形 |
|---|---|---|
| $d=1$（25 例） | 不一致 **0** | 不一致 **15** |
| $d=2$（14 例） | 不一致 **0** | 不一致 **7** |

不一致はちょうど $\mathrm{ord}_p(\#V_X)>0$ の例に限られ、ずれ幅はちょうど $\mathrm{ord}_p(\#V_X)$ である。

**なぜ cycle 15 で検出できなかったか**: $L\times L$ トーラスは 1 頂点 bouquet で $\#V_X=1$、
$\mathrm{ord}_p(\#V_X)=0$ なので (K) と (P) が数値的に一致してしまう。
$d=2$ の対照例（bouquet）でも両者は 4/4 で一致しており、これを確認済みである。
**「その模型では差が出ない」ことを「式が正しい」と取り違えた**のが cycle 15 の失敗の型である。

### 5.4 敵対的レビュー（自分の結論を反証しにいった結果）

- 「上式」が $a^{\mathrm{red}}$（$\chi=1$ を含む全 $\chi$ の和）を指すなら $-\mathrm{ord}_p(\#V_X)$ が
  正しくなるのでは？ → **ならない。** グラフのラプラシアンは $\det L_\alpha(1,1)=0$ なので
  $\chi=1$ は $\chi(f)\neq0$ の条件で自動的に落ち、$\sum_{\chi(f)\neq0}=S_n$ に一致する。
- 「上式」が $X_n$ の全非零固有値の積を指すなら？ → その場合は
  $\mathrm{ord}_p(\kappa_{X_n})=[\,\cdot\,]-\mathrm{ord}_p(\#V_{X_n})$ であって
  $+\mathrm{ord}_p(\kappa_X)$ の項が付かない。現行記述は $+\mathrm{ord}_p(\kappa(X))$ と
  $-\mathrm{ord}_p(\#V_X)$ を**同時に**書いており、どちらの読みでも成立しない。
- 数値が偶然か？ → 3 経路（Kataoka 原文・自前の Matrix-Tree 導出・39 例の厳密整数計算）が
  独立に一致するので偶然ではない。
- 数値で「(K) が 0 件不一致」なのを (K) の**証明**と取り違えていないか？ → 取り違えていない。
  (K) の根拠は Kataoka Prop 4.4 の原文と §5.2 の導出であり、数値は (P) の**反証**として使っている
  （反証は 1 件でも足りる。実際 22 件出た）。

---

## 6. 帰属（どの集合に住んでいるか）

- $\det L_\alpha\in\mathbb{Z}[\Gamma]$、$\kappa_{X_n}\in\mathbb{N}$、$S_n\in\mathbb{Q}_{\ge0}$（不分岐 $d$ 次では実際に $\mathbb{Z}_{\ge0}$）。
  検証コードは $\mathbb{Z}$ と円分体 $\mathbb{Q}(\zeta_N)\subset\overline{\mathbb{Q}}$ の中だけで完結する。
- Monsky Thm 5.6 / Cuoco–Monsky Thm 1.7 の住所は $\overline{\mathbb{Q}_p}$ 上の $\mathrm{ord}_p$ で、
  値は $\mathbb{Q}$。**$\mathbb{R}$ への脱出は本 step のどこにも無い。**
- Monsky の semi-algebraic 集合（Def 3.1）は $W^d$（$p$ 冪根の群、可算）の部分集合を
  有限個の条件で定義するものであり、実数の semialgebraic set とは別物である。ここは可算側。

---

## 7. 限界（何を確認していないか）

- Monsky *On p-adic power series* の **§1・§2・§4 は未読**。Theorem 5.6 の証明が依拠する
  Theorem 3.4 / 4.6 / 5.5 の**内容は読んでいない**（Theorem 5.6 と Def 3.1 の**言明**のみ確認）。
- Cuoco–Monsky の **§2–§7 は未読**。Theorem 1.7 の証明で使う Lemma 1.4/1.5/1.6 は
  言明のみ確認し、その証明が引く `[4]` の Theorem 2.1/2.2/2.3/2.5/2.9 は未確認。
- 本 step は**引用の一致**を確認したのであって、**原典の定理そのものを検証したのではない**。
  Monsky / Cuoco–Monsky の証明の正しさは前提として受け入れている。
- 数値検証は**不分岐**の場合だけ。分岐がある場合の Prop 4.4 第 2 項は数値で試していない。
