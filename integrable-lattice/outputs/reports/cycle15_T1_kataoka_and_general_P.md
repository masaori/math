# cycle 15 / T1: Kataoka 本文の取得と、一般の $P$ での増大則の決着

対象: `outputs/paper-plans/002_R_Lambda_duality.md` の G1 に残っていた 2 点
（cycle 14 総括で絞り込んだもの）。

- **(a)** グラフのラプラシアンでない一般の $P\in\mathbb{Z}[z^{\pm},w^{\pm}]$ で $p\mid P(1,1)$ のときの増大の完全な形
- **(b)** $\ell^{2n}$ 項の係数が $v_\ell(\mathrm{content})$ に一致することの**上から抑える向き**（cycle 14 では自前で証明できず外部定理に依拠）

## 0. 結論（先に置く）

**(a)(b) はどちらも閉じた。** ただし**閉じ方は「自前で証明した」ではなく「正しい既知定理を特定し、
本文で仮定と命題番号を確認し、本プロジェクトの対象がその適用範囲に入ることを確かめた」である。**
新規性は主張しない。

| 項目 | 結果 |
|---|---|
| Kataoka arXiv:2606.03579 の**本文取得** | **成功**（§1）。PDF を取得してページ単位で読んだ。Theorem 1.1 / 2.1 / 2.3、Definition 2.2 / 2.4、Proposition 2.6、Lemma 2.7、Remark 2.8 を確認。 |
| **(b) の決着** | **閉じた**（§2）。$\mu=m_0(f)$ は Kataoka Definition 2.2（＝Cuoco–Monsky Definitions 1.1, 1.2）で「$p^{-m_0(f)}f\in\mathbb{Z}_p[[\Gamma]]\setminus p\mathbb{Z}_p[[\Gamma]]$」と定義される、すなわち**$f$ を割り切る $p$ の最大冪そのもの**。本プロジェクトの補題 D（$z\mapsto1+T$ が $\mathbb{Z}$ 上の環同型ゆえ content 不変）と合わせて $\mu=v_p(\mathrm{content}_{z,w}P)$。上下両方向が Cuoco–Monsky Theorem 1.7 で与えられている。 |
| **(a) の決着** | **閉じた**（§3）。Kataoka Theorem 2.1（＝**Monsky [14] Theorem 5.6**）は**グラフに限定されていない**。任意の $f\in\mathbb{Z}_p[[\Gamma]]\setminus\{0\}$ と半代数的 $S\subset\widehat\Gamma$ についての定理である。本プロジェクトの $a_{p^n}=\prod_{\chi\in\widehat{\Gamma_n}}\chi(f)$（$f=P(1+T,1+S)$）はちょうどその左辺なので、**一般の $P$ にそのまま適用できる**。 |
| cycle 14 の非退化条件との対応 | 本プロジェクトの「$H$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたない」$\Rightarrow$ **$l_0(f)=0$（$\lambda=0$）**（§4）。**逆は偽**（反例 $P=z+w^2-2w$, $p=3$。初版は同値と書いていたが誤りで、敵対的レビューで訂正した）。命題 W が必要とする向きは成り立つので命題 W は無傷。 |
| 命題 W の $\mu_1=\frac{k(\ell+1)}{\ell-1}$ | Kataoka は $\lambda,\mu$ **だけ**を explicit と述べており、$\lambda_i,\mu_i$（$i\ge1$）は「有理数が存在する」としか書いていない。したがって本プロジェクトの $\mu_1$ の明示式は**文献で見つけられなかった**が、網羅調査ではないので**新規性は主張しない**（§6）。 |

検証: `sagemath/check/cycle15_T1_monsky_shape/`（実行ログ `monsky_shape.out`）。

---

## 1. Kataoka 本文の取得（一次情報）

- 論文: T. Kataoka, *An Iwasawa-type asymptotic formula for multiple $\mathbb{Z}_p$-coverings of graphs*,
  arXiv:2606.03579v1, 2 Jun 2026（Date: June 3, 2026。MSC 05C25 (Primary), 11R23）。
- 取得手段: `https://arxiv.org/abs/2606.03579` で abstract を確認 → `https://arxiv.org/pdf/2606.03579` を取得。
  PDF はテキスト変換では読めなかったが、**PDF をページ単位で直接読み出して本文を確認した**（pp.1–8）。
  `https://arxiv.org/html/2606.03579v1` は **HTTP 404**（HTML 版は無い）。
- 確認できた範囲: pp.1–8（Introduction、§2 Preliminaries on algebra、§3 冒頭）。
  **§4–§6（三つの主定理の証明）と Definition 3.8（Jacobian）は読んでいない。**

### 1.1 本文から引用（命題番号と仮定）

> **Theorem 1.1.** *Let $d\ge1$ be an integer. Let $X_\infty/X$ be a (possibly ramified) $\mathbb{Z}_p^d$-covering of
> connected graphs, that is, a tower of connected graphs $X=X_0\leftarrow X_1\leftarrow X_2\leftarrow\cdots$
> such that $X_n/X$ is a $(\mathbb{Z}/p^n\mathbb{Z})^d$-covering. We define non-negative integers $\lambda=\lambda(X_\infty/X)$ and
> $\mu=\mu(X_\infty/X)$ by $\lambda=l_0(\mathrm{Jac}_{\mathbb{Z}_p}X_\infty)$ and $\mu=m_0(\mathrm{Jac}_{\mathbb{Z}_p}X_\infty)$,
> where $\mathrm{Jac}_{\mathbb{Z}_p}X_\infty$ denotes the Jacobian group (Definition 3.8) and $l_0(-)$ and $m_0(-)$ are
> module-theoretic invariants (Definition 2.4). Then there exist rational numbers
> $\lambda_1,\dots,\lambda_{d-1},\mu_1,\dots,\mu_{d-1},\nu$ such that*
> $$\mathrm{ord}_p(\kappa_{X_n})=(\lambda n+\mu p^n)p^{(d-1)n}+\sum_{i=1}^{d-1}(\lambda_i n+\mu_i p^n)p^{(d-1-i)n}+\nu$$
> *holds for $n\gg0$.*

> **Theorem 2.1** (Monsky [14, Theorem 5.6])**.** *Let $f\in\mathbb{Z}_p[[\Gamma]]$ be an element and $S\subset\widehat\Gamma$ a
> semi-algebraic subset. Then there are rational numbers $\lambda,\mu,\lambda_1,\mu_1,\dots,\lambda_{d-1},\mu_{d-1},\nu$ such that*
> $$\sum_{\substack{\chi\in S\cap\widehat{\Gamma_n}\\ \chi(f)\neq0}}\mathrm{ord}_p(\chi(f))
> =(\lambda n+\mu p^n)p^{(d-1)n}+\sum_{i=1}^{d-1}(\lambda_i n+\mu_i p^n)p^{(d-1-i)n}+\nu$$
> *holds for $n\gg0$.*

> **Definition 2.2** ([2, Definitions 1.1 and 1.2])**.** *For $f\in\mathbb{F}_p[[\Gamma]]\setminus\{0\}$, we define a non-negative
> integer $l_0(f)$ as $l_0(f)=\sum_P\mathrm{ord}_P(f)$ where $P$ runs over the prime ideals of $\mathbb{F}_p[[\Gamma]]$ of the
> form $(\gamma-1)$ with $\gamma\in\Gamma\setminus\Gamma^p$ ... For $f\in\mathbb{Z}_p[[\Gamma]]\setminus\{0\}$, we define
> non-negative integers $l_0(f)$ and $m_0(f)$ by* $$p^{-m_0(f)}f\in\mathbb{Z}_p[[\Gamma]]\setminus p\mathbb{Z}_p[[\Gamma]]$$
> *and $l_0(f)=l_0(\overline{p^{-m_0(f)}f})$, where $\overline{(-)}$ denotes the reduction to $\mathbb{F}_p[[\Gamma]]$.*
>
> *When $d=1$, the $l_0$- and $m_0$-invariants of $f\in\mathbb{Z}_p[[\Gamma]]$ coincide with the usual $\lambda$- and $\mu$-invariants.*

> **Theorem 2.3** (Cuoco–Monsky [2, Theorem 1.7])**.** *Let $f\in\mathbb{Z}_p[[\Gamma]]\setminus\{0\}$. In Theorem 2.1, if
> $S=\widehat\Gamma$, we have $\lambda=l_0(f)$ and $\mu=m_0(f)$, which are in particular non-negative integers.*

> **Proposition 2.6.** *Let $\varphi$ be an injective endomorphism of a finitely generated free $\Lambda$-module.
> Let $M=\mathrm{Cok}(\varphi)$ be its cokernel. Then we have $\mathrm{char}(M)=(\det\varphi)$. In particular, we have
> $l_0(M)=l_0(\det\varphi)$ and $m_0(M)=m_0(\det\varphi)$.*

（Serre 同型 $\mathbb{Z}_p[[\Gamma]]\simeq\mathbb{Z}_p[[T_1,\dots,T_d]]$、$\sigma_i\mapsto1+T_i$ は §2.1 に明記。
$\mathrm{ord}_p$ は $\mathrm{ord}_p(p)=1$ で正規化、$\lambda_i,\mu_i,\nu$ は**有理数**で整数とは限らない。）

---

## 2. (b) の決着: 上界方向は Cuoco–Monsky Theorem 1.7 が両方向を与えている

cycle 14 では「下界 $a\ge v_\ell(\mathrm{content})$ は自前で証明できたが、上界 $a\le v_\ell(\mathrm{content})$ は
証明できなかった」と記録した（2 経路とも同じ境界）。本文確認により、これは**外部定理が等号を与えている**と確定した。

1. **Definition 2.2 より $m_0(f)$ は「$f$ を割り切る $p$ の最大冪」そのもの**。
   すなわち $m_0(f)=v_p(\mathrm{content}(f))$（$f$ の係数の $\gcd$ の $p$ 進付値）。定義であって定理ではない。
2. **Theorem 2.3（Cuoco–Monsky Theorem 1.7）が $\mu=m_0(f)$ を与える**。これは等号であって不等式ではない。
3. 本プロジェクトの補題 D（cycle 13 report §5、$d=2$ への拡張は自明）: $z\mapsto1+T$, $w\mapsto1+S$ は
   $\mathbb{Z}$ 上の環同型なので content を保ち、単項式因子は $\mathbb{Z}[[T,S]]$ の単元なので落とせる。したがって
   $$m_0\bigl(P(1+T,1+S)\bigr)=v_p\bigl(\mathrm{content}_{z,w}P\bigr).$$
4. グラフの場合は Jacobian がラプラシアンの余核なので **Proposition 2.6** より
   $m_0(\mathrm{Jac})=m_0(\det L)$。したがって $\mu=v_\ell(\mathrm{content}_{z,w}\det L)$。

**⇒ cycle 14 の命題 W の $\mu$ の上界方向は、Kataoka Theorem 2.3 を引けば済む。自前証明は不要である。**

数値確認（`monsky_shape.out` の (1)(2)）: 補題 D は 10 個の $P$ × 4 素数で不一致 0 件。
content $>1$ の例では $v_p(a_{p^n})=m_0\,p^{2n}$ がちょうど成立（$2\times$: $1,4,16,64$／$4\times$: $2,8,32,128$／
$8\times$: $3,12,48,192$／$3\times$ の $p=3$: $1,9,81$／$9\times$ の $p=3$: $2,18,162$）。

---

## 3. (a) の決着: Monsky Theorem 5.6 はグラフに限定されていない

cycle 13 step 1 は「一般の $P$ の $v_p(a_{p^n})$ の増大則を述べた文献命題を特定できなかった」と記録し、
cycle 14 もそれを引き継いだ。**この記録は誤りであった。** 探すべき定理はグラフの文献ではなく、
その土台にある Monsky の $p$ 進冪級数の定理である。

### 3.1 対応

$\Gamma\simeq\mathbb{Z}_p^d$、$\Gamma_n=\Gamma/\Gamma^{p^n}\simeq(\mathbb{Z}/p^n)^d$ とする。
Serre 同型 $\mathbb{Z}_p[[\Gamma]]\simeq\mathbb{Z}_p[[T_1,\dots,T_d]]$（$\sigma_i\mapsto1+T_i$）の下で、
$\widehat{\Gamma_n}$ の元 $\chi$ は $\sigma_i\mapsto\zeta_i$（$\zeta_i^{p^n}=1$）で決まり、$f\in\mathbb{Z}_p[[\Gamma]]$ に対し

$$\chi(f)=f(\zeta_1-1,\dots,\zeta_d-1).$$

$P\in\mathbb{Z}[z_1^{\pm},\dots,z_d^{\pm}]$ に対し $f:=P(1+T_1,\dots,1+T_d)$（単項式因子は $\mathbb{Z}[[T]]$ の単元なので
$\mathbb{Z}_p[[\Gamma]]$ の元として扱える）と置くと $\chi(f)=P(\zeta_1,\dots,\zeta_d)$、したがって

$$\boxed{\ \sum_{\substack{\chi\in\widehat{\Gamma_n}\\ \chi(f)\neq0}}\mathrm{ord}_p(\chi(f))
=v_p\Bigl(\ \prod_{\substack{z_i^{p^n}=1\\ P(z)\neq0}}P(z_1,\dots,z_d)\Bigr)\ } \tag{3.1}$$

すなわち **$P$ の零点を除いた簡約積の付値**が Theorem 2.1 の左辺そのものである（$S=\widehat\Gamma$）。
$\chi(f)=0$ となる $\chi$ が 1 つも無いときに限り、これは $v_p(a_{p^n})$（全ての $\chi$ の積）に等しい。
零点があるときは $a_{p^n}=0$ なので、$(3.1)$ の左辺は $a_{p^n}$ ではなく簡約積を測っている
（**初版は条件を付けずに $v_p(a_{p^n})$ と書いていた。誤りなので訂正した**）。

### 3.2 帰結（一般の $P$ について）

$f\neq0$ とする。Theorem 2.1 と Theorem 2.3 より、有理数 $\lambda_i,\mu_i,\nu$ が存在して $n\gg0$ で

$$\sum_{\substack{\chi\in\widehat{\Gamma_n}\\ \chi(f)\neq0}}\mathrm{ord}_p(\chi(f))
=\bigl(l_0(f)\,n+m_0(f)\,p^n\bigr)p^{(d-1)n}+\sum_{i=1}^{d-1}(\lambda_i n+\mu_i p^n)p^{(d-1-i)n}+\nu,$$

かつ $m_0(f)=v_p(\mathrm{content}_{z}P)$（§2-3）。$d=2$ では

$$v_p\bigl(a^{\mathrm{red}}_{p^n}\bigr)=v_p(\mathrm{content}\,P)\,p^{2n}+l_0(f)\,n\,p^{n}+\mu_1 p^{n}+\lambda_1 n+\nu \tag{3.2}$$

（$a^{\mathrm{red}}_{p^n}$ は $P(z)\neq0$ の因子だけの積。$P$ が $p$ 冪根で零点をもたなければ $a^{\mathrm{red}}=a$）。

**これがグラフのラプラシアンに限らない一般の $P$ に対する増大の完全な形である。**

### 3.3 退化点の扱いと、全域木数 $\kappa$ との関係（初版を訂正）

Theorem 2.1 の和は $\chi(f)\neq0$ の項に限られている。本プロジェクトの $a_{p^n}$ は全ての $\chi$ の積なので、
$P$ が $p$ 冪根で零点をもつと $a_{p^n}=0$ になる。$(3.1)$ が測っているのは**零点を除いた簡約積**である。

**グラフの場合との関係（訂正）**: 初版は「これはちょうど全域木数 $\kappa$ の規約と同じ」と書いたが、
**$-dn$ だけずれる**。$(★_2)$（cycle 14 定理 1）より $|\Gamma_n|\,\kappa(X_n)=\kappa(X)\prod_{\chi\neq1}\chi(\det L)$、
すなわち

$$\mathrm{ord}_p(\kappa_{X_n})=\underbrace{\sum_{\substack{\chi\in\widehat{\Gamma_n}\\ \chi(f)\neq0}}\mathrm{ord}_p(\chi(f))}_{\text{Theorem 2.1 の左辺}} - d\,n + \mathrm{ord}_p\bigl(\kappa(X)\bigr)-\mathrm{ord}_p(\#V_X). \tag{3.3}$$

（$\#V_{X_n}=\#V_X\cdot p^{dn}$。）**数値確認**（$3^n\times3^n$ トーラス、$d=2$、$p=3$）:

| $n$ | 0 | 1 | 2 |
|---|---|---|---|
| $v_3$(簡約積) | 0 | 8 | 32 |
| $v_3(\kappa)$ | 0 | 6 | 28 |
| 差 | 0 | 2 | 4 |

差はちょうど $2n=dn$（独立に検算済み）。この $-dn$ は $\lambda,\mu$（主要 2 係数）には影響しないが、
$\lambda_{d-1}$ と $\nu$ を変える。cycle 14 の命題 W が $-2n$ の項をもつのはこの寄与である。
**したがって「Theorem 2.1 の左辺 ＝ $\mathrm{ord}_p(\kappa)$」ではない。$(3.3)$ で読み替える必要がある。**

### 3.4 命題 V との整合

命題 V（cycle 14）は「$v_p(a_{p^n})>0\iff p\mid P(1,\dots,1)$」を初等的に与える。$(3.2)$ とは
矛盾しない: $(3.2)$ は $n\gg0$ の漸近形であり、命題 V は**全ての $n\ge0$ で**成り立つ非自明性の判定である。
命題 V の方が主張は弱いが、$n_0$ を要さず初等的（$\mathbb{Q}_p$ 不使用）で、
$\Lambda$ 側に内容があるかを**有限手続きで即断**できる点で独立の価値がある。

---

## 4. 本プロジェクトの非退化条件と $l_0$ の関係（初版の「同値」を訂正）

cycle 14 の命題 W は「$f=\det L(1+T,1+S)$ の $\bmod\,\ell$ 還元の最低次斉次部分 $H$（次数 $k$）が
$\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたない」を非退化条件としていた。
**初版はこれを $l_0(f)=0$ と同値だと書いたが、同値ではない。一方向のみ成立する。**

### 4.1 成立する向き（命題 W が必要とするのはこちら）

最低次斉次部分をとる操作 $\mathrm{in}(-)$ は乗法的である。$\gamma=\sigma_1^a\sigma_2^b$（$(a,b)\notin p\mathbb{Z}_p^2$）に対し
$\mathrm{in}(\gamma-1)=\bar aT+\bar bS\neq0$（$\mathbb{F}_p$ 上の非零線形形式）。したがって

$$(\gamma-1)\mid\bar f\ \Longrightarrow\ (\bar aT+\bar bS)\mid H,$$

すなわち **$H$ が $\mathbb{F}_p$ 有理な線形因子をもたない $\Rightarrow$ どの $(\gamma-1)$ も $\bar f$ を割らない $\Rightarrow$ $l_0(f)=0$**。
より一般に
$$l_0(f)\ \le\ \sum(\text{$H$ の $\mathbb{F}_p$ 有理線形因子の重複度}). \tag{4.1}$$

命題 W は「$H$ に有理零点なし」を仮定して $\lambda=0$ を使うので、**この向きだけで足り、命題 W は無傷である。**

### 4.2 逆は偽（反例）

**誤りの根源**: $l_0$ が走る素イデアル $(\gamma-1)$ は $\gamma\in\Gamma\setminus\Gamma^p$、すなわち
**$\mathbb{P}^1(\mathbb{Z}_p)$ で添字づけられる**（標数 $p$ で $u\in\mathbb{Z}_p^\times$ なら $(1+x)^u-1=x\cdot(\text{単元})$ なので
$(\gamma^u-1)=(\gamma-1)$、同じイデアルを与えるのは $\mathbb{Z}_p^\times$ 倍だけ）。
同じ最低次形式 $aT+bS$ をもつ相異なる素イデアルが**無限個**ある。実際
$\gamma=\sigma_1\sigma_2$ では $\gamma-1=T+S+TS$ で、$(T+S+TS)\neq(T+S)$
（標数 2 で $S=T$ を代入すると $T^2\neq0$）。

**反例**: $P=z+w^2-2w$、$p=3$。$f=P(1+T,1+S)=T+S^2$、$\mathrm{content}\,P=\gcd(1,1,-2)=1$ より $m_0=0$。
$\bar f=T+S^2$、$H=T$（$k=1$）は $(0:1)\in\mathbb{P}^1(\mathbb{F}_3)$ で消えるので、初版の判定では「退化、$\lambda\neq0$」。
**しかし実際は $l_0(f)=0$ である。**

- 論証: $\bar f$ は $T$ について次数 1 の distinguished 多項式なので既約。$(\gamma-1)\mid\bar f$ なら
  $\mathrm{in}(\gamma-1)\mid T$ より $\gamma\sim\sigma_1\sigma_2^{\beta}$、$\beta\in3\mathbb{Z}_3$。このとき
  $(\gamma-1)=(T+1-(1+S)^{-\beta})$ なので $1-(1+S)^{c}=S^2$（$c=-\beta\in3\mathbb{Z}_3$）が必要だが、
  $S^2$ の係数 $-\binom{c}{2}=-c(c-1)/2\equiv0\pmod3$ に対し $1$ が必要で矛盾。
- **数値確認（独立に検算した）**: $\sum_{\chi(f)\neq0}\mathrm{ord}_3(\chi(f))=0,5,20,65,200$（$n=0,\dots,4$）
  $=\tfrac52(3^n-1)$ に厳密一致。すなわち $\lambda=0,\ \lambda_1=0,\ \mu_1=5/2,\ \nu=-5/2$ で、
  **$n\cdot3^n$ 項が存在しない**。$\chi(f)=0$ となるのは自明指標のみ（$P(\zeta,\xi)=0$ は $\xi=1$ を強制）。

### 4.3 波及（$l_0$ の計算可能性は未解決）

初版 §5 は「$l_0$ は $\bar f$ の $\mathbb{P}^1(\mathbb{F}_p)$ 有理線形因子の重複度の和として $\mathbb{Z}$ 上の有限手続きで計算できる」
と書いたが、これは**誤ったレシピ**であり $(4.1)$ の上限しか与えない。上の反例の判定には $\mathbb{Z}_3$ 進の議論が要り、
$\mathbb{F}_3$ 上の有限計算では決まらない。**したがって $\lambda=l_0(f)$ の計算可能性（有限手続き性）は
本 step では確立できていない。** 未解決点として §6 に挙げる。

### 4.4 トーラスの例は正しい（例が合うことは一般規則の証明ではない）

$L\times L$ トーラス（2 ループ bouquet）: $\det L=4-z-z^{-1}-w-w^{-1}$、$f\sim-(T^2+S^2+T^2S+S^2T)$、$H=-(T^2+S^2)$、$k=2$。
- $\ell=3$: $-1$ が $\bmod3$ で非平方なので $H$ に有理零点なし $\Rightarrow$（§4.1 より）$\lambda=0$。
  実測 $\mathrm{ord}_3(\tau(3^n))=0,6,28$ は $\mu=0,\lambda=0,\mu_1=4,\lambda_1=-2,\nu=-4$ で一致（cycle 14 で独立検算済み）。
  命題 W の $\mu_1=k(\ell+1)/(\ell-1)=4$ と合う。
- $\ell=2$: $\bar f=(T+S)(T+S+TS)$ で、$(T+S)$ は $\gamma=\sigma_1\sigma_2^{-1}$ の $(\gamma-1)$
  （$(1+T)(1+S)^{-1}-1=(T-S)(1+S)^{-1}$、標数 2 で $T-S=T+S$）、$(T+S+TS)$ は $\gamma=\sigma_1\sigma_2$ の $(\gamma-1)$。
  よって $l_0=2$ で、$H=(T+S)^2$ の有理因子を素朴に数えた値と一致する。非退化でない。
- **この 2 例が $(4.1)$ の等号側であることは、一般に等号が成り立つことを意味しない**（§4.2 の反例）。

## 5. 002 の G1 への影響

- **(a)(b) はどちらも閉じた。** ($p$) 側の増大則は、一般の $P$ について $(3.2)$ の形で、
  主要 2 係数 $\mu=v_p(\mathrm{content}P)$ と $\lambda=l_0(f)$ が**明示的に決まる**。
  $\mu$ は $\mathbb{Z}$ 上の有限手続きで計算できる（content の $\gcd$）。
  **$\lambda=l_0(f)$ は不変量として確定するが、その計算可能性（有限手続き性）は本 step では確立できていない**
  （§4.3。初版の $\mathbb{F}_p$ 上のレシピは上限しか与えない誤りだった）。
- **($\infty$) 側は cycle 13 で確定済み**（LSW Thm 7.1 / LSV Thm 1.2・1.3）。
- **したがって双対命題 D は、仮定・結論・一般性の範囲まで書き下せる状態になった。**
  002 の G1 判定は cycle 15 step 4（`rank`）で行う。

**ただし依拠の性質を明確にしておく**: ($p$) 側の増大則は**本プロジェクトの定理ではなく、
Monsky / Cuoco–Monsky / Kataoka の定理の適用である**。本プロジェクトの寄与は
(i) 対応 $(3.1)$ を明示したこと、(ii) $m_0$ が content 判定に落ちること（補題 D）、
(iii) 非退化条件と $l_0=0$ の対応（§4）、(iv) 命題 V の初等的判定、の 4 点にとどまる。
これは T1 Reframe（既知結果の可算・厳密・形式検証可能な書き換え）としては正当な寄与だが、
**新しい定理ではない**。

---

## 6. 未確認のこと・新規性（正直に）

1. **Kataoka の §4–§6（主定理の証明）と Definition 3.8（Jacobian の定義）は読んでいない。**
   引用したのは pp.1–8 の Introduction と §2 Preliminaries、§3 冒頭のみ。
   Theorem 1.1 の**証明**は確認していないので、「証明を検証した」とは書かない。
2. **Monsky [14] Theorem 5.6 と Cuoco–Monsky [2] Theorem 1.7 の原論文本文は取得していない。**
   Kataoka が Theorem 2.1 / Theorem 2.3 として**引用した形**を確認したにとどまる。
   Kataoka の引用が正確であることは前提にしている。
3. **半代数的集合の定義（Monsky [14] Definition 3.1）は確認していない。** Kataoka も
   「precise definition を review する代わりに必要な性質を挙げる」としている。
   $S=\widehat\Gamma$ 自体は自明に半代数的（全体集合）なので、本プロジェクトの用途には支障がない。
4. **命題 W の $\mu_1=k(\ell+1)/(\ell-1)$ の明示式は文献で見つけられなかった。**
   Kataoka は abstract と Theorem 1.1 で $\lambda,\mu$ **だけ**を explicit と述べ、
   $\lambda_i,\mu_i$（$i\ge1$）は「有理数が存在する」としか書いていない。
   DuBose–Vallières [3, Section 7] と Kleine–Müller [11, Sections 8, 9] に数値例があると
   Kataoka が述べているが、**それらの本文は取得していない**。
   **網羅調査ではないので新規性は主張しない。**
5. cycle 13 step 1 の「一般の $P$ の増大則を述べた文献命題を特定できなかった」という記録は、
   **探索範囲がグラフの文献に偏っていたことによる誤り**であった。本 step で訂正する。
6. **$\lambda=l_0(f)$ の計算可能性は未解決**（§4.3）。初版の $\mathbb{F}_p$ 上のレシピは上限 $(4.1)$ しか与えない。
   本プロジェクトの「$\Lambda$ 側は有限手続きで決定可能」という主張は、**有限 $L$ の $v_p(a_L)$ については成立する**
   （終結式の整数計算）が、**漸近不変量 $\lambda$ については未確立**である。この区別を 002 に明記する必要がある。
7. **$\chi(f)=0$ となる $\chi$ が自明指標に限るという保証は一般の $P$ には無い。** グラフのラプラシアンなら
   連結性から従うが（cycle 13 系 B′）、一般の $P$ で消える $\chi$ が $n$ とともに増える場合、
   $(3.1)$ の簡約積と $a_{p^n}$ の関係の記述は本 report の一行では足りない。未整理のまま残す。
8. **半代数的集合の定義（Monsky [14] Definition 3.1）は未確認。** $S=\widehat\Gamma$ は
   Kataoka p.5 の列挙された性質から半代数的だと導ける（$H=\{1\}$ で $\widehat{\Gamma/H}=\widehat\Gamma$）が、
   他の $S$ を使う拡張には定義の確認が要る。

---

## 7. 検証

`sagemath/check/cycle15_T1_monsky_shape/`（SageMath 10.6、`sage monsky_shape.sage`、ログ `monsky_shape.out`）。

| 節 | 検証内容 | 結果 |
|---|---|---|
| (1) | 補題 D（$\mathrm{content}_{z,w}P$ と $\mathrm{content}_{T,S}P(1+T,1+S)$ の $p$ 進付値の一致） | 10 個の $P$ × 4 素数、**不一致 0 件** |
| (2) | 主要項 $m_0\,p^{2n}$ の一致 | content $>1$ の 5 例で $v_p(a_{p^n})=m_0p^{2n}$ が厳密に成立（差 0） |
| (3) | $(3.2)$ の形への同定（$n\ge1$ の 5 段で 5 係数） | 同定された $m_0$ が content 由来の値と一致（3 例） |

**これらは Kataoka Theorem 2.1 / 2.3 の帰結の確認であって、定理の証明ではない。**
