# cycle 21 / T3 Pure: 一般の塔の閉形式 — 5 係数すべてを $D$ の係数から決める

対象: cycle 20 step 3（`outputs/reports/cycle20_T3_ell_equals_2.md`）§9.1 が
**「取れなかったこと」**として明記した箇所 —

> 族 $p(1,0)+q(0,1)$ の外について、$\mathrm{ord}_2(\kappa_n)$ の閉形式は**得ていない**。
> 得たのは観察 G（$b=\sum j^*$ の数値支持）だけで、$c,d,e$ は決めていない。

および cycle 21 step 列が掲げた
「$n\ell^n$ の係数 $b$ は族の外でも決まるようになった（定理 W4・系 W6）が、
**残りの係数 $c,d,e$ は族でしか出ていない**」を埋める。

前提として読んでいる一次情報:
`cycle14_T3_two_variable_criterion.md`（$(6.1)$、定理 3、定理 4 の $(7.2)$、定理 5）、
`cycle19_T3_theta_ge_ell_plus_1.md`（補題 J0、定理 J2、系 J2a、定理 J4、補題 J1、定理 B′、
定理 J6、定理 J7、補題 J9、系 J10）、
`cycle19_T3_theta_infinity.md`（定義 2.1、命題 2、命題 7、命題 8、定理 X、定理 X′、定理 J8）、
`cycle20_T3_cancellation_recursion.md`（定理 L1、系 L2・L3・L3′、**定理 L4**、**定理 K′**）、
`cycle20_T3_s_infinity_decision.md`（定理 W1、補題 W2、**定理 W3**、**定理 W4**、系 W5、**系 W6**）、
`cycle20_T3_ell_equals_2.md`（命題 P1、定理 Y、**定理 Y′**、§9.1）、
`cycle18_T3_general_degenerate_tower.md`（補題 A1・A2、定理 B・C）、
`cycle21_T3_drop_assumption_B_star.md`（**同サイクル step 1**。定理 Q1、および
$b$ が Cuoco–Monsky Theorem 1.7 の $l_0$ そのものだという同定）、
`cycle18_T1_monsky1989_acquisition.md`（Monsky 1989 の本文照合。**$\ell^n$ の係数 $\alpha^*$ に
明示式が無いこと**）、`cycle16_T1_monsky_primary_sources.md`（Cuoco–Monsky §1 の原文）。

**記号の約束**: 本 report で新たに導入する命題には $G$ を冠する。

---

## 0. 結論（先に置く）

| 主張 | 状態 |
|---|---|
| **定理 G1（形の変換）**: $\Theta_M=\alpha M\ell^M+\beta\ell^M+\gamma$（$M\ge M^*$）ならば $\mathrm{ord}_\ell(\kappa_n)$ は cycle 14 $(7.2)$ の 5 係数形をとり、$(a,b,c,d,e)$ が $(\alpha,\beta,\gamma)$ と低レベルの有限和で書ける | **証明した**（§2） |
| **定理 G2（捻り段データ）**: $P_0\in S_\infty$ のまわりの**深さ $k$ の層**では、$M$ が十分大きいとき $\hat\theta_M=\varphi(\ell^M)\Lambda_k+\theta^\sharp_k$。ここで $(\Lambda_k,\theta^\sharp_k)$ は $\tilde E$ を **$\ell^k$ 乗根で捻った 1 径数部分群**へ制限した多項式の段データ（$\mathbb{Z}[\zeta_{\ell^k}]$ 上の有限計算） | **証明した**（§3）。**本 report の中心的な新しい道具**。$k=0$ は cycle 19 step 2 の定理 S（内側球）そのもの |
| **定理 G3（飽和深度の明示上界）**: $K(P_0):=\max\{k\ge0:\ j^*\ell\ge(\ell-1)\ell^{k}\}$ と置くと、深さ $k>K$ の層は必ず**非飽和**（$\hat\theta_M=\theta$）である。とくに $K=0\iff j^*\le\ell-2$ | **証明した**（§4）。**$\ell=2$ が特別なのはこの式の帰結**（$\ell=2$ では $j^*\ge1=\ell-1$ なので必ず $K\ge1$） |
| **定理 G4（一般の塔の閉形式。本 report の主結果）**: **(H) 以外の仮定を一切置かずに**（とくに (F)・(N)・(B\*) なしに）$(\alpha,\beta,\gamma)$ が $D$ の係数からの有限計算で決まり、したがって **$(a,b,c,d,e)$ の 5 係数すべてが決まる** | **証明した**（§5） |
| **系 G5（定理 J7 の最後の仮定 (B\*) が落ちる）**: $b=\sum_{P\in S_\infty}j^*(P)$ は **(B\*) なしで**成り立つ | **証明した**（§5.4）。ただし**同サイクル step 1 の定理 Q1 が同じ結論を別経路で先に証明しており、さらにそれは Cuoco–Monsky Theorem 1.7（1981）そのものである**。本 report の寄与ではない（§10） |
| **本 report が文献に対して足しているところ** | **$c$（$\ell^n$ の係数）である**。Monsky 1989 Theorem 3.12/3.13 は $\ell^n$ の係数 $\alpha^*$ について**存在と（$d=2$ での）有理性しか示しておらず、明示式を与えていない**（Monsky 自身が「no easy description」と書いている）。定理 G4 は、**voltage グラフの $\det L$ 型・$d=2$・(H) という限定の中で** $\alpha^*$ に相当する $c$ を $D$ の係数からの有限計算で与える。さらに $d,e$ も与える（Monsky の誤差項 $O(n\ell^{(d-2)n})=O(n)$ はそこを開けていない） | §10 に根拠と限定を書いた。**新規性は主張しない**（文献調査は網羅的でない） |
| **系 G6（$S_\infty=\emptyset$ の場合）**: $b=0$、$d=-2$、$c=\Theta_L/\varphi(\ell^L)$、$e$ も明示。cycle 19 定理 J6 に**欠けていた $e$** が埋まり、前提（$\theta$ の有界性）も系 L3′ で有効になる | **証明した**（§5.5） |
| 既知の閉形式との整合（定理 J8、定理 X′ の族、cycle 16 定理 D2 ＝ $\ell=2$ トーラス） | **確認した**（§6）。$\ell=2$ トーラスは DuBose–Vallières の数列 $5,19,61,167,417,987$ を $n=1$ から再現する |
| 母集団での照合（**当てはめを一切しない自由度 0 の予言** vs 実測 $\Theta_M$） | **測った**（§7）。FAIL 0 件 |
| 自分の誤り（初稿で $\hat\theta_M\le\theta$ を無条件だと思い込んでいた） | **記録した**（§8.1） |
| $(\Lambda_k,\theta^\sharp_k)$ を $\bar{\tilde E}$ だけから読む式 | **取れなかった**（§9.1）。$\bmod\ \ell$ では決まらないことを反例つきで確定させた |
| 新規性 | **主張しない**（§10） |

**「証明した」と書いたものは、すべて有限個の例に依らない証明を本文に持つ。**
数値だけで支えている観察は §7.3 に隔離し、検出力を明記した。

---

## 1. 出発点 — 5 係数のうちどこまでが出ていたか

記号は cycle 19 §1 を引き継ぐ。$X$ は有限連結 voltage 多重グラフ（$d=2$）、$D=\det L(z,w)$、
$\mu=v_\ell(\mathrm{content}\,D)$、$E=\ell^{-\mu}D$、$\tilde E=z^rw^sE=\sum c_{pq}z^pw^q\in\mathbb{Z}[z,w]$、
$\bar{\tilde E}\in\mathbb{F}_\ell[z,w]$、$S=\mathrm{supp}(\bar{\tilde E})$、$\kappa_n=\kappa(X_{\ell^n,\ell^n})$、
仮定 **(H)**（全段連結。系 C2′ で判定可能）を通して置く。

cycle 14 定理 4 は、Monsky / Cuoco–Monsky を借りて $n\gg0$ で

$$\mathrm{ord}_\ell(\kappa_n)=a\,\ell^{2n}+b\,n\ell^{n}+c\,\ell^{n}+d\,n+e \tag{1.1}$$

の形になることを述べる（cycle 14 $(7.2)$）。本プロジェクトでこれまでに決まっていたのは:

| 係数 | 状態（cycle 20 終了時点） |
|---|---|
| $a$ | $=\mu=v_\ell(\mathrm{content}_{z,w}\det L)$。**一般に決まっている**（cycle 14 定理 3 で下から自前、上からは定理 CM） |
| $b$ | $=\sum_{P\in S_\infty}j^*(P)$（cycle 19 定理 J7）。cycle 20 系 W4・W6 で $j^*$ が**二項式因子の重複度**という代数的な正体を得た。ただし**仮定 (B\*) が残っていた** |
| $c,d,e$ | **族でしか出ていない**。$\ell$ 奇・bouquet $p(1,0)+q(0,1)$ は定理 X′（$c=\Lambda$, $d=0$, $e=-\mu-\Lambda$）、$\ell=2$ の同族は定理 Y′。族の外は未決 |

例外的に、$S_\infty=\emptyset$（$\theta$ が至る所有限）のときは cycle 19 定理 J6 が
$b=0$、$c=\Theta_L/\varphi(\ell^L)$、$d=-2$ を与えていた。ただし
(i) 前提「$\theta$ が有界」はコンパクト性由来で**どのレベルで止まるか言えない**（cycle 20 系 L3′ で解消済み）、
(ii) **$e$（定数項 $\nu$）は「レベル $<n_1$ からの定数」と書かれているだけで、明示されていない**。

**本 report が使う道具は cycle 20 でそろっている。**

- **補題 J1（無仮定）**: $\displaystyle\Sigma_n:=\sum_{(\zeta,\xi)\neq(1,1)}v_\ell(E(\zeta,\xi))=\sum_{M=1}^{n}\Theta_M$、
  $\Theta_M=\sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^{M})}\hat\theta_M(P)$。
- **定理 L4（無仮定）**: $\hat\theta_M(P)=\varphi(\ell^M)v_\ell\bigl(E(\zeta^a,\zeta^b)\bigr)=v_\ell\bigl(\mathrm{Res}_x(\Psi_M,\Phi_P)\bigr)$。
- **cycle 14 $(6.1)$（(H) のみ）**: $\mathrm{ord}_\ell(\kappa_n)=v_\ell(\kappa(X))-2n+\mu(\ell^{2n}-1)+\Sigma_n$。
- **定理 W3（無仮定）**: $S_\infty$ と各点の $(\lambda,\theta^*,m_1,j^*)$ を $D$ の係数から有限手続きで決める。

したがって**残っているのは「$\Theta_M$ を $M$ の式に潰すこと」だけ**である。本 report はそれをやる。

---

## 2. 定理 G1（$\Theta_M$ の形から 5 係数へ）

> **定理 G1.** *(H) を仮定する。ある $M^*\ge1$ と $\alpha,\beta,\gamma\in\mathbb{Q}$ があって*
> $$\Theta_M=\alpha\,M\ell^{M}+\beta\,\ell^{M}+\gamma\qquad(M\ge M^*) \tag{2.1}$$
> *が成り立つならば、$n\ge M^*-1$ で $(1.1)$ が成り立ち、*
> $$a=\mu,\quad
> b=\frac{\ell}{\ell-1}\,\alpha,\quad
> c=\frac{\ell}{\ell-1}\,\beta-\frac{\ell}{(\ell-1)^2}\,\alpha,\quad
> d=\gamma-2, \tag{2.2}$$
> $$e=v_\ell(\kappa(X))-\mu
> +\Bigl[\textstyle\sum_{M=1}^{M^*-1}\Theta_M-\alpha\,\mathcal{S}_1(M^*\!-\!1)-\beta\,\mathcal{S}_0(M^*\!-\!1)-\gamma(M^*\!-\!1)\Bigr]
> +\frac{\ell}{(\ell-1)^2}\alpha-\frac{\ell}{\ell-1}\beta, \tag{2.3}$$
> *ここで $\mathcal{S}_1(N)=\sum_{M=1}^{N}M\ell^M$、$\mathcal{S}_0(N)=\sum_{M=1}^{N}\ell^M$。*

**証明.** $\mathcal{S}_1(n)=\dfrac{\ell-(n+1)\ell^{n+1}+n\ell^{n+2}}{(\ell-1)^2}$、$\mathcal{S}_0(n)=\dfrac{\ell^{n+1}-\ell}{\ell-1}$ は
等比・等差×等比の標準公式である。$\mathcal{S}_1$ の分子の $n$ を含む項は
$n\ell^{n+2}-n\ell^{n+1}=n\ell^{n+1}(\ell-1)$ なので、$\mathcal{S}_1(n)$ の $n\ell^n$ 係数は $\dfrac{\ell}{\ell-1}$、
$\ell^n$ 係数は $-\dfrac{\ell}{(\ell-1)^2}$、定数項は $\dfrac{\ell}{(\ell-1)^2}$。
$\mathcal{S}_0(n)$ は $\ell^n$ 係数 $\dfrac{\ell}{\ell-1}$、定数項 $-\dfrac{\ell}{\ell-1}$。

補題 J1（無仮定）と $(2.1)$ より、$n\ge M^*-1$ で

$$\Sigma_n=\sum_{M=1}^{M^*-1}\Theta_M+\alpha\bigl[\mathcal{S}_1(n)-\mathcal{S}_1(M^*\!-\!1)\bigr]
+\beta\bigl[\mathcal{S}_0(n)-\mathcal{S}_0(M^*\!-\!1)\bigr]+\gamma\,(n-M^*\!+\!1).$$

これを cycle 14 $(6.1)$ に代入し、$\ell^{2n},n\ell^n,\ell^n,n,1$ の係数を読む。$\blacksquare$

**注 2.1（逆は主張しない）.** $(1.1)$ の形から $(2.1)$ を導いてはいない。本 report は $(2.1)$ を
直接証明する（§5）ので逆は不要である。

**注 2.2（$\Theta_M$ に $M$ の 1 次項が無いこと）.** $(2.1)$ に $\delta M$ の項があると
$\Sigma_n$ に $n^2$ が出て $(1.1)$ の形を壊す。§5 の証明はそのような項を作らない。
（cycle 20 の検証コード `fit_b` は $\Theta_M=AM\ell^M+B\ell^M+CM+D$ の 4 パラメータで当てはめていたが、
$C=0$ は当てはめの結果ではなく §5 の帰結である。）

---

## 3. 定理 G2（捻り段データ）— 本 report の中心的な道具

### 3.1 深さ $k$ の層

$P_0=(u_1{:}u_2)\in S_\infty$（$u=(u_1,u_2)$ は原始整数ベクトル。定理 W1 より $S_\infty\subset\mathbb{P}^1(\mathbb{Q})$）を固定し、
$\det(u,\mathbf{e})=1$ なる整数ベクトル $\mathbf{e}$ を 1 つ取る（拡張 Euclid で構成できる）。
レベル $M$ の点のうち $P_0$ からの距離がちょうど $\ell^{-(M-k)}$ のもの（**深さ $k$ の層**）は

$$P_{k,t}=\bigl(u+\ell^{M-k}\,t\,\mathbf{e}\bigr)\bmod\ell^M,\qquad t\in(\mathbb{Z}/\ell^{k})^{\times}\ \ (k\ge1),$$

および $k=0$（$P\equiv u\bmod\ell^M$、1 点）で尽くされる。個数は $k\ge1$ で $\varphi(\ell^k)$、$k=0$ で $1$。
（$M\ge2k$ なら相異なる $t$ は相異なる射影点を与える。）

$g$ を原始 $\ell^M$ 乗根とすると $\eta:=g^{\ell^{M-k}}$ は原始 $\ell^k$ 乗根で、

$$\bigl(g^{a},g^{b}\bigr)=\bigl(g^{u_1}\eta^{t\mathbf{e}_1},\ g^{u_2}\eta^{t\mathbf{e}_2}\bigr)
\qquad\bigl((a,b)=u+\ell^{M-k}t\mathbf{e}\bigr). \tag{3.1}$$

**つまり、$P_0$ の近傍を見ることは「$1$ 径数部分群を $\ell^k$ 乗根で捻る」ことに等しい。**

### 3.2 捻り段データ

$\mathcal{O}_k:=\mathbb{Z}[\eta]$（$\eta$ は原始 $\ell^k$ 乗根、$\mathcal{O}_0=\mathbb{Z}$）と置く。
$\ell$ は $\mathbb{Q}(\eta)/\mathbb{Q}$ で完全分岐し（$e=\varphi(\ell^k)$、$f=1$）、
$v_\ell$（$v_\ell(\ell)=1$ に正規化）は $\mathcal{O}_k\setminus\{0\}$ 上で $\frac1{\varphi(\ell^k)}\mathbb{Z}_{\ge0}$ に値を取り、
$v_\ell(\alpha)=\dfrac{v_\ell\bigl(N_{\mathbb{Q}(\eta)/\mathbb{Q}}(\alpha)\bigr)}{\varphi(\ell^k)}$ で計算できる（**整数の付値ひとつ**）。

> **定義 G2a（捻り制限と段データ）.**
> $$\Phi^{[k]}_{u}(x):=\tilde E\bigl((1+x)^{u_1}\eta^{\mathbf{e}_1},\,(1+x)^{u_2}\eta^{\mathbf{e}_2}\bigr)
> =\sum_{m}A^{[k]}_m\,x^{m}\ \in\mathcal{O}_k[x]$$
> （$(1+x)$ の負冪が出るときは単項式因子 $\bigl((1+x)^{s}\eta^{s'}\bigr)$ を落とす。これは単元なので $v_\ell$ を変えない）。
> $$\Lambda_k:=\min_m v_\ell\bigl(A^{[k]}_m\bigr),\quad
> \theta^\sharp_k:=\min\{m:v_\ell(A^{[k]}_m)=\Lambda_k\},\quad
> m^\sharp_k:=\min\{m<\theta^\sharp_k: A^{[k]}_m\neq0\}$$
> （そのような $m$ が無ければ $m^\sharp_k=\infty$）。$k=0$ ではこれは cycle 19 step 2 の
> `stage_data`（$\lambda,\theta^*,m_1$）そのものである。

> **定理 G2.** *$P_0\in S_\infty$、$k\ge0$ とする。*
> 1. *$\Lambda_k,\theta^\sharp_k,m^\sharp_k$ は $t\in(\mathbb{Z}/\ell^k)^\times$ の取り方に依らない（したがって層の全点で共通）。*
> 2. *$M\ge2k$ かつ*
>    $$\varphi(\ell^{M})>\bigl(\theta^\sharp_k-m^\sharp_k\bigr)\,\varphi(\ell^{k}) \tag{3.2}$$
>    *ならば、深さ $k$ の層の全点 $P$ で*
>    $$\hat\theta_M(P)=\varphi(\ell^{M})\,\Lambda_k+\theta^\sharp_k. \tag{3.3}$$
> 3. *$\varphi(\ell^k)\Lambda_k\in\mathbb{Z}_{\ge1}$。とくに $(3.3)$ の右辺は整数である。*

**証明.**

**1.** $\sigma_t:\eta\mapsto\eta^{t}$ は $\mathrm{Gal}(\mathbb{Q}(\eta)/\mathbb{Q})$ の元で、$\mathbb{Z}$ を固定し、
$\Phi^{[k]}_u$ の係数を $t$ 版の係数へ写す。$v_\ell$ は Galois 不変（$\ell$ の上の素点が 1 つだから）なので
$v_\ell(A_m)$ の列は $t$ に依らない。

**2.** $\pi:=g-1$ と置くと $v_\ell(\pi)=1/\varphi(\ell^M)$、$(3.1)$ と定理 L4 より

$$\hat\theta_M(P)=\varphi(\ell^M)\,v_\ell\Bigl(\sum_m A^{[k]}_m\pi^{m}\Bigr),\qquad
\varphi(\ell^M)\,v_\ell\bigl(A^{[k]}_m\pi^m\bigr)=\varphi(\ell^M)v_\ell(A^{[k]}_m)+m .$$

右辺（$\mathbb{Z}\cup\{\infty\}$ に値を取る）の最小値が一意に達成されることを見る。

- $m=\theta^\sharp_k$: 値は $\varphi(\ell^M)\Lambda_k+\theta^\sharp_k$。
- $m>\theta^\sharp_k$: $v_\ell(A_m)\ge\Lambda_k$ より値 $\ge\varphi(\ell^M)\Lambda_k+m>\varphi(\ell^M)\Lambda_k+\theta^\sharp_k$。
- $m<\theta^\sharp_k$ かつ $A_m\neq0$: $v_\ell(A_m)$ は $\frac1{\varphi(\ell^k)}\mathbb{Z}$ の元で $\Lambda_k$ より真に大きいので
  $v_\ell(A_m)\ge\Lambda_k+\frac1{\varphi(\ell^k)}$。よって値 $\ge\varphi(\ell^M)\Lambda_k+\frac{\varphi(\ell^M)}{\varphi(\ell^k)}+m^\sharp_k$
  であり、$(3.2)$ よりこれは $\varphi(\ell^M)\Lambda_k+\theta^\sharp_k$ より真に大きい。

最小点が一意なので非アルキメデス的評価の等号が成り立ち $(3.3)$。

**3.** $v_\ell$ の値が $\frac1{\varphi(\ell^k)}\mathbb{Z}$ に入ることから $\varphi(\ell^k)\Lambda_k\in\mathbb{Z}$。
$\ge1$ は次で見る: $\mathcal{O}_k$ の極大イデアルは $(\eta-1)$（$k\ge1$）で剰余体は $\mathbb{F}_\ell$、
その剰余写像は $\eta\mapsto1$ を誘導するので $A^{[k]}_m\bmod\mathfrak{m}=\bar A_m(u)$。
$P_0\in S_\infty$ は $\overline{\Phi_u}\equiv0$、すなわち全ての $m$ で $\bar A_m(u)=0$ を意味する（補題 W2）ので
$v_\ell(A^{[k]}_m)\ge\frac1{\varphi(\ell^k)}$、よって $\varphi(\ell^k)\Lambda_k\ge1$。$\blacksquare$

**注 3.1（$k=0$ との一致）.** $k=0$ では $\eta=1$、$\mathcal{O}_0=\mathbb{Z}$、$(3.3)$ は
$\hat\theta_M(P_0)=\varphi(\ell^M)\lambda+\theta^*$ となり、cycle 19 step 2 の定理 S（および命題 7 の
「例外直線 1 本の寄与 $\lambda(\ell^n-1)+n\theta^*$」）と一致する。
**定理 G2 は定理 S を「深さ $k$」方向へ持ち上げたものである。**

**注 3.2（定理 B′ を経由しない）.** $(3.3)$ の証明は $\mathcal{O}_k$ の中で最小点の一意性を**示している**のであって
仮定していない。$\mathbb{Z}$ 係数のまま（$k$ を無視して）定理 B′ を使うと、まさにこの層で
最小点が同点になる（§4・§8.1）。**係数環を $\mathbb{Z}$ から $\mathcal{O}_k$ へ広げると同点が解ける**、
というのが本 report の技術的な要点である。

---

## 4. 定理 G3（飽和深度の明示上界）

$P_0\in S_\infty$ に対し、cycle 19 定理 J4 の $e_j$（基点 $P_0$）と $j^*=\min\{j\ge1:e_j<\infty\}$ を取る。
系 W5 の $r_0$ 以上の $r$ では $\Lambda(r)=\min_j(e_j+j\ell^r)$ の argmin が $j^*$ で一意になるので、
$R'(P_0)$ をそのような最小の $r$ とする。$r\ge R'$ の層（＝深さ $k=M-r$）では

$$\theta(P)=e_{j^*}+j^{*}\ell^{\,M-k}. \tag{4.1}$$

> **定理 G3.** $K(P_0):=\max\bigl\{k\ge0:\ j^{*}\ell\ \ge\ (\ell-1)\ell^{k}\bigr\}$ *と置く（$j^*\ge1$ より $K\ge0$ は常に定義される）。
> このとき、$k>K$ なる深さ $k$ の層では、$M\ge\max\bigl(R'+k,\ k+\lceil\log_\ell(e_{j^*}+1)\rceil\bigr)$ で*
> $$\hat\theta_M(P)=\theta(P)=e_{j^*}+j^{*}\ell^{\,M-k},\qquad
> \text{すなわち}\quad \Lambda_k=\frac{j^{*}}{\varphi(\ell^{k})},\ \ \theta^\sharp_k=e_{j^*}. \tag{4.2}$$
> *とくに $K=0\iff j^{*}\le\ell-2$ であり、$\ell=2$ では $j^*\ge1=\ell-1$ なので**必ず $K\ge1$** である。*

**証明.** $k>K$ は $j^{*}\ell<(\ell-1)\ell^{k}$、すなわち $(\ell-1)\ell^{k-1}-j^{*}\ge1$ を意味する。
$r=M-k\ge R'$ なので $(4.1)$ が使え、$\Phi_P\in\mathbb{Z}[x]$ の係数について
$m<\theta$ では $v_\ell(A_m)\ge1$、$m=\theta$ では $v_\ell(A_\theta)=0$ である。
定理 B′ の最小化 $\min_m(\varphi(\ell^M)v_\ell(A_m)+m)$ で $m=\theta$ が一意の最小点になる条件は
$\theta-m_1<\varphi(\ell^M)$（$m_1$ は $\Phi_P$ の最低次。cycle 18 補題 A2 (1) より $m_1\ge2$）であり、

$$\varphi(\ell^M)-\theta+m_1\ \ge\ (\ell-1)\ell^{M-1}-j^{*}\ell^{M-k}-e_{j^*}+2
=\ell^{M-k}\bigl[(\ell-1)\ell^{k-1}-j^{*}\bigr]-e_{j^*}+2\ \ge\ \ell^{M-k}-e_{j^*}+2$$

なので、$\ell^{M-k}>e_{j^*}$ すなわち $M\ge k+\lceil\log_\ell(e_{j^*}+1)\rceil$ で正になる。
よって $\hat\theta_M=\theta$。これと定理 G2 の $(3.3)$（同じ $M$ で両方が成り立つ $M$ を取れば）を比べて
$\varphi(\ell^M)\Lambda_k+\theta^\sharp_k=e_{j^*}+j^*\ell^{M-k}$ が 2 つ以上の $M$ で成り立つから、
$\ell^M$ の係数を比べて $\Lambda_k=\dfrac{j^{*}\ell^{-k}}{1-\ell^{-1}}=\dfrac{j^{*}}{\varphi(\ell^{k})}\cdot\dfrac{\varphi(\ell^k)\ell^{1-k}}{\ell-1}$。
実際 $\varphi(\ell^k)\ell^{1-k}/(\ell-1)=1$ なので $\Lambda_k=j^*/\varphi(\ell^k)$、定数項を比べて $\theta^\sharp_k=e_{j^*}$。

最後に $K=0\iff j^{*}\ell<(\ell-1)\ell\iff j^{*}<\ell-1\iff j^{*}\le\ell-2$。$\blacksquare$

**注 4.1（$\ell=2$ が特別な理由の正体）.** cycle 20 step 3 は $\ell=2$ に固有のものとして
**飽和**と**打ち消し**を挙げた。定理 G3 はその由来を 1 行で説明する:
飽和が起きる深さは $j^{*}\ell\ge(\ell-1)\ell^{k}$ で決まり、$\ell=2$ では $\ell-1=1$ が最小なので
$j^*\ge1$ である限り必ず $k=1$ まで飽和する。**$\ell=2$ は「$\ell-1$ が小さすぎる」だけであって、
構造的に別物ではない。** 同じことは $\ell$ 奇でも $j^{*}\ge\ell-1$ の塔で起きる
（実例: $\ell=3$、bouquet $(1,0),(0,1),(1,1),(1,-1)$ で $j^*=2=\ell-1$。§6.4）。

**注 4.2（$K$ は上界であって、$k\le K$ の層が必ず飽和するとは言っていない）.**
定理 G3 が主張するのは「$k>K$ なら非飽和」だけである。$k\le K$ の層で
$(\Lambda_k,\theta^\sharp_k)$ が偶然 $(4.2)$ の値になっても、§5 の式はそのまま正しい
（その層の寄与が非飽和層の寄与と一致するから）。**$K$ は「捻り段データを実際に計算すべき $k$ の有限範囲」を
与えるためのものであり、それだけで十分である。**

**理由（$K\to K+1$ の増分が打ち消し合うこと）.** $(5.3)$$(5.4)$ は $K$ に直接依存する項を含むので、
$K$ を取り替えても値が変わらないことは確認を要する。$K'=K+1$ の場合を見れば十分である（あとは帰納法）。
深さ $K+1$ の層は定理 G3 より非飽和なので $(4.2)$ より $\Lambda_{K+1}=j^{*}/\varphi(\ell^{K+1})$、
$\theta^\sharp_{K+1}=e_{j^*}$。したがって

- $(5.4)$: $\sum_k\varphi(\ell^k)\theta^\sharp_k$ が $\varphi(\ell^{K+1})e_{j^*}$ 増え、$-e_{j^*}\ell^{K}$ が
  $-e_{j^*}\ell^{K+1}$ になる。差は
  $e_{j^*}\bigl(\varphi(\ell^{K+1})-\ell^{K+1}+\ell^{K}\bigr)=e_{j^*}\bigl((\ell^{K+1}-\ell^{K})-\ell^{K+1}+\ell^{K}\bigr)=0$。
- $(5.3)$: $\frac{\ell-1}{\ell}\sum_k\varphi(\ell^k)\Lambda_k$ が
  $\frac{\ell-1}{\ell}\varphi(\ell^{K+1})\cdot\frac{j^{*}}{\varphi(\ell^{K+1})}=\frac{(\ell-1)j^{*}}{\ell}$ 増え、
  $-\frac{(\ell-1)j^{*}(K+r^\sharp)}{\ell}$ が $-\frac{(\ell-1)j^{*}(K+1+r^\sharp)}{\ell}$ になる。差は $0$。

> **【訂正 2026-08-01（cycle 24 step 1）】** 注 4.2 の**主張は正しい**が、初稿はこの打ち消しの計算を
> 書いていなかったため、読み手が注 4.2 の真偽を本文から検証できなかった。上の「理由」を書き足した。
> 検出は cycle 22 step 4 の Lean 検算 `cycle22_ops_lean_cycle21_theorems.md` §3.2（`G4_K_dependence`）。
> 同じ計算は cycle 22 の `cycle22_T3_coefficients_d_e.md` §2.3（命題 D1a）が $(2.2)$$(2.3)$ の形で
> 独立に書いている。

---

## 5. 定理 G4（一般の塔の閉形式）— 主結果

### 5.1 $\Theta_M$ の分解

$r^\sharp:=\max\bigl(r_0,\ \max_{P_0}R'(P_0)\bigr)$（系 W5 と §4 より $D$ の係数から計算できる）と置き、

$$U:=\mathbb{P}^1(\mathbb{Z}_\ell)\setminus\bigcup_{P_0\in S_\infty}B\bigl(P_0,\ell^{-r^\sharp}\bigr)$$

と置く（$r^\sharp\ge r_0$ なので球は互いに素）。$U$ 上で $\theta<\infty$ であり、
系 L3′ と同じ議論（候補集合 $U_{\mathrm{cand}}$ のうち $S_\infty$ に入らない点での $\theta$ の最大値と
系 L3 の距離評価を組み合わせる）で **$\theta$ は $U$ 上有界**、その上界は $D$ の係数から計算できる。
$\theta^{\max}_U$ を実際の最大値、$L\ge r^\sharp$ を $\ell^{L}\ge\theta^{\max}_U$ なるレベルとすると、
系 J2a より $\theta|_U$ は $\mathbb{P}^1(\mathbb{Z}/\ell^{L})$ を経由する。

$$A_{\mathrm{gen}}:=\frac{1}{\ell^{L}}\sum_{P\in U\cap\mathbb{P}^1(\mathbb{Z}/\ell^{L})}\theta(P)\ \in\mathbb{Q} \tag{5.1}$$

は $L$ の取り方に依らない（$L\to L+1$ でファイバーが一様に $\ell$ 個に分かれるから）。

> **注記（唯一の外部依存）.** 系 J2a は cycle 19 定理 J2（桁定理）の $m=\ell^L$ ちょうどの段を使い、
> そこには $\bar A_1\equiv0$ が要る（cycle 20 step 4 が検出した暗黙の仮定）。
> 本設定ではこれは cycle 18 補題 A2 (1)（$D(z,w)=D(z^{-1},w^{-1})$）から**無条件に**従うので
> 追加の仮定にはならない。本 report で $(1.2)$ 以外に外部から借りているのはこの 1 点だけである。

### 5.2 定理 G4

> **定理 G4（一般の塔の閉形式）.** *(H) を仮定する。上の $r^\sharp$、$A_{\mathrm{gen}}$、
> 各 $P_0\in S_\infty$ の $j^{*},e_{j^*},K(P_0)$ と捻り段データ $(\Lambda_k,\theta^\sharp_k)_{0\le k\le K}$ を取り、*
> $$\alpha:=\frac{\ell-1}{\ell}\sum_{P_0\in S_\infty}j^{*}(P_0), \tag{5.2}$$
> $$\beta:=A_{\mathrm{gen}}+\sum_{P_0\in S_\infty}\Bigl[\frac{e_{j^*}}{\ell^{\,r^\sharp}}
> -\frac{(\ell-1)\,j^{*}\,(K+r^\sharp)}{\ell}
> +\frac{\ell-1}{\ell}\Bigl(\Lambda_0+\sum_{k=1}^{K}\varphi(\ell^{k})\Lambda_k\Bigr)\Bigr], \tag{5.3}$$
> $$\gamma:=\sum_{P_0\in S_\infty}\Bigl[-e_{j^*}\,\ell^{K}
> +\theta^\sharp_0+\sum_{k=1}^{K}\varphi(\ell^{k})\,\theta^\sharp_k\Bigr] \tag{5.4}$$
> *と置く。このとき明示的な $M^*$（§5.3）が存在して $M\ge M^*$ で $(2.1)$ が成り立つ。
> したがって定理 G1 より、$\mathrm{ord}_\ell(\kappa_n)$ の **5 係数 $(a,b,c,d,e)$ すべてが
> $D$ の係数からの有限計算で決まる**。とくに*
> $$b=\sum_{P_0\in S_\infty}j^{*}(P_0),\qquad d=\gamma-2 . \tag{5.5}$$

**証明.** レベル $M$ の $\mathbb{P}^1(\mathbb{Z}/\ell^M)$ を 3 つに分ける（$M\ge M^*$）。

**(a) $U$ の部分.** $\theta|_U$ は $\mathbb{P}^1(\mathbb{Z}/\ell^{L})$ を経由し、$\theta\le\theta^{\max}_U$、$m_1\ge2$ より
$\theta-m_1\le\theta^{\max}_U-2<\varphi(\ell^{M})$（$M^*$ の条件）なので注 4.1（cycle 19）より $\hat\theta_M=\theta$。
$\mathbb{P}^1(\mathbb{Z}/\ell^{M})\to\mathbb{P}^1(\mathbb{Z}/\ell^{L})$ のファイバーは一様に $\ell^{M-L}$ 個なので、
この部分の和は $\ell^{M-L}\cdot\ell^{L}A_{\mathrm{gen}}=A_{\mathrm{gen}}\,\ell^{M}$。**$M\ell^M$ 項も定数項も出さない。**

**(b) 各 $P_0$ の、深さ $K+1\le k\le M-r^\sharp$ の層（＝ $r^\sharp\le r\le M-K-1$）.**
定理 G3 より非飽和で $\hat\theta_M=\theta=e_{j^*}+j^{*}\ell^{r}$、層の点数は $\varphi(\ell^{M-r})$。
$\varphi(\ell^{M-r})\ell^{r}=\ell^{M}-\ell^{M-1}=\varphi(\ell^{M})$ が **$r$ に依らない**ので

$$\sum_{r=r^\sharp}^{M-K-1}\varphi(\ell^{M-r})\bigl(e_{j^*}+j^{*}\ell^{r}\bigr)
=e_{j^*}\bigl(\ell^{\,M-r^\sharp}-\ell^{K}\bigr)+j^{*}\varphi(\ell^{M})\,\bigl(M-K-r^\sharp\bigr)$$

（$\sum_{r=r^\sharp}^{M-K-1}\varphi(\ell^{M-r})=\sum_{s=K+1}^{M-r^\sharp}\varphi(\ell^{s})=\ell^{M-r^\sharp}-\ell^{K}$ を使った）。
$M\ell^{M}$ 項の係数は $j^{*}\frac{\ell-1}{\ell}$、$\ell^{M}$ 項の係数は
$e_{j^*}\ell^{-r^\sharp}-j^{*}(K+r^\sharp)\frac{\ell-1}{\ell}$、定数項は $-e_{j^*}\ell^{K}$。

**(c) 各 $P_0$ の、深さ $0\le k\le K$ の層.** 定理 G2 より $\hat\theta_M=\varphi(\ell^{M})\Lambda_k+\theta^\sharp_k$、
点数は $k=0$ で $1$、$k\ge1$ で $\varphi(\ell^{k})$。和は

$$\varphi(\ell^{M})\Bigl(\Lambda_0+\sum_{k=1}^{K}\varphi(\ell^{k})\Lambda_k\Bigr)
+\Bigl(\theta^\sharp_0+\sum_{k=1}^{K}\varphi(\ell^{k})\theta^\sharp_k\Bigr).$$

$\ell^{M}$ 項の係数は $\frac{\ell-1}{\ell}\bigl(\Lambda_0+\sum_k\varphi(\ell^k)\Lambda_k\bigr)$、定数項は括弧の第 2 項。
**$M\ell^M$ 項は出ない。**

(a)(b)(c) を足すと $(5.2)$–$(5.4)$ を係数とする $(2.1)$ になる。$M$ の 1 次項はどこからも出ない（注 2.2）。
$b=\frac{\ell}{\ell-1}\alpha=\sum j^{*}$。$\blacksquare$

### 5.3 $M^*$ の明示形

$(2.1)$ が成り立つ十分条件として、次をすべて満たす最小の $M$ を $M^*$ と取ればよい。

1. $M\ge L$（$A_{\mathrm{gen}}$ が経由するレベル）。
2. $M\ge r^\sharp+\max_{P_0}K(P_0)$（(b) の閉形式が成り立つ境界。層が**空でも**閉形式は $0$ を返すので、
   空であること自体は障害ではない）。
3. $\varphi(\ell^{M})>\theta^{\max}_U-2$（(a)）。
4. 各 $P_0$、各 $k\le K$ で $M\ge2k$ かつ $\varphi(\ell^{M})>(\theta^\sharp_k-m^\sharp_k)\varphi(\ell^{k})$（定理 G2 $(3.2)$）。
5. 各 $P_0$ で $e_{j^*}+j^{*}\ell^{\,M-K-1}-2<\varphi(\ell^{M})$（定理 G3、$k=K+1$ の最外層）。

いずれも $D$ の係数からの有限計算である。

> **【訂正 2026-08-01（cycle 24 step 1）】** 条件 2 は初稿では
> 「$M\ge r^\sharp+\max_{P_0}K(P_0)+1$（(b) の層が空でない）」だった。**この $+1$ は 1 つ強すぎる。**
> §5.2 (b) が使う等式 $\sum_{r=r^\sharp}^{M-K-1}\varphi(\ell^{M-r})=\sum_{s=K+1}^{M-r^\sharp}\varphi(\ell^{s})
> =\ell^{M-r^\sharp}-\ell^{K}$ が成り立つ条件は $K\le M-r^\sharp$、すなわち $M\ge r^\sharp+K$ であり、
> $M=r^\sharp+K$（層が空）でも両辺 $0$ で成り立つ。
> **しかも初稿は §6.1（定理 J8 との照合）で $r^\sharp=1,K=0$ の下に $M^*=1$ を使っており、
> 初稿の条件 2 を自分で破っていた**（内部の食い違い）。**正しいのは §6.1 の側**で、直すべきはここである。
> 検出は cycle 22 step 4 の Lean 検算 `cycle22_ops_lean_cycle21_theorems.md` §1
> （`GeneralTower.sum_totient_Ico` / `layer_b_boundary`）。

### 5.4 系 G5（仮定 (B\*) が落ちる）

> **系 G5.** *定理 J7 の結論 $b=\sum_{P\in S_\infty}j^{*}(P)$ は、(F)・(N)・(B\*) のいずれも仮定せずに成り立つ。*

**証明.** (F)（$S_\infty$ の有限性）は系 J10 ＋ 定理 W1 で無条件、
(N) は系 W5 で無条件（本 report の $r^\sharp$ がその明示形）。
(B\*)（定理 B′ の最小点の一意性）は定理 G4 の証明で**一度も使っていない**:
(a)(b) では最小点の一意性を**証明して**使い、(c) では定理 B′ を経由せず定理 G2（$\mathcal{O}_k$ 上の一意性）を使う。$\blacksquare$

**ただしこの結論自体は本 report の寄与ではない。** 同サイクル step 1
（`cycle21_T3_drop_assumption_B_star.md` 定理 Q1）が別の道具（$\tilde E=BG+\ell H$ という
整数への持ち上げ）で同じ結論を証明しており、しかも step 1 §11 が明らかにしたとおり
**それは Cuoco–Monsky (1981) Theorem 1.7 ＋ Definition 1.2 そのもの**である。
本 report の系 G5 は、定理 G4 の副産物として同じことが出るという確認にすぎない。

**本 report が step 1 に足しているのは、$O(\ell^M)$ の誤差項の中身を開けたこと**である。
step 1 §9.2 は「定理 Q1 の誤差項 $O(\ell^M)$ の中身は本 step では開けていない」と書き、
§7 は「(B\*) は最内側の $O(1)$ 個の点での付値の正確さを保証していた。$b$ には効かないが
$c$ 以降には効く」と切り分けた。定理 G2 はまさにその**最内側の $O(1)$ 個の点**（深さ $k\le K$ の層）で
付値を正確に与える道具であり、両 step の切り分けは一致している。

### 5.5 系 G6（$S_\infty=\emptyset$ の場合）

> **系 G6.** *$S_\infty=\emptyset$（定理 W3 で判定できる）なら $\alpha=0$、$\beta=A_{\mathrm{gen}}$、$\gamma=0$ で、*
> $$a=\mu,\quad b=0,\quad c=\frac{\ell}{\ell-1}A_{\mathrm{gen}}=\frac{\Theta_L}{\varphi(\ell^{L})},\quad d=-2,$$
> $$e=v_\ell(\kappa(X))-\mu+\sum_{M=1}^{M^*-1}\Theta_M-A_{\mathrm{gen}}\Bigl(\mathcal{S}_0(M^*\!-\!1)+\frac{\ell}{\ell-1}\Bigr).$$

**証明.** $S_\infty=\emptyset$ なら $U=\mathbb{P}^1(\mathbb{Z}_\ell)$ で (b)(c) が空。
$\ell^{L}A_{\mathrm{gen}}=\sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^L)}\theta(P)=\Theta_L$（$M^*\le L$ を満たすように $L$ を取れば
$\hat\theta_L=\theta$）で、$\frac{\ell}{\ell-1}\ell^{-L}=\frac{1}{\varphi(\ell^L)}$。$(2.3)$ に $\alpha=\gamma=0$ を入れる。$\blacksquare$

**cycle 19 定理 J6 との差**: $c$ の値は同じである。新しいのは
(i) 前提「$\theta$ が有界」がコンパクト性ではなく系 L3′ の**有効な上界**で保証されること、
(ii) 定理 J6 が「レベル $<n_1$ からの定数 $\nu$」としか書かなかった **$e$ が明示されたこと**である。

---

## 6. 既知の閉形式との突き合わせ（検算）

### 6.1 定理 J8（$\ell$ 奇、bouquet $(\ell-1)\times(1,0)+1\times(0,1)$）

cycle 19 定理 J8 は $\mathrm{ord}_\ell(\kappa_n)=2n\ell^{n}+2\ell^{n}-2$、すなわち $(a,b,c,d,e)=(0,2,2,0,-2)$。
定理 G4 を手で回すと（$\bar{\tilde E}=w(z-1)^2-z(w-1)^2$、$S_\infty=\{(1{:}1),(1{:}-1)\}$、$r_0=R'=r^\sharp=1$、
各点で $j^{*}=1\le\ell-2$（$\ell\ge3$）より $K=0$、$e_{j^*}=1$、$\Lambda_0=\lambda=1$、$\theta^\sharp_0=\theta^{*}=2$、
$U$ は $\bmod\ \ell$ の $\ell-1$ 方向で $\theta\equiv2$ より $A_{\mathrm{gen}}=2(\ell-1)/\ell$）:

$$\alpha=\frac{2(\ell-1)}{\ell},\quad
\beta=\frac{2(\ell-1)}{\ell}+2\Bigl[\frac1\ell-\frac{\ell-1}{\ell}+\frac{\ell-1}{\ell}\Bigr]=2,\quad
\gamma=2(2-1)=2,$$

$$b=\frac{\ell}{\ell-1}\cdot\frac{2(\ell-1)}{\ell}=2,\quad
c=\frac{2\ell}{\ell-1}-\frac{2}{\ell-1}=2,\quad d=2-2=0,$$

$M^*=1$ なので $(2.3)$ の角括弧は $0$ で $e=\frac{\ell}{(\ell-1)^2}\cdot\frac{2(\ell-1)}{\ell}-\frac{\ell}{\ell-1}\cdot2=\frac{2-2\ell}{\ell-1}=-2$。
**5 係数すべて一致する。** 機械照合は検証 Step A1（$\ell=3,5,7$）。

### 6.2 定理 X′ の族（$\ell$ 奇、$p(1,0)+q(0,1)$、例外直線あり）

定理 X′ は $\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+2n\ell^{n}+\Lambda(\ell^{n}-1)$、
すなわち $b=2$、$c=\Lambda$、$d=0$、$e=-\mu-\Lambda$。定理 G4 の $b=\sum j^{*}$ は
この族で $|S_\infty|=2$・$j^{*}=1$（[A]）または $|S_\infty|=1$・$j^{*}=2$（[B]）を与えて $b=2$ で一致する。
$d=\gamma-2=0$ は $\sum_{P_0}(\theta^\sharp_0-e_{j^*})=2$ に対応する。機械照合は Step A2。

### 6.3 cycle 16 定理 D2 ＝ $\ell=2$ トーラス

$\ell=2$、bouquet $(1,0),(0,1)$。$S_\infty=\{(1{:}1),(1{:}-1)\}$、$\det(u,u')=-2$ より $r_0=2=r^\sharp$、
$j^{*}=1=\ell-1$ より **$K=1$**（定理 G3）。$k=0$: $(\Lambda_0,\theta^\sharp_0)=(1,2)$。
$k=1$: $\eta=-1$ で捻ると $(\Lambda_1,\theta^\sharp_1)=(2,0)$。$e_{j^*}=2$、$A_{\mathrm{gen}}=2$。

$$\alpha=1,\qquad
\beta=2+2\Bigl[\frac24-\frac{1\cdot(1+2)}{2}+\frac12\bigl(1+1\cdot2\bigr)\Bigr]=2+2\cdot\frac12=3,\qquad
\gamma=2\bigl[-2\cdot2+2+0\bigr]=-4,$$

$$b=2,\quad c=2\cdot3-2\cdot1=4,\quad d=-6,\quad e=-1 .$$

$$\mathrm{ord}_2(\kappa_n)=2n2^{n}+4\cdot2^{n}-6n-1 .$$

$n=1,\dots,6$ で $5,19,61,167,417,987$ となり、**DuBose–Vallières の数列（cycle 14 §7.3・cycle 16 定理 D2）と
$n=1$ から完全に一致する。** $d=-6$ は cycle 20 step 3 の表が挙げた $\ell=2$ の 4 通りの線形項
$-6,-2,0,+2$ の 1 つである。機械照合は Step A3。

**ここが cycle 20 step 3 §9.1 の「妨げ」に対する答えである。** 同 §9.1 は
「族の外では飽和が起きる定数項が $2(p'+q')$ に相当するもの一般へ変わるので、$v_2$ が場合により変わり、
層の構造が族の場合ほど単純にならない」と書いた。定理 G2 はその「場合により変わる $v_2$」を
**捻り段データ $\Lambda_1$ として一般に定義し、有限計算で出す**。
定理 Y′ の不変量 $w=v_2(c_e/2+c_o)$ は、この族における $\Lambda_1$ の具体形である。

### 6.4 $\ell$ 奇でも飽和は起きる（$\ell=2$ 固有ではない）

$\ell=3$、bouquet $(1,0),(0,1),(1,1),(1,-1)$（cycle 20 step 2 §8.1 が (B\*) の奇素数の反例として挙げた塔）。
$S_\infty=\{(0{:}1),(1{:}0)\}$、各点で $j^{*}=2=\ell-1$ なので定理 G3 より $K=1$。
$(\Lambda_0,\theta^\sharp_0)=(1,2)$、$(\Lambda_1,\theta^\sharp_1)=(2,0)$、$e_{j^*}=2$、$r^\sharp=1$、$A_{\mathrm{gen}}=8/3$。

$$\alpha=\frac{2}{3}\cdot4=\frac83,\qquad \beta=\frac83+2\Bigl[\frac23-\frac{2\cdot2\cdot2}{3}+\frac23(1+2\cdot2)\Bigr]=\frac{16}{3},
\qquad \gamma=2\bigl[-2\cdot3+2\bigr]=-8,$$

$$b=4,\quad c=\frac{3}{2}\cdot\frac{16}{3}-\frac{4}{2}=6,\quad d=-10 .$$

実測 $\Theta_M$ は $M=2,3,4$ で $88,352,1288$、予言 $\frac83M3^M+\frac{16}{3}3^M-8$ は
$88,352,1288$ で**一致する**（飽和を無視した式は $72,288,1080$ で外れる）。
**「(B\*) の破れは $\ell=2$ 固有ではない」という cycle 20 step 2 §8.1 の指摘は、
定理 G3 の $j^{*}\ge\ell-1$ という形で説明される。**

---

## 7. 数値検証

### 7.1 何を測ったか

実測側 $\Theta_M=\sum_{P}\hat\theta_M(P)$ は **cycle 20 定理 L4 の整数終結式**で計算しており、
本 report の理論から独立である（仮定を一切置かない）。
予言側 $(\alpha,\beta,\gamma)$ は $D$ の係数だけから決まり、**当てはめ（fit）を一切していない**。
すなわち**自由度 0** の予言と、$M$ ごとの実測との照合である。

> **なぜこの設計にしたか（cycle 20 step 3 の誤りへの対応）.** cycle 20 の検証コード `fit_b` は
> $\Theta_M=AM\ell^M+B\ell^M+CM+D$ を **4 レベルで 4 パラメータ**当てはめており、自由度 0 の当てはめを
> out-of-sample と読み違える危険があった。本 report は当てはめを使わない。
> 4 係数を「当てて」いるのではなく、**$D$ の係数から計算して**いる。

### 7.2 結果

母集団は 124 塔（1 頂点 bouquet 2–3 ループ 77、2 頂点平行 3 重辺 20、族 $p(1,0)+q(0,1)$ 21、
敵対的に選んだ名前つき 6）。実数値は
`sagemath/check/cycle21_T3_general_closed_form/RESULTS.md`、生ログは `*.out`。

| Step | 内容 | 照合件数 | **不一致** |
|---|---|---|---|
| A1 | 定理 J8（$\ell=3,5,7$）と $(a,b,c,d,e)$ が一致するか | 3 | **0** |
| A2 | 定理 X′ の族の形（$b=2$, $d=0$, $e=-a-c$）を満たすか | 7 | **0** |
| A3 | $\ell=2$ トーラスの $5,19,61,167,417,987$（$n=1$ から） | 6 | **0** |
| B | 母集団 × $\ell\in\{2,3,5,7\}$ の $(M,\text{塔})$ 組（$M\ge M^*$） | **1071** | **0** |
| B2 | 名前つきの塔を深いレベルまで（$\ell=2$ は $M\le9$、$\ell=3$ は $M\le6$） | 69 | **0** |
| D | $K\ge1$ の塔で naive 版（飽和を無視）が壊れること | 94 中 74 で破れを確認 | — |
| E | 深さ $k\le K$ の層で $\hat\theta_M=\varphi(\ell^M)\Lambda_k+\theta^\sharp_k$ | 388 | **0** |
| F | $b=\sum j^{*}$（飽和の有無に依らず） | 365 塔 | **0** |
| G | **Matrix–Tree 定理で計算した塔の値** $\mathrm{ord}_\ell(\kappa_n)$ との照合（理論から完全に独立） | **371**（$n\ge n_0$） | **0** |
| H | $\Lambda_1$ が $\bar{\tilde E}$ で決まらないこと（§9.1 の反例） | H1 3 塔 / H2 摂動 4 件 | **0** |

**FAIL 0 件。打ち切りは 2 件**で、どちらも $\ell=5$ の重い計算である
（Step B2: 名前つき 6 塔のうち 5 塔を $M=4$ で未実施。Step G: 母集団 107 塔のうち
"BQ2 $(1,-1),(1,-1)$" 以降を未実施）。$\ell=2,3$ には打ち切りが無い。
なお Step G では、$n<n_0$（漸近が始まる前。定理 G4 の射程外）でのずれが **48 件**あった。
これは反例ではなく、$M^{*}$（したがって $n_0$）が十分条件であって鋭くないことの現れである（§9.2）。

**3 本のスクリプトの実測所要は 615.6 秒 / 907.1 秒 / 1.0 秒**で、いずれも設計上限 20 分の内側である。

**$K$ の分布（Step C）**は次のとおりで、飽和は例外事象ではない。

| $\ell$ | $j^{*}$ の分布（点数） | $K$ の分布（点数） |
|---|---|---|
| 2 | $j^{*}=1$: 82、$j^{*}=2$: 41 | $K=1$: 82、**$K=2$: 41** |
| 3 | $j^{*}=1$: 69、$j^{*}=2$: 16 | $K=0$: 69、**$K=1$: 16** |
| 5 | $j^{*}=1$: 6、$j^{*}=2$: 6 | $K=0$: 12 |
| 7 | $j^{*}=1$: 6 | $K=0$: 6 |

$K$ は $j^{*}$ と $\ell$ から定理 G3 の式どおりに決まっている（$\ell=2$ は $j^{*}=1\Rightarrow K=1$、
$j^{*}=2\Rightarrow K=2$；$\ell=3$ は $j^{*}=1\Rightarrow K=0$、$j^{*}=2=\ell-1\Rightarrow K=1$）。
飽和（$K\ge1$ の点をもつ）塔は 365 中 **94**。

**$c$ が非整数の有理数になる例が実在する**: $\ell=3$、bouquet $(1,0),(1,-1),(1,2)$ で $c=13/3$。
これは Monsky 1989 が「$d=2$ なら $\alpha^{*}$ は有理数」としか言えていないことと整合する（§10.2）。

### 7.3 数値だけで支えている観察と、その検出力

**本 report で「証明した」と書いた主張（定理 G1・G2・G3・G4、系 G5・G6）は、
すべて有限個の例に依らない証明を本文に持つ。** 数値はその照合である。

数値だけで支えているのは次の 1 件である。

- **$K(P_0)$ の上界が鋭いこと**（$k\le K$ の層が実際に飽和していること）。定理 G3 は
  「$k>K$ なら非飽和」しか主張しない（注 4.2）。走査した母集団では $k=K$ の層は常に飽和していたが、
  これは**観察**であり、定理の成立には不要である（$K$ を上界として使えば式は正しい）。

---

## 8. 自分が犯した誤り（隠さず記録する）

### 8.1 「$\hat\theta_M\le\theta$ は常に成り立つ」と思い込んでいた

cycle 19 注 4.2 は「常に $\hat\theta_M\le\theta$ である」と書いており、私は初稿でこれを無条件の事実として
飽和層の解析を組み立てた。**これは誤りである。** 注 4.2 の根拠は定理 B′ の最小値が $m=\theta$ の項 $\theta$
以下だということだが、$\hat\theta_M$ が最小値に等しいのは**最小点が一意のとき**だけである。
同点のときは $v_\ell(\text{和})>\min$ になりうる。

実際、$\ell=2$ トーラスの深さ $1$ の層（$M=5$）では $\theta=18$ に対し $\hat\theta_5=32$ で、
**$\hat\theta_M>\theta$ が起きている**。誤りに気づいたのは、層ごとの実測値を出力して
$\theta$ と突き合わせたときである（一次情報＝実測を見たことで検出できた）。

**この誤りは結論を弱めるのではなく、逆に飽和層の正体（$\varphi(\ell^M)$ の整数倍という形）を教えた**
のであって、それが定理 G2 につながった。ただし「文献（自分の過去 report）の注を無検証で
前提に使った」こと自体は記録しておく。

### 8.2 飽和が起きる深さを「$r=M-1$ だけ」と決めつけかけた

最初に観察した 3 例（$\ell=2$ トーラス、$\ell=2$ の 2 頂点 3 重辺、$\ell=3$ の 4 ループ bouquet）は
いずれも $K=1$ で、飽和層が最外層 1 本だけだった。そこから「飽和は最外層 1 本」と一般化しかけたが、
定理 G3 の不等式 $j^{*}\ell\ge(\ell-1)\ell^{k}$ は $j^{*}\ge(\ell-1)\ell$ なら $K\ge2$ を許す。
**3 例からの一般化を、不等式を書いて確かめる前に採用しかけた。**
実際、母集団には $K=2$ の点が存在する（$\ell=2$ で $j^{*}=2$ の点が 41 個。§7.2）。
**思い込みのまま実装していたら、その 41 個で予言が壊れていた。**

### 8.3 $A_{\mathrm{gen}}$ の安定判定を 2 段の一致で打ち切っていた

実装 `closed_form` は $L$ を上げて $A_{\mathrm{gen}}$ が 2 段連続で一致したら止める。
これは「$\theta|_U$ が経由するレベル」の**十分条件ではない**（偶然一致しうる）。
理論上は $\ell^{L}\ge\theta^{\max}_U$ を満たす $L$ を取れば足りるので、
実装では $\theta^{\max}_U$ を実測して $L$ の妥当性を事後確認するよう直した。

---

## 9. 取れなかったこと（障害の確定）

### 9.1 $(\Lambda_k,\theta^\sharp_k)$ を $\bar{\tilde E}$ だけから読む式

定理 G2 は $(\Lambda_k,\theta^\sharp_k)$ を**有限計算で与える**が、$\bar{\tilde E}\in\mathbb{F}_\ell[z,w]$ の
組合せ的なデータ（台・二項式因子の重複度など）から読む式は**与えていない**。
$b=\sum j^{*}$ が $\bar{\tilde E}$ の二項式因子の重複度で書けた（定理 W4）のと対照的である。

**これは技術的な未整備ではなく、原理的に不可能である。** 2 通りの反例を挙げる（検証 Step H）。

> **反例 1（$\bar{\tilde E}$ を固定したまま $\Lambda_1$ が動く）.**
> $\ell=2$ トーラスの $\tilde E=4zw-z^2w-zw^2-z-w$ に $2zw$ を足すと、
> $\bar{\tilde E}$ は**変わらない**（したがって $S_\infty$、$j^{*}$、二項式因子の重複度、$e_j$ もすべて不変）が、
> $\Lambda_1$ は $2$ から $1$ に**変わる**。$2z^2w$、$2zw^2$、$2z^2w-2zw$ を足しても同様である。
> **したがって $\Lambda_1$ は $\bar{\tilde E}$ の関数ではない**（写像として well-defined ですらない）。

> **反例 2（既存の不変量では足りない）.**
> $\ell=2$ トーラス（$\Lambda_1=2$）と 2 頂点平行 3 重辺 $(0,0),(1,0),(0,1)$（$\Lambda_1=3$）は、
> $j^{*}=1$、$\lambda=1$、$\theta^{*}=2$、$e_{j^*}=2$ が**すべて一致する**のに $\Lambda_1$ が違う。
> したがって $c,d,e$ を「$j^{*},\lambda,\theta^{*},e_{j^*}$ の式」で書くこともできない。

$\Lambda_1$ は $\mathcal{O}_1=\mathbb{Z}[\zeta_\ell]$ 上の付値で、
**$\tilde E$ の係数の $\ell$ 進 2 桁目以降**に依存する（cycle 20 定理 Y′ の $w=v_2(c_e/2+c_o)$ が
まさにその形である）。$\bmod\ \ell$ に落とした情報だけでは決まらない。

したがって**「$c,d,e$ を $\bar{\tilde E}$ の不変量で書く」という形の目標は達成できない**。
達成できたのは「$D$ の係数からの有限計算で書く」という形である。
$a=\mu$ と $b=\sum j^{*}$ が $\bmod\ \ell$ の情報で決まったのは、
**$\ell^{2n}$ と $n\ell^{n}$ の係数だけが $\bmod\ \ell$ の情報で決まる**という現象であって、
$\ell^{n}$ 以下の係数へは延長されない。これが本 step で確定した障害である。

### 9.2 $n_0$（漸近が始まる段）の鋭さ

$M^*$（§5.3）は十分条件であって鋭さを主張しない。実測では多くの塔で $M^*$ より小さい $M$ から
$(2.1)$ が成り立つ（§7）。鋭い $M^*$ は与えていない。

### 9.3 $d\ge3$

$(1.1)$ そのものが $d=2$ の式（cycle 14 $(6.1)$）なので、本 report も $d=2$ に限る。
定理 G2 の捻りの考え方は $d\ge3$ でも意味を持つが、$\mathbb{P}^{d-1}$ 上の層別が
$\mathbb{P}^1$ ほど単純でないため、そのままでは移らない。

### 9.4 $\mu$（$\ell^{2n}$ の係数）の上からの評価

$a\le\mu$ は依然として定理 CM（Cuoco–Monsky）からの借り物である（cycle 14 注 7.1）。
本 report はここに触れていない。**したがって $(1.1)$ の「多項式形になること」自体は
借り物のままである**（本 report が自前で示したのは、多項式形になるならその係数が何かではなく、
$\Theta_M$ が $(2.1)$ の形になること、すなわち多項式形そのものと 5 係数の値である）。

> より正確に言うと、定理 G1 ＋ 定理 G4 は $n\ge M^*-1$ で $(1.1)$ を**自前で証明している**
> （$\Sigma_n=\sum_{M\le n}\Theta_M$ は無仮定の補題 J1 であり、$(2.1)$ は定理 G4 で証明した）。
> 定理 CM に依存するのは「$a\le\mu$」という一般論のほうであって、
> 本 report の枠内（(H) を満たす $d=2$ の voltage グラフ）では $a=\mu$ は $(6.1)$ から直接出る。

---

## 10. 既知性・新規性

**新規性は主張しない。** そのうえで、文献に対する位置づけを一次情報に基づいて書く。

### 10.1 $a$ と $b$ は既知である

- $a=\mu=m_0(F)$ と $b=\sum j^{*}=l_0(F)$ は **Cuoco–Monsky, *Class Numbers in $Z_p^d$-Extensions*,
  Math. Ann. 255 (1981), 235–258 の Definition 1.1・1.2 と Theorem 1.7** である。
  原文は cycle 16（`cycle16_T1_monsky_primary_sources.md` §3.2）が取得・書き写しており、
  同サイクル step 1（`cycle21_T3_drop_assumption_B_star.md` §11）が対応表を作って同定している。
  **本 report の系 G5 に新規性は無い。**

### 10.2 $c$（$\ell^n$ の係数）は文献では明示されていない

cycle 18（`cycle18_T1_monsky1989_acquisition.md`）は Monsky, *Fine estimates for the growth of
$e_n$ in $\mathbb{Z}_p^d$-extensions*（1989）の本文を取得して読み、次を確認している（同 §2.1–2.3）。

> Our goal in this paper is to refine the above Theorem I by proving that
> $e_n=(m_0p^n+\ell_0 n+\alpha^{*})p^{(d-1)n}+O(np^{(d-2)n})$ for some real $\alpha^{*}$.
> **There is no easy description of $\alpha^{*}$ and in particular we do not know if it is always rational.**
> （Introduction, p.309。$d=2$ のときに $\alpha^{*}$ が有理数であることは Theorem 3.12/3.13 で示される。）

$\alpha^{*}$ は本 report の $c$ に対応する位置の定数である。したがって:

- **$c$ の明示式は Monsky 1989 には無い**（存在と、$d=2$ での有理性だけ）。
- $d=2$ では Monsky の誤差項は $O(n\,p^{0})=O(n)$ なので、**$d$（$n$ の係数）と $e$ は
  そもそも Monsky の主張の外側にある**。
- 定理 G4 は、**voltage グラフの $\det L$ 型・$d=2$・仮定 (H) という限定された設定**で
  $c,d,e$ を $D$ の係数からの有限計算で与える。実際 §7 の照合では
  $c=13/3$ のような非整数の有理数が出ており、Monsky の「$d=2$ なら有理数」と整合する。

**それでも新規性は主張しない。** 理由:
(i) 文献調査は網羅的でない（Cuoco–Monsky の Theorem 1.7 の証明、Monsky 1989 の §3 の詳細、
その後の $\mathbb{Z}_p^2$-拡大の文献はいずれも読んでいない）、
(ii) 定理 G2 の内容（$\mathbb{Z}_\ell^2$ 拡大を $\ell^k$ 乗根の指標で捻って分解し、
各成分の $\mu,\lambda$ を取る）は**岩澤理論では完全に標準的な操作**であり、
Monsky が「no easy description」と言っているのは一般の $\Lambda_d$-加群についてであって、
$\det L$ 型のような具体的な $F$ に対しては同じ計算が既にどこかでなされている可能性が高い、
(iii) **本 step で新たに本文を確認した文献は無い**（上の引用はいずれも cycle 16・18 の取得済み一次情報である）。

### 10.3 $\ell^n$ 以下の係数が $\bmod\ \ell$ で決まらないこと（§9.1）

これも岩澤理論では標準的な認識である（$\mu,\lambda$ の下の項が「より深い」情報を要する）。
本 report が与えたのは、その「より深い情報」が
**$\mathbb{Z}[\zeta_{\ell^k}]$ 上の段データ $(\Lambda_k,\theta^\sharp_k)$（$k\le K$、$K$ は明示）で尽きる**
という有限性である。

---

## 11. 敵対的レビュー（自分の結論を反証しにいった記録）

1. **「$(\Lambda_k,\theta^\sharp_k)$ は $M$ に依存するのでは？」**
   → しない。定義 G2a は $M$ を含まない（$\mathcal{O}_k[x]$ の元の段データ）。
   $M$ が入るのは $(3.2)$ という「$M$ が十分大きい」という条件だけである。
   検証 Step E は、$M$ を変えて $(3.3)$ が同じ $(\Lambda_k,\theta^\sharp_k)$ で成り立つことを確認する。
2. **「深さ $k$ の層の $\varphi(\ell^k)$ 点で値が本当に同じか？」**
   → 定理 G2 の 1 で証明した（Galois 共役）。検証 Step E は層内の全点を実測して確認する。
3. **「$\mathbb{Z}[\zeta_{\ell^k}]$ を使うのは非可算側への脱出では？」**
   → ちがう。$\mathbb{Q}(\zeta_{\ell^k})$ は $\mathbb{Q}$ の**有限次代数拡大**で可算であり、
   計算は $\mathbb{Z}[x]/\Phi_{\ell^k}(x)$ の整数演算とノルム（整数）だけで閉じる。
   $\mathbb{R}$ にも $\mathbb{C}$ にも一度も出ていない。$(2.2)$ の係数は $\mathbb{Q}$ の元である。
4. **「$A_{\mathrm{gen}}$ の計算は $\theta$ が $U$ 上有界であることに依存するが、それは有効か？」**
   → 有効である。cycle 20 系 L3′ の議論（候補集合の各点での $\theta$ の実測 ＋ 系 L3 の距離評価）を
   $U$ に制限して使う。$S_\infty$ の点を除いた候補点での $\theta$ は有限計算で出る（定理 W3）。
5. **「$b=\sum j^{*}$ が (B\*) なしに出るなら、cycle 21 step 1 の課題は消えるのか？」**
   → 消えない。step 1 の課題は「定理 J7 の仮定 (B\*) を落とす」ことで、
   本 report は**定理 J7 を経由せずに同じ結論に達する別経路**を与えた。
   定理 B′ の最小点が一意になる条件そのものを特徴づけたわけではない。
6. **「(1.1) の形を仮定していないか？」**
   → していない。定理 G1 は $(2.1)\Rightarrow(1.1)$ であり、$(2.1)$ は定理 G4 で証明した。
   cycle 14 定理 3（$a\ge\mu$）が「多項式形で書けるならば」という条件付きだったのとは違う。
7. **「$K$ の定義に等号を含めたのは安全側か？」**
   → 安全側である。$j^{*}\ell=(\ell-1)\ell^{k}$ の境界では飽和するかどうかが
   $e_{j^*}$ と $m_1$ の比較で決まるが、$K$ を大きめに取っても式は正しい（注 4.2）ので
   境界は飽和側に倒してある。

---

## 12. 検証コード

`sagemath/check/cycle21_T3_general_closed_form/`
（`overview.md` に対象ラベル、`README.md` に手順と限界、`RESULTS.md` に実行結果、
`_defs21.sage` / `general_closed_form.sage` / `tower_values.sage` と `*.out`）。

- **Step A**: 既知の閉形式との突き合わせ（A1 定理 J8、A2 定理 X′ の族、A3 $\ell=2$ トーラスの数列）。
- **Step B**: 母集団の全走査。$D$ の係数だけからの予言（自由度 0）と実測 $\Theta_M$ を $M\ge M^*$ で照合。
- **Step C**: $|S_\infty|$・$j^{*}$・$K$ の分布と、定理 G3 の明示下界の確認。
- **Step D**: 飽和を無視した naive 版が $K\ge1$ の塔で実際に外れること（反例の実在）。
- **Step E**: 捻り段データの層ごとの実測照合（敵対的レビュー 1・2）。
- **Step F**: $b=\sum j^{*}$ が飽和の有無に依らないこと（系 G5）。
- **Step G**（`tower_values.sage`）: Matrix–Tree 定理で計算した塔の値 $\mathrm{ord}_\ell(\kappa_n)$ と
  閉形式 $(a,b,c,d,e)$ の照合（理論から完全に独立な突き合わせ）。
- **Step H**（`mod_ell_obstruction.sage`）: §9.1 の 2 つの反例
  （$\bar{\tilde E}$ を固定した摂動で $\Lambda_1$ が動くこと／既存の不変量が一致しても $\Lambda_1$ が違うこと）。

**3 本ともスクリプト単体の壁時計上限を 20 分以内に設計した**（cycle 19・20 で 3 回起きた
「掃引起動直後にセッションが終了」への対策）。実測は §7.2 の表に出す。
